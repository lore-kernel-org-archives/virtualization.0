Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0A960F5A
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF0A960F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6226075B;
	Wed, 27 Oct 2021 07:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kx8hlLFKi4B4; Wed, 27 Oct 2021 07:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D87860676;
	Wed, 27 Oct 2021 07:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31D42C0012;
	Wed, 27 Oct 2021 07:23:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD2AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0767280B02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6PIdHylHFJV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:23:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABAEE80AA6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635319405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kKwjUWtGswnRMdQI3v9sQff+PJbuXRHpBkdFH8zvQS8=;
 b=F6zvHl4lCvoz6Gg8+aGK338TZUWYRBv+T3VLq4xaKeLvrwpXiekgZ62dgXmrOW9tEMCGpP
 4R7CNJ3hjHFWO64lLBWw1IItkCfHaptcc9QJhX+au7Xnni6dUv4h52L6L/lyvrwlqz+yKW
 5w9r57+jLKeVFLF+QpXtFQwTfoZAKGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Y3o8YOjnP-OQPdMfujGhPw-1; Wed, 27 Oct 2021 03:23:23 -0400
X-MC-Unique: Y3o8YOjnP-OQPdMfujGhPw-1
Received: by mail-wm1-f70.google.com with SMTP id
 a21-20020a1c7f15000000b0032cd93a2bd7so8134wmd.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 00:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kKwjUWtGswnRMdQI3v9sQff+PJbuXRHpBkdFH8zvQS8=;
 b=abPycneKsyj18I0fRZl+ckzdhW3wiXLDt5tFohN7SDvexi3/CQ8Oq6+4dR8q7S3nOY
 Y17Cp0nS2+DgoLT7BdGoDKzJ89nWcvLSYvAj979kd5NI5NnotODUALAAdBLLzk2aEcVb
 8IP7Ofkmro4VGWsI2pd+6S6CUIR6F0FFD9tQHEeb226dmEkwkrrrGexM+LS+v/8OHStq
 9g2lj77VL32ooomIqE+mLdw3kWX4J6oMHAMcaaHoWT4jpDyCt7piZEEOspQxGqz/hqTc
 gi7lY+zUko6fzzPvnvFGR7NwDQ5iRp7uBKfBHqwOax3S2LcAIAKyS8d7RNku0ozaqxSW
 2dbA==
X-Gm-Message-State: AOAM533ZxzqkEeha/aV/raZF9F1hXMRL+n2oBhtj+OPeTtXf+nMzXoQg
 dlD3SoVLmf2SZkdNNxLX55M/PRuGvF/1AOWcOwkBfRXA7gtzB6xWaER0yOlojmYx11CYKipHKg+
 a1dgNbjwRDjAWv69+CTKfZWBfeeRQ2Dq25pbn4doiGw==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr4931504wro.86.1635319402507; 
 Wed, 27 Oct 2021 00:23:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaV9JBTSXjkf98o2dkjaFTK9GIFBtEjH9xoFyu0KuDhxjriNpKUFW0HQUW6QxBma8zwjt32Q==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr4931493wro.86.1635319402370; 
 Wed, 27 Oct 2021 00:23:22 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:a543:72f:c4d1:8911:6346])
 by smtp.gmail.com with ESMTPSA id t12sm2683586wmq.44.2021.10.27.00.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 00:23:21 -0700 (PDT)
Date: Wed, 27 Oct 2021 03:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: virtio: use eth_hw_addr_set()
Message-ID: <20211027032113-mutt-send-email-mst@kernel.org>
References: <20211026175634.3198477-1-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211026175634.3198477-1-kuba@kernel.org>
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

On Tue, Oct 26, 2021 at 10:56:34AM -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it go through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/virtio_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c501b5974aee..b7f35aff8e82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	dev->max_mtu = MAX_MTU;
>  
>  	/* Configuration may specify what MAC to use.  Otherwise random. */
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> +		u8 addr[MAX_ADDR_LEN];
> +
>  		virtio_cread_bytes(vdev,
>  				   offsetof(struct virtio_net_config, mac),
> -				   dev->dev_addr, dev->addr_len);
> -	else
> +				   addr, dev->addr_len);

Maybe BUG_ON(dev->addr_len > sizeof addr);

here just to make sure we don't overflow addr silently?


> +		dev_addr_set(dev, addr);
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
