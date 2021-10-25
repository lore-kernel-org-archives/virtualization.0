Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD22C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:27:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B67603E7
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56B67603E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14D2240399;
	Mon, 25 Oct 2021 07:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKopunpiQMrQ; Mon, 25 Oct 2021 07:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C7A6403A1;
	Mon, 25 Oct 2021 07:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A60C0012;
	Mon, 25 Oct 2021 07:27:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3044FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12B3680E7D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kS-dV6wIvSx8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:27:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58FC180E7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0XkrC+UsYHDOJ3e90dT054ylLI7aRFSLiirNaTfYXcS0awE7YL4L0g2afhzRSwKrMOlkAeqOS+90J7GnJXZmktIvfEMiE/kYDjDCOfFXrRxqFHxXaUxpO68UbFGkWJiTYp9oWKt3U8sUIQcPReSIOxUVMXtA5FlAL62M2JWGYh8urVCGk84uhv/KvbOml2996wKnhZntmNQl1w5Mof5yPPM55pSwdA6z4u3DK6KDuqWsW/hodIjWYs3x2E9XEBlr+rj3N5d2k1BUCePjznrsMsZrbqvPPiUaK849EWHRJthuc1tBF40HmxAwqgNTSx8GHPkfVLscKaPAxrltR5Otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQRefiMUykXDCT8i7fIV8hZbY2wmSjpj9FuKaoO2dVg=;
 b=djwQawOeQEjxzQsODrfIa0DEdVzHvZKSpBsSsGNrMx9BG1Mt+bhUr8yW9bJy/Isft/UNwV9vhTnGvp1M6qtvKucqtpxKSdmIeq4qK+3qmUgkV9i7jqqA5HAC9ot5CYBa1UlhpRmdf60oZxgowNVoaxjg7NkrSkk5AxgLohZN/v6QpJ5KcbcltD4ND/n0nls7uxBVPSKXTpzyUXxxxrExmc+5fUPhTilzp85WgRXWexzpv3rpsNEOLgScnX3gmsSjfzx9xBuZXedqplSS33iyjI9e/+twoMmyq8scRHERfIY6IrY85LRLhejyzfJvfGxJ70esNqp7Fe7siw5NvT/2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQRefiMUykXDCT8i7fIV8hZbY2wmSjpj9FuKaoO2dVg=;
 b=K2KEG3c2pFxvgNIl+2HB7q3JPuvM5+O8N72kmjXsUM93MkOlZiqXE5+6ggnuo1A/G6jkyQy7S2gSgKJBkhL/hm6M6lpj+gZM7ONNg9jN03yfVeyLeyv1Ldt24o46sVERtIIPDXwepbVldzcNTkM2gGvrIy0Vm0FI5eRmyoYqfl5ATSutggXGOC0DwIJCE46YWcVdY9X/LN9KEjTyt6ksQ9VBTVXFV4GIdx71Ldrkk0VdbfVmpTS8RibagWPf/r7bEPdEpNFtx6KJhtAdsn5U+dRdmKr/3yrp+m9eTt9ANhhTVpvuAyHhiTKGdjD8hiXOHqsK1Qg97pncdOtnpuICaw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 07:27:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:27:15 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Index: AQHXxpmvqggo5IfRl0a+twGjkaCaeave1XCAgABIAUCAAedaAIAAFFIAgAH+VFCAAD3FUA==
