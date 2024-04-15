Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50574424
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184959; cv=fail; b=gHXGu6Kp4cY2WxGNnNHxWKmxc89wWvuxOyJ8kepVkqDYP/8i2fSs6Rz/yaKqB7+8eZKhBMPpAOQ2FIPVqVPcRpCG0g8EsKukeX1PCw0AL0hyePTNoZ5hgHe8QYSkNLgObhI8INAYan9j1yDpFenKlALPhGLwYnP/r+CabKz2Dfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184959; c=relaxed/simple;
	bh=tSXrP8hrUkBUKzX9XXOlWJO7tLhr/gWb9KSOeI+Vwz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ss+iozq0UoXJ2Xj2SZTGMeGvdR5HuYVkEthfLP78r+L2Km5upmvea4Mh6MccF9UQdeKzPxRiD8n+kwRt6OgBuKSTv1XOaXNnkZeJd5rqDKEbX2RfG8IpAwfk1AR6jxqEOaQ5BAsKNNe/VW6dZgt4+IRfFoygE+/Qxlrt92sRtHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IahkcItU; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IahkcItU"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FBq3eL004173;
	Mon, 15 Apr 2024 05:42:28 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg4ftx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml4wSPKo2Lknsha7KaAosdWEgdtIBfhzPjH+mhE+OLB8BLiH0X1tkB5tjcihHWv/RKsU7wzTZoelkiwn4nr/jM2/9jUbmF+GgnPMcuOBaKfd8m1Fz+9efgZE3iCDu+9aKnTi1GcXoIBOnyB6F7kD2mqo8myg6CF9RgrwVvxbUz2GwN5BviPMDGi+knCkv3HpRtSqwJCyIZRE5rtyOwznlY9QfmwttIB6eITLu6cDJFVRyL6gebPLBqsQ3tWSJFGx+iCz9NEZl6QlSdIpKxGNstPq9kqbEKNXyERC/AI2Y6jbXQJwsKAUkxRyUOxdsvXgQQyi8Q3hKMZKeLwJ7VixYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSXrP8hrUkBUKzX9XXOlWJO7tLhr/gWb9KSOeI+Vwz8=;
 b=TNCSo0H7vS14Bv0bvL/itykiEvm+wbXAin3WYuj+SNzIC2YktbmqQEEiVNszplhGr1UYU7J6juVeFZvjwDFBA3oXBGSYxEZk6mrUEHYKGd3+oVgRQLHsrCKkN0t4/4qG/n6wQO0v0pHjph01tWtFw1ogYMSSjbO4udcEiXuC4p+L4k+zu1LAoe+NzvBb6zNZHLxeFu9t/PmQkqwYXY8AaPg5d0HesDn54pdbh0SFWX35AIIDtsl2xuvVwUOYtk5tz1LTY1clydFBj0WJKgFtnz+swARcufL40qQnOwCMCaaiN9AwYXK7983S4CvZUG4UL/23hNVVAzvV+bWgzxQU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSXrP8hrUkBUKzX9XXOlWJO7tLhr/gWb9KSOeI+Vwz8=;
 b=IahkcItUWTd8W0mzQJuNE3BAiHA0whBHaX/tVLEl6T7Q1h0Cilu9k6/LobLu/6eZ8JaWocm91IQK7CuQmdFrsYRapkQzLJuJ/sgeSP1FqTXbG6pgdjhFowbL+6mXcX0TmW/F8QkOk7EU6iDTU9jcRhcanq4k92sWwtNGomHwkUI=
