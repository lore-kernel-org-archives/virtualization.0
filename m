Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B001E4AB
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289422; cv=none; b=ndunyIXzoeSbRbiHkNO+dwyOlDz0bCi1CZxuSDgYWA4kMaGFg96x63vAEG2Kr16UNsGfN2Hfe7GtuD4A27ckY0zC9Buze3W40tH1UieOsxXNeD4SsUR9EwTwDQAUxvzueLq1OGDIhbT6vmq/eml6qi516ZcVe5suqVR7ipBflEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289422; c=relaxed/simple;
	bh=s0jNNTCFNE3uPdMhFoPhUG0485jwxbZ2R+RoOksHx5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YCHITYsFTxKnV2B2IflF2Sqt7Z5p9rHzR5eaBcEA8yV93OKAtWDG2hoT4ddKYmPPnf6qBM+o4e9g/PFbMJPPKKVNqafLLNojcuVIVlezWG8KrMAsXYOYSNKu1lpEqKvYVvQf1T2ttOoMUn3lqGBs4sGorh2tAJAhhlTlp7FOGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qdj9iDRW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qdj9iDRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768289420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiNF2ZRVVEZ6E26LXjvC+Q546JUw1TsWOthVS73LBBw=;
	b=Qdj9iDRW/aKsBw8HNwtOi6AwCXw7WHpqkg+dBNikh8wWHRipd8vpixoovry3WS0zGmwDvj
	Y2Wc4uTIYAs336Y/BcxdV0Y2jn6FWHE56Aj3zcPNAne0RT7nMFXndEFB7abfwlOAWwYVjS
	Nj5EpbTlZJpT2ZopF6IfD1ZDMpxrUJo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-RJX5HlDTMuyXJvITKhzv7g-1; Tue, 13 Jan 2026 02:30:19 -0500
X-MC-Unique: RJX5HlDTMuyXJvITKhzv7g-1
X-Mimecast-MFC-AGG-ID: RJX5HlDTMuyXJvITKhzv7g_1768289418
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so66193365e9.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 23:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289418; x=1768894218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiNF2ZRVVEZ6E26LXjvC+Q546JUw1TsWOthVS73LBBw=;
        b=NckeS3XChCmG5mGYkVcbRTJfWgZcqcRNbfrrbzh6GW3k43yJqs9UHJJa8pmyyaOxdG
         CnuJqUKbEep9AtiZEIVKUugcAmP3XzSthqRR1DJPFYEKznzuvZQjIPDm544SrtX4iaKe
         2RiSgzXZ8/MTjsQ5LIdTC8C4oMAUFL1JqbPZvYhtw5+DzmGTfP7aEtNBr98bUoxnrEuf
         MDjOnuCzguViAoQB53qyV7t2NmsFmHa7BsOm8NwwOIcE4CYFTQnDK0I6zumBISlFnvMj
         cEq2j0Ii39B0zTr2jyaiEWTGQEyplbsZs6ABmgtAcfFvqaqng2ul0bInQ/B0fcgimIeo
         XJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD2rb9AUU5kV77/TlbZ1pUfpCIsbmhDHujack5ZJOuD7HesKjJgd19j1WiChP9Cgl86QNrE2yNAQ25uwH0TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY22AUC+TwIGe2DuYRtBonu7lWvIeeev5euonRryiXNk3NqdEo
	lvOfpRZHnVI8prlAUhB8amY1QeCV+dEOPsth4M1Rgexz3QSvQvdwYeLzKmvAxZRerWho7NKz90M
	tEogSyghQhqBa4IxbSOT1tZevjaXWLavr0kCYtvVjr6glpE84mb9niGqc0+NWiJe39QOg
X-Gm-Gg: AY/fxX7csNOZQ3vZOJCLShQVJZ5f5zoQOas88TVafFiBRjSRkiJRblMbehecs4FDLQ9
	uZf/VVtFql8LWDRizVWWcqIc1Gvp6p5hi80Qh5WHyHhwAZewfxclxmDGdtlQ7724SGZdCqdYYd9
	v07PGQ6iWvX4drvop+rfi46VRQ4Eimbj4ocRkOdY8WcmyA0T4usBGLBdWYtUi/6Ee5kHQRuIfpx
	BZq5wnpduKOrT6s6+oVbaqF1DvkPa9DzV8cuKmaoX21Ef9lN1vGUC8jd3rVgulgC58YIe8Cuhv2
	WBIyVHups0ED1Un7+T8QckGozSAqJbP8vLNNQkCZFd1UHL6QOKOGRhO2HYzoTMq6EJ65wPGWm1K
	SYjmUoY5HiE6dQJwaS9noVnssQI22qhc=
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr147932055e9.25.1768289417462;
        Mon, 12 Jan 2026 23:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ7vVe0350H0JVYXQsiMlO2kPVRC9RBhfa40QZOD1BpNkmOPxCYFtpzNzUhbsBf042icJ1Ug==
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr147931635e9.25.1768289417019;
        Mon, 12 Jan 2026 23:30:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm387228755e9.11.2026.01.12.23.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 23:30:16 -0800 (PST)
Date: Tue, 13 Jan 2026 02:30:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	eperezma@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
	jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com,
	dtatulea@nvidia.com, jgg@nvidia.com
Subject: Re: [PATCH] vhost: fix caching attributes of MMIO regions by setting
 them explicitly
Message-ID: <20260113022538-mutt-send-email-mst@kernel.org>
References: <20260102065703.656255-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260102065703.656255-1-kshankar@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zAmdSiI8_9exs-R7HJM-Cx2LIgnXq-DEY8rwjWGVzgw_1768289418
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 12:27:03PM +0530, Kommula Shiva Shankar wrote:
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
> 
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.

device memory in question is the VQ kick, yes?
So if it is cached, the kick can get delayed, but how
is this causing "invalid read and write issues"?
What is read/written exactly?

> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I also worry a bit about regressing on other hardware.
Cc nvidia guys.


> ---
> Originally sent to net-next, now redirected to vhost tree
> per Jason Wang's suggestion. 
> 
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 05a481e4c385..b0179e8567ab 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1527,6 +1527,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (vma->vm_end - vma->vm_start != notify.size)
>  		return -ENOTSUPP;
>  
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
> -- 
> 2.48.1

