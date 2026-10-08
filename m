Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3A440638
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457151; cv=none; b=V1/9KKvN+CMjIRgZsY+J7TLLLGDa6lfkCWNMkWKJX5G8dXXwFWhb0fr9HZijsDSAzVk+g+bApq53noOg58UMcHRNsmM+aUCK0pEqHUvDWn3gZo9dAlurLZO7qxaPpGvsuKEU+ypX5oXsS96s43xFwj0ho0ypbe+3f1sy646zj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457151; c=relaxed/simple;
	bh=17qHtIw5UKhPTHhMl1c2dvvqvuwGDSK8zXNTm5NtwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EXBoQYWcJ8uoa0lXhjakp4Yt9EIuSqDTRMr/ZPTvjrpcLq5GXCqlaLBujsxizElzeSP3us4zQI2jZc4C2um+JtiznLbvV7343HpCfF1nqQwmnn69RWGp1OTB4QyIL23iBOYg73TuHVJm00MUVsXvGCb+LNpW4Ywzc5tLn5zHJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGQgyeC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGQgyeC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791457147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hb7lEf0ZKCP7EacVDyTHRHEN0Yn5+Gv2o8OJ+Cnr4DQ=;
	b=DGQgyeC13hEw6BTscSe9oAG6PBcGxpqNUTT1clQxCkwyAEaFer90taCtXE7KYFEH0+9FcA
	egSOnTLLAyU++A4c5xDZJge5GS7RIF8FZkbPrCy0iT7mjX90Ajbx157pMoVdv5J/JZM6p3
	mzDEssBi/LkiIOkDx+D6Gxvc+W4OABU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-BxEMwvpKOBy-_E-VNx5PNQ-1; Thu, 8 Oct 2026 10:59:06 +0000
X-MC-Unique: BxEMwvpKOBy-_E-VNx5PNQ-1
X-Mimecast-MFC-AGG-ID: BxEMwvpKOBy-_E-VNx5PNQ_1791457145
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so68818965e9.1
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 03:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457145; x=1792061945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hb7lEf0ZKCP7EacVDyTHRHEN0Yn5+Gv2o8OJ+Cnr4DQ=;
        b=2o5EtWMVE/2OIIhPJ9s85P/za80xApVI8PS2e1K8aEzOmJ93N5vqoq84Q/dHvZh26i
         HPRsKt244TBJBbkNK4aQO2a5oouxPhlnkrhWRHjq5jkr+Cbtzw0wuxC1LEadjn2Hz1cU
         lJCMaqPOEC1BvZBD+KgKgzEXD3n5QShsbwBYxl1YX3ga6cCx+6uVBc+ywdzXRMIgDCBI
         fl9zlzt6MAl5uZ/H+X3+2fJh71QFLcg22a3FhLPuWuUEko05uBmJMx7QG56AJjp2tYg4
         C0yCNZZYRQgKGKcSMhgs1Lt2FS8i/wBlxlI540Uf6gX/54CrZlqohKHxwZTBhsEYnJk6
         Cxhg==
X-Forwarded-Encrypted: i=1; AKwUvBwWV6irrdNGbuSZIOrfodPYzoDdf9XWPGkmCTOZUTDZzn+5+jvlHh/FIO1AIZP6BeekCF7xL2522smPMMocIw==@lists.linux.dev
X-Gm-Message-State: AFuF++mG4JBj+XNvlKdQVfdllP9vJS8kdglc4q5e9p+MZlAL++C1PArS
	QHbzYs/bflmV8ZNxvziGxPrBRmhW3e1MR/bfqJ0fCqOMxoj3W+bFRv+ghZ8PYt7UFqQBQyJoxu2
	D9RH2CtD59kMsYYSRDX6vjoc5Rckkq5ETtOQnEhfP0nci4AMg4o/UkQvuKdyV2FjucxJfTURYgy
	8M
