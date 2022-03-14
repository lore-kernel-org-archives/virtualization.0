Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA96C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 11:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 506A741522;
	Mon, 14 Mar 2022 11:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdvYi9_SbwJH; Mon, 14 Mar 2022 11:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EADB2409F9;
	Mon, 14 Mar 2022 11:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1422C0070;
	Mon, 14 Mar 2022 11:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D372C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F9004109B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J94X-Cos76Zw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:49:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B05C409F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647258566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OV+JMiHtDmU80bd8QdGrPwVuVFZHYuiIn55+GlQmhk=;
 b=X9iG2BRZhp0tUxW9OLTwpp2FWKrOPP4X8rpaVEEo9CUwVMIcsE0IhDNwEnK/2vC+aE1tAo
 cNaw186OgSMOgK59GeFXNcBQdEd0UV0T5U1OXwwnZzel9iFTW2TrE9Q2Mh8unswb9nM2nA
 YJqq7CJ1SENtQiplR+rzGgV1to4unt4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-RYp0GLX4NtWLlTxZ9nKWbg-1; Mon, 14 Mar 2022 07:49:25 -0400
X-MC-Unique: RYp0GLX4NtWLlTxZ9nKWbg-1
Received: by mail-wm1-f72.google.com with SMTP id
 q189-20020a1c43c6000000b003898de01de4so3399111wma.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 04:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2OV+JMiHtDmU80bd8QdGrPwVuVFZHYuiIn55+GlQmhk=;
 b=XI6Lfz91DfD2FQUoIJeYHCG7RShFz6IiGqAdo70Hp77Vwrl3Vsz4Cq7aWmXmJYaOxC
 snftZx8mCEPetXTuLXlc65Bupp1W6ZgrIhqaLbwZcE8sThsHhkbjf593OG7zxegqlGxc
 bR8tX13Dx0ySFLmMKAOypkaUG4+J+AJs6Wv2hmTQUCF2pkCm5KEiiFfQbmuc8YqoM2b8
 E61QtzjpDUdDIrKaNNK3BdLxe5YO4ECkoShhCD3tD+1bxGB94fGIaf2ooHWiaDnEmzXA
 SUMLUIW5af9ZMi50OVYB1fY2Ar6UbDW56a3S9bKpffaoPzYDbTGVnlMXutYYlYEi/5fu
 AqxQ==
X-Gm-Message-State: AOAM5306qv+qOds21kTWAFpuYTGHOTzCdQi504d95UNgWfILIfcd/Qo7
 SFxUaC8pCdhOlS+xqMfRPKWkpfUDGo423ywN3cmJIzgpsyVv4CilZtw3ufID8icJLfE6qvFR3Ed
 mpqu0YFOHozB4rV4Gzd6EZUobmWirtJDtqFlbJ34s1w==
X-Received: by 2002:a7b:c4d9:0:b0:382:a5cb:ff2f with SMTP id
 g25-20020a7bc4d9000000b00382a5cbff2fmr24926187wmk.193.1647258563831; 
 Mon, 14 Mar 2022 04:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0vEUQerg7rtj1M60xY/4WI1a07DNC4tgLgIhZzRrnktkhTqSbm6C/0HM52Wm6/8e4NBhRaQ==
X-Received: by 2002:a7b:c4d9:0:b0:382:a5cb:ff2f with SMTP id
 g25-20020a7bc4d9000000b00382a5cbff2fmr24926169wmk.193.1647258563574; 
 Mon, 14 Mar 2022 04:49:23 -0700 (PDT)
Received: from redhat.com ([2.55.183.53]) by smtp.gmail.com with ESMTPSA id
 v25-20020a05600c215900b0038117f41728sm18037161wml.43.2022.03.14.04.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 04:49:22 -0700 (PDT)
Date: Mon, 14 Mar 2022 07:49:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220314072137-mutt-send-email-mst@kernel.org>
References: <20220314084302.2933167-1-lee.jones@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20220314084302.2933167-1-lee.jones@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 14, 2022 at 08:43:02AM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do here is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
> 
> Also WARN() as a precautionary measure.  The purpose of this is to
> capture possible future race conditions which may pop up over time.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Pls refer to my previous responses to this patch.  I'd like to see an
argument for why this will make future bugs less and not more likely.


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
> 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
