Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B125782A
	for <virtualization@lists.linux.dev>; Sun,  7 Jun 2026 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780799017; cv=none; b=uGEQsCYXJPddUxYxGPkxbe82pNuue3MZC+YQhnB1/kl5yicq7v4rW1OcjoURxtUWmk2+EY/qo1guokVT5vmMssCA8uM7Dq/voiOOZtdwFqr15h4hz9GfEmncspxSa2hBRNoBxse3jlH5GUu5jZfVTzAhqFc1VczU444axCle9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780799017; c=relaxed/simple;
	bh=saswmV1voX+J31K8+1YYxt1/oMBSX7yd+TmMmd4PTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g8x+4Sdjo+bUZlkl7R7skVlZqNkodebYGIA7LV2lPqXwJtb90C1wIl25dE5llO1+2U4Cj7uBxSTBlb3lru5YM9C27iQbann/2ZMsN1ufvOkwJwAPqrxyIN4lb+q6Aks9KxpAe3zUm+tONIXTDemDtSlLLqzXhRLhynG0JBcZWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7Mzs1cT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7Mzs1cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780799015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkOun8GEXS2QG9yZ2UAlUL4A5OCbW95isM2TUiOZFI0=;
	b=i7Mzs1cToVwQOGP4UUnlUPzKzM5gn2nYmVaSCtreFqSgZO2rVEtkulOqDcXr7XcZ/gdhVd
	e5PIj37Xhtmv9gSZ2LVbSD9yD2gMlY7mPeOWBy84wQtl1hswC7f0feKk6LLusWRaVK8+Mi
	lp5FU77B6nQiSKKngaAVsq5S6LbjRiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-rgtwCv8NM4CsYH_Db-C1tQ-1; Sat, 06 Jun 2026 22:23:31 -0400
X-MC-Unique: rgtwCv8NM4CsYH_Db-C1tQ-1
X-Mimecast-MFC-AGG-ID: rgtwCv8NM4CsYH_Db-C1tQ_1780799010
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-460153ce644so2212017f8f.0
        for <virtualization@lists.linux.dev>; Sat, 06 Jun 2026 19:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780799010; x=1781403810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkOun8GEXS2QG9yZ2UAlUL4A5OCbW95isM2TUiOZFI0=;
        b=eVX6Cit2xiksTMhceqM/ESfGex7luXK5VOuVO51Afk1pvGe3bH2+FGX4Z6RUo2xSoG
         iCvAXF8CV72LLY/dziN/YC8aIx5FAmcc8eudRjtgVY2Ss7fWA/D283snqMuiPqeeXmiF
         rBcH8bwHYjPCF1dFK5mcXXTJWINdH7k58R9QM9Wx3LS/WQRDGFezt/7akXWeGqmwKk8N
         T+4r4M5ZIJ6j/QS2l8GIPRKll5AFi9spbpui9rTR2m4rSf8mxA8yEfzvwEaCW32Tt8PE
         Sf+p2X727CZhgCwXLICMWYrjkH+ci3lDJqmRfwqteX3mJ69oMCz7QmUZIOIKR1+IT2IZ
         kRMw==
X-Forwarded-Encrypted: i=1; AFNElJ8HDJI3oAWs6qPUjxmIaUdFE/knbgqsdbjAKQjCZuc9aj6Hq1yvK9OZv8nrY7RrG5d8Y+saFFRppEvFFZoN5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVUDeU88tVIQYMkkvyf+JmFdxMxyEnUi3M7Xsp8z5p3wQ9LcLk
	rUcfXNxYImTYgQuawNK8hd0v0wZu2kTOwIXbvhUYosfrAe/iSBXE1JL+Z0spVwZCJILzPBnkcL8
	4DBiPBopqqBRIWVaQrDPnPH0yhCOzuuYAGjPesfgDDXH1i6KRj5j+HVkgL0YyfJHGcNMq
X-Gm-Gg: Acq92OGB+jYXJ0hSYWPdYc3jguWKHD1B0SS57nWVyZhFvd9q2KYHVQ9Lh60fPmmbySX
	1+t5jd2BdjblP4VdDqALm0zu/V6QPzejeniJwBIUm/d3/5QbzZUEDRRSEA+mntYyzi+vUORZgVa
	7AqWZQpB3D+Ffizygs1p6PWm51EXcmV1z/CUmxiJJbWMJoyDNR7US1VWmXhhq+l3HSf3haKScHs
	nDg/wZ8Hy8NtcO6/18Gog+2sW1Fm+qXmmU0c8z6uXfQMX4cRUYYLHIl+kXKYDMHAPT7empOAe+X
	dGE7kwoBfUcuiqzgbzpA7qd1B0nF2BI8c7uOkjXXP1UOPygu3peTixjaYmIyMCptj6bpNiWWqGs
	QNbj+OJVrdPeW+iQzYL+8saU=
X-Received: by 2002:adf:f2cf:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4603050230cmr13522052f8f.20.1780799010201;
        Sat, 06 Jun 2026 19:23:30 -0700 (PDT)
X-Received: by 2002:adf:f2cf:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4603050230cmr13522025f8f.20.1780799009700;
        Sat, 06 Jun 2026 19:23:29 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm40650274f8f.20.2026.06.06.19.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:23:28 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:23:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: clamp zone report to the report buffer
 capacity
Message-ID: <20260606221933-mutt-send-email-mst@kernel.org>
References: <20260606170415.1523660-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260606170415.1523660-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GID2fvVAfQKN9nNjbM9kbh2X1IDeoAJ46ercwiDk8lU_1780799010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2026 at 01:04:15PM -0400, Michael Bommarito wrote:
> virtblk_report_zones() trusts the device-reported number of zones when
> walking the report buffer:
> 
> 	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> 		   nr_zones);
> 	...
> 	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> 		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);
> 
> The buffer is allocated by virtblk_alloc_report_buffer(), whose size is
> capped by the queue's max hardware sectors and max segments and can
> therefore hold fewer descriptors than nr_zones. nz is bounded only by
> the device-supplied report->nr_zones and the requested nr_zones, never
> by the buffer's descriptor capacity. At probe time the request count is
> unbounded (blk_revalidate_disk_zones() calls report_zones() with
> nr_zones == UINT_MAX), so the device-supplied report->nr_zones is the
> sole gate: a device that reports more zones than fit in the buffer
> drives the loop to read report->zones[i] past the end of the allocation.
> 
> A malicious or buggy virtio-blk device that reports an inflated nr_zones
> triggers this during zone revalidation at probe. KASAN reports a
> vmalloc-out-of-bounds read in virtblk_report_zones() against the report
> buffer allocated a few lines earlier.
> 
> Clamp nz to the number of descriptors that actually fit in the report
> buffer.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b1c9a27fe00f3..d50aaf956d558 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,6 +689,14 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  
>  		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),

I think nr_zones should have been le64, bot virtio64.


>  			   nr_zones);
> +		/*
> +		 * The device-reported nr_zones is untrusted;

this part depends on the config. just drop it.

> clamp it to the
> +		 * number of descriptors that actually fit in the report buffer
> +		 * so a malicious or buggy device cannot drive the parse loop
> +		 * past the allocation.
> +		 */
> +		nz = min_t(u64, nz,
> +			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
>  		if (!nz)
>  			break;
>  
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> -- 
> 2.53.0

