Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9024A6890
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265389; cv=none; b=DFQAD05NFEl8Mgg/BveOLc6LmCa0L0zQM0PLozUQuj8dAMW8pzRSc6wdo+C1/5m0eBh5Z8nC7qWyuwvd7FNEdkJ/9Zi0mc93ZX8lTUJboFA+sDOFido6rtI/OUXUhPezMp2ieYAq8B25DpqsHqikkTGDx2Ska+mL1NUk5WkxN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265389; c=relaxed/simple;
	bh=SzpsF1R44Ubodi/lWdByRj3ussGr5imnuwlywY4gVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M2dYDQQSVibRHJTUi+1DrJcb2eak3HBrBHpJwTMOHm/jiReTf8Dt4MW84SslYJesM39c5geJwTF5gW9QF0SfLoecyQgQJBQJYOVJX0yN1iD3dh8HdSXetQc8xCylcuwhtWIL9/b5ji5RGX9ec23qwjjnPCCozMRlD+CR2yk1Ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwi9L8PC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwi9L8PC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790265384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
	b=iwi9L8PCYLHq4qRf+05qlLtU+sMZlZQsLi3jeXHmSBtQas/NOHmBI+g5nC8pDQU6mSmyBQ
	UOMXlpiSP3g3uxK7ZQOZpcJwu7ma5s892oYeIzyWWCg7bJ0SP9iAwelLHL0McDFfLq4zXv
	nnz+WTQIyj8x/9dm+S1nIRh/R7LynDE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3w9OCL_wOK-JKQrbvhuRTw-1; Thu, 24 Sep 2026 11:56:23 -0400
X-MC-Unique: 3w9OCL_wOK-JKQrbvhuRTw-1
X-Mimecast-MFC-AGG-ID: 3w9OCL_wOK-JKQrbvhuRTw_1790265382
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c294ae16922so273675966b.0
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 08:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265382; x=1790870182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsIicbnwmHZxyMI07vJAKZ5x+YHru/pqorNr3bVuoUs=;
        b=oglv94kQF0bI1mBbus124S5w2ClDTTBqxPe1NuyLMMzOo1wyhOBbrT3CQNzQwvPiCO
         izEP0qWUqfEu00sy+dZmEVFN9QcVjXD6jBPSFLxhNPV9BgmNi+1Uiv9tmXr6lZ5oogJr
         nweCPSwRNYsLNNeHGtY0JPphpRyHspTuNYWVfvk4YHIChFFVLM5wLlh06GU/UTMte+vL
         ci6aLW8kzD8O/0vhCz3fRIalCYTGPn3g1oIAJE2/UJ0DeomEENXQDCcyOUoJD6Rs97xH
         1jnoT9FNsD41pjTDDUNmlc8nDMhCGrmxqLqvMTb67/MDSdrYpg+2SpjLZOAb6fwBLEL5
         49wQ==
X-Forwarded-Encrypted: i=1; AKwUvBytd0FnEwcQd18Xp7I46a+3VTmJjIZKxYcZ0OfCL2VBmIOLPMQzVTZyaAPyJMmDyd2/xTISQcVyxjKh8yRgag==@lists.linux.dev
X-Gm-Message-State: AFuF++mGidGWpXWLe8xN/BTT8IBetcpxvQNQqs5pJpkqb6TtNUWB8MLB
	jX7fIdekK8l0YWVrkjV234sQYg9A8fUzAPqw0iTYbh5+p2WlJvJiIEjGbR8VByrpJFsPfQ73AzY
	Ali5NvbWhxuR9O1M5/UNHM6j0dZQYquGUUrvlIBh3Cp8aVuZRtjURKNwCMzyIaAzqzEbH
