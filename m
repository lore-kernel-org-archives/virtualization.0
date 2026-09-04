Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFE3806CA
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507017; cv=none; b=Euxz2bjG1r9LTCzmkAdNRzu5TN+5/1ZEixkhpwFRi/ubVix5KQsJqmLoLU8aNhZWk0VFZ9kRMoi7ueLUFkLsXCVeJOKLwbEtXumKzQpafGHcu2KHY+Vkq+fTuedphRC5YWTR32RbSAwNqEeiQK96tB+wz9Cjv3pF/WChpmgUbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507017; c=relaxed/simple;
	bh=vyG6TckgHS+fOfKWh28/5LlQ+0vCj2uSJ0lEFsabQPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RezX+7zl7ajyAXDaa0xhKNupNLa8dsnzVuEKYjQnRELFNm5r9RBGQyxVjDmLOz7pq1vsfmdjDW0q5W5d1hOg8o5TUCemPD3E+cWfv6SzLN8w57Ak/zUWXIiKVojpJbzK7RhvCQjPm8/B0WLdOZY/Aoi4LEGr0iLaGpH7Sek6cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvQNKmEG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvQNKmEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788507014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Zk7aBCncIsthOXbh8gF12TMrw/cGPGJ22zkw/FqYgg=;
	b=RvQNKmEGLjw1oA1RKdUVA8J0+1iK3JZNfzyedPMZtrmLSVtmfD49r2nLHsubVyIsn8+uok
	hZfnnOsJG7s5p+U6OTX8FHVeuzO6IlyCSbm3TjFpuD9KylJhwKCoZLi1fQc5C2eukrk741
	+ghzx04BxPvcyEFhhDHajJ5nowTSw6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-eoX2mXInPaCWZFEKJdy9zQ-1; Fri, 04 Sep 2026 03:30:11 -0400
X-MC-Unique: eoX2mXInPaCWZFEKJdy9zQ-1
X-Mimecast-MFC-AGG-ID: eoX2mXInPaCWZFEKJdy9zQ_1788507010
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4843dc86dddso557925f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 00:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507010; x=1789111810;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zk7aBCncIsthOXbh8gF12TMrw/cGPGJ22zkw/FqYgg=;
        b=MfeH7hI+wdDitA1QGSuq0M9kpjy3nOKWOHHsjvFVaiEEiaFxk2FoW2rcWYQHEexr/B
         nGVyC1TTflfLjDdhuULaR15aLVsyMvwaOp4vDiyfcs7/TDtj3USMCG+BbYvMimUH+q0o
         8vSjPpm49bQ8v471VHwSTvrSzyGDG4eOMRJJQ0oit9GO6/or1wj1NvyQEeDnnJBgtGLq
         Q8KfAOm6NshPEF7vBj0xUmtBSFezBT+ZLTPm/Sq+w261LambQUv6bSA+lStxebmqn5BU
         HpggRDItau4++sZBaDLIbKlt+GxWfioRp7E8x5jk30cP65tCYneG4ScDKrMQbpw+vXFC
         NjgA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ8hcIj7fyOq4id00tYMHN8gcc6RrQguxihZarerU1BwpjTYX/qwUBqrMAGWHpN4EXWyZPa66hcBIeHaJahA==@lists.linux.dev
X-Gm-Message-State: AFuF++mJjCTss5b6kagfC/BxZk2sq+tHikfHrvplN5FNKtX+oNd5knHN
	Zr64FwNDLZz6WGWg3c90sB99eDzBjXCR55A6vQIfLd0YHFLln5ZbU9on4fsMAO6oAI8xc+X/gz9
	m6QplpuOVDmXcb5cUDS35vv6TJGNb2Uf70x7wJ+O1/Lbb7N5q5j5/16M3fMaqoW0pz7p3
X-Gm-Gg: AYBFou2jcrFPGBVuks8aSXNrDiU+/uK3md+X2qkUYpmRcF4NuZU3g6Q44NXDngU23I5
	hhAtvKMxZefRuszkFCnyd+9dM8D17aSiIigyUUbOYLNoPcyVNtE4sCmyCN923yBBrq3CZ7ykEAx
	BriKGHiueG7NvuDjSxvrWsBet7LzyVlPenn4dCD27v2GthBVBrxzxvE1t89sMhlp8r+PkbxGrre
	jQiu57OlfIf4RdPuIQUiDGM+rZs9aN7UJMlb94ygNr9LXE8ji8ktLaugYgkojuCPiqTmc9NhWE/
	VuXSo7hkekgusvPJT9UKStr5SEeWyYqwclmcEFcgZ/MHG17+tblhp0rIVrF3Dy6+FwOcdAlA47C
	+E77GGADXjdukGO7UU8N8P5Q=
X-Received: by 2002:a05:600d:113:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49cf827b19cmr21958145e9.14.1788507010279;
        Fri, 04 Sep 2026 00:30:10 -0700 (PDT)
X-Received: by 2002:a05:600d:113:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49cf827b19cmr21955605e9.14.1788507006980;
        Fri, 04 Sep 2026 00:30:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm4354107f8f.14.2026.09.04.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:30:06 -0700 (PDT)
Date: Fri, 4 Sep 2026 03:30:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 3/4] virtio-pci: return IRQ_HANDLED after non-zero ISR
Message-ID: <20260904032734-mutt-send-email-mst@kernel.org>
References: <20260903111342-mutt-send-email-mst@kernel.org>
 <20260903190731.13783-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260903190731.13783-1-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fMdWekdu_jhRcFiNviC7WdT63dJNdWMieMooBZ_zO9s_1788507010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2026 at 03:07:31PM -0400, Andrew Stellman wrote:
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
> Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>


besides pls do not post new versions as
replies to old one.
and I think this patch is unrelated to
others in this thread, right?
so just post it separately.

thanks!

> ---
> Changes from v1:
> - Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
> - Add Fixes and Suggested-by tags.
> - Test the change with virtio-blk forced to legacy INTx under QEMU.
> 
> Full red/green test logs and the exact tested patch:
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
> -- 
> 2.43.0

