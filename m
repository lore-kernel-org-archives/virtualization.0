Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C53CA4AF
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556518; cv=none; b=LCqt5xdBNSPF/hsE4wTmfQcItvBOoiGXsMbbF7pciGum3zvU9l8yZmVE8LhXS4UouSyAXskKt5ZLjfUgnE/Qb/tIcmiVSA1+n7OY+EOCYRjVZvdNk7Xz9FL2nfZzJUYHmqe0LiYs3174eJxfxUJrLJZZgGLRxW/B3seeSvX5SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556518; c=relaxed/simple;
	bh=pyvo4LUWHIIfbPUmZcKO1ka6B8u8qSTB1nr4VyPHxMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZNBJ99DrJLgdj2s6QAy816d/WbJdRcYQYTU4nxHRLzcETYbQfXpBeEG99FaSpyG03ASuB/W/Bqam69wTCc5afdFH2hJvSgld+wlDNk4Upkb7fPTMti9xKVAxKSk7a6RWuASkzIeOwK+PH0pboYVtmzrlHM7Uj3Sl/D3PbaoMzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dbeq7sfy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbeq7sfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788556513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LRYgJkhKXsg+F6WlQSfLdN/TvDFXG7GLQTKhRs3og8=;
	b=Dbeq7sfyhuekV3QOzeda/NWu6DCcP4QQeXsiEv/2jA3dV3Eefs2DnFyjuIT6VCFuCjSzPw
	nAVnv8ddZMSXlnQ7IPk3IyvEY/yxY9w6pnAhCTs17m9J4SFfajRcVUdrwuaHcWpbosdGEV
	7zlkoOxor+OpHnziGgzPP54K7GsEtOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-W60fvtajP6GSWUXif4GcBw-1; Fri, 04 Sep 2026 17:15:12 -0400
X-MC-Unique: W60fvtajP6GSWUXif4GcBw-1
X-Mimecast-MFC-AGG-ID: W60fvtajP6GSWUXif4GcBw_1788556511
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4843e59c32dso927387f8f.3
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 14:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556511; x=1789161311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LRYgJkhKXsg+F6WlQSfLdN/TvDFXG7GLQTKhRs3og8=;
        b=dP7IEqe74tNCdXWSVBBNmon8961E6CLzzvyQjXHaUuMEBhYSc7lw0VjgBGIoON3DEO
         x4jNsMzu/JTH7W9Tu6j4t46RFCw1dRLyITGG0aSM/xlS4fuPtkiJNEUQaReQljvB9pvX
         o7VNx9OJJijlg/OZ3dAgin/T0IpeeLB9QfCYcjZ6Z9h62Fh7frqebwesdGX27o2Jz/qB
         ZuOeHCLFCfeAoF8MLKRNFHknKcvwX0bzw/xuJbPgkh5aqi844k4zOajpeWK4CtUSchvR
         gHuhVgrukQGML7XyLwi5Y+kb+cTrkFsmOlIf9C82tFqPSDh1/xkGfDQkIZksmpmhEacX
         pOYg==
X-Forwarded-Encrypted: i=1; AKwUvBxMi7XYylrjZtQF+6A5FVzD1RNgsctEpv4xFsNZ1oEzXwoAn3rr/REJWF9oRJSRV0cbLoaxAg/JiaUEjMettg==@lists.linux.dev
X-Gm-Message-State: AFuF++m8cpAIkWwYyxlcw1fWHRmho4yliYsQhqOv6HZkTJwB5EVnYQOl
	Hbo05ZcPjsG3dH/pErnXJ/DdfTmY8HMSgmP1YJz2K/YbecwnHKUSXAF2s45KVstt9oUzEYCSQ6D
	4hZnBIKx4vr030+QEvfPmYim5cjzeNBm3bYcTbdlNVXjfPHxRfMyutD9udJJ6auXM+HtR
X-Gm-Gg: AYBFou1LLxvlkRtefgecag43z1p8Nfn58t3XERxbU3o9rkvorrBN9lxKi9bnRV56Rc3
	QEd9m3JoxSG/F5AVkj3lBlUdCEYBWicYDmPNipfRaXKd+fzgV0MVh574rWgJPji/xg81No4ssVp
	iOP2rtpPtwaq0blhQ+AGJ6P+k/HLkREa/EZDtiBNtyM6nHzoHE4MGepdU7mHS1YxWGtXWi4EiIX
	qnjwosJBP/G9j6LnMxciEIm+wEwTThOb/56s6oHPcYS3cr5jlF39IabwgAZRtMfKVcX4YnVM2/C
	4Pzc2O2I1CDPuQWg6ONmXmYPriKG+B6p4TCSAy4+weZs06c7bVR9hx3J1tpZ8bza8QiVDqoNsnp
	nHEvitrcqadGAcTDiLzVJofM=
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr56808255e9.23.1788556511146;
        Fri, 04 Sep 2026 14:15:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr56807965e9.23.1788556510730;
        Fri, 04 Sep 2026 14:15:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm217094745e9.9.2026.09.04.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:15:10 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:15:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio-pci: return IRQ_HANDLED after non-zero ISR
Message-ID: <20260904171336-mutt-send-email-mst@kernel.org>
References: <20260904141318.30278-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260904141318.30278-1-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ATrLNDE8q0ccMLfG8qRi5IWBSg6seg-gPA6mkqLw8TY_1788556511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 10:13:18AM -0400, Andrew Stellman wrote:
> vp_interrupt() reads the ISR before dispatching config-change and
> vring handling. Reading the ISR also clears it, so once the read
> returns non-zero the interrupt was from this device and has already
> been consumed.
> 
> Currently vp_interrupt() returns the result of vp_vring_interrupt().
> For a config-change interrupt with no vring work, that can return
> IRQ_NONE even though the ISR was non-zero and the interrupt was
> handled.
> 
> Call vp_vring_interrupt() for any queue work, but once the ISR is
> non-zero return IRQ_HANDLED.
> 
> Tested with QEMU virtio-blk-pci forced to INTx using vectors=0 and
> pci=nomsi. On an idle device, 200 config-change interrupts were
> generated using QMP block_resize.
> 
> Before this change, irq_handler_exit reported ret=unhandled and
> /proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
> After this change, irq_handler_exit reported ret=handled and the
> unhandled count remained at 0.
> 
> The issue was found during an LLM-assisted Quality Playbook review.
> 
> Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")

this is still the wrong commit to blame.

> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM

This is not the correct format. See Documentation.

> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
> Changes from v2:
> - Repost as a standalone patch in a new thread, per maintainer request.
> - Add LLM-assistance disclosure.
> - No code changes.
> 
> Changes from v1:
> - Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
> - Add Fixes and Suggested-by tags.
> - Test the change with virtio-blk forced to legacy INTx under QEMU.
> 
> Full red/green test logs and the tested v2 patch:
> https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidence/virtio-pci-intx
> 
>  drivers/virtio/virtio_pci_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 10371ecbc054..b90c174450b2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	if (isr & VIRTIO_PCI_ISR_CONFIG)
>  		vp_config_changed(irq, opaque);
>  
> -	return vp_vring_interrupt(irq, opaque);
> +	vp_vring_interrupt(irq, opaque);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d


I already did exactly this in my tree, no further action is necessary,
but I will add your tested by tag.

Thanks!

> -- 
> 2.43.0

