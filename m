Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDAC12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87AB61182
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87AB61182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FBB7825FE;
	Mon, 19 Jul 2021 05:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dL5vil_N0uT0; Mon, 19 Jul 2021 05:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2D31823FF;
	Mon, 19 Jul 2021 05:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30F7C0010;
	Mon, 19 Jul 2021 05:37:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13A31C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8C5F40419
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8i6LZAW-5AR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:37:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8B2740413
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1ee6P7ZytYD5Je5ergxCjsqxTBDFRcEXOC1T9JFhHDAW1G1N/DQba4ot4nEnqIaJHYI5ftxZuORkr/OEJMTGXi0pQt+86QCU7a/ap5KNKfak4HSQkB0Sc1hkVlrVTgXEsu2bNPqcYfCafa9tZ6eQ1xg83aOVsKlJc36WbXty8+5E96yJsTIAC3ldhWT5DnSHPsH7qbxjZAhHjUBQCP7Ya4Y6lALcV13tdtOfcA130Ksp1Z+8ZdjEXd2YukEfxLF975QXCwFC3diAosYfdTgdy11rDgUe7Y/JFh97bn8wX7MQ6QwDqBvrCZ5nrB0XJw9hscpuk6CJLlpgTfIUHJohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwmqHHgo5NjsZdWdVJgCF2UZJD0yHQ/GryIv0hC7RN8=;
 b=AhTWJWsREiYcPYgOkHFgYEWBO5AEEDg7Aq0EiWFzmBB2kmCtkNT1MxS8MKIDBPCphvjNdCj5LjMQKuK1f+snP9u2VVeVNiULOfI1RZpVY9haQkVKyCn9uXuatZQCBLN+mbWgdAL3HNTFI7OvEMGQQOYvVBbX7gvvO8XkADY0JlV52bL8eaTTIX9BYOK9BRxny4THZzQf0s2fFrmY4RkBTW1CSebicGrmPz3v//uGfXdjn6Pf66aYXP3h8+PvYXkRTrZQMd4Ez1fr8hT+BSP1yNzzfx2B6okM6A0hN0UmygABD7LiGZk9vfsFsA0lzL9LDHELfZPzooIZMfuYe47JHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwmqHHgo5NjsZdWdVJgCF2UZJD0yHQ/GryIv0hC7RN8=;
 b=n+jkkYuAcnXR6IX8T/wAtXPt6LVR0gunEO5L2OIkOfoej1+0VXngsbFI7aZdpIYG8r+OotcOaX/KDi/pYJ6yjt92y0ueXXU2Z0H2y9+eUagXt66BDdWJTN6Tg60wn8Dv7wTPDQVAmd4XdYnlmQ+tFLcjQ2j2NbfcARPbuW1bFiw6iRS4jju086eKEFfXn9Iwb+OG8mnZ1ooLR1FqS79LVdunTpl/wuYr90IJuW51qxXJcYDMjgK+qYK3mMz/u10Duzyw9QMVsMhmiN+6Fbmk7NpBosoIQ+hSPaVMDE2LXdUGKPYp4pS2dhZMVJr4KnkglaUjLVHOU9DtvsrX9hpYDA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 05:37:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 05:37:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 3/4] virtio: Protect vqs list access
Thread-Topic: [PATCH 3/4] virtio: Protect vqs list access
Thread-Index: AQHXet9qDe0UNy7c0Em1Bm8wqIVssatHoneAgAImyUA=
Date: Mon, 19 Jul 2021 05:37:22 +0000
Message-ID: <PH0PR12MB54819B7F3EE95EE211B3E9F6DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-4-parav@nvidia.com>
 <20210717164007-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210717164007-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891035cc-72e7-4b8a-996b-08d94a774864
