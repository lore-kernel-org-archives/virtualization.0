Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB3C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 05:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27F7140A06;
	Fri,  4 Mar 2022 05:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyNQgoe9zbc8; Fri,  4 Mar 2022 05:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B842940A05;
	Fri,  4 Mar 2022 05:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99517C001D;
	Fri,  4 Mar 2022 05:00:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79EC6C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 05:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5527240A06
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 05:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F1_-zwLGsG9R
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 05:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58E6440A05
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 05:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646370037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9LljTggMYdd47/c+/HB8RDqC/7m392I60YkhURxrMM=;
 b=CxA42lTm65lDJnTGnDF//4sdoc65r8Pl0zgdtyLvuW7iCxOFw664tJN0njToNQNWbg3vIj
 6IorVnzY2FzeTNAiBBU7U4NpWGDDn7zjsyeRCNOELUyGOP7by7z8kf+2clNnGnZbhiJBlG
 aJy5XNbS0IJDpJmbFJvwo7Or2gQ+qnY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-pRXbB4SJO4WBHEUzPYtrxA-1; Fri, 04 Mar 2022 00:00:33 -0500
X-MC-Unique: pRXbB4SJO4WBHEUzPYtrxA-1
Received: by mail-wr1-f70.google.com with SMTP id
 a5-20020adfdd05000000b001f023fe32ffso2908974wrm.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 21:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C9LljTggMYdd47/c+/HB8RDqC/7m392I60YkhURxrMM=;
 b=nL59XigRFjsPjOsC2cs4rGQuQJ5qC3u636Wvi5HXyXe1Ak7mPMwGglK2ODnUUydT4j
 QTHh8L9WCSec2oOw0keo6GMOyGrr5mQFvottsgrFneJE5KY6rpOemYCb0c23wxdEQKdM
 ovG3a+cwk3ybMJF+u4qte09+Z28xYD0H1pfu5ceyt92gyA1zlbTIMhuBntVinMfk0cup
 1FWhr/zWfys1bqMNww8uCYXwGr24OV3fVuuOyVfKJjuojgdI+8UlVXJxxha2qq+OmCOg
 5xuI4X80PE1B6WLaXkSSPFTqRNNe8PcK+K83llCnx1ZSzAVmrt6O4DufUHdJsBrJr79a
 B5Sw==
X-Gm-Message-State: AOAM531wMvjCxSa/vz80Y1oJevyAROLScx8jKMs3hum3AvwQNn6fdxIH
 cDtSu595lbZwV2rBgKRLCUIAipwBwPmA9mHKj+VknmS4UNlIpbt7jd23bBdOOju5sNGiXl3Udvu
 B8AxfLQa/a+VQTl0D1kgm+CCLxR9k94/qTFwmy/7JKQ==
X-Received: by 2002:a5d:47c5:0:b0:1ef:f2e8:11fc with SMTP id
 o5-20020a5d47c5000000b001eff2e811fcmr14057947wrc.109.1646370030408; 
 Thu, 03 Mar 2022 21:00:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/9IpbklvBlJJPYjzIkhqrW9cqHaZPxp5pYripZTV4jzY3k3rJRGhRMUtTqLp99H9+2vfm0A==
X-Received: by 2002:a5d:47c5:0:b0:1ef:f2e8:11fc with SMTP id
 o5-20020a5d47c5000000b001eff2e811fcmr14057937wrc.109.1646370030110; 
 Thu, 03 Mar 2022 21:00:30 -0800 (PST)
Received: from redhat.com ([2.53.6.39]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c4f8400b00380e45cd564sm4015646wmq.8.2022.03.03.21.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 21:00:29 -0800 (PST)
Date: Fri, 4 Mar 2022 00:00:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220303235937-mutt-send-email-mst@kernel.org>
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

So combine with the warning patch and update description with
the comment I posted, explaining it's more a just in case thing.

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
