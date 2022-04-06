Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CD7C433FE
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 11:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B87460A88;
	Wed,  6 Apr 2022 11:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CZ7gkh81SVr; Wed,  6 Apr 2022 11:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF3FD60784;
	Wed,  6 Apr 2022 11:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84C1EC001D;
	Wed,  6 Apr 2022 11:53:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26543C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 070DA81287
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id miCD1t9_1vEp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:53:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C21A81281
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649246021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kB1T+ZnqR2/L037KmDjJiiYzrhgcu2TNRn7h+cl2h1Q=;
 b=Mz4YwCC3bIN/x2mDJsJv2dux1VXMw/cj3YThnG+0qjtydeLa8CPq6ZlWy8N7vHBxBED9MZ
 Zi1fHP/bviJsv/n2m9mN7yZ4R+rdtxFe4qsjGaF/M1E3zcBRU6ifXwwOpeVqj0A4BZL5Gu
 V00zX4BSAcne+AYzO6LFipUYN0ZN7Q8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-znS0233AMXyvVtBDWP2rxg-1; Wed, 06 Apr 2022 07:53:40 -0400
X-MC-Unique: znS0233AMXyvVtBDWP2rxg-1
Received: by mail-wr1-f69.google.com with SMTP id
 p18-20020adfba92000000b001e8f7697cc7so412400wrg.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 04:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kB1T+ZnqR2/L037KmDjJiiYzrhgcu2TNRn7h+cl2h1Q=;
 b=UNfC5tdLe9RrtHqD1slizWtlUfsRrBqv2w399PRxv8+A5JI3YsLrRf0LLm5WamxVfT
 Rubf2Clb+9yFcC7cl9p4n6lBetobmQy/EaKKjfprc93WfQAoa76uerjX7BcbIyubaMyR
 3MceuAs4+JlKeiD6n7W5CZaE7AHAOS8ZeC9t6GeEL21XAwAWrB9NSTFEdyqK4Ihzj/5B
 O2F7pqC0sIVgESuhl1n8BWh+4BNotNMhR/pnrz5WKmII0BSQPhtTQoLypIsCwhKBJPkc
 S58aYLOSznEEtXgqDYGSfxa9P5DRzrsmhKAdulCtMVHN+mi2ULNPPesBjGMz7LbIMOiO
 oXvA==
X-Gm-Message-State: AOAM5337oa2i4h7KX6vsPaKQt3gq4TL0dg5kkj5SzNl6zUZ4sqVZwz+m
 rrUlcAnxy1GCR5INbVazZgEWeZSMZW6VJKVdKMZ8R7SihsdbjqDae29OYxgnaNSGQ1nuV72r9Gr
 JXCkGa3M63WMwV2LvXWSZlS4TfhG7o42OQrk3mGfmPg==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id
 u8-20020adfeb48000000b00203f85486ccmr6312037wrn.102.1649246019001; 
 Wed, 06 Apr 2022 04:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2+5QZG87zHPtKHombCPhUvvOUvDWdcIY4nG1TjUzIlk1J6N8DJq0jnyTF+14SRheRL60Wcw==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id
 u8-20020adfeb48000000b00203f85486ccmr6312018wrn.102.1649246018821; 
 Wed, 06 Apr 2022 04:53:38 -0700 (PDT)
Received: from redhat.com ([2.55.138.162]) by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c35c400b0038cbd8c41e9sm4594698wmq.12.2022.04.06.04.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 04:53:38 -0700 (PDT)
Date: Wed, 6 Apr 2022 07:53:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 2/5] virtio: use virtio_reset_device() when possible
Message-ID: <20220406074440-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 04:35:35PM +0800, Jason Wang wrote:
> This allows us to do common extension without duplicating codes.

codes -> code

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75c8d560bbd3..8dde44ea044a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
> -	dev->config->reset(dev);
> +	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> @@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
>  
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
> -	dev->config->reset(dev);
> +	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
