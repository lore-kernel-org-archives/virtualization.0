Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECED5C433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2953428E6;
	Fri, 27 May 2022 10:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csEw9KVUwuUI; Fri, 27 May 2022 10:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEADC428D7;
	Fri, 27 May 2022 10:25:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE7FC0032;
	Fri, 27 May 2022 10:25:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9943EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 810A561652
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vj6FRTNaAUhL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA0E361649
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653647107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuZAGr8LTLPKnTTHGsBiC03ZUbAgIARZMp0A9eFeOjI=;
 b=aJW6UrrP/Hxe2NHPprRzd5QuBWNzz0Eg3GL8UfwAZO77FNckC7eb4WtxzzCRAViIx9yynS
 7psCNyRDohYzR4vBzyW3NSLDhqqvl6LNk2bfVCocw6GvvaWzCXkN4oIbhzMSXOMb+R07gw
 g0MQbAQhJGnwtZtu2X2NGUBqiw8v6Zs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Q2ciu2-QMQOFpU7191jiwA-1; Fri, 27 May 2022 06:24:51 -0400
X-MC-Unique: Q2ciu2-QMQOFpU7191jiwA-1
Received: by mail-ed1-f72.google.com with SMTP id
 l17-20020a056402029100b0042bcb0c15e4so2791949edv.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RuZAGr8LTLPKnTTHGsBiC03ZUbAgIARZMp0A9eFeOjI=;
 b=5L+PXINnv0R302l6powUl6gOEZqwwUfYM7ghdvLmJipsE8cC6wB0MH1aoCd7UBPsan
 FdCj4+8raCA4TYbRd+EoofgMZkxBs++t6Qn/vd18vwVJgtg1Qm2R99klf28t0FyJGUiG
 mitWnk9vrZVSx5558CxK2HSxN7hk7hkVpC81lffgnAkooX4EkZmor4EHZhUBRZ6bYEF/
 oILgNpCzSprgYAAENblN0iUXA/Qq5yfOAuA5o5Uk3qAIZIo11LnzdOveRA9S4929z4PD
 Vc8sXEBYORgET7f3xa9jh85JK8piKOFBp1tSIx8j3h/2Y5Yv49I4sCoSWTJWuxJzpAAw
 IS7A==
X-Gm-Message-State: AOAM531ocM3fzU3ooxwBJwqjyDLp5AprUVND8FzHcju/0v7GlbBldxB0
 UgJEKkMCC5Yf0RBmUVfiUZmrgrLyqEmTOtT0lOf0bcVG9zLMZR4lGflmdlMCBahiIhHJYx7Gc2I
 aNcL6zNTtOpdSaGU+Sjtm5t/AF41+ILz4nqPuaCfEIQ==
X-Received: by 2002:a17:907:3e25:b0:6fe:fd4a:5b5e with SMTP id
 hp37-20020a1709073e2500b006fefd4a5b5emr18454139ejc.280.1653647090565; 
 Fri, 27 May 2022 03:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJjM8P8YDg2O9DcJdsHXxNVHJ5AXZbqaTJsUQOXz6/iICApS8FSDyg1JXujhJcyMt6rzYLbg==
X-Received: by 2002:a17:907:3e25:b0:6fe:fd4a:5b5e with SMTP id
 hp37-20020a1709073e2500b006fefd4a5b5emr18454129ejc.280.1653647090340; 
 Fri, 27 May 2022 03:24:50 -0700 (PDT)
Received: from redhat.com ([2.55.130.213]) by smtp.gmail.com with ESMTPSA id
 e13-20020a50a68d000000b0042ab4e20543sm1908597edc.48.2022.05.27.03.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:24:49 -0700 (PDT)
Date: Fri, 27 May 2022 06:24:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Message-ID: <20220527062346-mutt-send-email-mst@kernel.org>
References: <20220527013401.2196-1-liubo03@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220527013401.2196-1-liubo03@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Thu, May 26, 2022 at 09:34:01PM -0400, Bo Liu wrote:
> virtqueue_add_outbuf() can fail, when it fails, there is no need
> to call the funciont virtqueue_kick().
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Sorry don't get it.
What's the point of this patch really?

> ---
>  drivers/virtio/virtio_balloon.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..0d7da4d95e1e 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -153,16 +153,18 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  {
>  	struct scatterlist sg;
>  	unsigned int len;
> +	int err;
>  
>  	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
>  
>  	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> -
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err) {
> +		virtqueue_kick(vq);
>  
> +		/* When host has read buffer, this completes via balloon_ack */
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +	}
>  }
>  
>  static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> @@ -382,6 +384,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
>  	struct virtqueue *vq;
>  	struct scatterlist sg;
>  	unsigned int len, num_stats;
> +	int err;
>  
>  	num_stats = update_balloon_stats(vb);
>  
> @@ -389,8 +392,9 @@ static void stats_handle_request(struct virtio_balloon *vb)
>  	if (!virtqueue_get_buf(vq, &len))
>  		return;
>  	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> +	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> +	if (!err)
> +		virtqueue_kick(vq);
>  }
>  
>  static inline s64 towards_target(struct virtio_balloon *vb)
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