Date: Mon, 25 Oct 2021 07:27:15 +0000
Message-ID: <PH0PR12MB548192058744EA7C2D5943F5DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211022064007-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9037F79F3118AACDB3FDC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211023155850-mutt-send-email-mst@kernel.org>
 <20211023171505-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA03EA9DBB40EAE8122BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481BA03EA9DBB40EAE8122BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb10878a-b190-4b76-e9de-08d99788dea6
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-microsoft-antispam-prvs: <PH0PR12MB5433B342B4BECE59D531918ADC839@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrgkFgKXHkGy0eliNU5TN4r14LyX3bgFyF25zghLvt0S5jMse6+zdh76dO6vi7/iY6oefrIdZc+vUF0GCXc0qxfyV8A6HnAJop+tyGc8NiSfPVeY4orm+KnoZsLWIY2EgX3dBKN4GkSBPBpgQi5PZE0cO+A1cqu7pUCALdM9HgZQz9+jF5qoHbmBpLTg21Nka59VHDE7QXoBkGRSvN6Bpa9GdZwBl7q4Eyy0h997+TDy7p0O6sU7iXHK2eb/zkIMiFAkmstt72T8opvF2g5wC2otV1d2joK0VCPjIhi1hz1RxKjIlbRwaajy2mzFzfBzgwalqH3quUKgsScnq3wpmUuXR03+FNIykNt+6/qffBwFQo1xYtlnVaRcCP0nGUBw9H0bT9qRjMoxnkI+HV57WgdWPG+uwLIP+aQq6VnTUNa+Tugf3KSaypKM3B5BfwMCM5yrG0/0Vf0Ys3+KGGLvUnSjyys68JY9HNBTcDAtRY+CkD4hx1k2EWf3b1dHYrOXrNGspqPGGgpRB3e3zOv6mnXrRQ6Ai5dq+0fNnKta1JGfrjtsGneXS7EuNpQFWnetiUhiQUvED0F/jZ+jEaOe9dqfmjrrQh1HN0zT7dvNHUXVF5c977hxRK8cbSKw/DqhGyKon/GZXJDhP/TWdLFJXwbqZ9DRB3/7dKD8PbbSMETb2Mi/rCM7R2aYWPax7Y8CtXwP33nNhMn0kq34fOUqUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(7696005)(8936002)(8676002)(33656002)(38100700002)(64756008)(38070700005)(54906003)(6916009)(83380400001)(66556008)(52536014)(122000001)(316002)(66946007)(66476007)(55016002)(71200400001)(2940100002)(76116006)(26005)(186003)(4326008)(66446008)(6506007)(5660300002)(107886003)(2906002)(508600001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qu87AHubLkjkrVgsB8k2i18/6XjdjyyYXugNr7kQSVPw3eFaPXFDnTGRKBWN?=
 =?us-ascii?Q?f9jCw3MOKo8NgRIxkHfCX6o+0ioTS81WlQP/xdXnEwENuKy1TE3oYVpxQpbG?=
 =?us-ascii?Q?HnAI8ontNA7hqqq05kbG2TgK9b2QjnqirZaStB+ilsMbB4dxvcl0G5qyGpVX?=
 =?us-ascii?Q?3f1P84nXw9KCFUEqf8NAjOwN1mRtDTH1IRmhteMkVP95lDDrfqt0aBW9+ShE?=
 =?us-ascii?Q?x1XN/JhzGsbKxATaoW2FLm8Q12eQnALjptQ4kADPy1z22p4Gi8AzRwCrmMby?=
 =?us-ascii?Q?Y/rBihGtwohNos/VOhNLfQ/gtbtDdhTvV3lwzPdicTf6ggHCD3Tcwu5jpnQ/?=
 =?us-ascii?Q?kZ74oqQTfkK63QF06yTmmNCfVkakHUmVj7GqHBOAr7VHnyXnHIPc74DGc+4n?=
 =?us-ascii?Q?gA4nobVGBN37AvENxOwDNa1P1tuQa4VYI2joc9NACvoXUr8nAm1ZRJGpWwN+?=
 =?us-ascii?Q?W9x07LbDvfNwxbV9CGqztCErvfKSMsiRFxE9UMNd4uWHrnfnMgfcOwuzBk+f?=
 =?us-ascii?Q?/ZgaA77qGM86NCnZgFSHSU4SYiJkltk2wAGKcjIb5Df2ejpLJnIPQY58BmNT?=
 =?us-ascii?Q?H3UxwnB6h5jeKu4ADzkO283zAkgXl9Y7F+HHJxU/UieVk1qOvWc5vk6xcJ2I?=
 =?us-ascii?Q?PpSVrjRdwA1Q5OrmRKx6Q+4a9Bms4/bKvhpt4onInv1lMzvHJSZAUWRrTX2e?=
 =?us-ascii?Q?gVfgj2aOB1q96ui2tRNyKuYc213UVqcO9+aoH4wsu0M82KV/o8N6CdCBUF1z?=
 =?us-ascii?Q?H5xDPgMBz+ZTF/g98PK0djei9MqZMHZ6e6VaqdcKUH5fC4S8gV/SNj5GuLQy?=
 =?us-ascii?Q?+mQPtWOceKJZxA5yyHWmvHBDPNFsuKHRl4R8mqkNMQl5qpxux+4bSn7DDlRw?=
 =?us-ascii?Q?IKaZSzwgjjI3PrTeBwpDuTrUJQgUIu2E94fIuxSUl6GGaYftxd7xvs7lFbhY?=
 =?us-ascii?Q?eQx9uamCA0mTXwhjEqtEvTm+Kt7maJoqIUP7tV8Qmuh4e5hczv5gfwIs1qt2?=
 =?us-ascii?Q?JrjzBZWvV6QyPPvNmqkj4RxXxp1xUU9wMT+XMxtc2zQ47+7QQWppTtDRhcuq?=
 =?us-ascii?Q?XVAgFfQAXArEG8IQMPLrbW3NfMjrBH/cFoe8urO4yS1BnZ7LR4gJ/5csB6Iu?=
 =?us-ascii?Q?6rXA1pVp2imQtbvYJJzg7hO/WEp0C2LYpCG0SK7VG1kdwUnbCYdcKElbbdmI?=
 =?us-ascii?Q?YsTV3OxJ/5Ui089oDvMqEyxNCx3GzBj2ftq3FUO+rGLahHJ/j7STGZlrFvfO?=
 =?us-ascii?Q?/WoYLS1w4/5gyynQ+0LbXoTUOXEyHELbZUWy7kT2Sej4sgRAqBbT56fN6YHI?=
 =?us-ascii?Q?tk6FZsqVXCfiZBtarT6urLV0Ju5lIdx5Eqse8BpZbJlty2hgsSrmjzpgnmzU?=
 =?us-ascii?Q?91HtX9RAS8b38MYCFRNJ2xp0cdQZOZh0HydlnSFqDKpCpH2gH5R7oYzjhjUZ?=
 =?us-ascii?Q?c8Wc2VKAytgOV6OqW4cHVWM/M5dK1rz8FTE0xbveUUX5OQmktsTaV+QhXyiC?=
 =?us-ascii?Q?Fax6Jw6QQrgjl2C2XnxRHbvXGZafgiMvxIlFvdT/CsD5+jIGzl81DviZdxnz?=
 =?us-ascii?Q?e07lZyMrIJclFSyIF35rwI27DC+hBEeVb5DhWQ8T8JEzN3ZT2gYWl2TeSYMT?=
 =?us-ascii?Q?XoZSKqsVtZFIuzjPHC/sM6w=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb10878a-b190-4b76-e9de-08d99788dea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:27:15.5148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uS41CPTmly1nUaOQI2ToNWuiveknD7Ko1h5ouXQeoErA92ULYCp9QLyE97YJ/tnwKbD89zX48AdePvi2KUyxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

Hi Michael,

> From: Parav Pandit
> Sent: Monday, October 25, 2021 9:14 AM


> > > Thanks for the report. Parav, could you help bisect this please?
> > > I also pushed out a new head with some patches dropped.
> > > Could you test that maybe?
> > >
> > > Thanks!
> >
> > OK I think it's due to Jason's change to virtio blk. I dropped that patch for now.
> > Could you try again with the new head please?
> 
> Yes I will try today as soon as I recover my server access and update.

I verified the mlx5 and vdpa sim net with rebased tree. No kernel code trace seen.

The last commit in the tree that I verified is below.

commit 2b109044b081148b58974f5696ffd4383c3e9abb
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Sun Oct 24 09:41:40 2021 -0400

    virtio_blk: allow 0 as num_request_queues

    The default value is 0 meaning "no limit". However if 0
    is specified on the command line it is instead silently
    converted to 1. Further, the value is already validated
    at point of use, there's no point in duplicating code
    validating the value when it is set.

    Simplify the code while making the behaviour more consistent
    by using plain module_param.

    Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
    Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
