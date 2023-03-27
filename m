Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCE2C7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 12:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04D298131A;
	Mon, 27 Mar 2023 12:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04D298131A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G8phJLBK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bq8clev7Fbow; Mon, 27 Mar 2023 12:43:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 358E480DA5;
	Mon, 27 Mar 2023 12:43:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 358E480DA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AAE0C0035;
	Mon, 27 Mar 2023 12:43:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB92D40B34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB92D40B34
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G8phJLBK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9mm25rHlWgF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:43:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1DE440B20
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1DE440B20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679921013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okew6DGjoVJwf2XramfWu6hiLwNPjgMAsie77LgA37k=;
 b=G8phJLBKC2DZq9v/hM8HFFkXodiEz4v9bWzTJ/ftNjFKmvXN2qPElUWpIFyQ0MrptenbON
 qFO7xarvxVLEJ2lNvkogPkm1OQFGRLQNJzHkEeR7w3GzoCORnL8Iz4QkhVdzSbTBUzG++B
 hafhTDD+rQQ1B6yAXtLOYjYjj5LC6s0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-GOymg6yaNLi71_Zhqi8rig-1; Mon, 27 Mar 2023 08:43:32 -0400
X-MC-Unique: GOymg6yaNLi71_Zhqi8rig-1
Received: by mail-wm1-f69.google.com with SMTP id
 o7-20020a05600c4fc700b003edf85f6bb1so5679420wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 05:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679921011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okew6DGjoVJwf2XramfWu6hiLwNPjgMAsie77LgA37k=;
 b=KvNkwB39rqe5n3TS9PrEw78/HyjRdzqqCG+28vLllEi3VODr9TZV8qBEvHXy/k4RSs
 nlCWyOEXmVMHBhtVOfckH4aAj9QJtt2QDOCmTV37Z3fIB/K6btanG5p/uFN7qE6CMull
 bHEem4rsW/KE8j+6Ivnj39ui3lakPLKnOx3SPxCoxAQ49Fb0lZrtloDejJLCZ6TQmqub
 yGCXtgAovEOkmIctcfSN+oMP7coMGzSQwhpWMQOlwEJfHHJpuHy/5/9kAKt7ASwuvVEJ
 bhyJO9TjAJxq8M/A/LO3niH6Oz3RJOtREUSUjiyygwwvz+yD/K7sOAMDHo9wnK1E8f1+
 gb5Q==
X-Gm-Message-State: AAQBX9etsHXJRHfJ+3Zlu9qlAX/1ucX/75XQGQ7rcZ4BrY3KxmHsTB6q
 7g7JIuReLQ2pDjNz5v/o+h68pU/JuvhChBMgATYC1r58tgS7a4XtLbgZG23TtNAXrmvShJ9eQzn
 6EbJgIWfulu36AuDOP5e7AbRMRnmQkaWw6wjkL3scmw==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id
 u5-20020a7bc045000000b003ef6fee8057mr1516952wmc.25.1679921011575; 
 Mon, 27 Mar 2023 05:43:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8/SyqswJ4jRTerw8oSEMPhEZEW1SwIMQQ5198eUS5XRuV+yjc/mQikzsTZrLWNyeSaRuqQQ==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id
 u5-20020a7bc045000000b003ef6fee8057mr1516940wmc.25.1679921011227; 
 Mon, 27 Mar 2023 05:43:31 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c384b00b003edf2ae2432sm8703889wmr.7.2023.03.27.05.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 05:43:30 -0700 (PDT)
Date: Mon, 27 Mar 2023 08:43:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH v2] virtio_ring: don't update event idx on get_buf
Message-ID: <20230327084248-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

is the below same as what I posted or different? how?

On Sat, Mar 25, 2023 at 06:56:33PM +0800, Albert Huang wrote:
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix, if event_triggered is set to true, do not update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>

what is this exactly?

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..1c36fa477966 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
> -- 
> 2.37.0 (Apple Git-136)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
