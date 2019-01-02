class EventMailer < ApplicationMailer

  require 'open-uri'

  def new_events
    artistList = get_artists()
    stateList = ['New York']

    url = 'https://edmtrain.com/api/events?&client='+ENV['EDM_API_KEY']
    events = JSON.parse(open(url).read)

    artistListDowncase = artistList.map { |x| x.downcase }
    stateListDowncase = stateList.map { |x| x.downcase }
    lastWeek = (Time.now - (7*24*60*60)).strftime('%Y-%m-%d')
    @events = []
    events['data'].each do |event|
      #Check if event is in desired state and recent
      if (stateListDowncase.include?(event['venue']['state'].downcase) && event['createdDate'] > lastWeek)
        #Check if artists are part of event
        event['artistList'].each do |artist|
          if artistListDowncase.include?(artist['name'].downcase)
            @events << event          
            break
          end
        end
      end
    end

    mail to: ENV['EMAIL'], subject: 'New Events'
  end

  private

  #List of artists interested in
  def get_artists
    return ['22Bullets',
            '3LAU',
            '3PM',
            'Above & Beyond',
            'Aevion',
            'Adam Lambert',
            'Adaptiv',
            'Afrojack',
            'Aguelardo',
            'Aitor Blond',
            'Alan Walker',
            'Alessia Cara',
            'Alesso',
            'Alex Kunnari',
            'Alicia Madison',
            'Alina Aslanian',
            'Alina Renae',
            'Aloe Blacc',
            'Aloma Steele',
            'Alpharock',
            'Amada',
            'Ameria',
            'Andrew Belize',
            'Andrew Rayel',
            'ANGEMI',
            'Anki',
            'Andero',
            'Angel Taylor',
            'Angelika Vee',
            'Anna Yvette',
            'Anoop Desai',
            'APEK',
            'Archie',
            'Ares Carter',
            'Arild Aas',
            'Armin van Buuren',
            'Arty',
            'Ashton Palmer',
            'Aspyer',
            'Astra',
            'Astroblast',
            'Astronaut',
            'ATB',
            'A-Trak',
            'Audien',
            'Audiobot',
            'AVE & EFX',
            'Axollo',
            'Axwanging',
            'Axwell',
            'Aysan',
            'Bali Bandits',
            'Bart B More',
            'Basshunter',
            'Bassjackers',
            'Bastille',
            'Bauer & Lanford',
            'Beeetz',
            'Benny Benassi',
            'Bingo Players',
            'Bishop',
            'BISHØP',
            'Blackcode',
            'Blair',
            'Blanee',
            'Blasterjaxx',
            'BloueBart',
            'Bodhi Jones',
            'Boehm',
            'Borgeous',
            'Borgore',
            'Bougenvilla',
            'Braken',
            'Brandon Mignacca',
            'Breathe Carolina',
            'Bright Lights',
            'Brooks',
            'Broz Rodriguez',
            'BRKLYN',
            'BUNT',
            'Burak Yeter',
            'Buzzmeisters',
            'CAJOR',
            'Calvin Harris',
            'Calvo',
            'Cammora',
            'Carta',
            'Cascada',
            'Cash Cash',
            'Cat Carpenters',
            'Cazzette',
            'Cedric Gervais',
            'Chachi',
            'Cheat Codes',
            'Chocolate Puma',
            'Christofi',
            'Christopher S',
            'CHRNS',
            'CHRSTN',
            'CID',
            'Cignature',
            'Clean Bandit',
            'Codeko',
            'Collin McLoughlin',
            'Corey James',
            'Cormak',
            'Corti Organ',
            'Cosmow',
            'Crankdat',
            'Crossnaders',
            'CRUNKZ',
            'Cuebrick',
            'Culprit',
            'Curbi',
            'Da Brozz',
            'Dada Life',
            'DallasK',
            'Daniel Garrick',
            'DANK',
            'Dankann',
            'Danko',
            'Dannic',
            'Danny Avila',
            'Dante Klein',
            'Danyka Nadeau',
            'Darius & Finlay',
            'Dark Point',
            'Darren',
            'Dash Berlin',
            'Dastic',
            'Dave Nazza',
            'David Bulla',
            'David Guetta',
            'David Pietras',
            'Savid Spekter',
            'Daya',
            'Daydreamer',
            'Deepend',
            'Delaney Jane',
            'Deniz Koyu',
            'Didrick',
            'Different Heaven',
            'DiJiTAL',
            'Dillon Francis',
            'DIMATIK',
            'Diplo',
            'Dirty South',
            'Dimitri Vangelis & Wyman',
            'Dimitri Vegas & Like Mike',
            'Disco Fries',
            'Disco Killerz',
            'DIVARO',
            'DJ Antoine',
            'DJ Snake',
            'DJ Vice',
            'DOLF',
            'Don Diablo',
            'Drako',
            'Driftbomb',
            'Dropgun',
            'Dr Shiver',
            'DSTAR',
            'Dua Lipa',
            'DubVision',
            'Dux n Bass',
            'Dylan Dunlap',
            'Dzasko',
            'Dzeko',
            'East & Young',
            'EDX',
            'Electric Joy Ride',
            'Elephante',
            'Ellie Goulding',
            'Ember Island',
            'Emily Coulston',
            'Enhanced',
            'Eric Prydz',
            'Exit Friendzone',
            'Faruk Sabanci',
            'Faul & Wad',
            'Fedde Le Grand',
            'Federico Seven',
            'Feenixpawl',
            'Felix Cartal',
            'Felix Jaehn',
            'Fever',
            'Firebeatz',
            'Fisnik',
            'Flipboitamidles',
            'Florian Picasso',
            'F.O.O.L',
            'Frank Pole',
            'Friendzone',
            'Fluze',
            'FTampa',
            'Futuristic Polar Bears',
            'Galantis',
            'Gareth Emery',
            'Gazzo',
            'Ghastly',
            'Ghostdragon',
            'Gianluca Vacchi',
            'Gidro',
            "Gigo'n'Migo",
            'Girls Love DJs',
            'GLDN',
            'Goshfather',
            'Greencoast',
            'Greg Cerrone',
            'Gregor Salto',
            'Gryffin',
            'GuiigS',
            'Guru Josh',
            'Halogen',
            'Halsey',
            'Hardwell',
            'Headhunterz',
            'Heikki L',
            'Helena Legend',
            'Hellberg',
            'Henrell',
            'Herflex',
            'HIDDN',
            'HIFI',
            'HOANG',
            'HOLDON',
            'Hook N Sling',
            'Honka',
            'Hotlife',
            'HtPkt',
            'Hyper Potions',
            'HYPRESSION',
            'Illenium',
            'Ingrosso',
            'INNA',
            'Itro',
            'Ivan Gough',
            'IZECOLD',
            'J3RO',
            'Jac & Harri',
            'Jack Holiday',
            'Jack Howes',
            'Jack Miz',
            'Jack Taylor',
            'Jake Liedo',
            'Jake Wolfe',
            'Jakko',
            'Jakob Liedholm',
            'Jai Wolf',
            'Janieck',
            'Jason Ross',
            'Jason Walker',
            'Jayceeoh',
            'Jayce Garen',
            'Jay Hardway',
            'Jay Cosmic',
            'Jaz Von D',
            'Jeff Sontag',
            'Jenaux',
            'Jenn Blosil',
            'Jermaine Fleur',
            'Jewelz & Sparks',
            'Jim Yosef',
            'Jimmy Clash',
            'J.Lauryn',
            'Joe Gil',
            'Joe Killington',
            'Joe Stone',
            'Joel Fletcher & Reece Low',
            'Joey Dale',
            'John Christian',
            'John Dahlbäck',
            'John Dahlback',
            'John Martin',
            'Jonathan Mendelsohn',
            'Joni Fatora',
            'Jonny Rose',
            'Jordan Jay',
            'Josie Dunne',
            'Joye Mill',
            'Jmi Sissoko',
            'Julian Jordan',
            'Junior J',
            'Justice Skolnik',
            'Justin Caruso',
            'Justin Prime',
            'Juventa',
            'K?D',
            'Kaaze',
            'Kalkutta',
            'Kap Slap',
            'Karboncopy',
            'Karma Fields',
            'Karra',
            'Kaskade',
            'Kastra',
            'Kasum',
            'Kat Krazy',
            'Kat Nestel',
            'KATT',
            'KDrew',
            'Ken Loi',
            'Kerry Wheeler',
            'Kevin Charm',
            'Kevin Drew',
            'Kevin Wild',
            'Khaskada',
            'Khlorinn',
            'Kid Arkade',
            'Kill The Buzz',
            'klei',
            'Klingande',
            'KLYMVX',
            'Kokaholla',
            'Kopa',
            'Kosling',
            'Kovan',
            'Krewella',
            'Kris Maydak',
            'Krishane',
            'Krripton',
            'KSHMR',
            'KURA',
            'Kygo',
            'Kyle Tree',
            'LA Riots',
            'Laidback Luke',
            'Lana Del Rey',
            'LarsM',
            'Lash',
            'Last Night',
            'Lenno',
            'Leon Lour',
            'Lights',
            'Lindsey Stirling',
            'Lil Jon',
            'LIONE',
            'LNY TNZ',
            'Loreno Mayer',
            'Lost Frequencies',
            'Lost Kings',
            'Lucas & Steve',
            'Lucas Nord',
            'Luis Rodriguez',
            'Lush & Simon',
            'Lux',
            'LVNDSCAPE',
            'LVTHER',
            'Madison Mars',
            'Maestro Harrell',
            'Mahama',
            'MAKJ',
            'Mako',
            'Mammals',
            'Manse',
            'Marc Benjamin',
            'Marc Brothers',
            'Marcus Santoro',
            'Mark Borino',
            'Marnik',
            'Marshmello',
            'Martell & William Ekh',
            'Martin Garrix',
            'Martin Miller',
            'Martyn',
            'Massive Vibes',
            'Matisse & Sadko',
            'Matluck',
            'Mats Mattara',
            'Matthew Koma',
            'Matoma',
            'Maurice West',
            'Max Adrian',
            'Max Elto',
            'Max Landry',
            'Maxim Schunk',
            'Meikle & Div Eadie',
            'MERCER',
            'Meron Ryan',
            'Mesto',
            'MGMT',
            'Miavono',
            'Micah Martin',
            'Michael Brun',
            'Micky Blue',
            'Midnight Kids',
            'Mike Candys',
            'Mike Williams',
            'MIKEY C',
            'Miles Away',
            'Milkman',
            'Milk N Cookies',
            'Misterwives',
            'MKC',
            'Moiez',
            'Morgan Page',
            'MOTi',
            'Muzzaik',
            'Moyan',
            'Muffin',
            'Myon',
            'Myon & Shayne 54',
            'N3ON',
            'Nathan Skyes',
            'Nause',
            'Neilsan',
            'Nero',
            'Nervo',
            'Nevve',
            'Nicky Romero',
            'Nikki Williams',
            'Nikko',
            'Nima Nesta',
            'Nino Lucarelli',
            'No Class',
            'Nurko',
            'Olaf Tupik',
            'Oli Hanson',
            'Olly James',
            'OLWIK',
            'Onderkoffer',
            'OneRepublic',
            'Otto Knows',
            'Patrick Moreno',
            'Paris & Simo',
            'Paris Blohm',
            'Patrick Moreno',
            'Paul Aiden',
            'Paul Meany',
            'Pegboard Nerds',
            'Pep & Rash',
            'Peter Kiemann',
            'Peter Nemeth',
            'Pharien',
            'Phillip Matta',
            'Pierce Fulton',
            'Porter Robinson',
            'Preon',
            'Prince Fox',
            'Prismo',
            'Proezas',
            'Progressive Brothers',
            'Project 46',
            'PRYVT RYN',
            'Punk Party',
            'Puppet',
            'Purple Haze',
            'Quarterback',
            'Quentyn',
            'Quintino',
            'Qulinez',
            'Radiology',
            'Ragasur',
            'Raiden',
            'Rain Man',
            'Raven & Kreyn',
            'RavenKis',
            'Ravitez',
            'Razihel',
            'R3hab',
            'REDFOO',
            'RedMoon',
            'Reeka',
            'Reunify',
            'Reverie',
            'Rhylex',
            'Rick Wonder',
            'Ricky Mears',
            'Rico & Miella',
            'Rigby',
            'Riggi & Piros',
            'RIVERO',
            'RL Grime',
            'RMCM',
            'Robbie Mendez',
            'Robert Falcon',
            'Robert J.C',
            'Robin Schulz',
            'Roman Aloy',
            'Ron Carroll',
            'Rosendale',
            'Roy Orion',
            'ROZES',
            'Rudeejay',
            'Ryan Riback',
            'Ryos',
            'S9',
            'Sagan',
            'Sage',
            'Said The Sky',
            'Sam Feldt',
            'Sam Knight',
            'Sam Smith',
            'Samlight',
            'Sander van Doorn',
            'Sandro Silva',
            'Sarah Charness',
            'Sebastian Back',
            'Sebastian Ingrosso',
            'Sebjak',
            'Seeb',
            'Selena Gomez',
            'Seven Lions',
            'Shaan',
            'Shapov',
            'Shanee',
            'Shermanology',
            'Shift K3Y',
            'Showtek',
            'Sick Individuals',
            'Sigrid',
            'SIIK',
            'Simone Nijssen',
            'SirensCeol',
            'Sixth Sense',
            'Skrillex',
            'Smallpools',
            'SNYC',
            'SØLRS',
            'SOLRS',
            'SƠN',
            'SON',
            'Sophie Francis',
            'Southlights',
            'SOVTH',
            'Special Features',
            'Spektrem',
            'Spencer Tarring',
            'Spirix',
            'Stadiumx',
            'Stargate',
            'Stargliders',
            'Starlyte',
            'Steerner',
            'Steve Angello',
            'Steve Aoki',
            'Steve Forte Rio',
            'Steve James',
            'Still Young',
            'Stonebank',
            'Streex',
            'Strike Nine',
            'Sunstars',
            'Suyano',
            'Swede Dreams',
            'Swedish House Mafia',
            'SweetState',
            'Syn Cole',
            'Synchronice',
            'Syndec',
            'Taku-Hero',
            'Taylor Jones',
            'Taylr Renee',
            'Teemu',
            'The Chainsmokers',
            'The Him',
            'The Jane Doze',
            'The Knocks',
            'The White Panda',
            'Third Party',
            'Thomas Feelman',
            'Thomas Gold',
            'Thomas Hayes',
            'Throttle',
            'Tiesto',
            'Tiësto',
            'Tim Atlas',
            'Tim Gordon',
            'Timmy Trumpet',
            'Tobu',
            'Tommy Jayden',
            'Tom Bourra',
            'Tom Hangs',
            'Tom & Jame',
            'Tom Swoon',
            'Tom Walker',
            'Tomo Hirata',
            'Tony Junior',
            'Tony Romera',
            'Topher Jones',
            'Tori Franco',
            'Torres',
            'Totally Normal',
            'T-Pain',
            'Trademark',
            'Trevor Guthrie',
            'Trilane',
            'Triple M',
            'Tristam',
            'Tritonal',
            'Trouze',
            'Troye Sivan',
            'Tungevaag & Raaban',
            'Two Friends',
            'Twoloud Sofia To Tokyo',
            'Tylah Rose',
            'UBERJAKD',
            'Ummet Ozcan',
            'Uppermost',
            'Urban Cone',
            'Vance Joy',
            'Vanto',
            'VARGENTA',
            'Varun',
            'Vassy',
            'Vee Brondi',
            'Venice & Michele C',
            'VICE',
            'Vicetone',
            'Victor Niglio',
            'Vigiland',
            'VINAI',
            'VIRTU',
            'Virtual Self',
            'VITIZE',
            'Vlad Lucan',
            'Walk of the Earth',
            'Warren',
            'Wasback',
            'WasteLand',
            'WHOLM',
            'Wiep',
            'WildVibes',
            'Wolfgang Gartner',
            'Wolf Tide',
            'Xan Griffin',
            'Xuitcasecity',
            'Yaro',
            'Yeah Yeah Yeahs',
            'Years',
            'Yellow Claw',
            'YesYou',
            'Youngblood Hawke',
            'Yves V',
            'Zack Martino',
            'Zaeden',
            'Zatox',
            'Zedd',
            'ZHU',
            'Zombie Nation',
            'Zonderling',
            'Zookeeper']
  end

end
