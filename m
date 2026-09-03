Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6333F54B6
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434941; cv=none; b=uvPzP2NktxzDVnmox1M+ikwvxLF3BfpnvwxGaAzOVAGyXqgXij/Zq7NzlB5Dv+Zgf5J2AWKIVvamjb9EB/kT5zl97tp+btgHIhrkgTkplyIxwDCiHQhs1fBT7+J7P3K0GerJTENOZ3xwnVW31jgH9sdQUWPSq9Bv5x2uguEUdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434941; c=relaxed/simple;
	bh=izIoxQQPPhWNBGA2zN0F8lnUVzBbBYH0WQkACSGnoZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mIIPs0yGxnp8wXmBNY6Fo2JCZeUILjBrUarC2FgvmM0qGhclv6QenLq/SNfYRfCeKBpqvOdt+2zOGrAi+6d6Xkk8kFe8K2UcM/mW8kGk16NtLU9AjlRxNRUxn6WKSIUrRmrNppx1roX8T+keE1DTa7eeVLPIiXbkBedcffVTHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZN4BKBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZN4BKBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788434937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7VfWNLPahHWyir7K1ES/2Ml0Y11JC1XZzjOhYDml2w=;
	b=VZN4BKBsbt5E4NBfWnxlewGXYYHNOQoSQiSIXeS5adpiS22TmDn23Ak+9/hBFt6J7z5AAi
	h4fi9UpBBhGISp/fgUHwXJLnS7g6y1leOKFIpRPX4fTT81AGddLsCzpeMkFddNo6+FUtmn
	1mM1xc6mtbBLH7KXDMTE6NqPiN+7a0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-x7b9ig8rOOqnjqu-kJThiQ-1; Thu, 03 Sep 2026 07:28:55 -0400
X-MC-Unique: x7b9ig8rOOqnjqu-kJThiQ-1
X-Mimecast-MFC-AGG-ID: x7b9ig8rOOqnjqu-kJThiQ_1788434934
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so24244185e9.1
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 04:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434934; x=1789039734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7VfWNLPahHWyir7K1ES/2Ml0Y11JC1XZzjOhYDml2w=;
        b=gfzFsmKj31MD7LmA2WPam6L5AIJ0PvOT8HkLoTlWQExZVuNF1PjoeRppH3/dDrLjso
         7rxPYqHxE/IWlH0aHP1vpLRPpLWd6dtFW/dPlI3t72DIIISS0zJIcRbDyy/N3lRWvZ4v
         3BBbGCbZpdI5tkO4c16i1LLkol5Y79Dcb2HGeqH2acZVWTQMIQ4tJkA+MjTjw4YIx8sG
         R1q8AzmTYr7ElV0sbI6SftUoLTE9qliAt+2D7cMaoVRzJ0JZfAVENeHFQ8cY/hXO0/LX
         mESp6UynJybJpanRaCqWOy2PAV8RHlETceRswhbYmnjFr/BhCp2jVc3gkSAJFZO+dLQ1
         qA7w==
X-Forwarded-Encrypted: i=1; AKwUvBxCK7CEVR4z3f0BpXlV6S0dXw95qGHKfVlIuZ/UEc9cgD5/qx6O9B+J0pXMPKerg4NwAZYR4regL39/BqPQwQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k4br1kaf5cuo2hKXEzSx6mgF0/VFC/oeKLf4pGUcx1rIaWsMdS
	mjPhY38GSEneo8CQQEnIvaSCXye0oouPh4cufkXiRXz/CrKwNbvGmxLLOTNzFmxzcjxhrIV/dYL
	tnDV77EBQvPVtSrjyeUQYycAR478YqpZ8GD2FPdgMBAWqTtCCZErmaZHK9eg7vCyqPecX
X-Gm-Gg: AYBFou1jl90l/5FiJQHV3skaOBh2BQ1ZVi5CYN5AHNInhd+BjxXSscnUhAXwf4ufnzP
	6U2wOosk4UYdbFcn4otSABGNIBIivRRECUqBK8uTbsB04c5atzs3l/op4+jw/sA/WEh4QabqWB2
	jmPIRggajgnp9Lqe/y1CIoPhH14f4OKKHuFk/FwQi3NvDMphhmtE4MAoPWM/9GeVi7dFej9XgnY
	mr9imJXG/hSR+eSk3s79EJENt9MdRjMVu/izxWj96WQ1A4xo1JJwFgdN1LOrwJHnJdGqSR774tE
	s4GbP1wejq2bCilXcsLTwiZ0VIG5k8PRQQxHFSGwDfCs8QeQqSCuDIbZfDVuaHoyvBnIxpEJ0zx
	POZsgtRDipuYF7IJB18KJ5o4=
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr235855405e9.16.1788434933532;
        Thu, 03 Sep 2026 04:28:53 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr235853945e9.16.1788434932899;
        Thu, 03 Sep 2026 04:28:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm62587755e9.7.2026.09.03.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:28:51 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:28:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-mmio: synchronize callbacks during device
 reset
Message-ID: <20260903072404-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
 <20260818040433.66986-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818040433.66986-2-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OPD8ti0pKwncd8shI2C9WRXiNbke-oTUtnVdl75uMAI_1788434934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 06:04:32AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks are not in progress
> once it returns, but vm_reset() only writes 0 to the status register.
> A callback that has already entered vring_interrupt() keeps running
> while the driver tears down the state it uses.
> 
> Wait for a status read to return 0, so the device has stopped raising
> interrupts, then synchronize_irq() as vp_reset() does with
> vp_synchronize_vectors().
> 
> Fixes: edfd52e63672 ("virtio: Add platform bus driver for memory mapped virtio device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/virtio/virtio_mmio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 510b7c4efdff8..a2ca03dbe803d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -55,6 +55,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
> @@ -254,6 +255,11 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +
> +	/* Wait for reset completion before flushing callbacks. */
> +	while (vm_get_status(vdev))
> +		fsleep(1000);

this is only required for transport version 3.


> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
>  }
>  
>  
> -- 
> 2.53.0

