Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7FEC433E0
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 18:41:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AE922A83
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 18:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AE922A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B509885C05;
	Mon, 11 Jan 2021 18:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LmmVCNujyKMz; Mon, 11 Jan 2021 18:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0A268578B;
	Mon, 11 Jan 2021 18:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5DC3C088B;
	Mon, 11 Jan 2021 18:41:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E29EBC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C6F6086C1D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QMTkzbFLFVdS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:41:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1ECCF86762
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvd1Sn4j3+/QOnhyVnUpwWOqFBBaBjk8LshgVi6vcFeCL8/5TWeisM16QlAAvwqPnQhAlHqE+uLDMGgvfD/cF/LKM4M63Atpy1oN4V+nfJJgm7Sl2KbPccUYYd7mKKgS82/GogurjHo92g8ymbOL4dMuXIYXPakw4p+CY0+iHGMYjgNSAZIG4bC7gZJpGXlosqR5XxKcllfeTyiO8faeutAKTVZWHzekuXD+GT0+N/b7QDD46xWh76ujCwtfGMPp1M8zgsrhyMYVycUWqMXqXi2kIrUfqJ79yD8zqRUAothHyvWXFp/DroKvo1oS2IvnZZ+c6nxS0QdJ7qvjmEJvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9N8QIvGvXzx0iQ2tmnXkTA7ws+OXVvRQPTpDrpNcg4=;
 b=LnTWjgRUKl4KwKlknbqGEXDI0hkMJVVyj2dEWfO+w0YqCdxMv/kthBSECwNXyj6DUcnA+GQJPjWkbda5AFDED/be4fBJP50TZjPIdDp44qlHPaPOpSNA6ZkGk7Az3cbfqioQW537c5KflsloaI9w+KuADTPW0IV55fJdGOFEzluUIz8xGORPc+ZkbKej2b9zryY+EkssPwont5hOKYbt4EwTBSQuHKmT1uf/5Q5NmimcGdY4J7uFTz2dWqQcyR3uEspPBA/EUlnMwJPEHXekY5FcL2Y6eKVEMFB6iBo0LyibS9VCEO79Ug6U9xbH8VGhdRHhUDfjTlUO7WGwvtg9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9N8QIvGvXzx0iQ2tmnXkTA7ws+OXVvRQPTpDrpNcg4=;
 b=AcWW0OJOQG9fbLC9Ru+ZlR6EuJNJZGN7LF2qRaDg1+BM/CLUTYIIHj5vnpqWJr84w1Av+NXzXlbGJOUvfVXYbmXB2fUEhRz2z+z5nHurow1xTiW+ecP4QBb5aN27Ix8pCIjKQcLBkzHzWsfjzncoMS2GdaOvyn3h3aTZEdx42P0=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DM6PR05MB6250.namprd05.prod.outlook.com (2603:10b6:5:116::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.3; Mon, 11 Jan 2021 14:05:56 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::688e:f536:937d:30af]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::688e:f536:937d:30af%5]) with mapi id 15.20.3763.008; Mon, 11 Jan 2021
 14:05:56 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Thread-Topic: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Thread-Index: AQHW6BP3A8HW/guArUOQbzIvYaI8UqoiX3wAgAAWG4A=
Date: Mon, 11 Jan 2021 14:05:56 +0000
Message-ID: <4D53036F-FB61-4730-87D9-4EB6B350B17F@vmware.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
 <X/xItnTyAa7OwSEI@kroah.com>
