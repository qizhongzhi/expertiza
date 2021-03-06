require 'rails_helper'
describe ReviewResponseMap do
	before(:each) do	
		@participant=create(:participant)
		@assignmentquestionnaire= create(:assignment_questionnaire)
		@reviewresponsemap=create(:review_response_map)
	end

  describe "#new" do
    it "Validate response instance creation with valid parameters" do
     # reviewresponsemap = build(:review_response_map)
      expect(@reviewresponsemap.class).to be(ReviewResponseMap)
    end
    it "Validate response instance creation with valid parameters" do
      response=create(:response_take)
			expect(response.class).to be(Response)
    end
    it "Validate response instance creation with valid parameters" do
			expect(@participant.class).to be(Participant)
    end
  end

  describe "id" do
    #test all the id are stored correctly
  let(:reviewresponsemap) {ReviewResponseMap.new id: 66, reviewee_id: 1, reviewer_id: 22, reviewed_object_id: 8}
  let(:response) {Response.new id: 4, map_id: 4}
  let(:participant) {Participant.new id: 1}
    it "should not be any other reviewresponsemap's id" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.id).not_to eq(7)
    end
    it "should be our exact reviewer's id" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.reviewer_id).to eq(2)
    end
    it "should not be any other reviewer's id" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.reviewer_id).not_to eq(3)
    end
    it "should be our exact reviewee's id" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.reviewee_id).to eq(1)
    end
    it "should not be any other reviewee's id" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.reviewee_id).not_to eq(2)
    end
    it "should be the response map_id" do
      expect(response.map_id).to eq(4)
    end
  end
  describe "title" do
  #test the title to be stored correctly
    it "should be Review" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.get_title).to eq('Review')
    end
    it "should not be teamReview" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.get_title).not_to eq('Team Review')
    end
    it "should be feedbackReview" do
      reviewresponsemap = build(:review_response_map)
      expect(reviewresponsemap.get_title).not_to eq('Feedback Review')
    end
  end
  describe "#export_field" do
    it "Length of fields" do
			export_fields=ReviewResponseMap.export_fields nil
			expect(export_fields.length).to be(2)	    
    end
    it "Name of the fields" do
      reviewresponsemap = build(:review_response_map)
			expect(ReviewResponseMap.export_fields(6)).to eq(["contributor", "reviewed by"])
    end
  end
  describe "#add_reviewer" do
    it "should add reviewer" do
      #expect(ReviewResponseMap.add_reviewer(11,12,13)).to raise("The reviewer, \"" + "12" + "\", is already assigned to this contributor.")
    end
  end
  describe "#import" do
    it "raise error when not enough items" do
      row = []
      expect {ReviewResponseMap.import(row,nil,nil)}.to raise_error("Not enough items.")
    end
    it "raise error when assignment is nil" do
      assignment = build(:assignment)
      allow(Assignment).to receive(:find).and_return(nil)
      row = ["user_name","reviewer_name", "reviewee_name"]
      expect {ReviewResponseMap.import(row,nil,2)}.to raise_error("The assignment with id \"2\" was not found. <a href='/assignment/new'>Create</a> this assignment?")
    end
    it "raise error when user is nil" do
      assignment = build(:assignment)
      allow(Assignment).to receive(:find).and_return(assignment)
      allow(User).to receive(:find).and_return(nil)
      row = ["reviewer_name", "user_name", "reviewee_name"]
      expect {ReviewResponseMap.import(row,nil,2)}.to raise_error("The user account for the reviewer \"user_name\" was not found. <a href='/users/new'>Create</a> this user?")
    end

    it "raise error when reviewer is nil" do
      assignment = build(:assignment)
      allow(Assignment).to receive(:find).and_return(assignment)
      allow(AssignmentParticipant).to receive(:find).and_return(nil)
      row = ["user_name","reviewer_name", "reviewee_name"]
      expect {ReviewResponseMap.import(row,nil,2)}.to raise_error("The user account for the reviewer \"reviewer_name\" was not found. <a href='/users/new'>Create</a> this user?")
    end
    it "raise error when author not found" do
      assignment = build(:assignment)
      allow(Assignment).to receive(:find).and_return(assignment)
      allow(AssignmentTeam).to receive(:find).and_return(nil)
      row = ["user_name", "reviewee_name", "reviewer_name"]
      #expect {ReviewResponseMap.import(row,nil,2)}.to raise_error("The author \"reviewee_name\" was not found. <a href='/users/new'>Create</a> this user?")
    end
  end
end