Received: from PH7PR18MB5354.namprd18.prod.outlook.com (2603:10b6:510:24d::11)
 by SJ0PR18MB3833.namprd18.prod.outlook.com (2603:10b6:a03:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:42:13 +0000
Received: from PH7PR18MB5354.namprd18.prod.outlook.com
 ([fe80::9d9:2372:b211:483e]) by PH7PR18MB5354.namprd18.prod.outlook.com
 ([fe80::9d9:2372:b211:483e%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 12:42:13 +0000
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
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kIABLXgAgAGCvNCAABqmgIAALTNQgASL+ACAAFOSAA==
Date: Mon, 15 Apr 2024 12:42:13 +0000
Message-ID: 
 <PH7PR18MB535426965C489176FA9D8281A0092@PH7PR18MB5354.namprd18.prod.outlook.com>
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
 <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com>
In-Reply-To: 
 <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5354:EE_|SJ0PR18MB3833:EE_
x-ms-office365-filtering-correlation-id: aa123c6e-7d21-4ae1-f291-08dc5d4979a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F4mx993SYeTqNVB3wWW/m+KvhxHiWRtiC5KCQYN7FiciSjrWICfPv0XzvMmEpIqc2aCiXGqvfjzmRKK4O6msZmBaZOa66C2Cpp8EUMsQ0YQxYQgRDa8z1bb3lPprJuCMTZLCVYDHNkJ3gH3xBsxGLzKrwLAR1cPfAhqPGJfkp3sFVNlF6LqiTQCOtJnzCRC+Z+KQbQgsVkxolKs6CILpbjpePy/hMhjstMC2ZxwwbpcXBkiCURSrY8tIDPrFkQIqn65ZzSXQ4OXGYHrufslk/n3wTenICm0i5PO9CPkWo6qHe3PcRQemNpfEhRf+OGsDe1hOXfJyCHrZcJxNJ9STYbSKMlRmwlvssdmP6tO64CxXrPVUOEMpkBIWfFbBa5yJuSSjREQcku4j6U6tQRl7PNzPAq/34H9u08bLF6gpnh+XMAb0o704F7BCOKUAfr+dCOcHaD7jcRtUbGEEfPBiKPAmSYps7Rv8YIQx7Ic+OL82fU8+/BJNs9G+JX3XRbvn8GOb8P3r37MvnOvIUrIIrBargX71EG7PPh46IqdTjn3Q9bMXcpPGOfGjQFbF4h7bUdgad9rC6eL3tAdG/D3ygqELoqtZ5eiLioTF+nO8/rGFkoOATAjEj6jPBmHSA8nYy8AS+GuPNpMkOZKOQ+QAy6jLr0v/h19nhcfVuXxJAYAWaCF4KLiHRBBR5Ua84rGSHZFtLXLbhTYQcDLLVTXpOGRPWfaOB0tSiv6DBFypUTY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR18MB5354.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVl0U0F3Q1U4eCtDTHN3NEVuTDZkUU9RMm0yam84VUJDVnRybjE0RW85U205?=
 =?utf-8?B?UzNwZzcvajE0WERMdEwwaEoxOWFpN1l1Z2FhbHZ5NGE5ZGtrZURZRDFkejhT?=
 =?utf-8?B?L3d4Zlg0SjFFQ0xrMG56Rzd5YndWZHFWQlRpVk85YzdBZ3NNb3Zid1lhdWtw?=
 =?utf-8?B?YjdkcEpMdUJKOWRmcmFVc3p1ZEErVlRqeHozUVBlb3BOUXU5TVo5RVFaekhw?=
 =?utf-8?B?L3pVTjRSd3Fta2gzWVMyc0U4Y2NxQnBVazFESzVMUjE5WkZoS200SFJDa2Fs?=
 =?utf-8?B?Vnp6bU1Nc3FuYmF5Uzc3bmNxK01EU3NqK2t5US9pS3ZkcXh0ZzhYVXFBR2cw?=
 =?utf-8?B?Wmx0dWpMbGh4dnBlanIzd2xWQTA5c2hoZEFjVm1YY2EwRjlYSk9OVVFpdGZE?=
 =?utf-8?B?N24vaWs0V2g5bUM5Y2J0Q1hkd3paRmliT0xtcmJJSUk5czNkeEpRVGx1ZWwy?=
 =?utf-8?B?ZEd3VjQ1dnhZLzYxZmNKMWFWZkNoOW5Ed21oSGRBaXUwLzVjM3hETDNPUXBN?=
 =?utf-8?B?dFdhck1wMk5nNjd0eDZlYjJObG42RzBqVks5VlMrU1luMnpjM3ZzbmlNa21X?=
 =?utf-8?B?a3UzZnJvR0c1OEkza25JanFCTndaVnVtNWxsZDFoUHJKNzQrK05kR3Q1aXlz?=
 =?utf-8?B?ck9haFMxbXN6V3I2elFQcnRyTWF5V2tsQU5pYktkdkhiYzZQbFdNQ2NPZjkx?=
 =?utf-8?B?d25pTTlUWmM0RzlkT0tTcjZwZkltSTJNVHJscGZQNlIzd3FCMFhDZFpSSFBu?=
 =?utf-8?B?YnFiWFBaSlZmeUpvQmttMGpkOEplQyszUU96T2p6UUxNRTZSOFhzU3d1c1gr?=
 =?utf-8?B?S0ZQQ3VZZzhTMmdiRWw2WFBJcUdrRDQvRUJXRDlzU3JKQUtxb1RwMTU5dHov?=
 =?utf-8?B?VllIWDBDWFNRMWVCaStFWi8yK1drYjBITVZuU2RkTXEvVVpLY29POUU5SVBL?=
 =?utf-8?B?QUtET0JEKzZwQVh1cUVrRHdKQWdYdGFMUFVyVHZRSEFEUVpnWjBKUEEzazht?=
 =?utf-8?B?bFBuYzRnYVphSmV1bDRkdnhzS0xXL0RTZkltSDM0VHRrY2NqMFdCNkxNc2JJ?=
 =?utf-8?B?YW5hMTYxalR3ZzI0eDR5ZUFjTng0N1dteEIwalRKSldkbkU4VHJTZlBnM2lu?=
 =?utf-8?B?M2VKYWxwMWxKWFhidFo4MEJHL3NpYlhyWFpxL2xYT2plS2VyMnc4eE9ZbTY3?=
 =?utf-8?B?R0x3bnpBMld3d3ZGdTZNVTdXNzRJNU5hMS9CTzZuZG5DTytCUmdnRDlqbnlP?=
 =?utf-8?B?OFJxeFF0dGdDbUl0OTVOYWtTR1hobmNudE5tNjcwS1JCc1lOcTY4ZjMrUE56?=
 =?utf-8?B?bkxnNSttck14a1BuVXNqL3ZuVkM5TGpPb1VpYmdoQ2dDTGFGcDd0TGRCSzBN?=
 =?utf-8?B?MFlIbjN0QmxjL0JSZEQ2ZHpSbUExMnRNUWZJNDFyNlo5ZEtQQmFWZUQ2VEZl?=
 =?utf-8?B?d3hRTTJVRXVaN2Z2VG51d1lNU0hCYVlpdmRCMTd2bWdOV0dFN2ZJZ2Jic1hO?=
 =?utf-8?B?TlNLSXBpOEU2OVU2eldXN094dmhXS1Jxc1VJTTZYR1p5ODFNK2lBOER0ejdC?=
 =?utf-8?B?TUxNekROT20wS2ZxTHFsNWJtR29QM2tVNjBWQlJTc0VqSCtKaVpBeHJ0RWpX?=
 =?utf-8?B?TU4rZS9tQW1aeVpSaHZFS1puWk1DMGtCOHNIN1VzbGhjTVBPT2pFMFpJempw?=
 =?utf-8?B?ZlYrSGtteGo3c0NrNGl5bTVTd2pRUjFJb3prWEVSUnRHWnZsUG91NE9IbUdv?=
 =?utf-8?B?QnB2OHBTQU5VZ3pPSUVqSDlTOFYxZEFKZ2NhRUdMcW9XYUJvcFRsNzU3SDFu?=
 =?utf-8?B?alVtQzJEV21vb0FBYmEvaSt0UlAwY3QvNFBWelh4MTlsdVJncmdQTElSRStS?=
 =?utf-8?B?RWRWQVVBNnJjR2N3STNZMGFMM1FFbHhqWWJHVjYvZXpYUmQvVlBDTnFGTlFM?=
 =?utf-8?B?MWNjNXU0Y2Q4TS9Rd3EzMll6UW5ibjZrNmV6MDN0ZTB0NWltVDZLekZoZFpx?=
 =?utf-8?B?QnlSVmM0dGl4aFBwanFKbElxYkZGL0N6VVZuOFUyUGU1dVZUUWtUMkdEWm9I?=
 =?utf-8?B?ZWhxZnllYnN1d2xEMElnbHc2V2MzYzM0Y09sRHdJbCszZWNwcGRrSzRWNUU4?=
 =?utf-8?Q?A4AGnwSfe3WQPObnHFCo6/UZX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5354.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa123c6e-7d21-4ae1-f291-08dc5d4979a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:42:13.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Rn6fOOP96B3PFjnaj2fjxm4RzhZYwoXCN2J2xf84ZFFRIVMczqOF2JnKLnW7ZqJe1ZEXAPyTnjPp9eBInIo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3833
X-Proofpoint-GUID: cPNkSCzPERC4-ZT77Sh9-2-MHQqJR91H
X-Proofpoint-ORIG-GUID: cPNkSCzPERC4-ZT77Sh9-2-MHQqJR91H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_10,2024-04-15_01,2023-05-22_02

PiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSB2aXJ0aW86IHZkcGE6IHZEUEEg
ZHJpdmVyIGZvciBNYXJ2ZWxsDQo+IE9DVEVPTiBEUFUgZGV2aWNlcw0KPiANCj4gT24gRnJpLCBB
cHIgMTIsIDIwMjQgYXQgNTo0OeKAr1BNIFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRD
SF0gdmlydGlvOiB2ZHBhOiB2RFBBIGRyaXZlciBmb3INCj4gPiA+IE1hcnZlbGwgT0NURU9OIERQ
VSBkZXZpY2VzDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBBcHIgMTIsIDIwMjQgYXQgMToxM+KAr1BN
IFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiA+
ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDExOjMyIEFNDQo+ID4gPiA+ID4gVG86
IFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwuY29tPg0KPiA+ID4gPiA+IENjOiBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsNCj4gPiA+ID4gPiB2aXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC5kZXY7IHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOw0KPiA+ID4gPiA+
IFZhbXNpIEtyaXNobmEgQXR0dW51cnUgPHZhdHR1bnVydUBtYXJ2ZWxsLmNvbT47IFNoaWppdGgg
VGhvdHRvbg0KPiA+ID4gPiA+IDxzdGhvdHRvbkBtYXJ2ZWxsLmNvbT47IE5pdGhpbiBLdW1hciBE
YWJpbHB1cmFtDQo+ID4gPiA+ID4gPG5kYWJpbHB1cmFtQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFj
b2IgPGplcmluakBtYXJ2ZWxsLmNvbT47DQo+ID4gPiA+ID4gZXBlcmV6bWEgPGVwZXJlem1hQHJl
ZGhhdC5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0g
dmlydGlvOiB2ZHBhOiB2RFBBIGRyaXZlcg0KPiA+ID4gPiA+IGZvciBNYXJ2ZWxsIE9DVEVPTiBE
UFUgZGV2aWNlcw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBBcHIgMTAsIDIwMjQgYXQg
ODozNeKAr1BNIFNydWphbmEgQ2hhbGxhDQo+ID4gPiA+ID4gPHNjaGFsbGFAbWFydmVsbC5jb20+
DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBS
ZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSB2aXJ0aW86IHZkcGE6IHZEUEENCj4gPiA+ID4gPiA+
ID4gZHJpdmVyIGZvciBNYXJ2ZWxsIE9DVEVPTiBEUFUgZGV2aWNlcw0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiBPbiBXZWQsIEFwciAxMCwgMjAyNCBhdCAxMDoxNTozN0FNICswMDAwLCBT
cnVqYW5hIENoYWxsYSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICsgICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2
KGRldik7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIGlmICghZG9tYWluIHx8IGRv
bWFpbi0+dHlwZSA9PQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyBJT01NVV9ET01BSU5fSURF
TlRJVFkpDQo+ID4gPiA+ID4gew0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGRldl9pbmZvKGRldiwgIk5PLUlPTU1VXG4iKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICBvY3RlcF92ZHBhX29wcy5zZXRfbWFwID0NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgb2N0ZXBfdmRwYV9zZXRfbWFwOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXMgdGhpcyBhIHNob3J0Y3V0IHRvIGhhdmUgZ2V0IGJldHRl
ciBwZXJmb3JtYW5jZT8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBETUEgQVBJIHNob3VsZCBoYXZl
IHRob3NlIGdyZWFjZWZ1bGx5IEkgdGhpbmsuDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gSU9N
TVUgaXMgZGlzYWJsZWQgb24gaG9zdCBhbmQgc2V0X21hcC9kbWFfbWFwIGlzDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IG5vdCBzZXQsIHZob3N0LXZkcGEgaXMgcmVwb3J0aW5nIGFuIGVycm9yICJGYWls
ZWQgdG8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gYWxsb2NhdGUgZG9tYWluLCBkZXZpY2UgaXMgbm90
DQo+ID4gPiA+ID4gPiA+ID4gPiBJT01NVSBjYWNoZSBjb2hlcmVudCBjYXBhYmxlXG4iLg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiBIZW5jZSB3ZSBhcmUgZG9pbmcgdGhpcyB3YXkgdG8gZ2V0IGJldHRl
ciBwZXJmb3JtYW5jZS4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBUaGUg
cHJvYmxlbSBpcywgYXNzdW1pbmcgdGhlIGRldmljZSBkb2VzIG5vdCBoYXZlIGFueQ0KPiA+ID4g
PiA+ID4gPiA+ID4gaW50ZXJuYWwNCj4gPiA+ID4gPiBJT01NVS4NCj4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiAxKSBJZiB3ZSBhbGxvdyBpdCBydW5uaW5nIHdpdGhvdXQgSU9N
TVUsIGl0IG9wZW5zIGENCj4gPiA+ID4gPiA+ID4gPiA+IHdpbmRvdyBmb3IgZ3Vlc3QgdG8gYXR0
YWNrIHRoZSBob3N0Lg0KPiA+ID4gPiA+ID4gPiA+ID4gMikgSWYgeW91IHNlZSBwZXJmb3JhbW5j
ZSBpc3N1ZSB3aXRoDQo+ID4gPiA+ID4gPiA+ID4gPiBJT01NVV9ET01BSU5fSURFTlRJVFksIGxl
dCdzIHJlcG9ydCBpdCB0byBETUEvSU9NTVUNCj4gPiA+ID4gPiA+ID4gPiA+IG1haW50aW5lciB0
byBmaXggdGhhdA0KPiA+ID4gPiA+ID4gPiA+IEl0IHdpbGwgYmUgaGVscGZ1bCBmb3IgaG9zdCBu
ZXR3b3JraW5nIGNhc2Ugd2hlbiBpb21tdSBpcyBkaXNhYmxlZC4NCj4gPiA+ID4gPiA+ID4gPiBD
YW4gd2UgdGFrZSB0aGUgdmZpbyBwY2kgZHJpdmVyIGFwcHJvYWNoIGFzIGEgcmVmZXJlbmNlDQo+
ID4gPiA+ID4gPiA+ID4gd2hlcmUgdXNlciBleHBsaWNpdGx5IHNldCAiZW5hYmxlX3Vuc2FmZV9u
b2lvbW11X21vZGUiDQo+ID4gPiA+ID4gPiA+ID4gdXNpbmcgbW9kdWxlDQo+ID4gPiBwYXJhbT8N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gdmZpbyBpcyBhIHVzZXJzcGFjZSBkcml2ZXIg
c28gaXQncyB1c2Vyc3BhY2UncyByZXNwb25zaWJpbGl0eS4NCj4gPiA+ID4gPiA+ID4gd2hhdCBl
eGFjdGx5IGVuc3VyZXMgY29ycmVjdG5lc3MgaGVyZT8gZG9lcyB0aGUgZGV2aWNlIGhhdmUNCj4g
PiA+ID4gPiA+ID4gYW4gb24tY2hpcCBpb21tdT8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IE91ciBkZXZpY2UgZmVhdHVyZXMgYW4gb24tY2hpcCBJT01NVSwgYWx0aG91Z2ggaXQgaXMgbm90
DQo+ID4gPiA+ID4gPiB1dGlsaXplZCBmb3IgaG9zdC1zaWRlIHRhcmdldGVkIERNQSBvcGVyYXRp
b25zLiBXZSBpbmNsdWRlZA0KPiA+ID4gPiA+ID4gbm8taW9tbXUgbW9kZSBpbiBvdXIgZHJpdmVy
IHRvIGVuc3VyZSB0aGF0IGhvc3QgYXBwbGljYXRpb25zLA0KPiA+ID4gPiA+ID4gc3VjaCBhcyBE
UERLIFZpcnRpbyB1c2VyIFBNRCwgY29udGludWUgdG8gZnVuY3Rpb24gZXZlbiB3aGVuDQo+ID4g
PiA+ID4gPiBvcGVyYXRpbmcgaW4gYSBuby0NCj4gPiA+IElPTU1VIG1vZGUuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgc2V0X21hcCgpIGlzIGVtcHR5IGlu
IHRoaXMgZHJpdmVyLiBIb3cNCj4gPiA+ID4gPiBjb3VsZCBzdWNoIGlzb2xhdGlvbiBiZSBkb25l
Pw0KPiA+ID4gPg0KPiA+ID4gPiBJbiBuby1pb21tdSBjYXNlLCB0aGVyZSB3b3VsZCBiZSBubyBk
b21haW4gcmlnaHQsIGFuZCB0aGUgdXNlciBvZg0KPiA+ID4gPiB2aG9zdC12ZHBhKERQREsgdmly
dGlvIHVzZXIgcG1kKSwgd291bGQgY3JlYXRlIHRoZSBtYXBwaW5nIGFuZA0KPiA+ID4gPiBwYXNz
IHRoZSBQQSAoPSBJT1ZBKSB0byB0aGUgZGV2aWNlIGRpcmVjdGx5LiBTbyB0aGF0LCBkZXZpY2Ug
Y2FuDQo+ID4gPiA+IGRpcmVjdGx5IERNQSB0byB0aGUNCj4gPiA+IFBBLg0KPiA+ID4NCj4gPiA+
IFllcywgYnV0IHRoaXMgZG9lc24ndCBkaWZmZXIgdG9vIG11Y2ggZnJvbSB0aGUgY2FzZSB3aGVy
ZSBETUEgQVBJIGlzDQo+ID4gPiB1c2VkIHdpdGggSU9NTVUgZGlzYWJsZWQuDQo+ID4gPg0KPiA+
ID4gQXJlIHlvdSBzYXlpbmcgRE1BIEFQSSBpbnRyb2R1Y2VzIG92ZXJoZWFkcyBpbiB0aGlzIGNh
c2U/DQo+ID4gTm8gYWN0dWFsbHksIGN1cnJlbnQgdmhvc3QtdmRwYSBjb2RlIGlzIG5vdCBhbGxv
d2luZyBJT01NVSBkaXNhYmxlZA0KPiA+IG1vZGUsIElmIHNldF9tYXAvZG1hX21hcCBvcCBpcyBu
b3Qgc2V0LiBIZW5jZSwgd2UgYXJlIHNldHRpbmcgc2V0X21hcA0KPiA+IHdpdGggZHVtbXkgYXBp
IHRvIGFsbG93IElPTU1VIGRpc2FibGVkIG1vZGUuDQo+ID4NCj4gPiBGb2xsb3dpbmcgaXMgdGhl
IGNvZGUgc25pcHBldCBmcm9tIGRyaXZlcnMvdmhvc3QvdmRwYS5jDQo+ID4NCj4gPiAgICAgICAv
KiBEZXZpY2Ugd2FudCB0byBkbyBETUEgYnkgaXRzZWxmICovDQo+ID4gICAgICAgICBpZiAob3Bz
LT5zZXRfbWFwIHx8IG9wcy0+ZG1hX21hcCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4NCj4gPiAgICAgICAgIGJ1cyA9IGRtYV9kZXYtPmJ1czsNCj4gPiAgICAgICAgIGlmICgh
YnVzKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gPg0KPiA+ICAgICAg
ICBpZiAoIWRldmljZV9pb21tdV9jYXBhYmxlKGRtYV9kZXYsDQo+IElPTU1VX0NBUF9DQUNIRV9D
T0hFUkVOQ1kpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RTVVBQOw0KPiANCj4g
UmlnaHQsIHNvIGhlcmUncyB0aGUgcXVlc3Rpb24uDQo+IA0KPiBXaGVuIElPTU1VIGlzIGRpc2Fi
bGVkLCBpZiB0aGVyZSdzIG5vIGlzb2xhdGlvbiBmcm9tIHRoZSBkZXZpY2Ugb24tY2hpcA0KPiBJ
T01NVS4gSXQgbWlnaHQgaGF2ZSBzZWN1cml0eSBpbXBsaWNhdGlvbnMuIEZvciBleGFtcGxlIGlm
IHdlJ3JlIHVzaW5nIFBBLA0KPiB1c2Vyc3BhY2UgY291bGQgYXR0YWNrIHRoZSBrZXJuZWwuDQo+
IA0KPiBTbyB0aGVyZSBzaG91bGQgYmUgc29tZSBsb2dpYyBpbiB0aGUgc2V0X21hcCgpIHRvIHBy
b2dyYW0gdGhlIG9uLWNoaXANCj4gSU9NTVUgdG8gaXNvbGF0ZSBETUEgaW4gdGhhdCBjYXNlIGJ1
dCBJIGRvbid0IHNlZSBzdWNoIGltcGxlbWVudGF0aW9uIGRvbmUNCj4gaW4gc2V0X21hcCgpLg0K
DQpPdXIgY2hpcCBsYWNrcyBzdXBwb3J0IGZvciBvbi1jaGlwIElPTU1VIGZvciBob3N0LXNpZGUg
dGFyZ2V0ZWQgRE1BIG9wZXJhdGlvbnMuDQpXaGVuIHVzaW5nIHRoZSBEUERLIHZpcnRpbyB1c2Vy
IFBNRCwgd2XigJl2ZSBub3RpY2VkIGEgc2lnbmlmaWNhbnQgODAlIHBlcmZvcm1hbmNlDQppbXBy
b3ZlbWVudCB3aGVuIElPTU1VIGlzIGRpc2FibGVkIG9uIHNwZWNpZmljIHg4NiBtYWNoaW5lcy4g
VGhpcyBwZXJmb3JtYW5jZQ0KaW1wcm92ZW1lbnQgY2FuIGJlIGxldmVyYWdlZCBieSBlbWJlZGRl
ZCBwbGF0Zm9ybXMgd2hlcmUgYXBwbGljYXRpb25zIHJ1biBpbg0KY29udHJvbGxlZCBlbnZpcm9u
bWVudC4NCk1heSBiZSBpdCdzIGEgdHJhZGUtb2ZmIGJldHdlZW4gc2VjdXJpdHkgYW5kIHBlcmZv
cm1hbmNlLg0KDQpXZSBjYW4gZGlzYWJsZSB0aGUgbm8taW9tbXUgc3VwcG9ydCBieSBkZWZhdWx0
IGFuZCBlbmFibGUgaXQgdGhyb3VnaCBzb21lIG1vZHVsZQ0KcGFyYW1ldGVyIGFuZCB0YWludCB0
aGUga2VybmVsIHNpbWlsYXIgdG8gVkZJTyBkcml2ZXIoZW5hYmxlX3Vuc2FmZV9ub2lvbW11X21v
ZGUpIHJpZ2h0Pw0KPiANCj4gPg0KPiA+IFBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uIHdoZW4gaW9t
bXUgZW5hYmxlZCBpcyBub3Qgd2l0aCBETUEgQVBJIGJ1dCB0aGUNCj4gPiB4ODYgSFcgSU9NTVUg
dHJhbnNsYXRpb24gcGVyZm9ybWFuY2Ugb24gY2VydGFpbiBsb3cgZW5kIHg4NiBtYWNoaW5lcy4N
Cj4gDQo+IFRoaXMgbWlnaHQgYmUgdHJ1ZSBidXQgaXQncyBub3Qgc3BlY2lmaWMgdG8gdkRQQSBJ
IHRoaW5rPw0KPiANCj4gVGhhbmtzDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzDQo+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBvYnNlcnZlZCBwZXJmb3JtYW5j
ZSBpbXBhY3RzIG9uIGNlcnRhaW4gbG93LWVuZCB4ODYNCj4gPiA+ID4gPiA+IG1hY2hpbmVzIHdo
ZW4gSU9NTVUgbW9kZSB3YXMgZW5hYmxlZC4NCj4gPiA+ID4gPiA+IEkgdGhpbmssIGNvcnJlY3Ru
ZXNzIGlzIEhvc3QgdXNlcnNwYWNlIGFwcGxpY2F0aW9uJ3MNCj4gPiA+ID4gPiA+IHJlc3BvbnNp
YmlsaXR5LCBpbiB0aGlzIGNhc2Ugd2hlbiB2aG9zdC12ZHBhIGlzIHVzZWQgd2l0aCBIb3N0DQo+
ID4gPiA+ID4gPiBhcHBsaWNhdGlvbiBzdWNoIGFzIERQREsNCj4gPiA+ID4gPiBWaXJ0aW8gdXNl
ciBQTUQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcy4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4NCj4gPg0KDQo=
