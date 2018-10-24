defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.AssignedTasks
  alias TaskTracker.AssignedUsers
  alias TaskTracker.Users
  alias TaskTracker.TimeBlocks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, is_task_assigned_to_user: true)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    time_blocks = TimeBlocks.list_time_blocks_for_task_id(task.id)
    user_id = get_session(conn, :user_id)
    user_email = Users.get_user(user_id).email
    users_list = AssignedUsers.list_assigned_users_for_user_by_email(user_email)
    users_list = Enum.map users_list, fn(user) -> user.user.email end
    manager_list = AssignedUsers.list_assigned_users_for_user(user_id)
    users_list =  if length(manager_list) == 0, do: users_list ++ [user_email], else: users_list
    can_assigned_to_anyone = (length(users_list) > 0)
    task_cset = AssignedTasks.change_assigned_task(%AssignedTasks.AssignedTask{
      user_id: user_id, task_id: task.id
    })
    task = Map.put(task, :time_worked, String.slice(Time.to_string(task.time_worked), 0, 5))
    render(conn, "show.html", task: task, task_cset: task_cset,
      users: users_list, is_task_assigned_to_user: true, can_assigned_to_anyone: can_assigned_to_anyone, time_blocks: time_blocks)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    time_blocks = TimeBlocks.list_time_blocks_for_task_id(task.id)
    user_id = get_session(conn, :user_id)
    assigned_task_ids = Enum.map AssignedTasks.list_assigned_tasks_for_user(user_id), fn(t) -> t.task.id end
    is_task_assigned_to_user = task.id in assigned_task_ids
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, is_task_assigned_to_user: is_task_assigned_to_user,
      time_blocks: time_blocks)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    time_blocks = TimeBlocks.list_time_blocks_for_task_id(task.id)
    time_diff = Enum.map(time_blocks, fn time -> DateTime.diff(time.end_time, time.start_time) end)
    time_in_not_sec = Enum.map(time_diff, fn time -> div(time, 60) end)
    hours = Enum.map(time_in_not_sec, fn time -> div(time, 60) end)
    minutes = Enum.map(time_in_not_sec, fn time -> rem(time, 60) end)
    total_hour = Enum.map_reduce(hours, 0, fn hour, acc -> {hour, acc + hour} end)
    total_minutes = Enum.map_reduce(minutes, 0, fn minute, acc -> {minute, acc + minute} end)
    hour = elem(total_hour, 1)
    minute = elem(total_minutes, 1)
    actual_hour = hour + div(minute, 60)
    actual_minute = rem(minute, 60)
    task_params_with_time = task_params
    |> Map.put("time_worked", %{"hour" => Integer.to_string(actual_hour), "minute" => Integer.to_string(actual_minute)})
    case Tasks.update_task(task, task_params_with_time) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
