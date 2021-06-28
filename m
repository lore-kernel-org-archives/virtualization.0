Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED45C49EA3
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 10:56:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D2C61C6C
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 10:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D2C61C6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF3DC82F14;
	Mon, 28 Jun 2021 10:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKZoBJiYDwkW; Mon, 28 Jun 2021 10:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 808DB82C21;
	Mon, 28 Jun 2021 10:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5615DC001A;
	Mon, 28 Jun 2021 10:56:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6590C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 10:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3EF34031C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 10:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HB0wHgPjNyqc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 10:56:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02BC14031B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 10:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxnfsrEbaf0Crjg8lCiKpnt6Z5RkjnzswrvNbIuJ4YahlH51/4g/0iuTGx9m45JNcIip8HeAdPpO8S2nkF9LRQkqEIELUtV1JEY7wHHmzNVCR6bDHC5/iG0/dbpBgW6798/ujaaJeiweNXJSBTJIFvL8sM6jeQbCJO7P9O/fzEVPVvYX8dP+6RDoA8N7QuzgLlvHnfySuY3Tk08IVlzIrtPlBFEZgrhuG2lPFHbCTK/CyJX+cZqAtKsjSbS9KyJAZaJydDrUaiNusRfWldQ8XE1KFBQhKJONPQ3Chcn1ON/ee4SWy32muU/ZSCFxN56zmsQ9zGwHPWZdSCpaz7Dt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS1VTimSWIVifLTIg3ZpAtv2vg2Grdxekc1cQIe9asA=;
 b=TIql/jC3CC68iazgyVsyl/WSAXm/Ed7C/BrlLir88kN/zTSrWoHEGu1iWUU4PgLu++KQp/CSXFvIW+TWOfhDB1a14KE38FjMlT1K3nN17bcyrVwSN3YR6xWzuyLR+cD20JA/OhS4Xy11NThwiNDzuWutp0gYsj4ExMftIsa3e+V/ru8G0h6v0rhaTuhwFMiS1d3aDgZbGF00ABeDZL6lkfBO/GkkEnnF0ueBb+1mhKtX0BkKOiW10YMvIENQbwz+dGNXEsczs+IueyPDsVOKu21z5kGsrzUFZ++XV2vNCdfQLDXbizc/kmi5bNOtYnrioT6Jvmlmv4/lOnhDJjrXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS1VTimSWIVifLTIg3ZpAtv2vg2Grdxekc1cQIe9asA=;
 b=ZZUnND41R4mXmvkR1NFURXYNlkVw89ZIphu3Ec29nKGRk7dQZTI4aiYhZXY8SM/J4bSkRm1kI8c2+okquwBMpp3tKZQ+avo8nzNqgyJAg++3yh+fgz0mspFHS8xBwfys9Pb65UHuhqmqcTvj5vTTG6/J5bxtXwa6zD718rvxkSQ6+ADYDOWIQpwIc0aIje6uUbeo+Gn8Gwjwc8eJYsviRE0ejwWtf1YCjscJaGno9z/60ADKNd1m2tyhUh+CntR9VwCdrFHOPoQ6FUREGOlnRHFK7TZG0aC4tUyizT60ZLHHhE5e9c8wYu0yrwzfgQSuxIkn3KAe7FKKZJT6rTY1kQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 10:56:29 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 10:56:29 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0A==