X-Gm-Gg: AYBFou2xealXY3ETxNRZ0uyFeMObQpu/82Cn/iP/5WNCKF7OkJ+6D2YN5B2HjbA+m/v
	VeSqre3Yp4HJO1dvY91k3vX10v9fbzSA27bRSS0/xtPu9APaXtYK9/K52OwvnYjV4/a6Wp5xgwM
	SZZNPfgVQ34ObIMgdj/euS3ym1xKcrnNCGx17DD+QyuvMakZ4StnsAGsYBg9YhecsWRUeopt7sy
	1nGzUVHKUweos7BcuDYg6v/mHp/5SXBhYCaRCBNM0LFJ9It53DTEMBHPDORGINsFEGyDIuTyO78
	l/Z56uq29fg4/6Hi5SxBTcWK7iCKmzrJ/uiA25hoBQlxMONWo8X5aivbbkttBVEJP3DAV2pGEKy
	0UaXrBhE3CRaq/HXcwJF+qU1WB3xDwr4Cs2pmKoo6f6QPiKKixn9k5aoVu2clIxhHmw==
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230040666b.45.1790265382152;
        Thu, 24 Sep 2026 08:56:22 -0700 (PDT)
X-Received: by 2002:a17:907:968b:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c2ac2594bcdmr230038666b.45.1790265381573;
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Received: from redhat.com (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk. [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33e046sm312897966b.8.2026.09.24.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:56:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:56:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vringh: reject empty / undersized indirect descriptor
 tables
Message-ID: <20260924114316-mutt-send-email-mst@kernel.org>
References: <20260924030627.13287-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260924030627.13287-1-fangxy@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: twNlaztWE5an6ywnAU9BqFjynZ-bRARXI5OU18FzCSw_1790265382
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 11:06:27AM +0800, Fang Xieyan wrote:
> move_to_indirect() rejects an indirect descriptor table only when its
> length is not an exact multiple of sizeof(struct vring_desc).  A guest
> descriptor with VRING_DESC_F_INDIRECT and len == 0 passes that check, so
> *desc_max becomes 0, yet __vringh_iov() keeps walking the (empty) table
> and aborts with -ELOOP only after reading one full descriptor past its
> end -- leaking 16 bytes of memory adjacent to the table into a kernel
> stack variable.
> 
> Reject any len smaller than one descriptor, before the existing stride
> check, so no descriptor is ever fetched from an empty table.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  drivers/vhost/vringh.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Leak path: once move_to_indirect() sets *desc_max = 0 and points *descs
> at the (empty) table, the next __vringh_iov() iteration first runs
> 
> 	err = copy(vrh, &desc, &descs[i], sizeof(desc));
> 
> i.e. a 16-byte read from descs[0] -- one full struct vring_desc past the
> end of the table -- *before* the "indirect_count > desc_max" test fires.
> When the guest page backing the table sits just before a sensitive host
> page, those 16 bytes are attacker-influenced adjacent memory.


> The multiple-of-16 stride check is kept for defense in depth.
> 
> Userspace reproducer (move_to_indirect()/__vringh_iov() extracted verbatim,
> 2048-byte region followed by a guarded red zone):
> 
>     [VULNERABLE] return=-62 (-ELOOP)  OOB-read=YES  bytes-past-region=16
>     [PATCHED   ] return=-22 (-EINVAL) OOB-read=no   bytes-past-region=0

it seems nicer not to fail with EINVAL not with ELOOP as we currently
do, so the patch is fine. but the commit log if weird, looks like
an ai hallucination.


"an attacker" "vulnerable" and "leak" - is there an implication that this is a
security problem somehow? Because I do not see how this data gets
anywhere.

> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f..0767748 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -197,8 +197,9 @@ static int move_to_indirect(const struct vringh *vrh,
>  	}
>  
>  	len = vringh32_to_cpu(vrh, desc->len);
> -	if (unlikely(len % sizeof(struct vring_desc))) {
> -		vringh_bad("Strange indirect len %u", desc->len);
> +	if (unlikely(len < sizeof(struct vring_desc) ||
> +		     len % sizeof(struct vring_desc))) {
> +		vringh_bad("Invalid indirect len %u", desc->len);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.50.1

