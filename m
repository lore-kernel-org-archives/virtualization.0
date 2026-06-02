Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6373603DD
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383549; cv=none; b=rs/pEEuh3Z7MP7XFO22JA0W/esqvQOolwZy9NHYmrGkx45ylq9onJra2jTWVT03Qx17qiXkssoilGI0oYimsL5mOUPBzSEXM/C3+txkXIKHbMdP0dQg5YYjAjHR2YB3HYbgeTpTn2ChZGaRA59c9lMNwSHBklGJXp9PrJxCJ4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383549; c=relaxed/simple;
	bh=pIG+06FZ/DHgNH53/jtFSdUrNB+urC7R94mgI4vNJ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=se+23HrtBXujcyz/htxMNiWlpmRk049cS2YPNTckGuX02Hu/5p7Z+TKdmlSeBKspmrSlpyFcYfhLQXQ0zTn6vNF3uXvyb2cvIWtD3brQMOgpw02eATMx35i6qPU8PNUt467Gr69AeseO4xUT7ettmhoQoXcV1fE3RAx0BHCgOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsU8FY9K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsU8FY9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780383546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS40ddYhC+PZ+IYRQdjSjQCwzQHh2ypnu3XDzP5dhIM=;
	b=LsU8FY9KRH/cqJab3TkeDqKks/XTaKyausX9WnuwML0dtmhuJTWJtkZocC9WC8/ElWq0JP
	nYYdvlsiWwI2kmE6URXxRE1mAwQXxZVrvr/RlSom6LsUjQMnKCDimCFH5S/ehw4DUNb3dT
	EyfD1zLcazBP6MxWmPV0XnHlSjRNQjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-bifaYNQzMoifBmY3lhOHGA-1; Tue, 02 Jun 2026 02:59:05 -0400
X-MC-Unique: bifaYNQzMoifBmY3lhOHGA-1
X-Mimecast-MFC-AGG-ID: bifaYNQzMoifBmY3lhOHGA_1780383544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a762e646so19953635e9.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780383544; x=1780988344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS40ddYhC+PZ+IYRQdjSjQCwzQHh2ypnu3XDzP5dhIM=;
        b=V5JsBJxRVWUZM6HZHoTDIur4r6FpzLUXfLVwPrdjPbXE/7joPs5N9XqFTK9U9TCybW
         Y8Bh+Ip+Fsy5nNUCnjaJHsWwecLyURAOliKVbQVgflYL75DRQLsqvekVCDRe9YFSO8d9
         rBT9ghJorItNkXR09Vki1F80WtsqEgvt6J8vYXeeMIdKzBSwSSIQuDetcScYnbpqeeIE
         dC/J6qjUZB6LLZZnvtUgXtmPIeRVvXBoiY7bMCpzTkjmlePjvO8tiDa9n8BGcYbJ4myj
         8xjs9cv7XIpy360+ex12hC59PM2/COIWvQpHsDLXoGy1g0e4oBLA6dwqBuSTnhUA738a
         ++UQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H1wg/+vZEpTCszdAPfIEPcc28sFZ0DtUBxgdH/bUBxJ0wHvYKa6qcMXTRTOtfZseO9At1giPiLlind6Zhcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu6jE+1uFmFk/iWxPtalB6rgjsmd+SVehEXdayq3ilnYz57Uvj
	nT2Mb7WcfWCSb9yWakt8ZDJ6Tc/b1zNuvpLN1Kc637da9rZsB4KAHHTDPQR7pRGsb0y/TvToY3A
	TLhshkR1LbjZHm02fKgBru8SHf1r1/n2B+81tg6oXdQmydSNz2QaCXpy+GD3sYbcOwxsU
X-Gm-Gg: Acq92OH5E7jsEDk+gnZgZ6vNXkUrLoDKi0v5Za5DLWxDPqV3Oe5cVI66pATK+PT0ANb
	7euUW+h2SRCyGC9JF0E+Z+DpP3tGKFYAaj0Dp1xX7I9wFuKs4p7rZDtSNzNBc6zDI0DkA4UEM9B
	Ghg5RWn75tAEHhxADfPqlyd/JB/5zpyQ7dDm0ouzkT3V34NxLaT3Qj1WvEVGiE7UyJrr+xOPzYE
	l/rNBhziKEfSTKuncwyxL8QM6jBQLO2q5bxuIV4lA2j1AVxV3FYOf0addaOhgknBGPGzsX0UvD6
	roH1HFiHPu9lD2iV1fRW+XclTPEM2pATVBp9qYN+hw3G5KnKK12rkHAyk8vsQ0SnUg9NCmh5MHJ
	ZVWbQyvKmHl7UVU+MPStpKbnbJ8PCCXyfm829xHlNEpN+WjatRhjFZw==
X-Received: by 2002:a05:600c:2d47:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490a2961e9dmr166050195e9.30.1780383544029;
        Mon, 01 Jun 2026 23:59:04 -0700 (PDT)
X-Received: by 2002:a05:600c:2d47:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490a2961e9dmr166049925e9.30.1780383543573;
        Mon, 01 Jun 2026 23:59:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09be7fsm93880255e9.7.2026.06.01.23.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:59:03 -0700 (PDT)
Date: Tue, 2 Jun 2026 02:59:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yangjiale <yangjiale133@163.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Message-ID: <20260602025834-mutt-send-email-mst@kernel.org>
References: <20260602043123.10207-1-yangjiale133@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260602043123.10207-1-yangjiale133@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iMnhkmw5X7q9zr3f9F_n4b1SYDY1yBlLcV7YvopU6zQ_1780383544
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 02, 2026 at 12:31:23PM +0800, yangjiale wrote:
> When a descriptor list spans across cache lines,
> updating the flag first can lead to a scenario where the device side
> perceives the flag as valid, yet the corresponding address and length
> fields remain unupdated—resulting in invalid values.
> Therefore, the flag field must be updated last.
> 
> Signed-off-by: yangjiale <yangjiale133@163.com>
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fbca7ce1c6bf..036b4f90d30f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  					     &addr, &len, premapped, attr))
>  				goto unmap_release;
>  
> +			desc[i].addr = cpu_to_le64(addr);
> +			desc[i].len = cpu_to_le32(len);
> +			desc[i].id = cpu_to_le16(id);
> +
>  			flags = cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  			else
>  				desc[i].flags = flags;
>  
> -			desc[i].addr = cpu_to_le64(addr);
> -			desc[i].len = cpu_to_le32(len);
> -			desc[i].id = cpu_to_le16(id);
> -
>  			if (unlikely(vq->use_map_api)) {
>  				vq->packed.desc_extra[curr].addr = premapped ?
>  					DMA_MAPPING_ERROR : addr;

Good catch!  And presumably we need a write barrier then?

> -- 
> 2.25.1