Date: Mon, 28 Jun 2021 10:56:28 +0000
Message-ID: <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
In-Reply-To: <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f78c48c-3ce8-4e90-1fa6-08d93a2361e7
x-ms-traffictypediagnostic: PH0PR12MB5451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54512893B19B7FB4FEEE4CA0DC039@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDNMhPCJ+Jj0U3f/rf5v4l1b29y9vHBDBYIiPSg25dDpH6MXWX/Yw+/g0C2E/VBViinVXRWS3DeGSFS73LGjgBBxD+IxPvI6BxXoza2A3mNi6AqUM+zlzFudlSUNdk+Yxmrk/7bhMTLRsfhI321kq0TZgg7xMKfi/xAoLpgkECWi5rY99AVB7b+fCTjLIhBZJCGKCHT9rjGtaitljM2Lika5z0xeGbza926Yug11rb1XL+aUn2/Ltw8Qw4J+ZW/0jYKF0qH4pwmOjsoFWZx+1xI0NJiHwPspjwjczXeCIg1qI8A6F1ts8f9vvgrg5fnRosuU5QRlZk+bkwFOPP7VKmx+0ktb/kjKDODDWJU4sBEup2Yud3jW8z8JPn+sBl9tUQwbtsCwJPV4fxn1WWQvRpB1vlRidet48/mRoLL6YxpcDCjHXqgxFDu5YjHBmxbkGdu86373Rha0HChzvAkIxhYyg7T2QszS27EyiLHjnL/nn1NIS+LVfYI4ggArTGqTUlD3x2SyeU5z8HmtmpZvFOkfEDMBzyQiasbooaZlVLJwL441gtnQifi+nYNPQAYUBOYBdTmdTZyptXhJI3lvMRyHKzqOZYe7N0CiRlxCqh1KRy2lk1v0pT2mi+UAxfucIHJEiBTd3gHUksXW+VTUHk3k94Cas9i85zUvVLPuAisnyHPLIWbGBxw8j/tfUkvMRQlbCQc9CahXoIsXGhnhJS40D/p2QH0FAN/FpG9f+43JF6TJTV2OqF+oUtN+bDuWJEuKt7CC+oIGkc3Yx3X6sXIJw3Uca67Fzc3nI54ppqYAvjmQIe0K7jDK7YFoNF2n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(7696005)(33656002)(8676002)(6506007)(316002)(54906003)(8936002)(4326008)(9686003)(186003)(26005)(966005)(110136005)(478600001)(107886003)(55016002)(66946007)(66556008)(5660300002)(122000001)(76116006)(66476007)(83380400001)(38100700002)(2906002)(86362001)(71200400001)(52536014)(64756008)(66446008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qyt0RlFWZVh3UlJVd1pnaTAzRGZnbUhidnQvNFJ5SnJZbWdZb1EvUW5XMTV5?=
 =?utf-8?B?cUlGeDlzM29TRTJxNEJBWkQ0MEhid1JXbHVPSmtsRDJvZWR3aVJaaURZYW0z?=
 =?utf-8?B?S3QxN3F4K05laUFDR0ZrQXo5Y1Mzb202bmFDWG9ML21nQUt2WVJrVDFrckZS?=
 =?utf-8?B?Mm1TYzc5VzlyOENudEtDbUxybDdMSTV5dlppTWk1a2ZxUGtOc1NRUmxjVERB?=
 =?utf-8?B?NDlnaVNlektNU0ZxVEZwZWEyYlJSNjVJZnlnd1h2cnN6R285U0pWQ2pLcVpN?=
 =?utf-8?B?YUJhTDRtMVlabTF4UXh1RENlS0piNzNQQTA2WDVmSVgzS1UxdGp4UWlzRTVD?=
 =?utf-8?B?cEdrbmVuS1B4ajF1bEE5clhWYmNGYzFjcnd3SW5BVGk2UlppdmZyWUhLY2ds?=
 =?utf-8?B?by9VZmFadGNTZVA5Uk9CeUhKQWZFbWZIekh2QU1YN3BXMVdLalB6U0tRVWdr?=
 =?utf-8?B?d3h4alZVU2w3NTdnWkU3UlY3b2NSSE1VcWlPZkZCQkFneFJxREtrY3JGZFI2?=
 =?utf-8?B?bDI4NER6eGQvSkVqUjNnd293M1Q3Smw2cDBKaGVyUnFyYi9iS1ArNUZiMXcr?=
 =?utf-8?B?SE1aYWw0S2h3Y0hGc1cyM0ppbkpPMm1WN0lSZmZ3VkpPd2g3a3U2WmFDY1VD?=
 =?utf-8?B?ZHBGRmc1UUZlcEpvTmc2eC9hYXAzdmdGRW5aU29lL1lFY3FLZXRzbWhpejFI?=
 =?utf-8?B?b3RScEJhcFFBb01IMnExSU8za0plWkY4bTRpZVJRTGlnM2UzSFNFNUNrZGtK?=
 =?utf-8?B?RVJvb29DbWNRQnpoUUZVakRxclFXWFhJeDBRcnM3UWgya0hkenBScjYza3J5?=
 =?utf-8?B?UU41VzFoZU5LdlpLdXZZYnlBaEZUeDJJSmNFMktXckFGTm9icCtxSGJHTlVE?=
 =?utf-8?B?OGNiNlNtU2xIdk1ocFBpR1dQNzZBTXNKcGhtVktIZlFiT2o3L1VkRlpYdDM2?=
 =?utf-8?B?YjFQQWVOZGU1ODVPYWVxUlU0QVB4dnNkSmFFSGFiUEJPUC90VkV6MERHamxG?=
 =?utf-8?B?cFRVUEIzMDBqY1plZHkyeWJWWWhIZ0M1VGZuWXZQRTRDOXdGNnF3UFFWeUJa?=
 =?utf-8?B?aXVvMFloMlVLd3hFMUxHR3BaRFppSkpQVlpsTFBwbkVRVEE0d3pYbGwwMWJH?=
 =?utf-8?B?Tmk1M0JzUlVUNHFyb3NFZ04rV2xwaU81WUhDeC9RajRDR0lKTStVWkpQUTFK?=
 =?utf-8?B?R3hJY3JFKzV2aXg5U0Z4L1VDVmt2cjBiUlRNL2dJNFkza1AyMTI4SDFQbXAr?=
 =?utf-8?B?czNxU1FLdTY3eW5YbzdJQVJzYVFKd2pObEY1alV0TlRwY3krbm4yZEt2UUlj?=
 =?utf-8?B?TkRCQzN2ODR2NlBhalZmb0M2bktRTTdMWTZSUEZuZ1ZBcEtqOUtES09sTUpN?=
 =?utf-8?B?enIxYmNhTm5PQTJRSS8wMFk3SGJnSUQwaWJiOTNVUkFUbzRaUVBRWWo5eGZS?=
 =?utf-8?B?Vkptb3ZFN214WExaVm5kYy9yREtCcUNLSG93SDBrYS94L3F3RDlFRWRXU01p?=
 =?utf-8?B?REVyNTJieit3RUJNVVV6bjliSWFGTFVjOUNSbW5zSGtVbmw3ZGVVQzhjOG1K?=
 =?utf-8?B?ak5JSjRjL0RnTUV6aDlpdDBDekVuMXdhT2xZcTJ1NXd4bjRyWXJQeEFpWlhz?=
 =?utf-8?B?U2hmT1p5ZVJGdzZKQ1hMekdjeVJMVXltU0RsTndXSSszc0tzZjMxSW1xb1dP?=
 =?utf-8?B?Z0g4c0UzVnc5NktvUnVRSkRYelJod3hnMFU3UWM4clN4OGF1bjNsQmZ6Qmgz?=
 =?utf-8?Q?qoq/s1Bcx8KYzkCTLB7PGRQ4HpDl4EWg42y309V?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f78c48c-3ce8-4e90-1fa6-08d93a2361e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 10:56:28.9543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aO2lysDRo2vlrAK9/shiSLBoLy4vkgIZG78BSDUX5UPuuCDw2ktVnTCq9/rLFNigjLKQtzgKixtLOu2VoAneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSnVuZSAyOCwgMjAyMSAxMDozMyBBTQ0KPiANClsuLl0NCg0KPiA+Pg0KPiA+PiBJIGRvbid0
IHNlZSB3aHkgaXQgbmVlZHMgdHlwZWNhc3QsIHZpcnRpb19uZXRfY29uZmlnIGlzIGFsc28gdUFC
SSwNCj4gPj4geW91IGNhbiBkZWZlcmVuY2UgdGhlIGZpZWxkcyBkaXJlY3RseS4NCj4gPj4NCj4g
PiBVc2VyIHdhbnRzIHNldCBvbmx5IHRoZSBtYWMgYWRkcmVzcyBvZiB0aGUgY29uZmlnIHNwYWNl
LiBIb3cgZG8gdXNlcg0KPiBzcGFjZSB0ZWxsIHRoaXM/DQo+IA0KPiANCj4gR29vZCBxdWVzdGlv
biwgYnV0IHdlIG5lZWQgZmlyc3QgYW5zd2VyOg0KPiANCj4gIkRvIHdlIGFsbG93IHVzZXJzcGFj
ZSBzcGFjZSB0byBtb2RpZnkgb25lIHNwZWNpZmljIGZpZWxkIG9mIGFsbCB0aGUgY29uZmlnPyIN
Cj4gDQpFdmVuIGlmIHdlIHJlc3RyaWN0IHRvIHNwZWNpZnkgY29uZmlnIHBhcmFtcyBhdCBjcmVh
dGlvbiB0aW1lLCBxdWVzdGlvbiBzdGlsbCByZW1haW5zIG9wZW4gaG93IHRvIHBhc3MsIGVpdGhl
ciBhcyB3aG9sZSBzdHJ1Y3QgKyBzaWRlX2Jhc2VkIGluZm8gb3IgYXMgaW5kaXZpZHVhbCBmaWVs
ZHMuDQpNb3JlIGJlbG93Lg0KDQo+IA0KPiA+IFBhc3MgdGhlIHdob2xlIHZpcnRpb19uZXRfY29u
ZmlnIGFuZCBpbmZvcm0gdmlhIHNpZGUgY2hhbm5lbD8NCj4gDQo+IA0KPiBUaGF0IGNvdWxkIGJl
IGEgbWV0aG9kLg0KSSBwcmVmZXIgdGhlIG1ldGhvZCB0byBwYXNzIGluZGl2aWR1YWwgZmllbGRz
IHdoaWNoIGhhcyB0aGUgY2xlYW4gY29kZSBhcHByb2FjaCBhbmQgZnVsbCBmbGV4aWJpbGl0eS4N
CkNsZWFuIGNvZGUgPSANCjEuIG5vIHR5cGVjYXN0aW5nIGJhc2VkIG9uIGxlbmd0aA0KMi4gc2Vs
Zi1kZXNjcmliaW5nIGZpZWxkcywgZG8gbm90IGRlcGVuZHMgb24gZmVhdHVyZSBiaXRzIHBhcnNp
bmcNCjMuIHByb29mIGFnYWluc3Qgc3RydWN0dXJlIHNpemUgaW5jcmVhc2VzIGluIGZ1bGx5IGJh
Y2t3YXJkL2ZvcndhcmQgY29tcGF0aWJpbGl0eSB3aXRob3V0IGNvZGUgY2hhbmdlcw0KDQo+IA0K
PiANCj4gPiBPciB2ZW5kb3IgZHJpdmVyIGlzIGV4cGVjdGVkIHRvIGNvbXBhcmUgd2hhdCBmaWVs
ZHMgY2hhbmdlZCBmcm9tIG9sZA0KPiBjb25maWcgc3BhY2U/DQo+IA0KPiANCj4gU28gSSB0aGlu
ayB3ZSBuZWVkIHNvbHZlIHRoZW0gYWxsLCBidXQgbmV0bGluayBpcyBwcm9iYWJseSB0aGUgd3Jv
bmcNCj4gbGF5ZXIsIHdlIG5lZWQgdG8gc29sdmUgdGhlbSBhdCB2aXJ0aW8gbGV2ZWwgYW5kIGxl
dCBuZXRsaW5rIGEgdHJhbnNwb3J0DQo+IGZvciB0aGVtIHZpcnRpbyB1QVBJL0FCSS4NCkluIHNw
aXJpdCBvZiB1c2luZyB0aGUgdmlydGlvIFVBUEkgc3RydWN0dXJlLCB3ZSBjcmVhdGluZyBvdGhl
ciBzaWRlIGJhbmQgZmllbGRzLCB0aGF0IHJlc3VsdHMgaW50byBjb2RlIHRoYXTigJlzIG5vdCBj
b21tb24gdG8gbmV0bGluayBtZXRob2QuDQpJb2N0bCgpIGludGVyZmFjZSBvZiBRRU1VL3Zob3N0
IGRpZG4ndCBoYXZlIGFueSBvdGhlciBjaG9pY2Ugd2l0aCBpb2N0bCgpLg0KDQo+IA0KPiBBbmQg
d2UgbmVlZCB0byBmaWd1cmUgb3V0IGlmIHdlIHdhbnQgdG8gYWxsb3cgdGhlIHVzZXJzcGFjZSB0
byBtb2RpZnkNCj4gdGhlIGNvbmZpZyBhZnRlciB0aGUgZGV2aWNlIGlzIGNyZWF0ZWQuIElmIG5v
dCwgc2ltcGx5IGJ1aWxkIHRoZQ0KPiB2aXJ0aW9fbmV0X2NvbmZpZyBhbmQgcGFzcyBpdCB0byB0
aGUgdkRQQSBwYXJlbnQgZHVyaW5nIGRldmljZSBjcmVhdGlvbi4NCkkgbGlrZSB0aGlzIGlkZWEg
dG8gcGFzcyBmaWVsZHMgYXQgY3JlYXRpb24gdGltZS4NCg0KPiBJZiBub3QsIGludmVudCBuZXcg
dUFQSSBhdCB2aXJ0aW8gbGV2ZWwgdG8gcGFzc2luZyB0aGUgY29uZmlnIGZpZWxkcy4NCj4gVmly
dGlvIG9yIHZEUEEgY29yZSBjYW4gcHJvdmlkZSB0aGUgbGlicmFyeSB0byBjb21wYXJlIHRoZSBk
aWZmZXJlbmNlLg0KPiANCg0KPiBNeSBmZWVsaW5nIGlzIHRoYXQsIGlmIHdlIHJlc3RyaWN0IHRv
IG9ubHkgc3VwcG9ydCBidWlsZCB0aGUgY29uZmlnDQo+IGR1cmluZyB0aGUgY3JlYXRpb24sIGl0
IHdvdWxkIHNpbXBseSBhIGxvdCBvZiB0aGluZ3MuIEFuZCBJIGRpZG4ndA0KPiBub3RpY2UgYSB1
c2UgY2FzZSB0aGF0IHdlIG5lZWQgdG8gY2hhbmdlIHRoZSBjb25maWcgZmllbGRzIGluIHRoZSBt
aWRkbGUNCj4gdmlhIHRoZSBtYW5hZ2VtZW50IEFQSS90b29sLg0KPiANClN1cmUgeWVzLiBXaGlj
aGV2ZXIgY29uZmlnIGZpZWxkcyB1c2VyIHdhbnRzIHRvIHBhc3MsIHVzZXIgc3BhY2UgcGFzc2Vz
IGl0Lg0KDQo+ID4+IEZvciB2aXJpdG9fbmV0X2NvbmZpZywgd2h5IG5vdCBzaW1wbHk6DQo+ID4+
DQo+ID4+IGxlbiA9IG9wcy0+Z2V0X2NvbmZpZ19sZW4oKTsNCj4gPj4gY29uZmlnID0ga21hbGxv
YyhsZW4sIEdGUF9LRVJORUwpOw0KPiA+PiBvcHMtPmdldF9jb25maWcodmRldiwgMCwgY29uZmln
LCBsZW4pOw0KPiA+PiBubGFfcHV0KHNrYiwgVklSVElPX0NPTkZJRywgY29uZmlnLCBsZW4pOw0K
PiA+IFVzZXIgc3BhY2UgbmVlZCB0byBwYXJzZSBjb250ZW50IGJhc2VkIG9uIHRoaXMgbGVuZ3Ro
IGFzIGl0IGNhbiBjaGFuZ2UgaW4NCj4gZnV0dXJlLg0KPiA+IExlbmd0aCB0ZWxsaW5nIGhvdyB0
byB0eXBlY2FzdCBpcyB3YW50IEkgd2FudCB0byBhdm9pZCBoZXJlLg0KPiANCj4gDQo+IFNvIHRo
ZXJlJ3Mgbm8gcmVhbCBkaWZmZXJlbmNlLCB1c2luZyB4eHhfaXNfdmFsaWQsIGlzIGp1c3QgYSBp
bXBsaWNpdA0KPiBsZW5ndGggY2hlY2tpbmcgYXMgd2hhdCBpcyBkb25lIHZpYSBjb25maWdfbGVu
Og0KPiANCj4gaWYgKGFfaXNfdmFsaWQpIHsNCj4gIMKgwqDCoCAvKiBkdW1wIGEgKi8NCj4gfSBl
bHNlIGlmIChiX2lzX3ZhbGlkKSB7DQo+ICDCoMKgwqAgLyogZHVtcCBiICovDQo+IH0NCj4gDQo+
IHZzLg0KPiANCj4gaWYgKGxlbmd0aCA8IG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
ZywgbmV4dCBmaWVsZCBvZiBhKSkgew0KPiAgwqDCoMKgIC8qIGR1bXAgYSovDQorIHRoZSBmZWF0
dXJlIHBhcnNpbmcgY29kZSwgZm9yIGVhY2ggZmllbGQuDQoNCj4gfQ0KPiANCj4gQWN0dWFsbHks
IFFlbXUgaGFzIHNvbHZlZCB0aGUgc2ltaWxhciBpc3N1ZXMgdmlhIHRoZSB1QVBJOg0KPiANCj4g
aHR0cHM6Ly9naXQucWVtdS5vcmcvP3A9cWVtdS5naXQ7YT1ibG9iO2Y9aHcvbmV0L3ZpcnRpby0N
Cj4gbmV0LmM7aD1iZDc5NThiOWYwZWVkMjcwNWUwZDZhMmZlYWVhZWZiNWU2M2JkNmE0O2hiPUhF
QUQjbDkyDQo+IA0KPiBJZiB0aGUgY3VycmVudCB1QVBJIGlzIG5vdCBzdWZmaWNpZW50LCBsZXQn
cyB0d2VhayBpdC4NCkkgYW0gdW5hYmxlIHRvIGNvbnZpbmNlIG15IHNlbGYgdG8gYnVpbGQgc2lk
ZSBiaXRtYXNrIGZvciBjb25maWcgZmllbGRzLCB0eXBlIGNhc3RpbmcgY29kZSBpbiBzcGlyaXQg
b2YgdXNpbmcgZXhpc3Rpbmcgc3RydWN0dXJlIFVBUEkuDQpUaGlzIGNyZWF0ZXMgbWVzc3kgY29k
ZSBmb3IgZnV0dXJlLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
