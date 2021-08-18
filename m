Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B7C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 04:36:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1677A61053
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 04:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1677A61053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1B5D60764;
	Wed, 18 Aug 2021 04:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osP_5p4fVCKG; Wed, 18 Aug 2021 04:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BEA5605F6;
	Wed, 18 Aug 2021 04:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CCD5C001A;
	Wed, 18 Aug 2021 04:36:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9362BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C18D60683
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4oY21GVLxz4K
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:36:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A8B7605F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqKNvOCDLaa3yba5L9SM67WwPQPS8aW5zFk6H02ukawOVjj2ha6B14+h/DLCa+pzXaxNbTsiUtUu3RZ1UAEUYhbG+rGSKW/me84S99HR8uTvzx4VddQP/e8RQVezQbYKXY6vTKQeznAbxVBaBJMT+pb6mEv049PtQi6Ef52Nw2LYNlGqn8qiCx3NI8gf86YpfIv76BE0GYkoTWDh4JY3ZZ33T4e4JFP7a1uaNVQg2qnjBeus8wLeoM5tU2ECSarZ9KGnoLyl5YBGInQvEJkEFDFvkLkW/G9XfuRgGyFlJ5mdoF92I0YNPHFsqWuLsd/1Mzg6d+RjHadGPiBW5sru5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kLO5sYf6bDhWMX9eZvNyKP9uGq643fKwF+Jt3JkWQ=;
 b=P/jnWZpJVw0ZpoXTSdb23GPFnKKjW8y+NyM8ERL4REYyYfoO3/TwB2OZfATjTlJU9wNTS+p+gL2MU2rFXEza9VEjkneFWfyCNYJDzHyTPFybvkvjvj4LAqc2KbU4fA0OiEV36lc24Py4w753FkBIVmxmxXRzsUNsrlfsp0FTgi/R2wSxj4NjDdiN22RmvrUTMg7KSHi4osJ1B4vVzYiH7KiAXfhippPNYfXpZbqL2DYLJP0sZm5WDSB6kAJbHn3gNXev34qhdI5QNkqCsXf1lN3HIMmaB0ZUTUf413bLzJ9I8W1vUfrNmeHDm4V1RgL08j/7ecmstNI7A90ez0oLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kLO5sYf6bDhWMX9eZvNyKP9uGq643fKwF+Jt3JkWQ=;
 b=GN7Q+e/htzYUYTbKWaEntVJ2ulkMxXrTp8idt+iBV1D8GR92Pe6N4w0HMK7ocpWRAbmUmImpWzAez4bewx8Og0QgO9BbnKU4ldP8y23/ZNMKQgbGbwfgC1n8rwm5otC8nvTV31x8N/PPSz/WpMEt53EtKH7BCx2E6ryulEGwpot6uWXQUGJkZUSkgDu7sHrqTWNGjmgjJNe7PJlNVTahhyjyqtjW8xMvT4qyk+yJjFllNcNCOVifq+N/iQwnMgeXJfFWVRCIvI6vCByxhEUdJCf32snMkyKedJxk/9pHomQfevpJoAPhidOWj2/WirORFmJpVSdZ2yaUVKUeAf4w/g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 04:36:43 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 04:36:43 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggATGdICAAADAkIALu+yAgAH5tgCAABhhgIAAAEPw
