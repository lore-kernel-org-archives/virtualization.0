Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268962;
	b=EbrQVm3QVubtHAHZpjlIfTxJpyMEQ+NAk3xVrG3PG0QiptOXRxNFPsdDBsXi+bS+d80Q
	 d2twvp3Va72guc7anDfiDzNW1hJb+Sa8B6B6dj7tqiLUyLoyjRTu/015VUJ2KafYldDCS
	 +i3JXtjmGwZLDcQYdL9BouP0VUx2G3DqarmvoFGrbW6NQ7OxgEo2c8HvsQYR0fZxjM+Ne
	 gETfXRY2XZrfPT6XtON3oNErT5t66c1ze6U3BTeA7zdsVz7Qwt8XPWKmdNJUwmKv5z8r4
	 Or1SaiZCePyyzvq5fU38Noyu+qROiEQE2ClTnBD+xZccdpmFjlnYvahnLPNizi+IBuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268962;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition;
	bh=pbmX/uqxn8yhCkWVdVToI34WWKoGFOjfs0mbjo3EsYk=;
	b=osUTje9r8Eafh00wS8BvL4RoXeqr79+j3Sqia+ZLS0OyyV5M1V8jONhQmSE4ZLLGld1E
	 Twofgu7tGTL7/tw8WJBZF/NcR7MTjm9BprOi1gpfvIcbkloIgAVVq981fG41ufA2Clyjz
	 R43Llothdj9ArMvP0rCL8qJr64I7E/RB1lil27bXRxiYqTdW+dzsSRXAi1E1YyhOatTtI
	 xjGwRtHstW4DJHVy8R0hwfZyXylUSngp0V6oDZAQ5wxMDP2lDG1GqwNMVI4IJ7o4NeyGJ
	 5PRLk6s9gihYLY5P+2UOReTEsjH0ai0Rig/d+t4xI4ozVGT8ldjdydRR13t5SciRqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgHrqpVw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4F606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 10:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgHrqpVw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793268960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbmX/uqxn8yhCkWVdVToI34WWKoGFOjfs0mbjo3EsYk=;
	b=AgHrqpVwQKOBxZ6IA2H+26OukXFmj9qOXPL+/OEWM5q0AFyucmfFREvqIawNU6wwx/aKIy
	jqgutNZYIsSTemxbDvpU4UspB5tEVxOHDCtedRyMh56vFv56dhLZaQNFBno5Vks1N4NB/7
	Sr28xJDe89H/zuCkqLu68TjS8ciUO1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-fNEzMtbHNwe0GX0ngApWmA-1; Thu, 29 Oct 2026 06:15:59 -0400
X-MC-Unique: fNEzMtbHNwe0GX0ngApWmA-1
X-Mimecast-MFC-AGG-ID: fNEzMtbHNwe0GX0ngApWmA_1793268958
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so1591512f8f.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 03:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268958; x=1793873758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbmX/uqxn8yhCkWVdVToI34WWKoGFOjfs0mbjo3EsYk=;
        b=lYNLzeVBK8fhG/O0nExrpcKotltpWMMeVFhj9yBcXKJV0kBEen66HdOotZlL/8iTFr
         b674zbw8rVDKB+vHmq0jaHRgHRGHFfUpB+OowmM0S+RtCd0x91X6JOqWD9NIjUVdS8+N
         XP/lIP+TMgOMRpYQy+ZRHGwjXPHs2A4iZDLBDL/2Hefdl9oUl87kwUL82vqqLVAc9cRr
         MUSBD0SZxhUqXLQQBCmqEC7oNiLedThkOGeuQtsfMYgqeP88I1a6YkEEBF0z4YN2g4aU
         cKPMH/3qSRJrlqt4jHKpHZdiPjykmPZYkihGeDx3ETNt7yDcntXg8w4FYdKEvJvKVpdC
         +Tjg==
X-Gm-Message-State: AFq9FYJ3e6ATXkOMPArwkydT+AiLdYLJpFeDJPXNyNt9pefUVRgZ3W0y
	nGcwdMXGCo8xJ+EWCrledVkrNXK9oOomm+3J82lLa0EJ7RAQKI6pfTrewa4BvJWzvhPeEvxl+TG
	B+MULOO3Slm5aYfTCn4voK3WkTN7VKB4KdZDto82c7XTUJTW0FFuL5a1J11zwVmtK//Y0
X-Gm-Gg: AYBFou2j98Qu/f0/RgluuqHdDSdza2UNF6ZHkLkEgyQb6hQM55tvbC9QM/3Imw8NoJ0
	7qRmnb6ELZvMBAGynpdTqECt5jBLPuPvr6bFDE22TNLh2FUsaBYw72paybo1p/cFtnvJne+qa04
	8degg0EDRz3Ine5DsRGHeDOv6Xv/y773pkojiklItVWW61JSjGe1a39LgQXFGe2TO6369TRTKTs
	j7qqlRQWx5ZZlBeVW3tmYM+9amRNfIgjwGVViAWToAiqp33TBIogq8ZHXAzpB8BdnXNcygd6T8K
	qvnJr4lq6KZzX5qOUkD6Z+1oBbxCH0lozPcfcwE/79fgtkypli+H2ntwapqYbHuSOJOMHF9xOa5
	b1T/us71v/vr5a344e0+GERK1FmBeaRV48ReMoLaEHIs=
