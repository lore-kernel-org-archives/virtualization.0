Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF75C6FA99
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 17:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BA0F81065;
	Mon,  6 Mar 2023 17:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BA0F81065
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ONaE+9y6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ms0W-3u3k0NI; Mon,  6 Mar 2023 17:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC77680E66;
	Mon,  6 Mar 2023 17:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC77680E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0789C0035;
	Mon,  6 Mar 2023 17:57:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0243CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE26D4061C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE26D4061C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ONaE+9y6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWGK1GiamA0N
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:57:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 660DE40022
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 660DE40022
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678125461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I738/18sbvHmC2+417kvwhaipDQYnMqOKuRA/kftVmQ=;
 b=ONaE+9y6Iy+92FCfskKsIlOYobDzexRUsPTT9Efe6LJ2AVkKNXSuokdw+tnenuZX4W1uET
 Zf/3FduE0O4wen80y4RQwlxu/6iTxF/Rjv7dx/AuUx7ewE9to3U91nmNnMdKvmyq7tKmXn
 QRkScuR/D9uRZqo9lOvjTil+U/N2ZbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-r8KqbDxxMEWskUO9tnSrHQ-1; Mon, 06 Mar 2023 12:57:40 -0500
X-MC-Unique: r8KqbDxxMEWskUO9tnSrHQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 e17-20020a05600c219100b003e21fa60ec1so4060645wme.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 09:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678125459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I738/18sbvHmC2+417kvwhaipDQYnMqOKuRA/kftVmQ=;
 b=dFgJVGk/n72Mr654KQ3qZ5dY5jXJdxBPZUeTa7S8tk1L1qQyzRgzHyWW8kApDZrLqI
 Q5QTGXTg/wzrQsehXsWQKiiLo4Jj+5GAhZIAmhBq7bvJMXNKq2TXmA3GNy65zMReRpBE
 W65Ygy4CcDPt4EzcWj/ADofy5uQnvpfYV69vxtVzKceErCSVw/Vzy6TiqUsVhkT12z2Z
 zNxMsom+u8IX+PjpGbcRKX799kzuwY1QLWfm7A3aOE2pipnkUnzoRacZtJsVTL0PEwx3
 fKH2c19ybSXcom3nms/JTOT+h+l0Qdv4QMgm9dWrBqaSFCMO4syfzAuNbqsQIEjfnWxf
 AICw==
X-Gm-Message-State: AO0yUKVY6gV5suYUuTVZVzRKC3clBDvPUN7HBY7/VIw3SkghANW3i/me
 FLnc+EwqPO7t3wrxr3zi1L1eUKdkevaT1TfZ+TUhNMLo5OmfubiO+yCbf6t0FqVhKZpgwqedSjz
 /bjZN3x0G+oZJD6EqU0CeDbYAobQ3wCoxwx10oc7XpA==
X-Received: by 2002:a05:600c:4f53:b0:3ea:dbdd:b59c with SMTP id
 m19-20020a05600c4f5300b003eadbddb59cmr10192599wmq.15.1678125458891; 
 Mon, 06 Mar 2023 09:57:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/7vZlQ5uxUx+GGtLM0+if0KbUiPqDYTkq6I2qARMVnh5tT0y/ZRu7nd7JUJRS0jmoNHNwt9Q==
X-Received: by 2002:a05:600c:4f53:b0:3ea:dbdd:b59c with SMTP id
 m19-20020a05600c4f5300b003eadbddb59cmr10192578wmq.15.1678125458554; 
 Mon, 06 Mar 2023 09:57:38 -0800 (PST)
Received: from redhat.com ([2.52.23.160]) by smtp.gmail.com with ESMTPSA id
 l5-20020a05600c16c500b003e20fa01a86sm10602188wmn.13.2023.03.06.09.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 09:57:38 -0800 (PST)
Date: Mon, 6 Mar 2023 12:57:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio_net: add checking sq is full inside xdp
 xmit
Message-ID: <20230306125344-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Mar 06, 2023 at 12:15:35PM +0800, Xuan Zhuo wrote:
> If the queue of xdp xmit is not an independent queue, then when the xdp
> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> the following error.
> 
> net ens4: Unexpected TXQ (0) queue failure: -28
> 
> This patch adds a check whether sq is full in XDP Xmit.
> 
> Reported-by: Yichun Zhang <yichun@openresty.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 777de0ec0b1b..3001b9a548e5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -302,6 +302,8 @@ struct padded_vnet_hdr {
>  
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
> +			  struct send_queue *sq);
>  
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -341,6 +343,16 @@ static int rxq2vq(int rxq)
>  	return rxq * 2;
>  }
>  

I'd really rather we ordered functions reasonably so declarations
are not needed.

> +static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> +{
> +	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> +		return false;
> +	else if (q < vi->curr_queue_pairs)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
>  {
>  	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> @@ -686,6 +698,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  	ret = nxmit;
>  
> +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> +		check_sq_full(vi, dev, sq);
> +
>  	if (flags & XDP_XMIT_FLUSH) {
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
>  			kicks = 1;
> @@ -1784,16 +1799,6 @@ static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
>  	}
>  }
>  
> -static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> -{
> -	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> -		return false;
> -	else if (q < vi->curr_queue_pairs)
> -		return true;
> -	else
> -		return false;
> -}
> -
>  static void virtnet_poll_cleantx(struct receive_queue *rq)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
