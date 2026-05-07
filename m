Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64D3ED5D9
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164331; cv=fail; b=R23tfN9FLtumParQh5VyYVO75GOZXYowFanY16zKV1GqiT60HdvAvTcpc0eNJsYADjcMNclK/o+G0l3VlV/hlfFAFvdbiD3vhhEI3yA3x6QGhei0eZynWxYR8d0XWCrIyNxTKcJyRdyvLm9MpyuPEqBoAxQ/YqhqhfkoHG8nbyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164331; c=relaxed/simple;
	bh=4CAPo2SM521a8cuNOpnvIXmfipHVX2SPsRGRc4p1XNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTnSWvtf5CdeKRrIyGlyDCgO6dN99Jz5IxkL+i6VyEi1zzqbhyu4tKHJ0phXsJa26rZOfB2QzdsjH1n52U/kEvf5W/I67ZaOFkm4NgWN2ZRqZgtdo0xJdiguVkWA4equNiALfDPJ3YybsHXWDn0JdAY7IC2bTLgggQKNB+ZM7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.51 with ESMTP; 7 May 2026 23:02:05 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: baver.bae@lge.com
Received: from unknown (HELO sniperexo2.lge.com) (165.244.147.12)
	by 156.147.1.127 with ESMTP; 7 May 2026 23:02:05 +0900
X-Original-SENDERIP: 165.244.147.12
X-Original-MAILFROM: baver.bae@lge.com
Received: from unknown (HELO PUWP216CU001.outbound.protection.outlook.com) (40.93.139.6)
	by 165.244.147.12 with ESMTP; 7 May 2026 23:02:05 +0900
