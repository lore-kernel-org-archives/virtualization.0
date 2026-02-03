Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E06396B75
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110363; cv=none; b=fjge/qzRx7XqL6Xm57gwPeJW1M7NrO4dvlYXji5X3/cReGMdEmG7k7qjD90n+eiDGZmXD6Dh6IVFcm7wknoWon3zctKOF9pncKfn4Lo5Q2EghKiMXHx4maxayfjgH7Ck03t++kv4nK0W1gnPHd6JewBMuXjhtFFLNSRW6PvfYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110363; c=relaxed/simple;
	bh=JxpEZ5tbLRwPZDvaOIBEHKKckKzdOtkFQm5l5V5uiLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmGHYS5uBj0+z2XOY96IT0YORF854lCyqPBSdZh1zN69jI5WItJWWSRt9AV+3QtXzblMvKzVwWWiW2G4iepG0YccI+OV17ETRxQhK/7eBBaO0Uge3k2siQIg+/yF3AF6dQXrYv5C4wc2QwKxq1SDPIdJYRM70JHsvUAI8Ka3KkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9hdng7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9hdng7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770110360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Jpk8ObAb0wujGpkASRD1s52R/DYhqpf5NMLaAUU7Vs=;
	b=U9hdng7vFZpjZoLfYFBBZi+iBJ0tfXFJX21QX7s0KgLvhKYDjbXiLf85y+04HUVtNAUQdN
	G4/TjNmZLt+KebCrntcAI8CGicfiCvxLbIaZR7fsmHvjN02Lqs8a3DWTK1JNz+ufeONssT
	hIXhwirrRe6OrLLWa78lXwtBMYpjKII=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-7rrzPueFMaKBh8uSkyDqcw-1; Tue, 03 Feb 2026 04:19:16 -0500
X-MC-Unique: 7rrzPueFMaKBh8uSkyDqcw-1
X-Mimecast-MFC-AGG-ID: 7rrzPueFMaKBh8uSkyDqcw_1770110356
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso49236725e9.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 01:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110356; x=1770715156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Jpk8ObAb0wujGpkASRD1s52R/DYhqpf5NMLaAUU7Vs=;
        b=brsQS/uRcDazTDn/KV4H2aqt2+Ev8Fliv04wxRVBsJDtSDxZHznm6a7qkyE/PjfL0f
         kCw0K95bwv1Xuvg218hEnGVPj0vu7OqFbjeJCDhsxWVPPtDFaIcwMnAslZjOQS6CG2Tq
         kIVRWEmc5QejcuYyAJHJpZo+ZHGFsmU7ySozoihYvJawlKBH3pLwuckCS2LeO8CHYWMJ
         iaHM250klpehU1Y8c30/CM94rklyxEPMf/5gqqQMZHyCj0YS3FpF9CVRV5j7qD5J8NWD
         oOTRaWxZWKJ41IZLm0Y0zW4I6Yr9dPREF3QQbmzFtG/0aOmM58bJFP3LNsZGfm12bEKv
         +gaw==
X-Gm-Message-State: AOJu0Yw8cl517Eie+Ond4zRoAubpOGSo5V30mYyW8nMFJ8c1Px2APgPN
	oPAy9kvmu9Dfftdm0ohoWEB1tea9qibxCdYqy0MCcUMaORBR+lsl0tO/hvsG0bjO7+l4ElFdnWN
	mwLaEFXHzCT3CQpkVAcy1x7d2bsDgFT738+Jl+PdCROUUdShNlotYcMBuIRaDFuUFUAra
X-Gm-Gg: AZuq6aL+cqsr2Cj11FhQzERb7TX6ZU3/Cn4p7BjDxkreKJaHHZDT7XPvviReHVZjjJU
	9vMa6Uri9fnd45jmS0Hi6laKB7tlgkm0bGDTt9b9gdhqmIl7OAXFZ1rRwyJNe9fyl3GmS3Wn1tM
	/E/N5YLcXsPpV+hbYvzftphP3MZopNNCXGkcz1BEl+97C3SLBUxGSfTb+1UE3wgkgncJOPZS5aQ
	cgiWNhV+E+7EgvZDsbQdd9cGbeGrKpm5Wp/8b3LdJXCahyWwzy1OxWHGixwMxYn8LjY/Xod6/2v
	TXdtqGIEeMEGU2XvPBLGbOzoYDuCD4GHt2Rxagll6NELVIayEatQFpSYf/41t+KpoFLsiKOtDmO
	HczBOVqJd7vQ=
X-Received: by 2002:a05:600c:8b2f:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-482db486e65mr192394425e9.27.1770110355632;
        Tue, 03 Feb 2026 01:19:15 -0800 (PST)
X-Received: by 2002:a05:600c:8b2f:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-482db486e65mr192393995e9.27.1770110355153;
        Tue, 03 Feb 2026 01:19:15 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da6bcad7sm157523385e9.0.2026.02.03.01.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:19:14 -0800 (PST)
Message-ID: <90017867-2649-4632-8497-96e2592c73c3@redhat.com>
Date: Tue, 3 Feb 2026 10:19:10 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260202170518.9076-1-danielj@nvidia.com>
 <20260202170518.9076-8-danielj@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260202170518.9076-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kWxw250htJBYocvi3ddqEl3yGhL6FDVMNhvgxp1MZx0_1770110356
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The AI review reported a possible issue that looks valid to me.
Reporting the feedback manually because I think only one to the AI
remarks is valid, see below.

On 2/2/26 6:05 PM, Daniel Jurgens wrote:
> +static bool validate_eth_mask(const struct virtnet_ff *ff,
> +			      const struct virtio_net_ff_selector *sel,
> +			      const struct virtio_net_ff_selector *sel_cap)
> +{
> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
> +	struct ethhdr *cap, *mask;
> +	struct ethhdr zeros = {};
> +
> +	cap = (struct ethhdr *)&sel_cap->mask;
> +	mask = (struct ethhdr *)&sel->mask;

This function casts sel_cap->mask to struct ethhdr * and accesses fields
at offsets 0, 6, and 12. Shouldn't there be validation that
sel_cap->length is at least sizeof(struct ethhdr) = 14 bytes?

Looking at virtnet_ff_init() at line 6291, it only checks that
sel->length <= MAX_SEL_LEN (40 bytes) but doesn't enforce a minimum
length for the ETH selector type. If a device provides an ETH selector
capability with length < 14 bytes, won't validate_eth_mask() read beyond
the allocated mask array?
---

Note that the AI review additionally reported a possible leak on xarray,
but I think it got confused possibly because it run out of token and
mixed-up the patch context.

/P