X-Gm-Gg: AYBFou2mbd8H7fBRkraMUxbs8g1o2gcCCsBQ6fyZAI6sHvHhUj3XclFDesE2PJziDNk
	C1/+WwMRvfEaBnuD7MKWTasJTQZNvNLr6HMp146MgJBQqwtd0u6N9U1YY7Txp6GdbZAM+AqzbO3
	AZudFQATnilzO9X7z5M4Py6TOww6oV5QpeeTx48yajDztdehyuCefUkETWwYUQq8yBwF1iMWghm
	Mv6oZzG7gDoY0iqtqugTKSUcvAlnrAH0S5dj0lloY9BCtXPd0gz2//WJBnfAex6+c0vgYDto26t
	yuzUKBheCq7vlgxO7EAYFhSJJr+KQwUBFXxwWsgzpEkKi1P1O+naeQJ08uhSEb2UftBGZMM=
X-Received: by 2002:a05:600c:6097:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a18064cf5bmr83954315e9.22.1791457144689;
        Thu, 08 Oct 2026 03:59:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6097:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a18064cf5bmr83954015e9.22.1791457144185;
        Thu, 08 Oct 2026 03:59:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843d8997sm69177015e9.10.2026.10.08.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:59:03 -0700 (PDT)
Date: Thu, 8 Oct 2026 06:59:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH] iommu/virtio: bound the probe-property walk to the probe
 buffer
Message-ID: <20261008065310-mutt-send-email-mst@kernel.org>
References: <20261008094240.1082031-1-yhlee@isslab.korea.ac.kr>
 <sashiko-outbox-163970@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-163970@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7n2-VaGxKULwbP0hYW13R-vwzkcoW1AXjPRSa1BIPn0_1791457145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 08, 2026 at 09:56:03AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] iommu/virtio: unaligned 64-bit access due to unvalidated property length
> --
> 
> commit 1966676bc77a49f0f207bc2272bebf67d2bd8f06
> Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> 
> iommu/virtio: bound the probe-property walk to the probe buffer
> 
> This commit prevents an out-of-bounds read in viommu_probe_endpoint() by
> checking if the property fits within the probe allocation before
> dereferencing it. It also moves the length check in viommu_add_resv_mem()
> ahead of the memory accesses to avoid reading past the end of the
> allocation.
> 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 587fc13197f12..dbc997a6e3568 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -489,6 +489,9 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  	struct iommu_resv_region *region = NULL, *next;
> >  	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >  
> > +	if (len < sizeof(*mem))
> > +		return -EINVAL;
> > +
> >  	start = start64 = le64_to_cpu(mem->start);
> >  	end = end64 = le64_to_cpu(mem->end);
> 
> [Severity: High]
> If a buggy or malicious device supplies an unaligned property length earlier
> in the parsing loop, could the mem pointer passed to viommu_add_resv_mem()
> be unaligned?
> 
> Because the virtio_iommu_probe_resv_mem structure is not packed, the
> compiler assumes natural alignment. On architectures with strict alignment
> requirements (such as ARM or SPARC), wouldn't these direct 64-bit
> dereferences via le64_to_cpu() trigger a hardware alignment fault and lead
> to a kernel panic?
> 
> [ ... ]
> 
> > @@ -563,8 +564,10 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >  	type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
> >  
> >  	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> > -	       cur < viommu->probe_size) {
> > +	       cur + sizeof(*prop) <= viommu->probe_size) {
> >  		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > +		if (len > viommu->probe_size - cur)
> > +			break;
> 
> [Severity: High]
> The virtio-iommu specification requires property lengths to be 8-byte
> aligned,

Does it? Where in the spec?

> but this length validation does not enforce alignment.

it really shouldn't since it's not in the spec.

> Can an unaligned property length from the untrusted device advance the cur
> offset incorrectly?
> 
> viommu_probe_endpoint()
>     ...
>     cur += len;
> 
> Wouldn't this cause subsequent property structures to be mapped to unaligned
> memory addresses?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008094240.1082031-1-yhlee@isslab.korea.ac.kr?part=1


Indeed, it would be cleaner to use unaligned APIs, or memcpy the
structure. Pre-existing and not part of this patch.

-- 
MST

