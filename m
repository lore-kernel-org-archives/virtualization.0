Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7144C60
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171736; cv=fail; b=UsjgFsoQqRZJvRDG3DOeaW9664vuM9UZeQC6AkFuGwA9hBS0DQpwhGxxgd3K7iXEsYrWfl+datIxbMAShgKszcP6DFtFyR4PapnKlCHLtZTAZLMP/nzO+ILfYOytX7PAD8W7U3gfVqeBiZTSSGlV3Wa/ol8PKHReo/ZVcXPGuFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171736; c=relaxed/simple;
	bh=CdGUSsu9tl2Y2mvqNticKYzd27u2mIpOnoEAo3VaPOs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ReSwDVyxGer0O5SLb56Cvkp8+ug68J82DeCpPVKawHwwX22gtKvI0ALYy5mHEMLV0vGehKBRxpm/HcCaron8PZSlQ6A8UHgNIzPOo3I/d+wr7ls8kKnwEgC5XtrKi6Cnk+rKvTEl4ULPGuIqzE+7KrK87t8490MPCUqmEEFF8Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=S3GFFzoG; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="S3GFFzoG"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE82A81C44
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 15:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4T-OlKBVFfY0
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 15:42:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:260d::701; helo=eur03-dba-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3FB1681C26
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FB1681C26
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=S3GFFzoG
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:260d::701])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FB1681C26
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 15:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbMB0mH2gD3h2hMmw41f2whj+Sbtv78NipVe9T6ol0SLiT1qGUzSXzyV1WqpiuM/KcVeXvDrglCaW6o6YnvwU/X8jFSUzNjiAS92BxFZpeWbV7+6RBeXm/kk1uZ3pcpuVevAOrCJytulWYNLZvu1iAYiM7raUOAhIG6hfTVwBuUnHkKLOSNIXvnvZftzwC3mu/FkNBsrFYgyc2wVCWhKQVbjlBvR43f7gc0zNdX+3CDTAoO1rhxEn5ciVV4uvyWBqbO+OcdWh0cbHRrp9VoLNUL/cwbSSR0HWMat2ytEmV5JuOIgW3VZn5EKnINV/W1CWqZ9UphMYXb2iBgVoPpsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdGUSsu9tl2Y2mvqNticKYzd27u2mIpOnoEAo3VaPOs=;
 b=gggAQtdGsbBpPZfzYh73MIR/qK7C9k8Je95P4Y3DFYPmmQR/pmetkzM52zghGVulQi9GuiRL5uLi0plHg4XiFBe+fPRbBkJAkgBHG8pkTVn7ABgFCJwjAHcHmZyMvJCgdXl7RIvljKfj2HzCIH4k2GKIeqbvOPg4R3E83SYhk++WL3o29bBsTKGmck1ZTuM9KnN4ZuYfoPM1puwVsX8SrEYvcHY2JEG0xZwvEsb9onvPuxyAbaXT/XubDXPgCCxXmu0nSp7r5bzOLGbNuBy86LSRaz2zP6IzOWbN+q/qBQ2SeLElHKTMlsP8vmPblHnf3W7CFnxQOWWh1MMCepL4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdGUSsu9tl2Y2mvqNticKYzd27u2mIpOnoEAo3VaPOs=;
 b=S3GFFzoGNnE0FydSELm6GJusvhzmuVf3SZucTpBHKyMKKHo3o2QzddouWlklaLE4oBuqgAQPiRWLZUqQUzNU1hPpRx7kiQokMUBvY0yzGxppyqgbW/EgY3QKASKs5CKX5azAmXjdU5KX0GCz1Ce7krwThHK1fx35/daJaUBUd6I=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by DB9PR07MB7242.eurprd07.prod.outlook.com (2603:10a6:10:21e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 15:42:06 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::f49d:54e2:b3e6:f607%2]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 15:42:06 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: WSCC 2024: Euro-Par 2024 International Workshop on Scalable Compute
 Continuum
