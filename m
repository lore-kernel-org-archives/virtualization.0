Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436D4F5E6
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915350; cv=fail; b=opwznNJzVkf6XCu4y6mtmmEuxEj3AkH00Nq36W/mI97+hmif/5RPZbUErzoSmMO+8LIIPUspysXd7y/dJBrkSbpFENbIPsuEq7eEQk06Xzzq7ZXQAA8H3ccK0OQFI0pgtPFjYbAuWX8xZX7NCtc/WLEXh+LhNEJy34qbaa4d0NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915350; c=relaxed/simple;
	bh=tS9RZk6uBtRoO3D5WAbRaoUdozJ+Jwgy4eT3TmlRvfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ys5oGWgGxg7GyXTRvz5EhC9WhrzIAhJq5oFsZc5TZrmlt+5AxHIImq3bWQ+I7DlPMzCG9lh029q/npSuljbtODc/E8e66KxkWtr36zRzTkI5jwC/Wm9ZtzGap9gP6nRqt+HGkrVXVzCEXDXw02H7uIwgGI9FXnCuWSrcH1YwUB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AoerY9o5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AoerY9o5"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4ADPt009071;
	Fri, 12 Apr 2024 02:49:03 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xewph11ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 02:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvBeYdgBctFHgdBAHniNlMpUpmSB2PzCEgYoXMJUKNbPsfT+T5Fw2j/arAajHus/6S7WQV16OFKutrSuFcC/oShZ+GcEsvtr4HnvHUnIh95ywbrFA/fl2OizDaXvs1mED5fDTU3VAmQNNr/SOpyTcD57u/0+hmra0HPD/hJA+3Axz4E80iIX/wQveMrBqJ3vbL+Z3BzwPQwChtNjA9jdr08J4ngHwoKcxvu/khYn8SRguvqaYkO4Hby0ZJtNZt47C+I25cSd50YlIaAPaIk4VvMA2mgENxHiw/xUbUgpJoDBC+I3/V+b/FHWtaZ15NYWz0bJ/9f+EuJUJk+oHUw8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS9RZk6uBtRoO3D5WAbRaoUdozJ+Jwgy4eT3TmlRvfQ=;
 b=ZZdiOcIpVRH74mnH8VYJyvqrauDOwUNs9N39urK6EDE8mtAmG5yDo2ZQIGwCksu+kxDxsJ4vBiKFMYIKFzeNDPYINQ/TtVi3OnNyZG7iJjW0heBf0FMPj9QHNN+7KNN99gsgPOwvWbcvu5D4S7jySAStIrlv1UX/UL6+6kHqIBzRxF5btDGPAeoqsCWwctx/gMujRg70qAmm02034may5sXqanf6gny+1JjOWcDoXcnKRWFVJvDU3T62NEMdUKwvfVVo0E/Oeaotqp971TcsIDb8COeMKZvg+1Xn0+iU5Il3X5ecUJo++WT33uVnJBLJVFBQRXjnh1WVQeRIud8rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS9RZk6uBtRoO3D5WAbRaoUdozJ+Jwgy4eT3TmlRvfQ=;
 b=AoerY9o5qok0NobrM7tpcCjdy9AKKjH9roVCeUz2tV4F0tOa1MrZ0C1ujWrpZ1dW7VrH6krr+uHvDhiEGWE+5/2S2uLAFXXMa0HhRaatNrYPLZnSK9dRr1QaEl+l8GHiw8pd0TNwmM0L4kH9o7cwC6gUkHwDQEVi5Wn7ZeCEclY=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by CH0PR18MB4274.namprd18.prod.outlook.com (2603:10b6:610:b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 09:48:59 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 09:48:58 +0000
From: Srujana Challa <schalla@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
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
Thread-Index: 
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kIABLXgAgAGCvNCAABqmgIAALTNQ
Date: Fri, 12 Apr 2024 09:48:58 +0000
Message-ID: 
 <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
 <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
In-Reply-To: 
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|CH0PR18MB4274:EE_
x-ms-office365-filtering-correlation-id: bf9f0b09-efc6-4954-a3c8-08dc5ad5c693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5EQT9tnrms6W3XGvHqIi0vZyPENB/M0CsXZydUZTzkX2dAAukyWdINXesufobc5wPfV8o2OhY4V5qXT3gdKJfph8hYn0SgqXkXf8wtSBOpNhGKCw9IOMXNmT6rVgpjR6aWf2jIvfOTEspz7pMsT1mz+HPwyMRK1WuBaqAkR4VGgJK9AosFHTsgfKuzPSZ7natgll/ZemJ8eOcmUmZLJMZBzVYTiQ2xkYXNrAuJ9bOWYHnS5LZbNzWoAOmf/Hz7cFvIdGjHZ4rYdk4utmgInrTMWHfpjJ2P+WN9zLuHh51K4kV3MoiByaVmMypbbiOO+YpOCZFpyvD3xShpw+MwvXZ/DDBI9yy5QANu3OLTo5DygBW3wA00kX+URFK2wdnoifsmBVYHdiGa88990eIwTDgOsPZ1xw54KHYQAwjPFP0+TPAmQ0uu7Ap8rnJjYfT483fzDmiQ1J466/zBJLcUU+LqLABet8kVgpsZfeiH5Ubep8401mydzsZEIVFlvUAJ24zXqCJc1jIBegwqqDIM8bQgZ+k+W1djcYkMRmGSy+VAybyXmJYsDsxGLofOxeJ8efRU1wD3HdhRjHFBtzYb8KIxdDIOGQNK0wLn5YuM7L3ooqiG3pyhK80OPu/Ex5d6DD6mS0tLvyOyk6j53T/im4b9yuu4jRNdAqyKdaQWpNX8ndiLp3w4l1M2lU0kCV31EFANVDDQxThLOnidZMPZxkPHpXS3XhZECAGKURwH9KQqY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K25MMk5SaHorTlArTEJBMHREZ3FzSFBZVFlzUVRFQmZMVkdrUlliN0V3VVB5?=
 =?utf-8?B?YndDR1ZZSi9ETkhsOG5tRDh5YXpxc3Nad2pKc3hqVGUxZDNub1JiWTNBOVJ6?=
 =?utf-8?B?WGhuL3JncWphVExQZUU0OS81YXRIKyt4cFVZVFp3ZWYwRFkzMVhtcDRKM3JU?=
 =?utf-8?B?dXp4SjE5dE5tL25oMmVMRFZGMEM0NFRTMjNMbVAxc3FZNW9SY1d6UWREeHc5?=
 =?utf-8?B?bmZZRnFqdTY1ZzhUb2J4Rjc5clY0Z3gyc3FIanRPVTRWWFNGK1lJNTAzenlo?=
 =?utf-8?B?cVJITXVaeTBTTTFjVUsvZ0FTejVDK0hDWXlCWXdibWEzVjhyZmxHc2JiUXlC?=
 =?utf-8?B?VTNNSkUyYVhRbU5PbFo4cGZxa0llUEJMdW9DcmJhejhFSFN2MjBlejJUakJB?=
 =?utf-8?B?b3lqaHNRN080TjgxK1pnQ2NuZWgxQkV0aDlkV3lxL0MwK0piQVh3cnU0elhv?=
 =?utf-8?B?d01KU2ZOdGNXcUI0SjRBMk5HMWFwelJ1aFhGcC9oZUZ1WXhCYmFLQVZFRFJK?=
 =?utf-8?B?YmNRR0s3SVVXajRUQUJLSGNzZFZ4Q2hrNFBDTU5ETDRKaW1aL2o4UFlOcXQx?=
 =?utf-8?B?cCtMZnNsdGdtcjNKUG92VzZRdlh5RGtBaXpRRGc0VHBjejdXRTVxNVZveC9S?=
 =?utf-8?B?dVhYc2hOTmZpZXpKVk1ZUGNXNWpxL0tuM2JmM3lJRkhCWFhqaE1UNmo3bkls?=
 =?utf-8?B?ZUdJaWp3cnFwQ2VzenNlM1c3bzBjaGY5M3pwa2FsQUUwUGJMSnNWWFUxc2Jp?=
 =?utf-8?B?WGpwQzdtbmkzQ0dVZytPbHFZRDFLemQ5UEl2am9qQXYwN3QrMzdKU2kwd2Vr?=
 =?utf-8?B?NEtQbmxRY1JaLzFJdm4yYlVSL1crK0wwUU1seFk2cTVzeUVhVXRQcnlSSGdJ?=
 =?utf-8?B?VjQ4SmswcnpZcS8xL2xjak51UmxJYktSd2d3cisrTkhBYlNRcVM2Zm5CNGxm?=
 =?utf-8?B?dTFYamJFcTRPY1dSNit3a3JUNndXOUhXL2I5TW5PazFjOXdIN0FPNGpNazdu?=
 =?utf-8?B?VUdWeGY3bldFVjhiSTBycDR2aElMbEIybTRtWHNIcVpvYkQvRWUyZy9CV3RK?=
 =?utf-8?B?Zi92ZlB4aDhjbVVERDNSTjhjOFZzRUdTekRVbEIzbDMrMzJWcXFwZDZWSmZs?=
 =?utf-8?B?VVdseUxJMlI3RXdlb0JwcXAzU3lWZnFvR0lPTFRWZ2l0MVY0UU5PQVZwSzhM?=
 =?utf-8?B?Y1VBOENqWmpWcWpybENFald0V3VtUVhhVEV1RE1OVHFqOGpKcktqTEZqMjhI?=
 =?utf-8?B?d0FoZ0prRVlQMU5iOGxTSnJ0YjBiOThSSkgyRW8va1NwOVpQT0JaQzdUSGEr?=
 =?utf-8?B?WlNYQ0ljaStLN08wUndBQVJwNTExY3RHbGFWMnpPcENMbzdSRHN1OHdsM3NZ?=
 =?utf-8?B?em9ZdjhxWEQwMWllM09RSHRDZ3ZLak12cEs4M0NERE12aXFqbjZ6eHMySHd4?=
 =?utf-8?B?MXZRUDRnYksxY0U4U1hlaWMySWsyNGJUWHBiK3JqdUxqU214SWQ4dTd1c1pV?=
 =?utf-8?B?SUEyWHh6NFpsUDRkNGFDbTFOU21YdkQ0TnFYVXJhWlZobk9LTGFGOGh1bnVT?=
 =?utf-8?B?dnpGVy9nUTJ0V25rNnc4SDdaMW5ORnhKdTlQSzRhSVJ2N01wTzhoZGFyNE1q?=
 =?utf-8?B?VzFseGJRN3ZkZkExWEt6dXR2TmI1eXB1KzBCdzZ0MGdJUzJzUGRsWjlaS3dp?=
 =?utf-8?B?RlRWQUFoaTRrUWVURmZEdjZpLzhIanVWYzE5WmoyaG45cFpUTHQybFFFc1Ru?=
 =?utf-8?B?TEFteGovVHphd2Nha240MlVhWVNHd1JBamlDY1oybGZsVjdCdWo5K3pxZjMv?=
 =?utf-8?B?OSswc1BYRXNjUDVBQk5hWU1ha1Fha1hhSy9mMWdwY2wzcHNFR3AvdU1YNEpS?=
 =?utf-8?B?eGt6TUd2bGhmZ3ZHWVlweFhGY3U5T28xcjRVR1BZMExMVkYrRWY2eG0zT25y?=
 =?utf-8?B?SzRlaFZubXJLZlpmQjBIc0JwREt4bzFSTkNjY05TRlo5bzh2Q1VyNllyMU81?=
 =?utf-8?B?ZzlUQkx0ZUI2VzVTcDZiaVk5RzFEZU8xUHNRMExKWWIxZEUrRTRHblFpVXdK?=
 =?utf-8?B?Um8xRXI2US9POTRQWFQwTnFsT1ZzWFVPK2RtMXc1ZkFkb3FMdE9BL1g5K2tv?=
 =?utf-8?Q?DrU/EbmJbJY5sdadwaVUh1AQD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9f0b09-efc6-4954-a3c8-08dc5ad5c693
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:48:58.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ice+F8psiB+cb+sUelpGVu8EGyacujcVSaPhMka5cwALvwePJN33wlamVvM/QOyGuE3OTL/16rxuL4TQkLANQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4274
X-Proofpoint-GUID: xADcTX9969wXWB3qmyzUvm9s1MTCbNJQ
X-Proofpoint-ORIG-GUID: xADcTX9969wXWB3qmyzUvm9s1MTCbNJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02

PiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSB2aXJ0aW86IHZkcGE6IHZEUEEg
ZHJpdmVyIGZvciBNYXJ2ZWxsDQo+IE9DVEVPTiBEUFUgZGV2aWNlcw0KPiANCj4gT24gRnJpLCBB
cHIgMTIsIDIwMjQgYXQgMToxM+KAr1BNIFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4g
U2VudDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDExOjMyIEFNDQo+ID4gPiBUbzogU3J1amFu
YSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+DQo+ID4gPiBDYzogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT47DQo+ID4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5k
ZXY7IHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOyBWYW1zaQ0KPiA+ID4gS3Jpc2huYSBBdHR1
bnVydSA8dmF0dHVudXJ1QG1hcnZlbGwuY29tPjsgU2hpaml0aCBUaG90dG9uDQo+ID4gPiA8c3Ro
b3R0b25AbWFydmVsbC5jb20+OyBOaXRoaW4gS3VtYXIgRGFiaWxwdXJhbQ0KPiA+ID4gPG5kYWJp
bHB1cmFtQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47DQo+
ID4gPiBlcGVyZXptYSA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBb
RVhURVJOQUxdIFJlOiBbUEFUQ0hdIHZpcnRpbzogdmRwYTogdkRQQSBkcml2ZXIgZm9yDQo+ID4g
PiBNYXJ2ZWxsIE9DVEVPTiBEUFUgZGV2aWNlcw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgQXByIDEw
LCAyMDI0IGF0IDg6MzXigK9QTSBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4N
Cj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxd
IFJlOiBbUEFUQ0hdIHZpcnRpbzogdmRwYTogdkRQQSBkcml2ZXINCj4gPiA+ID4gPiBmb3IgTWFy
dmVsbCBPQ1RFT04gRFBVIGRldmljZXMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFdlZCwgQXBy
IDEwLCAyMDI0IGF0IDEwOjE1OjM3QU0gKzAwMDAsIFNydWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgZG9tYWluID0g
aW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KGRldik7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgaWYgKCFkb21haW4gfHwgZG9tYWluLT50eXBlID09DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsg
SU9NTVVfRE9NQUlOX0lERU5USVRZKQ0KPiA+ID4gew0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAiTk8tSU9NTVVcbiIpOw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiArICAgICAgICAgICAgICAgb2N0ZXBfdmRwYV9vcHMuc2V0X21hcCA9DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgb2N0ZXBfdmRwYV9zZXRfbWFwOw0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiA+IElzIHRoaXMgYSBzaG9ydGN1dCB0byBoYXZlIGdldCBiZXR0ZXIgcGVyZm9y
bWFuY2U/IERNQQ0KPiA+ID4gPiA+ID4gPiA+ID4gQVBJIHNob3VsZCBoYXZlIHRob3NlIGdyZWFj
ZWZ1bGx5IEkgdGhpbmsuDQo+ID4gPiA+ID4gPiA+ID4gV2hlbiBJT01NVSBpcyBkaXNhYmxlZCBv
biBob3N0IGFuZCBzZXRfbWFwL2RtYV9tYXAgaXMgbm90DQo+ID4gPiA+ID4gPiA+ID4gc2V0LCB2
aG9zdC12ZHBhIGlzIHJlcG9ydGluZyBhbiBlcnJvciAiRmFpbGVkIHRvIGFsbG9jYXRlDQo+ID4g
PiA+ID4gPiA+ID4gZG9tYWluLCBkZXZpY2UgaXMgbm90DQo+ID4gPiA+ID4gPiA+IElPTU1VIGNh
Y2hlIGNvaGVyZW50IGNhcGFibGVcbiIuDQo+ID4gPiA+ID4gPiA+ID4gSGVuY2Ugd2UgYXJlIGRv
aW5nIHRoaXMgd2F5IHRvIGdldCBiZXR0ZXIgcGVyZm9ybWFuY2UuDQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IFRoZSBwcm9ibGVtIGlzLCBhc3N1bWluZyB0aGUgZGV2aWNlIGRvZXMgbm90
IGhhdmUgYW55DQo+ID4gPiA+ID4gPiA+IGludGVybmFsDQo+ID4gPiBJT01NVS4NCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gMSkgSWYgd2UgYWxsb3cgaXQgcnVubmluZyB3aXRob3V0IElP
TU1VLCBpdCBvcGVucyBhIHdpbmRvdw0KPiA+ID4gPiA+ID4gPiBmb3IgZ3Vlc3QgdG8gYXR0YWNr
IHRoZSBob3N0Lg0KPiA+ID4gPiA+ID4gPiAyKSBJZiB5b3Ugc2VlIHBlcmZvcmFtbmNlIGlzc3Vl
IHdpdGggSU9NTVVfRE9NQUlOX0lERU5USVRZLA0KPiA+ID4gPiA+ID4gPiBsZXQncyByZXBvcnQg
aXQgdG8gRE1BL0lPTU1VIG1haW50aW5lciB0byBmaXggdGhhdA0KPiA+ID4gPiA+ID4gSXQgd2ls
bCBiZSBoZWxwZnVsIGZvciBob3N0IG5ldHdvcmtpbmcgY2FzZSB3aGVuIGlvbW11IGlzIGRpc2Fi
bGVkLg0KPiA+ID4gPiA+ID4gQ2FuIHdlIHRha2UgdGhlIHZmaW8gcGNpIGRyaXZlciBhcHByb2Fj
aCBhcyBhIHJlZmVyZW5jZSB3aGVyZQ0KPiA+ID4gPiA+ID4gdXNlciBleHBsaWNpdGx5IHNldCAi
ZW5hYmxlX3Vuc2FmZV9ub2lvbW11X21vZGUiIHVzaW5nIG1vZHVsZQ0KPiBwYXJhbT8NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IHZmaW8gaXMgYSB1c2Vyc3BhY2UgZHJpdmVyIHNvIGl0J3MgdXNlcnNw
YWNlJ3MgcmVzcG9uc2liaWxpdHkuDQo+ID4gPiA+ID4gd2hhdCBleGFjdGx5IGVuc3VyZXMgY29y
cmVjdG5lc3MgaGVyZT8gZG9lcyB0aGUgZGV2aWNlIGhhdmUgYW4NCj4gPiA+ID4gPiBvbi1jaGlw
IGlvbW11Pw0KPiA+ID4gPiA+DQo+ID4gPiA+IE91ciBkZXZpY2UgZmVhdHVyZXMgYW4gb24tY2hp
cCBJT01NVSwgYWx0aG91Z2ggaXQgaXMgbm90IHV0aWxpemVkDQo+ID4gPiA+IGZvciBob3N0LXNp
ZGUgdGFyZ2V0ZWQgRE1BIG9wZXJhdGlvbnMuIFdlIGluY2x1ZGVkIG5vLWlvbW11IG1vZGUNCj4g
PiA+ID4gaW4gb3VyIGRyaXZlciB0byBlbnN1cmUgdGhhdCBob3N0IGFwcGxpY2F0aW9ucywgc3Vj
aCBhcyBEUERLDQo+ID4gPiA+IFZpcnRpbyB1c2VyIFBNRCwgY29udGludWUgdG8gZnVuY3Rpb24g
ZXZlbiB3aGVuIG9wZXJhdGluZyBpbiBhIG5vLQ0KPiBJT01NVSBtb2RlLg0KPiA+ID4NCj4gPiA+
IEkgbWF5IG1pc3Mgc29tZXRoaW5nIGJ1dCBzZXRfbWFwKCkgaXMgZW1wdHkgaW4gdGhpcyBkcml2
ZXIuIEhvdw0KPiA+ID4gY291bGQgc3VjaCBpc29sYXRpb24gYmUgZG9uZT8NCj4gPg0KPiA+IElu
IG5vLWlvbW11IGNhc2UsIHRoZXJlIHdvdWxkIGJlIG5vIGRvbWFpbiByaWdodCwgYW5kIHRoZSB1
c2VyIG9mDQo+ID4gdmhvc3QtdmRwYShEUERLIHZpcnRpbyB1c2VyIHBtZCksIHdvdWxkIGNyZWF0
ZSB0aGUgbWFwcGluZyBhbmQgcGFzcw0KPiA+IHRoZSBQQSAoPSBJT1ZBKSB0byB0aGUgZGV2aWNl
IGRpcmVjdGx5LiBTbyB0aGF0LCBkZXZpY2UgY2FuIGRpcmVjdGx5IERNQSB0byB0aGUNCj4gUEEu
DQo+IA0KPiBZZXMsIGJ1dCB0aGlzIGRvZXNuJ3QgZGlmZmVyIHRvbyBtdWNoIGZyb20gdGhlIGNh
c2Ugd2hlcmUgRE1BIEFQSSBpcyB1c2VkDQo+IHdpdGggSU9NTVUgZGlzYWJsZWQuDQo+IA0KPiBB
cmUgeW91IHNheWluZyBETUEgQVBJIGludHJvZHVjZXMgb3ZlcmhlYWRzIGluIHRoaXMgY2FzZT8N
Ck5vIGFjdHVhbGx5LCBjdXJyZW50IHZob3N0LXZkcGEgY29kZSBpcyBub3QgYWxsb3dpbmcgSU9N
TVUgZGlzYWJsZWQgbW9kZSwNCklmIHNldF9tYXAvZG1hX21hcCBvcCBpcyBub3Qgc2V0LiBIZW5j
ZSwgd2UgYXJlIHNldHRpbmcgc2V0X21hcCB3aXRoIGR1bW15DQphcGkgdG8gYWxsb3cgSU9NTVUg
ZGlzYWJsZWQgbW9kZS4NCg0KRm9sbG93aW5nIGlzIHRoZSBjb2RlIHNuaXBwZXQgZnJvbSBkcml2
ZXJzL3Zob3N0L3ZkcGEuYw0KDQogICAgICAvKiBEZXZpY2Ugd2FudCB0byBkbyBETUEgYnkgaXRz
ZWxmICovDQogICAgICAgIGlmIChvcHMtPnNldF9tYXAgfHwgb3BzLT5kbWFfbWFwKQ0KICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KDQogICAgICAgIGJ1cyA9IGRtYV9kZXYtPmJ1czsNCiAgICAg
ICAgaWYgKCFidXMpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7ICANCg0KICAgICAg
IGlmICghZGV2aWNlX2lvbW11X2NhcGFibGUoZG1hX2RldiwgSU9NTVVfQ0FQX0NBQ0hFX0NPSEVS
RU5DWSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCg0KUGVyZm9ybWFuY2Ug
ZGVncmFkYXRpb24gd2hlbiBpb21tdSBlbmFibGVkIGlzIG5vdCB3aXRoIERNQSBBUEkgYnV0IHRo
ZSB4ODYgSFcgSU9NTVUNCnRyYW5zbGF0aW9uIHBlcmZvcm1hbmNlIG9uIGNlcnRhaW4gbG93IGVu
ZCB4ODYgbWFjaGluZXMuDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4g
V2Ugb2JzZXJ2ZWQgcGVyZm9ybWFuY2UgaW1wYWN0cyBvbiBjZXJ0YWluIGxvdy1lbmQgeDg2IG1h
Y2hpbmVzDQo+ID4gPiA+IHdoZW4gSU9NTVUgbW9kZSB3YXMgZW5hYmxlZC4NCj4gPiA+ID4gSSB0
aGluaywgY29ycmVjdG5lc3MgaXMgSG9zdCB1c2Vyc3BhY2UgYXBwbGljYXRpb24ncw0KPiA+ID4g
PiByZXNwb25zaWJpbGl0eSwgaW4gdGhpcyBjYXNlIHdoZW4gdmhvc3QtdmRwYSBpcyB1c2VkIHdp
dGggSG9zdA0KPiA+ID4gPiBhcHBsaWNhdGlvbiBzdWNoIGFzIERQREsNCj4gPiA+IFZpcnRpbyB1
c2VyIFBNRC4NCj4gPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoYW5r
cy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4NCg0K
