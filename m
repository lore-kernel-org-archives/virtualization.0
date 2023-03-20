Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C5CC6FD1C
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 20:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56FBB40A6D;
	Mon, 20 Mar 2023 20:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56FBB40A6D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HqM/4hxD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FBWVEQ9YoyU4; Mon, 20 Mar 2023 20:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4EF54047B;
	Mon, 20 Mar 2023 20:02:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4EF54047B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 913E3C0035;
	Mon, 20 Mar 2023 20:02:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65A6BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 20:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A19E40A5C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 20:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A19E40A5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9dftqPrGKe5p
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 20:02:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 315084047B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 315084047B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679342570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n+odsWK/6XB/7HnKfFcwb3aXLzuuaTQPBIxdkaXeqKE=;
 b=HqM/4hxDJ/E5TcJeLu+0tky8/CPSH05dIxdEj4Npb/pZ1QDIQC9MT7ol1JlJpoaFIh+KrO
 HEHI1KB59crLB/1xbym/o93yjjmPnp2mMCsb9pgkRJ+PK6OLwFbWadJxLOPt2aCVkzfAto
 kOJk/mHUxIxM6tqBlVL0bmJdGpsxoMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-O15UWDIkNaWfavuJ5xmnXQ-1; Mon, 20 Mar 2023 16:02:49 -0400
X-MC-Unique: O15UWDIkNaWfavuJ5xmnXQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 fl22-20020a05600c0b9600b003ed26ca6206so8956165wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 13:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679342568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+odsWK/6XB/7HnKfFcwb3aXLzuuaTQPBIxdkaXeqKE=;
 b=uddDqVhTLY9+i0mPL2U5ndWeITVDpJxghR2C5Ixfu7ogPqLyxrpumPLS0DKBvrQXQD
 FV3wE9IjhUj/qNxhH51LcBX6vXR7DGfqXKzBhz0YadT7NpgCypZ74P7ExT4lhro4ijNQ
 4Hc3dCGGoLxzM6CtCjb09dMxKzXOlOc0B8H7wOk+niPDh6NZ0bgvu33tnJj9LJR377dW
 WITR4x7dg7r+P7V0GPAIL4WK8cEv8kmx5l6Do5M52pqfxNSgBRGy6oQfdX1lzCzFYJ6G
 0+RnR7pkEgBYVSWCV7JsPEJO5ZRzztoAKfE9Y++WwONf1XGsZxbch1cvn2WxFKBz8igX
 hVDQ==
X-Gm-Message-State: AO0yUKVrw1JWxHtBtN49ZOReHf8X+mt4ogEUg1hIQxqwVkG5p/Gq8SEQ
 0Jzds8Zljv77P8ofZKOQm3VdU8H/Av13+B/YYSapPBpXCxTGCIXJAUgF9Gl+OxCU639cqX41oys
 y7OtL/Om1+FpRCzxgFPZefe/A7P5zhOSV3igutztqDA==
X-Received: by 2002:a05:600c:22d4:b0:3ed:7700:eb88 with SMTP id
 20-20020a05600c22d400b003ed7700eb88mr537332wmg.13.1679342568387; 
 Mon, 20 Mar 2023 13:02:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set8K4GLauapoPdv1AfU5pXJtSJp9GuT0N93+IE9hlzwBpTuUQqlUbDQR1Qkq31uqOQKagcBFhQ==
X-Received: by 2002:a05:600c:22d4:b0:3ed:7700:eb88 with SMTP id
 20-20020a05600c22d400b003ed7700eb88mr537319wmg.13.1679342568099; 
 Mon, 20 Mar 2023 13:02:48 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b003edddae1068sm5605654wmo.9.2023.03.20.13.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 13:02:47 -0700 (PDT)
Date: Mon, 20 Mar 2023 16:02:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 2/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
Message-ID: <20230320155938-mutt-send-email-mst@kernel.org>
References: <20230320114930.8457-1-elic@nvidia.com>
 <20230320114930.8457-3-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230320114930.8457-3-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 20, 2023 at 01:49:30PM +0200, Eli Cohen wrote:
> One can still enable it when creating the vdpa device using vdpa tool by
> providing features that include it.
> 
> For example:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> 
> Please be aware that this feature was not supported before the previous
> patch in this list was introduced so we don't change user experience.

so I would  say the patches have to be reordered to avoid a regression?

> Current firmware versions show degradation in packet rate when using
> MRG_RXBUF. Users who favor memory saving over packet rate could enable
> this feature but we want to keep it off by default.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>

OK and when future firmware will (maybe) fix this up how
will you know it's ok to enable by default?
Some version check I guess?
It would be better if firmware specified flags to enable
by default ...


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 5285dd76c793..24397a71d6f3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3146,6 +3146,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			return -EINVAL;
>  		}
>  		device_features &= add_config->device_features;
> +	} else {
> +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
>  	}
>  	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
>  	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
