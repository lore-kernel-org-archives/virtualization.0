Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D272C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 22:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0793F60BA3;
	Mon,  7 Mar 2022 22:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMjCBU0R5Aij; Mon,  7 Mar 2022 22:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A631060597;
	Mon,  7 Mar 2022 22:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76922C0012;
	Mon,  7 Mar 2022 22:37:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0EB8C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9041540734
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FrQyqeX03xqu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E236404F3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646692646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8UjngamxI9B+AYkCciPjNfNT+6reXZ4EgmCRb4lE+4=;
 b=CDW/m6WWluNXHqt5ZGLDL8J93iH3W3jES8rvFLxvjnE2GRZtUqjqTE+bfABVzWEwx52HPO
 6LQeWvZ6yqtjsYyDW2pM4RBoLHgGZmL0hkMVgGWlOyDgtkuPgRTKIrwikK0rwXF3LQtb/f
 03N3+G6UvwdgWTh7iGb65AAYxq/l2pw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-NetPXuurP9ydLVKOGEE1rQ-1; Mon, 07 Mar 2022 17:37:24 -0500
X-MC-Unique: NetPXuurP9ydLVKOGEE1rQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 qf24-20020a1709077f1800b006ce8c140d3dso7671568ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 14:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z8UjngamxI9B+AYkCciPjNfNT+6reXZ4EgmCRb4lE+4=;
 b=56f9okOAoC/KcmxjLaU1wk5u1OUjWq+EkAIa3pSVUv+GsFQgZLHFeRBiH0y/yI3GRU
 gx7BW5KxyFyIqr5yHFJne6qrkOrw1o7ko3eLLCYh5r/U8zcyu6/QDu20+nT8jh2bM+ZO
 3Sb5f5h7WL7HauPdKR1UCVNxJRUdipd5fAvKtD4WH/xnLnezg/2kyr/B6IKmL076rVNX
 SGgm334rfPyq8ngyJ1SShGhAFWay+jCJx4dt9mxGPNuw1zHj+/SU/Yn0Xnl1IVBFL8Qh
 2vsH1SU5O45iDPOoDIRgUVX/OnAco1eEZrATz+xWf1OSKrjjUBSI4VI0hW7B7ztUMql/
 c3Iw==
X-Gm-Message-State: AOAM533PekjiSAFzmp4iNND9xxd7OkeS6IbatPuYXcFonyNY28g2p5X3
 fyuvzbm6jF8gxKoqPhcFC8p65mMEJinNu+1DOAkFPuAD3O8THpdvJckUMRD1Ka3xAp73yXu1WY2
 fnfekhrfXgnqhfMNWittNmdOYBXL/5ahdfi5aHNpvXw==
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id
 u4-20020a056402064400b004164ade54e3mr5993881edx.222.1646692642161; 
 Mon, 07 Mar 2022 14:37:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDQfReYKCLxP7wgXRhk5w7cO+7IyYbZrZcsq5S+N9M32u3NyUw3dG6w3ZKY6BWETW8k6zHrA==
X-Received: by 2002:a05:6402:644:b0:416:4ade:54e3 with SMTP id
 u4-20020a056402064400b004164ade54e3mr5993869edx.222.1646692641977; 
 Mon, 07 Mar 2022 14:37:21 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 w14-20020a170906d20e00b006cee22553f7sm5205644ejz.213.2022.03.07.14.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 14:37:21 -0800 (PST)
Date: Mon, 7 Mar 2022 17:37:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220307173439-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20220307191757.3177139-1-lee.jones@linaro.org>
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

On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do here is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.

Pls just basically copy the code comment here. this is just confuses.

> Also WARN() as a precautionary measure.  The purpose of this is to
> capture possible future race conditions which may pop up over time.
> 
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00

And this is a bug we already fixed, right?

> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com

not really applicable anymore ...

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..ef7e371e3e649 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> +		/* No workers should run here by design. However, races have
> +		 * previously occurred where drivers have been unable to flush
> +		 * all work properly prior to clean-up.  Without a successful
> +		 * flush the guest will malfunction, but avoiding host memory
> +		 * corruption in those cases does seem preferable.
> +		 */
> +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> +
> +		mutex_lock(&dev->vqs[i]->mutex);
>  		if (dev->vqs[i]->error_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
>  		if (dev->vqs[i]->kick)
> @@ -700,6 +709,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		if (dev->vqs[i]->call_ctx.ctx)
>  			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>  		vhost_vq_reset(dev, dev->vqs[i]);
> +		mutex_unlock(&dev->vqs[i]->mutex);
>  	}
>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> -- 
> 2.35.1.616.g0bdcbb4464-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
