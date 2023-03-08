Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC97EC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 12:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31D7160C03;
	Wed,  8 Mar 2023 12:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31D7160C03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNXslAKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3CL2kYywy_Ln; Wed,  8 Mar 2023 12:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DC0C607A1;
	Wed,  8 Mar 2023 12:21:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DC0C607A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C176C0071;
	Wed,  8 Mar 2023 12:21:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23102C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 12:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAA7F417CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 12:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAA7F417CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNXslAKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rlicJk5FjiE4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 12:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73532417CF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73532417CF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678278074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYUSGl+c2i/XrGfwxUOIC1FfAmTL8/NIk2jsBnOFyek=;
 b=dNXslAKaVVzoJaoP6flqaB/MeRyrz4fIAyVMB9vj+Yr96c67tZv4yno51oV8/5wBeKYBcd
 6N+HwcgyvGnWP/oKoUykoRYkeuxg0G67PAAh6soIBTajTqODsuokgzQHtt3hGOn5Y/zdwE
 SyhMH+w52z+tXSv+5BrcSqWmByTevcc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-uWS8jdfBObi1xixK-nbpJg-1; Wed, 08 Mar 2023 07:21:13 -0500
X-MC-Unique: uWS8jdfBObi1xixK-nbpJg-1
Received: by mail-ed1-f72.google.com with SMTP id
 dn8-20020a05640222e800b004bd35dd76a9so23801874edb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 04:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678278072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYUSGl+c2i/XrGfwxUOIC1FfAmTL8/NIk2jsBnOFyek=;
 b=QoCL+hJgD2GUHA26ZNnnPAIz0cRV77/ZCULaamyvSR5N+4IVDCDHWCO/EZRZizZ1Pc
 eVtFNaRc5Vm8QrYe2GEJfwApqlJDjLf0uzBXFJ5XYm2Hcim5Wjxy915QNPclaz629wKH
 GQmeNYIFfuBQjdCQ9LV3bcP5FwOq4zEYQJnMM8xnN30jhEuRtTp9SJniuFnu0NGhRzOA
 5fO1dK/5A12RnAUGFw4Ck60Ul8ZJnCzyCRD1WuOgZDI6iL2Nzxc7hSJptOePQT3bH+Wu
 YZ4UEERf4kZEW5/Dg9u+2//XUfSQ8RS9W0csT1+GuBkQR2dKvi3DuFG8+sv70BnpJLGP
 zLxQ==
X-Gm-Message-State: AO0yUKUfj6o7Z8oCI9CZ089fYapqFcPagYXgBUXDCxdS10UdSxSgrxhn
 ak31RnQdLpJmretN4MSwzLZN6hnd2euDMdiTQpVcX/32Ga2vHgSa0u+YUDhTgiAIv1zY1suh9x4
 LJQfFctGHT2LJxXO0WKd3eUV7FkRLDWOZ3E5egLXdkQ==
X-Received: by 2002:aa7:d856:0:b0:4af:6e95:861b with SMTP id
 f22-20020aa7d856000000b004af6e95861bmr23390137eds.2.1678278072618; 
 Wed, 08 Mar 2023 04:21:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+6tZBfhWzjylNGTyxDwu7Yy+PpamZXGOVNIhYLZOhQ3DZ5QD/rfxx44WLOJiGYe6hsxp2zJQ==
X-Received: by 2002:aa7:d856:0:b0:4af:6e95:861b with SMTP id
 f22-20020aa7d856000000b004af6e95861bmr23390108eds.2.1678278072292; 
 Wed, 08 Mar 2023 04:21:12 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 r15-20020a50c00f000000b004bbc90e1fa3sm8087835edb.93.2023.03.08.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 04:21:11 -0800 (PST)
Date: Wed, 8 Mar 2023 07:21:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net, stable v1 3/3] virtio_net: add checking sq is full
 inside xdp xmit
Message-ID: <20230308071921-mutt-send-email-mst@kernel.org>
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-4-xuanzhuo@linux.alibaba.com>
 <7eea924e-5cc3-8584-af95-04587f303f8f@huawei.com>
 <1678259647.118581-1-xuanzhuo@linux.alibaba.com>
 <5a4564dc-af93-4305-49a4-5ca16d737bc3@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5a4564dc-af93-4305-49a4-5ca16d737bc3@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 08, 2023 at 04:13:12PM +0800, Yunsheng Lin wrote:
> On 2023/3/8 15:14, Xuan Zhuo wrote:
> > On Wed, 8 Mar 2023 14:59:36 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >> On 2023/3/8 10:49, Xuan Zhuo wrote:
> >>> If the queue of xdp xmit is not an independent queue, then when the xdp
> >>> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> >>> the following error.
> >>>
> >>> net ens4: Unexpected TXQ (0) queue failure: -28
> >>>
> >>> This patch adds a check whether sq is full in xdp xmit.
> >>>
> >>> Fixes: 56434a01b12e ("virtio_net: add XDP_TX support")
> >>> Reported-by: Yichun Zhang <yichun@openresty.com>
> >>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> >>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>  drivers/net/virtio_net.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>> index 46bbddaadb0d..1a309cfb4976 100644
> >>> --- a/drivers/net/virtio_net.c
> >>> +++ b/drivers/net/virtio_net.c
> >>> @@ -767,6 +767,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >>>  	}
> >>>  	ret = nxmit;
> >>>
> >>> +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> >>> +		check_sq_full_and_disable(vi, dev, sq);
> >>> +
> >>
> >> Sorry if I missed something obvious here.
> >>
> >> As the comment in start_xmit(), the current skb is added to the sq->vq, so
> >> NETDEV_TX_BUSY can not be returned.
> >>
> >> 	/* If running out of space, stop queue to avoid getting packets that we
> >> 	 * are then unable to transmit.
> >> 	 * An alternative would be to force queuing layer to requeue the skb by
> >> 	 * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not be
> >> 	 * returned in a normal path of operation: it means that driver is not
> >> 	 * maintaining the TX queue stop/start state properly, and causes
> >> 	 * the stack to do a non-trivial amount of useless work.
> >> 	 * Since most packets only take 1 or 2 ring slots, stopping the queue
> >> 	 * early means 16 slots are typically wasted.
> >> 	 */
> >>
> >> It there any reason not to check the sq->vq->num_free at the begin of start_xmit(),
> >> if the space is not enough for the current skb, TX queue is stopped and NETDEV_TX_BUSY
> >> is return to the stack to requeue the current skb.
> >>
> >> It seems it is the pattern that most network driver follow, and it seems we can avoid
> >> calling check_sq_full_and_disable() in this patch and not wasting 16 slots as mentioned
> >> in the comment above.
> >>
> > 
> > 
> > 
> >  * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
> >  *                               struct net_device *dev);
> >  *	Called when a packet needs to be transmitted.
> >  *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
> >  *	the queue before that can happen; it's for obsolete devices and weird
> >  *	corner cases, but the stack really does a non-trivial amount
> >  *	of useless work if you return NETDEV_TX_BUSY.
> >  *	Required; cannot be NULL.
> 
> Thanks for the pointer. It is intersting, it seems most driver is not flollowing
> the suggestion.

Yes - I don't know why.

> I found out why the above comment was added, but I am not sure I understand
> what does "non-trivial amount of useless work" means yet.
> https://lists.linuxfoundation.org/pipermail/virtualization/2015-April/029718.html

dev_requeue_skb 

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
