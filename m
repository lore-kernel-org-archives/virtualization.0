Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15733C48BC2
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 04:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA60160720
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 04:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA60160720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8428082948;
	Wed, 23 Jun 2021 04:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zH9SACE3mNAH; Wed, 23 Jun 2021 04:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 316548293D;
	Wed, 23 Jun 2021 04:22:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0139C001A;
	Wed, 23 Jun 2021 04:22:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4EC8C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A95B403C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8aqMPIvw1R8e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:22:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16EAC400D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 04:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx//sao5J0aJrQyP+UOg4VnzIuY00w+UcpBSzi0SZdP/uMat9rTRgEKmNwg0WPtX2wMo1MKhClqEu8Rb2cBgK86fXzquofUQJoA+Xc+rTw+NPcZYXSLceAwGClRHhkI+yj6q9T3DR5KnH9MfCO/h04h9WohIuA6iYghfZcewuOItIFhGwDTEZrGt0rC6GuokiEVQeNUWcGmGWvOTI1c48OdI7b2QVhEBHZuUQGg4YeiHt4BX7we+jWhrlhQeNCnjQAZ99d51yOxzXpZYtVoi21RsH4F9Ha7D2wNKPNnETXoDM4hUCfkYWJ49lTYDe4stKrPr/gZ4Z6mqFDhu1LZy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYhAKWXmzMGhNLleWJOMoHEfh1gn7MCaeJ+MpKnSWM=;
 b=L3+Mw/M/M0I9h9xgClnA4B2FzPyZ+a3I2YxXGp8Zq8FeJ1uqlO6UFqxOuXQbxPzDYK98KAhHW7lFSd7xf/7NZ1uFnBZvJO4quk63PJoDDOlCURhDLxHB2w8Y7hLIk/JfbbOKTiOIK2yTXkRNMuGViMAZmmw6CNkKhAlNaV5iGwTt7lzmi9qLqK42AZRmHoiNESpf9zEMfmDdp5/gbzD5J5ffm/rDXJRCDtidzS962Y2mjKpUJDQohcMluPJfZbVSM7NmPL1ppKiaHHxnljAfHUddo0Lf8u1h5tYQHEorMzX3NkC3bLrN8ZcQ/B0Ld7fKp3STzPH+nf+Ct+i2GLN6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYhAKWXmzMGhNLleWJOMoHEfh1gn7MCaeJ+MpKnSWM=;
 b=jnUVBP6S0Gyq6Xcji/e4jwQKxjaSNlStOvB3i1SDp7hHg1IpmkLIwrBtC/xksWsXvx5zTLMdaW2bqaUOEY0Jv9O0saU4pGKUyWM1rqC5TBeoWRxuLhLkpgdyIJqqR9qI/r80IwuzkVEUxHjLM6z8AEvoSqOQJoYqT7x9P3kRBk+VXiP/mU6XFMHMg3tvYp95EctYSrsFlT8jeDiXOHH4zTkQ0dIdXL1CpkI2fk0AowcmzdDNWOjiVVLsbyj1nH+3H4cPL4MzHEenvfXBaDFJ4xr8gcroMXe9aT7bTjSBotR0j57neRi81qgZGR6DEF7RaTc7/ZULWtjHGggY6XODsA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 04:22:26 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 04:22:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPA
