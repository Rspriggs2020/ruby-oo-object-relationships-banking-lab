class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
  def execute_transaction
    if valid? && self.sender.balance >= self.amount
      while status == "pending"
        self.sender.balance -= amount
        self.receiver.balance += amount
        self.status = "complete"
        true
      end
    else
      reject_transfer
    end
  end 

  def reverse_transfer
    if @status == "complete"
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    end
  end
end
