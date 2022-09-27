Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7481C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 20:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 377A381464;
	Tue, 27 Sep 2022 20:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 377A381464
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcVQ8iah
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PoK8twufH0dZ; Tue, 27 Sep 2022 20:30:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE7EA8135F;
	Tue, 27 Sep 2022 20:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE7EA8135F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72439C0033;
	Tue, 27 Sep 2022 20:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3A3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16D954013D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16D954013D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcVQ8iah
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NnJmRyxXn7iO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:30:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47914400DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47914400DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664310609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ONZGrKrq1sS5sx+hAdgkduCJ7jSA1Bg21aVIwPpM/M=;
 b=AcVQ8iahK/5Px59SjUeGIsveh/tEZTGni0prh3HTqIPW5P/EdIeGH1c9MullHunax5np6/
 /jZtL1dlJ+W5y0q1LkWeWZBtL6dtSw/tFTuLZdPi9G8AK/3oWIX5YsAAL3O5WByVbUfHj4
 K6QDyFDjCRLBFbidLRt+hCTmq9nqelo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-pB1-ZCe7PFWpQTA_jUiAoQ-1; Tue, 27 Sep 2022 16:30:07 -0400
X-MC-Unique: pB1-ZCe7PFWpQTA_jUiAoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 g8-20020a05600c4ec800b003b4bcbdb63cso6036789wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=3ONZGrKrq1sS5sx+hAdgkduCJ7jSA1Bg21aVIwPpM/M=;
 b=1b7rRtt7a/qkU/xLuFio3/9BAgm42VdK4IeTItG2gaGtymWsxLz9kSYYKAaQfUTNa3
 dJk+bhz3GgdO+pA9alGCn6ZjakAPTpOBeOVshmLnB9c/fCGcdQyKRaf1Rdrq4N+spYWR
 rrVO8Ffk0dvmpAgbHGzra41+1u0cTsVE33rRZxtse2Cprt8BSREuegFhNSi63utcYrNs
 MVtF49inLu5JYdezddLRngJ2IW04f4WryyELL8ByVLBpMCTyFhWSlkNQk8Tpos954Z7a
 Fw5YoDgKXP17sb2/9lo2HRJdcCDola652ehQJoF4nimEPJkCZZsTFwAaBQ7jQ1VaOhhY
 XOZQ==
X-Gm-Message-State: ACrzQf0xMWxZbgCQ4GcYtxPfsfcfbnENPTPGOUU8/l2j0uGQjr0AT7qk
 HZqItBH3tlZ1ZBsODR0OOLYu1w6l4rFtePmA5i7JD8LNtEUp7wHS0MrTsd3NqDUTpmWAX6edzHn
 dJB5zVnGnr7+fUkun3g9xlOS/e0Cdxh95WpHgm8yZBw==
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id
 j3-20020adff543000000b00228c692127amr18847103wrp.246.1664310606561; 
 Tue, 27 Sep 2022 13:30:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM549zwnW5nDlpn3BeNyNzKinHd2eWShJ3HLCvV+21vbyOBZA6EZF6qJ/GBWosJuGDJpvq7SCQ==
X-Received: by 2002:adf:f543:0:b0:228:c692:127a with SMTP id
 j3-20020adff543000000b00228c692127amr18847092wrp.246.1664310606357; 
 Tue, 27 Sep 2022 13:30:06 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 iw5-20020a05600c54c500b003b5054c6f87sm2612262wmb.21.2022.09.27.13.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 13:30:05 -0700 (PDT)
Date: Tue, 27 Sep 2022 16:30:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
Message-ID: <20220927162745-mutt-send-email-mst@kernel.org>
References: <20220926091130.9244-1-liubo03@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220926091130.9244-1-liubo03@inspur.com>
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

On Mon, Sep 26, 2022 at 05:11:30AM -0400, Bo Liu wrote:
> It passes '_vq' to vring_free(), which still calls to_vvq()
> to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq() in hot path.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

What is the point of this change?

__vring_new_virtqueue returns struct virtqueue *, so vring_free
matches that. No?

> ---
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..d6d77bf58802 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -221,7 +221,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					       void (*callback)(struct virtqueue *),
>  					       const char *name);
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> -static void vring_free(struct virtqueue *_vq);
> +static void vring_free(struct vring_virtqueue *vq);
>  
>  /*
>   * Helpers.
> @@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  	if (err)
>  		goto err_state_extra;
>  
> -	vring_free(&vq->vq);
> +	vring_free(vq);
>  
>  	virtqueue_vring_init_split(&vring_split, vq);
>  
> @@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>  	if (err)
>  		goto err_state_extra;
>  
> -	vring_free(&vq->vq);
> +	vring_free(vq);
>  
>  	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
>  
> @@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>  
> -static void vring_free(struct virtqueue *_vq)
> +static void vring_free(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->we_own_ring) {
>  		if (vq->packed_ring) {
>  			vring_free_queue(vq->vq.vdev,
> @@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  	list_del(&_vq->list);
>  	spin_unlock(&vq->vq.vdev->vqs_list_lock);
>  
> -	vring_free(_vq);
> +	vring_free(vq);
>  
>  	kfree(vq);
>  }
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