Thread-Topic: WSCC 2024: Euro-Par 2024 International Workshop on Scalable
 Compute Continuum
Thread-Index: AQHac8qrXJrtr+jByEGhVETnC/lPvQ==
Date: Mon, 11 Mar 2024 15:42:06 +0000
Message-ID: <A3EEB814-410B-4EAA-85CB-22645192E80E@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phd.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|DB9PR07MB7242:EE_
x-ms-office365-filtering-correlation-id: 3befd79c-7fc5-4cf8-5a23-08dc41e1ce31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9gwE/4cZPDszAfqrNirpQv5VNSbJ4Zbp2ZUsT7rSwepDUYpm63cjf1FIbZL3mpsEx1aiTcWayQOQrUX/YJDUoAmKCJWXnQMs0wOae+X9bqdrgXjDHQ2DPEbRXRVNyUcX01CFP0RHdKkQUqyTXAHGSWNbqk2Tvxo5ZU0wmDOJwNMeeLrpRU4Ct0Dsb/wMEpHckIev/gWgvyv751lO82ZZFhqgOermkgLKqNSVJ46ylmof949tx83VGZ5uAq/lVdW1KvZq5zEChKj8zOV97ofmnqWp0CndTuo3qKV0M005bUVUSly3ygmZc7ryp79Sz6/ekGW1SnpIf3Px7/sK4Qy8C+zybL8wbx1MaCIkrC4GFFC9lryXsJn7JjMuNpWj/IC0KzfCDHVxJXPgP1OPLPIhYNTPeXQJoyV9MxBcdVSA03f3WH4ButAKZX+otw6jwJ+3msdbL8Zf8Qv3UYNvGptErchbO430PHpTj+VkV2IeNqYLw5Lw/5uMhPXt5hSFUcdTJROiys9HCTXu+x1ldXl8rnGvAVAo4LxNYn+g+BT4YSgzK4wm2KLsMzTOgMKTHT04/X+7BOL0xHid2CvIfoqeoOpkUKkjaLZz4jMkShUCO301YczkyKIHSflYWXiYUKQx6J2BYY6+MrFI0NBf05xSpWxw1NTRWnqzk1h4g2BcZ4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlZyRW5uZEtVcVMwSXVlMy9mWURkdnJtVWxtZHY1eEQwenNnaUl6Z005OWY2?=
 =?utf-8?B?VUJobWp1K01UMFdZVXFKZXVadytlSS9KYkxReDJkVVdseGFzeDlwa2I1Vk1L?=
 =?utf-8?B?RmwxTko5NnQ1QmJlZ0RPbVNicGdJb09EdUcxcXA2RmZlYk9KNEFpeEVHNExi?=
 =?utf-8?B?RU5PMDJKSVdEUW0rckJaeTI3M3M2UXZMZHlobEIwRGFhQWM0L3dQVWwxdlIw?=
 =?utf-8?B?WW50OXA1a0xtTXREY1NmZk1mTlBwZUtsOUxYcUZxWlFjbmE0NkcyVllGdUNH?=
 =?utf-8?B?Z3lyTnUzTEt2cEFHUDFnUVduVVVPVTduUEZGQ0VBUzdtNjY4N283WVpxZmtn?=
 =?utf-8?B?YXJNc3pnMFF2OFZWQjg4cGdtZ0s0eDNlQVBGMGt5dEdQUlFFYkI5L0pONjNy?=
 =?utf-8?B?T1REUWo4QUdvOFZOc3RLdnFEYnlpM3VHNXE3UlZRcU0wWnUzUzMvdGZjWVh1?=
 =?utf-8?B?LzE1TlY5b1EzQURMNXBrN1JRRFlOT2R0amN0Ym03V0h1VHZBQm9FVTFqdUZi?=
 =?utf-8?B?dENvN3p4ak9oZkY2aGczZ0I5Y2tRVEhBWHJ6QXl1MlhOQXNOM0VTSEZTTHRP?=
 =?utf-8?B?K1RqcGdZZ0J3YzREdjFzcHRmRTV5dlpCYVpjaG4yZFpDblh1MDA1cGQrd2Fn?=
 =?utf-8?B?VzhuaUtpTjFGSU01NVJibURGeS9JK0oyemRmN1RwQ0tQNHF0cW8zVnZQUTdM?=
 =?utf-8?B?ZDJoVXVqQzJ0elUvRU9hV2FnZzY3MzIzTDZHL0R3SGg5NG00eWZ1MHJUdGVu?=
 =?utf-8?B?emoyRGVPWG8ySUJ3ZCsvOU0vd1RFNS95QVRPN2tuTVBxNmVuT0MrWTZWN0Q5?=
 =?utf-8?B?akNmcGNYZWN5RVRaanc4OEJYQnVWNkJ2Tkx2NWNNNFJ0R2txdjdLb1hWZzhp?=
 =?utf-8?B?QUJGTnowcnFreTF6MWZmeHd4VHVuek1vZ2tmamVaTUlJTVNaZGdHTjZUSFBV?=
 =?utf-8?B?K0VqaGlhUE9mT1dReGEzdmFENTlrNDVVZExuVi82eEhEbzRuTitVOHNTbGpi?=
 =?utf-8?B?eXNnbjhVUXJsRStLRm1iZnh5Nmd0bk8vMS9Ud0NxMURoMmNaaFRKSzV1ZmZU?=
 =?utf-8?B?RUtYa0lJMGRMNmZoS0VoaExUaGZwb1IyNXpRU2NJWWE4Q3B5ei9mdFYyWnVr?=
 =?utf-8?B?N3dWWm1nTDVJZlgvQUhNS2JTWm9SOE9VT2tSdjQzQ2preHp4NkZ5VzI2VGtE?=
 =?utf-8?B?RXY3V3ZSRVVqODFnZko1WktQdHJ1S1dLNzJOQmJWeGpzZ2dOMlgrMkhuSitq?=
 =?utf-8?B?bUVMd3gzenJLTGRyMHdoRTQyOGtKYWxBZ1dNUUI2WFdhSkpsQVBUN0hTOXNG?=
 =?utf-8?B?TEpyamsxZ0c2UHZJZjdtTkNTbW1BREZLaUJQRTBSUHdPVWtXZnN1VHpZYXBt?=
 =?utf-8?B?eVJudllRZjkxaDV0YkV3emhLNDRaRmJvTmt3YlVCZWZzMmlUMGdDUkNWNjlG?=
 =?utf-8?B?cm9iRmo3WTgxRzRrQi9GRmIyTHlmc05QNXdjbzQyZWJ5TmkwbVRRalFiTmw1?=
 =?utf-8?B?c1ZJOEpMeDJHc2VLSmd0b09ObXBqOU9uKzRjRS9PeWF2Y3VJb3l4Wlp4QURt?=
 =?utf-8?B?aFVrQmIzdUVEQnNCVTY4YXMxQm1sOFZITzFFVlpKdWtvUTRPQWFoT2d1aFBY?=
 =?utf-8?B?bG5NckQyYy9NaEc5OGFUWTRFS0ZMd3lEMTkwSlJ5TjBOT2JPNjg1T012MFRu?=
 =?utf-8?B?VS9VQWx5TEczam52VUt0anY5MEZ6LzNibTZPVFdEakY3UWFZdVB2eXVUaVZa?=
 =?utf-8?B?S0dkNDk0ZkRmcG5hbVZ3cFlQRmVKRE9NTlF0MkFIaUVHanRxM2Z0UG1Lc2Q2?=
 =?utf-8?B?QmpzZUlQT3VhSDdjWUMvSTRtQVZWdFhpNXVWd1RtZ0RiR09tU0NaVVZtcWRX?=
 =?utf-8?B?bmdVelVwUlJnNVFZZk9iVVFZdWhFT0dub3pHT1Rray9EcmduRzBkenFEcXJm?=
 =?utf-8?B?bmdFd1VPcWNKQXVCQStMQml5Z1p1Y1B6Qnp6UUpiaUlVUm4wN3prQXpQYndU?=
 =?utf-8?B?K0hHQUl5LytiaytKT0pIdjNVdjNJSEdabjNkdmpsczQ0NWcxSGo2ekloUjhZ?=
 =?utf-8?B?M2QrR1dLazV5K3Zvb1pIWGRDNnd2S2UzamdYK2t5clRLU0ZWSnpxMlBjdnNE?=
 =?utf-8?B?dXRzbE5aT2l4cUpra1FFL2ZCbU8wRzFRa2c5TGZRb1JvUXlndjh3M2FjSlpi?=
 =?utf-8?Q?WYsTDY/MVT1fh35ke7roRjLGGX/jbGsc1zJsfmB5E7o+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D263D54F2260C4A882903242F4E2D50@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR07MB8408.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3befd79c-7fc5-4cf8-5a23-08dc41e1ce31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 15:42:06.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uY6oJUZLiknmqiIdpIJb70qu6v7/shc0rY8L0ru/Qe2nHtEHoy5IBpqF1KukybCdHvadOln2hjMfMz7EzciCWI3KumETJlMPMod/si2/2/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7242

