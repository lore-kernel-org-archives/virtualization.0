Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B44C433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 07:26:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C06260724
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 07:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C06260724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA19D81D0B;
	Wed, 15 Sep 2021 07:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLhNJqPLnhRv; Wed, 15 Sep 2021 07:26:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8982A81DCA;
	Wed, 15 Sep 2021 07:26:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B1C3C000F;
	Wed, 15 Sep 2021 07:26:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF0C3C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D11A6403CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fV7CG7DoIcFU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:26:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 274C040387
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631690808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxE2x0LHpSWmPDUKiA4SC3PMYHF62O6V8fJ2k4L/mOE=;
 b=dpHwuD9jg/0L7GicmCzHrU110O1vMgRDdfHTA8xEUHcWhBlkJHXUv7G5XhLDpZixRJvWTs
 GHw7WJwtnXI+THJup/BBKrZLDNYiHZAcgTRg+DmQ2OG5CWbKUYL6b0whFOcQMdi0WS80wI
 pWw0CbXdAnZ7ZJktk1mBKCZ4XREwdFM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-nrzF8ZASP66mXtyfJOUwmg-1; Wed, 15 Sep 2021 03:26:46 -0400
X-MC-Unique: nrzF8ZASP66mXtyfJOUwmg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m9-20020a05600c4f4900b003057c761567so1331986wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 00:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LxE2x0LHpSWmPDUKiA4SC3PMYHF62O6V8fJ2k4L/mOE=;
 b=pSpio7ktw2oHjEdMisABcJ6u0YMwgMWQGlUm1QY7eU+XQBisj4ol+9AAKn5NnWt+2Z
 jjI9Pu/Rd/Y2QUATH861lGmYbp4jBymtbZl/YyBiKlEdwpYLPjUXntizrUWAJGJrBALe
 7bEvEoKT4zyJR5Ks3PL+QnJLtHPx17PEWqSoCy8HYS5DwCWzhMMezcay8Qj/4ItsxViB
 eDrbgHYhg726HSSVaPmcb1tHEJ3beIRHw4FvDHpXw0KSAktJX0eyrC76EvbGXKDgQXpP
 MsDNh0XOSpHjoTpqSJwx7+1gxZNvH4euQHcog5BBTUcs7ktx7aJjeK1VQt/6NK1SiwbO
 kMiw==
X-Gm-Message-State: AOAM532zeD1hUcCaQdCDTh/jZeGOr9iUlOgoXJkYNiaqTCVXtOHh/NPL
 kuTfEHPDFQxRg64WnD2F8CfntSUHsXzRZ6qzVs2WmS4OsWQpUVP2zHroHR1TJsfFhawVeUuJIo5
 Mo2zquuVSxAGnFNp7xulEdX5UlaHc1eTI07+yO67yQQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2795701wmb.112.1631690805673; 
 Wed, 15 Sep 2021 00:26:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCCn4lCnnOjC1yCPwbQqy3AXMz4aDtlv/1NwTxsg+6aBBMkZ7q5mRE/4uearyFq0B2SQAh1A==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2795691wmb.112.1631690805485; 
 Wed, 15 Sep 2021 00:26:45 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
 by smtp.gmail.com with ESMTPSA id m29sm13517929wrb.89.2021.09.15.00.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 00:26:44 -0700 (PDT)
Date: Wed, 15 Sep 2021 03:26:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Message-ID: <20210915032510-mutt-send-email-mst@kernel.org>
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
 tiwei.bie@intel.com, virtualization@lists.linux-foundation.org
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

On Wed, Sep 15, 2021 at 02:39:32PM +0800, Wu Zongyong wrote:
> Currently we unset vq irq after freeing irq and that will result in
> error messages:
> 
>   pi_update_irte: failed to update PI IRTE
>   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
> 
> This patch solves this.
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vhost/vdpa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index f41d081777f5..15bae2290bf9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>  		return -EINVAL;
>  
> +	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		for (i = 0; i < nvqs; i++)
> +			vhost_vdpa_unsetup_vq_irq(v, i);
> +

If we do this before reset like this then the device might assert the
irq, might it not?

>  	if (status == 0) {
>  		ret = ops->reset(vdpa);
>  		if (ret)


> @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  		for (i = 0; i < nvqs; i++)
>  			vhost_vdpa_setup_vq_irq(v, i);
>  
> -	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		for (i = 0; i < nvqs; i++)
> -			vhost_vdpa_unsetup_vq_irq(v, i);
> -
>  	return 0;



>  }
>  
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
