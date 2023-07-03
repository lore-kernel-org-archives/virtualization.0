Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACEBEB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 15:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D562408CF;
	Mon,  3 Jul 2023 15:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D562408CF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PtTctG/1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gst0Yy8asNOu; Mon,  3 Jul 2023 15:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 901F840611;
	Mon,  3 Jul 2023 15:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 901F840611
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6309CC0071;
	Mon,  3 Jul 2023 15:46:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4510CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 15:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FBDA401A3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 15:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FBDA401A3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PtTctG/1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nQMFh41libM3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 15:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A33A400FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A33A400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688399185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1NZ1ljPvaJ3lSN+5NzJxss1L8wbkM12/fOlYD41I+hs=;
 b=PtTctG/1ez7VXREMouolHSd2PlD6Se30N7Op8DdJPfxgP5bBxBJzvcIVFov6OwZnLzcfnC
 4m07LnGtsvLHbgS2y/RgfnruLPqzaPRu9JR+/ZWrUPw+aLXVDzh3l0DnUmgZbZxk7JFbWU
 d4a3vNk7sFXUPRDMF3bEAuHkMrSFy7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-iGaX2Ic5M36Aq6m2jyHW4A-1; Mon, 03 Jul 2023 11:46:24 -0400
X-MC-Unique: iGaX2Ic5M36Aq6m2jyHW4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2301803f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 08:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688399183; x=1690991183;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1NZ1ljPvaJ3lSN+5NzJxss1L8wbkM12/fOlYD41I+hs=;
 b=DXzl2YA8qmsrApOQSoliFa7yCmNHxb2yPwr8kpq/RsXCgFqfTfN9Q4TLyKWoYzhAQE
 R50d7aji/0pU9ixNiLzoLLcuuWcC4eS4yjDIjV7Xfn+BfBk0K+6nhHexpsHKRUCH8war
 ZuDYdaUUAkhQxTGV/TEq25oTQT9WmkQ8WgOjjGqiuD2XOpIOR8U000OkHMggh/cYZUF+
 hs9vvFuPSVjXtDo9k3R8DYLbj9kqfSa4OZglt393H4TjzcPBid+xDXa58FqDrPt+l7X2
 k0Vlxk+Ooo1w1rwPP7MVur2tzgYrhNvZUAWAbeVqFmLn/85rOWkkfgFqBGFkKRIYfemZ
 qK7g==
X-Gm-Message-State: ABy/qLbOmsKegzREh6lXzeKzjhOORH+XYvk4n5+sIzkDOmukzoAVLAfL
 60En8cjhlpnFwqD1z/NqdT9qcbMLwL8nVYY/+VRdTRs9x3tIgZvO+GHmFSpmtP0W2QmikttuEUH
 4NYULFNcE5If+3nEkqBgPUnapXgatcRs+vupA6EVbng==
X-Received: by 2002:a5d:6b51:0:b0:314:2ff2:b051 with SMTP id
 x17-20020a5d6b51000000b003142ff2b051mr4571361wrw.41.1688399183196; 
 Mon, 03 Jul 2023 08:46:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGx6h38T6vXWijoWHBefYK9XvHRwTUZinS5fxcyNS70iY6BvXvn5QbTff33EKlYWUaKf1dIJA==
X-Received: by 2002:a5d:6b51:0:b0:314:2ff2:b051 with SMTP id
 x17-20020a5d6b51000000b003142ff2b051mr4571342wrw.41.1688399182846; 
 Mon, 03 Jul 2023 08:46:22 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0030ae499da59sm10816007wrn.111.2023.07.03.08.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 08:46:22 -0700 (PDT)
Date: Mon, 3 Jul 2023 11:46:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230703110241-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230703142514.363256-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio P=E9rez wrote:
> Offer this backend feature as mlx5 is compatible with it. It allows it
> to do live migration with CVQ, dynamically switching between passthrough
> and shadow virtqueue.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>

Same comment.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 9138ef2fb2c8..5f309a16b9dc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -7,6 +7,7 @@
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/vdpa.h>
> +#include <uapi/linux/vhost_types.h>
>  #include <linux/virtio_config.h>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/mlx5/cq.h>
> @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_v=
dpa_net *ndev)
>  		flush_workqueue(ndev->mvdev.wq);
>  }
>  =

> +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
> +{
> +	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +}
> +
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 f=
eatures)
>  {
>  	struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>  	.get_vq_align =3D mlx5_vdpa_get_vq_align,
>  	.get_vq_group =3D mlx5_vdpa_get_vq_group,
>  	.get_device_features =3D mlx5_vdpa_get_device_features,
> +	.get_backend_features =3D mlx5_vdpa_get_backend_features,
>  	.set_driver_features =3D mlx5_vdpa_set_driver_features,
>  	.get_driver_features =3D mlx5_vdpa_get_driver_features,
>  	.set_config_cb =3D mlx5_vdpa_set_config_cb,
> -- =

> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