Date: Wed, 18 Aug 2021 04:36:43 +0000
Message-ID: <PH0PR12MB5481EF1FFD6EED706E831C89DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
In-Reply-To: <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bddba3ef-e8c1-49d1-274e-08d96201c79e
x-ms-traffictypediagnostic: PH0PR12MB5468:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5468FF881FF902E349A102F2DCFF9@PH0PR12MB5468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pzrnKJWcffZ7J0F0tj83Nyg9EKMx7WL3RoOajQE321xR8R0AFm4a9fTUkisrwN/eQNN84lz6AWtlK8/f3WS728OOxQ2hKHimlISKofR1xBuMMBglxoayoPUT1N/rilOZ0I6McrM8+W3jskuFm2nRYaFrwo1x2j3flsKAZmXqKu8UxPL68WktryzI0iXQ2IB5UgkeuWYLJrC0ER0G61hCFBzzmB7S7kVWPnMMO7c28aTBPL25Af4fyipmtyE8OSeteQOgPvx1GfhfDsW3Z6MPDSrHcZskLRbomEOidGEdlvOuFHXf6sDG/EypXeFtQ0qJa5g/1NAUfNjmA4wTHk4utz/2C0ZPrKKT5N6viAT66gSLVkm1n+3yFd0LxXNuiCNOhcaM9Uw1vlx9S/tm3044+C/kc3rZ8mGfwB3QM5cbVL6cCERMH59EWH9cslLig9Z4X+kVWjPi72QS2KxIua9ouSOVJvLHVaEFQaIs+jgGEdMmX5B7h2mAvIUBPHM6LbFn6nIpKGtPl0JXojQhuv54eEYe/U1tmF09uaBlvMxZDdyAQ7L4+QRwi82A5G8t4wZXI3T8uy7gbuxhHMZIJpITrAUMyVijfSDo15G487Z3ozP7HsA2ShzCHnYaNhgG9FHQUbEPmAqheqHQ5eG848qBSjqIsszn98t9UMh1XJT0L88SoRYcDVOoyyp7BI5nRbJJmg32hlRNKRwmUWubWR2zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66556008)(6916009)(71200400001)(66446008)(4326008)(8676002)(64756008)(478600001)(66476007)(83380400001)(86362001)(76116006)(8936002)(5660300002)(52536014)(55016002)(9686003)(107886003)(54906003)(66946007)(38100700002)(38070700005)(33656002)(186003)(122000001)(7696005)(316002)(26005)(2906002)(6506007)(53546011)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVVeG1UcHhadWhvS1ZDcnBYTmQyZ05WUU13SWFFc1BFZk5lNHhRc1lMY1dB?=
 =?utf-8?B?WmhScHMxdElHcER4VXlCZ0hyYm1ESENRS1VtaWZtN1NXODY3ckZ0Y2U2cVBC?=
 =?utf-8?B?RmlBcG1CUWRybm9UcStIYzJicjIwL2MrNzNpaDV5RDdwY2pwTUV2aTMzNzdl?=
 =?utf-8?B?OEJuWGIwZ1plTlNjT0JOWDc3TVhBaEFzejZhYnE2VjFFMjVNdXFFR2xkcGNk?=
 =?utf-8?B?RTNGN0RJTzFCVGc3VDhlbVZGY0NzZ0trTE9hZENZWDlKNkhHbFY2Mmh0bElB?=
 =?utf-8?B?R1NhM0pUU3RRbndxVTR6OHpMSm9IaU4rVTlWU080MEFhRGoyd1YxZ0Y4ZGYz?=
 =?utf-8?B?b1hXNmQweDc4YW9Md1N1NVBKaXEyb0t6b0tVUU1yZ3VKVi9FbkE3UlNXcjNt?=
 =?utf-8?B?NCtGejYrZXR6WHVqZ2tob1lZb01DejZZMVh6RFJSZU9KTlg4Tk95cEcySnly?=
 =?utf-8?B?MmhLenRVOXM2WWxmYnpUakczSEtUenAwSDZSQW5Jb3NuVnhuOVZoZ3ZXTzFP?=
 =?utf-8?B?RzQvQjFkRThUZ2hQMmtYZlZsSDQ3NlhiWXBZcC9KL2RpS1lTWEJFN2pFcVZV?=
 =?utf-8?B?QXBFaXZpZlk3NFZwbjdrVHdEaGVrUVJHQ3JVSUJGNW5DMDhtRnp2M29OdGR6?=
 =?utf-8?B?YkMyTUw0bENjd1Q4d0ZEUlRDMzJFNkNvWlcxN0JQSnBqSDBLMUI2MExkd21h?=
 =?utf-8?B?RzVCckRjNWZ0VzNzY0ZvVExTTnh4NXJMVlVWWFpQQUhDclFqSFlOc3EyK1Zt?=
 =?utf-8?B?TS9BUUNLRHNlcnkxcHMvdUhJaHMvZzVOekh6M2pxeGR3SGxmZGRJek1vdDhD?=
 =?utf-8?B?Q2VrbkdQSUVLTDBtTkNOaEUyUnhzS3l4eGpTTUt6UndZSUhhVjZGaG1uRThD?=
 =?utf-8?B?eEl6c3NuSWJCeENGWHdRVS9aUkZuekpRK0tVY3FxWFZ1MnIvbjY1RE1tTlg1?=
 =?utf-8?B?bjBNY0Q1NGdEeEF3Z0NMb3NoYkpqQVhZN01yZDJNcG0xajkrZ1M2ai96TlZP?=
 =?utf-8?B?Y2tyUEc0OEdSUGx3Y0ZJdVM4QkZvTmQ5aXFPTW1tUXIrZmVzNUQzUG0vRXpn?=
 =?utf-8?B?ZzA0ejl4MzE2QUlOMkRRNGVrSTZQNnhUYnpFSHA2Tm9yOTBwMUNVaWhpMXRN?=
 =?utf-8?B?MlBNN0U3dGh1bVZDOU5TN0FuNDMvS2IwSU9xaE4zb1A4b3cxY0p1Qy9nejNX?=
 =?utf-8?B?KzVpZGNhM3FyRWhpS2VBWUc0b3dBT080bUJkS1BwVzdZUVRqRDBkMk1VUGJQ?=
 =?utf-8?B?TTBoODRmNEVmRXcyOUtXVVlTYzRMelBRajJDbzRGR2N3dVVobHdKQ3g4S3VN?=
 =?utf-8?B?eHNpdzlxaHBvOThlRVNwajcyYWxDZ01rU2s2VlduK3JTMjFMZjBCVmsxbkZD?=
 =?utf-8?B?bHlFL1M1MmN5MmtoemxSNEhYSElBK3lQNGFZQnYxQ0VJckU0WXpycnV4UVBB?=
 =?utf-8?B?Rk1RUWRjdHFsUjUyT3M5c3NGZHZBTW1oQjFJeVRxaDZqZDlHNEhQVldIV2pH?=
 =?utf-8?B?enpqdjFpTEJySTkrVHlvSTlTYTUvYmp5OFlvVXFUaVNLMk8wcG4zSDBwMHZl?=
 =?utf-8?B?bXFSSzViRnYyYlRBUUxoQ1A3YkYyQjFvU0tLUThycWdldHh6Qy9Td3BoV21N?=
 =?utf-8?B?MVlKcDAwSzVlWUJ0TThVRHk3ZVlUOHg5L2JLZEdBTEJiSWhDVEJFbDhwMEI1?=
 =?utf-8?B?RHhMTnRsbEQ1TEIzdVVWTXliVHByZ1BaRVRTaHJBNVdwaEJ3SHhrWU01NzQx?=
 =?utf-8?Q?K4YdQUaoH28hEJp23BocB9betxeY2yciAdkW/FH?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddba3ef-e8c1-49d1-274e-08d96201c79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 04:36:43.2369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxhVCVE1rAvz4jr1TtWOP341bYnDMdA40j+s4tqnK5mkwq6nqX0xLkJuIGreHWwfl9XMKLzg7OwDNnGH5jVJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, August 18, 2021 10:02 AM
