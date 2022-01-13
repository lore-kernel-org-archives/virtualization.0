Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C53C433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 15:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6716860BCB;
	Thu, 13 Jan 2022 15:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fU2jsFff2DMV; Thu, 13 Jan 2022 15:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E926C60803;
	Thu, 13 Jan 2022 15:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDE9DC0030;
	Thu, 13 Jan 2022 15:19:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 115FDC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC6BD400CF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CAhffrTOnbnR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 891DA40022
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642087193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NnVmdo4eA3jgB9H6nwQxP3p+2r7UOf/6AXY2LS6emsY=;
 b=Ad3xZTmx5jZGtH4TTfEF52EHvcKw5GTQOtatkHmn8EtifvQa6HscYajx8FMzKNV+aJf8fx
 dzBcacccSq/qxzl6lQI+KHS1nbmTnVRWso9xzGZmKBZuuL1rQ+1yXCMMh7nQ95VxFvh8Zp
 Sw4ugVnc67Z7v1JC8DbmeTAgRyn5+Fg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-ypmz5GJ7PHaLQTjUCljkqA-1; Thu, 13 Jan 2022 10:19:52 -0500
X-MC-Unique: ypmz5GJ7PHaLQTjUCljkqA-1
Received: by mail-ed1-f72.google.com with SMTP id
 i9-20020a05640242c900b003fe97faab62so5611775edc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NnVmdo4eA3jgB9H6nwQxP3p+2r7UOf/6AXY2LS6emsY=;
 b=EvEqJdNTggrWdt2ZBFPXjH6vno3heoPByATYUhdvA7/JSM/ULnqHUJtC/o+4tmuu3/
 gHi5dr/j5enUVnt1JhW39YJQrsj+4xTL6WeBbI9cp52JiSs8dBcIrkzGHwTY4EKtnnJH
 1ebrvEOtFLMYYbxWzcDBLKaGA6OqBbjvGTBs59to0H7+zenMKvaVogN+anZKrPYjaY93
 OwYEAkjkp7IDLj3I+ACLCEN/BNNn8KtnosHIzs+fQVzL0yewnMtjGANUGAIwHMS18F/W
 UGl0bK+Avvri9GLphjz67/x7tdIvRzb8a5z0REjLeUDCyOvIoePdZsBAZe+aQrksoJ2n
 CEzw==
X-Gm-Message-State: AOAM533IE6upcyb3yS0J8CkQtMmvdmmzU0lAKDi8yibbx3si5eiGAFsk
 Wa8JSjSZIiyUG5rDMSDCtae0TNABhpqAWVimW95c3OlIWDVjNPRHiyMsvEbRP4FrbO9DPkolHL9
 SlzyxauwJ/NgvQ2GAWoPk46VzKcP0CuTTQ8grLp+sFA==
X-Received: by 2002:a17:906:7942:: with SMTP id
 l2mr4109127ejo.730.1642087190540; 
 Thu, 13 Jan 2022 07:19:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY9l0dMwz3EJs33yEWQDUQD/vM85TTnjGbfUdGlr/uzrnbvqMxaz/IW8imPgv8gALNSSrBgA==
X-Received: by 2002:a17:906:7942:: with SMTP id
 l2mr4109114ejo.730.1642087190356; 
 Thu, 13 Jan 2022 07:19:50 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id m12sm1309096edd.86.2022.01.13.07.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jan 2022 07:19:49 -0800 (PST)
Date: Thu, 13 Jan 2022 10:19:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220113101922-mutt-send-email-mst@kernel.org>
References: <20220113145642.205388-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220113145642.205388-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Thu, Jan 13, 2022 at 03:56:42PM +0100, Stefano Garzarella wrote:
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime. In this case, the device would go to re-read avail
> index to access the descriptor.
> 
> As we already do in other place, we can cache the value in `avail_idx`
> and compare it with `last_avail_idx` to check if there are new
> buffers available.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

I guess we can ... but what's the point?

> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  		       &vq->avail->idx, r);
>  		return false;
>  	}
> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
> -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> +	return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
