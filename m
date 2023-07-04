Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B8EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 10:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C741240391;
	Tue,  4 Jul 2023 10:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C741240391
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Po2MWcDP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pb6wtODFYCei; Tue,  4 Jul 2023 10:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31973400DA;
	Tue,  4 Jul 2023 10:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31973400DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3A9C0071;
	Tue,  4 Jul 2023 10:16:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82EBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A98FC60E3F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A98FC60E3F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Po2MWcDP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZaF4Qq0zjHZ4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F5C3608A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F5C3608A6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688465788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzKWcWNbdy1eikXjeDKW4tKRnjZxY0mHx4cUe+wcPOU=;
 b=Po2MWcDP2njRxbekhArFDqHShUerhIVzJ4GucSypIyQ0YUGTeZfDcEhppA7dJhMV8YSBB+
 ymBkuXv64UmzXTasRrXxTRLN2L0iiNkQwL3i5n13ZFqLZGp8KRbS6MZgFJi5r+2+Z/BTGN
 reEM+zIFIFvfkLD0UKx3+9lMWnf1OUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-xOp6ApBAPRGAwnJLTFMwRg-1; Tue, 04 Jul 2023 06:16:26 -0400
X-MC-Unique: xOp6ApBAPRGAwnJLTFMwRg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f810b4903fso32828305e9.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 03:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688465785; x=1691057785;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzKWcWNbdy1eikXjeDKW4tKRnjZxY0mHx4cUe+wcPOU=;
 b=B2RW1gsqjyavsNQNFD6FRm6R3PLLuv+reU40fq6NR80LwyQtgg05xZ3SMM7oP/Gj8U
 d83E5CgVX4+AR4GB+jn8O//R+3OpMwh8Ch1UfNzYyyXIDa9nYhhJB0K8T1xu/njawf3k
 JTZPMgFJ842WmNuOj5J1JKlxGyWvv4CQLiR0j1g3ivZjub43/8wrtWolsbKLHA/Wg5dA
 3jXBdBjPcK7aM0rp09FGCxPWVafd8WmSjA8VX4zcvfS9mIrNJ5W83Brmd7+LDUSXkke6
 V0al7DBBeWYD8gxKK6QOSAlx3PW9GF9gzNvREqZusrMCMbZ6QxWhnJBrp31lugq1h8kR
 x3Iw==
X-Gm-Message-State: AC+VfDwm4wFJe7HUjIinUlT4LO4jS2J6d80hIC3BOim/ib6RrTafUhJh
 ARC7sWes0s0hMi+HXaX0CE+Riahfgci1HloHqy2g4JC442UI8Cjp2SlZ67rGvxvrCUDhq172lLz
 Tnj16t1vsIsZrFnT/G0m8ezVcGjTrXU7XLTKmgMITWA==
X-Received: by 2002:a05:600c:224c:b0:3fb:a5a0:6199 with SMTP id
 a12-20020a05600c224c00b003fba5a06199mr11644664wmm.14.1688465785730; 
 Tue, 04 Jul 2023 03:16:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48SCmk7KFv2iokhJjmfb1gPMTBckEl/OtlE7ovaKXJ62b8bGF9Sm/mxfTBvSpRedzKtf6n0Q==
X-Received: by 2002:a05:600c:224c:b0:3fb:a5a0:6199 with SMTP id
 a12-20020a05600c224c00b003fba5a06199mr11644649wmm.14.1688465785442; 
 Tue, 04 Jul 2023 03:16:25 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 a10-20020a1cf00a000000b003f8fb02c413sm29765719wmb.8.2023.07.04.03.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 03:16:24 -0700 (PDT)
Date: Tue, 4 Jul 2023 06:16:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230704061356-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, leiyang@redhat.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> =

> =

> On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=E9rez wrote:
> > > Offer this backend feature as mlx5 is compatible with it. It allows it
> > > to do live migration with CVQ, dynamically switching between passthro=
ugh
> > > and shadow virtqueue.
> > > =

> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > Same comment.
> to which?
> =

> -Siwei

VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit t=
o it
as a kernel/userspace ABI: what if one wants to start rings in some
other specific order?
As was discussed on list, a better promise is not to access ring
until the 1st kick. vdpa can then do a kick when it wants
the device to start accessing rings.

> > =

> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > =

> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -7,6 +7,7 @@
> > >   #include <uapi/linux/virtio_net.h>
> > >   #include <uapi/linux/virtio_ids.h>
> > >   #include <uapi/linux/vdpa.h>
> > > +#include <uapi/linux/vhost_types.h>
> > >   #include <linux/virtio_config.h>
> > >   #include <linux/auxiliary_bus.h>
> > >   #include <linux/mlx5/cq.h>
> > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct ml=
x5_vdpa_net *ndev)
> > >   		flush_workqueue(ndev->mvdev.wq);
> > >   }
> > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *=
vdpa)
> > > +{
> > > +	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > +}
> > > +
> > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, =
u64 features)
> > >   {
> > >   	struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_o=
ps =3D {
> > >   	.get_vq_align =3D mlx5_vdpa_get_vq_align,
> > >   	.get_vq_group =3D mlx5_vdpa_get_vq_group,
> > >   	.get_device_features =3D mlx5_vdpa_get_device_features,
> > > +	.get_backend_features =3D mlx5_vdpa_get_backend_features,
> > >   	.set_driver_features =3D mlx5_vdpa_set_driver_features,
> > >   	.get_driver_features =3D mlx5_vdpa_get_driver_features,
> > >   	.set_config_cb =3D mlx5_vdpa_set_config_cb,
> > > -- =

> > > 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
