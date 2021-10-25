Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D1AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:08:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8536660F6F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8536660F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4504D60649;
	Mon, 25 Oct 2021 07:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tMH2omOXLEr; Mon, 25 Oct 2021 07:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C12B260757;
	Mon, 25 Oct 2021 07:08:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96715C0012;
	Mon, 25 Oct 2021 07:08:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7538C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B561580E34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Poe-KZR7uTlK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:08:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1BD880E31
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI+pgl1gxNdYSH+VHVHD5HoNOxRbkt7Q0/PXfbFFZgXILw/qbULUYE+06QKGXNPepSZ4I5Ms+jBwvA93F9eSRHbFgoeMcyeHajZmK6eSx6MCh+rpAVx35AVfvgeLpr53Rl/VvsMzJX9iXQT9PNj6hjOoRrHRBA3pbsS+tHbpCWx6WgY/L1OvbweBP4r+gIlPKaruArTWdpf7AeNIspKP/zf7UEmsGK3To7V/LX64XCiiagNBKEDUNe+fgbSdPPww3nEh7cg4oVh+SFiqIU7hfUgEwilpAwNJBWjko+0xyIl5IJVVu+9CERtTXAqU+9mkWJrR+AxkzxaFC2Dtk9dGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDnlh56Llkdp0gAPI7HOy3r7BXEPB93/+GdneKQWfWo=;
 b=nTHNWdND4P9CYgmSTL4ZjHh6L6w/T0cnw+PEj+30Kew7Xgn01KmZZq6L0Vh1SRH6OqDq55sErAtFNw+/eEqfXw/1SDjPK6V7QW978Z8GydP4lTbgAqBRLddRvav0kuwNY10Rs6+YaISuzQyVVzj/QX0y+/lG3ACym+QPMSXaDFaG3yrnvIyZxH8rLeAVYj/02Hh4iqR+u2gFFWw+enElRcXmbXj9la4sbDQMmts9JTxLDzqApKrcJhiHVaJpD0g8TiFY8pJcDHjYfzP2VxUv0lTo+8iKJXxEr5JGotEBMsGbR8OhnQOwvb6LDFYBgpggEc4tC44LUqpFg0C1qw+DcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDnlh56Llkdp0gAPI7HOy3r7BXEPB93/+GdneKQWfWo=;
 b=lpKOpu5fSbvGX7AT0tdD4Bcr/KUSKOqmERNc9Vy/jEkF5ExZqCkGDoZ9c6dzrAMgWyjZOGvsgn3vX3Kfewwb828eDpiKwHPxclxc/Kw7sTPXzVjyhQCNt+qQ8o/xjW79yN+SpPSpMFygrqoCAwOHB7W+os+hfHN0GAtannfbBaktZZadBvktDnQ9vpIVcjGQuNon1rwquruFzxCLqD/JmWshQPYpJ2nQfh+bix5EdNjtu0kGdOpVAGjOpe6qRYpcmTSXYNo9FJeMW5wnQYI2g5Nx9ggUYv2G5IRnwBwYROzJvrYQf5D1Jv6Qn87ZEgo1kZmNBc26c7A1qGaHZw1sBA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 07:08:50 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:08:50 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 6/8] vdpa/mlx5: Fix clearing of
 VIRTIO_NET_F_MAC feature bit
Thread-Topic: [PATCH linux-next v4 6/8] vdpa/mlx5: Fix clearing of
 VIRTIO_NET_F_MAC feature bit
Thread-Index: AQHXxpm1BQUHdhx1Xkme/wZVx2NBe6vjUBgAgAAAnEA=
Date: Mon, 25 Oct 2021 07:08:50 +0000
Message-ID: <PH0PR12MB5481233AF957874DF60575CEDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-7-parav@nvidia.com>
 <53c1e41b-cac2-2419-9bd9-e40163e98dad@redhat.com>
