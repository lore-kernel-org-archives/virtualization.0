Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF96C433F5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 10:56:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0B061B6F
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 10:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D0B061B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A7E980E2A;
	Mon, 15 Nov 2021 10:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70kU5y4vvk2U; Mon, 15 Nov 2021 10:56:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E541380D17;
	Mon, 15 Nov 2021 10:56:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C598BC001E;
	Mon, 15 Nov 2021 10:56:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B872CC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 10:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92C4B607A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 10:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKm8R5qOw6x7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 10:56:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E45E60791
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636973783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0lUZeUeVNztnqCJybcLl+qwTFeIC8ui2eT7yul8nnE=;
 b=PMy7+VGhXekmd1/XsMFRh2fPfuRNT3OQi6I3sM0ZlG8BwxAYweIwwRkwDMDykgiXtDvps8
 5juYsdDdjzFAJpFTJKqIg3jyIjc3+RohXeF6LGkoHRBZg1dMZZ4QC2WhcCs2yUrwoX2FTK
 qCFAFhwpSlmfoE+SXk9nqgov/BLNvvc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-EuSo_HaSOteUz-eAUXcxbQ-1; Mon, 15 Nov 2021 05:56:22 -0500
X-MC-Unique: EuSo_HaSOteUz-eAUXcxbQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 v10-20020a1cf70a000000b00318203a6bd1so7687134wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 02:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S0lUZeUeVNztnqCJybcLl+qwTFeIC8ui2eT7yul8nnE=;
 b=yeUOAtIL0TYVhChwev+q0GqoEBqqTgC+Kcw2ILXd1gM//l+CnqAcBnVzYb9FzVGQxp
 6GWFAuyRp43mUU2AS6rfU8qBGlalw1VmqNLyOnNprra1wIa9cQaKuCs+0enzkRrDxLGE
 domToJgYewsWM8nLUz2qJWtmPhcDOxNSpK8m1cyTR1eYfP6wrWbHsgblkxIogXK30aiA
 ZDqgGk04jsnjD1VMsnHt82gY/rId3HVC9GaQz0C/DoHh9GNWApG5FmXR80P+7+ckadty
 c0OD6CsGtwuU9Nlr5SLT4T0twN/xPNauqf7tevS7jkC0Im4sXBEhUxK8bNYQOFkb5bsM
 GiTw==
X-Gm-Message-State: AOAM530FL815Y1BPrAXPwDbluQydjcWKMz4whYd78IBv/Z4EnyJRcd4T
 U4ndxlveDB8S9LAX4WE1ieMF65399bT1TgYQgM678mVfiYx0RuMEbLWBZoRoXS3fs/K4Xxys82L
 9U8mDCCLdJHdJ/BPj6JbY9e9F0EG0ZtNa+M3Bj6uKUw==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr58679819wmc.176.1636973781575; 
 Mon, 15 Nov 2021 02:56:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/cmiECc6xSujDlVb2k+MCmaVCE42WdD6GquDHr+MhgA+OWyObeRyaWcRWbnxtr95mgwqqpg==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr58679788wmc.176.1636973781330; 
 Mon, 15 Nov 2021 02:56:21 -0800 (PST)
Received: from redhat.com ([2.55.156.154])
 by smtp.gmail.com with ESMTPSA id z18sm13827144wrq.11.2021.11.15.02.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 02:56:20 -0800 (PST)
Date: Mon, 15 Nov 2021 05:56:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
Message-ID: <20211115055336-mutt-send-email-mst@kernel.org>
References: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
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

On Mon, Nov 15, 2021 at 11:16:42AM +0800, Wu Zongyong wrote:
> Vdpa devices should be reset after unseting irqs of virtqueues, or we
> will get errors when killing qemu process:
> 
> >> pi_update_irte: failed to update PI IRTE
> >> irq bypass consumer (token 0000000065102a43) unregistration fails: -22
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>


A Fixes flag might be appropriate here.  2cf1ba9a4d15c ?

Also, remind me of commit 97f854be203883b61d24f230445bd533bbdf770c
vhost_vdpa: unset vq irq before freeing irq - what's the difference
in scenarios?


> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 01c59ce7e250..29cced1cd277 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>  
>  	mutex_lock(&d->mutex);
>  	filep->private_data = NULL;
> +	vhost_vdpa_clean_irq(v);
>  	vhost_vdpa_reset(v);
>  	vhost_dev_stop(&v->vdev);
>  	vhost_vdpa_iotlb_free(v);
>  	vhost_vdpa_free_domain(v);
>  	vhost_vdpa_config_put(v);
> -	vhost_vdpa_clean_irq(v);
>  	vhost_dev_cleanup(&v->vdev);
>  	kfree(v->vdev.vqs);
>  	mutex_unlock(&d->mutex);
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
