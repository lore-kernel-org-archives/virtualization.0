Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9956AD53
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715657634; cv=fail; b=i0DR6EuswV4TAvAwdXT6r0kRusleiPm6EaKNTMJ2vDGxsSFJLwkI/9naYTKcuiTfTCSUeGOnSu0juvCDPlnmdFXDtV7No6WtAXmg100bZscv8VqmR5H36EMkJytL118B9pVpaAkrxt8NHn/vUrJ92mr0UVc8a7PnUruIqm+mX/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715657634; c=relaxed/simple;
	bh=nG0kkyp8Rk9ajUY0/8en5szbrwEcvtMv89y/bVjHMwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMznKa7M3hBcEcehcw6weUhSVSfTTGjTU4JUY2Afko9/pMk1BEWYEgy4TavYMsk0M1dYtfvOd7WvF8YtKT5Tu+BS0skvx11kxzE0efL1ZpsvCWTCFmpZ1LpoOwiQAcCLANhWi6r0vZkvBoekS6JGPN28V8XSA/+m0zqpxDBHJP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bbczmVbq; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bbczmVbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REv1Q73mtD3f1V8dLHDTTY4g81u+qXpisdOKtWh8eDAGg23zqmbyYZ/cq9Nsj6RMIDXM8Z+dQoKtca/SyZ7+RiWONkuixvAW99R60w2KwqGOzVprZ9vwnWWKdHMpytUKlCtSyicvc7Io+eCfRc1tK3PnR4bwLWlWbrccJ3tJclSk6z9nk0/gPd9I0KS4l9QOx0cdB3EzQvelQu6cefMUVjPVUTxSeMQCGCWa6DSA52gunxONT6ojQdzcNYiUjq6UlcXSl0Fm3iW/8xsqm2F9L1AdkHEw0Vh9fwqZYDmpJExbfXgjMhfWVZa1RcPJDQvJJZnkyRvFqxDZ9dgPRuIa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG0kkyp8Rk9ajUY0/8en5szbrwEcvtMv89y/bVjHMwM=;
 b=AYRVOh+6kSQXt90C/8XJCnkJ6q9+0N4ykPgfjxp235byS9w5A/2wSE5wG5qUdORsxI1CW3U6AT6NmJpQ+NNIV0s7S/sMnE6EeOKFE40ZmjUZ6OEK0c1S8TEWyAZ7j7BHBzzu4wZQkEdCTyXVlLaY8bkAqdmf1CezotVo/7xrVTON/7zUBHTOckYuOR7VcdvubdvWhBkCQe72YTfNhnhrWKZoJ48GsHs/2Lpu7alCoHxpLNqAc9Y0RdCBXtoWYHetXnV8weV15TtKWnb1s/ghyCKBkDpfbNB5fA0D0NX4DUhlEBy/ZUEEjDCSPNpn5B9jD1DWzwVTYjeRFwJ7zTv4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG0kkyp8Rk9ajUY0/8en5szbrwEcvtMv89y/bVjHMwM=;
 b=bbczmVbqpBLToYT0yEe3nr0V+FR/thO8mqbMNuMW9lSVZ/woAEeJ2hByYSTDq8hL65yDZBVX2WQ/PN1lDD9DIfxrxzEQQAm7nlYDjt0+qcHx7NpMShd+eWpJDu7S2VSOu4Mj4sIXTfW8akI6YotTz6ulSmwDl+TIjF96m/f3nNnydkYOWANkYcm9InuMah4QSwoGHinWgOCdsCqlv7uiMF4iC5k3n5hCUR321mOWzFBxDIsyOF5gBOxg9gFUy8lmmWRS4ZSKDvE1Smjdpj+dEjS3DD817sN0WjUrMzo906ReBRb5jgNRsG7mi8pwM/HvaJiYHLy8ljekNmnreM65LA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 03:33:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 03:33:48 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Thread-Topic: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Thread-Index: AQHapTkyKWSHdlbG402zkv/WdkAkBbGVKZ6QgADHvwCAACLGgA==
Date: Tue, 14 May 2024 03:33:48 +0000
Message-ID:
 <PH0PR12MB54817C2EF9EBCF604878B214DCE32@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
 <PH0PR12MB54814D7C2081F336ADCEC341DCE22@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a5b4f0b0-caba-463b-ae60-f9a0bbb806f3@intel.com>