X-Original-SENDERIP: 40.93.139.6
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: baver.bae@lge.com
X-Original-RCPTTO: baver.bae@gmail.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ90kV4FA4zraSfgkUS2cZUIauOgwFeykGB4NuIZNgR9W6e652EteUjQPYzGp2VVD5CZ4BSyDlwm4Hkx5RkdSWCdoq9pc62Y76khqHvTYZJASYrF1KTfZ+Ox8pNXL+W8gGb0AZhbE/hcF40xZYzMUHAsLU3quJfg9zH8uvmFjs6bCtmdd+7G5O/08KJqsjw6JxvtYojhhfDc9BqP8eKoZ7jrXgzqX2LmG0Rufr6ffxfD3Or2KhMxITlinkG3WaC/6sScsq8iRz8HJw5RumzSRwZ0xMIyvmQvu0/EQXsxE3BnNV5lzIhZZrq+Q3UQnw+bn5z+bLjezFzrWeOougdH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CAPo2SM521a8cuNOpnvIXmfipHVX2SPsRGRc4p1XNg=;
 b=Nmqn3J5otHSDhxxTzBw7HeAo7y8vy3e2H1GPBKfdM6MyTIKCmPxZCktqd29jbs6GsSlNryAOm3NSTwTIvQFdjJrOJoOdLK/ulrP5cnxK0bIAr2dgEgvNC+6JiRpRxKplF1NYkCCB7phdc2phYtKdd3+sENE73+Hrog2dAw8Jspv0P2OYyuMTUD9H3wdXcZk6IbwrOe9X5Q7lpwQsaPMHUaaF0kWPndx79nC7Bs0RCpEFZjApGZGwB5i9MKU2JDs3ZdtVjVoO72nbptBoCO4wArGu8JdkaL9SMLyN0hoMf33Md0tYg0RjRl+9B+6B2QignCk+9FnKjTtleVQbtv+4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from PUVP216MB3266.KORP216.PROD.OUTLOOK.COM (2603:1096:301:168::21)
 by SE1P216MB1319.KORP216.PROD.OUTLOOK.COM (2603:1096:101:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 14:02:02 +0000
Received: from PUVP216MB3266.KORP216.PROD.OUTLOOK.COM
 ([fe80::2c5e:a807:fe06:202]) by PUVP216MB3266.KORP216.PROD.OUTLOOK.COM
 ([fe80::2c5e:a807:fe06:202%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 14:02:02 +0000
From: =?utf-8?B?67Cw7ISx7Zi4L+yxheyehOyXsOq1rOybkC9TVyBQbGF0Zm9ybSjsl7ApQWR2?=
 =?utf-8?Q?anced_OS_Task?= <baver.bae@lge.com>
To: Sungho Bae <baver.bae@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>
CC: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J206rG07Zi4L1Rhc2sgTGVhZGVyL1NXIFBsYXRmb3JtKOyXsClBZHZhbmNl?=
 =?utf-8?Q?d_OS_Task?= <gunho.lee@lge.com>
Subject: Re: [RFC PATCH v8 2/4] virtio_ring: export virtqueue_reinit_vring()
 for noirq restore
Thread-Topic: [RFC PATCH v8 2/4] virtio_ring: export virtqueue_reinit_vring()
 for noirq restore
Thread-Index: AQHc3XTMVzt5JFAAUEWzqieWDHRUcrYCjTzk
Date: Thu, 7 May 2026 14:02:02 +0000
Message-ID:
 <PUVP216MB32666718B999ECE451867745F13C2@PUVP216MB3266.KORP216.PROD.OUTLOOK.COM>
References: <20260506162254.25576-1-baver.bae@gmail.com>
 <20260506162254.25576-3-baver.bae@gmail.com>
In-Reply-To: <20260506162254.25576-3-baver.bae@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUVP216MB3266:EE_|SE1P216MB1319:EE_
x-ms-office365-filtering-correlation-id: 1bbbbc8c-1805-41cd-454c-08deac4136e5
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Xp7loqo6+gke2g7ayyboLPcNmwwFkZUr9TwaEMLWawXuC1t4a8U37Tu5JjxF6P/1+Z5s2y/qldTXJLSleGkNcZz9bt8GJ5YUb1NoqHWZLnilGF2hgtF/PxdXzvsB9HUR1BvD0OskNdNiyxQYmQ60qBTMFgyDrCMnQupcstkQtww2iEn2TZ1JW6cW67MiryqY54GqalNm85CZuA0GJeF56t0pNrt1igPixORnRV9xeL4+7ytHzKketVIpxkmkrLL2H6EVVN9hTCyCManrrsPTKJrSO1irBYBUpSZWobjJWupba+zjpqmIJfFmDpsaNGmbe45sBDHCJ5VXo1iaGA6twQFiNhvp90xb6Bpg6kwLYZf18Cq7Rs1XosM0d5HUQNlqf3/mG3oQPXtBJ5lgctB4M+TEnsdgiOkNXEscn8UZ30e9EBGY8Es7NvEFFmMurcfa/QuFSN5GE2MBzMeycp5qY0ODP6UKUXQ5Yd6sMitEvb6ZUwpgY/nQEJyKzS4MUnC/mbfSk48LcwKTvLSnEUylzhMHg61kMOkcRmRo5Waw0RlAwCe/2FyCntgu7DZPT/QVKeEnsKnECIv4510A828TQ37ZAyJz7gbyNM03v/n59YkYXqw6Xy6vnBfuk7MT6c8vjnkCu1+BysObA+mDQtyXASepmSJZZH4QS5XkaOGDYHtYX1gCwu53rRORNgH55v1MFISYwGeCtjCcV4NWNqsuJw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUVP216MB3266.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFQ1cGMydnhYcmc4Ky91bStzTEIzaGFuZXR5VVhLMHEzeDVDeFdsa1ROLzNJ?=
 =?utf-8?B?L0dHSUlBSVpscWNzU1pDclFTWGllZDl4TEVpM01IL0V3K3RzZk1nYytEdkI3?=
 =?utf-8?B?STFzSDc4QWZnNG9mYjROMkJOcFdZREdKMEcwcE04MnQ2V2FLQVZCVGVNRmhi?=
 =?utf-8?B?UXlUT003OWZLVXlQdkFhSWxEdDBIbWlwdGlqTXdUZGFvVHZodWhGN2luT2I5?=
 =?utf-8?B?VHlSR3J5YWdOdGtzYXRwV2lZSnI3Y2NWSHdvdTUwQ0x2ZkY4U1Jyb3lud2Q0?=
 =?utf-8?B?WFFGUkpIYXhwS0FLUGhKRG54SWVkY3AyazEvcGFjNHM0TGhyZG1ZdTdXOVJn?=
 =?utf-8?B?b0hxd3ltQThXU3o2YnJ5UmhyOUo5NmY2UkVRUXpoTmRPU29ibTVPSUJBZTB2?=
 =?utf-8?B?YkMycHU4SWVFY2xhV3RpeTNNZDdFTjFuYWh5TldkaXEyUU5IV0FWVXJGeHA3?=
 =?utf-8?B?bEJtZzdNMUdkMzF5Y2R6MFlVb3k3TnRWRFA1cENCOXZnNGdHNFd3WU8vbjhM?=
 =?utf-8?B?cHdVd0VTNERDZ0QyZTdaVVlQRjdoWXRqdmRxeXRXTXJMREp1aStpUnNJdnZH?=
 =?utf-8?B?bWtBem9VOVQ0VlM5UVZBcVAvVlpWcWxlNHNjYWRNakdsM2FNN01BcUxkUVNw?=
 =?utf-8?B?ZHdpTEU5emt5dk9hRzllNFhUSEZrb2RBdHByNGpMbDFTUVpYZWJWVUNGN2gv?=
 =?utf-8?B?V2pMQnJuN1E3UHNvRUd0TGNadlZseU1lNUpHNnV6MzdPZWF2OXZyRDFLRTBE?=
 =?utf-8?B?a2ZlYmx5YkV3TmNqZTlBZGo5R01ETXZ2YnRtYjJUMTZVYmUwVmg0TFhTYTlT?=
 =?utf-8?B?UGhZK1VERVlsQnhiZ242Rkgwb21rVlJqbG9EeHgxdEMzODdHckpVQlVXcVRj?=
 =?utf-8?B?SzJESXJtaVpkMk40V3FrL0Q2WDg1Q2hscEpOc2dBc0xFTmw1eUZwT2FaMC9K?=
 =?utf-8?B?TC9Gd3dYQ1Iva2xMajdDZlVPUHd4cnQ3Q29OVXd1MmRieXhKSU9nM0JibFQ4?=
 =?utf-8?B?dUp3ZDF0K0FFUFFPMnpYR1BEY0p1K1QwNDRkMDhVNnR3a3VuazE2T244ZFNE?=
 =?utf-8?B?dFZZV09YS3hmM0ZWNmVWMjZ4ajZuZFQxMlRFTW52eUxHN3E1Tno5bndFMmY4?=
 =?utf-8?B?dG5rVC9zVENNSW5yTVQySjhDZlhJd3Z1bWhHcHBHNytUOUsxRjNtVHE1WENH?=
 =?utf-8?B?K05PdFlNTkpqT1dRNlF3clJZamJFRExPNUVGenNndmFwM0hxM3NvOUFuMnhy?=
 =?utf-8?B?ZkdXM0l5aW94N0FrQW5JWDcxcG9yTDIvMVZHUDZRQ3NobC8weW1vQVRQZmRZ?=
 =?utf-8?B?bnd2THRZQm90ZzJIUEtQbXh0R0J4ZnFNNEhwY0c3Uzdpb1ljUjVTd044d25r?=
 =?utf-8?B?ZlE5ZCtHa1lCLzZTaGRhRktId3c1Vmk0MHhRVkkwS0xkckx3YlhuSVhWZGZ5?=
 =?utf-8?B?b0RXL3FFQ0dqSkFRbVoyZ09JL0Y2dXJCUzBqYXViaVgrbk1acTNWZ2F2eEtn?=
 =?utf-8?B?YmVXYWNhaGdYajRrdDlVTEVQblJVcm1DMUljSSszb3BiRkdIY3IyTVRXMGd4?=
 =?utf-8?B?LzlKN3ZBUHFWRHQxdHQ5dTE0NjdSZFcwbWRvV3ZiTFgvOVB5QXJCSmJ6YmV4?=
 =?utf-8?B?WXNjWHhWQXNyWDhMdG5XL1hIQURFMWFyUGZsRWNpcE1US2FLUHY3RjJIN1NU?=
 =?utf-8?B?VXVpRHB2enZYMmo1NmZtMkxNYTM3TmRpdS9WQ2tVTE9ZdjJtM2ZNdCtLbVda?=
 =?utf-8?B?RkVOYmFYcmNWWUptTjZPMUwwaUw4QTFoYUkyUlJabWhORFB2cU9rUEhHa2hS?=
 =?utf-8?B?VzRrR0I2c1g0TnVlUzBTQzNNVVN4VFVKQXB0bUlucm9Bc2ZwSUMyTXNaZWxU?=
 =?utf-8?B?QllOYmZTRUJsY0xmSG1sRUJyYTBYdjlseDJVTDNuZi91ZTlLdExwSkcva0xM?=
 =?utf-8?B?NStyNE0yNlFtS0ZhN1FXamlUT1pYWVJmNlR6NGx1TnZaSi83VVNoVCtXM3Qr?=
 =?utf-8?B?ekxzeGo1MU8zODBrYjVMaktqY3FiS0ZtYUVQcC84c1dhQzcvWFprQWVOSTBk?=
 =?utf-8?B?UGE2T2lFTmFTQnFSVXh6NXdKUE1iNFJzcEZueWhTNjJLcDFYY3RyeW1ZU3N3?=
 =?utf-8?B?aDBnUFRWaTlsRDZOM2RnY043ZTZPSTg1REdjOTVvTFZZd0I5R05GNXEyNVNX?=
 =?utf-8?B?ZUhHaDhtOE00YVliK2x0amdKU0hkSTgwS0pUbjBEREREa1QvNlcrd0UrYlhu?=
 =?utf-8?B?dUdQWFd1ODFIa3hpd1BtT2VJR1hWWHQ1N2lNNnZJYVFlZWd4NHdnemZ1MDRC?=
 =?utf-8?Q?A/U0LNJJhhb1kRbauR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fOw/TDGq0xOM/qfc5dyN2DrNNgpEAk8X2UMUddxdDdsXO5SQv0GUFwycjI9Q4WP3P0xv+aYfum38SG8wDAHXXQGPFhSreMURlCwYQQGQvZlFftJWf17/ir7pF8q2IgP62ShkPpgxH4DoiVfqUI/uKvOAvPOq4WudlRGlX/1gAXtmrJ7IU4IT+vd6QI7GMhRos1Gr31XGh+AC9nGhBC4Z6PkJLlFmwkbWK8rCqqtA2UtVlbxG5BhSi4/3pjN+eHfpXMs9Z5lpj6ZxkeZYAbWIgd+KApJMwA0zWjfczJAFKOS2q4e87CBaxR3ShhRTWG/IcIVHI2ToCkbXswLEb63Lyw==
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUVP216MB3266.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbbbc8c-1805-41cd-454c-08deac4136e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 14:02:02.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfBt4nt8bovY/zkJmQRnx0D1c+/gX7ONiOP8BBUCAwH6tgm03OvQxaip+30p0v23etHGE1MmrFtE9SiED694FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1319

T24gVGh1LCBNYXkgNywgMjAyNiBhdCAxMDo0NToyMFBNICswOTAwLCBTdW5naG8gQmFlIHdyb3Rl
OgoKPiArwqDCoMKgwqDCoMKgIGlmICh2aXJ0cXVldWVfaXNfcGFja2VkKHZxKSkgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpcnRxdWV1ZV9yZXNldF9wYWNrZWQodnEpOwo+ICvC
oMKgwqDCoMKgwqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBTcGxpdCBxdWV1ZSBzaGFkb3cgaW5k
ZXggc2hvdWxkIG1hdGNoIHRoZSB2aXNpYmxlIGF2YWlsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGluZGV4IHdoZW4gdGhlIHF1ZXVlIGlzIGZ1bGx5IHF1aWVzY2VkLgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoV0FSTl9PTih2cS0+c3BsaXQuYXZhaWxfaWR4X3NoYWRvdyAhPQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0aW8xNl90b19jcHUo
dnEtPnZxLnZkZXYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnEtPnNwbGl0LnZyaW5nLmF2YWls
LT5pZHgpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FQlVTWTsKCkEgc2VjdXJpdHkgaXNzdWUgcmVnYXJkaW5nIG1hbGljaW91cyBob3N0
cyBoYXMgYmVlbiByYWlzZWQgZnJvbSBzYXNoaWtvOgpodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0
Y2hzZXQvMjAyNjA1MDYxNjIyNTQuMjU1NzYtMS1iYXZlci5iYWUlNDBnbWFpbC5jb20/cGFydD0y
CgpUaGF0IGlzIGEgZ29vZCBwb2ludC4KCkhvd2V2ZXIsIEkgZG8gbm90IHRoaW5rIHRoaXMgV0FS
Tl9PTiBpcyBtZWFudCB0byB2YWxpZGF0ZSBob3N0aWxlIG9yIG90aGVyd2lzZSB1bnRydXN0ZWQg
aG9zdCBpbnB1dC4gVGhlIGNoZWNrIGlzIHRoZXJlIHRvIHZlcmlmeSBhIGd1ZXN0LXNpZGUgaW52
YXJpYW50IGF0IHJlaW5pdGlhbGl6YXRpb24gdGltZTogb25jZSB0aGUgcXVldWUgaXMgZnVsbHkg
cXVpZXNjZWQgYW5kIHRoZSB0cmFuc3BvcnQvZGV2aWNlIHNpZGUgaGFzIGFscmVhZHkgc3RvcHBl
ZCBvciByZXNldCB0aGUgcXVldWUsIHRoZSBzcGxpdCBhdmFpbCBzaGFkb3cgaW5kZXggaXMgZXhw
ZWN0ZWQgdG8gbWF0Y2ggdGhlIHZpc2libGUgYXZhaWwgaW5kZXguCgpJZiBhIGNvbXByb21pc2Vk
IGhvc3QgY2FuIHN0aWxsIG1vZGlmeSB0aGUgdnJpbmcgY29udGVudHMgYXQgdGhhdCBwb2ludCwg
dGhlbiB0aGlzIGlzIG5vdCBhIHByb2JsZW0gc3BlY2lmaWMgdG8gdGhpcyBXQVJOX09OLiBTdWNo
IGEgaG9zdCBjYW4gYWxyZWFkeSBjb3JydXB0IHZpcnR1YWxseSBhbnkgc2hhcmVkIHZpcnRxdWV1
ZSBzdGF0ZSwgc28gcmVwbGFjaW5nIHRoaXMgd2FybmluZyB3aXRoIGEgcGxhaW4gLUVCVVNZIHdv
dWxkIG5vdCBtZWFuaW5nZnVsbHkgaW1wcm92ZSByb2J1c3RuZXNzIGFnYWluc3QgdGhhdCB0aHJl
YXQgbW9kZWwuCgpJbiBvdGhlciB3b3JkcywgdGhpcyBXQVJOX09OIGlzIGludGVuZGVkIHRvIGNh
dGNoIGd1ZXN0L2RyaXZlciBzdGF0ZSBpbmNvbnNpc3RlbmNpZXMgb3IgdmlvbGF0ZWQgY2FsbC1z
aXRlIGFzc3VtcHRpb25zLCBub3QgdG8gcHJvdmlkZSBwcm90ZWN0aW9uIGFnYWluc3QgYSBtYWxp
Y2lvdXMgaG9zdC4gRm9yIHRoZSBhY3R1YWwgZmFpbHVyZSBwYXRoLCB0aGUgY29kZSBhbHJlYWR5
IHJldHVybnMgLUVCVVNZIGFmdGVyIHRoZSB3YXJuaW5nLgoKSSB0aGVyZWZvcmUgdGhpbmsgdGhp
cyBpcyBiZXR0ZXIgdHJlYXRlZCBhcyBhIGRlYnVnZ2luZy9pbnZhcmlhbnQgY2hlY2sgdGhhbiBh
cyB2YWxpZGF0aW9uIG9mIHVudHJ1c3RlZCBpbnB1dC4KCkJlc3QgcmVnYXJkcywKU3VuZ2hvIEJh
ZQ==
