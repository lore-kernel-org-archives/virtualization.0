Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC23DAAC8;
	Thu, 17 Sep 2026 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641741; cv=fail; b=P81u3K7wDIsn79wNOAkoly/42NYcPy9I9WGL7GZSeDmSKoZb+i39Jf+geAhBTxPyxuY16qRav+X/1p5bZ7K5Nf2eurhMARFSv2G8NN0Ebgz9rPUS6YRRL/TOBjk89cPeqJuhTmRf5g4je5iqDCLK6insNsxJoMbbTLkf0gTo+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641741; c=relaxed/simple;
	bh=182qGVSmJ5eZmqzyFPbb6y7MncQuF2HlcId/NXkMHW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWDZTN7deALaGqoCGA48gnaiDq4DQgxi9kOUstP0PaZsanua0zjdgAluhaHKzLofT0BYfRXUrISseaLcQGoDnMC7K2XS0h+yKeUtWHqha8Seh9LfT3jU6ofnxOxAM6+G9f8wRhTDWAokMJf4ssPspDR5ojbFZCwF372xcTivK24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0mmr2xNj; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0mmr2xNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh5vkAusWlVK7BimYDpS9bUTgjh+lCT3wdkIv4/nGdqQ6zRIXWhV5wVI9I5dyZMLR+zns5hNqLJxH1TYk1lxSf0hP0vRoeqkkgMiOVMdmsU/lY/Dhvm2yqfb5n5atTQjdDHk3xzgogW6MIpaVbIKps1Cpqf0xwKIRTpb52/DqdD3u2khYniwNDt3RAEZqZUQaA7FcyolbLCuEiIdy64id0RLsjAGmkITGP+DPAHjFXdxN8gS4ldy7jYv1VIg+Xbi47Jn2nJDRAKEli6NiIERFltF++g+/LhQYwYnXrBS7MXb228L5IeFmV+kpLOt8PfyCf42d05VmGlmzq59a8kAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=182qGVSmJ5eZmqzyFPbb6y7MncQuF2HlcId/NXkMHW0=;
 b=vlWTVCJmWCPBK8YQT7A3gP9tPcziQEkwU38+TxT/cjhePpZZxWcSJcQU2u+/mUDzQTQHMNCf0ZjifA0q506Pz68471SgydkM3N3VccwMRZrcAoC9/BpMAvSk9TeGArrqdxSiXD6xoohLUX/ySfC9YnqNoTcLZPXcFedawWWmc6/F5GPqatikhGjjgyuDymsjoc7wCnVftosXToSv7VwHut6YAfGidXjzb7nJDWYt257tskhjEoPgKUL/ArzPTHwDu6eFysOGfuN2Oa5bTwRpem4l2P3totcXO28ZmkoO5OXdquWdLdg1V214Qo+JjGc3hLr/KTAIkrhdx7BAUm/7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=182qGVSmJ5eZmqzyFPbb6y7MncQuF2HlcId/NXkMHW0=;
 b=0mmr2xNjJQN1ZUwQ2qVpYqxvi6dFPtOM+kZKSQSnVGHEbWUpm6KC9qsB+eLwwsX5eadGXywy1JBrg89GMjn/gckEV/NuC89VGf59Q2W48Erlw3ayoiOnSau4oRlZPIH+LfQoWOdKYNl9+zIM9s6FuEOovNFH1z8zOpsolHkMk/M=
Received: from PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:42:15 +0000
Received: from PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009]) by PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:42:15 +0000
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Eugenio Perez <eperezma@redhat.com>
Subject: RE: [PATCH v6 2/4] drm/virtgpu api: add blob userptr resource
Thread-Topic: [PATCH v6 2/4] drm/virtgpu api: add blob userptr resource
Thread-Index: AQHdRo78rfmv8WDVBkO4XshLDyCQmrbSkyiAgAABz2A=
Date: Thu, 17 Sep 2026 10:42:15 +0000
Message-ID:
 <PH8PR12MB7183279E6B3BD93C5EBD5193D9B82@PH8PR12MB7183.namprd12.prod.outlook.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-3-honghuan@amd.com>
 <20260917103437.92F271F000FF@smtp.kernel.org>
