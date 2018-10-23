# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskTracker.Users.User
alias TaskTracker.Tasks.Task
TaskTracker.Repo.insert!(%User{email: "admin@jonathanzybert.com", admin: true})
TaskTracker.Repo.insert!(%Task{title: "Task 1", desc: "Description"})