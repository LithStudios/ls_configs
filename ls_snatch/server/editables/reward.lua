function GiveReward(player, reward_table)
    for item, amount in pairs(reward_table) do
        exports['kq_link']:AddPlayerItem(player, item, amount)
    end
end
