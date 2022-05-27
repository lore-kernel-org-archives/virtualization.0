Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E3DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A35EB41343;
	Fri, 27 May 2022 10:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-UFPR3wn8Cu; Fri, 27 May 2022 10:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B5DE4133F;
	Fri, 27 May 2022 10:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E9E9C0032;
	Fri, 27 May 2022 10:26:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15DD1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FA76165D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kq-rLVSZnCbM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4703861649
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653647171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDuT9p5IVFO/EJoQkNQnFZKYnxf8PK4RwYvLobWGchc=;
 b=NuDihs+kGZqPL3ecVyi5qZq/7smTCEpfOVQ2nzj0YUAtAZilanuOW2xBOJLwz1FYBwnGDT
 eePdHP44QaUw3zxtzW8DRc8L0rXGxXoRji8exsBcITfSwBxvhwHfGtmDv2R4+wYWMJ5v7q
 6BxFdX8jyHw5cI+0VeIW4ot8FBf/tZ8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-y2kzK9bAM4ScSlDucd8GWQ-1; Fri, 27 May 2022 06:26:08 -0400
X-MC-Unique: y2kzK9bAM4ScSlDucd8GWQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 x23-20020aa7dad7000000b0042be38e5095so1778150eds.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VDuT9p5IVFO/EJoQkNQnFZKYnxf8PK4RwYvLobWGchc=;
 b=TtL/8hpkTmhE/FhPaBQrNaMwlX5kaE0g2TJHhVULV1FNG24KUSUgXzWohaNCPY9wWp
 KiIdMwBe9zb+UGRrpnQSIGUxcfdJ0G4z/GgyqX9+FkMTchy27NChxcf5XC9bCGcd54S0
 BV8cdXwnKiTURL34udNCtOmtLp1ttGMgHSCQju5o47J07y9t2Ib1s8eMBGCi24Xq9pRr
 U1BCZjCia7ea9guf25EIcWcVIrJ0QShQriVAr0DYZ7eKYVDY4jpYYerhEGapNWC060h1
 88WhnrNbI3DFwXOcsK0PU/TdP2rQZ9Wqq6+8aG875/Tk2A+AkEgHFy0Ivm7RvqhZmCir
 Bs0Q==
X-Gm-Message-State: AOAM531Z0orkqh2mS8yMmy5I8WScaQd7y36mk8rgSZWN4MVBIk6NN7Ai
 1jLXSsATaP2pyORsN2rkPZTgIp7m7+dLKbFQSjHe9sp44IsuyY3AkE4flmPtYGcKis4y1tKu7by
 VuzWO+BbuJvnJs/8jodiTkt/DD7jifYNozmKnvGKTfw==
X-Received: by 2002:a17:907:8a01:b0:6ff:3eab:9dfa with SMTP id
 sc1-20020a1709078a0100b006ff3eab9dfamr1366876ejc.467.1653647166570; 
 Fri, 27 May 2022 03:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9zkt6pxv2eemrcADCJv6daaUMF9g2JEKNpj/qII2hYbZ7VhwCc2ToG0nrfb37bYAX4O8kXQ==
X-Received: by 2002:a17:907:8a01:b0:6ff:3eab:9dfa with SMTP id
 sc1-20020a1709078a0100b006ff3eab9dfamr1366866ejc.467.1653647166363; 
 Fri, 27 May 2022 03:26:06 -0700 (PDT)
Received: from redhat.com ([2.55.130.213]) by smtp.gmail.com with ESMTPSA id
 p19-20020a50cd93000000b0042617ba63besm1915464edi.72.2022.05.27.03.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:26:05 -0700 (PDT)
Date: Fri, 27 May 2022 06:26:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: keliu <liuke94@huawei.com>
Subject: Re: [PATCH] virtio: Directly use ida_alloc()/free()
Message-ID: <20220527062533-mutt-send-email-mst@kernel.org>
References: <20220527073302.2474073-1-liuke94@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220527073302.2474073-1-liuke94@huawei.com>
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

On Fri, May 27, 2022 at 07:33:02AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Please Cc people that commented on the original patch. thanks!

> ---
>  drivers/virtio/virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..143f94652306 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -413,7 +413,7 @@ int register_virtio_device(struct virtio_device *dev)
>  	device_initialize(&dev->dev);
>  
>  	/* Assign a unique device index and hence name. */
> -	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
> +	err = ida_alloc(&virtio_index_ida, GFP_KERNEL);
>  	if (err < 0)
>  		goto out;
>  
> @@ -451,7 +451,7 @@ int register_virtio_device(struct virtio_device *dev)
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
>  out_ida_remove:
> -	ida_simple_remove(&virtio_index_ida, dev->index);
> +	ida_free(&virtio_index_ida, dev->index);
>  out:
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
> @@ -469,7 +469,7 @@ void unregister_virtio_device(struct virtio_device *dev)
>  	int index = dev->index; /* save for after device release */
>  
>  	device_unregister(&dev->dev);
> -	ida_simple_remove(&virtio_index_ida, index);
> +	ida_free(&virtio_index_ida, index);
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_device);
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
