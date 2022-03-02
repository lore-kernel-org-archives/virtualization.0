Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A529C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AB9194048A;
	Wed,  2 Mar 2022 13:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFgI8bLhBDfP; Wed,  2 Mar 2022 13:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 048574047F;
	Wed,  2 Mar 2022 13:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC85DC0082;
	Wed,  2 Mar 2022 13:31:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCF19C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CADE481756
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tZv5XI3Dt-Yx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:31:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54E6981699
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646227865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vpr93uN6MxOxe9fXO/50h3J2w847QD18h7MxHrR4EFI=;
 b=iS9W8aLb7Se1nGA1uLxNKwe0RAflwosaZYo0HzYvHwCggDiOTRNU15t+0MfjDO1ASaj+wC
 aXr7CIhSlh6nBOKVFGyYt9ivSyhRNhQa9FGD+2ToWApQznlCJv8kM4mX+GztYHknEnj4IO
 a+56V0dBKAyJuZgZFyl7PrtdkzTFGc8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-HJooK9MOMLOepoHM89LiBw-1; Wed, 02 Mar 2022 08:31:00 -0500
X-MC-Unique: HJooK9MOMLOepoHM89LiBw-1
Received: by mail-wm1-f71.google.com with SMTP id
 f13-20020a05600c154d00b003818123caf9so822112wmg.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vpr93uN6MxOxe9fXO/50h3J2w847QD18h7MxHrR4EFI=;
 b=xo3xcuOXT5/RVsQWcmLzuXty/HzBzMq6rM/ZrHKJNbgEAjrt9V8LRUMaDe0M3tl9ih
 lj/CI2pViBMkRUB3M4vWyh8qerR0LhT3gGCymQVquwvrl8V4h0X02lmJLBN+Gf6WYb1+
 890nxEh8THZ+qXkE2HJXEDJr3ZWP68LWJeeKbkGHWJQsvhogNiFRiBSdfldfzd7ygBpr
 /70I2wspiZH1Wt1BRv2x4StmuW8u5He2BEc5XhpTGQEXHUfpMDnFkyYYXjDcKqMirfDG
 NveYcKGUB0Ks3Wf419g18a+L3JdxSrrkAzgLdLiXkRRtUEIrcApEGv/ga3zCfM0SSdA4
 Swig==
X-Gm-Message-State: AOAM533WdnCC+vc5n49HsekErvRr+IGr/pNYLYURUhBtyrgslQLYMpOj
 npP7xgDyLF2wvpoWHkBTk5tROC1VgsTekS1q8Iy1WWRPWjLi9jsvw+SJNLhF8XWxYort/0hO4os
 dI2wYhxM8ltkqxtiqdvLS3R2CAQ1LT251b7NuaYIAKg==
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id
 o9-20020a5d4089000000b001f0481961bamr706807wrp.307.1646227857898; 
 Wed, 02 Mar 2022 05:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB5w9pGnsT+Lg3Clzc3lJA6rrR//BxxGl8wdCoogL6jR5Pnb1QZrgmJ3q8QCWDn1myvFVNdQ==
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id
 o9-20020a5d4089000000b001f0481961bamr706789wrp.307.1646227857681; 
 Wed, 02 Mar 2022 05:30:57 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 bi6-20020a05600c3d8600b00381590dbb25sm9721486wmb.3.2022.03.02.05.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:30:56 -0800 (PST)
Date: Wed, 2 Mar 2022 08:30:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302082021-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20220302075421.2131221-1-lee.jones@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
> 
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..bbaff6a5e21b8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> +		mutex_lock(&dev->vqs[i]->mutex);
>  		if (dev->vqs[i]->error_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
>  		if (dev->vqs[i]->kick)
> @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		if (dev->vqs[i]->call_ctx.ctx)
>  			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>  		vhost_vq_reset(dev, dev->vqs[i]);
> +		mutex_unlock(&dev->vqs[i]->mutex);
>  	}

So this is a mitigation plan but the bug is still there though
we don't know exactly what it is.  I would prefer adding something like
WARN_ON(mutex_is_locked(vqs[i]->mutex) here - does this make sense?



>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> -- 
> 2.35.1.574.g5d30c73bfb-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