In-Reply-To: <53c1e41b-cac2-2419-9bd9-e40163e98dad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37907c69-322e-42de-4aad-08d997864c35
x-ms-traffictypediagnostic: PH0PR12MB5435:
x-microsoft-antispam-prvs: <PH0PR12MB5435B7599ADAAE84FA63407DDC839@PH0PR12MB5435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohLsziKGrSh4llj5BxNOMg4WIkaWXDrdiC1rGsLD0N1t3nXy3D+s2Jkxz2HkUW70Rw8hGutid9RTqjb8OyXYLe/FuBj20KrcuHO/uDMSAymepnP6maHTtIOfelSMj0WKjB/ITCNL0W16RuHzTVTsX0Lz9GyT2mcMsck0aevL222umWZnwSoRUWUpRsNS2/ShE/6a+degls0XIJj7BUckq2Msxcfs/jqmKCa+WiJ992xs9oxd3lWf7jfRfZLNh7K8MsOOZq8kaQYRvYzikrNoeJZO1EOrcrLwosN87MIBdMKX1YJrLHHtcfHupoFSI2GbEi9sIpLcffm0VkbDoHoYGOXDrVlRY9zdKa6Gp6Q4MvdU67BqUd39u8F3HkijeKEoR4kJ8VZLsM0gBVe+RAYiiDt12ZZfSz7shQyWrICk7hOKRRH2b7l3+rLKB99MMvHAEWFYjjHzjJ3k24mM9LpR2SMcCaVBiILUJBiPwj1ppVxs5b2B8OLWFwBIgk7GBhRzU3me1AJ/uili3djImABr10tIO94wQVo77KlVWOCSbS7YYqN9bRXoHCtrm3KOLu+IlKmko+/LoR12/m3fz/4mwYJL/OobCv8DKs6tJc5Gt50KtTEusK2ebGnrzGYqgSJb5U8Srai53SK10LKPT6a+63J2b4sfD9ARUsUJtF+Lb9pSxO5UuqpqdCJVco2/9Pww74FwbTxyLwzryruLQSBT+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(8936002)(66446008)(4326008)(66556008)(64756008)(76116006)(66946007)(86362001)(66476007)(8676002)(6506007)(55016002)(122000001)(38100700002)(5660300002)(9686003)(7696005)(52536014)(33656002)(107886003)(186003)(316002)(83380400001)(508600001)(2906002)(38070700005)(71200400001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1dPSlNxdWwwTmRueVVNZDNQbGFiTUFWanJPZFlhajNFa1Jtd0k1Nk15WTNx?=
 =?utf-8?B?UDl1VmQ4eS9uUUxpSEJBd1ZhTFFPc3hJTkxkaEtHWDJIVjFqSjErRGwrSWM2?=
 =?utf-8?B?NS9wTFJ5Y3k4Y0dSQk1JMlJWNVQ2bk9QemFEVklwNWltRUgySU1KTTZsWUVI?=
 =?utf-8?B?dUhoV0tIMWJITlBLejZkTTVveFMzbDQyWHpWd1dKREVYZkZZN0IyUFRDblh1?=
 =?utf-8?B?RTByaXFQYlR3SFBJNFBicTFwS21SUXMzVzN4dGYrY01FV2h2WTBVUnE5VFR4?=
 =?utf-8?B?dTRGWUdsUi9Da1JRdkovNW9JUjdLNlFoRGRzYUpBUGZRTGFieTN0SlRlZlp3?=
 =?utf-8?B?Uk1LSHFYQTdDVFRpay9DNWIzQmlzd2M3bHUyd3F0SDY1VTQ0WFRpYkhGTTJN?=
 =?utf-8?B?SnpXdFI2emV6T0oxMDEyTVY5Q1haa2tRb2dIZzMvZ1pQMGQ4eHBoTzJIeHFz?=
 =?utf-8?B?cnh4a3hONXJucVBKVWFiV01DeGx5UnVkd21xOVJoSVF1UkFkeERQeFdzdHlW?=
 =?utf-8?B?TWhXa2N1WHAvUHJHU2tqb0wySlJwNE9qL1IyWXRJd051cllFUWt3ZU1CMmxU?=
 =?utf-8?B?WFB0NVBvKzQwSjVFcFBhbmxhcWpXQnROOTBkaHdqT2p4a3FFZ09uZTQxVUdV?=
 =?utf-8?B?NHB0cTZCbW9ZRWVnUG54eTg1dUp3MEpneUNzcUcxdjgrYWlxem9ZL3BGVlNC?=
 =?utf-8?B?TmlVY3piaEJuMHNLVHU2RXhhTWNoaGxhamVvUjdmOWkzcENkMyt1T2pEaUZy?=
 =?utf-8?B?ZUhCVXVCOEFKUzhFM0tDclRscGlXWVF4UTl4Q0FUb3NlYzdWdGgxbjRBcWFs?=
 =?utf-8?B?bzl4V0ZvV1ZlMlMrMFVwRGV0Y1AvcGNoUVpHWUNvV2w3VG13Y2hUWFo0bDNx?=
 =?utf-8?B?aHZOQXhxRHk3UkMraEdGU3RXSHlEa1hoUzg1dWxDZ3VoRFppeVZld1llTmF5?=
 =?utf-8?B?cGY5czFlTWNrQjk2aTloallTNE1HQk9jM0R1c1Uyc1BXL0twb2J1cEE0cTFC?=
 =?utf-8?B?WEhNRUMrYmlqZ3pET21BbVhGckszVnZvZVN3eHJ0RWgwTXJmUytLVnd5S0h1?=
 =?utf-8?B?b2gzZ3JqbE9TMlV1YlVzS2MwVDFxYUhUZkJUY2l0aFZLMzhVZTZLRXRzWmlt?=
 =?utf-8?B?MlAvNk9lb2hGTnhvaDFaNVN4bloxbmlVenhwSHl0VUFBM0pQU01mNXNWRVd3?=
 =?utf-8?B?Z0FrZSt2bXJtVjlWd2djMGl0YVJWRkM3RjlBUFI2Nm1BTzJkb051NVRsZXBE?=
 =?utf-8?B?SzNUWHArd1dYNUd0aHZCMUFrcEY3akljU3hmUGNNSmIvbngvK1UraUNTZ1dp?=
 =?utf-8?B?alU1VXl0OEg4TTVaWU5waWF4TEZYQXdJY2p3SktqdldWV3l6OE5HWTVIUFlF?=
 =?utf-8?B?cy9sbEJ4Z0NXOWF4R2UvREE4d3hFKzhmeGJvdjlOQ2NQMWZicWY4UlpKTnFV?=
 =?utf-8?B?Mzkzb2l4Z1kzNFdjaDlLaEN5ZzlHNTN3VlQvNnJnSURwOXc2ME9PTkRXV0Vs?=
 =?utf-8?B?NjNPU1BQUWVXdlFIZFdJLzdSMnYvMjhpekpLUjR1dVFpeUhMVEF2cWg2OGxU?=
 =?utf-8?B?Z1dOYk1IM0phWHVnUTY0aEppa0FoV3lWUUZRMWZsejlESzZZVTl5Ym9aMi8z?=
 =?utf-8?B?R0h1ZzVUL251VURvMm1BVmVoV1psUWowNFc1SlhhNCtpM0l0QUY4QS9VRDZW?=
 =?utf-8?B?V3l2ME11WktPTGRGMXlNQWUreFlVL0JYT1IxamxtZEtrdGh0UTB4R3lsa3FZ?=
 =?utf-8?B?UERYb1dYTEhZbjVvZUt4UGFEV1J4cnhaMVoxblZzbVdjcC9CUitmOWZiSzg5?=
 =?utf-8?B?STRGVGh0M1Q1dXZYTTY4c3VmTTFuMW9JSEFJWEVhZDlzMWNvZWdJU3o0ZkFk?=
 =?utf-8?B?YXA2Q1BQQW52T21vOGtKWENaZkdYbm5wUE1aZm1qMCtXaWdFdWI1RWxtOTI0?=
 =?utf-8?B?ay9pekxHUkRPNU5jaGNLZkVkZ0tsMzRZd25CdktNeUxCeEVXZ3dTMVEzOEJ4?=
 =?utf-8?B?c1hUNDJFeDB2VjVnYnM5SmZ1OVJNTVZrd0ozZGNlMjBOT0pqUThrbDExSGQw?=
 =?utf-8?B?OEx4ZEtVTlFGMm5LajFRa0g3MkpKT2tyaFZOWUdBYlM4UUZPUnNQNCtrVzNp?=
 =?utf-8?B?R2hZZGJkY3dsWTBVeXpsa2F5VzUvTHp2YjY5aTYxYlU5eFBMMFAxbllSdFdZ?=
 =?utf-8?Q?TjP+n5ZZGU0mxcBehyUCaSs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37907c69-322e-42de-4aad-08d997864c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:08:50.8632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0XX/m6sZcYTK3amkPrm1EwojQZjW6QiCLR+I6yc7o4/qncpati6ZvJUvXqx/y7DJl87Tbf1vQa1Pk68xE7uWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDI1LCAyMDIxIDEyOjM1IFBNDQo+IA0KPiDlnKggMjAyMS8xMC8yMiDkuIrl
jYgxMjozNSwgUGFyYXYgUGFuZGl0IOWGmemBkzoNCj4gPiBDaXRlZCBwYXRjaCBpbiB0aGUgZml4
ZXMgdGFnIGNsZWFycyB0aGUgZmVhdHVyZXMgYml0IGR1cmluZyByZXNldC4NCj4gPiBtbHg1IHZk
cGEgZGV2aWNlIGZlYXR1cmUgYml0cyBhcmUgc3RhdGljIGRlY2lkZWQgYnkgZGV2aWNlIGNhcGFi
aWxpdGllcy4NCj4gDQo+IA0KPiBUaGlzIGlzIG5vdCB3aGF0IEkgcmVhZCBhdCBsZWFzdCBmcm9t
IG1seDVfdmRwYV9nZXRfZmVhdHVyZXM6DQo+IA0KPiBzdGF0aWMgdTY0IG1seDVfdmRwYV9nZXRf
ZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KSB7DQo+ICDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsNCj4gIMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZk
ZXYpOw0KPiAgwqDCoMKgwqDCoMKgwqAgdTE2IGRldl9mZWF0dXJlczsNCj4gDQo+ICDCoMKgwqDC
oMKgwqDCoCBkZXZfZmVhdHVyZXMgPSBNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obXZkZXYt
Pm1kZXYsDQo+IGRldmljZV9mZWF0dXJlc19iaXRzX21hc2spOw0KTm90IHN1cmUgSSBmb2xsb3cu
IEZlYXR1cmUgYml0cyBhcmUgZGVjaWRlZCBieSB0aGUgZGV2aWNlIGNhcGFiaWxpdGllcyBleHBv
c2VkIGJ5IHRoZSBNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04uDQpPdGhlciBmaWVsZHMgYmVs
b3cgYXJlIHByZXR0eSBtdWNoIHN0YXRpYy4NCg0KPiAgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZk
ZXYubWx4X2ZlYXR1cmVzIHw9IG1seF90b192cml0aW9fZmVhdHVyZXMoZGV2X2ZlYXR1cmVzKTsN
Cj4gIMKgwqDCoMKgwqDCoMKgIGlmIChNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obXZkZXYt
Pm1kZXYsDQo+IHZpcnRpb192ZXJzaW9uXzFfMCkpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfVkVS
U0lPTl8xKTsNCj4gIMKgwqDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBC
SVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSk7DQo+ICDCoMKgwqDCoMKgwqDCoCBuZGV2
LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WUSk7DQo+
ICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0NCj4gQklUX1VMTChW
SVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUik7DQo+ICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRl
di5tbHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpOw0KPiANCj4gIMKgwqDC
oMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMs
IGZhbHNlKTsNCj4gIMKgwqDCoMKgwqDCoMKgIHJldHVybiBuZGV2LT5tdmRldi5tbHhfZmVhdHVy
ZXM7IH0NCj4gDQo+IA0KPiBUaGFua3MNCj4gDQo+IA0KPiA+DQo+ID4gQ2xlYXJpbmcgZmVhdHVy
ZXMgYml0IGNsZWFyZWQgdGhlIFZJUlRJT19ORVRfRl9NQUMuIER1ZSB0byB0aGlzIE1BQw0KPiA+
IGFkZHJlc3MgcHJvdmlkZWQgYnkgdGhlIGRldmljZSBpcyBub3QgaG9ub3JlZC4NCj4gPg0KPiA+
IEZpeCBpdCBieSBub3QgY2xlYXJpbmcgdGhlIHN0YXRpYyBmZWF0dXJlIGJpdHMgZHVyaW5nIHJl
c2V0Lg0KPiA+DQo+ID4gRml4ZXM6IDA2ODYwODJkYmY3YSAoInZkcGE6IEFkZCByZXNldCBjYWxs
YmFjayBpbiB2ZHBhX2NvbmZpZ19vcHMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMgfCAxIC0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBpbmRleCBjYTA1ZjY5MDU0YjYuLjBh
MmI3OTg4NzA4NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBA
QCAtMjE5Miw3ICsyMTkyLDYgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfcmVzZXQoc3RydWN0IHZk
cGFfZGV2aWNlDQo+ICp2ZGV2KQ0KPiA+ICAgCWNsZWFyX3Zxc19yZWFkeShuZGV2KTsNCj4gPiAg
IAltbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRldi0+bXZkZXYpOw0KPiA+ICAgCW5kZXYtPm12ZGV2
LnN0YXR1cyA9IDA7DQo+ID4gLQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgPSAwOw0KPiA+ICAg
CW1lbXNldChuZGV2LT5ldmVudF9jYnMsIDAsIHNpemVvZihuZGV2LT5ldmVudF9jYnMpKTsNCj4g
PiAgIAluZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSAwOw0KPiA+ICAgCSsrbXZkZXYtPmdl
bmVyYXRpb247DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