X-Received: by 2002:a05:6000:41c9:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48e5d5a45cbmr11729615f8f.36.1793268957684;
        Thu, 29 Oct 2026 03:15:57 -0700 (PDT)
X-Received: by 2002:a05:6000:41c9:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48e5d5a45cbmr11729540f8f.36.1793268957034;
        Thu, 29 Oct 2026 03:15:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7c3sm35294599f8f.51.2026.10.29.03.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:15:56 -0700 (PDT)
Date: Thu, 29 Oct 2026 06:15:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, nicolinc@nvidia.com, jgg@nvidia.com
Subject: Re: [PATCH] virtio_pci: don't take the MSI mutex under
 cpu_hotplug_lock
Message-ID: <20261029061405-mutt-send-email-mst@kernel.org>
References: <20261029084043.19409-1-zenghui.yu@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261029084043.19409-1-zenghui.yu@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qeI40Qfma4jTEpqre4wc6Ma5f2Z4BN9YlEhSClYVMAE_1793268958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2026 at 04:40:43PM +0800, Zenghui Yu wrote:
> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> Lockdep reports the following circular locking dependency when a virtio-net
> device is probed with lockdep enabled on a system whose devices sit behind
> an IOMMU:
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     7.3.0-rc1+ #84 Not tainted
>     ------------------------------------------------------
>     kworker/u34:0/57 is trying to acquire lock:
>     ffff800104f83ee8 (&md->mutex){+.+.}-{4:4}, at: msi_domain_get_virq+0xf0/0x118
> 
>     but task is already holding lock:
>     ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c
> 
>     which lock already depends on the new lock.
> 
>     Chain exists of:
>       &md->mutex --> &group->mutex --> cpu_hotplug_lock
> 
> The cycle is composed of three dependencies:
> 
> * cpu_hotplug_lock -> &md->mutex (which triggers the splat). virtio_net's
>   init_vqs() calls cpus_read_lock() around virtnet_set_affinity(), which
>   reaches vp_set_vq_affinity(). That calls pci_irq_vector(), which takes
>   the per-device MSI mutex (&dev->msi.data->mutex) via
>   msi_domain_get_virq().
> 
> * &md->mutex -> &domain->mutex -> &group->mutex.  MSI-X allocation of any
>   device behind the IOMMU holds the MSI mutex while allocating interrupts
>   through the IRQ domain hierarchy. The MSI parent domain (GICv2m, or ITS
>   likewise) calls iommu_dma_prepare_msi() from its .alloc() to map the MSI
>   doorbell, which takes the IOMMU group mutex.
> 
> * &group->mutex -> cpu_hotplug_lock. bus_iommu_probe() calls
>   iommu_setup_dma_ops() under the group mutex; initializing the IOVA
>   rcaches registers a cpuhp instance, which takes cpu_hotplug_lock.
> 
> The cycle only became complete since commit 288683c92b1a ("iommu: Make
> iommu_dma_prepare_msi() into a generic operation"), where
> iommu_dma_prepare_msi() switched to use the group mutex.
> 
> pci_irq_vector() is a pure lookup of a vector that is bound to the
> queue for the whole lifetime of the queue, so there is no reason to
> take the MSI mutex for it from cpu hotplug locked contexts.
> 
> Cache the IRQ number in virtio_pci_vq_info {} at vector binding time and
> make vp_set_vq_affinity() use the cached value.
> 
> This also covers the CPU hotplug callbacks
> (virtnet_cpu_online/virtnet_cpu_dead), which call virtnet_set_affinity()
> with cpu_hotplug_lock already held.
> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> ---
>  drivers/virtio/virtio_pci_common.c | 12 +++++++++++-
>  drivers/virtio/virtio_pci_common.h |  3 +++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b90c174450b2..2f42300a8a84 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -224,6 +224,16 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
>  		goto out_info;
>  
>  	info->vq = vq;
> +
> +	/*
> +	 * Cache the Linux IRQ number so that later users (e.g.
> +	 * vp_set_vq_affinity() from cpu hotplug locked contexts)
> +	 * don't have to take the MSI mutex via pci_irq_vector().
> +	 */

I don't think this comment is helpful. Commit log is enough.

> +	info->virq = 0;
> +	if (msix_vec != VIRTIO_MSI_NO_VECTOR)
> +		info->virq = pci_irq_vector(vp_dev->pci_dev, msix_vec);

	else
		info->virq = 0;

	Please.

> +
>  	if (callback) {
>  		spin_lock_irqsave(&vp_dev->lock, flags);
>  		if (!vp_is_slow_path_vector(msix_vec))
> @@ -571,7 +581,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  
>  	if (vp_dev->msix_enabled) {
>  		mask = vp_dev->msix_affinity_masks[info->msix_vector];
> -		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
> +		irq = info->virq;
>  		if (!cpu_mask)
>  			irq_update_affinity_hint(irq, NULL);
>  		else {
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..18b15a5f84ae 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -40,6 +40,9 @@ struct virtio_pci_vq_info {
>  
>  	/* MSI-X vector (or none) */
>  	unsigned int msix_vector;
> +
> +	/* Linux IRQ number of msix_vector, or 0 if not mapped */
> +	unsigned int virq;
>  };
>  
>  struct virtio_pci_admin_vq {
> -- 
> 2.56.0

