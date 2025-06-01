Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1F18D643
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748775101; cv=none; b=PIP8hbMrQkScPmRS++iKGsIXHThiQ8duF5Pq60JL0q5QRztT5Bo3CB/W05seYcKkctd9Hzx2ABGqk/KdMNhX3PGAJUvvdEmy2O4I44tqHOwHJ9teNk+EE6Xted4e7ZNc8NHm68CR7dpu660yql+pDEsLDKyFPUD7RG1dslVfUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748775101; c=relaxed/simple;
	bh=Kg3D1Hds9FAI9RcBxGC9kYXWJb0C19mfROuvp6I68T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=op16JSAbqprLmovs9R87+MmPDuKFAyjPt0FPVCcpt5hvbcL2PS3G8sEPAVfr9Hc1SjymFsbnVqwDdhMEb9S6m3mQaURIUvxV3gULc+115BJDdFPvb7CcAcIqqKO9IL96NBN2n4sgp0uHIPlb2i97COkYYPajNXwZIBOSqPHlvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYQTEDiS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYQTEDiS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2230C60A62
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yT4yD29ob1a for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Jun 2025 10:51:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 72509606E7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72509606E7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYQTEDiS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72509606E7
	for <virtualization@lists.linux-foundation.org>; Sun,  1 Jun 2025 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748775098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+LDkkF3bl9XFii8SeXhYSZYWFK7xdUoFXE21Deot6Q=;
	b=DYQTEDiSdyQbMJiPkdjD9rj8JmJt/YRpQJmcc1yatWWq/oh9omV/vKjfD+1ZPEPj1VtD0M
	s2UcMULpqIUUAEmjbtUhvilfLGkQE8ysn9QHYx6ANFYa1z5NSFQx3k9Au8Ht9EwkWiGTVO
	i+Fu57fjDppfyHwonXHoPNY4ZSMWwNM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-JjVdqJNdMnGVt4YZkpXwag-1; Sun, 01 Jun 2025 06:51:37 -0400
X-MC-Unique: JjVdqJNdMnGVt4YZkpXwag-1
X-Mimecast-MFC-AGG-ID: JjVdqJNdMnGVt4YZkpXwag_1748775096
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so1592245e9.2
        for <virtualization@lists.linux-foundation.org>; Sun, 01 Jun 2025 03:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748775096; x=1749379896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+LDkkF3bl9XFii8SeXhYSZYWFK7xdUoFXE21Deot6Q=;
        b=dFVDNwo6czNB6zkraG+NNwdnjrYmO9O9ogM5yfC4Trd+pMZEz8gSQDh8YVxRfqmYzg
         DY230UbC3Ug7H61iemgtXrFdXbdH9JmO05H3rZwhXKkvmfKCBWvW9yhLzX+vWhaCWQip
         eLH/HnbE26rmsAGJhRxiablG4IuJ95CAA0RzNfMbAScM5SIYSmDrjuMJHv7fke3vFEnf
         BnkVMoEIA5ZDe0XoxZYJlCAYWtWhztva4xrnMek5M9Aou2ugxkUwkKrvF+IU6y4yqY1q
         ybwJn/gY+pbvWe1C9A7fpVAa1kUqlmMpL9SxAsItRgbr2MHQqOHFH03pAFUeEFFvRbuG
         xYVg==
X-Forwarded-Encrypted: i=1; AJvYcCVmAKFu6dRMUp6sRUvQvAX617Zo6ErfPaNMMHm4nAn8kk5l6GN11pTKS6ISBk/Hi0rzCoHebk0GZSSEL/l3kg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxkBgnftuSV2PZ56iHzEIqKh7CYUm6xwVzXPaSozD/SErRsKw3b
	UuO5P0L5vpnk41FxN/LQUeFiUvl9uxOicEOCJ4JPgB7M/JXU6UaF42GlTOVQU5KKB1TvW/eKezN
	N4QTf+4tTZjfmgFYpsIcK7q6tS7hcgq3GnzFlvt0EGI4G+UZv8HKX3o21tL94nkMhW8OAx4Jrec
	seQXHFNww=
X-Gm-Gg: ASbGncsIHU4rL3Xl6ntxGqxG3F/LWJiYZs7aATLiPLot2f1fsNM2BCXSwb8T9EUsEjk
	b3b8EGhRZXT7oZow7E1VhTYWHLhG7YrmEJF8nDXxm3exVY9rDq9c10dj/XsV0R56DQ+WAR1+TtA
	N/yUSorGYF5wxvTbU0a7r6Exq6B6TC88XVFe7uXKFEPs4+dtoYbXJbwxiy/ua90v5eJLvuk4iKS
	XM4dDRByWTFh2pY30w0KCk+N1uRxBhUI5UlyQB4Fx3tGBjLzpDTR7phHYkqKXtdq9zlhxNL2GPH
	bgrsOsadX2Gte3F5
X-Received: by 2002:a05:600c:6747:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-450d8876bd5mr68720175e9.29.1748775095924;
        Sun, 01 Jun 2025 03:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyVvW8vOUJekNf9fJWEFV8OBsS9sxAfCFyfMFebeG/spr6/CyNivjswpG1bzmxkbm+qlN2ZA==
X-Received: by 2002:a05:600c:6747:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-450d8876bd5mr68720075e9.29.1748775095516;
        Sun, 01 Jun 2025 03:51:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8012af3sm80427155e9.35.2025.06.01.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 03:51:34 -0700 (PDT)
Date: Sun, 1 Jun 2025 06:51:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
Message-ID: <20250601064917-mutt-send-email-mst@kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250531095800.160043-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: reso4op7haj1lfYP8Fd8CJSU8kZHc136NOc8DxbBo1s_1748775096
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
> 
> Add a new module parameter to allow userspace to select behavior
> between using kthread and task.
> 
> By default, this parameter is set to true (task mode). This means the
> default behavior remains unchanged by this patch.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

So modparam is here but does nothing.
This should be the last patch in the series, or squashed with 3/3.

why is this inherit_owner but ioctl is fork_owner? is there
a difference? If not
can't the name be consistent with the ioctl?  vhost_fork_owner?


> ---
>  drivers/vhost/vhost.c |  5 +++++
>  drivers/vhost/vhost.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..240ba78b1e3f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
> +bool inherit_owner_default = true;
> +module_param(inherit_owner_default, bool, 0444);
> +MODULE_PARM_DESC(inherit_owner_default,
> +		 "Set task mode as the default(default: Y)");
>  
>  enum {
>  	VHOST_MEMORY_F_LOG = 0x1,
> @@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->byte_weight = byte_weight;
>  	dev->use_worker = use_worker;
>  	dev->msg_handler = msg_handler;
> +	dev->inherit_owner = inherit_owner_default;
>  	init_waitqueue_head(&dev->wait);
>  	INIT_LIST_HEAD(&dev->read_list);
>  	INIT_LIST_HEAD(&dev->pending_list);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..c1ff4a92b925 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -176,6 +176,16 @@ struct vhost_dev {
>  	int byte_weight;
>  	struct xarray worker_xa;
>  	bool use_worker;
> +	/*
> +	 * If inherit_owner is true we use vhost_tasks to create
> +	 * the worker so all settings/limits like cgroups, NPROC,
> +	 * scheduler, etc are inherited from the owner. If false,
> +	 * we use kthreads and only attach to the same cgroups
> +	 * as the owner for compat with older kernels.
> +	 * here we use true as default value.
> +	 * The default value is set by modparam inherit_owner_default
> +	 */
> +	bool inherit_owner;
>  	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  			   struct vhost_iotlb_msg *msg);
>  };
> -- 
> 2.45.0

