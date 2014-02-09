module Unifi
  class Base
    attr_accessor :attr_hidden, :attr_hidden_id, :attr_no_delete, :attr_no_edit, :key, :_id

    alias id _id
  end
end
