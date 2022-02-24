Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF14C4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 17:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D43D4012E;
	Thu, 24 Feb 2022 17:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqVFoH9Xksuz; Thu, 24 Feb 2022 17:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AC00400E0;
	Thu, 24 Feb 2022 17:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3878EC0021;
	Thu, 24 Feb 2022 17:56:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B78DC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55D7F4163E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpuYdG6xjz0X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D8344162F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645725356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyZ+8mwH7A7IyXyP8sy2oOYKxL6VPV73PTdkRXEFeIw=;
 b=MX4R9q2wzjzws8tux1M6ilcba2dKm3rlcHYJeVp7cK2NH07MskjFd9Gi4RIu3RKLVLaAlU
 F9R7RmNSbWMpJwqhdisayaE1aVsJaWpEs3jM8zQtzMbJq9gxJQGN3fE3PTP5qJ7pIuzN+v
 i8reQblmmaZYMR2IHhTwpl8GF/nP5sM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460--NWXCEnCMf6MlgxD2qd8pQ-1; Thu, 24 Feb 2022 12:55:55 -0500
X-MC-Unique: -NWXCEnCMf6MlgxD2qd8pQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 u9-20020adfae49000000b001e89793bcb0so198556wrd.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 09:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xyZ+8mwH7A7IyXyP8sy2oOYKxL6VPV73PTdkRXEFeIw=;
 b=TQF1GxXaUNwSehyJAMvOT8EpiXIPCj2W6TGN0J4rqJ+emmZqDBeOQ1J9ctpxW7xOPF
 6RMN8BjKEfHY9W4wkD0gUwNOXvhNeaoZyx8BBJ0WVn8P1D4B0xmNpVBmIspGC2FdpIN2
 gheGx8cR0XFPuBQRMc/42frkXxUhm2/G4m/guCbMjhUQ7gm39XRebPsfP5TqLvT6sZK4
 aYShpKLfjiNWKOeP+wTIk8sPjsM4+vWOIqOziUAwpgEmis6D1J1U1vG6hcjApsDRrS7U
 MDbT6A62gHOYe95MYRBKPZ5XUed0yMpDz9Tco4bd3KHQMvft6o4Ko3uZ+WSClxYJOxLx
 lMlQ==
X-Gm-Message-State: AOAM530NsTCTyM6Kjyd5+tc1c0XXcn5/PtkE+zuD9T6ztRjUy4aYdPBd
 zW/w6ySlz9oO6EGNfW7WEzMYnwMSs+r8dE6LTWbUWa8+88CoqyS9nELS3/sRNRenpZlImqEgTz1
 7XvTO3imXfgZmvVp6UsyaeIva2uFrkT6DG1FfN3n55Q==
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id
 f13-20020a05600c4e8d00b0037c4e20baa6mr3332963wmq.19.1645725353272; 
 Thu, 24 Feb 2022 09:55:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPIbEkonNCeTz8FUscHAS8oihHXjPH9/S9rkSQ1S5nl9l6gCfI9+XK+q8zBFoGHuqRfK+4Tg==
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id
 f13-20020a05600c4e8d00b0037c4e20baa6mr3332937wmq.19.1645725352901; 
 Thu, 24 Feb 2022 09:55:52 -0800 (PST)
Received: from redhat.com ([2.55.145.157]) by smtp.gmail.com with ESMTPSA id
 q7-20020adfcd87000000b001e8a4f58a8csm15343wrj.66.2022.02.24.09.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 09:55:52 -0800 (PST)
Date: Thu, 24 Feb 2022 12:55:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220224122655-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211108081324.14204-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

Typo in the subject btw.

minor tweaks to commit log below

On Mon, Nov 08, 2021 at 04:13:24PM +0800, Jason Wang wrote:
> Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> for split virtqueue") tries to make it possible for the driver to not
> read from the descriptor ring to prevent the device from corrupting
> the descriptor ring. But it still read 

reads

>the descriptor flag from the
> descriptor ring during buffer detach.
> 
> This patch fixes 

fixes this

>by always store 

storing

>the descriptor flag no matter whether
> DMA API is used and then we can avoid reading descriptor flag from the
> descriptor ring. This eliminates the possibly of unexpected next
> descriptor caused by the wrong flag (e.g the next flag).
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


I'd also like the commit log to document what the issue is in a bit more depth.
I think the main reason we are checking the dma API is this


static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
                                          unsigned int i)
{
        struct vring_desc_extra *extra = vq->split.desc_extra;
        u16 flags;

        if (!vq->use_dma_api)
                goto out;

	...
}


so I guess with a bad flag, what will happen is num_free will become too
big is that right?




> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00f64f2f8b72..28734f4e57d3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	}
>  	/* Last one doesn't continue. */
>  	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vq->use_dma_api)
> +	if (!indirect)
>  		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>  			~VRING_DESC_F_NEXT;
>  

BTW I'm a bit confused why we need the & (vq->split.vring.num - 1) logic.
Maybe it's time we stopped writing out descriptor then overwriting it -
e.g. return the desc_extra pointer from virtqueue_add_desc_split
instead of an index. Worth checking what this does to performance.


> @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>  
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (vq->split.desc_extra[i].flags & nextflag) {
>  		vring_unmap_one_split(vq, i);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
