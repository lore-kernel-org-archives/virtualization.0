Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:07:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA16761029
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA16761029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74ABB401D7;
	Tue, 26 Oct 2021 04:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pKikNH65FhmD; Tue, 26 Oct 2021 04:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1113400E1;
	Tue, 26 Oct 2021 04:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71C39C0012;
	Tue, 26 Oct 2021 04:07:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C8C8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71769401D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:07:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K9U5dXIWF_Hc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:07:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E18F14013D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlH4vXRS3qESsaVprUEhsfV8wqWZD9tw5nvXW3cVAV5SXsAr2pyTtOZ9i2qmMY0fL2bdzcCME01gGAKYsun4GDrEPdNKxwknRu7tz4SgU3r7YaUZ8NA97hBXrPQkVvUjTRE8tNLqYq70JiJk7bPVF98aunY+8G4PAFrZAJN38VyZtwYNTd1UJIkW+Odi0LpsM6MsHXw8v8mkL1CPSf+SD+7cirtI+RhhSfawC3OsMLaiWakvEBnnq4XD0CPIw/+G8XxiAbOnN6oLlsILxcjDjwcUYhOw05WHFcTEt/7g4gXXhodSKtONg6UPaQnxS05ADpDX+QhnEqw8Jo2Gfcztqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtS/rS0qSxag/H/oQW1+HUs9fu463GtGV+2PtHpVRek=;
 b=KYCTnc9TbLaCXaBbLlWTVBfu30RTkxFCSVLfgAg2EsqLVYKOVJKGgU6GanAOKdmOLbvho0EtgQiCpCk5ltc/kAapw2uWMMzN44Vja4JB2+n54ki8WhN3pwF8/lsXPAaZPKi4ZBM9g0zaDEfZnS5Qvr2k6ribAyxM3KqMkEkIijfBa3SsUrgo3lh2cwHRPLzdcKnhWuR4hNFzQw0dDuzdgCtBmmISUN3UmA2fTI9aayt0/orQDrMEGQ+Po643+5cSu4rFtKfCAT+Z3cg9ZwlmB6g8OTbS92hrqEvDiOB8/tE79Omsddw8LmAkrdSaNE33q6yK0nk1/ZF46VS8a0Vp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtS/rS0qSxag/H/oQW1+HUs9fu463GtGV+2PtHpVRek=;
 b=B2G8q33HDF8/0IIWUslYb6QhFv8e3OFKp8xt/3u9Ps2UN1evRgyabWBN+6sltJ82pxvbnjmXIUkuGsARJ7t7R4CBdc8IaO72gYrv/ULCNu1Uv+V+KHeumEUiWXZSlOp/k3sCK6YI0VwNXZldrTLQwQSwSbxwwLbZJ7mgkUt7mn6k1xy0kWflEZAyyHGg4l2d10pzO68KaeUasEi48tzJAnhOqSLcqQbyj2YTbRUdszNUy2nDIoPgUyx2raGL0roxXVp+2hfHXmK7SczXrKUXRCqVbHT4mg47uoZBArdKhGB/ZXq3QvRpQbFdBm+E/iKpJJ+gDWddNMe+nP24wTjE9A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:07:45 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 04:07:45 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Topic: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Index: AQHXyZ9Zee9PnHCFgkCpho/IiIavRavkCf8QgAAteACAAHM4IA==
Date: Tue, 26 Oct 2021 04:07:45 +0000
Message-ID: <PH0PR12MB548129D8A5197974A5917BC0DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
 <PH0PR12MB5481911ACF48EE43603F5EA6DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211025171431-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025171431-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18eae99b-f5b6-4a4d-bb60-08d998362a41
