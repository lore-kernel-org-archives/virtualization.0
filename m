Return-Path: <SRS0=80gr=L4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD42C07E95
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 21:50:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7D2613C2
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 21:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D2613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 630FF40433;
	Sun,  4 Jul 2021 21:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQ8JL0_65O84; Sun,  4 Jul 2021 21:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96AF640426;
	Sun,  4 Jul 2021 21:50:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72BA5C001A;
	Sun,  4 Jul 2021 21:50:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3544FC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 21:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3007740266
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 21:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uo-0whfrNDAf
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 21:50:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E238400B5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625435423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIGegxYGDRVnY+0B5U65wuNVG6v5O6+ZCTdBoj9f2Yw=;
 b=W9Y1GzfHjF73/hj3uUnGuyJkqWYa3HzZ16jWcEAnqM9iKdVy0fTm1xrHY+fjKzIdMVkX+t
 M0rFhK3OoTKJIBSTq8GRShrdAxsRKN7Ii3YbF10Bm7EwSwAtWc5W/i1+bOS0HC7/0hzMC+
 8fs+hsW5hi6/y7zodbZfIrtjS5VNLF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-fe9b3z23Plm7agQh8vu8ig-1; Sun, 04 Jul 2021 17:50:20 -0400
X-MC-Unique: fe9b3z23Plm7agQh8vu8ig-1
Received: by mail-wm1-f71.google.com with SMTP id
 n37-20020a05600c3ba5b02901fe49ba3bd0so2450613wms.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 14:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hIGegxYGDRVnY+0B5U65wuNVG6v5O6+ZCTdBoj9f2Yw=;
 b=t9XZEvX/8fkEDLEL7qXGmuIFQZthXK7FQik3nJYOyVMwZeFBNRmKRCXtuOwhYj8XRn
 Y4YamypMafxdC41DR7anARm+ogFadMv8I/Xat8IAEXqMB+oHatKPHjJKHG327QIYCX8N
 qRwpXcVkTzhO375yR0VUMPf6Z2CkQebGMKh8olKdlkuryK+fRDgpPkTV76W4qGZun/l6
 YVY6Nn3Jui56dXxYELWjGxtyZ8+iMd5BKCbxW86s2nxSSTqoJVTdojr4cyL908EhfHsU
 Jkl66svbf4D/k+aWK5DFmkRPvlNZVpMtT83lrxr6qaRGwh9fcNl8n5kWwggnKQEp6JFR
 H16g==
X-Gm-Message-State: AOAM532J8ehQilRGSLrT0LoKvexWU61F685YUkKBZ1DaemNZ0AMGqY3O
 IorpnrovpdPwz9FdmYZFB7GSGKzf1YSmCFqywQA7C2tRQS9zLUMxSXTJ3fy5GgQhnDyzpJwkw5d
 lUZSvoVcs2Y7161XUdSTYpn8rle3A2MdkKaP/mn46yQ==
X-Received: by 2002:a05:600c:3501:: with SMTP id
 h1mr4478406wmq.157.1625435419083; 
 Sun, 04 Jul 2021 14:50:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMAN2Vtw1cK9aE+mZwmlC30rOpcp20CWrNEC04TT9Kpl1piUVWOO3pZq+1QEDhpbR9mFw+gQ==
X-Received: by 2002:a05:600c:3501:: with SMTP id
 h1mr4478371wmq.157.1625435418721; 
 Sun, 04 Jul 2021 14:50:18 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id n13sm2841425wms.4.2021.07.04.14.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 14:50:17 -0700 (PDT)
Date: Sun, 4 Jul 2021 17:50:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gautam.dawar@xilinx.com
Subject: Re: [RFC PATCH] vhost-vdpa: mark vhost device invalid to reflect
 vdpa device unregistration
Message-ID: <20210704174856-mutt-send-email-mst@kernel.org>
References: <20210704205205.6132-1-gdawar@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <20210704205205.6132-1-gdawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 martinh@xilinx.com, hanand@xilinx.com
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