x-ms-traffictypediagnostic: PH0PR12MB5449:
x-microsoft-antispam-prvs: <PH0PR12MB54496E3D9F27797CD1F4A638DCE19@PH0PR12MB5449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6NEPqCc71VLnKbs2b0Js8tDyaPDOaz6nMo2TSwsXEwjL7Xn5G+LPA6K9k1CO8NrB39JMVCgu38Aan3KlBRteku/zU1JY0Vj3cpYrU375+6W19l3Evm8fZsGWQc3aSma5aXvRopgeISa2Q/saxQAjhS3tYVX5SLujunXIBffeE22AjFRt2JPJWXYtxzVlG/M+Eec4GBV4q358F9LnOPdkb+7dvEqPauiue7zqPrxcgmK3nxlLMiQnAHI92wRjcaf2VYjcrwe8xbH5ZsFedCBbZZs1nws4YZvqPVqEbt1vzrMj8/XjBwCL89hmaCmH0zcDghu8hj356Wjwx8J/e7+DFGZX+BbTIb/MnZFHsEV2ig6hXVT2wSgk6pgVyBzS8Btw7TCGwCOIDqQtuA7EpN1NreqRTEarIqbz+TXU6FEAZc2lioA8IYeR/wqHykrB/i8S1B8orkPaNTHYJp5WKaiDkqTTVtuu8bDOdM/FQtxKzbPiTJsnI1RAnLNa3gDsPK8oaP27CksCA+pGL/L4fwUVqHxqHCrO2lyR88mMHQk/4rOMjojBV4tfLz+XGNYzPWmmpRJr1Ceia6IAT2jgU0Ony/VvvgtD4y/kSmHGB2KAiFi6/MmQZNpl2yDzxIPHRh8d0LSbNQUiuH5wFOzWbs0Ip+yFROJeK24bzaGKPHX2C6guqOmWmqr3YjVIWnqkEZKP2pwZHa763oujBQ1w67iow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(26005)(55236004)(86362001)(66446008)(64756008)(186003)(2906002)(71200400001)(6506007)(6916009)(66946007)(66476007)(66556008)(316002)(5660300002)(8936002)(4326008)(83380400001)(76116006)(478600001)(7696005)(38100700002)(122000001)(8676002)(33656002)(52536014)(55016002)(9686003)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4CFMmNE/7QLGuvgZhGDSvAWv8ik8nrHesYU19Paln3pt+r4aK1qsIR0bPm3n?=
 =?us-ascii?Q?FI37dTVlgFEepOJ3Pu4Haa6EhoVaMBPwMqPp4P7HZ0sKEjbkIO33Tu8K3xfQ?=
 =?us-ascii?Q?WgB6Sw29MDEg5GRDW7sa4pXInKcO6vwG7marR0klSD7tv0btK29eb4P5xnaH?=
 =?us-ascii?Q?TIZAARapx5szsy4q+zIHuEddn43LRB0SnwYl0z/TIPxq5reSCk80Kaw9P8hw?=
 =?us-ascii?Q?DzoBcvJd8G/bsDZyiKPZoKkpUCohsaeCDckmj/djl+fOz79SMNDZaVRPmlVW?=
 =?us-ascii?Q?wxpNp3mDqYtB/2Z/62PThs5pw6hqVDLtT1Gc8PMN1SurE82n0KOq+n0D3Agk?=
 =?us-ascii?Q?nr41+PY99lwPzz8kIi89e1hQswEOiwO8F7JXbhH+RzVvQ5mAHSa8BqOWdG5+?=
 =?us-ascii?Q?T8rWkstkvroKZgj9xpB2aIAnElz3YPZCk1JhFOG6TnDWstPMe5h7/OT0VOwY?=
 =?us-ascii?Q?/ewlxFI/sFbj+3kWF6crvy3CFgfKKhBsvWR0YH81r3nvvGLlqmgUiEFBhlO6?=
 =?us-ascii?Q?DxV2tMtJnxYY6OcLEJUfBdJb03PEsX0+H/+hDDyKnaKVA4clnR+GJU84BJyc?=
 =?us-ascii?Q?i4X/w4UWEDu1BwEmUAwY8II8eC8oW2bP2hvPTwvgKCnSWz9miuIa6Z0868Xu?=
 =?us-ascii?Q?okAR/ngTawxGnwH16HvgaZlARWgpEVeiTw+tSjPQ063wFTAlgUsYENx3kzuJ?=
 =?us-ascii?Q?a90YRoFGVLQ2wGoSRs2nmvLGSEVCb5kg9pgt6tokkGPt1kFR5/xghKbn46A6?=
 =?us-ascii?Q?OzrUZBKJQNPxReX3eM+6AZRRjHkylQm68MBkYwQ7mTqoNlpsyG9RwkeYS5R3?=
 =?us-ascii?Q?2uSdwq4947M9mcENDa6svYVbE1gOniv03KJYk+aiimtf7mogFmXwS+STDNX7?=
 =?us-ascii?Q?eoikwMTpuEOVryaRa91NOXvHLRi6fPJ5c/j7iIqaOQasXX/6lL3cWw9ULBNU?=
 =?us-ascii?Q?ixhUxGMfFqy2G01lonLRVbEXhsjkA1wbzZ4hgqvPkhWOTN/444nF/KKYxgmV?=
 =?us-ascii?Q?lwt+D0I2RzLLXnxpH34AzNdlsqOhtgNH/rH59HFp1Vd2rZnuxjcqtnZ9IvGo?=
 =?us-ascii?Q?FHf/unCIAtvmunWuwOFRByVmZKto3Tbm2K7QsTuXBNLC69PL3RCMmdOsw4oF?=
 =?us-ascii?Q?9RtMcJDt5Hroou20AVh/KOoFcgDxn3zbNNCrYkbz5u11rMJHnDf2MV9FhIpI?=
 =?us-ascii?Q?/MMa68B60/xnawV6cNNd/UagbTVhHoiZOXRlxajZThOdKw3TAErG0Wn42KS2?=
 =?us-ascii?Q?XGBX+trnvHmJe6XPnOg6BDSImFoAej9rk5tqpa8rUGEqniDyn1sAwCASDHwJ?=
 =?us-ascii?Q?RUcYqZkGzDMlsy25mW1xpXz7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891035cc-72e7-4b8a-996b-08d94a774864
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 05:37:22.5333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0j7F4LCOKVSY947vfG8sr2XT5ZZyE0SsHpp2teaX0YIlc2HzFTZFy2kdcNHe4J3f384EZk69rXxrqfVup6/nQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
Cc: "virtualization@lists.linux-foundation.org"
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, July 18, 2021 2:11 AM
> 
> On Sat, Jul 17, 2021 at 10:42:57AM +0300, Parav Pandit wrote:
> > VQs may be accessed to mark the device broken while they are
> > created/destroyed. Hence protect the access to the vqs list.
> >
> > Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all
> > virtqueues broken.")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  drivers/virtio/virtio.c      | 1 +
> >  drivers/virtio/virtio_ring.c | 8 ++++++++
> >  include/linux/virtio.h       | 1 +
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c index
> > 4b15c00c0a0a..a0d81e35ec4b 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -355,6 +355,7 @@ int register_virtio_device(struct virtio_device *dev)
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >
> >  	INIT_LIST_HEAD(&dev->vqs);
> > +	rwlock_init(&dev->vqs_list_lock);
> >
> >  	/*
> >  	 * device_add() causes the bus infrastructure to look for a matching
> 
> Let's just use a simple spinlock. I don't think we are worried about scaling the
> breaking of devices to multiple CPUs.
>
It wasn't the scaling, just wanted to have the clarity on list access. But I realized that rwlock is bigger size too.
So yeah, will simplify to spinlock in v2.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
