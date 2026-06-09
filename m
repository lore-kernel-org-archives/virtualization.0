Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DF3E5574
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020505; cv=none; b=k6C1Lv8tFR7p5sL9USzz6g49NjuI95QtxCJ4fNIjIFWrv3MJm6e4nlLNYccLGnY40NvNuwhmImy4gbV6k4Lis++ukufSWjXpB7TzbHes0x1H+2ZHVrWMC48ZUaMr9gp3YCw2wxMBtoTRrmY3NXweQnhwpOOVzfjyWtgyKPNxVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020505; c=relaxed/simple;
	bh=vh4wTHSupJWsPBBHRt4byAg9tmu3n/JJ3JkBimEoRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EpRymw0/rkuR6SBZjS7bUIecgg82XNLey5RJhqemUsf9SLpvL+RZBqwrq3Bz7L86fOX8dgPjnsok19tavqf4PmwKrRwbGyq3da3V+V3VkhW+UWh/HsdXVYl6y256HFT2FnjYlEhh3EEgWgFy/USRzy7kdpi5lR22EwXLj/zdtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqZ1+/TW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqZ1+/TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781020502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFekO1yhKAjnCNx4nQmykHHEMqovGJRsN7iwpZ8ZFPs=;
	b=cqZ1+/TWvCjTnb4dpoOo1sYbWZzJ3k6pNZSw6gQP5+JlAE/L4eH8zdN6hNWfPs92EqfGog
	TlQyn3UHX7IhV90+a+hWjDplVEuHZlVUhOk717oF8B54ZnDOcAKfzKkSUKKq0yzJUGxkIJ
	uCI4vrSv1gNDWg2E4iqxYqvwz8/Rf7s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hoPWkvvBM7ugaH4v5xbl4Q-1; Tue, 09 Jun 2026 11:55:00 -0400
X-MC-Unique: hoPWkvvBM7ugaH4v5xbl4Q-1
X-Mimecast-MFC-AGG-ID: hoPWkvvBM7ugaH4v5xbl4Q_1781020500
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso26557245e9.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 08:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020500; x=1781625300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFekO1yhKAjnCNx4nQmykHHEMqovGJRsN7iwpZ8ZFPs=;
        b=DwqIUg3poO9QonuUs0BzJjqIX9EOZIRnhH834aURZvQc9CfCENPW3RkFUyWitXMR5A
         fCgqCLm/LjWAl2TEpyZ7lOQiSt9bz41+KlnvSfE6H17jCtaopdu56d/00t9qjrf6uj90
         e3VV5UQQFXTnOY/1KNp/Dli7oEqhKTAr6MGXsOX/15QVtUX8PFWTcD0dWb8rZpBYo/F5
         nUDq/nKjGIqcMIoQ3mBtmANX06bjD4iUvW43Uq7zlqGRMfJ+PvRp7ZKOCSd7HOe+cRE3
         nOZxpyzfsMJF27woGgvo6JOxQzgOL9FqdjGqzuAyrjzKhMz0ftY+WCNytL9LDj0qa4t0
         LIRw==
X-Forwarded-Encrypted: i=1; AFNElJ89tZjqVtWOA69he2zpNeKgqu4fZLJachl9/Ku/OPOCs3uR6thaZg4ToFLwnaJUEwUAhgOCUn9zuN7trROe8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0YcJptIt3+qzI0bgMgB74Ev3wPnFROrMso+bQICDb2sKruuxM
	h03SWfWFSyvjOFdpgN5Oc7wcqvYsAvvxAETXfhKxSyO2137++weA+FGjPPjoa+3gDwwdV42nLwS
	4tGA9s5pmRnhGE3lIKMi3gr1HlwA6+Zgv2KPTQcKW3LIjJvXvBsXoXsUuKU2J9ANgQcpw
X-Gm-Gg: Acq92OEA9C6DCud4Rs9rnYJ/6N+NgVVVFr78bSzIIzBAOX9nM2GB0eHaUJHLThoHv4A
	6q58coIySu85mVOkqcdkvVNWO3HKWNwC9D2Ip2LaX3urVUnzp4npIVSp1i/4VcZngj0t9C94/Ju
	s3UARcBoUgfa9YSonY6D4iP1RWomoihrFWwRl18pxfyGMiOqq0WBoxMjaSF52ZKiSU/6FU/7NIN
	94nZgUAAGnaB8nHZz7Z/bREwUJVR9Ig7oq1ddQqn37XDTzKpQ7yfiF2cglkM1GDlktz/Vmov0m/
	CKl38rqpx9WaVLus4p78mCDCV+9XGc7T3yeGInqhZ6/89w2qfXHewGHoxgRdn0fHOm8C9UCgylo
	KI+AQsTDcGfk8sjocwsZT3LJGbVfvJqWWVlQKwQX7NGCmb3JK2/4j6w==
X-Received: by 2002:a05:600c:c4a7:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490c262183cmr324676805e9.29.1781020499573;
        Tue, 09 Jun 2026 08:54:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490c262183cmr324676385e9.29.1781020499094;
        Tue, 09 Jun 2026 08:54:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm496291625e9.6.2026.06.09.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:54:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:54:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: clamp zone report to the report buffer
 capacity
Message-ID: <20260609115437-mutt-send-email-mst@kernel.org>
References: <20260607124834.3059944-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260607124834.3059944-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zgOGelE8Ucqi2YVKIBYUp2B9pJ2Xv6Z1tY98mKcPzA8_1781020500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 07, 2026 at 08:48:34AM -0400, Michael Bommarito wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2: drop the explanatory comment per Michael S. Tsirkin's review; the
>     clamp itself is unchanged.
> 
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b1c9a27..32bf3ba 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,6 +689,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  
>  		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
>  			   nr_zones);
> +		nz = min_t(u64, nz,
> +			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
>  		if (!nz)
>  			break;
>  
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> -- 
> 2.53.0

