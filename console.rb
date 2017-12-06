require('pry-byebug')
require_relative('./models/bounty.rb')

bounty1 = Bounty.new({
    'name' => 'Amy',
    'value' => '2',
    'favourite_weapon' => 'Nunchucks',
    'danger_level' => 'ermagerdyerderd'
  })

bounty2 = Bounty.new({
    'name' => 'Mark',
    'value' => '1000',
    'favourite_weapon' => 'Rail gun',
    'danger_level' => 'high'
  })

  bounty1.save()
  bounty2.save()

  # Bounty.delete_all()
  # bounty1.save()
  # bounty2.save()
  #
  # bounties = Bounty.all()
  Bounty.delete_by_id(2)
  p Bounty.find(4)
  binding.pry
  nil
