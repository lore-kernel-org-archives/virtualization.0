Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07778C4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 23:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A478060597;
	Mon, 26 Dec 2022 23:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A478060597
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FjUebgYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cUBPCdrXRl5; Mon, 26 Dec 2022 23:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EFFD60595;
	Mon, 26 Dec 2022 23:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EFFD60595
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA86AC0032;
	Mon, 26 Dec 2022 23:36:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29BB1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 105EC8138D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 105EC8138D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FjUebgYG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GzSC-b-ug8ln
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CF1381386
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CF1381386
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672097801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzpr44sA44tjoiP52UekyIu8PBOLrYR7TYiwR3W0WSA=;
 b=FjUebgYGQPzACUkZiz2adQAanYnJSTR1eLctA+wanzywaeJ8n7b9ElWrG6KyHN4BVvi6y8
 r5d9a9KwTUxPAIImxsIXwaxX/KuZpRmy90AJeAI/VItQ2ZDdZjFfp3bEu4UEcmnC10Aqw5
 sYAmqaCdCWs7nJDwtO3fLIwJqLyTz4w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-PyBZEmHzP3Gs30uWZtQj_A-1; Mon, 26 Dec 2022 18:36:40 -0500
X-MC-Unique: PyBZEmHzP3Gs30uWZtQj_A-1
Received: by mail-ej1-f70.google.com with SMTP id
 hd17-20020a170907969100b007c117851c81so8070722ejc.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 15:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzpr44sA44tjoiP52UekyIu8PBOLrYR7TYiwR3W0WSA=;
 b=C7tpEGQyfSH/BDRrThRFgDeTqi2MA7zOpiAe/fNNqlLrK3bsdz5RodRIzDFAckMX5d
 40lqnU+KStvxzvxIfYUfBBKgLEcn6Y01GhAFLBoT8ynm45vr6CHBTZLFBbpvSgXKwS3C
 uISmmOSIq8DUjZZ9ZOH25Y7jMs1gU7DNRc8pjjPXGEfxIAMLHoEYNjuPAqc+6x4NCXdv
 yganvnAoabuWExsRSRAQahBCTf0XSat1tJmAMK7chKiJ3zrclEP4iRL7P7xjsNBaoyOn
 CAQLxacriF66d5Is//fFIfkGnG7yrkLQH/4dnefast64zW2HqpH7DaJqw705z4u2XZCA
 w+6w==
X-Gm-Message-State: AFqh2kqyNcOre7MMe+gX+aeUr35zSVXldpW8TaF9bTtRmKfAovSRmZdp
 NT+b8wtjSvMUxNPU2PtATXUNsMh3VvuLKGkPkDAVPnWBB7pwI8ECYlLhANkh4fM7al96Unf0Bp1
 cvBGGtmjawchfHr/2kBIWI+Bf+KCuKn3ouS/ECghc6g==
X-Received: by 2002:a17:907:7676:b0:7c1:7183:2d32 with SMTP id
 kk22-20020a170907767600b007c171832d32mr18284271ejc.56.1672097799366; 
 Mon, 26 Dec 2022 15:36:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvQh+t/YUrOWufzLCFVyH7pjzJsK3vL527X56J/9SF731Dpz8d+d56ZwO0krnV4UliPaSZ5Q==
X-Received: by 2002:a17:907:7676:b0:7c1:7183:2d32 with SMTP id
 kk22-20020a170907767600b007c171832d32mr18284257ejc.56.1672097799188; 
 Mon, 26 Dec 2022 15:36:39 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 j18-20020a1709066dd200b0080345493023sm5296229ejt.167.2022.12.26.15.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 15:36:38 -0800 (PST)
Date: Mon, 26 Dec 2022 18:36:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
Message-ID: <20221226183604-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221226074908.8154-3-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Mon, Dec 26, 2022 at 03:49:06PM +0800, Jason Wang wrote:
> Switch to reuse BAD_RING() to allow common logic to be implemented in
> BAD_RING().
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - switch to use BAD_RING in virtio_break_device()
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..5cfb2fa8abee 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -58,7 +58,8 @@
>  	do {							\
>  		dev_err(&_vq->vq.vdev->dev,			\
>  			"%s:"fmt, (_vq)->vq.name, ##args);	\
> -		(_vq)->broken = true;				\
> +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \

I don't think WRITE_ONCE/READ_ONCE pair as such. Can you point
me at documentation of such pairing?

> +		WRITE_ONCE((_vq)->broken, true);		       \
>  	} while (0)
>  #define START_USE(vq)
>  #define END_USE(vq)
> @@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
>  
>  	/* Prod other side to tell it about changes. */
>  	if (!vq->notify(_vq)) {
> -		vq->broken = true;
> +		BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
>  		return false;
>  	}
>  	return true;
> @@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
>  	list_for_each_entry(_vq, &dev->vqs, list) {
>  		struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> -		WRITE_ONCE(vq->broken, true);
> +		BAD_RING(vq, "Device break vq %d", _vq->index);
>  	}
>  	spin_unlock(&dev->vqs_list_lock);
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
