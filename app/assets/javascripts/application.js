$(document).ready(function() {

  if ($( '#q_votes' ).text() > 0 ) {
    $( '#q_votes' ).css("color","green"); 

  }else if ($( '#q_votes' ).text() == 0 ) {
    $( '#q_votes' ).css("color",'black'); 

  }else{
    $( '#q_votes' ).css("color","red"); 
  }

  // JQuery for Positive Question Votes
  $( '#question_plus' ).on('click', function(e){
  
  e.preventDefault();
  questionVotePos();

  });

  // JQuery for Negative Question Votes
  $( '#question_minus' ).on('click', function(e){
  
  e.preventDefault();
  questionVoteNeg();

  });

  // JQuery for Positive Answer Votes
  $( '.answer_plus' ).on('click', function(e){
  
  var vote_id = $(this).children().val();
  answerVotePos(vote_id);
  var i = parseInt($(this).next().html());
  $(this).next().empty();
  i++;
  $(this).next().append(i + '  <i class="fa fa-arrow-up" style="color:green"></i>' );
  $(this).hide();
  $(this).next().next().hide(); 




  });

  // JQuery for Negative Answer Votes
  $( '.answer_minus' ).on('click', function(e){
  
  var vote_id = $(this).children().val();
  answerVoteNeg(vote_id)
  var j = parseInt($(this).prev().html());
  $(this).prev().empty();
  j--;
  $(this).prev().append(j + '  <i class="fa fa-arrow-down" style="color:red"></i>');
  $(this).hide();
  $(this).prev().prev().hide(); 


  });

//-----------------------------------------------------------------//
// Answer and Question votes AJAX functions
//-----------------------------------------------------------------//

// Question Positive Vote
function questionVotePos() {  

  var vote_id = $( '#q_vote_id' ).serialize() + '&' + 'type=plus'
  $.get('/vote', vote_id, function(data){
    q_counter = data;
    $('#q_votes').html('<strong>'+q_counter + '</strong>  <i class="fa fa-arrow-up" style="color:green"></i>');
  });

}

// Question Negative Vote
function questionVoteNeg() {
  
  var vote_id = $( '#q_vote_id' ).serialize() + '&' + 'type=minus'
  $.get('/vote', vote_id, function(data){
    q_counter = data;
    $('#q_votes').html('<strong>'+q_counter + '</strong>  <i  class="fa fa-arrow-down" style="color:red"></i>');
  });

}


// Answer Positive Vote
function answerVotePos(vote_id){

 
  var ser = 'vote_id=' + vote_id + '&' + 'type=plus'

  $.get('/vote/answer', ser, function(data){
    q_counter = data;

  });

}

// Answer Negative Vote
function answerVoteNeg(vote_id) {

  var ser = 'vote_id=' + vote_id + '&' + 'type=minus'

  $.get('/vote/answer', ser, function(data){
    q_counter = data;
  });

}

//-----------------------------------------------------------------//

});