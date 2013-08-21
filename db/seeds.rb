User.create({first_name: "Josh", last_name: "Miramant", architect_score: rand(100), location: 94108})
100.times do
	User.create({first_name: "Dummy", last_name: "Account", architect_score: rand(100), location: 94108})
	User.create({first_name: "Dummy", last_name: "Account", architect_score: rand(100), company_id: rand(30), location: 94108})
end
30.times do
	Company.create({name: "Good.Co", size: rand(100), industry: "startup", architect_score: rand(100)})
end