x-ms-traffictypediagnostic: PH0PR12MB5500:
x-microsoft-antispam-prvs: <PH0PR12MB550054B48533F6C704D9BCF9DC849@PH0PR12MB5500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYUfKwxVxRLJVR708i0bOqA18AZvZ2acvOjomyJnz4zRqx09LVj4I0DOuoqw0pjlOlxqtG/YFyPqtDEzBRNwkqxLi2yDI7FkIRrqvrXcblecSAaN5k/+6nlVDBSuKmwgqfFPKy74y8x25LQg/N256olsr9jhlRSkX9TCnB4iJaNgDrD/hS600aaX3+IZtrdDQo4LIGFU2z1YROewG1KlQ4ZgGtBMedwmqP2xbLakh42SP0ISBtM5uuPR4LZIVRi6ep+NVf/MB7kr6IbZW17THWZPlL14E8/fsdZhsoabcEUFjvuKcWJTeC6Q78kynWZDo6qpxnOF62BlR8G156k8X00Oeyu+G5MP+G74WUq05nE0dYtwSPtjzz5TlJdIjkxQbF97yL19pNicFuGQHnHNNkj+kt3gf2GmBRoaCYmudskoXgeeshZW/BmDl6TLNiVd/Lez1WOi4qhIJXUGHhRTiue74bL2XJTluQXA6lWEzFaUJdTDmPYNJSRM147hmMj6X4uO1tz/Kp+NIpcuZKmcNi5wcdv2d8/0m5eLOR6kJYpaLOt3p0tjnoPk157j92JuEcA22vTm4tvSHYzIZABH1G7ut7hhDwPlEhA2s09KefK1uwQIVV9WU2BvgtprHW8Cz4PcW72FhnB+mrna3vHiWNAXwb1FBc7ESji8kxSgIURiICSSw4yi4fooOnB6ONAvy4QZVCxq4bv5juc6VXg9NjfrDVoNUXmcxSnNcNdSI4l85q7j/qH0ZpDihen6BL9k5FBSvd/PKGDZ5w8GnVvAies1UEv373DPlxjMF296314=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6506007)(26005)(38100700002)(2906002)(71200400001)(966005)(33656002)(186003)(8676002)(508600001)(8936002)(107886003)(66476007)(6916009)(4326008)(55016002)(5660300002)(9686003)(64756008)(66946007)(76116006)(66446008)(52536014)(316002)(54906003)(83380400001)(38070700005)(66556008)(122000001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XtAeutqTWqkbtvV5ZlrGhzAXxO7TCWs61RiON77/BQzIU3WtZvQutqoQPeHZ?=
 =?us-ascii?Q?+ULDohBfrW2GpRvmhRpmJFse6/MltKxwxKAR3zFXyLif14KwEtaCefEmoohh?=
 =?us-ascii?Q?5MMOH8DawLjmszcjncXr3CjD/dz/MoP3wL1kNvzlnwlq4F1aJ69w8MAaSssD?=
 =?us-ascii?Q?Ntye4aV1qCK6qQvvOoqUcZsns8g9t2nzjZtsEFYx1MoWbk7Fp9/f5mxmSVFg?=
 =?us-ascii?Q?8MwUL//R5Mx25aLAdQmUUfb2gimReBDC22Vmi5gT6dPz2yocSiUWOzzm9ii6?=
 =?us-ascii?Q?M7ItfxTc3iEI7z6cHevE1kiIX4QGt2s6Ne7/HB4yyfvIcEP5kvDEA7ymSSI7?=
 =?us-ascii?Q?zSa1kDHcrIJSkRKoLuJsbvAm6H/4/cNFFvvL1/8GJDO+DXRsp7S+6ftB4VDb?=
 =?us-ascii?Q?twX/6wvl8RDKdt1YHNjokpFEXt7d+NNx+xcwMn4TtaWOx+nIjEZgcJPkXaf9?=
 =?us-ascii?Q?WOb2GqQ/n2BDATKjX4k9Z3/QsLtk8FItQTYIhMIpxdOZv4tXqUISDtQkouf2?=
 =?us-ascii?Q?5FGn111OEiURksm9xMIh2PXh1vzGg/+tQiabJHlWwUlZ7RxGx5TN4zqKwlEQ?=
 =?us-ascii?Q?8BC5XC1GovKd3pt4RS1fmxn1w4uUsWS9tkiQI2ocIJ8yNgL2msEB4SQTiKMf?=
 =?us-ascii?Q?5WXjhBgFKShpiF+dEBnAkOltmnNWuvqEuB6tWplucQy7m2a9O3q3HUANU+6K?=
 =?us-ascii?Q?MCX0bEASjMoXN4j5k6PF9QwOqCZLUMly849PaAZBaEQRrMJyEeGZxpDpTpUQ?=
 =?us-ascii?Q?vJ5wb7YoWGB+SOOarYqqUYh5bGWK228PvnrZUX65g77Ao079I5bqSCWQ95BO?=
 =?us-ascii?Q?ISphTQv2CMuJbpDx1WV0xd5NDjrJUx/2BoTiSUpLRdRuVrzXPrDIFRqKK2jP?=
 =?us-ascii?Q?WMZfR/k5E5oSaJKsEKHAZSxP+1jf1Z1tf+hD7SBKO1J7vOrbrQdOs4h7x9H7?=
 =?us-ascii?Q?TGNsy4NKl8O2iyNR+iM43MgxDkrugPbUmCgeWbp42bl4e7fbjX61FvpKl+Cz?=
 =?us-ascii?Q?gTeF/XthKkbILTU29+gIHMIBC46+50le7K1r/hDqp/tzt/Gv31TCz8VOB4TZ?=
 =?us-ascii?Q?3mTh10s+8d8IqnMZoA/l3aCeuh2QH8prpNk5p18YQgE0YJGF95arlgT78dN+?=
 =?us-ascii?Q?XsUmxTxZIyRSVZnDm4wkEfLxl61Co2B5MA4SQVWJEb3loWOI+WFKbDNWK9qG?=
 =?us-ascii?Q?BT4NYkymhU22zp7xF3dZckMrWYM8PSUIMlYOsaqr5jyVw18kUj2waNTO4eEm?=
 =?us-ascii?Q?5yQSjfHY30zarlt4GyP17NqL0yBJQvIfn/7VAdlRUG4taEyTB4hdwqgg5BVj?=
 =?us-ascii?Q?mubxIJUyqp2fgkXDCl2QpGi10R9+1MAYPqH+THt9YyxxbVH9mo44zzxcm/Bm?=
 =?us-ascii?Q?JIUqtqoVXDkXOfc1p8gzaMm9mtSSh7Q7a6Utc1tX7kdwpeI58Q5DZcCHSrWP?=
 =?us-ascii?Q?7hj4nm81g4eRuFeCFEqPzrk/T8LojIngBdcUPzML7gipPOUGG2O+wHzMKFEY?=
 =?us-ascii?Q?3BkAcitl5rlBlI4h2EBxXqLo9l9amohBhotAm2wJc77qm4heH4SYC62wM20b?=
 =?us-ascii?Q?Om7Si62JOkuX1gV6keo8AO66SLUIerk0xe5ZoOU79pX7SajWDKGDTcaMJWuZ?=
 =?us-ascii?Q?AZ83nknHcGn3j8aDR52eZWU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eae99b-f5b6-4a4d-bb60-08d998362a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 04:07:45.2878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Qs+hMlkhejQXtnJsgL2S6hQKRWOpa86H0K9PXaYkndHX09ZhLntSTAcYpmb6MOnrJZ8byFLJ1tyGO1yA3HT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, October 26, 2021 2:45 AM
> 
> On Mon, Oct 25, 2021 at 06:35:35PM +0000, Parav Pandit wrote:
> >
> > > From: Parav Pandit <parav@nvidia.com>
> > > Sent: Monday, October 25, 2021 6:23 PM
> > >
> > > From: Eli Cohen <elic@nvidia.com>
> > >
> > > Add code to accept MAC configuration through vdpa tool. The MAC is
> > > written into the config struct and later can be retrieved through
> get_config().
> > >
> > > Examples:
> > > 1. Configure MAC while adding a device:
> > > $ vdpa dev add mgmtdev pci/0000:06:00.2 name vdpa0 mac
> > > 00:11:22:33:44:55
> > >
> > > 2. Show configured params:
> > > $ vdpa dev config show
> > > vdpa0: mac 00:11:22:33:44:55 link down link_announce false
> > > max_vq_pairs 8 mtu 1500
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 8d1539728a59..860d80efa5d1 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/vringh.h>
> > >  #include <uapi/linux/virtio_net.h>
> > >  #include <uapi/linux/virtio_ids.h>
> > > +#include <uapi/linux/vdpa.h>
> > >  #include <linux/virtio_config.h>
> > >  #include <linux/auxiliary_bus.h>
> > >  #include <linux/mlx5/cq.h>
> > > @@ -2523,18 +2524,19 @@ static int mlx5_vdpa_dev_add(struct
> > > vdpa_mgmt_dev *v_mdev, const char *name,
> > >  	if (err)
> > >  		goto err_mtu;
> > >
> > > -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> > I messed up above line in the rebase conflict.
> > Let me resend the series.
> 
> If it's happening it's better happen soon, rc7 is out.
> 
Done at [1].
[1] https://lore.kernel.org/virtualization/20211026040243.79005-1-parav@nvidia.com/T/#t
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
