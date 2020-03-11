let eventClassIDs = ""
let eventClassDetailsIDs = ""

function checker(value) {
  // criteria for including item in cleanup
  if(value.includes('unregistered')) {return true}
  if(value.includes('?')) {return true}
  return false
}

dataPoints.forEach(e => {
  if (checker(e.name)) { //insteadd of using name as a critera, any other item can be used (like created on, last seen, etc.)
    if(e.eventClassId){eventClassIDs = e.eventClassId+", "+eventClassIDs}
    if(e.eventClassDetailsId){eventClassDetailsIDs = e.eventClassDetailsId+", "+eventClassDetailsIDs}
  }
})

console.log('EC:', eventClassIDs)
console.log('ECD:', eventClassDetailsIDs)

document.addEventListener('DOMContentLoaded', ()=>{
    let eventClass = document.getElementById('EC')
    let tr1 = document.createElement('tr')
    tr1.innerHTML = eventClassIDs
    eventClass.appendChild(tr1)
    let eventClassDetails = document.getElementById('ECD')
    let tr2 = document.createElement('tr')
    tr2.innerHTML = eventClassDetailsIDs
    eventClassDetails.appendChild(tr2)
})
