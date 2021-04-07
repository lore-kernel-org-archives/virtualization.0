Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB1FC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:28:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FEE6136A
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FEE6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A286040F90;
	Wed,  7 Apr 2021 07:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct0e2vcrm4Fy; Wed,  7 Apr 2021 07:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0330940F54;
	Wed,  7 Apr 2021 07:28:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9972C000C;
	Wed,  7 Apr 2021 07:28:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BD3C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CC5B40F54
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4b_L7_GvPYho
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAC9F40250
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM5B8Xyjy4Q68xqn+QEcuy4/VxpmmPHL2k4iuuY3fijQZ9G0u78FuE023FwjY4hD7zwDovLXPlexlbSHbpe0mF6Ucfvb8topCpKtJgh2Gby2uC5nhmrlQZhgIH0g/mjV+kE1zECbSz9YsjKDo/R4UMmDzkpjChF71/DwcTz8zfC2Y1iVA9EwXM7BI5bpPKFytD6KL1pSKkAakb8jelfHejAOgc0yxU1soWaCLPRtCWD74nW6iUvvVJF3KzqbxOe3Xbafhhv3T8x1RVQaIngKa24Ddkc7YAmimmwq11HEPysGfYmRkt0feY/pcpnWkEQdv9mXrSB8sKxRuUDtrLq1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJT0wc7d4RdWnmdSX0oXdI3NdY6yzNdAvjUo8jPr1DM=;
 b=gOCBX21dLuumfuygMM8bG+ivvoJkEnxlfST7bJO9d/jigpJ4gUMM5FWMxytyovv6d7G6EsxXBntQbJczPGM3V9HLn9rxG0PT/vBb1ByVJFO5+YAFdIOSMJWrXEvDUnpg8t62Wp3knVRx9hNW+uB4BRvLVr0HK0ggt5YSna3hyGI0N923+CAzrF//1E5/qqtVvg6IOgFdOh6xWhcOql5tvnZU8/sJcOe7en2dQ5Q1ZMNSoFiqloNJny4WG4nuUwFdoPb8qyv8bgQcZ6UfYehuyK5DAATtndDsFR4kmoHTXNFHc94/EzYvKt/ebRgXPezG5h2lgMUA4peTjVdDe7oo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJT0wc7d4RdWnmdSX0oXdI3NdY6yzNdAvjUo8jPr1DM=;
 b=pgbepGCcanjYcE+3KA1NNGYJy2hBkgCL8bh3zQrFIbRpDYMJo9YVI37HkkRGL9/S9FAtqQoXwNs66Un14E1QgvxZRceTaDrkU9zw9vKaQ9kSWooVhbEQbe/VLxKw41cjaz7OJIe6TMX9BNMgXBL+vhIwfEdKl4YG6EqjyY+AgkK7Hehe5gTzaxy54Q7HHvFE8AVGSEmpP3/G2/anK+648Sg1sIOzH2EO7wkBFxDM481YpELSxRh5d6TWImEZDh+rOfwKddD6LBC5+zsHjIlipIlS1pJITtrc/QJ0lIIY3t5vkex0z4S8e/6qMA53wyJSnUZ8Ql+hCWWuEGZyBjMM5g==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 07:28:33 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%9]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:28:33 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v2 14/14] vdpa/mlx5: Fix wrong use of bit
 numbers
Thread-Topic: [PATCH linux-next v2 14/14] vdpa/mlx5: Fix wrong use of bit
 numbers
Thread-Index: AQHXKwcOl6yIB+iKZUa5O+QaHBUBI6qoqHSAgAAAjeA=
Date: Wed, 7 Apr 2021 07:28:32 +0000
Message-ID: <BY5PR12MB432210FD62C52C07E99DB2DBDC759@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-15-parav@nvidia.com>
 <7a58f3f8-5ed2-b584-d554-5d6a1e93c00d@redhat.com>
