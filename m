Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270FC4727F
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:25:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF72071E
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNNmzgIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BF72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 384AD86005;
	Mon, 28 Sep 2020 19:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XB8ZOvwduLhq; Mon, 28 Sep 2020 19:25:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2354A86044;
	Mon, 28 Sep 2020 19:25:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BFEDC016F;
	Mon, 28 Sep 2020 19:25:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86667C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7B896855F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 574AR1o0oMTB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D166485534
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:25:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601321116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2nKTlXCHkk0I+UzMY9e22BDypXWl7/hOf+zrdkgOpTo=;
 b=bNNmzgIR89bgwCxZZB0v6o2cnJY1AiuBpnNt6sURcS2yxBcUS2cIyE3oP2aKU3aqpraqiA
 wB5Nc7G3EaQWzyPx5OL3Vw0TRyE4ll9C8sQUka/FShh4vpKRl8I0JZwOGn0mBfdotAhVMm
 BWykjXMt5xkVNuMXbNO08AAXGE/egkw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-PshyqJ7lMq2Wlyp6lnwsCw-1; Mon, 28 Sep 2020 15:25:14 -0400
X-MC-Unique: PshyqJ7lMq2Wlyp6lnwsCw-1
Received: by mail-wr1-f71.google.com with SMTP id v5so767252wrs.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 12:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2nKTlXCHkk0I+UzMY9e22BDypXWl7/hOf+zrdkgOpTo=;
 b=g0pP2NFr5sl8han3cxyWVgqxy23kuAfHJwSwuiu4c9CTHdmID0+64rypxcbONDCbI6
 sgLU2SrfqQN0b26eyFhR9zeM39Yrql5cqOHiPOddhuiWao3xVUqIrufB3i1sPq3Dvfcp
 MR9XgWMaaB3bIgQc+0zudX1zsUijXsugQRw/ZdG8leB345xMUOQuVcf5CBX+toVJfjui
 f4q+THbx598yV59+/Uw+WdOTNpyn9g+p5IVuYOWr7jvaKXqIER4/O1akfHnoNNulsegg
 92TKHzQqgGL5QLVFhZZt1AEaTjQkwK6KiKJ6ffC56UEokJxPG9ItSHdf41RUjv9096lR
 uNwA==
X-Gm-Message-State: AOAM5329jDE7AiFUsVh3hMf6s/dm8IcRJbbpaFxoglSTU16PcS0RBQ33
 MT4fW82kMvcuyi9lo4KQiBh1p0JZXyAWWg5Gbee9Qtor5cPRpo6PxJOtytWfNLGfn79bSefJecQ
 XHi2b+DVv0w2ZD/Z0EWde5DBJ7kb28SyOHGa/ZUqmqQ==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr67865wrn.12.1601321113607;
 Mon, 28 Sep 2020 12:25:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7xSjUlrIYA4jwMpqWY182+T5ivdXhloLPiggvlGpfiY12bL5p1W8yFCJEjoKt1aJv2vxTvQ==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr67852wrn.12.1601321113379;
 Mon, 28 Sep 2020 12:25:13 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id o16sm2604020wrp.52.2020.09.28.12.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 12:25:12 -0700 (PDT)
Date: Mon, 28 Sep 2020 15:25:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: xiangxia.m.yue@gmail.com
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
Message-ID: <20200928152142-mutt-send-email-mst@kernel.org>
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Sep 28, 2020 at 11:39:15AM +0800, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Allow user configuring RXCSUM separately with ethtool -K,
> reusing the existing virtnet_set_guest_offloads helper
> that configures RXCSUM for XDP. This is conditional on
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 21b71148c532..2e3af0b2c281 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
>  				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
>  				(1ULL << VIRTIO_NET_F_GUEST_UFO))
>  
> +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> +
>  struct virtnet_stat_desc {
>  	char desc[ETH_GSTRING_LEN];
>  	size_t offset;
> @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
>  				netdev_features_t features)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	u64 offloads;
> +	u64 offloads = vi->guest_offloads &
> +		       vi->guest_offloads_capable;
>  	int err;
>  
> -	if ((dev->features ^ features) & NETIF_F_LRO) {
> -		if (vi->xdp_queue_pairs)
> -			return -EBUSY;
> +	/* Don't allow configuration while XDP is active. */
> +	if (vi->xdp_queue_pairs)
> +		return -EBUSY;
>  
> +	if ((dev->features ^ features) & NETIF_F_LRO) {
>  		if (features & NETIF_F_LRO)
> -			offloads = vi->guest_offloads_capable;
> +			offloads |= GUEST_OFFLOAD_LRO_MASK;
>  		else
> -			offloads = vi->guest_offloads_capable &
> -				   ~GUEST_OFFLOAD_LRO_MASK;
> +			offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> +	}
>  
> -		err = virtnet_set_guest_offloads(vi, offloads);
> -		if (err)
> -			return err;
> -		vi->guest_offloads = offloads;
> +	if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> +		if (features & NETIF_F_RXCSUM)
> +			offloads |= GUEST_OFFLOAD_CSUM_MASK;
> +		else
> +			offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
>  	}
>  
> +	if (offloads == (vi->guest_offloads &
> +			 vi->guest_offloads_capable))
> +		return 0;

Hmm, what exactly does this do?

> +
> +	err = virtnet_set_guest_offloads(vi, offloads);
> +	if (err)
> +		return err;
> +
> +	vi->guest_offloads = offloads;
>  	return 0;
>  }
>  
> @@ -3013,8 +3027,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>  		dev->features |= NETIF_F_LRO;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> +		dev->hw_features |= NETIF_F_RXCSUM;
>  		dev->hw_features |= NETIF_F_LRO;
> +	}
>  
>  	dev->vlan_features = dev->features;
>  
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
