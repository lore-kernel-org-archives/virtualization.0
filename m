Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A2158215
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744168; cv=fail; b=Owjv8UzJVrvASZkshv/7uqAYBRLemo4t29nwCMruwapFc7E55BRmvGR/tYzX9zw4aSMjZGSikjyr6arSfcQmz+KyyQAndChT40YNAWW6i5ck1kM+2NvWiQm2APnFRFEbWLZey4Z3Vs9MwxEI/0Vk4rdkqAB/yVhEuxpyVMHKziM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744168; c=relaxed/simple;
	bh=lcZEHv4LNtdDj51RS0N1IHSvEnHhIfAEvA5R2Bp2PBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzJyQUKNzvEzG2LSE3L/UM7fY3pNkmm6RayAiSYmyPml11GPW9SSoD6gaVbFWPCs9NoCCg1R/nc+cs9WoJWMtZBQ0Ed79mh4HzrUK2Wex91fY85W0pnHfUo3VLxPWlDpiAuCQcJorIpGgxSeRSzY2B7YltGoBLE3UyOdfZ6HO9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=M/XReDo9; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="M/XReDo9"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A9h3LV015614;
	Wed, 10 Apr 2024 03:15:41 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xdrc6gc9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4DJD5nfDm87upCfWdrLovLwWJA9VDIHsoViskcmQLvgHPya2QPm+JFuNbJil9Qpwq2VNaC0dPRG5MHLxtDvFTfQm3OSRsnEOnHLwRSfxaAgpLd3MZgjuNDDZ6H3zfgy9ZH8qlwxgAoYm/YkpnayvGtz+aol4oIcrwocJYYMnQYM4C4FZj47pF9z14jCNED2UqlAZSql3wW3lPuES9cV1YLAxfqQ/IBU3PuzyCT7ZEfB0xh6lGdy2A/3i8M2sZRxwuR5hkO1tglPyTZ4KkvdcQMpb4CsVznveXDPMRKvUmwP0+Z0+gj9dTI08fMh05sIq544UwbyZ3LbVmZsijSxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcZEHv4LNtdDj51RS0N1IHSvEnHhIfAEvA5R2Bp2PBo=;
 b=Y2VVemphMvUG0gWM+Ls36FirPrTgH0AqyPAcQ85l9B00ow0kjvhLojnqJRINVSjCozRnTwg53MAj5rmy9393/982+/6PDsOrlJwxD4MewtT/jblN1yJ1cRmbYMnCu6vcrgX/om2Tumf3wTmRIK3LhWC+CF8a8dw+WZpybs72UQt0zKyk/3P5K9I7/ukeKmymDoYSAVfftpOhWkDPV54CqP7a7B4q7IimJG0xwFLg5EhTNPzC9XW+OSj6VaePb/2fFdXmyEVm7ljNUC7xs6GgJiFCyVimrBGbacCV13gBurVn4/y2K1/PTo1Gj6O0vC1B4VLr+oW2jMKgdFBJGAJk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcZEHv4LNtdDj51RS0N1IHSvEnHhIfAEvA5R2Bp2PBo=;
 b=M/XReDo9hqgA2NactZ+b/BlvlqGsAfOoJBoZWrtq6dq3jgG3Mcndkvzp2ahQNlIdeeKwelWHbh6gw7BZBLdCXDZoWdmgNZgVcknHy2tH0ie5HytyX/D8O5NBxj9f8Y7porHcWds5q9Ih6DnE0IQu1AGHmyXD5iT9yH7qCXzxuQY=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by CH0PR18MB4179.namprd18.prod.outlook.com (2603:10b6:610:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 10:15:38 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 10:15:38 +0000
From: Srujana Challa <schalla@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, eperezma
	<eperezma@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Topic: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Index: AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQ
Date: Wed, 10 Apr 2024 10:15:37 +0000
Message-ID: 
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
In-Reply-To: 
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|CH0PR18MB4179:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /3eM2mkGsZP9MIgot+0lLRN7bEKyqIA1Y15/Xin1N+0xgxRMAeucFbGGG62Ta3PVFa3EF6JOW+jsScdfGiCBTqAaZXsHXuxIEYJi4Ek/+z7puwVBi4dJRd3b8b7LCEmhaFZecuq7rGsGGTTN3ZHfu5fqEn/Tc70hZRCb7oAoMV/nI0qwAT3aCPt9EgBnC2zDVvrlO7WxeUqpxNmeo0TFlE9IcFFZ1CF4bM8+h8DXXcEbLqKC0AORsNAJbvojnIfJTLuSS9CsW1+EVZx1/EqNuHAGPHIOQ9IvSK+bGdeuJVeoF9R/ZvOKeqH39UxG1dvj2yjUD8szpdBFoNNQ76y1B4lUDRZscDsHSeYtOeFRX5Gj6QbZ1EguDxrbJ/9JH3gJxKns1q7Ihr+Ufjh2H5TT8H0SV6VlFPBF9EHib6bZUmCL6Cz2EpLrm9WP/iFAzMFl5PKjj6I+NJcNLBCa3oU9ARSrxbzhUy9bt4ebbwNIxZ5dUqXXbo374Yb4grWQCYW/3Vl1KqCXS7FCWjmjeoZT9GAdp+D0v5Hw1g47U+dRUS9M8XTssy0Vd+sUyhl4Um0e2aWctgd0uOIq1BAv/Ds0LkL9UBjg6C2CBc9JRUTwKVnZPYsQYxaPTB3KhUXwut6NeRB1dtGKbU+fFmEM4fMJwcqkItSPlzL/pHpRNV3YTEI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHBrMkVhRjFNSlRZZ0c5T0dMdXNRTGI4bVdWYlM0cFVvVlJwdlFyc29XYk04?=
 =?utf-8?B?Q09pYTJaTk5uSmw5S2pEZVJLdGxhSjNNOVNrcXF4cmF0OUZyNHBockRlbkJB?=
 =?utf-8?B?NzVHQ29aZ3U4Q0NHd1cyMGJ4TUZXRk5NRW5Eblk3SVJOUmJvLy92VkhwRnBj?=
 =?utf-8?B?em9pSXZHbnVyeDhVcTg5a0Yvd0Z4VUdQUFNvSXlxb1p4ZnQ3dEo4TnFrTWxn?=
 =?utf-8?B?UERvSG4zSGN6cGJ6UWhza1lMM1ZxUHV4Qm1ZcHl4b2kyYitlZDNkNzUvNVJD?=
 =?utf-8?B?RzR6Z1NULzArNENYN1NQN253WElySnM2Z2thQUwrTDZ4YjYzU3N0b0VWbVpW?=
 =?utf-8?B?OUloTmdlaERSaXdWMncwbDZYZzVPYVpEYWVvaGwrRHVQZ2R0Tm4xNUJmekF1?=
 =?utf-8?B?V09Da3ZyUjhMQWs0a0k3eXpIbG9LTFlIRWdXZUJTTmhOZ3VtTTRlcEFtSWxz?=
 =?utf-8?B?WnA1SnRodU9YaExKL3VIdnVTMEtZdjI3WEprYVJyc052Zk83WTIvbjlSQjhT?=
 =?utf-8?B?Vmd5elR1VnpFUGxMT2NjVEJ5UzZmQUJFRndhMDR4Nlc2cE00WDMvbnNDeGtT?=
 =?utf-8?B?emhKSTJCQk5SdktpR1FleWp2blI0TWsvZlhRcXhTOGVsVGJTc1p3WC9nZHFH?=
 =?utf-8?B?a0lNekJLbzNobnBtdDdnbTFseXhCZHR4MHJ2Q3Bpd3h2cnBzcWF5ZkJ6RWpi?=
 =?utf-8?B?MUhrcDVYcEk5b0w1UEwrbEwvREswRWs0cU1jRmhTZElIQThLa0lBNGNCSUZs?=
 =?utf-8?B?eWFacDZMVS9kUEdGTXBmTGUxVWVJY2pMSWxydDdrZXg4SVZSQ0RTUlRsNU5Y?=
 =?utf-8?B?aThQWjJpSzlta3ErV1JBMnIzNGJaditkcXF0ZWs0VTRmb3lmVW8xM1F1TFhP?=
 =?utf-8?B?VldpMmxQVXA2QWw5NFpZWFZrUnQwbHFpUXZDSkdQdEdqNUNiWU5oWEpUSzhi?=
 =?utf-8?B?VE43a0tSTFdBVWN4aDlrVU5CVmp5VXJYcEVlTnY0MWxHenRYSEFBdW9FekVG?=
 =?utf-8?B?dU4yeHlXVkMxKzcvK0NrcnZWQVUwdHZ1TG1KZzdUZjExZC9rL3ErSHpLdE54?=
 =?utf-8?B?Z1FtU05vc2JmWjdaR0ozaEJ5TWRUeDFCWGJnS3dTcGcvQUxSeStxQUFUSmU1?=
 =?utf-8?B?ZmtnQzdjSWhuVzhad1ZNNy9Sb2JsUk8xTWNVSlVvaVRUblpPQ0dhNnpYd3Zh?=
 =?utf-8?B?NDVhSFNIK25rSCt6RE9lbzArS0FFN2FqSVNjTGhMaldHblNPVFpHWmFJVlR0?=
 =?utf-8?B?a09RSFJYM0t3azlycVRYWDlhTWpvSHBGNWxKeU9lNGJJODUweHVBNzQvWEJR?=
 =?utf-8?B?U2pBbG1RVk1zVEt3VHZGc1lVRk5KZ0tRNW83QlV2SGI1b1N0OVJUVGxmaEtH?=
 =?utf-8?B?TC9tSUdkQXBKd0NaVGllcHExMEhudnA5d20reE9OY01ZRUwwSUQxblJrdTZx?=
 =?utf-8?B?eUpDZEYyNWRXREFWMjZqUWNCTzYxN0hOWTNnNFc2MXNBUHVGTXJkUThmKzZp?=
 =?utf-8?B?TlhRV09WSmwrcjVTeWlMVG5icW91T2lGZHF1UzltQWd2c2JCWkVBT1VTUVJU?=
 =?utf-8?B?MkE2ZFJOUk5LM1oySkZ1NzZGM3BUWWdEZjJoODlxcVR0Y2FNZnRyc20wL3Bh?=
 =?utf-8?B?RTNiczl4alA5cGQ2bXA3UlA4dWJQV0orYUt5cEtCbThzTHlkVDZCYit6aXh4?=
 =?utf-8?B?aFVTQ1Ixc1IwbmpQcko0N251U0QwUk50WEN5ZElhQzI2Sk9NbnowUDdGN2RI?=
 =?utf-8?B?N0NkT0NYalVDb3dyWGVlY1FGS0NjSG4vT2FJb1RqeFIyaTBjU1RKd1BMcUZi?=
 =?utf-8?B?VnFvOWNsTjJac1VQU0pDTXdmZGlObzJOQVBBR1Q4djhRZlpKejZzL3NCV3Rs?=
 =?utf-8?B?RzdvdjZpMDM2Y0VOb285TjZabGJFUWI2V2hOQUt3dkRmRXEwRmZSV2lNaWM3?=
 =?utf-8?B?L0w1aDdmY3ZvYUhMNW5LYXBPUXJ3QklvZlhRMWphTEtTMUtvT0NpN1N3VklR?=
 =?utf-8?B?b2c1NE9rMGtVeWQ1Nmp6MFg5R3FzNis3dUdOZFIwMnl2d2hMR01kbTcwTERS?=
 =?utf-8?B?SlNVZDAzNUxyRWNsbnUvR293QlQvWVV3dzcyRTRmVFZQa3YvcXF5YUhVQk5z?=
 =?utf-8?Q?cwiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb1f98-75d1-445a-f42f-08dc59472b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 10:15:38.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5sKAWL5FL4zH0AIWpipGO8CrhvLJSj9Vai186HdhHmZzCLhMQbQ8edekbsCjpUGs/FUTztrRV1Y3xcurDvFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4179
X-Proofpoint-GUID: KDJqmkNuUlSd2Tax_XRoyhrKG6qqBP-O
X-Proofpoint-ORIG-GUID: KDJqmkNuUlSd2Tax_XRoyhrKG6qqBP-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02

PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3Jf
ZGV2KGRldik7DQo+ID4gPiA+ICsgICAgICAgaWYgKCFkb21haW4gfHwgZG9tYWluLT50eXBlID09
IElPTU1VX0RPTUFJTl9JREVOVElUWSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgZGV2X2lu
Zm8oZGV2LCAiTk8tSU9NTVVcbiIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgb2N0ZXBfdmRw
YV9vcHMuc2V0X21hcCA9IG9jdGVwX3ZkcGFfc2V0X21hcDsNCj4gPiA+DQo+ID4gPiBJcyB0aGlz
IGEgc2hvcnRjdXQgdG8gaGF2ZSBnZXQgYmV0dGVyIHBlcmZvcm1hbmNlPyBETUEgQVBJIHNob3Vs
ZCBoYXZlDQo+ID4gPiB0aG9zZSBncmVhY2VmdWxseSBJIHRoaW5rLg0KPiA+IFdoZW4gSU9NTVUg
aXMgZGlzYWJsZWQgb24gaG9zdCBhbmQgc2V0X21hcC9kbWFfbWFwIGlzIG5vdCBzZXQsDQo+ID4g
dmhvc3QtdmRwYSBpcyByZXBvcnRpbmcgYW4gZXJyb3IgIkZhaWxlZCB0byBhbGxvY2F0ZSBkb21h
aW4sIGRldmljZSBpcyBub3QNCj4gSU9NTVUgY2FjaGUgY29oZXJlbnQgY2FwYWJsZVxuIi4NCj4g
PiBIZW5jZSB3ZSBhcmUgZG9pbmcgdGhpcyB3YXkgdG8gZ2V0IGJldHRlciBwZXJmb3JtYW5jZS4N
Cj4gDQo+IFRoZSBwcm9ibGVtIGlzLCBhc3N1bWluZyB0aGUgZGV2aWNlIGRvZXMgbm90IGhhdmUg
YW55IGludGVybmFsIElPTU1VLg0KPiANCj4gMSkgSWYgd2UgYWxsb3cgaXQgcnVubmluZyB3aXRo
b3V0IElPTU1VLCBpdCBvcGVucyBhIHdpbmRvdyBmb3IgZ3Vlc3QNCj4gdG8gYXR0YWNrIHRoZSBo
b3N0Lg0KPiAyKSBJZiB5b3Ugc2VlIHBlcmZvcmFtbmNlIGlzc3VlIHdpdGggSU9NTVVfRE9NQUlO
X0lERU5USVRZLCBsZXQncw0KPiByZXBvcnQgaXQgdG8gRE1BL0lPTU1VIG1haW50aW5lciB0byBm
aXggdGhhdA0KSXQgd2lsbCBiZSBoZWxwZnVsIGZvciBob3N0IG5ldHdvcmtpbmcgY2FzZSB3aGVu
IGlvbW11IGlzIGRpc2FibGVkLiANCkNhbiB3ZSB0YWtlIHRoZSB2ZmlvIHBjaSBkcml2ZXIgYXBw
cm9hY2ggYXMgYSByZWZlcmVuY2Ugd2hlcmUgdXNlciBleHBsaWNpdGx5IHNldCANCiJlbmFibGVf
dW5zYWZlX25vaW9tbXVfbW9kZSIgdXNpbmcgbW9kdWxlIHBhcmFtPw0KDQo+IA0KPiBUaGFua3MN
Cg0KVGhhbmtzLg0KDQo=