Date: Wed, 23 Jun 2021 04:22:25 +0000
Message-ID: <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
In-Reply-To: <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4179cf8-b192-422a-384e-08d935fe818c
x-ms-traffictypediagnostic: PH0PR12MB5403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5403D9B1DB23104C633FA3BEDC089@PH0PR12MB5403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOo1tNzD8xtAht9qtM3OGbsSFmVysvUJtdearzwH4cDOPI3ss2H91aWtAu0+iA2WPq1j2/ZtmQWv41jXGC/VJNuLJQ+fzLi/MWBmq5DfWPCfke/cx98faZrPnm/hbdyfxfwfbixS91gugSlexwGs7Jbu6kJf2+PMbKLCbDtfurVCm7utk0p3aqOcE2C+nAJ3xFv8A6LHV0Tfu8hZNYc3CmTTWd5nM2jIYeoBSVZhP8y2YJ1VU7dkcAzW7Vb46iwgzqIOhnyHACBek8kHSk6EJdmzx4O+vFMLSamryzFQ7Dr97eEySJX1+hzXZgZsI2a8zdaGcW4Y6/cSMw2QvEBiDNWn19jo6BzoYoy7TRKzRWfYmeQgkNXoeiFy99CBkgPUhU7d/J/ZyD7vsHP411rIGzwiRMoERS4aP7FYzbtdOmyGm6/o6y0l8TFP2JMFQMynMYvBaMEq2iyBW0igXOfcKrAwCUqbwO8Ja7KNBLp6FdzCMN7f+t44gL8kfUXTg0Z1I2B+QT9ydMQTEF4J+pixTkT93MNPvM12jJKZwzDP5qX6AmaVgGzUnCWjWvm0HlQyiNP+zC1m24gftzWlns3tbn81BDFUngS6PvI3B8gvXV+ZpC0N4/3FoYQF06tptWgtthVx2APc/+bVidcZpteTTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(9686003)(55016002)(2906002)(478600001)(5660300002)(122000001)(107886003)(38100700002)(76116006)(186003)(52536014)(8676002)(71200400001)(4326008)(86362001)(6506007)(66946007)(66446008)(66476007)(66556008)(64756008)(26005)(83380400001)(8936002)(7696005)(33656002)(110136005)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJRWDI4b0MzYnNjS3pQVE5aRTlqVnROQVdCY0E0VUpRM1lDWXlldElURGZz?=
 =?utf-8?B?emw1WW1hb3ZYcVl2QWRHQjlqTG5hSXY1dE1ZaUJWOWh5bWVZVkdHc0V2WFlP?=
 =?utf-8?B?QVhTSm9LcjJkekYySEplNXZjS3dYRHBaTzZQTlBvQXp2dE9JSkZPQStpMUtJ?=
 =?utf-8?B?UlNPU0FCb0lKOTJaOUVST1RHdXpYWWxlSDRCbThoakRHWm83UUlGTEdwNVRQ?=
 =?utf-8?B?c1BzbUo0bzFrM2dMa1ZITVkwd2xUdzdmeWpPUVZ2NDR4a01wYUswQ28vdGZ1?=
 =?utf-8?B?Nk9aOG9MMzRhOE8vM3k0eXM2SzRkelIvb2F3MStyUVUrTHRaakpjTitQZXB1?=
 =?utf-8?B?WjcwYXpLaXBncTltVUtKcUxXMy9od3lOVmJsZm9pTXhRc29pOTBHZE1UNjZO?=
 =?utf-8?B?d3A4TXdPU0RFTDdOd3JJeDFBMnRPK1BQeXY0cXZrZVF1RnhScnFPOTFEN0hK?=
 =?utf-8?B?ZVNJazFXRSt6dk9JVGNhZjZxUU9XekdsNjRXSkhZaGg3T1ZZQ00xV2V4WERn?=
 =?utf-8?B?STYzaHpIRFNFaUdtQTV3eE9yZ1NvTHJwTlJGa1JmQkxwSlcwdDJ1N2pxVnRL?=
 =?utf-8?B?L1VMM3hqQmxXWUk5QjVUWTJSemNYRFlwK1NzVndOYTZTd01DMTl5RmdvQ1Nv?=
 =?utf-8?B?ZUhFNjBKMVN5a21mQ2ZPODNzUnA1UnRZQ2c0YnMyUEt6cU9OOW5uZVk4aHJY?=
 =?utf-8?B?bTdKenRRM3pnK1daTE53ZjR0OHM5bUhsNEhRSlI0dmhMWXp6dTBkamtjU3hZ?=
 =?utf-8?B?RWZZRGNTR1AvV3hlYnRRamFIYmhLU2J0cnQ3aHMrUWIwbHpwbXV4VEJuTEgr?=
 =?utf-8?B?aXl4THEvZ0ZuNkI0ckJTb0d4N01Zc0creUNCeFNMTFJvVUh5Y1lFaDBGQTlU?=
 =?utf-8?B?SDhxa2RwVG0yK05ISHhxME5jd211SEdJdzlBeklIWnlSb2F3YVdPOVhtaS83?=
 =?utf-8?B?MWxRaEtvL21XbW01WDRHRnR0ems5aHVjcEtPZWpNc1k1OW96eG13eWo2VDBS?=
 =?utf-8?B?QnpqN1JqN1R0eGE2Qit2WEkyemFWL09pM2tISmxHS2hyUHB4UFN2Njd6Zmd6?=
 =?utf-8?B?RUM1dUxBUjJnYmR2RnIxdVBXUE5vZnpiMVpjeDBYRTNLZE50ekkydUxyKzB6?=
 =?utf-8?B?LzF1Mm05UFhVS2ZYWi9FRSszZUw0dmYzQVliejk1QUcyTzdpOWdlaGdvQk1h?=
 =?utf-8?B?ZWpUUXdwaWdFRGZRYVVocDFFMEtMUTBDUTJrVWQ5V1l5TEFwRG1VVjlnZTZK?=
 =?utf-8?B?WHpKdjlQdXYzMVpvelFnNy9tRVh2SjBaY3BzQjJGNkNmMUJPL2JtUFhGVzlF?=
 =?utf-8?B?c2pKdExrdTJMeXlHVUhWakM2WHRYd1ZIVm9Eb2diS1o5Tm5LMkJNZVdmR1M2?=
 =?utf-8?B?enFmZzdPck43MTlxL2h1Sk5HWG5vQ3AvTHM5WngwVnlBYUVjdUM4RlBRSG0y?=
 =?utf-8?B?bFl5azUzS3Frak9rVXBpd3JEcGp0ZlUwRTFTVmdSVHBhNFBtRWk3RHkyOTFS?=
 =?utf-8?B?YWlGNmF6SFk1RlEvbVp2dHlqYXA1bVRuaHJ4dVlCWU9iVy9LS1R4OWVMeGJ3?=
 =?utf-8?B?K2xGeGJoODVDWHZYYVp4MnNpQVNrQzh2Q0VXenRJSXpmUWpXM0orNVZ1OFlQ?=
 =?utf-8?B?TjlHN09EbC96RTB0NXlJcytCRmdQT2laekxIdjZvUEhEZXM0M0FPeFlRRXNv?=
 =?utf-8?B?Q21XanNObXJPOXdid3ZNcytJMjhCRys1YllpejNyZk0xZnZGQ0FSa252TTZi?=
 =?utf-8?Q?+T1Tq/0oB4xJ25FfK/VGV0xAQ9yLDCcG0ZL00WN?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4179cf8-b192-422a-384e-08d935fe818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 04:22:25.9438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +A4ntJyB3hv+g2Jnwza5b5Ihoc0gbUEpK4kh+PV70vrDnABM35bg0rOvvDynW6MJ2T8/V/XrjoIDxz3vQEkvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDIzLCAyMDIxIDk6MzkgQU0NCj4gDQo+IOWcqCAyMDIxLzYvMjIg5LiL5Y2I
