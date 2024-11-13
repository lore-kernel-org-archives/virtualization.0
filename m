Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1F18C01F
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731540509; cv=none; b=rwz14gfoVn4ThU2b7QMhJsUdTLpRRVlCVow9T9MOZhOjMdloSVfQST2O+qkxD14PFCp7YXuuko4wKFj2OhB7F+s2roxk4W3kHuWwXqqf8ACuvGdE/kxDNlybVg6MnDRqC0tvX32wv9qeJpr3rFcYqBkv/+mIMCXK8o9E2euGZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731540509; c=relaxed/simple;
	bh=YjU9s9ZaDbxHYGeaV2C6N8/SfLJnNYOE0SEesrqDb04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g32h2RiuPHzckp0qYUigGp2IoObmwvnVn12JW9Sd7QsWW7EOaLoJ2F5qDF5NK594nsiq47P4/UihZI8Eor3C5dzRI3pnzqFLWYC1e0cHC7lA+I+sAWIJ/yh4S68zNMBXD0WaWA9iVoaO/F4jYbCp8RcOlc+qWw7cxOUGoeQJ0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtYPUXVZ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtYPUXVZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 065AA4028D
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 23:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fOmuRZOJHNP for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Nov 2024 23:28:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E73A4400C7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E73A4400C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OtYPUXVZ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E73A4400C7
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 23:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731540503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CByKMOgU0eVBz2mkNWqRqmAJAX+dEHJdylhbZFnmBaU=;
	b=OtYPUXVZNSXA3hHJYAzRy53gGVd39Iq8Moyk8mAzsfvPFD8Fm0P1ZnXqjWk5/Rxs8vCjGi
	mW8h1aa5Px6HD0GpFts/z5PrlgY68nbMBEiCW90TkoOGSbjgX3Sz6p3bvZQq9kSj+NPVjd
	Vfes/Ia6kykDiJugG+0Rgv7Rtydc6RE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-zQ5HWaQTPd6XxaCVRnI_4g-1; Wed, 13 Nov 2024 18:28:22 -0500
X-MC-Unique: zQ5HWaQTPd6XxaCVRnI_4g-1
X-Mimecast-MFC-AGG-ID: zQ5HWaQTPd6XxaCVRnI_4g
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a71d04b04cso18365ab.1
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Nov 2024 15:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731540502; x=1732145302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CByKMOgU0eVBz2mkNWqRqmAJAX+dEHJdylhbZFnmBaU=;
        b=KGN/UhDAeffoGV8J8kYAfF8MW6jpv6pck3uIMmZCngfxDBEwCir+n+5xAnO+od0tl8
         ++UAX4LL7u4i54Ye42CfXCaKH1GVEpbO2jOkOC1g690dtK/IjWlG2wRbD56RISBtNEgP
         sn00EC+rQgq2VYh4H7ZHi+EDOwMbiXgoPHKN9W4kJvRB7oHEVdr3qw621SEEqtRPTPIS
         jPtJvLskfhyBlAyha4gjRdhMxKJxphAcgfP30oUEQUBOxWrhkhO3T620bV+n4P6CEQju
         nwajs1REpzOL7yg2cLpa3B0+lx63JXqMlBuBBkA0fwWe4JVjhg7AXWXx9CHa4gwc5Koo
         w9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOsZtuQI4hMyxIItl2uq+LF9do1/rAxAjQJBXaZoAVc95AVOMat6VT5rjAbDslZuPlkZ4nHqKNa43FqGj21Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyFtdM08PkXQ35+ApaWUd2O7FeDmNy2sVkvrR7JuagWVqrL36RM
	YvD9lcCjRX09jUP1hbRjeYBecCmak+u5iGVsocUn6dhQn3c2Ob86mnxk5e7lhGrVHMaj2E8rMKa
	tv++4Ov/AayWXoPs8PS4IKsSeKtivKuBeVOwSsJqpVJqud51gILx3IxXykkK/qIe6dXlQdGq4QO
	CFXPI=
X-Gm-Gg: ASbGncvQfLh2ErPPFCTOoNJhbShrPECxKMpdsDJNMqcqfUAWFv2c80fh9jDqDJs0f/8
	Hew4X/znH5yHimdzJqpJS0NURevpIAo5ChMVz4Fkj64hL0Wg2NDpSKBWxDFMBN9ooWguo73jCiy
	WxabA6RHKOJOJFPlsbumFRlcvaCKmj8gLtK8lH0SWytLedimB3gS8IbBhle6Gf03GsmSey8HpOU
	0JGkclG6djhwKXZB22K9I73UVpVKTWIaTkZzjZofOSYo3pw/72GSQ==
X-Received: by 2002:a05:6602:1355:b0:82a:249e:bdfd with SMTP id ca18e2360f4ac-83e0336c2d5mr666722439f.3.1731540501881;
        Wed, 13 Nov 2024 15:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQTrkqTWB+qDVFYGCr8R0nJM12ERLnPB/kUAvT+bqN4as4eTVubwQThRFN253QDhFxM2PlMw==
X-Received: by 2002:a05:6602:1355:b0:82a:249e:bdfd with SMTP id ca18e2360f4ac-83e0336c2d5mr666720939f.3.1731540501430;
        Wed, 13 Nov 2024 15:28:21 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4deacf3013dsm1296353173.122.2024.11.13.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:28:20 -0800 (PST)
Date: Wed, 13 Nov 2024 16:28:19 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V4 vfio 5/7] vfio/virtio: Add support for the basic live
 migration functionality
Message-ID: <20241113162819.698fd35a.alex.williamson@redhat.com>
In-Reply-To: <20241113115200.209269-6-yishaih@nvidia.com>
References: <20241113115200.209269-1-yishaih@nvidia.com>
	<20241113115200.209269-6-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5InRhResGXu2EgQrJP7iE7hLFTZVK6IEep7KL1D1gY_1731540502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 13:51:58 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> new file mode 100644
> index 000000000000..a0ce3ec2c734
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/migrate.c
...
> +static int virtiovf_add_migration_pages(struct virtiovf_data_buffer *buf,
> +					unsigned int npages)
> +{
> +	unsigned int to_alloc = npages;
> +	struct page **page_list;
> +	unsigned long filled;
> +	unsigned int to_fill;
> +	int ret;
> +	int i;
> +
> +	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
> +	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);

checkpatch spots the following:

WARNING: Prefer kvcalloc over kvzalloc with multiply
#416: FILE: drivers/vfio/pci/virtio/migrate.c:71:
+	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);


With your approval I'll update with the following on commit:

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index a0ce3ec2c734..4fdf6ca17a3a 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -68,7 +68,7 @@ static int virtiovf_add_migration_pages(struct virtiovf_data_buffer *buf,
 	int i;
 
 	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
-	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
+	page_list = kvcalloc(to_fill, sizeof(*page_list), GFP_KERNEL_ACCOUNT);
 	if (!page_list)
 		return -ENOMEM;
 
Thanks,
Alex

