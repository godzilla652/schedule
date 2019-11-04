# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Day.create(name: 'Понедельник')
Day.create(name: 'Вторник')
Day.create(name: 'Среда')
Day.create(name: 'Четверг')
Day.create(name: 'Пятница')


Clock.create(name: '8:30-9:50')
Clock.create(name: '10:10-11:30')
Clock.create(name: '11:50-13:10')
Clock.create(name: '13:30-14:50')
Clock.create(name: '15:05-16:25')
Clock.create(name: '16:40-18:00')
Clock.create(name: '18:10-19:30')
Clock.create(name: '19:40-21:00')


User.create(name: 'admin', password: 'admin')