MTA6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4+IElzIGl0IGJldHRlciB0byB1c2UgYSBz
ZXBhcmF0ZSBlbnVtIGZvciBuZXQgc3BlY2lmaWMgYXR0cmlidXRlcz8NCj4gPj4NCj4gPiBZZXMs
IGJlY2F1c2UgdGhleSBhcmUgb25seSBuZXQgc3BlY2lmaWMuDQo+ID4gSSBndWVzcyBpdCBpcyBy
ZWxhdGVkIHRvIHlvdXIgYmVsb3cgcXVlc3Rpb24uDQo+ID4NCj4gPj4gQW5vdGhlciBxdWVzdGlv
biAoc29ycnkgaWYgaXQgaGFzIGJlZW4gYXNrZWQgYmVmb3JlKS4gQ2FuIHdlIHNpbXBseQ0KPiA+
PiByZXR1cm4gdGhlIGNvbmZpZyAoYmluYXJ5KSB0byB0aGUgdXNlcnNwYWNlLCB0aGVuIHVzZXNw
YWNlIGNhbiB1c2UNCj4gPj4gdGhlIGV4aXN0aW5nIHVBUEkgbGlrZSB2aXJ0aW9fbmV0X2NvbmZp
ZyBwbHVzIHRoZSBmZWF0dXJlIHRvIGV4cGxhaW4gdGhlDQo+IGNvbmZpZz8NCj4gPj4NCj4gPiBX
ZSBkaWQgZGlzY3VzcyBpbiB2Mi4NCj4gPiBVc3VhbGx5IHJldHVybmluZyB0aGUgd2hvbGUgYmxv
YiBhbmQgcGFyc2luZyBpcyBub3QgZGVzaXJlZCB2aWEgbmV0bGluay4NCj4gPiBSZXR1cm5pbmcg
aW5kaXZpZHVhbCBmaWVsZHMgZ2l2ZSB0aGUgZnVsbCBmbGV4aWJpbGl0eSB0byByZXR1cm4gb25s
eSB0aGUgdmFsaWQNCj4gZmllbGRzLg0KPiA+IE90aGVyd2lzZSB3ZSBuZWVkIHRvIGltcGxlbWVu
dCBhbm90aGVyIGJpdG1hc2sgdG9vIHRvIHRlbGwgd2hpY2ggZmllbGRzDQo+IGZyb20gdGhlIHN0
cnVjdCBhcmUgdmFsaWQgYW5kIHNoYXJlIHdpdGggdXNlciBzcGFjZS4NCj4gPiBSZXR1cm5pbmcg
aW5kaXZpZHVhbCBmaWVsZHMgaXMgdGhlIHdpZGVseSB1c2VkIGFwcHJvYWNoLg0KPiANCj4gDQo+
IFRoZSBtYWluIGNvbmNlcm5zIGFyZToNCj4gDQo+IDEpIFRoZSBibG9iIHdpbGwgYmUgc2VsZiBj
b250YWluZWQgaWYgaXQgd2FzIHBhc3NlZCB3aXRoIHRoZSBuZWdvdGlhdGVkDQo+IGZlYXR1cmVz
LCBzbyB3ZSBkb24ndCBuZWVkIGJpdG1hc2suDQpXaGljaCBmaWVsZHMgb2YgdGhlIHN0cnVjdCBh
cmUgdmFsaWQgaXMgdG9sZCBieSBhZGRpdGlvbmFsIGZpZWxkcy4NCj4gMikgVXNpbmcgaW5kaXZp
ZHVhbCBmaWVsZHMgbWVhbnMgaXQgbXVzdCBkdXBsaWNhdGUgdGhlIGNvbmZpZyBmaWVsZHMgb2Yg
ZXZlcnkNCj4gdmlydGlvIGRldmljZXMNCj4gDQpNb3N0bHkgbm8uIGlmIHRoZXJlIGFyZSBjb21t
b24gY29uZmlnIGZpZWxkcyBhY3Jvc3MgdHdvIGRldmljZSB0eXBlcywgdGhleSB3b3VsZCBiZSBu
YW1lZCBhcw0KVkRQQV9BVFRSX0RFVl9DRkdfKg0KTmV0IHNwZWNpZmljIHdpbGwgYmUsDQpWRFBB
X0FUVFJfREVWX05FVF9DRkdfKg0KQmxvY2sgc3BlY2lmaWMsIHdpbGwgYmUsDQpWRFBBX0FUVFJf
REVWX0JMS19DRkdfKg0KDQo+IEFuZCBhY3R1YWxseSwgaXQncyBub3QgdGhlIGJpbmFyeSBibG9i
IHNpbmNlIHVhcGkgY2xlYXJseSBkZWZpbmUgdGhlIGZvcm1hdCAoZS5nDQo+IHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyksIGNhbiB3ZSBmaW5kIGEgd2F5IHRvIHVzZSB0aGF0PyBFLmcgaW50cm9k
dWNlDQo+IGRldmljZS9uZXQgc3BlY2lmaWMgY29tbWFuZCBhbmQgcGFzc2luZyB0aGUgYmxvYiB3
aXRoIGxlbmd0aCBhbmQNCj4gbmVnb3RpYXRlZCBmZWF0dXJlcy4NCkxlbmd0aCBtYXkgY2hhbmdl
IGluIGZ1dHVyZSwgbW9zdGx5IGV4cGFuZC4gQW5kIHBhcnNpbmcgYmFzZWQgb24gbGVuZ3RoIGlz
IG5vdCBzdWNoIGEgY2xlYW4gd2F5Lg0KUGFyc2luZyBmaWVsZHMgcmVxdWlyZSBrbm93bGVkZ2Ug
b2YgZmVhdHVyZXMgYXMgd2VsbCBhbmQgYXBwbGljYXRpb24gbmVlZHMgdG8gbWFrZSBtdWx0aXBs
ZSBuZXRsaW5rIGNhbGxzIHRvIHBhcnNlIHRoZSBjb25maWcgc3BhY2UuDQpJIHByZWZlciB0byBm
b2xsb3cgcmVzdCBvZiB0aGUga2VybmVsIHN0eWxlIHRvIHJldHVybiBzZWxmIGNvbnRhaW5lZCBp
bnZpZGl2aWR1YWwgZmllbGRzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
