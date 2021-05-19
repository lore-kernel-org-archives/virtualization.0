Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA7C433ED
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 12:44:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F5160FE8
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F5160FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC5A3405E6;
	Wed, 19 May 2021 12:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNAKaOHZvVe1; Wed, 19 May 2021 12:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FC0B4040A;
	Wed, 19 May 2021 12:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F07D9C000D;
	Wed, 19 May 2021 12:44:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F5CDC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 12:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CEB74044C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 12:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4vieF1zs2PU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 12:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E5CD403D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621428247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nRJlqzEVYVS1/SvMXR+2/BKtjftG9Sb49308uzo44I=;
 b=P2SUMf1UTyu6JxSIhvtGZ2/6Zc6Fnf873frF3gGTPL+ajW6EhE1HSUFkkTzdWpDfRIft6A
 y0R4X4ZSLVdC86CaMCZopChG13lt1f16EnE8psNEhLHMEajWSuvwtvUnZVvPgIIw5HYjIH
 Ll0P0zD0W4+WSQxGErPmajQsdbmhlvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-orPWqR17N86r7XKEdA3V-g-1; Wed, 19 May 2021 08:44:06 -0400
X-MC-Unique: orPWqR17N86r7XKEdA3V-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 b16-20020a7bc2500000b029014587f5376dso1783857wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 05:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3nRJlqzEVYVS1/SvMXR+2/BKtjftG9Sb49308uzo44I=;
 b=NwRTqK0ySQAkHnf3pY0xdTT02YGn5vsUHgCjg13lOk4RfdAc/qU2dVmiQOYXxCQM++
 2zcTw57+CYOFki1V7puBbOXbhHju0Rstg37bLZtSS9gwE58pk9J6Y4G2GX5P9YpwY0+6
 Tu2KPC5PvmjruA/Mdy1xeSQcy6j4C6aQ6tSbGCahP+UGtTrzxLAdieDAMh3kEi+82s8V
 WdIWd1nXwKJiWpNh/fUWTge7eJXmnuOmLWMtXsZVugfS/wFdPIor+28+TfOoMR1I8+d8
 H9UWk7ymdjXNrn3W/NDs4BxXJv63DhuGdNjOV+g/JflyMyuuRu25kM2C0Qow1P0BZ6mh
 WE/g==
X-Gm-Message-State: AOAM531w7f0mjayhjMknVvzK8LNim3pDF3GIsEpDNLzE8oMCSeDp7VI2
 kKl0wTSh15rgfIX2HuWp0DJ7elJtzBrJi3Rvn6FXTheYzaxVx7KVSwNQne/Nv8hoQodnHJ1/Ib1
 gcxCuKXnbfJoGGtLMKJtcjbhp48eHBd3Ez3a9bUj9Eg==
X-Received: by 2002:a05:600c:4f93:: with SMTP id
 n19mr10882671wmq.100.1621428245059; 
 Wed, 19 May 2021 05:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2zXAce9vxa84C3TXPO1jqG3bwYE0ylT4xa1LflwpAW7o/fVS2uf5HuwYeghETT6bbuUdD8A==
X-Received: by 2002:a05:600c:4f93:: with SMTP id
 n19mr10882654wmq.100.1621428244873; 
 Wed, 19 May 2021 05:44:04 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id o21sm25628938wrf.91.2021.05.19.05.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 05:44:04 -0700 (PDT)
Date: Wed, 19 May 2021 08:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: Introduce a new kick interface
 virtqueue_kick_try()
Message-ID: <20210519083900-mutt-send-email-mst@kernel.org>
References: <20210519114757.6143-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210519114757.6143-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
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

On Wed, May 19, 2021 at 07:47:57PM +0800, Xuan Zhuo wrote:
> Unlike virtqueue_kick(), virtqueue_kick_try() returns true only when the
> kick is successful. In virtio-net, we want to count the number of kicks.
> So we need an interface that can perceive whether the kick is actually
> executed.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c     |  8 ++++----
>  drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9b6a4a875c55..167697030cb6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -617,7 +617,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	ret = nxmit;
>  
>  	if (flags & XDP_XMIT_FLUSH) {
> -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> +		if (virtqueue_kick_try(sq->vq))
>  			kicks = 1;
>  	}
>  out:
> @@ -1325,7 +1325,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>  		if (err)
>  			break;
>  	} while (rq->vq->num_free);
> -	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
> +	if (virtqueue_kick_try(rq->vq)) {
>  		unsigned long flags;
>  
>  		flags = u64_stats_update_begin_irqsave(&rq->stats.syncp);
> @@ -1533,7 +1533,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  
>  	if (xdp_xmit & VIRTIO_XDP_TX) {
>  		sq = virtnet_xdp_get_sq(vi);
> -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> +		if (virtqueue_kick_try(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			sq->stats.kicks++;
>  			u64_stats_update_end(&sq->stats.syncp);
> @@ -1710,7 +1710,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	if (kick || netif_xmit_stopped(txq)) {
> -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> +		if (virtqueue_kick_try(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			sq->stats.kicks++;
>  			u64_stats_update_end(&sq->stats.syncp);
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..1462be756875 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1874,6 +1874,26 @@ bool virtqueue_kick(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick);
>  
> +/**
> + * virtqueue_kick_try - try update after add_buf
> + * @vq: the struct virtqueue
> + *
> + * After one or more virtqueue_add_* calls, invoke this to kick
> + * the other side.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns true if kick success, otherwise false.

so what is the difference between this and virtqueue_kick
which says

 * Returns false if kick failed, otherwise true.







> + */
> +bool virtqueue_kick_try(struct virtqueue *vq)
> +{
> +	if (virtqueue_kick_prepare(vq) && virtqueue_notify(vq))
> +		return true;
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick_try);
> +
>  /**
>   * virtqueue_get_buf - get the next used buffer
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..45cd6a0af24d 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -59,6 +59,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>  
>  bool virtqueue_kick(struct virtqueue *vq);
>  
> +bool virtqueue_kick_try(struct virtqueue *vq);
> +
>  bool virtqueue_kick_prepare(struct virtqueue *vq);
>  
>  bool virtqueue_notify(struct virtqueue *vq);
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