In-Reply-To: <20260917103437.92F271F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-17T10:41:05.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7183:EE_|MW4PR12MB6949:EE_
x-ms-office365-filtering-correlation-id: 705bad23-c6cd-4086-d813-08df14a856de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|18002099003|4143699003|56012099006|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 WGPkldkRi7oUK1Z7ftqFBYvTqi/Vxs9qdR6RjJKZeZTH58jMSuiu0pEgWnL5YdryI4crYbQ19yWAy/mAWut/b0+3JGo8RiI1zc5Q7pM8I3Su/YCvtz3l1ttDzF0J2PrDwLJw8L8NSMvsYQCAt7V7CXQ6fEw2P0eX01NoRip6aV8oD1mWoqgFWoKOnCsMo1QI4yv3zPLQMsh5NF//vfSg+BTXsEtPoNirwl2NtWSc4OqAISPt2lScjAioXmX/09Cd9ew4HHLniRCXzX31ff85dMY96XcYTgaagva50t00WSRM2u9IYFhh7lAbOyr+o3/z2iOBkmRRP89tvj7jF+XR2HUR/hZaRiHXqUWI48gav7WEpYItNWZrBxxKghv1cUfEw3UbsKvJxqusuMv3cGDbzA+GfGTPf98v12iS0JalbzmCAJO2O7rf5CAlvDnDd1sfwIvRluZUc8r0Y8RbLHytl/vWOBuHiMT4qx2t3DXLLHTQtfnSfy7ECayt1WTYlXKWeNCJe0/jYSQktD9IrkERagSXWgOFqOBOoKfDYzNd4eqQVnMrCDeoaa6dJU0dAIAgMMM8UhvnXz32OifetRuw+8rfWQHoTGwT2xF6mCCURP8qX4a1c8nUQ/r0sCFtP8jwMQqWE1+euuWUZPatc3hPk8dv0fk7XFlN4xsZarZEmTI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7183.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUM4L2F1dVhZUWd2OWxQVW1USFB0L25IRjM2UDh1MkFGM3JBMndWZFpwbGRq?=
 =?utf-8?B?Y3NFODJKeVk2czduejE4VTRQMHpQcFR3a2EvcmxkT2xOa1N5TFFVanV5M04z?=
 =?utf-8?B?K1pHZW5JQk15RUFpT3g5UkMweDVidFZRS0xOSVZjeVZKNmk0OGFaaVZndzQx?=
 =?utf-8?B?UTVBOWlJb2ZoaUovQkJPZUUxclRGWFFIWXpHRUdXL2xLOGdqMktHdjJqZ2I1?=
 =?utf-8?B?UlUwZzREcDc3blhKZXBVNktVZHFPVlllaStrOTVENzhCeDNkWVVna0ZXblZk?=
 =?utf-8?B?YlUrK2lyY2RjdTVhcTlrQ3Fnd1FKNzh5aksvUGptNTdON1VOcnZURHhzR29F?=
 =?utf-8?B?bCtpblNEdG8yOUIzOGl4RlZNQjJldm1NSGhXZncraWlVTk1vYmZNWU4vMlBD?=
 =?utf-8?B?Uzl1WUdaSVRyVlhOZTVSYno4Rlg2M0lHY2FPZXFURVNLQ3M3K1JCL3VnM0Rx?=
 =?utf-8?B?SitSaGdQM1EydXNFTmJsd0M2aGxIcnFoMnA2RjZ6bHNwOWtXMXdHK2hjL3FK?=
 =?utf-8?B?UEFHcUVmYi9tb2dnKzlTZmxQdTBtK2Vpd3lvL1pGaktqU0ZVbGpIMXJhZUZZ?=
 =?utf-8?B?bzJkMWtMTWxqTWlRa2wxRW8xUUZsTndZREowMk93OU1VeGhCRzB4UzZiMlB1?=
 =?utf-8?B?ZU4zSUNRNU1oYi8xNFIwVFJkYnQ4VGx6bUo4RmQwZzBMRGcyS2ZOb1dsV2VH?=
 =?utf-8?B?aDB6SFAvOEFNakdGOUhwVjhJK0NwSUJ6Vk5Ia29yWXV4dFQxa2t3NEFUSUVa?=
 =?utf-8?B?SzE4ZTJtcE1YbE9QVHNVUENoM3N3ajc3bEpDZVNha0RPZzZ1U2RIcFFveXZX?=
 =?utf-8?B?TTd3UXhSNGZmV2hVbEppUDI4ajZSSFNaaVdWZmo3SmtIRGdpNTZjckxVTjJh?=
 =?utf-8?B?cWVuZjFkZUdYMTBaWENLRklXN3p0akNscWhUWG9wdHFFdFg0d0dWcmJsbitm?=
 =?utf-8?B?WUpZeWRoMGRKRCthcmtJWi83VHVRNVlXcFhFVHlxdmszc2x4a3QxR2RKdFJo?=
 =?utf-8?B?SjRVTHRzR0RVa1lwOTljd2lLbkRRNU01WEg4VjZxbnRaVGdjSG5MOEhHNU9E?=
 =?utf-8?B?SDRPSnJUbC9lNFBiNkxTUWdqTm1LN2JuZTRBbUNHOHdJZExpNzBuWTFUN2ZS?=
 =?utf-8?B?dnRub2NQNHBqa0FwdWtEN1VmYlpnK1RvT0c0QStkUVRsV3I0VnV6YjNwWUkx?=
 =?utf-8?B?cjRkSW9IUndONG9tcmlJQ3hGRzNxQUprbi92dThla2hXSXBsUW5uMlJSYWh0?=
 =?utf-8?B?YUNERkFJaFlFWDVxZXl3Nno3UnBpSGRCNnVLZDJQRXRRdEFkZjNOYVk3V1h2?=
 =?utf-8?B?Q2xMcy9YK25DQnVFK3hqSml5Z3AwMURGRk90bXdPWi9iN3lNVlpLdHhHQXlH?=
 =?utf-8?B?VEJuY1p3U1hjcmpKQUlKK2hSb1Z1amo3RW5JalVwUUVOWjhJL25yUnZtR2Ru?=
 =?utf-8?B?a3ptbUpzTXFxWGhaRStDdEQ0Z0xkUWc4SWF4R0xqcVNKdnMvS3c5SkpuTU5Q?=
 =?utf-8?B?OXMvQytrY2UvcVFWZ0M0TnRrblF6anlJY3BsY3NYTkdyeUYwK3AyaWFFa3Bm?=
 =?utf-8?B?cjhyMVkreSt3OTlhYjhjY3ovU0lRNlhmZ254bnJxTXFBYk52ZlRUemR5bU1C?=
 =?utf-8?B?TSs5eE9yZEZqa3VpWEd6RENYSzRFbFVENitLdko0UXlsL3hpejZwb0J6VWdV?=
 =?utf-8?B?NGVJTWJFMktaOEZFWFVzbjhzc0g4alBDK3FENWNhT2JDVHpFRWZscVE3eE5I?=
 =?utf-8?B?YVlIMi95UkErdFZZOXJ0STJhQWp4eWNFSk1KWnZSaWw1VjdYSzdEbG0zbUF6?=
 =?utf-8?B?QjRhR2dtaG1TTHU1S2FBOXk0Z2xBWGZBdzJpbUFJS1lmK3V6L1phUlgyRVVz?=
 =?utf-8?B?Z2JiM0dINk40bzNkQUk2T0xHa29mUmhWaXNWeWNVeWYzMkdaZkg3WTdmZGtw?=
 =?utf-8?B?V2czbzdPeDd1L0pxMUdWWHRuT211MTR2V0gxWS8rNmxST1B2YjEwOUhLMWpU?=
 =?utf-8?B?b0tWeVNrcTdhRFBJTk01UUZ2WE4rb1R5L20vcENkWWNVR1dCeFZGNWdpd2VN?=
 =?utf-8?B?My96NW1BVXBmOFk3UzJnOUJsN0RHVUlqVnBvTXN2cmVrbmtGZnFLSllXQTB5?=
 =?utf-8?B?b1VnQ0hxTHU5SllQUGtSSDQwMmRVdGh6bmJHaGRWQkNhaEFkU1N6MkNIVXZp?=
 =?utf-8?B?SkthdVlsY0RiWlQvRVpVNXU3aW1KMnRrRlV0dVZSVHA2QUhnT1NBV0UrYm9F?=
 =?utf-8?B?VVI5cUhaSS9nc3IvajNBOXYzczhXWHdWalFsTHI2NnJGTzRiYmNJM3VvOXk0?=
 =?utf-8?Q?QoXmJMukeKcYriHLy1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7183.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705bad23-c6cd-4086-d813-08df14a856de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 10:42:15.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDChqMjwVR8ezH5ifHh/7yzuOJVQw2BGMNmv1+SwQ7quJgtZKfWmWK//N+HTbISTlGG0OZrEes6eJ5JeURnZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

