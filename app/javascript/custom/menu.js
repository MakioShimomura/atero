  // document.addEventListener('DOMContentLoaded', function() {
  //   var elems = document.querySelectorAll('.dropdown-trigger');
  //   var instances = M.Dropdown.init(elems, 'alignment');
  // });
  
  // let radios = document.getElementsByName('question[choice]')
  // let len = radios.length;
  // console.log(radios)
  // console.log(len)


document.addEventListener("turbo:load", function() {
  let radio_btns = document.getElementsByName('question[choice]')
  for (let target of radio_btns) {
  	target.addEventListener(`change`, () => {
  	  document.myform.submit()
  	});
  }
})
  