On Mon, Jul 05, 2021 at 02:22:04AM +0530, gautam.dawar@xilinx.com wrote:
> From: Gautam Dawar <gdawar@xilinx.com>
> 
> As mentioned in Bug 213179, any malicious user-space application can render
> a module registering a vDPA device to hang forever. This will typically
> surface when vdpa_device_unregister() is called from the function
> responsible for module unload, leading rmmod commands to not return.
> 
> This patch unblocks the caller module by continuing with the clean-up
> but after marking the vhost device as unavailable. For future requests
> from user-space application, the vhost device availability is checked
> first and if it has gone unavailable, such requests are denied.
> 
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>


I don't seem mappings handled below. Did I miss it?

> ---
>  drivers/vhost/vdpa.c | 45 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e4b7d26649d8..623bc7f0c0ca 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -47,6 +47,7 @@ struct vhost_vdpa {
>  	int minor;
>  	struct eventfd_ctx *config_ctx;
>  	int in_batch;
> +	int dev_invalid;
>  	struct vdpa_iova_range range;
>  };
>  
> @@ -61,6 +62,11 @@ static void handle_vq_kick(struct vhost_work *work)
>  	struct vhost_vdpa *v = container_of(vq->dev, struct vhost_vdpa, vdev);
>  	const struct vdpa_config_ops *ops = v->vdpa->config;
>  
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return;
> +	}
>  	ops->kick_vq(v->vdpa, vq - v->vqs);
>  }
>  
> @@ -120,6 +126,11 @@ static void vhost_vdpa_reset(struct vhost_vdpa *v)
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
>  
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return;
> +	}
>  	vdpa_reset(vdpa);
>  	v->in_batch = 0;
>  }
> @@ -367,6 +378,11 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  	u32 idx;
>  	long r;
>  
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return -ENODEV;
> +	}
>  	r = get_user(idx, (u32 __user *)argp);
>  	if (r < 0)
>  		return r;
> @@ -450,6 +466,11 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  		return 0;
>  	}
>  
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return -ENODEV;
> +	}
>  	mutex_lock(&d->mutex);
>  
>  	switch (cmd) {
> @@ -745,8 +766,13 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	int r = 0;
>  
> -	mutex_lock(&dev->mutex);
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return -ENODEV;
> +	}
>  
> +	mutex_lock(&dev->mutex);
>  	r = vhost_dev_check_owner(dev);
>  	if (r)
>  		goto unlock;
> @@ -949,6 +975,11 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	u16 index = vma->vm_pgoff;
>  
> +	if (v->dev_invalid) {
> +		dev_info(&v->dev,
> +			 "%s: vhost_vdpa device unavailable\n", __func__);
> +		return VM_FAULT_NOPAGE;
> +	}
>  	notify = ops->get_vq_notification(vdpa, index);
>  
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> @@ -1091,11 +1122,13 @@ static void vhost_vdpa_remove(struct vdpa_device *vdpa)
>  		opened = atomic_cmpxchg(&v->opened, 0, 1);
>  		if (!opened)
>  			break;
> -		wait_for_completion_timeout(&v->completion,
> -					    msecs_to_jiffies(1000));
> -		dev_warn_once(&v->dev,
> -			      "%s waiting for /dev/%s to be closed\n",
> -			      __func__, dev_name(&v->dev));
> +		if (!wait_for_completion_timeout(&v->completion,
> +					    msecs_to_jiffies(1000))) {
> +			dev_warn(&v->dev,
> +				 "%s /dev/%s in use, continue..\n",
> +				 __func__, dev_name(&v->dev));
> +			break;
> +		}

When you have an arbitrary timeout you know something's not entirely
robust ...

>  	} while (1);
>  
>  	put_device(&v->dev);
> +	v->dev_invalid = true;
> -- 
> 2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
