const needs = document.querySelector('.needs')
const streetcon = document.querySelector('.street-container')
const streetout = document.querySelector('#street-output')
const velout = document.querySelector('#vel-output')
const fuelicon = document.querySelector('#fuel-icon')
const seatbelticon = document.querySelector('#seatbelt-icon')
const cidout = document.querySelector('#cid-output')
const idout = document.querySelector('#id-output')
const nameout = document.querySelector('#name-output')
const hpicon = document.querySelector('#hp-icon')
const foodicon = document.querySelector('#food-icon')
const watericon = document.querySelector('#water-icon')
const micicon = document.querySelector('#mic-icon')
const armor = document.querySelector('#armor')
const armoricon = document.querySelector('#armor-icon')
const oxygen = document.querySelector('#oxygen')
const oxygenicon = document.querySelector('#oxygen-icon')
const minimap = document.querySelector('#minimap')


window.addEventListener('message', (event) => {

    const data = event.data;

    if (data.type === 'turn') {
        if ((data.data1 == 'on' && data.data2 == 'mapaon') 
        || (data.data1 == 'off' && data.data2 == 'mapaoff') 
        || (data.data1 == 'off' && data.data2 == 'mapaon')) {
            document.body.classList.add('hidden'); 
        } else {
            document.body.classList.remove('hidden');
        }
    }
    
    if (data.type === 'inveh') {
        if (data.bool == 'true') {
            minimap.style.display = '';
            needs.style = 'right: 30px;';
            streetcon.style = 'bottom: 30px;';
            streetout.textContent = data.streetname;
            velout.textContent =  `${Math.floor(data.vel)} MPH`;
            fuelicon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.fuel)}%, -10% ${Math.floor(data.fuel) + 2}%)`;
            if (data.seatbelt) {
                seatbelticon.style = `display: block;`
            } else {
                seatbelticon.style = `display: none;`
            }
        } else {
            minimap.style.display = 'none';
            needs.style = 'right: 50%; transform: translateX(50%)';
            streetcon.style = 'bottom: -100px;';
        }
    }

    if (data.type === 'ids') {
        cidout.textContent = data.cid;
        idout.textContent = data.id;
        nameout.textContent = data.name;
    }

    if (data.type === 'needs') {
        hpicon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.hp)}%, -10% ${Math.floor(data.hp) + 2}%)`;
        foodicon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.food)}%, -10% ${Math.floor(data.food) + 2}%)`;
        watericon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.water)}%, -10% ${Math.floor(data.water) + 2}%)`;

        const clipPathValue = data.micrange === 6.0 ? "polygon(0 110%, 100% 110%, 110% -10%, -10% -10%)" 
        : data.micrange === 3.0 ? "polygon(0 110%, 100% 110%, 110% 50%, -10% 50%)" 
        : "polygon(0 110%, 100% 110%, 110% 75%, -10% 75%)";
    
        const strokeValue = data.mic === 1 ? "url(#grad3); transform: scale(1.15)" : "url(#grad1)";
        
        micicon.style = `clip-path: ${clipPathValue}; stroke: ${strokeValue}`;

        if (data.armor > 0 && data.oxygen == 0) {
            armor.style.display = "";
            oxygen.style.display = "none";
            needs.classList.add('more');
            needs.classList.remove('more2');
            armoricon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.food)}%, -10% ${Math.floor(data.food) + 2}%)`;
        } else if (data.armor > 0 && data.oxygen > 0) {
            armor.style.display = "";
            oxygen.style.display = "";
            needs.classList.add('more2');
            needs.classList.remove('more');
            armoricon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.food)}%, -10% ${Math.floor(data.food) + 2}%)`;
            oxygenicon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.oxygen)}%, -10% ${Math.floor(data.oxygen) + 2}%)`;
        } else if (data.armor == 0 && data.oxygen > 0) {
            armor.style.display = "none";
            oxygen.style.display = "";
            needs.classList.remove('more2');
            needs.classList.add('more');
            oxygenicon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.oxygen)}%, -10% ${Math.floor(data.oxygen) + 2}%)`;
        } else {
            armor.style.display = "none";
            oxygen.style.display = "none";
            needs.classList.remove('more2');
            needs.classList.remove('more');
        }
    }
}); 

// armor.style.display = "none";
// needs.classList.remove('more');
// armoricon.style = `clip-path: polygon(0 110%, 100% 110%, 110% ${Math.floor(data.food)}%, -10% ${Math.floor(data.food) + 2}%)`;