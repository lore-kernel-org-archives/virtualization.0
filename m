Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80020D51C
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329019; cv=none; b=uuxTyRfKl29iVsqvnG1tSPVg4tpqonkTQP3jNKJgS2b9gXcNmXZjlTosBEFo6npWYkuxcaMb5RziA/wLGKLUCN1q5tppzHroQATLMKRkSsRjgqJnugPL7BMx1QFXS2S58e7AJ8q6/HywGg7CAiICSKfEnrqOocSoShy+7YUWL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329019; c=relaxed/simple;
	bh=qqYnk5XrxGLzZLkCL3wTaRUPbFdR2fhEIlck66k8r7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pEGZxKGzeJ1FLRznHLsb44ggZJONHJ4IxlvVFhXyw8hZ0MBekqvLZ514JDIJ8zuecjLVaKq/AHvgYO7fFzmnJQSVfswwNCHtSP6EiNYNQyb+roUprpf63MdBEJ4hSTdHXAm3T7D31yFePGKsSVfi4wMe9JAYGzBeh/GOr8DMiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNw4zZ1W; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNw4zZ1W"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ECEB80C9D
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJbJN_6swfH5 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Apr 2025 13:36:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BEB5E80C98
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEB5E80C98
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NNw4zZ1W
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEB5E80C98
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUewcCAfKjSAtX3UJYdMN8CFjSRLSUT1k8cvjFFQcBY=;
	b=NNw4zZ1WDsOuXerDn686nQxsfQC5xB41kZngCXF3Dh14FaauZxzzLBklMjeVeIq/7+Q52x
	WdW92oQ01qpuxYKcYyYc0Qa63HFiE4V56kunIoxa5JL7iegWtXfS9eBYFo4zTFz1xeaqV5
	CxkJN3bK1DBwPDIHirkttvZQG4Ekpio=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mwQHDljiOi-VZWpiv6L5OQ-1; Tue, 22 Apr 2025 09:36:53 -0400
X-MC-Unique: mwQHDljiOi-VZWpiv6L5OQ-1
X-Mimecast-MFC-AGG-ID: mwQHDljiOi-VZWpiv6L5OQ_1745329012
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5f63ee41315so2324534a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329012; x=1745933812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUewcCAfKjSAtX3UJYdMN8CFjSRLSUT1k8cvjFFQcBY=;
        b=e8N5eEvdeMPj7sZgkJv+vmYoD/+Jqizga3pTI8sCTbIVWLpS2sWR1gocf1lkx7qfgi
         y16vrQ9CLyJYefhpOTJvlWGfzj1DULk35MizX9njZYYmACAgEFSx1dOpcm7qaIRbkKgh
         Mj6DnES0CvkMFHtArwZruNsg5PJrxTlJZwOmO9D98RQiASxTVFlIfCjNiUf9nmY4cKFS
         luTy3oQ9IHdw1VUI7LcK+bYw9a9cX72bsf3KHOuxAHs44TG7DYGfOlv9KV/9pPbRv4pt
         wpIYUSK4li4nSKcQ3xKLA2hgCtmeRxWegPXUnUI9SCByI1Go2KtvPZAadbHc5cR0SJ8Z
         jEnw==
X-Forwarded-Encrypted: i=1; AJvYcCUtBzk5q8UTiB00jwoK2R0RFUptPu5GzjfCn3N0S0Av50HrfZwE3+RzWwXY2Diq4Xjmoi9lT1j/lqBGI2xpqg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyHFox88ScPsrc5wyUpl6G3OqMaCZy+4ZVI1CmujMu0H5TnTzQz
	XBl/Ib0pgGqezvyxfoEJUR04AUzR/DEIgJK7QhKNAq/FSzSdMg9bVfDhA0CD/vfeZoNBWgfSQxw
	wqWqLR4S8EzThnxIFbYg4PpTjfDM9C4scAl8oTiD23lga6fMjIe/j/6x6YE0mipRQH2cWgFtRgw
	Vt7fE=
X-Gm-Gg: ASbGncsjs89mfm3nFdp5nu1en1FxT5YZ4ucqtsuxNw4AGE5lNg1hm/xjO2Fa8vsNxOq
	aZl+iSpo3SnIr7A9KrvA1K8MKQ6as8BZlYKNnmPXScoKkbLsdGiMEBzPIYG3HaGRrryyLjaGj1h
	Q15qinE9kz1Zqr6+UzZUprG0mfsTdi+FQ9VNzNKP235Q5ctD1aIGLuNzmjvH+Jm2lGV2tpRXLwC
	xBhm0LjNcjAd5bkErp2KH8lpSIFRk8RRTs74kdgut25f5TN0RdI8d/nAteA2Dlf8EX4PQxxXT+d
	LVrsc3oJ06xwu4x5
X-Received: by 2002:a05:6402:274f:b0:5f4:c499:5508 with SMTP id 4fb4d7f45d1cf-5f628535a3amr11578545a12.9.1745329011720;
        Tue, 22 Apr 2025 06:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLWfcUfsxB2IzKkKV/CizBO05VIu+DXGm+L8+NKFCuGMypvZbpTLcet5RlzVieCOKekjSNxQ==
X-Received: by 2002:a05:6402:274f:b0:5f4:c499:5508 with SMTP id 4fb4d7f45d1cf-5f628535a3amr11578522a12.9.1745329011142;
        Tue, 22 Apr 2025 06:36:51 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a4aed3sm5887654a12.80.2025.04.22.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:36:50 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:36:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 1/4] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <feelu5lubmz3syms5nkjnzdzoygwnbnldms3hzbhkenpu3s4k6@xwzjct2xo6hq>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250421024457.112163-2-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: geJT-jNPSaoNAMMUH2-vtoOG5tZ44omItKztWiG0toE_1745329012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Apr 21, 2025 at 10:44:07AM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles, it confuses some
>legacy userspace applications, therefore, we are reintroducing kthread
>API support.
>
>Introduce a new parameter to enable users to choose between kthread and
>task mode.
>
>By default, this parameter is set to true, so the default behavior
>remains unchanged by this patch.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 9 +++++++++
> 2 files changed, 10 insertions(+)

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

