'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b3b9257e9187e71878345b789e9001ee",
"assets/AssetManifest.bin.json": "ce414057baeb7a2a049b2e2c2737fcb9",
"assets/AssetManifest.json": "88e6a85a2ea18ac124624522654181b3",
"assets/assets/font/airbeat-eaw0j.ttf": "ef1a65b5499af1bc43f8d02e1644348e",
"assets/assets/font/Helvetica.ttf": "1b580d980532792578c54897ca387e2c",
"assets/assets/images/androidstudio.png": "112e8aa41375107bb88d81ec758d27b1",
"assets/assets/images/bitbucket.png": "545d6acac0e5a2643484c0c594bf984e",
"assets/assets/images/Canva-logo.png": "9bbbdf0f4b72366c547a6a552a723532",
"assets/assets/images/Clogo.png": "623f8181c81323e831a831bd69b76d95",
"assets/assets/images/cloudinary.png": "8344d465e7a0e46fd6685b6942c91977",
"assets/assets/images/dart.png": "75566a02b5bef2aa0a7425a79cb8655c",
"assets/assets/images/education_logo.png": "20c6dc59a4fcbe72588367a3aa6aab67",
"assets/assets/images/experience.png": "22af4a8ce8a558c83c821cf993fa8f4c",
"assets/assets/images/figma.png": "4e0c7a99b060282bc974f90f79cf0654",
"assets/assets/images/firebase.png": "1d4d34609b1a2a0f05862bb29d6877c5",
"assets/assets/images/flutter.png": "e02a6c427d3f2f6128219c4916cc4c6f",
"assets/assets/images/flutterflow.jpeg": "01db2631bb67c83cc99900c210675b98",
"assets/assets/images/Girithar%2520logo%2520dark.png": "286ca3a7b45ad753fe656d3b1dba0676",
"assets/assets/images/Girithar%2520logo.png": "e7d94c4c74cd463af51da0d7c138ee5c",
"assets/assets/images/git.png": "f83b8fb033736399800863e1ed2c1b21",
"assets/assets/images/github.png": "a294bed2f971c2b5118a723577a67c40",
"assets/assets/images/golang.png": "de2f371731bba5199f0636b90e0dfb13",
"assets/assets/images/jira.png": "aafea4778dbf05652d6fde00b421eba9",
"assets/assets/images/kotlin.png": "30f175dd17069894cb900a98e607e9c2",
"assets/assets/images/Legendary.png": "4e248f8327c8a4f0619cccd803291753",
"assets/assets/images/Legendarylogo.png": "2ec91d6fbdc6a79f39483e170de1c5b8",
"assets/assets/images/lotties/github.json": "24dec41d23206e051d06df24466854ea",
"assets/assets/images/lotties/linkedin.json": "d8e2d6e0ac516e8b8a12b4348715e35a",
"assets/assets/images/lotties/whatsapp.json": "fa3016aedecae1d55c6ecf0c74ccb493",
"assets/assets/images/Nearle%2520Deals.png": "70c1546f224ea6b1261c9067966b1faa",
"assets/assets/images/Nearle%2520Xpress.png": "eed147f72b595c88d098cb3bd0ec3309",
"assets/assets/images/Nearledealslogo.png": "728e6fefe85a369302acfd334feee189",
"assets/assets/images/Nearlexpresslogo.png": "13229c24968a824fe7213dae2efd32fe",
"assets/assets/images/postman.png": "e295a5931e4984f88917942cce6690cd",
"assets/assets/images/profile.jpg": "59bf076c607a0fb266ce291e147a9f4b",
"assets/assets/images/profile1.jpg": "1a42225192baaea236d2eb81c3244359",
"assets/assets/images/slack.png": "e4f78d4baab5fd848b6dc8c3e158d558",
"assets/assets/images/sourceTree.png": "bfc1e1d8f4c2f16eeede2749abbc3acd",
"assets/assets/images/sql.png": "29b524d0b6f487be03dea49ee2506120",
"assets/assets/images/tick.png": "58b61aab7081c0c9ee8986232ecf62b7",
"assets/assets/images/whatsapp.png": "fd60fdbb014c44037d8d96528c4bef0e",
"assets/FontManifest.json": "db1b11bd7741f2b6e7716db1cf4e2b72",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/NOTICES": "19daa360e1c0cc5cfe8bf82796416512",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "286ca3a7b45ad753fe656d3b1dba0676",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "04f9da17e0e9be0d820e1cdde8c07df4",
"icons/Icon-192.png": "a712d8fba46108dc51912bb91233cad1",
"icons/Icon-512.png": "696ad1825508b34e6a79d631b7704842",
"icons/Icon-maskable-192.png": "a712d8fba46108dc51912bb91233cad1",
"icons/Icon-maskable-512.png": "696ad1825508b34e6a79d631b7704842",
"index.html": "55f0c9d2b2a1aa0db21cbd968deb1843",
"/": "55f0c9d2b2a1aa0db21cbd968deb1843",
"main.dart.js": "2b8d9b2b0e1ebda83f238c27ffb965d1",
"manifest.json": "e74af8957b5899dc6da961caee768ec9",
"version.json": "009c9e65172e010890f7f65fde438006"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
