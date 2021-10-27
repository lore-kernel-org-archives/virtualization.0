Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:31:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59F1610A4
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A59F1610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61A85605E0;
	Wed, 27 Oct 2021 15:31:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOKwWhr4XrSi; Wed, 27 Oct 2021 15:31:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 202D060666;
	Wed, 27 Oct 2021 15:31:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2748C0012;
	Wed, 27 Oct 2021 15:31:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F31C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A549A60666
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtoWS0wrKk7E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:31:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0F1A605E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635348668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlA3nQ1QJzVNgnX+dWY9bZTNzaWdxEwvFkBavyJU+R8=;
 b=Mt4pHa1lvmKIJsNI079UNC8Ef68dxGt/L0TseyC0Kgf2SkvLZbUBK7lwKVxu6n5IN5t0UW
 pjPNmILp9zn8A4EoQMSgmc0XBV3f7qfavzYO5DSFUmTrH7d5Fhw8NG14LJvd59l0DLYsEn
 rSjwNt6G0m7DaYR5qr3hkkkIWQX3srw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-2vgaxj_rPj6l9nFg2nh3uw-1; Wed, 27 Oct 2021 11:31:05 -0400
X-MC-Unique: 2vgaxj_rPj6l9nFg2nh3uw-1
Received: by mail-wm1-f70.google.com with SMTP id
 j38-20020a05600c1c2600b0032ccf96ea8eso1268729wms.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 08:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NlA3nQ1QJzVNgnX+dWY9bZTNzaWdxEwvFkBavyJU+R8=;
 b=ZPUUU/TSblyiOigQR8Nxg7A3KRndIkLUc4Ax+faeyI/XT2tLDZCGuETTEw1CLqDv4m
 u6FOKPdYoWJ87uwwHMdothvGozPSar5ZVajv/JnZPdrwvVe+YeOghiCJfFk9ysmx3ob9
 GBawsMFshAtwvdyP0rNbZ5k42u0+ADKXcoEbAXd4EjU0YPeVjlkIaceMN3FBeqRojj5q
 c1U+IVASE44k473Ae8k80dRFEMYlFXJnvtKUbr//FhWScfELpuWATL9CgiwRLvmBrTHG
 AsmjQbmvqydhVsvGA+5Bj0rnWVDmkyDcdLwbl0mb+B6RyD1F/bx0IC/kHve/it4d77ch
 KM8g==
X-Gm-Message-State: AOAM530aw9RQknlAu3MvHp+kNo/c/7r5p3izzLM/Einnq6xYe+3Ie0Cq
 /KcIDeTEdH/lWumpL9Iol67yZw3k+XkWyS8QJUBfcaR7xzlYhfT6VL/lLp+NgCwHYH4khbGxFeq
 pjaLdcKSUSasVjaN20J20Yqib6wnd5oP/zBKV9lAnig==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr36123793wrw.208.1635348664576; 
 Wed, 27 Oct 2021 08:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwja2+cAsX5qhyqxBAK7VZupFPj2JJ88axvhWNqQ4Jrw2r9FC4mm7+Txvs4mKv41SaXVzhbog==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr36123776wrw.208.1635348664436; 
 Wed, 27 Oct 2021 08:31:04 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
 by smtp.gmail.com with ESMTPSA id n11sm198454wrs.14.2021.10.27.08.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 08:31:03 -0700 (PDT)
Date: Wed, 27 Oct 2021 11:30:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] net: virtio: use eth_hw_addr_set()
Message-ID: <20211027113033-mutt-send-email-mst@kernel.org>
References: <20211027152012.3393077-1-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211027152012.3393077-1-kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, davem@davemloft.net,
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

On Wed, Oct 27, 2021 at 08:20:12AM -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it go through appropriate helpers.
> 
> Even though the current code uses dev->addr_len the we can switch
> to eth_hw_addr_set() instead of dev_addr_set(). The netdev is
> always allocated by alloc_etherdev_mq() and there are at least two
> places which assume Ethernet address:
>  - the line below calling eth_hw_addr_random()
>  - virtnet_set_mac_address() -> eth_commit_mac_addr_change()
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: - actually switch to eth_hw_addr_set() not dev_addr_set()
>     - resize the buffer to ETH_ALEN
>     - pass ETH_ALEN instead of dev->dev_addr to virtio_cread_bytes()
> 
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/virtio_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c501b5974aee..cc79343cd220 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	dev->max_mtu = MAX_MTU;
>  
>  	/* Configuration may specify what MAC to use.  Otherwise random. */
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> +		u8 addr[ETH_ALEN];
> +
>  		virtio_cread_bytes(vdev,
>  				   offsetof(struct virtio_net_config, mac),
> -				   dev->dev_addr, dev->addr_len);
> -	else
> +				   addr, ETH_ALEN);
> +		eth_hw_addr_set(dev, addr);
> +	} else {
>  		eth_hw_addr_random(dev);
> +	}
>  
>  	/* Set up our device-specific information */
>  	vi = netdev_priv(dev);
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