> On Wed, Aug 18, 2021 at 11:15 AM Parav Pandit <parav@nvidia.com> wrote:
[..]
> > > I'm inclined to say vxlan is closer to a model to follow.
> > Ok. thanks for the feedback. We are using the model close to vxlan.
> > Lets resolve should we have it at creation time, post creation or both?
> > (a) Creation time
> > Pros:
> > - simpler single api for user
> > - eliminates needs of inventing stats reset in future series
> > Cons:
> > - inability to reuse the device with different config
> 
> This can be solved by destroying the instance and re-creating it with a
> different params?
> 
Yes, which is what I tried be say below.

> > - This may not be of great advantage, and it is probably fine to have creation time params
      ^^^^^ here.

> >
> > (b) post creation time:
> > Pros:
> > - able to reuse the device with different config for say different VM.
> > - will require stats reset in future once stats are implemented
> 
> Any reason for doing this other than re-creating the device?
> 
No. Only reason I can think of is, device reconfig may be faster than recreate.
But I weigh user simplicity more at the beginning and optimizations to bring later if required.

> > Cons:
> > - more commands for users to config a device, better to have the ability at
> create time.
> 
> We probably need to support post creation but it should be device specific.

True. Your below device resize is good example of it.

> 
> E.g we may support device resize for virtio-blk devices.
> 
> But it can be done on top I think.
I think so too.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