In-Reply-To: <7a58f3f8-5ed2-b584-d554-5d6a1e93c00d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d959a35-2fe0-4e4b-597e-08d8f996bfc2
x-ms-traffictypediagnostic: BYAPR12MB2614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2614D515E34B198292A78E4CDC759@BYAPR12MB2614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYT8V7DBwSSw9Y3lT4awRpFmSWDE7IvV4UjGtkF7cmTdm4dxMzaVvdWVg0bIJ9UMaIr2Id9Ky4ibwSIzKCJKeNXY+nVk0DnrX6KLxxlVMx7fH9FqLzC9QPiHT7qz4/Opt3bcPXHwWHV4g1eDJlzt3PreZQdSl9pXU8oPlAQEudPtyRkQJ7mi7a956sTJ8fJdW8TKwTX2SoCHtp8GcQqCLODbMkiJIP0f1rMfY4an4tmKDjP04p5CnPp6O6y8x1gEKqsVdVwZzYxXzFcFrpBcwnAiu5yXbMx2yNCD2hYs8YQFhrbgPb0JTAJ0keQ+f5w07nh4WAGbya2BMWJGk640v538EzxyRj9dHV6KRPNg+eg1VE+HroJa15+iuNyq6XxXbeyUKHs6NQeugDx5oKFA4FBqrT2VJ6PzKxoOxEY/h63kNrm14YZC7Sjczfho3uSX0JuJ9xGduXHauJar+A142mkSkbhXpzv7aRTgBz4g+eVHTQrw/nafvko8n3CSHqQqq5B238d1qh0Xre4pPtxD6uSXF+4nI9IKPjVPpfnh5/2wKWsqYAPO7LRGp0LUkSR0f5flCldNKoGbaq3pvG2vGXMKCRn6Zjf2hsd9kdmCX5laOl+JSu1UqG7JXzLeqXYdJ4Ks+ZT3GBrFpDiQ+A4oTMg6ZTkb6v8j3ArCkhZrD38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(8936002)(66946007)(71200400001)(38100700001)(66476007)(76116006)(478600001)(4326008)(66556008)(7696005)(83380400001)(55016002)(54906003)(8676002)(9686003)(86362001)(186003)(2906002)(5660300002)(6506007)(52536014)(33656002)(26005)(107886003)(316002)(66446008)(110136005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?Nkw5bHJ0bjljRVB0Z3BUajFJNG9uTTZsdS9NdkUxWkNoMHFpOUUxQ2xo?=
 =?iso-2022-jp?B?amVvTGNCaDJqUDVQUVFqWXRnaFc2ZmpsWGVoQ051VUx4N2NWZmNrR0Mw?=
 =?iso-2022-jp?B?ZjF4MjR5Y3VaUFlNak1KUjludEhNMlM2bGNnNXN3eDVET2cvdmpkQWZB?=
 =?iso-2022-jp?B?b3E2RngvTUdvbG9OeXVDaDhmY1Z2TnFJMWlXdnl2UnFQbjArZ0FuTUdy?=
 =?iso-2022-jp?B?aitSbm9QV04za0VoeTlBTWYyT3NmaXc2RVpDTzZsYjNwaFRXb1lkUDFM?=
 =?iso-2022-jp?B?ZkkwQm9tcitCMHEwWE91bXgxdDRwZ05sTlhLcEpRM095YVQ2NHRmT28w?=
 =?iso-2022-jp?B?dXFvdEdhSmJFREVFMERFWXdpQ0kwU2lGRU8xRHRkc3Y0ekRKQ0JvR0RH?=
 =?iso-2022-jp?B?NUlqdDQxVUwyV1UrN0FoTm9sa1FIRlZxMEdIRWZCWWsxZ2pqV3hJajdv?=
 =?iso-2022-jp?B?ZjVWbFd4RVJiZERxSjFqVXVBWXFXTDFTU0pQdDF1bkVBUUZWN1BoWGNo?=
 =?iso-2022-jp?B?b2Y1Z21HcHJ1SmdGb28wNFN6QWlXS21UOEtLeGhCY0pxaFhkSnBZS3BJ?=
 =?iso-2022-jp?B?YWhBZG01cDdMSFdjZWt6VFFlZDRaTzFsdUNMaVRDU3o2ckRzU2t4Vmd2?=
 =?iso-2022-jp?B?azVYYi9hM0I1K25sVWlVSmRIQ0ZobVcvVWZPOEIvMDV4bmloREJiMGZX?=
 =?iso-2022-jp?B?RlZ5a1dOTDR2bmxnd0ZiYUduUHVoQUZGWjFsV2I0NkJMTkhQL2R3SFZv?=
 =?iso-2022-jp?B?VUdZdERIT2lxNnJTSnpGb2tVQTNnTHg3TDJxVmtQR0MzTDRabXlhR1NG?=
 =?iso-2022-jp?B?NDNzSTQ1OWhncm1yTTRodFpoL2JKcXo1V1B6TmJVencvLzhkM1Jjbzgx?=
 =?iso-2022-jp?B?cVhwQXIzeUxyVEZTdFdPdlV3UFRqVFUwWjlkbDRUVERMWVdOWTJkbGk1?=
 =?iso-2022-jp?B?dFBWb251NytJLzZxU3pxWmdlQ2FqMTNXUU5JSmEwOFd6QTl0eDJKWUZs?=
 =?iso-2022-jp?B?dDI3dHhwZ0dIWU1POTZLWXBmc0cvQm83UCtTcDV2K1RldzF6Lzh5aXVM?=
 =?iso-2022-jp?B?MTdPUVdVZitFeUNnN3NML1dJMHpYbHo1M3luYW5nR1hxcVJLQS9qWTlG?=
 =?iso-2022-jp?B?NktOOG9XWHlmK0JRM05raWNqcmtodFJkbUdyYnZ0N3ZZMVpqSVNRUkwr?=
 =?iso-2022-jp?B?SFVPV2VibS92TnNQZVNrNGFoSklQMVlLblBLamlzdTRlZExid1lyYnI4?=
 =?iso-2022-jp?B?c0cxb3hMVjlHamZvUGJZYllZZmJ3NDNoNTBYbWs4MmozSllJS0FQUU1s?=
 =?iso-2022-jp?B?TGw1Q0VQZElLSTJZdDVUTXVmWmw4UG1tbU1Zb1FvQ2drYnYxNW9TbmZK?=
 =?iso-2022-jp?B?QmM5Q0N5ZUZBUUpaZGVEOXhJdzhBSDM0YU8xaWJwRVdiYkFwZ2I4OFJZ?=
 =?iso-2022-jp?B?QTlTNlN6b0dqS2s2Y1VpTGxuSnFtRlE5NE93bjNUM0s2NU13aDV1MGhp?=
 =?iso-2022-jp?B?M1kzeEhzWjJrMkJjVERjK0hURUZ0NG1qMmhHTEpyZEZsYTFDMXRTbXhy?=
 =?iso-2022-jp?B?NFRYazRYTVpnWndsR2NEcmt4SmU5M3JwemllWHE4YnFIZEhzNFR2Smwr?=
 =?iso-2022-jp?B?S3drV3hwcG1sb1k2dFgvZHJzN1planlDaE43alA5dFRKTHJGVGd6VStC?=
 =?iso-2022-jp?B?NHprSUdzRXdYOFZHQjNVN3RRczVtb09mOWpSL1YrbkhHblRuVnFzZWgx?=
 =?iso-2022-jp?B?SjFnc1JOK1RKQjcrclBaLys4TGNaSVNySG1zV3B1R3IyTHBmZ2dvOG5m?=
 =?iso-2022-jp?B?R1c0Tjd6cnNhdmtYc2cxRU84QTNSdVNjVnpIQVloN3prSTVkdGNSdjRm?=
 =?iso-2022-jp?B?YVE3U1l4VEdUTHhUcjUwN3JzSjMrSndmYlYySEJQdkZwakhtaytpcDYy?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d959a35-2fe0-4e4b-597e-08d8f996bfc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 07:28:33.0112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0P0egZmOG/Q4formRu4DIYeKgf6cdugxsVkT/XLX8NCbFS942TAuO9mlQAQBm9S8ZD9kiat3X0kVano3swsCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, April 7, 2021 12:56 PM
> 
> 在 2021/4/7 上午1:04, Parav Pandit 写道:
> > From: Eli Cohen <elic@nvidia.com>
> >
> > VIRTIO_F_VERSION_1 is a bit number. Use BIT_ULL() with mask
> > conditionals.
> >
> > Also, in mlx5_vdpa_is_little_endian() use BIT_ULL for consistency with
> > the rest of the code.
> >
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
> > devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index a6e6d44b9ca5..3b79b5939c7c 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -821,7 +821,7 @@ static int create_virtqueue(struct mlx5_vdpa_net
> *ndev, struct mlx5_vdpa_virtque
> >   	MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq-
> >fwqp.mqp.qpn);
> >   	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
> >   	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> > -		 !!(ndev->mvdev.actual_features & VIRTIO_F_VERSION_1));
> > +		 !!(ndev->mvdev.actual_features &
> BIT_ULL(VIRTIO_F_VERSION_1)));
> >   	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> >   	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
> >   	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> @@
> > -1578,7 +1578,7 @@ static void teardown_virtqueues(struct
> mlx5_vdpa_net *ndev)
> >   static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev
> *mvdev)
> >   {
> >   	return virtio_legacy_is_little_endian() ||
> > -		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
> > +		(mvdev->actual_features & BIT_ULL(VIRTIO_F_VERSION_1));
> >   }
> >
> >   static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16
> > val) @@ -1985,6 +1985,8 @@ static void query_virtio_features(struct
> mlx5_vdpa_net *ndev)
> >   	print_features(mvdev, mvdev->mlx_features, false);
> >   }
> >
> > +#define MIN_MTU 68
> > +
> >   static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> >   {
> >   	u16 hw_mtu;
> > @@ -1995,6 +1997,9 @@ static int query_mtu(struct mlx5_core_dev
> *mdev, u16 *mtu)
> >   		return err;
> >
> >   	*mtu = hw_mtu - MLX5V_ETH_HARD_MTU;
> > +	if (*mtu < MIN_MTU)
> > +		return -EINVAL;
> > +
> >   	return 0;
> >   }
> 
> 
> This looks irrevalant to what is described by the commit log.
> 
Yes, this hunk came from a wrong patch of mtu.
I will fix it in v3.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