In-Reply-To: <X/xItnTyAa7OwSEI@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-originating-ip: [83.92.5.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c7a4d44-deaa-411b-9d6b-08d8b63a03fc
x-ms-traffictypediagnostic: DM6PR05MB6250:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB6250E64C94B2AEA7A8FB0025DAAB0@DM6PR05MB6250.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmUxi1rT9tigOE6e0A9sGQGgQc3Xfetw8CwHhkHCItUpuHTWRMUf1powt179IZURUK4lnoI3XcqukoLuTU9PF1AXd58WOzBTEzOeYZ5IJbOWz7GKirvm67g8jxRw5f5G9MKvoLQddxHiRxPnBcyhoZ3+GHfx7G7DopP15T7KhGkOrJrvEn6Q4lwi5XZ4vTRHa+cL9L14zszhjyupKMeBSN634E3yi4r1uOizrL0ZnYyyoRGR25kEBhYyLdE+hnDwWHLA0RHrUYwEJsGyV0S5jfDIbBlkTY7KSWY6RdC9IuWyRuJ/bx6HW7XW224L28ph5tkg6XJE5agFgrca5RuP3TXtCLaigIKywdnDuKeusOiP9ii+OxcR0QkXidgCLe2DpWiqQv2mTKfCE1H6xz2BnyBYrLU5qfAYNCLBPlUAprY2hxTJvs2y9nqlNSNcIXPQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR05MB3452.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(4326008)(478600001)(36756003)(83380400001)(53546011)(6506007)(186003)(8676002)(54906003)(26005)(2906002)(6512007)(6916009)(316002)(2616005)(8936002)(5660300002)(64756008)(91956017)(66476007)(66556008)(76116006)(66446008)(33656002)(86362001)(66946007)(6486002)(71200400001)(107886003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlgyM1ovbC80TnpJSVVpUFB4VytKRFJwd0lqN1JWMHRaZXZsNXF0VEo1ell4?=
 =?utf-8?B?TTJaRys5emxDNjFMUnRFZTJFQ2VlYnV5NXZ4RUU2emtMUTlYTHAwSFo1Y3Ra?=
 =?utf-8?B?aDNSOGxYVWJEM0l0ajNlbU8wY1BWTERHSmJmc1I5OTdVR2hOdTFoUHhqQm1k?=
 =?utf-8?B?QnZySElDV0lhSVhKbStmWHlDeXdqSkNvNDZUcmRHcngrUGF6eE5sUnRNM2Jy?=
 =?utf-8?B?MmZQb0hFdVBYQXVWRjF0UXRuSkpXWi9ueEJqQXN5SmpkNFZDTS8vWVpMY1dC?=
 =?utf-8?B?c3pleEpGS0kvWEJXclg1RFl6MkVlYkN6dnVTNmZNcmNWVFZicVpEeElkZDhq?=
 =?utf-8?B?NFNLa2NITlJEK1dRSy95YUwvZXQxU3pJR25TZG9RYTl6UDBSUjd3NkQyQnFq?=
 =?utf-8?B?RVpPTmpjTDVQenlLTFBza1FtY1A3WGRqdHlZOUdXU2dIbmRGQjRIMGlUSHd5?=
 =?utf-8?B?clVmOC9IaGJJTUtIR0xxbDE2Y2FkRXZVWTBXa0k3bDhZTkZWMTA0MkxTM0Q3?=
 =?utf-8?B?REw5NWYrRWpOLzFTVXpTYzQvV0p4bFd0TzBOU1dzN29QUTRGeDlpbGlQekxY?=
 =?utf-8?B?dGxZdWxOenNhRTNzRGc1RVMra1BYWnJIa21wNkVzbWFHaW4xKzlqaU1wbmNk?=
 =?utf-8?B?SjZoc1BIQ1V2d0l6cktGdS81MFJvNm1keldGTE9hakN2WTk2cW0xUEJ5L0c3?=
 =?utf-8?B?Qm04V2hYbFJlaWY5Q2ZGU3FpTHlZaGpRQmI3SXdtbmc0cUdyYVk3eWZHVlUx?=
 =?utf-8?B?bEZ2V0p6R1IvdEI1MkZpNTBCV0lnZFhScU10OGUwT3k3K0tSamRiSTVFTGJt?=
 =?utf-8?B?bXJVd1cxUi9BaHF2TnJCWHJURHY0MGh6RXhTWGg1OGw0bWIvVzAxdVlMSU1F?=
 =?utf-8?B?S3JFNTBZK2dwaXgvMm9tNHZ4Z0ZPRWl4NEZFTTlvb2tTeFlLYXVVQmU4UjRs?=
 =?utf-8?B?KzhkbWVteWRFeWhSbDYzMmdNbWlCbDJZZmdKL0ZyS0lUaVhSRkdLeFc0QXZ1?=
 =?utf-8?B?Y1FZM3FTRVBaYmR1NTJKVmRGbXVVT09DOTk5K1RXVjA2RTNGK0p0SDQwMENK?=
 =?utf-8?B?c3B0M2Eza0wrR0toOXE5QTNxSjhoK3JjR1JYdkx6MTFOUDdhbGJyOUFvM0d6?=
 =?utf-8?B?NFVLcmlTZ0tTdDk1ZldFWktWTVFVSklMVjB6L24xUUhuU3RtYTdieHdja1Rx?=
 =?utf-8?B?STJ2R0c1UWhONXRTdnpzUnVyYytBR09STExtaDJIUzFRcFhpWG1GWHltQlU0?=
 =?utf-8?B?QUVyVTBIVW9ITkJxQVFYdnZ0SmwyVFB6aURlKytPQXUyNnVmVjMveGRhRG1H?=
 =?utf-8?Q?JQdVIEy42dvevaNO1ugBxP6YpeBI2Vs2u7?=
Content-ID: <1D969ED034DC9D418965142EDEDE7098@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7a4d44-deaa-411b-9d6b-08d8b63a03fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 14:05:56.3251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lq7bxDNC/aVawxzsyr0MXM2YOBd70aRWO+3pj+Zpor1cNIY+hY399wa89U3PNY8QMNOnMNoc5JnY5mIC71k2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6250
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gMTEgSmFuIDIwMjEsIGF0IDEzOjQ2LCBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEphbiAxMSwgMjAyMSBhdCAwNDoxODo1M0FNIC0w
ODAwLCBKb3JnZW4gSGFuc2VuIHdyb3RlOg0KPj4gV2hlbiBjcmVhdGUgdGhlIFZNQ0kgcXVldWUg
cGFpciB0cmFja2luZyBkYXRhIHN0cnVjdHVyZXMgb24gdGhlIGhvc3QNCj4+IHNpZGUsIHRoZSBJ
T0NUTCBmb3IgY3JlYXRpbmcgdGhlIFZNQ0kgcXVldWUgcGFpciBkaWRuJ3QgdmFsaWRhdGUNCj4+
IHRoZSBxdWV1ZSBwYWlyIHNpemUgcGFyYW1ldGVycy4gVGhpcyBjaGFuZ2UgYWRkcyBjaGVja3Mg
Zm9yIHRoaXMuDQo+PiANCj4+IFRoaXMgYXZvaWRzIGEgbWVtb3J5IGFsbG9jYXRpb24gaXNzdWUg
aW4gcXBfaG9zdF9hbGxvY19xdWV1ZSwgYXMNCj4+IHJlcG9ydGVkIGJ5IG5zbHVzYXJla0BnbXgu
bmV0LiBUaGUgY2hlY2sgaW4gcXBfaG9zdF9hbGxvY19xdWV1ZQ0KPj4gaGFzIGFsc28gYmVlbiB1
cGRhdGVkIHRvIGVuZm9yY2UgdGhlIG1heGltdW0gcXVldWUgcGFpciBzaXplDQo+PiBhcyBkZWZp
bmVkIGJ5IFZNQ0lfTUFYX0dVRVNUX1FQX01FTU9SWS4NCj4+IA0KPj4gVGhlIGZpeCBoYXMgYmVl
biB2ZXJpZmllZCB1c2luZyBzYW1wbGUgY29kZSBzdXBwbGllZCBieQ0KPj4gbnNsdXNhcmVrQGdt
eC5uZXQuDQo+PiANCj4+IFJlcG9ydGVkLWJ5OiBuc2x1c2FyZWtAZ214Lm5ldA0KPj4gUmV2aWV3
ZWQtYnk6IFZpc2hudSBEYXNhIDx2ZGFzYUB2bXdhcmUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
Sm9yZ2VuIEhhbnNlbiA8amhhbnNlbkB2bXdhcmUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL21p
c2Mvdm13X3ZtY2kvdm1jaV9xdWV1ZV9wYWlyLmMgfCAxMiArKysrKysrKy0tLS0NCj4+IGluY2x1
ZGUvbGludXgvdm13X3ZtY2lfZGVmcy5oICAgICAgICAgICB8ICA0ICsrLS0NCj4+IDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IEhpLA0KPiAN
Cj4gVGhpcyBpcyB0aGUgZnJpZW5kbHkgcGF0Y2gtYm90IG9mIEdyZWcgS3JvYWgtSGFydG1hbi4g
IFlvdSBoYXZlIHNlbnQgaGltDQo+IGEgcGF0Y2ggdGhhdCBoYXMgdHJpZ2dlcmVkIHRoaXMgcmVz
cG9uc2UuICBIZSB1c2VkIHRvIG1hbnVhbGx5IHJlc3BvbmQNCj4gdG8gdGhlc2UgY29tbW9uIHBy
b2JsZW1zLCBidXQgaW4gb3JkZXIgdG8gc2F2ZSBoaXMgc2FuaXR5IChoZSBrZXB0DQo+IHdyaXRp
bmcgdGhlIHNhbWUgdGhpbmcgb3ZlciBhbmQgb3ZlciwgeWV0IHRvIGRpZmZlcmVudCBwZW9wbGUp
LCBJIHdhcw0KPiBjcmVhdGVkLiAgSG9wZWZ1bGx5IHlvdSB3aWxsIG5vdCB0YWtlIG9mZmVuY2Ug
YW5kIHdpbGwgZml4IHRoZSBwcm9ibGVtDQo+IGluIHlvdXIgcGF0Y2ggYW5kIHJlc3VibWl0IGl0
IHNvIHRoYXQgaXQgY2FuIGJlIGFjY2VwdGVkIGludG8gdGhlIExpbnV4DQo+IGtlcm5lbCB0cmVl
Lg0KPiANCj4gWW91IGFyZSByZWNlaXZpbmcgdGhpcyBtZXNzYWdlIGJlY2F1c2Ugb2YgdGhlIGZv
bGxvd2luZyBjb21tb24gZXJyb3IocykNCj4gYXMgaW5kaWNhdGVkIGJlbG93Og0KPiANCj4gLSBZ
b3Ugc2VudCBtdWx0aXBsZSBwYXRjaGVzLCB5ZXQgbm8gaW5kaWNhdGlvbiBvZiB3aGljaCBvbmVz
IHNob3VsZCBiZQ0KPiAgYXBwbGllZCBpbiB3aGljaCBvcmRlci4gIEdyZWcgY291bGQganVzdCBn
dWVzcywgYnV0IGlmIHlvdSBhcmUNCj4gIHJlY2VpdmluZyB0aGlzIGVtYWlsLCBoZSBndWVzc2Vk
IHdyb25nIGFuZCB0aGUgcGF0Y2hlcyBkaWRuJ3QgYXBwbHkuDQo+ICBQbGVhc2UgcmVhZCB0aGUg
c2VjdGlvbiBlbnRpdGxlZCAiVGhlIGNhbm9uaWNhbCBwYXRjaCBmb3JtYXQiIGluIHRoZQ0KPiAg
a2VybmVsIGZpbGUsIERvY3VtZW50YXRpb24vU3VibWl0dGluZ1BhdGNoZXMgZm9yIGEgZGVzY3Jp
cHRpb24gb2YgaG93DQo+ICB0byBkbyB0aGlzIHNvIHRoYXQgR3JlZyBoYXMgYSBjaGFuY2UgdG8g
YXBwbHkgdGhlc2UgY29ycmVjdGx5Lg0KPiANCj4gDQo+IElmIHlvdSB3aXNoIHRvIGRpc2N1c3Mg
dGhpcyBwcm9ibGVtIGZ1cnRoZXIsIG9yIHlvdSBoYXZlIHF1ZXN0aW9ucyBhYm91dA0KPiBob3cg
dG8gcmVzb2x2ZSB0aGlzIGlzc3VlLCBwbGVhc2UgZmVlbCBmcmVlIHRvIHJlc3BvbmQgdG8gdGhp
cyBlbWFpbCBhbmQNCj4gR3JlZyB3aWxsIHJlcGx5IG9uY2UgaGUgaGFzIGR1ZyBvdXQgZnJvbSB0
aGUgcGVuZGluZyBwYXRjaGVzIHJlY2VpdmVkDQo+IGZyb20gb3RoZXIgZGV2ZWxvcGVycy4NCj4g
DQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oJ3MgcGF0Y2ggZW1haWwgYm90DQoNCkhpLA0KDQpU
aGUgcGF0Y2hlcyBhcmUgaW5kZXBlbmRlbnQgYW5kIHNob3VsZCBiZSBhYmxlIHRvIGFwcGx5IGlu
IGFueSBvcmRlcjsNCkkgZGlkbuKAmXQgc2VlIGFueSBwcm9ibGVtcyB3aGVuIGFwcGx5aW5nIHRo
ZW0gaW4gZGlmZmVyZW50IG9yZGVycyBsb2NhbGx5Lg0KDQpJ4oCZbSBoZXNpdGFudCB0byBwcm92
aWRlIHRoZSBwYXRjaGVzIGFzIGEgc2VyaWVzIG9mIHBhdGNoZXMsIHNpbmNlIG9uZSBvZg0KdGhl
bToNCiBWTUNJOiBVc2Ugc2V0X3BhZ2VfZGlydHlfbG9jaygpIHdoZW4gdW5yZWdpc3RlcmluZyBn
dWVzdCBtZW1vcnkNCmlzIG1hcmtlZCBhcyBmaXhpbmcgYW4gb3JpZ2luYWwgY2hlY2tpbiwgYW5k
IHNob3VsZCBiZSBjb25zaWRlcmVkIGZvcg0KYmFja3BvcnRpbmcsIHdoZXJlYXMgdGhlIG90aGVy
cyBhcmUgZWl0aGVyIG5vdCBpbXBvcnRhbnQgdG8gYmFja3BvcnQNCm9yIHJlbHkgb24gb3RoZXIg
cmVjZW50IGNoYW5nZXMuIEhvd2V2ZXIsIGlmIGZvcm1hdHRpbmcgdGhlbSBhcyBhDQpzZXJpZXMg
b2YgbWlzYyBmaXhlcyBpcyBwcmVmZXJyZWQsIEnigJlsbCBkbyB0aGF0Lg0KDQpUaGFua3MsDQpK
b3JnZW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
