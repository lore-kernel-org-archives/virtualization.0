Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E10C433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 20:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 283D340B8D;
	Mon, 16 May 2022 20:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAT0qg93yjtw; Mon, 16 May 2022 20:29:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8175140B58;
	Mon, 16 May 2022 20:29:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53C98C0032;
	Mon, 16 May 2022 20:29:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C190FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFB4A418E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:29:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7oKlZOCYUMd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:29:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E303418E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6Xm5LN8ZCcveq3M1qn7vnGUHf25Ybx+WZ7T/BzTRG3BnzuvQsHTZzHzrKCwJxsNtqHoh4EKc3njWs2UYNmk30Eq+sLglCcHXILXBKx0n/XNEpoldfVvU6SQn6s+8Ug1KBWljGKcu2523GpC5Mh7pjSXW8tPD/PUsDIvvRgNRYc8JsQSoJ8xx/h/oLTyohFtXnC+PUoLLvHH+CdOx2jr9YWb2vXA0ftcb4JSWVqb72TLTcSEYbFFF/TuK19LuUndd/K8bjr7URt1ZSaAw8agdt3YLw6rdlE3q9tW8wnfXba4nCnKAq54W89/qFYiBYRH22koo3i3MH3ByQWxr6YHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur2Z9lM0ofAqmfFE9Q56nIa1KipuT1PshScVYBS5wxo=;
 b=MNyYv793B0gHAPnKy1XPFQ+RrkTz8N07cRUnf9NXgSd7cc1WW9Io8rj62ZEXjnvaQ2COd51ZO8sBMH8s187Ydx+FX6Umb4kphx5voaBVEuwnKhJX31OV8HHQ1e1Ae2IkDTqPugCw67zLg/9L8TrCDyCZMuGgsUwOF2M//pEFl3ajQQKZ41jcP4lu5FTH8VWaDKnkpPLPqbpuVPQlOlKKLHPjxQKqi1nVjDwrOBIpxOwAW6L+V4Np+ZqYcdVn6LXmOx2qRCp5oPgYTxZAhXXix9Cr+40LLecIxooCaEYREb63ZYlArKJ+hR7iorJkp0fVE+emXQn5cvgynNySaY2QVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur2Z9lM0ofAqmfFE9Q56nIa1KipuT1PshScVYBS5wxo=;
 b=X/Ws0fxXRYLUnRiSyXIPncdbn4cz0kpwf4VkC9STnYCqzroaSdXBMTfeVg0vd1i471RbQ+wHSAA4YU9sLvc8BuXmSOIi2cecNC2o0LmZSpa/2xQCCGlyyEHepBkJoaNI+mzoVDoQOy89nE+FUOvhrLYIeIEt8g8ZGlCAp199b74caEJ4wn0jfSbjEY4s4Ib/L0YQgVo9WElFSf2bJ8kXlA/vjsHbohTdNMfz+xSXjY8X8/AdzwptRvqho5mpOUpKP96fuzWhqOf6KD7pwfGwy0i+wSeQQggKu6wgC6I1X/dH3CTgebhx+7oVqK9gAduDiH5D7fLEg7Pa+0iie5tOVQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 20:29:14 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 20:29:14 +0000
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: RE: About restoring the state in vhost-vdpa device
Thread-Topic: About restoring the state in vhost-vdpa device
Thread-Index: AQHYZW+JxbBQ1h+RIkS7iyhFOVHKbK0c5lPggAAyGwCAAAYJcIAEGq4AgAC/8WA=
Date: Mon, 16 May 2022 20:29:14 +0000
Message-ID: <PH0PR12MB54812F8306F5B9650BA10783DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
 <PH0PR12MB5481AF0B02B0FB00885FF2AEDCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BY5PR02MB698052EE53B707C6C04C3C8CB1CA9@BY5PR02MB6980.namprd02.prod.outlook.com>
 <PH0PR12MB54811C88B389ACB495BD5AB2DCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe2dQx1s7wQr8OLp-0eAQZJcCBuFwdxBA=sgeNm_u4N6A@mail.gmail.com>
