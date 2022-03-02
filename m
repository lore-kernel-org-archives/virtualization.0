Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D351C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB00760BA1;
	Wed,  2 Mar 2022 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qhh0LsG_ZlJt; Wed,  2 Mar 2022 09:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 15283605A5;
	Wed,  2 Mar 2022 09:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA6D0C0082;
	Wed,  2 Mar 2022 09:35:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1837BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC51F415AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QYRKm1sYxVpp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:35:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A51E1409A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646213699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AbAW59nDe9iXOUa0NZzg+mzBzM1DTimtc+hATy3tFU=;
 b=GoDYInfgoNnQ/zEEXcGeS2vlE3IqNnPfBAbLm449iyM50vU5bUAFyRHxd+QUn4UamlVmoq
 IlgMRUPRr6A36hspVr2H3PTgrRUVoIjBXZvqoybaIkql8hkzLb5wFcM/vhKob3jcEL1af5
 IoP6QXU1jHIB6wMiKGf7zOHZuxn6o08=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-k-76OZJ3M3O-1cqNmNu4DA-1; Wed, 02 Mar 2022 04:34:56 -0500
X-MC-Unique: k-76OZJ3M3O-1cqNmNu4DA-1
Received: by mail-qv1-f72.google.com with SMTP id
 z3-20020a0cf003000000b004328f6a7131so1110683qvk.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 01:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4AbAW59nDe9iXOUa0NZzg+mzBzM1DTimtc+hATy3tFU=;
 b=ZD4KVQAmMNaqDkYj8HxrMYTsCuTgLHLb2uF48Yk1a2ZHAsXzXQHwiqOtPqsHYsAkxV
 IoWl4yMx82tcsjNRGq49stkR0D2iiXsIgY/syiu4zzp+usi2dlIAQFsEcKoWTtYHZv5R
 y7jswSlZyo6txd3BCfG6ZpfA70jJrRJn4KxUduh3XIuckYpKTLYT765E8zI+AQuDL5Fr
 N8zZJ7LIKR8Z6qUol5skIG5pVISzJVnJMThduxPDJwzB8ClFXEjHFizOwY7hrtbdDKRh
 UoAniwqDrQE2GutvkNTUA3+bmJzB6XI0qWbIAZT5G8fJUqC/YmZOr/1Y3uDa7CwWjgR4
 qb9Q==
X-Gm-Message-State: AOAM530TEeOb/0nFAJCOqZECdFZn+UfaWN+2aGlVARVbt+SpPYU0SGXc
 hQjuH5/tmJ9t/Cq7gA8vM0xEBJnyxYgXqYEwdJ5HceNXrxG1pCyeGmhI1t/EDR4+TAN0Nm6rRgp
 VZLNggowDfpVZ9VRP5pudry3AjTMSIa/QXtDDuCruoA==
X-Received: by 2002:a05:622a:589:b0:2de:9437:a380 with SMTP id
 c9-20020a05622a058900b002de9437a380mr22719612qtb.593.1646213695543; 
 Wed, 02 Mar 2022 01:34:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyC7INR2ARPeT61tUoT3peU6aDKB65/ufMp14UgRUKuFsJtDC2iNl/gqIBFpEUP3M458d4Gpw==
X-Received: by 2002:a05:622a:589:b0:2de:9437:a380 with SMTP id
 c9-20020a05622a058900b002de9437a380mr22719598qtb.593.1646213695279; 
 Wed, 02 Mar 2022 01:34:55 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 h3-20020a05622a170300b002e008a93f8fsm6551504qtk.91.2022.03.02.01.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 01:34:54 -0800 (PST)
Date: Wed, 2 Mar 2022 10:34:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302093446.pjq3djoqi434ehz4@sgarzare-redhat>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20220302075421.2131221-1-lee.jones@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
>vhost_vsock_handle_tx_kick() already holds the mutex during its call
>to vhost_get_vq_desc().  All we have to do is take the same lock
>during virtqueue clean-up and we mitigate the reported issues.
>
>Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00

This issue is similar to [1] that should be already fixed upstream by 
[2].

However I think this patch would have prevented some issues, because 
vhost_vq_reset() sets vq->private to NULL, preventing the worker from 
running.

Anyway I think that when we enter in vhost_dev_cleanup() the worker 
should be already stopped, so it shouldn't be necessary to take the 
mutex. But in order to prevent future issues maybe it's better to take 
them, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] 
https://syzkaller.appspot.com/bug?id=993d8b5e64393ed9e6a70f9ae4de0119c605a822
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a58da53ffd70294ebea8ecd0eb45fd0d74add9f9

>
>Cc: <stable@vger.kernel.org>
>Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
>Signed-off-by: Lee Jones <lee.jones@linaro.org>
>---
> drivers/vhost/vhost.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 59edb5a1ffe28..bbaff6a5e21b8 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> 	int i;
>
> 	for (i = 0; i < dev->nvqs; ++i) {
>+		mutex_lock(&dev->vqs[i]->mutex);
> 		if (dev->vqs[i]->error_ctx)
> 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> 		if (dev->vqs[i]->kick)
>@@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> 		if (dev->vqs[i]->call_ctx.ctx)
> 			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
> 		vhost_vq_reset(dev, dev->vqs[i]);
>+		mutex_unlock(&dev->vqs[i]->mutex);
> 	}
> 	vhost_dev_free_iovecs(dev);
> 	if (dev->log_ctx)
>-- 
>2.35.1.574.g5d30c73bfb-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
