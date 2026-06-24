Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B63CB2FA
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330828; cv=none; b=ZxAUs/1/S15uUT6zUDGx0lCei2iz+phm4CU9VwpbDjJgsOMtq6ojc6XOQ8Da5GwdvUR2g2pJYgrC75LYt9QekKgAAZjX45vax3/YokvKj5SSoTrcB0eYgYDL6KCAGQznrEhLBE+P8Lm8yDrweRdzFVRNuyTPnD2/Fkm3AG9gwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330828; c=relaxed/simple;
	bh=0sw9vdmmHIrg289S7LBhBP3TAeh5HlhPIfC0XvwKSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tHmBNHsuYnNGKJzW4wkK7UJdzRsJrKmYNBN1yRd9N3iZqPycwp/tm+gybcjxBBnB2ibf0StVM4xFYind7Jo2weeXWShSyHfgw+goS7pt0J5kVpGVt8sv2DbsXbLKQbgG/jJTrHs8d77fQa9V2R6cUszh42l4vj9uusQS1sjVeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8WVZRMs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8WVZRMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782330825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
	b=V8WVZRMspSKhnefhPoUpqtBnZ3POvCSRgOVMjFHCc1k+uHuVZUoq7o7XA2GYAXFBYQdiCr
	FK8g+Z0W79mHAZwVIeAnGQhJ6HUhmSQNbut6jwjgZmKiebSZin9qYP9t4jyw1+XVi7oBk7
	Ma0PbMf65Ip4vuVTxboxQfSkT91yM6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ATY9E0m5Nwe0U5PLm59Hiw-1; Wed, 24 Jun 2026 15:53:43 -0400
X-MC-Unique: ATY9E0m5Nwe0U5PLm59Hiw-1
X-Mimecast-MFC-AGG-ID: ATY9E0m5Nwe0U5PLm59Hiw_1782330823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49244130073so9229825e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330822; x=1782935622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQwXPDQFNRwXTCwtbeb7bS0lb7BdO0SS5von3s4mxo4=;
        b=ezPPIB5Or3GZKj0+Gn21Mpnwl8L+KlUaHE2LXvfi92AmYWQRa/v3tQnL/NVcxLHxiT
         ORa2pXS55twOPv++AgYJk7/JPzNG1ZnS3BoV8MsdLGV7w2oipJWuzjIpTW/Zz0YxcB5j
         grtWmETBxp3LOgQbc58UqzcTvKP2MTz47iYz+1wiX4/ZF+w6JLygpoGFIM7pldfMWSQV
         WGsdJpI9Wk37+uDgvWwNGMkGA+nlg6vD7mUBHEZjE3RuxIQOOSQNuQknDtmi8XbV2+CS
         /YqA4M30F96AuQGRTQKRppnxKZt9Dw2F/Fpi8z9L0Gn84ShhwI5Px/TE14kEj3Al/+jd
         lrvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4zJtsHLewgmSO6pnRgVXjWVHXjGxSIOWxhZ0bskRwbqSKTD4uujOywJj5K4n9EUrDgstne4+YEf7axi00SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQr8gMOyL6sGaIDMcTaTOg6s932Kdee+GJvLon7JyKPLw0phu1
	WrDHQW0JF+pH9m8A1TBbQP6k/mcRxeayVw9x/mp/9ADExV48bilYkBTwTsHWFRmTiucL6QFFEPn
	LLcef9UqgFhIYRzbFmrQfkcwk4ONvzCReDK2/ONjOU1w1QnAfmTaQkdrDzFxr8HPkxLf8
X-Gm-Gg: AfdE7cnNpGPa/iEqFYUfdCcFO6KV79zDsLUAWJOy5nBuimVS1lHZwPlmbMoGsL8vRjW
	+jX4UV3dH6X8P0FHYbmVlBX0oV9nDxoo2W59RcntSA5qsbThTsyxRl7xei60vngQaSJaqLgnEWB
	QFR7QcmhSgtt8yq4NatS/22lCf94J/jS5sn+9VUaDBikFiGTLfnuDN1eY8p+cwlN4YiJJm/cGu/
	Krp5glgvstQFpv6dlpaHlktyPaBjyfatipnBXGPxZWc6BLG0wp012170d7Cm0NwaJBP7A+6BfUu
	3whtIWIHt4uMt9UHj4ykfDjzTqVklZKQQ4Br4iGqNpSF6P9VivQpABmCkzJxNkZxgch52XrB9kS
	SsjRSUSkkuP0tTcnjyLnfcsutiBi1HaG/
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134949975e9.10.1782330822570;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8716:b0:490:e196:eaee with SMTP id 5b1f17b1804b1-4925b359af6mr134949745e9.10.1782330822030;
        Wed, 24 Jun 2026 12:53:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264011d5fsm16636315e9.1.2026.06.24.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:53:41 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:53:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Message-ID: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260624190653.2893-1-alhouseenyousef@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6mcSu6kDyhUYTsAmdGAHJWK2QxVvo7bD4Lspyc20IJ4_1782330823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. If that addition wraps,
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the page-count calculation.

You should add "on 32 bit systems" - I do not see how it can
overflow on 64 bit.

> Also make the
> memlock check subtraction-based so a large page count cannot wrap the
> pinned page total.

I don't see how this can happen at all - pinned_vm is in units of pages.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/vhost/vdpa.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..090cb8693 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
> +	u64 pinned_vm;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
>  
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	mmap_read_lock(dev->mm);
>  
>  	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> +	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> +	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> -- 
> 2.54.0

