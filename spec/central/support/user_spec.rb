require 'rails_helper'

describe User, type: :model do

  describe "validations" do

    it "requires a name" do
      subject.name = ''
      subject.valid?
      expect(subject.errors[:name].size).to eq(1)
    end

    it "requires initials" do
      subject.initials = ''
      subject.valid?
      expect(subject.errors[:initials].size).to eq(1)
    end

  end

  describe "#remove_story_association" do
    let(:user) { create :user}
    let(:project) { build :project }
    let(:story) { build :story, project: project }

    before do
      project.users << user
      project.save
      story.owned_by = user
      story.requested_by = user
      story.save
    end

    it 'removes the story owner and requester when the user is destroyed' do
      expect{ user.destroy }.to change{Membership.count}.by(-1)
      story.reload
      expect(story.owned_by).to be_nil
      expect(story.requested_by).to be_nil
    end
  end

end

