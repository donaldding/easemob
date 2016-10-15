module Easemob
  module Groups
    def create_group(groupname, description, owner, members: nil, is_public: true, maxusers: 200, is_approval: false)
      jd = { groupname: groupname, desc: description, public: is_public, owner: owner, users: maxusers, approval: is_approval }
      jd[:members] = members unless members.nil?
      request :post, 'chatgroups', json: jd
    end

    def get_groups(group_ids)
      request :get, "chatgroups/#{[*group_ids].join(',')}"
    end

    def query_groups(limit = 50, cursor: nil)
      params = { limit: limit }
      params[:cursor] = cursor unless cursor.nil?
      request :get, 'chatgroups', params: params
    end

    def query_group_users(group_id)
      request :get, "chatgroups/#{group_id}/users"
    end

    def delete_group(group_id)
      request :delete, "chatgroups/#{group_id}"
    end

    def modify_group(group_id, groupname: nil, description: nil, maxusers: nil)
      jd = {}
      jd[:groupname] = groupname unless groupname.nil?
      jd[:description] = description unless description.nil?
      jd[:maxusers] = maxusers unless maxusers.nil?
      request :put, "chatgroups/#{group_id}", json: jd
    end

    def user_join_group(group_id, username:)
      request :post, "chatgroups/#{group_id}/users/#{username}"
    end

    def user_leave_group(group_id, username:)
      request :delete, "chatgroups/#{group_id}/users/#{username}"
    end

    def group_add_users(group_id, usernames:)
      request :post, "chatgroups/#{group_id}/users", json: { usernames: [*usernames] }
    end

    def group_remove_users(group_id, usernames:)
      request :delete, "chatgroups/#{group_id}/users/#{[*usernames].join(',')}"
    end

    def user_joined_chatgroups(username)
      request :get, "users/#{username}/joined_chatgroups"
    end

    def group_set_owner(group_id, newowner:)
      request :put, "chatgroups/#{group_id}", json: { newowner: newowner }
    end

    def add_to_group_block(group_id, to_block_usernames:)
      request :post, "chatgroups/#{group_id}/blocks/users", json: { usernames: [*to_block_usernames] }
    end

    def remove_from_group_block(group_id, blocked_usernames:)
      request :delete, "chatgroups/#{group_id}/blocks/users/#{[*blocked_usernames].join(',')}"
    end

    def query_group_blocks(group_id)
      request :get, "chatgroups/#{group_id}/blocks/users"
    end
  end
end
