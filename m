Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5E137923
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514229; cv=none; b=L9v0bYPnNzY/PLxpxuuSz2ID8AcCQZUyDoXkaazEerNTetV9U76yHjRSa3+maor3UpDCHjIKH8nr4250U1LVlQ0CyLJSef6EHbqR7sOI8UoqfhQK8+L4GNfPUMHvc8zI9h38Lzmr9doEXZYTlD36C7zkG1Mkok4K9eFCMXcoHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514229; c=relaxed/simple;
	bh=xaI867HGHR4T8sG8WY/K4UFRf2cdS9W4OArVVIu7Kpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aHv8Biz23S7ogJwOCnNJcC9VcG28YGjF/ItY5ZK+UxkZqv+2722n6Ur63mlM7KTs84s9njYrvaJczG4zzXdd/YHpPU2teM8qQBoQdV7oo6JZS7R7l3P5cnXm44FWg+hCkNsvcQARrZltM+Ucu+y1Zl7xkTClfS8KUF9uHdD1Z3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPyEaacq; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPyEaacq"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 059C240370
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r82VUFi3nl9z for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:30:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 458A840361
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 458A840361
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hPyEaacq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 458A840361
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GD6tHabuLwNG81tJKtS1hzWrYbj0F2aL9q0asRKe8YM=;
	b=hPyEaacqyRuX9+kg8znm2zNq4vFe7a0JlGD1pOjowevFrKGj8aIHC1iTsjQY2Q+lD8KoPX
	RhMCGsgD8QtxWWtd9d1EPAWNhXnhtxfcsqTRdpJifpJNdmkvzK2pvP4GlB3uRgmammEm7T
	vAatITlG8hq2bFfW/4Rgjgme+klTyak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-RH27AKeDPhCkMxSCJ51oCw-1; Tue, 01 Apr 2025 09:30:24 -0400
X-MC-Unique: RH27AKeDPhCkMxSCJ51oCw-1
X-Mimecast-MFC-AGG-ID: RH27AKeDPhCkMxSCJ51oCw_1743514223
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913aea90b4so2290159f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514223; x=1744119023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD6tHabuLwNG81tJKtS1hzWrYbj0F2aL9q0asRKe8YM=;
        b=ubTKplUHGhTfjsHO2GdPVLmjh4HgwfOTAzO7QKk+jcGG+Wn4lrho0SoMCH+NJ+s7qh
         Q9vGjypK/hkJlT9nfcUj699QLiXlZpUY5YhBlGFbk+Ax1DwPyUC0/0vqLVseRKEHFGnN
         rijmIN2SJLlgLoaO2mRG+u9IAA8Z4YK1uwZOMYNnemerUq0DCTOio8XxevQ1H9jfJQRX
         /wo4RmGxbnSJMDnxTnS/HPoDukZVLGgkrQ1Iw4/4FuZk/DcCbQTzLm2BaJeUIgRveyBO
         HWghAO1aRJNk8XH4+LjAwpnvZQZIDwqBzkOZbCNKEeMGeivQPIo+4z/h7E9wgqzBqKaH
         bMcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0NaAzZHVWwJy3Ej/nIv+OCjtXZd3gUChQVQuZR53zm/p/GI+Hpgijx7wysTSbVw+tNTEQQWNaHpvwZGTWYg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyDG/l4KIILvh3RmF3q2hq6Vq89jg+oXzllStwcwS5kEl9xk0Tg
	4l+SXok8PFdnMB2t98hqVGPVzxddY3tNoAPZn8gkMWbQi6DWC7C0dBvdPXN4vOe7AaYUkWnSkV2
	2C04gNRKIWMFC6icR/P6HwUbhkcY2VGwp1wyr/LxybPXVNn/JU049v0rsdnuTYw3X627MsoKfzY
	peELg=
X-Gm-Gg: ASbGnctsnyb0NlpWClwRc51iQFmZHPxk/gP1dIMQ+25TiHJz+/PaUf+sFZsoFIPf4WP
	9xS/Hi/OgJWZ6EAIvL9vikM0LD1cayruQUadOGv7zEll/CNpDKPobp39FGbX77iYjTe0PgYGJYr
	a7VEDr1msVVGyzo5zv6L6uYFce1dJ73XesqiNn87+RV6dRFGjgRm7nWERrjUHAWer+d/BOqCecD
	eJai83WBOPGNdp4A42nqS8uYCpz1SgcTKIyDdQYBOwRgoBjLvjVMF9qihvCqnkL42EvuEy7SK1W
	43FspZga14/O37HBeu9xzX5Ymw7kGiJ436AS33yNsvOCeVbjmWVjsXt0c4w=
X-Received: by 2002:a05:6000:1787:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39c120cca84mr10705798f8f.1.1743514223441;
        Tue, 01 Apr 2025 06:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrXMI4ItLJvlB6UQ12DShg3B37MVyGcSOysd3SaKEAZoFNB9cLMEIrsOQAU4HBuVM/YXR7Q==
X-Received: by 2002:a05:6000:1787:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39c120cca84mr10705740f8f.1.1743514222825;
        Tue, 01 Apr 2025 06:30:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm13928073f8f.7.2025.04.01.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:30:22 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:30:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <74u5ppfmuf4gwjup3eotpnd6bulocerdk4l54qvykfcnesf6hm@udabnuiw2v6y>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sOsaiKN7wjptq17FWjLdN5F-rmEd8aRZZqvUtV3p674_1743514223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:45PM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles,it confuses some legacy

nit: missing space "principles,it"

>userspace app, Therefore, we are reintroducing kthread API support.

nit: "userspace app, Therefore" -> "userspace app. Therefore"

>
>Introduce a new parameter to enable users to choose between
>kthread and task mode.

I would explain that by default this is true, and so we are not changing 
the behavior with this patch.

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 9 +++++++++
> 2 files changed, 10 insertions(+)

Anyway, the patch LGTM with or without the commit tweaks:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 63612faeab72..250dc43f1786 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->byte_weight = byte_weight;
> 	dev->use_worker = use_worker;
> 	dev->msg_handler = msg_handler;
>+	dev->inherit_owner = true;
> 	init_waitqueue_head(&dev->wait);
> 	INIT_LIST_HEAD(&dev->read_list);
> 	INIT_LIST_HEAD(&dev->pending_list);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index bb75a292d50c..19bb94922a0e 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,15 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	/*
>+	 * If inherit_owner is true we use vhost_tasks to create
>+	 * the worker so all settings/limits like cgroups, NPROC,
>+	 * scheduler, etc are inherited from the owner. If false,
>+	 * we use kthreads and only attach to the same cgroups
>+	 * as the owner for compat with older kernels.
>+	 * here we use true as default value
>+	 */
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>