QU1EIEdlbmVyYWwNCg0KVGhpcyBwYXJ0IG5lZWQgc29tZSBpbnB1dCBmcm9tIG1haW50YWluZXIs
IHRoZXNlIGZsYWdzIGRvIG5vdCBzZWVtIHRvIGhhdmUgZWZmZWN0IG9uIHRoZSBRRU1VIHNpZGUu
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBzYXNoaWtvLWJvdEBrZXJuZWwu
b3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAx
NywgMjAyNiA2OjM1IFBNDQpUbzogSHVhbmcsIEhvbmdsZWkxIDxIb25nbGVpMS5IdWFuZ0BhbWQu
Y29tPg0KQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5kZXY7IEV1
Z2VuaW8gUGVyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY2
IDIvNF0gZHJtL3ZpcnRncHUgYXBpOiBhZGQgYmxvYiB1c2VycHRyIHJlc291cmNlDQoNClRoYW5r
IHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90
ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KLSBbSGlnaF0gdmlydGlvLWdwdTogZ3Vlc3Qt
b25seSBibG9iIGZsYWdzIGxlYWtlZCB0byBob3N0IGJyZWFraW5nIHdpcmUgQUJJDQotLQ0KDQpj
b21taXQgY2UxNTBjYjFhNjg1MjhlNDkxZDQwYjI4YzAzMzc2MzExYTY1M2MwYw0KQXV0aG9yOiBI
b25nbGVpIEh1YW5nIDxIb25nbGVpMS5IdWFuZ0BhbWQuY29tPg0KDQpkcm0vdmlydGdwdSBhcGk6
IGFkZCBibG9iIHVzZXJwdHIgcmVzb3VyY2UNCg0KVGhpcyBjb21taXQgYWRkcyBEUk0gaW9jdGwg
ZmxhZ3MgYW5kIGEgdXNlcnB0ciBmaWVsZCB0byBhbGxvdyB1c2Vyc3BhY2UgdG8gcmVxdWVzdCBh
IGJsb2IgYmFja2VkIGJ5IGFuIGV4aXN0aW5nIHByb2Nlc3MgbWFwcGluZy4gSXQgaW50cm9kdWNl
cyBndWVzdC1vbmx5IGZsYWdzIFZJUlRHUFVfQkxPQl9GTEFHX1VTRV9VU0VSUFRSIGFuZCBWSVJU
R1BVX0JMT0JfRkxBR19VU0VSUFRSX1JET05MWSBmb3IgZ3Vlc3QgcGluIGJlaGF2aW9yLg0KDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL3ZpcnRncHVfZHJtLmgNCj4gYi9pbmNsdWRl
L3VhcGkvZHJtL3ZpcnRncHVfZHJtLmggaW5kZXggOTU1ODdlMTJhZWQ1Ny4uNjE3MWI0ZTIzMDBi
MQ0KPiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS92aXJ0Z3B1X2RybS5oDQo+ICsr
KyBiL2luY2x1ZGUvdWFwaS9kcm0vdmlydGdwdV9kcm0uaA0KPiBAQCAtMTg2LDYgKzE4Niw5IEBA
IHN0cnVjdCBkcm1fdmlydGdwdV9yZXNvdXJjZV9jcmVhdGVfYmxvYiB7DQo+ICAjZGVmaW5lIFZJ
UlRHUFVfQkxPQl9GTEFHX1VTRV9NQVBQQUJMRSAgICAgMHgwMDAxDQo+ICAjZGVmaW5lIFZJUlRH
UFVfQkxPQl9GTEFHX1VTRV9TSEFSRUFCTEUgICAgMHgwMDAyDQo+ICAjZGVmaW5lIFZJUlRHUFVf
QkxPQl9GTEFHX1VTRV9DUk9TU19ERVZJQ0UgMHgwMDA0DQo+ICsvKiBHdWVzdC1vbmx5IGZsYWdz
ICovDQo+ICsjZGVmaW5lIFZJUlRHUFVfQkxPQl9GTEFHX1VTRV9VU0VSUFRSICAgICAgMHgwMDA4
DQo+ICsjZGVmaW5lIFZJUlRHUFVfQkxPQl9GTEFHX1VTRVJQVFJfUkRPTkxZICAgMHgwMDEwDQoN
CltTZXZlcml0eTogSGlnaF0NCkRvIHRoZXNlIGd1ZXN0LW9ubHkgZmxhZ3MgbGVhayB0byB0aGUg
aG9zdCBhbmQgYnJlYWsgdGhlIHZpcnRpbyB3aXJlIEFCST8NCg0KV2hlbiB1c2Vyc3BhY2UgY2Fs
bHMgdGhlIERSTV9JT0NUTF9WSVJUR1BVX1JFU09VUkNFX0NSRUFURV9CTE9CIGlvY3RsLA0KdmVy
aWZ5X2Jsb2IoKSBhc3NpZ25zIHJjX2Jsb2ItPmJsb2JfZmxhZ3MgZGlyZWN0bHkgdG8gcGFyYW1z
LT5ibG9iX2ZsYWdzLg0KVGhpcyBzdHJ1Y3QgaXMgcGFzc2VkIHRvIHZpcnRpb19ncHVfdXNlcnB0
cl9jcmVhdGUoKSwgd2hpY2ggY2FsbHMgdmlydGlvX2dwdV9jbWRfcmVzb3VyY2VfY3JlYXRlX2Js
b2IoKS4NCg0KSW4gdmlydGlvX2dwdV9jbWRfcmVzb3VyY2VfY3JlYXRlX2Jsb2IoKSwgdGhlIGZs
YWdzIGFyZSB3cml0dGVuIGRpcmVjdGx5IHRvIHRoZSBjb21tYW5kIHdpdGhvdXQgbWFza2luZzoN
Cg0KZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3ZxLmM6dmlydGlvX2dwdV9jbWRfcmVz
b3VyY2VfY3JlYXRlX2Jsb2IoKSB7DQogICAgLi4uDQogICAgY21kX3AtPmJsb2JfZmxhZ3MgPSBj
cHVfdG9fbGUzMihwYXJhbXMtPmJsb2JfZmxhZ3MpOw0KICAgIC4uLg0KfQ0KDQpJZiB0aGVzZSBn
dWVzdC1vbmx5IGZsYWdzIGFyZSBub3QgbWFza2VkIG91dCBiZWZvcmUgYmVpbmcgc2VudCB0byB0
aGUgaG9zdCwgd2lsbCBzdHJpY3QgaG9zdHMgcmVqZWN0IHRoZSBjb21tYW5kIHdpdGggYW4gZXJy
b3IsIG1ha2luZyB0aGUgdXNlcnB0ciBmZWF0dXJlIHVudXNhYmxlPw0KDQpJIG5vdGljZWQgdGhp
cyB3aXJlIEFCSSB2aW9sYXRpb24gYXBwZWFycyB0byByZW1haW4gdW5maXhlZCBhdCB0aGUgZW5k
IG9mIHRoZSBwYXRjaCBzZXJpZXMgKGNvbW1pdCAzNTcwNzZiZjU4MWMpLg0KDQpbIC4uLiBdDQoN
Ci0tDQpTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQv
MjAyNjA5MTcxMDI1NDAuMTMxMjEwMi0xLWhvbmdodWFuQGFtZC5jb20/cGFydD0yDQo=