In-Reply-To: <a5b4f0b0-caba-463b-ae60-f9a0bbb806f3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8525:EE_
x-ms-office365-filtering-correlation-id: b6046f1e-46a7-49fa-f875-08dc73c6aadc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dm5qWXF1SDhXOXVoWG8zNi9xL1pxaUdrM0c3bnZpZEcxL05yQW1VMDJGYXFt?=
 =?utf-8?B?YUsvV0dGTXB4U0toNFVJODlvT1UrdlFzMElKYVYyQjB6dlFaTkJPNms0QVlW?=
 =?utf-8?B?QjRTR0VoWTVRUjdYUXV1WVI2N05kZFpGaFFZNGp0cGk2SW04K3hoaENVTFZO?=
 =?utf-8?B?OWdJRjhPZG90b1VYV1pKaUZVR2UwZ3F6Q3FaSU9YM2gra25sOVEwTTBmVjRJ?=
 =?utf-8?B?M1BGQmdGYnRKSFFQV2VhSjBJblY2MXVPWU9wOEpYNkdxRHhxOVYzcjFSWlk5?=
 =?utf-8?B?eVZGbllGaGtQNnBER3YraGlqL1RSQkVYKy9HSmUzNm45d2RKUitvZkR2aEhQ?=
 =?utf-8?B?a1VERWlkb1JJcXU0OWcwZGZNdHNOU0Z3VHY3WDl1YklER3Ywb0M5WHNNa01O?=
 =?utf-8?B?SkF5K1hwMWovcHQzdGM1SmJQeHZwTVZ2bjFvUENGcnVhU0lENDdmSWZ0T0tm?=
 =?utf-8?B?ODgxdk1vQjEyZ3BNMUlkODZBTzlMekh2VnJlOTg0M0FSazBSSUk4TGpncXFi?=
 =?utf-8?B?VENnUFhRbk5ZNmVMcCtnZlBtWTZNR21LUmlyelJ2REhWc21YckNlbi93Y3Nw?=
 =?utf-8?B?S1BxWXNyUVdNNDNBb3ZtSDFqcEdwTDRaQzZjTnZ5WnRBQmtvUlI3RFNDaHhG?=
 =?utf-8?B?S2xqYlJ1dzBBL3BLaEhKR3R4M0pmS2hucnFkMWNDQWNpSGtQUVZlak5TVFFJ?=
 =?utf-8?B?ZkppZDN1Tkx4d2JtRWthS1BMd1JOODBDR01PLzMyZjF6WG9OL2pad2xRZ20w?=
 =?utf-8?B?ditRMzVBY1NNUkdNczV5NFhQRmRxdTJDdGU0SzRMZHQ1ZmdFYzFLWEdmYjVy?=
 =?utf-8?B?QlRSbURJa2k5RXRYV0g3OGJxNkhpSTNFdElPMFlPM1ZEc3A0MlBLWWRnL3hM?=
 =?utf-8?B?OWdhWnVGNnI5bUY1ck1WSWhTZUpGSklVb1Zra3NVZC85V1VUQ0pZVHJWeUtl?=
 =?utf-8?B?Qkw3UC9DWTdoM0piUkNZNXcydndDTDNzL1BReVVtbDlrTStvemZnSUFiTTJI?=
 =?utf-8?B?amJoRm1zT0R3Ti9PNDRsYXVuQ1BqcmFGSlByRFFoaC9ibTJFckF6ZC9PM01K?=
 =?utf-8?B?dTlsMlRpQUlFTW8rNENvbUFrL2RSY3N6TDZXdkVFUFk1UW5TMGpjVWkzQTF6?=
 =?utf-8?B?amtadlFOQ2IyUWN4ellrZEp6L3BGNWsrN0EzcGQ5dGhuTzJ3NHoxVWVMZUdE?=
 =?utf-8?B?cTBYenEzYW9TYVRyZkY5ZVZWMGtIeHpJKzNYT0E4ZlZLR0xSUWRsS2RyMHJZ?=
 =?utf-8?B?bzlTSHZRSHB2dUc4WnhzTS9XZUlyekZXcHZKSVBuVjNvMHppdVZjRGxOUUZh?=
 =?utf-8?B?dzRpUjhCUjhsem9xM2ZJZTZaRnNYMGJPZEQvS3E5MVJ5RW5FRGMxTUExWVph?=
 =?utf-8?B?dnVTMWRJZXZzd3cwMnZla092V3BESlllZkdSK3A4V0ZVTFc2bzQvbGlORk5n?=
 =?utf-8?B?VU0vbzdUVE5zODMxS0F4SU4zQWxLZmxkOUgyekwrTHB2Nm15WGl2RENQdFRR?=
 =?utf-8?B?MFhYRXA4QUZnLzAzenhRUmZMVHRRRmtjQ1lTTU82SkJvZmFBREVsVGQ5VkN2?=
 =?utf-8?B?bjFYYSsya3pNV0E0cEdabDdZc3JkN1hQVWRkV1YxUEh5UHJsNUhoL2RvQ01j?=
 =?utf-8?B?cTZ0TXVCa0Q0Zk0zc1BFQ1E0YXlIMVZ4TWJ5MWZWdVh5U0l3ZlUrck8wb2pj?=
 =?utf-8?B?R1Eyb2xUVFZZZnhoMmFxMTJ3QzZpQkRRZEVnSWdpUlJEN1llUVlPSjZzZGZZ?=
 =?utf-8?B?NDFPL3k5YVhvZUh6RDFSU1ZXbUJXNUFiNXNvSHUvYzFSYWVSclZPU1VqVkMv?=
 =?utf-8?B?aEo1NGxBNml4RzRyTENNZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3ZzUFNsUFBEVDl6YVpQOUNtK050ZWZMdTlvaHhmSmZ1a1p5cXBSYVJQVWlS?=
 =?utf-8?B?emsvVlA5WFprbVJwdHM1ZExJYSsvditXMDNkU1BUNUt5eFhlekZRa20wQk1p?=
 =?utf-8?B?ZW0yTU1lQ0Juam1jN2lvT1pmOVE1bXErUDc1b3hVZnBrTVRyVFFnOGFwUFpl?=
 =?utf-8?B?S1pFajNRNlFrRG42VjB0bThlNFpBWkZ2dm02NU4xa3hxbXhseDMvb2xWY2tG?=
 =?utf-8?B?Q3V3UjhBaW1SZHk4RUMycmo0V1BRZUZSWit2UEMwQSt4b1ZIbnFxVEVzdHVo?=
 =?utf-8?B?NnRLY0F6NkNLSWJBdWIvM1VwUGZQbE1UQ25YWWI3Y24xV1N6czY0VVN3NGh5?=
 =?utf-8?B?aWF2Z21jVXo3UGZlZy9XZVl3THUwdnJsWDdMWUVhM0t4aU5BZ3Z2ZlJqRUVV?=
 =?utf-8?B?dFo4R2ZBeHlFWnh5Mzd1eVNaRzlHdXVyVUR0Nytpa05sbGZrWENxaG05ckl1?=
 =?utf-8?B?cTh6NXRMWFBCbmsrZldpSGV0ZzhxYllwbkgwRzcvYjFYOFFPbTBBWHUxL0or?=
 =?utf-8?B?UlVmd1pSeEdwRFhWWE5reTdKMkZHYk5CaHdTcVczWVdBM0RCbWhad05HYk9a?=
 =?utf-8?B?NUZ6TjN0Ly9UUmZIVjY5SE44cWN1K2VYS1JkNjR1dlpBMGtPM3BRSXEyakd5?=
 =?utf-8?B?cjVpUmpkblJVdXVtTCt2UlVSeENuUDJEZG1nckYrekRxWktjSmNRMkc0cUxH?=
 =?utf-8?B?WEdOeUpHWnlsMEw4czl6bUZiSWswcXVGWXdnN0NWSW51b1VoODBOaWFqSVpB?=
 =?utf-8?B?aUN5REptcUFMNEkzQWxKTjFrQ0NBK1VRYjgzcEJQajFCUUhTZm9YWEFYVC9Q?=
 =?utf-8?B?aWdSSDhDRk85VE5nN0dpUEJKRzQwdU51SmM1TElLY0lKendSVVN2b2ZiMlpz?=
 =?utf-8?B?T1BRMFhUa2xTYmREVUc4NVVhSDcxdWxxSG9ObG42ZWpubm5RaS9GQkhpWHFv?=
 =?utf-8?B?NVlRckVRZVZIUGYxOVUwTnhwQTZtV0lFa2Y3eXExYzE1cjE2VExqYmtyL20z?=
 =?utf-8?B?SktwZzNBdHNwbitPMUlOSHhlUmVGV2pKMnNXL0tJZWc1eGJ6ZG54QU5CcEtO?=
 =?utf-8?B?VWVnMFc1eVJZOWd1bjFmalpRQmdXQVA5UU00MUV3dUN6L0NnODZ6bVRuUVVT?=
 =?utf-8?B?NjkzVUZML0xlWElJell2cWZOMjNVS1R6U0F2bkhLQWZ3MVF3SHNZL2Y0ZXg3?=
 =?utf-8?B?SW9vYllEbWk4eTRVdjk0NnhKaUFzdE5tMWhEMXFpck11K2JBQWRFOEx3RVBo?=
 =?utf-8?B?c2FHRjNKUjZ1c2k5R3FUbVQ3U0Zyd0dqTm9XOFpPa3UyK2h6WXFZTzArQy9E?=
 =?utf-8?B?R29aRXc1L04zajVNNThBZDBkTG4xREZhTGpHWDNkZGM4bE9JYzVNZ0Yrc1pq?=
 =?utf-8?B?bHEzUmhjSkxkcTFGZE9MM3dlUnpyVDdHN2NKK3VENHBMOWlnT0dlM1pTVk5L?=
 =?utf-8?B?YmFhbUloZzdUdWovdE01TEg0VDVyTHhubTMxK1ZaYVRUM1J4Z2NqQ0hXcW1B?=
 =?utf-8?B?dU5wemZIYk9wSDkzWXphZXphSkM5TmdkRFcvRVBNR2RVT1VKcTZSOUhQRDhl?=
 =?utf-8?B?TGpadDhMU1dnWmNOQ2VqUWsyaFdUS3lJekNTMmNneDllTzA5cjBBcU5zMEY0?=
 =?utf-8?B?YXhRZkQ0RmdGb085bksvM05qWEUvbFJOOGQyQTFJZDlvdFhkd1pDYVJFeXYw?=
 =?utf-8?B?aTkvRUVESHNQU000eXhUNGM2bmIrck9lOTFRQVk5VFJtWGN1MXFmNTZnMVZR?=
 =?utf-8?B?aklwVjIzS0p1bERZQm5TWEdjMVI3RU5obm03OHF2MjRQZ1NkOVJKUWkxWUdP?=
 =?utf-8?B?NDZVSXJQZmw1KzlUeEJIaGVzSXphNFY1ZC9DN1QrN0pLbEM3KytOZWlLNXo2?=
 =?utf-8?B?aUNZRU1zTnNvV0JZYmFZZks3WlF0d2Q0WTVMWlhmMU1qUWZmb1ZkTHpZNVlG?=
 =?utf-8?B?bzF0Z3B3VDBRYkV1WlNQY1p1ZlFzcnBrMGQ4NEM0MWM3TmlTcEltdlVkam00?=
 =?utf-8?B?azFJeVc1WkhFblFEZ05HR09YMktYb2NtUTRsUkFBRCtLUStPd01jSlBFbG45?=
 =?utf-8?B?dVppd2twYXNaam9reUpEc1dRamdMY2FORjhYOW9qdHhmOXh2ZG9NTUhxaUZO?=
 =?utf-8?Q?0yII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6046f1e-46a7-49fa-f875-08dc73c6aadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 03:33:48.6850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFbUIkNc+9Btzwg44zA422JmFy5ZUsEsW00DBLCjH0FYMm/yqbem50ZODuTsVvK3tIOcyxMJRTYIxnBJ5vHtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgTWF5IDE0LCAyMDI0IDY6NTggQU0NCj4gDQo+IE9uIDUvMTMvMjAyNCA5OjM2
IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gSGkgTGluZ3NoYW4sDQo+ID4NCj4gPj4gRnJv
bTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVz
ZGF5LCBNYXkgMTQsIDIwMjQgMjo1NyBBTQ0KPiA+PiBUbzogamFzb3dhbmdAcmVkaGF0LmNvbTsg
bXN0QHJlZGhhdC5jb20NCj4gPj4gQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsg
Wmh1IExpbmdzaGFuDQo+ID4+IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTdWJqZWN0
OiBbUEFUQ0hdIGlmY3ZmL3ZEUEE6IGlmY3ZmIGRyaXZlcyBzdGFuZGFyZCB2aXJ0aW8gcGNpIGRl
dmljZXMNCj4gPj4NCj4gPj4gTW9zdCBvZiBpZmN2ZiBjb2RlIHdvcmsgZm9yIHN0YW5kYXJkIHZp
cnRpbyBwY2ksIGV4Y2VwdCBmb3IgYmFyNC4NCj4gPj4gVGhpcyBjb21taXQgbWFrZXMgYmFyNCBv
bmx5IGVmZmVjdGl2ZSBmb3IgSW50ZWwgcHJvZHVjdHMsIHRoZXJlYnkNCj4gPj4gdHVybmluZyBp
ZmN2ZiBpbnRvIGEgc3RhbmRhcmQgdmlydGlvIHBjaSBkcml2ZXIuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gLS0t
DQo+ID4+ICAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICB8ICAyICstDQo+ID4+ICAg
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+
ID4+IGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAgNSArKysrLQ0KPiA+PiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9LY29uZmlnIGIvZHJpdmVycy92ZHBhL0tjb25m
aWcgaW5kZXgNCj4gPj4gNjU2YzFjYjU0MWRlLi5kYmYwOWYzNWJjZWYgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvdmRwYS9LY29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvdmRwYS9LY29uZmln
DQo+ID4+IEBAIC00NCw3ICs0NCw3IEBAIGNvbmZpZyBWRFBBX1VTRVINCj4gPj4gICAJICBpbiBh
IHVzZXJzcGFjZSBwcm9ncmFtLg0KPiA+Pg0KPiA+PiAgIGNvbmZpZyBJRkNWRg0KPiA+PiAtCXRy
aXN0YXRlICJJbnRlbCBJRkMgVkYgdkRQQSBkcml2ZXIiDQo+ID4+ICsJdHJpc3RhdGUgIkludGVs
IElGQyBWRiBhbmQgc3RhbmRhcmQgdmlydGlvLXBjaSB2RFBBIGRyaXZlciINCj4gPiBUaGUgdmly
dGlvIHNwZWNpZmljYXRpb24gbGltaXRzIHRoZSBzdWJzeXN0ZW0gdmVuZG9yIGFuZCBkZXZpY2Ug
aWQgdXNhZ2UgZm9yDQo+IGluZm9ybWF0aW9uYWwgcHVycG9zZXMgb25seS4NCj4gPiBIZW5jZSB0
aGlzIGNoYW5nZS9jbGFpbSBoZXJlIGZvciBzdGFuZGFyZCBpcyBub3QgZ29vZC4NCj4gPg0KPiA+
IEkgZG9uJ3QgaGF2ZSBvYmplY3Rpb24gdG8gaGF2ZSBwZXIgdmVuZG9yIGNyZWF0aXZpdHkgaW4g
dGhlIHNwZWMsIGJ1dCBmb3IgdGhhdA0KPiBsZXQgT0FTSVMgY29tbWl0IHRvIHJhdGlmeSB0aGUg
c3BlYyB0byB1c2Ugc3Vic3lzdGVtIHZlbmRvciBhbmQgZGV2aWNlIGlkIGZvcg0KPiBub24taW5m
b3JtYXRpb25hbCBwdXJwb3Nlcy4NCj4gPiBBbmQgYW1lbmQgdGhlIHNwZWMgIiAoZm9yIGluZm9y
bWF0aW9uYWwgcHVycG9zZXMgYnkgdGhlIGRyaXZlcikuIi4NCj4gVGhlIHNwZWMgc2F5czoNCj4g
VGhlIFBDSSBTdWJzeXN0ZW0gVmVuZG9yIElEIGFuZCB0aGUgUENJIFN1YnN5c3RlbSBEZXZpY2Ug
SUQgTUFZIHJlZmxlY3QNCj4gdGhlIFBDSSBWZW5kb3IgYW5kIERldmljZSBJRCBvZiB0aGUgZW52
aXJvbm1lbnQgKGZvciBpbmZvcm1hdGlvbmFsIHB1cnBvc2VzDQo+IGJ5IHRoZSBkcml2ZXIpLg0K
PiANCj4gSSBkb24ndCBzZWUgaG93IHRoaXMgY2hhbmdlIGNvbmZsaWN0cyB3aXRoIHRoZSBzcGVj
Lg0KSXQgZG9lcy4gSXQgaXMgdXNlZCBiZXlvbmQgdGhlIF9pbmZvcm1hdGlvbmFsXyBwdXJwb3Nl
cyBhcyBkZXNjcmliZWQgaW4gdGhlIHByZXZpb3VzIGVtYWlsLg0KTGV0IHZwX3ZkcGEgZHJpdmVy
IGhhbmRsZSB0aGUgc3RhbmRhcmQgZGV2aWNlIGFzIE1pY2hhZWwgcG9pbnRlZCBvdXQuDQoNCj4g
Pg0KPiA+PiAgIAlkZXBlbmRzIG9uIFBDSV9NU0kNCj4gPj4gICAJaGVscA0KPiA+PiAgIAkgIFRo
aXMga2VybmVsIG1vZHVsZSBjYW4gZHJpdmUgSW50ZWwgSUZDIFZGIE5JQyB0byBvZmZsb2FkIGRp
ZmYNCj4gPj4gLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jDQo+ID4+IGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyBpbmRleA0KPiA+PiA0NzJkYWE1ODhhOWQu
LjQ3YmM5YjExYzY3OCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuYw0KPiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jDQo+ID4+
IEBAIC0xNzgsNyArMTc4LDggQEAgaW50IGlmY3ZmX2luaXRfaHcoc3RydWN0IGlmY3ZmX2h3ICpo
dywgc3RydWN0DQo+ID4+IHBjaV9kZXYNCj4gPj4gKnBkZXYpDQo+ID4+ICAgCQlody0+dnJpbmdb
aV0uaXJxID0gLUVJTlZBTDsNCj4gPj4gICAJfQ0KPiA+Pg0KPiA+PiAtCWh3LT5sbV9jZmcgPSBo
dy0+YmFzZVtJRkNWRl9MTV9CQVJdOw0KPiA+PiArCWlmIChody0+cGRldi0+c3Vic3lzdGVtX3Zl
bmRvciA9PSBQQ0lfVkVORE9SX0lEX0lOVEVMKQ0KPiA+PiArCQlody0+bG1fY2ZnID0gaHctPmJh
c2VbSUZDVkZfTE1fQkFSXTsNCj4gPj4NCj4gPj4gICAJSUZDVkZfREJHKHBkZXYsDQo+ID4+ICAg
CQkgICJQQ0kgY2FwYWJpbGl0eSBtYXBwaW5nOiBjb21tb24gY2ZnOiAlcCwgbm90aWZ5IGJhc2U6
DQo+ID4+ICVwXG4sIGlzciBjZmc6ICVwLCBkZXZpY2UgY2ZnOiAlcCwgbXVsdGlwbGllcjogJXVc
biIsIEBAIC0zMzAsMTgNCj4gPj4gKzMzMSwyNCBAQA0KPiA+PiB1MTYgaWZjdmZfZ2V0X3ZxX3N0
YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQpDQo+ID4+ICAgCXN0cnVjdCBpZmN2Zl9s
bV9jZmcgIF9faW9tZW0gKmxtX2NmZyA9IGh3LT5sbV9jZmc7DQo+ID4+ICAgCXUxNiBsYXN0X2F2
YWlsX2lkeDsNCj4gPj4NCj4gPj4gLQlsYXN0X2F2YWlsX2lkeCA9IHZwX2lvcmVhZDE2KCZsbV9j
ZmctPnZxX3N0YXRlX3JlZ2lvbiArIHFpZCAqIDIpOw0KPiA+PiArCWlmIChsbV9jZmcpIHsNCj4g
Pj4gKwkJbGFzdF9hdmFpbF9pZHggPSB2cF9pb3JlYWQxNigmbG1fY2ZnLT52cV9zdGF0ZV9yZWdp
b24gKyBxaWQNCj4gPj4gKiAyKTsNCj4gPj4gKwkJcmV0dXJuIGxhc3RfYXZhaWxfaWR4Ow0KPiA+
PiArCX0NCj4gPj4NCj4gPj4gLQlyZXR1cm4gbGFzdF9hdmFpbF9pZHg7DQo+ID4+ICsJcmV0dXJu
IC1FT1BOT1RTVVBQOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBpbnQgaWZjdmZfc2V0X3ZxX3N0
YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQsIHUxNiBudW0pICB7DQo+ID4+ICAgCXN0
cnVjdCBpZmN2Zl9sbV9jZmcgIF9faW9tZW0gKmxtX2NmZyA9IGh3LT5sbV9jZmc7DQo+ID4+DQo+
ID4+IC0JdnBfaW93cml0ZTE2KG51bSwgJmxtX2NmZy0+dnFfc3RhdGVfcmVnaW9uICsgcWlkICog
Mik7DQo+ID4+ICsJaWYgKGxtX2NmZykgew0KPiA+PiArCQl2cF9pb3dyaXRlMTYobnVtLCAmbG1f
Y2ZnLT52cV9zdGF0ZV9yZWdpb24gKyBxaWQgKiAyKTsNCj4gPj4gKwkJcmV0dXJuIDA7DQo+ID4+
ICsJfQ0KPiA+Pg0KPiA+IFRoaXMgaXMgbW9yZSB0aGFuIGluZm9ybWF0aW9uYWwgYW5kIHJlcXVp
cmVzIE9BU0lTIHZpcnRpbyBjb21taXR0ZWUgdG8gYWRkDQo+IHNlY3Rpb24gdG8gaW5kaWNhdGUg
cGVyIHN1YnN5c3RlbSB2ZW5kb3IgdG8gYWxsb3cgaXRzIG1vZGlmaWNhdGlvbnMuDQo+IFRoaXMg
aXMgSW50ZWwgU3BlY2lmaWMgaW1wbGVtZW50YXRpb24uDQpTdXJlIHRoYXQgaXMgZmluZS4gU28g
a2VlcCBpdCBhcyBfaW50ZWxfIGRyaXZlci4NCk5vIG5lZWQgdG8gYWRkICJhbmQgc3RhbmRhcmQi
IGFuZCB0aGluZ3MgYXJlIGp1c3QgZmluZS4NCg0KPiA+DQo+ID4+IC0JcmV0dXJuIDA7DQo+ID4+
ICsJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICB2b2lkIGlmY3Zm
X3NldF92cV9udW0oc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTMyIG51bSkgZGlmZg0K
PiA+PiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMNCj4gPj4gYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGluZGV4DQo+ID4+IDgwZDBhMDQ2MDg4NS4uZTg5
ZmQ0ZDk2ZmYxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMNCj4gPj4gQEAg
LTEsNiArMSw3IEBADQo+ID4+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQ0KPiA+PiAgIC8qDQo+ID4+ICAgICogSW50ZWwgSUZDIFZGIE5JQyBkcml2ZXIgZm9yIHZp
cnRpbyBkYXRhcGxhbmUgb2ZmbG9hZGluZw0KPiA+PiArICogVGhpcyBkcml2ZXIgYWxzbyBkcml2
ZXMgc3RhbmRhcmQgdmlydGlvLXBjaSBoYXJkd2FyZXMNCj4gPj4gICAgKg0KPiA+PiAgICAqIENv
cHlyaWdodCAoQykgMjAyMCBJbnRlbCBDb3Jwb3JhdGlvbi4NCj4gPj4gICAgKg0KPiA+PiBAQCAt
ODgwLDcgKzg4MSw5IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBpZmN2Zl9wY2lfaWRz
W10gPSB7DQo+ID4+ICAgCQkJIFZJUlRJT19UUkFOU19JRF9CTE9DSywNCj4gPj4gICAJCQkgUENJ
X1ZFTkRPUl9JRF9JTlRFTCwNCj4gPj4gICAJCQkgVklSVElPX0lEX0JMT0NLKSB9LA0KPiA+PiAt
DQo+ID4+ICsJLyogc3RhbmRhcmQgdmlydGlvIHBjaSBkZXZpY2VzICovDQo+ID4+ICsJeyBQQ0lf
REVWSUNFKFBDSV9WRU5ET1JfSURfUkVESEFUX1FVTVJBTkVULA0KPiA+PiArCQkgICAgIFBDSV9B
TllfSUQpIH0sDQo+ID4+ICAgCXsgMCB9LA0KPiA+PiAgIH07DQo+ID4+ICAgTU9EVUxFX0RFVklD
RV9UQUJMRShwY2ksIGlmY3ZmX3BjaV9pZHMpOw0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPj4N
Cj4gPg0KDQo=
