Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5902BDC26
	for <virtualization@lists.linux.dev>; Wed,  1 Oct 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318268; cv=none; b=pbtrLOyd1enuyhWH3a70HMGqlSTBToAYKU1SQW+x6kfC2Jz3LauscLcKC9M/nfpPPOVKe4+aXlCom8sKqicfHslYsp6BGor6ECt6V3QyCgUIJIzspe4Ycqn9SiTid3tG8fKOBuZU864yfIb6GWgVfw5J7ZfRP2Jz8f+84sgrVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318268; c=relaxed/simple;
	bh=+ntO8IhcLjUfgG3Tl85pJSQjIsj7vcYuQlV24Iuh4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SyMpCCfW5NHRakxsLnUvokuRFgEw9z9fmKBpozoFCHOJnCxtAxyJ9eLIWh7C6mDCkWbHtjnUzaHMhIEezDruqJjddZAh0B5rOEd2EWf2hpRr/MxhAx6HEu4w4BvRw9d7qwk4a6AHqECIB6/LnqGhhB3MHMI/7NYxRB2I3/65lZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGtZU9Jv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGtZU9Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759318265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjn0YAp/S91LPcD+yCLO1GaiQme1ryl9SDDHJbufKoc=;
	b=RGtZU9Jv7Uf4l/pmk2aObdvvy2rAy/SCIMwLYGqyaCohj3hDoNI8BpU93pqKKdIxL1hWeo
	anR/hSCywbU+ztxgEttE9PIX+SARjoGeUMamQilY9J2Ndr0oLml98pdMAKTEMncr4Qm42G
	Isnr/38p8TZRW4oHR9sILanjbhskbp8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-0RaVKaDCMYCdPlMMyE-GZQ-1; Wed, 01 Oct 2025 07:31:04 -0400
X-MC-Unique: 0RaVKaDCMYCdPlMMyE-GZQ-1
X-Mimecast-MFC-AGG-ID: 0RaVKaDCMYCdPlMMyE-GZQ_1759318263
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f93db57449so3962929f8f.2
        for <virtualization@lists.linux.dev>; Wed, 01 Oct 2025 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318263; x=1759923063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjn0YAp/S91LPcD+yCLO1GaiQme1ryl9SDDHJbufKoc=;
        b=qqJtTvfcK9QzYXd8axDDWDVRRuPqasTCJVhaPwoH7pPXFkhYuof46i88M+OjeLkLFW
         MAQp2qcahqvv7GO+vkAq1umiN5is/67yRV3VvmKuLmijnFG++FlpqeN3LYprDItKj+gj
         D5pj4Nm7CL3QRmrNCySfMB3AGnZZDn0q/vobq66vP4Myfg/WY/X+C6rC2OdK8tvM/Dob
         lCQIfbD62yVwF80eCn5gpkCTJxY9yYW4feeRJyqGBPeT+SVV0mYRF1Vue5qMh8Ol4kpx
         ZRnFFdSW/LFMftIpBqKgjSvEbRyPFr7ipZLyQ7G+27pd2G3B4LTqGJA6iNXy+FR26Agl
         cAPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNg6qgre2cF+1jJQsQdnMoOx3pMkQTLbYCRzHTRsUUYWLWUCnhtCybw7fW6cR8WkbkGkvPNgpynngksqREw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOi3SBCl3Kc6XYxfi2IAJPTOJhYGHLp85zhnHS4Dd/mwjIFTVd
	nPe37FMNj/ZNwEnV1GUc2eCsKouiUcSEvgj082KWDKrt6+XvnlwRcM6+rYy4emnUQlxdvCY+fK5
	U3va3N5vHaR0hCWju9AE1LjRjVbU/mhsyMDr2oJL44HiQID4u5ySkvk2a0QjNbqRT//RhTLTGVk
	/K
X-Gm-Gg: ASbGncttIdfonN8GIse5o1NZCDFQL0shY23xe8Q2FaQZkZ5nrjYs5ZwhXkD0GJj+rkm
	wi+f78avhl3gkpQKF25cK9kc5B2F75ZgUe50z2++TTun4j8kvGCUgKIBARakM8Et5EiQ0zfQv58
	oOKl4ot6GPx5iTE8+2K8C/q2cV7gKUGszOCdx0tWdpW14tG8/odrB78fZWOn6vXHLv+mSXbFP6m
	Fh+Rnvit31YaMfdhXiGgiXefBjFgjFZxCDqrSfOM0csgrQKuTJPfAEqn/EkBwt7n5KKonwpTJQX
	dL3rp5JscOnf24mgvM7M6/KubVMsWLZU31So6+E=
X-Received: by 2002:a05:6000:24c6:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-425577f056dmr2450938f8f.23.1759318262729;
        Wed, 01 Oct 2025 04:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5q08sJLCfUBTyxM3ZcMrLPFKvZgNXOAzaBU2ckt9yIh/nxyqNXUMtFwGdm94iF2nTmKPT4Q==
X-Received: by 2002:a05:6000:24c6:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-425577f056dmr2450911f8f.23.1759318262213;
        Wed, 01 Oct 2025 04:31:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619ad9c6sm38124855e9.16.2025.10.01.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:31:01 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:30:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/19] virtio_ring in order support
Message-ID: <20251001073020-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4DhiIV3DvlCaaIf4B-7HRfVori1c1T5NsfFFnxsrKIU_1759318263
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 06:36:49PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.

Jason can you pls spin v8 without patch 12? I think I agree
it is questionable.

> Changes since V6:
> 
> - Rebase on vhost.git linux-next branch
> - Fix poking packed virtqueue in more_used_split_in_order()
> - Fix calling detach_buf_packed_in_order() unconditonally in
>   virtqueue_detach_unused_buf_packed()
> - Typo and indentation fixes
> - Fix wrong changelog of patch 7
> 
> Changes since V5:
> 
> - rebase on vhost.git linux-next branch
> - reorder the total_len to reduce memory comsuming
> 
> Changes since V4:
> 
> - Fix build error when DEBUG is enabled
> - Fix function duplications
> - Remove unnecessary new lines
> 
> Changes since V3:
> 
> - Re-benchmark with the recent vhost-net in order support
> - Rename the batched used id and length
> - Other minor tweaks
> 
> Changes since V2:
> 
> - Fix build warning when DEBUG is enabled
> 
> Changes since V1:
> 
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
> 
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_get variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 892 ++++++++++++++++++++++++++---------
>  1 file changed, 681 insertions(+), 211 deletions(-)
> 
> -- 
> 2.31.1