LS0tIEFwb2xvZ2llcyBmb3IgbXVsdGlwbGUgcG9zdGluZ3MgLS0tIA0KDQoNCioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQpXU0NDIDIwMjQ6IEV1cm8tUGFyIDIwMjQg
SW50ZXJuYXRpb25hbCBXb3Jrc2hvcCBvbiBTY2FsYWJsZSBDb21wdXRlIENvbnRpbnV1bQ0KRGF0
ZTogMjYtMjcgQXVndXN0IDIwMjQNCkxvY2F0aW9uOiBNYWRyaWQsIFNwYWluDQpXb3Jrc2hvcCB3
ZWIgcGFnZTogaHR0cHM6Ly93c2NjLmRpLnVuaXBpLml0Lw0KRXVyby1QYXIgd2ViIHBhZ2U6IGh0
dHBzOi8vMjAyNC5ldXJvLXBhci5vcmcvDQoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKg0KDQoqIENhbGwgZm9yIFBhcGVycw0KVGhlIOKAnENvbXB1dGUgQ29udGludXVt
4oCdIHBhcmFkaWdtIHByb21pc2VzIHRvIG1hbmFnZSB0aGUgaGV0ZXJvZ2VuZWl0eSBhbmQgZHlu
YW1pc20gb2Ygd2lkZXNwcmVhZCBjb21wdXRpbmcgcmVzb3VyY2VzLCBhaW1pbmcgdG8gc2ltcGxp
ZnkgdGhlIGV4ZWN1dGlvbiBvZiBkaXN0cmlidXRlZCBhcHBsaWNhdGlvbnMgaW1wcm92aW5nIGRh
dGEgbG9jYWxpdHksIHBlcmZvcm1hbmNlLCBhdmFpbGFiaWxpdHksIGFkYXB0YWJpbGl0eSwgZW5l
cmd5IG1hbmFnZW1lbnQgYXMgd2VsbCBhcyBvdGhlciBub24tZnVuY3Rpb25hbCBmZWF0dXJlcy4g
VGhpcyBpcyBtYWRlIHBvc3NpYmxlIGJ5IG92ZXJjb21pbmcgcmVzb3VyY2UgZnJhZ21lbnRhdGlv
biBhbmQgc2VncmVnYXRpb24gaW4gdGllcnMsIGVuYWJsaW5nIGFwcGxpY2F0aW9ucyB0byBiZSBz
ZWFtbGVzc2x5IGV4ZWN1dGVkIGFuZCByZWxvY2F0ZWQgYWxvbmcgYSBjb250aW51dW0gb2YgcmVz
b3VyY2VzIHNwYW5uaW5nIGZyb20gdGhlIGVkZ2UgdG8gdGhlIGNsb3VkLiBCZXNpZGVzIGNvbnNv
bGlkYXRlZCB2ZXJ0aWNhbCBhbmQgaG9yaXpvbnRhbCBzY2FsaW5nIHBhdHRlcm5zLCB0aGlzIHBh
cmFkaWdtIGFsc28gb2ZmZXJzIG1vcmUgZGV0YWlsZWQgYWRhcHRhdGlvbiBhY3Rpb25zIHRoYXQg
c3RyaWN0bHkgZGVwZW5kIG9uIHRoZSBzcGVjaWZpYyBpbmZyYXN0cnVjdHVyZSBjb21wb25lbnRz
IChlLmcuLCB0byByZWR1Y2UgZW5lcmd5IGNvbnN1bXB0aW9uLCBvciB0byBleHBsb2l0IHNwZWNp
ZmljIGhhcmR3YXJlIHN1Y2ggYXMgR1BVcyBhbmQgRlBHQXMpLiBUaGlzIGVuYWJsZXMgdGhlIGVu
aGFuY2VtZW50IG9mIGxhdGVuY3ktc2Vuc2l0aXZlIGFwcGxpY2F0aW9ucywgdGhlIHJlZHVjdGlv
biBvZiBuZXR3b3JrIGJhbmR3aWR0aCBjb25zdW1wdGlvbiwgdGhlIGltcHJvdmVtZW50IG9mIHBy
aXZhY3kgcHJvdGVjdGlvbiwgYW5kIHRoZSBkZXZlbG9wbWVudCBvZiBub3ZlbCBzZXJ2aWNlcyBh
aW1lZCBhdCBpbXByb3ZpbmcgbGl2aW5nLCBoZWFsdGgsIHNhZmV0eSwgYW5kIG1vYmlsaXR5LiBB
bGwgb2YgdGhpcyBzaG91bGQgYmUgYWNoaWV2YWJsZSBieSBhcHBsaWNhdGlvbiBkZXZlbG9wZXJz
IHdpdGhvdXQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IGhvdyBhbmQgd2hlcmUgdGhlIGRldmVsb3Bl
ZCBjb21wb25lbnRzIHdpbGwgYmUgZXhlY3V0ZWQuIFRoZXJlZm9yZSwgdG8gdW5sZWFzaCB0aGUg
dHJ1ZSBwb3RlbnRpYWwgb2ZmZXJlZCBieSB0aGUgQ29tcHV0ZSBDb250aW51dW0sIHByb2FjdGl2
ZSwgYXV0b25vbW91cywgYW5kIGluZnJhc3RydWN0dXJlLWF3YXJlIG1hbmFnZW1lbnQgaXMgZGVz
aXJhYmxlLCBpZiBub3QgbWFuZGF0b3J5LCBjYWxsaW5nIGZvciBub3ZlbCBpbnRlcmRpc2NpcGxp
bmFyeSBhcHByb2FjaGVzIHRoYXQgZXhwbG9pdCBvcHRpbWl6YXRpb24gdGhlb3J5LCBjb250cm9s
IHRoZW9yeSwgbWFjaGluZSBsZWFybmluZywgYW5kIGFydGlmaWNpYWwgaW50ZWxsaWdlbmNlIG1l
dGhvZHMuDQoNCkluIHRoaXMgbGFuZHNjYXBlLCB0aGUgd29ya3Nob3AgaXMgd2lsbGluZyB0byBh
dHRyYWN0IGNvbnRyaWJ1dGlvbnMgaW4gdGhlIGFyZWEgb2YgZGlzdHJpYnV0ZWQgc3lzdGVtcyB3
aXRoIHBhcnRpY3VsYXIgZW1waGFzaXMgb24gc3VwcG9ydCBmb3IgZ2VvZ3JhcGhpY2FsbHkgZGlz
dHJpYnV0ZWQgcGxhdGZvcm1zIGFuZCBhdXRvbm9taWMgZmVhdHVyZXMgdG8gZGVhbCB3aXRoIHZh
cmlhYmxlIHdvcmtsb2FkcyBhbmQgZW52aXJvbm1lbnRhbCBldmVudHMsIGFuZCB0YWtlIHRoZSBi
ZXN0IG9mIGhldGVyb2dlbmVvdXMgYW5kIGRpc3RyaWJ1dGVkIGluZnJhc3RydWN0dXJlcy4gQSBw
YXJ0aWFsIGxpc3Qgb2YgaW50ZXJlc3RpbmcgdG9waWNzIG9mIHRoaXMgd29ya3Nob3AgaXMgdGhl
IGZvbGxvd2luZzoNCg0KLSBTY2FsYWJsZSBhcmNoaXRlY3R1cmVzIGFuZCBzeXN0ZW1zIGZvciBD
b21wdXRlIENvbnRpbnV1bQ0KLSBTeXN0ZW0gc29mdHdhcmUgZm9yIGNsb3VkLWVkZ2UtSW9UIG9y
Y2hlc3RyYXRpb24NCi0gRGlzdHJpYnV0ZWQgYW5kIGRlY2VudHJhbGl6ZWQgbWFuYWdlbWVudCBv
ZiByZXNvdXJjZXMgYW5kIGFwcGxpY2F0aW9uIGRlcGxveW1lbnQgaW4gdGhlIENvbXB1dGUgQ29u
dGludXVtDQotIFByb2dyYW1taW5nIG1vZGVscywgbGFuZ3VhZ2VzIGFuZCBwYXR0ZXJucyBmb3Ig
dGhlIENvbXB1dGUgQ29udGludXVtDQotIENvbXB1dGUgQ29udGludXVtIHBlcmZvcm1hbmNlIG1v
ZGVsaW5nIGFuZCBhbmFseXNpcw0KLSBGdW5jdGlvbi1hcy1hLVNlcnZpY2UgYW5kIEJhY2tlbmQt
YXMtYS1TZXJ2aWNlIGluIHRoZSBDb21wdXRlIENvbnRpbnV1bQ0KLSBFbmVyZ3ktZWZmaWNpZW50
IHNvbHV0aW9ucyBmb3Igc3VzdGFpbmFibGUgQ29tcHV0ZSBDb250aW51dW0NCi0gQUkgaW4gYW5k
IGZvciB0aGUgQ29tcHV0ZSBDb250aW51dW0NCi0gU2NhbGFibGUgYXBwbGljYXRpb25zIGZvciBD
b21wdXRlIENvbnRpbnV1bSAoSW9ULCBtaWNyb3NlcnZpY2VzLCBzZXJ2ZXJsZXNzKQ0KLSBEYXRh
LWludGVuc2l2ZSBhbmQgc3RyZWFtIHByb2Nlc3Npbmcgc3lzdGVtcyBhbmQgYXBwbGljYXRpb25z
IGluIHRoZSBDb21wdXRlIENvbnRpbnV1bQ0KLSBEaWdpdGFsIFR3aW5zIGFuZCBpbmR1c3RyeSBh
cHBsaWNhdGlvbnMgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQotIFByb3RvdHlwZXMgYW5kIHJl
YWwtbGlmZSBleHBlcmltZW50cyBpbnZvbHZpbmcgQ29tcHV0ZSBDb250aW51dW0NCi0gQmVuY2ht
YXJrcyBhbmQgZXhwZXJpbWVudGFsIHBsYXRmb3JtcyBmb3IgcmVwcm9kdWNpYmxlIGV4cGVyaW1l
bnRzIGluIHRoZSBDb21wdXRlIENvbnRpbnV1bQ0KDQoqIFN1Ym1pc3Npb24gSW5zdHJ1Y3Rpb25z
DQpUaGUgcGFwZXJzIHNob3VsZCBiZSBmb3JtYXR0ZWQgYWNjb3JkaW5nIHRvIHRoZSBMTkNTIGd1
aWRlbGluZXMuIFRoZXkgc2hvdWxkIGJlIGJldHdlZW4gYSBtaW5pbXVtIG9mIDEwIGFuZCBtYXhp
bXVtIG9mIDEyIHBhZ2VzLg0KDQoqIFNwZWNpYWwgSXNzdWUNClNlbGVjdGVkIHBhcGVycyB3aWxs
IGJlIGludml0ZWQgdG8gc3VibWl0IGFuIGV4dGVuZGVkIHZlcnNpb24gdG8gYSBKb3VybmFsIFNw
ZWNpYWwgSXNzdWUuIFdlIGFyZSBpbiBjb250YWN0IHRvIHByb3Bvc2UgYSBTcGVjaWFsIElzc3Vl
IGluIGEgaGlnaC1xdWFsaXR5IGpvdXJuYWwuIEluZm9ybWF0aW9uIHdpbGwgYXBwZWFyIHNvb24g
b24gdGhlIFdTQ0Mgd2ViIHNpdGUuDQoNCiogSW1wb3J0YW50IERhdGVzDQogIE1heSA2dGgsIDIw
MjQgICAgICAgUGFwZXIgc3VibWlzc2lvbiBkZWFkbGluZQ0KICBKdW5lIDE3dGgsIDIwMjQgICAg
UGFwZXIgYWNjZXB0YW5jZSBub3RpZmljYXRpb25zDQogIEp1bHkgMXN0LCAyMDI0ICAgICAgIENh
bWVyYS1yZWFkeSBkdWUNCg0KKiBXb3Jrc2hvcCBDby1DaGFpcnMNCi0gVmFsZXJpYSBDYXJkZWxs
aW5pLCBVbml2ZXJzaXR5IG9mIFJvbWUgVG9yIFZlcmdhdGEsIEl0YWx5DQotIFBhdHJpemlvIERh
enppLCAgICAgVW5pdmVyc2l0eSBvZiBQaXNhLCBJdGFseQ0KLSBHYWJyaWVsZSBNZW5jYWdsaSwg
IFVuaXZlcnNpdHkgb2YgUGlzYSwgSXRhbHkNCi0gTWF0dGVvIE5hcmRlbGxpLCAgICBCYW5rIG9m
IEl0YWx5LCBJdGFseQ0KLSBNYXNzaW1vIFRvcnF1YXRpLCAgIFVuaXZlcnNpdHkgb2YgUGlzYSwg
SXRhbHkNCg0KTG9va2luZyBmb3J3YXJkIHRvIHJlY2VpdmluZyB5b3VyIGV4Y2VsbGVudCBzdWJt
aXNzaW9ucyBzb29uLg0KDQpCZXN0IHJlZ2FyZHMsDQoNClZhbGVyaWEgQ2FyZGVsbGluaSwgUGF0
cml6aW8gRGF6emksIEdhYnJpZWxlIE1lbmNhZ2xpLCBNYXR0ZW8gTmFyZGVsbGksIGFuZCBNYXNz
aW1vIFRvcnF1YXRpDQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
CkFsYmVydG8gT3R0aW1vDQpQaEQgU3R1ZGVudA0KRGVwYXJ0bWVudCBvZiBDb21wdXRlciBTY2ll
bmNlDQpVbml2ZXJzaXR5IG9mIFBpc2EsIEl0YWx5DQpFLW1haWw6IGFsYmVydG8ub3R0aW1vQHBo
ZC51bmlwaS5pdA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