In-Reply-To: <CAJaqyWe2dQx1s7wQr8OLp-0eAQZJcCBuFwdxBA=sgeNm_u4N6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 994c7126-f02f-4791-c210-08da377abe38
x-ms-traffictypediagnostic: MN2PR12MB3008:EE_
x-microsoft-antispam-prvs: <MN2PR12MB300845554E0A7C4853487AA0DCCF9@MN2PR12MB3008.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yo4r4KocI1gDXXoj2TCCYF0vF8viOz1r5C5crU+gAM3S7kRyo8aPZgxaja1nYmabnKpKoTYjeaPuQHvpgson9ZfvU9GKWGeYcLiY8BdQYI3Cwv42CvTsR74Tq7vfDwS08kGWJ0Qh66PV/WEYxQeO+b1nK7qRGh8TiuxN+7TQB8v12msgOY4Xqi86yNa5HqYu94esIJSI2VGeT4x+w5d2qeVwJKkTWXGVBelTI+udDHXnzNLAD8t/tO01zmoPNh9ASmrXMipFChAgSNcVU8zboNZmMpSNuEO269bZJC5za8giR98oYxdreD0f8B3qP3yxi4FprdA9p+ZmOHwZ1guGEJ3NwJER7dKsdiZd7DKKJaJ4HAdOiWhnmCU7F8JFkDvumSqJgrLV0pPJgw8BVQvEzoPogh7pCBFFiqPEGyoad/beOlSVraO4Ce0MG0wIJWoa1kYCCN57w24NODyEn2r5Y+h2BFa+5gT2NsrzCkIopWj3tL2pZFJYQ1+nQUdJIzE9RtWl1FRiQMNWk2GThZpEmF0f4rKK68Cet5RNAO3igYLXrMx7pKi8jmco0D3EeMhWUhYaiwUxmRLJ2ZybASSh88dbxIawkCCsUc7SZbOxg1eiIYaY/3YhqAtNjueo6NRNF1wkKViEEPNlp0bNtbThi2B2PaSNDSIH2HgJxHZxhyV0nv92s4Jn6ZxZAUx0ECyGNGo2n0RJ/31o+2bRM5HZsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(64756008)(4326008)(38100700002)(38070700005)(66446008)(33656002)(5660300002)(55016003)(186003)(76116006)(66476007)(66556008)(66946007)(52536014)(2906002)(6916009)(71200400001)(53546011)(6506007)(508600001)(316002)(86362001)(83380400001)(7696005)(122000001)(54906003)(8936002)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzY0R3kyUG5GK3ZJYS9oSXhFWnl4ZlF4b0lrcUxNdnNiMHR5SHBoQ2xlUEc2?=
 =?utf-8?B?TTgxdkhTRTIreS8yNm8rZ2tzVjVsSExWWlA1VUVndzdQMXFFa1dBYVZ4Nzli?=
 =?utf-8?B?dXQ2elp0NnlGK3NldjlhVFN0QjhCM3R5NDJpcVhjN1ppWkJmeWJXeTVIU1ZG?=
 =?utf-8?B?Wm9ZMlNGOStSSndYb2lRV1ZCSWs0ZUVXcDhDNi9UendFN2JMMS9BRWZSa3lu?=
 =?utf-8?B?d2dudWlxc3o3dkxrUThic3o1QzVaRG9PbzFMRUptVXN6WjQwK3ZBT01kVGZo?=
 =?utf-8?B?cE5jRE9jUEh4bDlncmxHd3RKWm9hYlp4UjN5ZHdtMGhKUE5PUjJCZVZHUThN?=
 =?utf-8?B?czBRbE9vVFpVRHFwb0JHMERqVjhUYU5xcWhrQWdLYUlqRkozTTNOUUoySVBJ?=
 =?utf-8?B?dElIWTBaQnFSVUpISFlZMnl5dkpxSU1kTU9oNk5NVFJyT29MUlBsY2o0bmw4?=
 =?utf-8?B?eFJQU1ZoVVNjWUV6WFlheGtCUDFSUlJ5WDRxRHgycm5JaHlxcWVlbDFBenFy?=
 =?utf-8?B?ZWxNdVlvQmc2ZjBENDNmbEI2bUgrSjRxTWpTN0dZRWxQOHlvcG5vYktsb2Y4?=
 =?utf-8?B?dXN1bWVoa3d5RkErZjY4eVdiNFNxVEF3eVNnNDBtSXVwNGtDaXEyNG5sQkJo?=
 =?utf-8?B?eWRTU3VDYm9vV1FKOGkrbGFNVzJTVFBqd2VRc0dBSUxOTkRhZ05HUlAzWkJi?=
 =?utf-8?B?SVo4cmtSY0pZQTlybG4zUmhxanlEdnJMUWUzbzYrbmlSWnFzK0kwdXR5ZXgw?=
 =?utf-8?B?YkhEOGEvdUJreVBKbVBDUWRjajdtMkEvMEY2OEhETFNVK1lzQ0I1dDZnOWlj?=
 =?utf-8?B?Q2NTTFVoU2RrOFVtdEF0WmhJN3EyaDZQaWJTVHpkVnc0dnQrNHRNZnViU3o5?=
 =?utf-8?B?QXZkelNFVlNROGl4Vm54L3gveW0zL2ZhOUQ3d01GV0tzMjZoYXUyZWNPTFpG?=
 =?utf-8?B?VVd1N25IckpKS2M5RTUrYnBoTnY4TG1kcU5JRE42OXl2YU5FTUJRcHBJblQ3?=
 =?utf-8?B?VkdLeFpHTmNRMXl5RVVZakhBaHVmREhNUXBjMzY5ZkxPeG1XM3o2aFhSN09x?=
 =?utf-8?B?ek9WenhhSFJ3YndNRmx2azdaVFhxMWFTYzlSUmc3UmxvR0JCakF0a0hpc2hY?=
 =?utf-8?B?WGc5c3dPcHJMUW1hZGJGUHUwQUJQcGZ2U0VqYkd0eHdpUXpHQkRkVGZLbW1T?=
 =?utf-8?B?bUxvS1k5UlhkTytTMU4yK3k4OCtQaUltbUNCa3hZOTBEb0xHMzRXYVJCaWQ4?=
 =?utf-8?B?UTVtNU1SdVhBWWhwaUFBVkg2bUpKV0xxVTBtTnZnajIremtaK29GS00xU2Jo?=
 =?utf-8?B?dVNMZGRSQnlOVzVmblY0cTlyWklPaUtINEp5U3lmVXpPV1laZUR3blNZdnpK?=
 =?utf-8?B?SGhkY0N6MFNBZ3l6NGlVQWpWTlpjb3ZyVjdJYVJ4WGZOaCtHdmJVOFYzRkto?=
 =?utf-8?B?bFBxM2JPSlV1ZTdnOENvWWtGQmNSSUpJRm4rRnd5M1BWbXU0N0ZPNXFMWHZa?=
 =?utf-8?B?WFRqakp6R2RuK1p6MmtmTG9yUWN1NnhqamVHZUVEaFJjV0hTQkhBdVBXb1Uv?=
 =?utf-8?B?N1EzTTdhVWNrUDNrZ1I3Ylc2WWpwTzhRSHRXNDNKZXJENHQ0dG54amRldmxM?=
 =?utf-8?B?TVVEZDVaVEEvbWo4OGYyalZmUllzMkRvYWlaVStQNHdEdC9UQkVHV1JiR3Bm?=
 =?utf-8?B?L2g4VjRWNzR0QzdaUTljdzJwN2RkdGNQaUp6QkZ3MXErcDUrU1NqKy9NV0ZQ?=
 =?utf-8?B?MkdCV1VZak5vOG1oWFUxSlRHbDZkSVE3NHYvQnFkSG44aGtmMzIyMW55b1dz?=
 =?utf-8?B?M0FrbGhpMlBNd1prVW4rYWhXQUErMElIbDJMN2ZySTZHS2lTTnd5cEp6WXdY?=
 =?utf-8?B?WldhSEhQaUhZTmlvMUdoMW10R1VhOU9JMW4xSlJtTVI0bkFNUXpFanMzOElz?=
 =?utf-8?B?T3dtOWtFcVFaVzhlRkFXZHl5d0g0Yk5nUHZONktNUFN5RUJhWVBFQWtZWUlq?=
 =?utf-8?B?WWdIcDlKNHdBa2M4eG5MSG5xN2I5bThDTGlESDBpL3pYK3VxWlNnNzZkc3JK?=
 =?utf-8?B?M3ZBTS9IRUp1NU9VZ0dMc1lyOHovcmJ5VHVNZ2NidGt6R3NNcFgzTUdHQURR?=
 =?utf-8?B?YUNQWVJway9YVm8zV0EwQ2phRmw5UnVTTUplYXgraEF3ejNtc29ObHZJL0d6?=
 =?utf-8?B?Rzd1Mzg2QWtrUzZHenZtUzV2QWo1cFRKcDJ3QjUvYWw5b3dobUVGKytYb1Z2?=
 =?utf-8?B?dUVxcE5TemNLMVpOcUk3R0c2N3RqSkl0SXRCSXhQSVVaTElXblIzb2tCMmhl?=
 =?utf-8?B?QTluZUIvRWlhSlMyVmNxL2V2c2tYWWliQlRhYUlCcTlEYlZuNXVsdz09?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994c7126-f02f-4791-c210-08da377abe38
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 20:29:14.2650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9A6zRYZciD1MgK8PH7OKzEqcs5nX8+UFmKradMf+kVK2igo5cG4xxXwT4tRRSD2Spnhnj11yDSRZ1f4+osU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "virtio-networking@redhat.com" <virtio-networking@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgTWF5IDE2LCAyMDIyIDQ6NTEgQU0NCj4gDQo+IE9uIEZyaSwgTWF5IDEz
LCAyMDIyIGF0IDg6MjUgUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEhpIEdhdXRhbSwNCj4gPg0KPiA+IFBsZWFzZSBmaXggeW91ciBlbWFpbCBjbGll
bnQgdG8gaGF2ZSByaWdodCByZXNwb25zZSBmb3JtYXQuDQo+ID4gT3RoZXJ3aXNlLCBpdCB3aWxs
IGJlIGNvbmZ1c2luZyBmb3IgdGhlIHJlc3QgYW5kIHVzIHRvIGZvbGxvdyB0aGUNCj4gY29udmVy
c2F0aW9uLg0KPiA+DQo+ID4gTW9yZSBiZWxvdy4NCj4gPg0KPiA+ID4gRnJvbTogR2F1dGFtIERh
d2FyIDxnZGF3YXJAeGlsaW54LmNvbT4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDEzLCAyMDIy
IDE6NDggUE0NCj4gPg0KPiA+ID4gPiBPdXIgcHJvcG9zYWwgZGl2ZXJnZSBpbiBzdGVwIDc6IElu
c3RlYWQgb2YgZW5hYmxpbmcgKmFsbCogdGhlDQo+ID4gPiA+IHZpcnRxdWV1ZXMsIG9ubHkgZW5h
YmxlIHRoZSBDVlEuDQo+ID4gPiBKdXN0IHRvIGRvdWJsZSBjaGVjaywgVlEgMCBhbmQgMSBvZiB0
aGUgbmV0IGFyZSBhbHNvIG5vdCBlbmFibGVkLCBjb3JyZWN0Pw0KPiA+ID4gW0dEPj5dIFllcywg
dGhhdCdzIG15IHVuZGVyc3RhbmRpbmcgYXMgd2VsbC4NCj4gPiA+DQo+IA0KPiBUaGF0J3MgY29y
cmVjdC4gV2UgY2FuIHNheSB0aGF0IGZvciBhIHF1ZXVlIHRvIGJlIGVuYWJsZWQgdGhyZWUgdGhp
bmdzIG11c3QNCj4gaGFwcGVuOg0KPiAqIERSSVZFUl9PSyAoU3RpbGwgbm90IHNlbmQpDQo+ICog
VkhPU1RfVkRQQV9TRVRfVlJJTkdfRU5BQkxFIHNlbnQgZm9yIHRoYXQgcXVldWUgKE9ubHkgc2Vu
dCBmb3INCj4gQ1ZRKQ0KPiAqIElmIHF1ZXVlIGlzIG5vdCBpbiBmaXJzdCBkYXRhIHF1ZXVlIHBh
aXIgYW5kIG5vdCBjdnE6IHNlbmQNCj4gVklSVElPX05FVF9DVFJMX01RX1ZRX1BBSVJTX1NFVCB3
aXRoIGEgcXVldWUgcGFpciB0aGF0IGluY2x1ZGUgaXQuDQo+IA0KVGhlc2UgaWYgY29uZGl0aW9u
cywgc3BlY2lhbGx5IHRoZSBsYXN0IG9uZSBpcyBub3QgZ29vZCBhcyBpdCByZXF1aXJlcyBkZXZp
Y2UgdHlwZSBrbm93bGVkZ2UsIHdoaWNoIGluIG1vc3QgY2FzZXMgbm90IG5lZWRlZC4NClNwZWNp
YWxseSBmb3IgdGhlIG5ldyBjb2RlLg0KDQo+ID4gPiA+IEFmdGVyIHRoYXQsIHNlbmQgdGhlIERS
SVZFUl9PSyBhbmQgcXVldWUgYWxsIHRoZSBjb250cm9sIGNvbW1hbmRzDQo+ID4gPiA+IHRvIHJl
c3RvcmUgdGhlIGRldmljZSBzdGF0dXMgKE1RLCBSU1MsIC4uLikuIE9uY2UgYWxsIG9mIHRoZW0g
aGF2ZQ0KPiA+ID4gPiBiZWVuIGFja25vd2xlZGdlZCAoImRldmljZSIsIG9yIGVtdWxhdGVkIGN2
cSBpbiBob3N0IHZkcGEgYmFja2VuZA0KPiA+ID4gPiBkcml2ZXIsIGhhcyB1c2VkIGFsbCBjdnEg
YnVmZmVycywgZW5hYmxlIChTRVRfVlJJTkdfRU5BQkxFLA0KPiA+ID4gPiBzZXRfdnFfcmVhZHkp
IGFsbCBvdGhlciBxdWV1ZXMuDQo+ID4gPiA+DQo+ID4gPiBXaGF0IGlzIHNwZWNpYWwgYWJvdXQg
ZG9pbmcgRFJJVkVSX09LIGFuZCBlbnF1ZXVpbmcgdGhlIGNvbnRyb2wNCj4gPiA+IGNvbW1hbmRz
Pw0KPiA+ID4gV2h5IG90aGVyIGNvbmZpZ3VyYXRpb24gY2Fubm90IGJlIGFwcGxpZWQgYmVmb3Jl
IERSSVZFUl9PSz8NCj4gDQo+IFRoZXJlIGlzIG5vdGhpbmcgc3BlY2lhbCBiZXlvbmQgInRoZXkg
aGF2ZSBhIG1ldGhvZCB0byBiZSBzZXQgdGhhdCB3YXksIHNvDQo+IHJldXNpbmcgaXQgYXZvaWRz
IGhhdmluZyB0byBtYWludGFpbiBtYW55IHdheXMgdG8gc2V0IHRoZSBzYW1lIHRoaW5ncywNCj4g
c2ltcGxpZnlpbmcgaW1wbGVtZW50YXRpb25zIi4NCj4gDQo+IEknbSBub3Qgc2F5aW5nICJpdCBo
YXMgYmVlbiBsaWtlIHRoYXQgZm9yZXZlciBzbyB3ZSBjYW5ub3QgY2hhbmdlIGl0IjoNCj4gSSdt
IHZlcnkgb3BlbiB0byB0aGUgY2hhbmdlIGJ1dCBwcmlvcml0eS13aXNlIHdlIHNob3VsZCBmaXJz
dCBhY2hpZXZlIGENCj4gd29ya2luZyBMTSB3aXRoIHBhY2tlZCwgaW5fb3JkZXIsIG9yIGV2ZW4g
aW5kaXJlY3QuDQo+IA0KPiA+ID4gW0dEPj5dIEZvciB0aGUgZGV2aWNlIHRvIGJlIGxpdmUgKGFu
ZCBhbnkgcXVldWUgdG8gYmUgYWJsZSB0byBwYXNzDQo+ID4gPiB0cmFmZmljKSwgRFJJVkVSX09L
IGlzIGEgbXVzdC4NCj4gPiBUaGlzIGFwcGxpZXMgb25seSB0byB0aGUgdmRwYSBkZXZpY2UgaW1w
bGVtZW50ZWQgb3ZlciB2aXJ0aW8gZGV2aWNlLg0KPiA+IEZvciBzdWNoIHVzZSBjYXNlL2ltcGxl
bWVudGF0aW9uIGFueXdheSBhIHByb3BlciB2aXJ0aW8gc3BlYyBleHRlbnNpb24gaXMNCj4gbmVl
ZGVkIGZvciBpdCBiZSBlZmZpY2llbnQuDQo+ID4gQW5kIHdoYXQgdGhhdCBoYXBwZW5zIHRoaXMg
c2NoZW1lIHdpbGwgc3RpbGwgd29yay4NCj4gPg0KPiANCj4gQWx0aG91Z2ggaXQncyBhIGxvbmdl
ciByb3V0ZSwgSSdkIHZlcnkgbXVjaCBwcmVmZXIgYW4gaW4tYmFuZCB2aXJ0aW8gd2F5IHRvDQo+
IHBlcmZvcm0gaXQgcmF0aGVyIHRoYW4gYSBsaW51eC92ZHBhIHNwZWNpZmljLiBJdCdzIG9uZSBv
ZiB0aGUgcmVhc29ucyBJIHByZWZlcg0KPiB0aGUgQ1ZRIGJlaGF2aW9yIG92ZXIgYSB2ZHBhIHNw
ZWNpZmljIGlvY3RsLg0KPiANCldoYXQgaXMgdGhlIGluLWJhbmQgbWV0aG9kIHRvIHNldCBsYXN0
X2F2YWlsX2lkeD8NCkluLWJhbmQgdmlydGlvIG1ldGhvZCBkb2Vzbid0IGV4aXN0Lg0KDQo+ID4g
T3RoZXIgdmRwYSBkZXZpY2VzIGRvZXNu4oCZdCBoYXZlIHRvIGxpdmUgd2l0aCB0aGlzIGxpbWl0
YXRpb24gYXQgdGhpcyBtb21lbnQuDQo+ID4NCj4gPiA+IFNvLCBhbnkgY29uZmlndXJhdGlvbiBj
YW4gYmUgcGFzc2VkIG92ZXIgdGhlIENWUSBvbmx5IGFmdGVyIGl0IGlzDQo+ID4gPiBzdGFydGVk
ICh2cmluZyBjb25maWd1cmF0aW9uICsgRFJJVkVSX09LKS4gRm9yIGFuIGVtdWxhdGVkIHF1ZXVl
LCBpZg0KPiA+ID4gdGhlIG9yZGVyIGlzIHJldmVyc2VkLCBJIHRoaW5rIHRoZSBlbnF1ZXVlZCBj
b21tYW5kcyB3aWxsIHJlbWFpbg0KPiA+ID4gYnVmZmVyZWQgYW5kIGRldmljZSBzaG91bGQgYmUg
YWJsZSB0byBzZXJ2aWNlIHRoZW0gd2hlbiBpdCBnb2VzIGxpdmUuDQo+ID4gSSBsaWtlbHkgZGlk
buKAmXQgdW5kZXJzdGFuZCB3aGF0IHlvdSBkZXNjcmliZSBhYm92ZS4NCj4gPg0KPiA+IFZxIGF2
YWlsIGluZGV4IGV0YyBpcyBwcm9ncmFtbWVkIGJlZm9yZSBkb2luZyBEUklWRVJfT0sgYW55d2F5
Lg0KPiA+DQo+ID4gU2VxdWVuY2UgaXMgdmVyeSBzdHJhaWdodCBmb3J3YXJkIGF0IGRlc3RpbmF0
aW9uIGZyb20gdXNlciB0byBrZXJuZWwuDQo+ID4gMS4gU2V0IGNvbmZpZyBzcGFjZSBmaWVsZHMg
KHN1Y2ggYXMgdmlydGlvX25ldF9jb25maWcvdmlydGlvX2Jsa19jb25maWcpLg0KPiA+IDIuIFNl
dCBvdGhlciBkZXZpY2UgYXR0cmlidXRlcyAobWF4IHZxcywgY3VycmVudCBudW0gdnFzKSAzLiBT
ZXQgbmV0DQo+ID4gc3BlY2lmaWMgY29uZmlnIChSU1MsIHZsYW4sIG1hYyBhbmQgbW9yZSBmaWx0
ZXJzKSA0LiBTZXQgVlEgZmllbGRzDQo+ID4gKGVuYWJsZSwgbXNpeCwgYWRkciwgYXZhaWwgaW5k
eCkgNS4gU2V0IERSSVZFUl9PSywgZGV2aWNlIHJlc3VtZXMgZnJvbQ0KPiA+IHdoZXJlIGl0IGxl
ZnQgb2ZmDQo+ID4NCj4gPiBTdGVwcyAjMSB0byAjNCBjYW4gYmUgZG9uZSBtdWx0aXBsZSB0aW1l
cyBpbiBwcmUtd2FybSBkZXZpY2UgdXAgY2FzZSBpbg0KPiBmdXR1cmUuDQo+IA0KPiBUaGF0IHJl
cXVpcmVzIGNyZWF0aW5nIGEgd2F5IHRvIHNldCBhbGwgdGhlIHBhcmFtZXRlcnMgZW51bWVyYXRl
ZCB0aGVyZSB0bw0KPiB2ZHBhIGRldmljZXMuIEVhY2ggdGltZSBhIG5ldyBmZWF0dXJlIGlzIGFk
ZGVkIHRvIHZpcnRpby1uZXQgdGhhdCBtb2RpZmllcw0KPiB0aGUgZ3Vlc3QtdmlzaWJsZSBmcm9u
dGVkIGRldmljZSB3ZSB3b3VsZCBuZWVkIHRvIHVwZGF0ZSBpdC4gDQpBbnkgZ3Vlc3QgdmlzaWJs
ZSBmZWF0dXJlIGV4cG9zZWQgYnkgdGhlIHZkcGEgZGV2aWNlIG9uIHRoZSBzb3VyY2Ugc2lkZSwg
YSBtaWdyYXRpb24gYWdlbnQgbmVlZHMgdG8gdmVyaWZ5L2FuZCBtYWtlIGRlc3RpbmF0aW9uIGRl
dmljZSBjYXBhYmxlIHRvIHN1cHBvcnQgaXQgYW55d2F5LiBXaXRob3V0IGl0IGEgZGV2aWNlIG1h
eSBiZSBtaWdyYXRlZCwgYnV0IGl0IHdvbid0IHBlcmZvcm0gYXQgc2FtZSBsZXZlbCBhcyBzb3Vy
Y2UuDQoNCj4gQW5kIGFsbCB0aGUNCj4gbGF5ZXJzIG9mIHRoZSBzdGFjayBuZWVkIHRvIG1haW50
YWluIG1vcmUgc3RhdGUuDQpNb3N0bHkgbm90LiBBIGNvbXBsZXRlIHZpcnRpbyBkZXZpY2Ugc3Rh
dGUgYXJyaXZlZCBmcm9tIHNvdXJjZSB2ZHBhIGRldmljZSBjYW4gYmUgZ2l2ZW4gdG8gZGVzdGlu
YXRpb24gdmRwYSBkZXZpY2Ugd2l0aG91dCBhbnlvbmUgZWxzZSBsb29raW5nIGluIHRoZSBtaWRk
bGUuIElmIHRoaXMgZm9ybWF0IGlzIGtub3duL3dlbGwgZGVmaW5lZC4NCg0KPiANCj4gRnJvbSB0
aGUgZ3Vlc3QgcG9pbnQgb2YgdmlldywgdG8gZW5hYmxlIGFsbCB0aGUgcXVldWVzIHdpdGgNCj4g
VkhPU1RfVkRQQV9TRVRfVlJJTkdfRU5BQkxFIGFuZCBkb24ndCBzZW5kIERSSVZFUl9PSyBpcyB0
aGUgc2FtZQ0KPiBhcyBzZW5kIERSSVZFUl9PSyBhbmQgbm90IHRvIGVuYWJsZSBhbnkgZGF0YSBx
dWV1ZSB3aXRoDQo+IFZIT1NUX1ZEUEFfU0VUX1ZSSU5HX0VOQUJMRS4gDQoNCkVuYWJsaW5nIFNF
VF9WUklOR19FTkFCTEUgYWZ0ZXIgRFJJVkVSX09LIGhhcyB0d28gYmFzaWMgdGhpbmdzIGJyb2tl
bi4NCjEuIHN1cHBsaWVkIFJTUyBjb25maWcgYW5kIFZRIGNvbmZpZyBpcyBub3QgaG9ub3JlZCBm
b3Igc2V2ZXJhbCB0ZW5zIG9mIGh1bmRyZWRzIG9mIG1pbGxpc2Vjb25kcw0KSXQgd2lsbCBiZSBw
dXJlbHkgZGVwZW5kZW50IG9uIGhvdy93aGVuIHRoaXMgaW9jdGwgYXJlIG1hZGUuDQpEdWUgdG8g
dGhpcyBiZWhhdmlvciBwYWNrZXQgc3VwcG9zZWQgdG8gYXJyaXZlIGluIFggVlEsIGFycml2ZXMg
aW4gWSBWUS4NCg0KMi4gRWFjaCBWUSBlbmFibGVtZW50IG9uZSBhdCBhIHRpbWUsIHJlcXVpcmVz
IGNvbnN0YW50IHN0ZWVyaW5nIHVwZGF0ZSBmb3IgdGhlIFZRDQpXaGlsZSB0aGlzIGluZm9ybWF0
aW9uIGlzIHNvbWV0aGluZyBhbHJlYWR5IGtub3duLiBUcnlpbmcgdG8gcmV1c2UgYnJpbmdzIGEg
Y2FsbGJhY2sgcmVzdWx0IGluIHRoaXMgaW4tZWZmaWNpZW5jeS4NClNvIGJldHRlciB0byBzdGFy
dCB3aXRoIG1vcmUgcmV1c2FibGUgQVBJcyB0aGF0IGZpdHMgdGhlIExNIGZsb3cuDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
