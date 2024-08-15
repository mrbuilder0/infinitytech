local tokens = {
	["roblox"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6Im1hcmNzeW5jQWNjZXNzIn0.eyJkYXRhYmFzZUlkIjoiMGJjMGNjMWEtNTJhMS00OGYyLWFhMGMtN2IyY2U2OGRhYjI3IiwidXNlcklkIjoiOWRlZmU4YzItMTEzMC00MmRkLTk5YjEtODFlYjk1M2Y5YjkxIiwidG9rZW5JZCI6IjY2YmRmMmE4YWQyOTFjNDlmZjk5Y2U5YyIsIm5iZiI6MTcyMzcyNDQ1NiwiZXhwIjo4ODEyMzYzODA1NiwiaWF0IjoxNzIzNzI0NDU2LCJpc3MiOiJtYXJjc3luYyJ9.6jE2Jw_7cohZqLYC7u3m23-azxJOzkGEig8tO0KWxZ8"
}


-- DO NOT EDIT THE FOLLOWING LINES BELOW, UNLESS YOU KNOW WHAT YOU ARE DOING!
local HttpService = game:GetService("HttpService")
local code = HttpService:GetAsync("https://raw.githubusercontent.com/mrbuilder0/infinitytech/main/utils.lua", true)
local Utils = loadstring(code)
Utils()
local MarcSyncClient = {}

local code = HttpService:GetAsync("https://raw.githubusercontent.com/mrbuilder0/infinitytech/main/types.lua", true)
local Types = loadstring(code)

MarcSyncClient.getVersion = function(self:typeof(MarcSyncClient), clientId: number?):string
	self:_checkInstallation()
	local url = ""
	if clientId then url = "/"..clientId end
	local result = Utils.makeHTTPRequest("", "GET", "https://api.marcsync.dev/v0/utils/version"..url, nil, nil, self._options);
	return result["version"]
end

MarcSyncClient.createCollection = function(self:typeof(MarcSyncClient), collectionName: string):typeof(require(script.Parent.Objects.Collection).new())
	if not self._accessToken then error("[MarcSync] Please set a Token before using MarcSync.") end
	if not collectionName then error("No CollectionName Provided") end
	local result = Utils.makeHTTPRequest("collection", "POST", "https://api.marcsync.dev/v0/collection/"..collectionName, {}, self._accessToken, self._options);

	if not result["success"] then error(result["errorMessage"]) end
	result = require(script.Parent.Objects.Collection).new(collectionName, self._accessToken, self._options)

	return result
end
MarcSyncClient.fetchCollection = function(self:typeof(MarcSyncClient), collectionName: string):typeof(require(script.Parent.Objects.Collection).new())
	self:_checkInstallation()
	if not collectionName then error("No CollectionName Provided") end
	local result = Utils.makeHTTPRequest("collection", "GET", "https://api.marcsync.dev/v0/collection/"..collectionName, {}, self._accessToken, self._options);
	
	if not result["success"] then error(result["errorMessage"]) end
	result = require(script.Parent.Objects.Collection).new(collectionName, self._accessToken, self._options)

	return result
end
MarcSyncClient.getCollection = function(self:typeof(MarcSyncClient), collectionName: string):typeof(require(script.Parent.Objects.Collection).new())
	if typeof(self) ~= "table" then error("Please use : instead of .") end
	self:_checkInstallation()
	if not collectionName then error("No CollectionName Provided") end
	return require(script.Parent.Objects.Collection).new(collectionName, self._accessToken, self._options)
end

return {
	new = function(accessToken: string, options: Types.ClientOptions?):typeof(MarcSyncClient)
		if not accessToken then warn("Token not provided while creating a new MarcSync Object.") end
		if not tokens[accessToken] then warn("Token provided for creating a new MarcSync Object not Found in Token Table, using it as token instead.") else accessToken = tokens[accessToken] end
		local self = {}
		self._accessToken = accessToken
		self._options = options or {retryCount = 3}
		self._checkInstallation = function()
			if not self then error("Please Setup MarcSync before using MarcSync.") end
			if not self._accessToken then error("[MarcSync] Please set a Token before using MarcSync.") end
			if not game:GetService("HttpService").HttpEnabled then error("Please Enable HTTPService in order to use MarcSync.") end
		end

		self = setmetatable(self, {
			__index = MarcSyncClient
		})

		return self
	end
}
