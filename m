Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95651C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 16:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40CCE404FC;
	Fri,  4 Mar 2022 16:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uFiETQWWipDq; Fri,  4 Mar 2022 16:48:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D0D340232;
	Fri,  4 Mar 2022 16:48:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A26BC0012;
	Fri,  4 Mar 2022 16:48:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2613FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0597160A79
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lelV6LK1RFFh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:48:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A00B060810
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646412488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXHJzGIO2DpN/950dP0XzRsezt/Kr2kOdiCXWPNUhtA=;
 b=ZhHFPbHRkqItrBhPWr8Jglvw2Dqn6YzTyNuXvRGkcC6Le1DZL5aE9Dgb0GFkPbyrG+VTwd
 rBOjya9yUOMVj7nEt9GT3InQSPz2CNJ3XDsQWO/+18Q18k6scirMvrGnXH/rlA3gm4NnDb
 psNXQIpeZvNDj+HQgleA/uwvNdIeUPU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-qTp_3FZtNKOYJ-OgnrZ6TA-1; Fri, 04 Mar 2022 11:48:07 -0500
X-MC-Unique: qTp_3FZtNKOYJ-OgnrZ6TA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c19-20020a05600c0ad300b00385bb3db625so2696623wmr.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 08:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NXHJzGIO2DpN/950dP0XzRsezt/Kr2kOdiCXWPNUhtA=;
 b=PJ2MoRisGwwXZXj2hAtbuVD2VG809XiYmwfPm9hM9JLKTNReyN6+0C/Q/1SOBSVMCg
 rqIJ3MQnoGFUzLLT6HW/CNb/sC7OGo1em3g0EDoGRCHgWm1JLgCO+l+Amo1DbUyjBAbv
 DSBmwsME7tJYhpbla0twZ11eoJMHKKTDqkG9UOjIgfhkwGG5P7ZKr85T49No+9HwcGCc
 c8+yr6pobLm+0aJkJCwViWBoKV+IDJuhC+lFEfyn+Q5dDRvCYIEjimYShioccJByi2xP
 bPEEHyV8yqZruOAJLm9KwNywqL400LyGtEd1pqbxH1abkEOagtdMAW+pVAoWn0UfchSi
 ciOg==
X-Gm-Message-State: AOAM530ZPNDZMJAeeIi5zePCegD01MlHO5OGW9e1kyjy2dJc7JhJgvHm
 Kn5wVMbUgu4MQD3Yp3f6xhW32O6mJv/+PqmBUUyIlu5UKEmkmT0t8VKV5WhexG+Wqnx6dkiE7yU
 xuS6VBqV9RGNSgLFCzIxE1oPM+HvGVH6NRWXdvmSYbA==
X-Received: by 2002:a5d:4485:0:b0:1ef:d619:4de2 with SMTP id
 j5-20020a5d4485000000b001efd6194de2mr18533929wrq.88.1646412486245; 
 Fri, 04 Mar 2022 08:48:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1LHmfxoByV3G55D7/RSII3aDqbhXifikAKYkjpTRjhuQFLuDvl21okW72hfANNpBtEJwK+g==
X-Received: by 2002:a5d:4485:0:b0:1ef:d619:4de2 with SMTP id
 j5-20020a5d4485000000b001efd6194de2mr18533913wrq.88.1646412485973; 
 Fri, 04 Mar 2022 08:48:05 -0800 (PST)
Received: from redhat.com ([2.52.16.157]) by smtp.gmail.com with ESMTPSA id
 y12-20020adff14c000000b001f04d1959easm4999809wro.13.2022.03.04.08.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 08:48:05 -0800 (PST)
Date: Fri, 4 Mar 2022 11:48:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220304114718-mutt-send-email-mst@kernel.org>
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

OK so please post series with this and the warning
cleaned up comments and commit logs explaining that
this is just to make debugging easier in case
we have issues in the future, it's not a bugfix.

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
>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> -- 
> 2.35.1.574.g5d30c73bfb-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
