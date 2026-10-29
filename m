Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274596;
	b=0xJpuyu88xAqFiQv26USkHPBhCRvd5ijscCXC3uPiK7vxAeD0qtCzvRmRpcbCxcss7bU
	 +CnuALz9LG3nI1sZYSJaxQKF0aIO6zuZcOz/EZPo89JehYAPFIn3NoSuQuc8mEHkWRhvN
	 ZBaU+2N2fabWaNf6Z5wre1+oYfSrsnWU5OAjhN9JuP8+cxvHEy5cs67bDngtlcJVWjO38
	 W143wX5jOKN7v2VHG+hHlcRp4uGY8oiCJ3CCMvSuQPx3JWGzsMJeovI6Jy6tUqBDG2Ne2
	 Vl/plK9UJJIH0JsCPOgi6NB3gXIN5rD8BiAEaY4C6v+0GU5Le99ORildo5fLDMvQRAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274596;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WLPilKKHX6Bll8fJE0h26Y8yfh8KgpBjg3n7rIwaERE=;
	b=A81tY0W/Y3cmJYIZJk0SQupGjArwMVHWhKWd7cut4gkNTDCEsq7C6amx8QS/f6/+PLU1
	 eiLcUC8PKaXdWnvJxy9zNXit7iH562ccQRXHAt8zDp41ZWgbw7kHmfnOUjCTXG+Lwf8Ha
	 7LrfFjBZH6Iz8FtnJG1yQRkVEz+l1Op0t6EUt/zUYZXYyf436C/fNyJS27dH75QHmWn0x
	 az36Befiu78ERiV8nhrysBox6WTrZWKW6zbmSVjOOm+Lq16rH3D5f0+MIufeTMRKHq/zD
	 ZMG20gwQAvYU7cm5dusH6RJsk0mLKsD/bbWk3oBCFqF+1id4bP/FkShc5oCKuD78ANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CE+6uOtv;
	arc=none smtp.remote-ip=91.218.175.154
Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD428606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD428606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CE+6uOtv
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Py6lQrwHa4zJ6zD1EgfM4Iwsjr2BmalEeCHDe8MI8N4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793274592; v=1; x=1793879392;
 b=CE+6uOtv+dc0U1gD6iIsFfJhhoMcGS6Gss+OfPe8guZWf+xWp1GbQ2M3Nb5YEuUfgyA99phI
 9hMf6QA/MwfLT8krmfIMErkFZGDMJguAHGXJu9rhrlv3hfbk+gxAJGk2UnU/9WPnh3HI+KBJ7uU
 smrovH+Ps8lCe7ZU6VS4/rec=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 251fa304af50e268;
	Thu, 29 Oct 2026 11:49:52 +0000
X-Mizu-Trace-ID: 251fa304af50e268
X-Migadu-Flow: FLOW_OUT
Message-ID: <d3bffe7f-8ccc-4378-9548-fe013d4e0cb5@linux.dev>
Date: Thu, 29 Oct 2026 19:49:44 +0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_pci: don't take the MSI mutex under
 cpu_hotplug_lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 nicolinc@nvidia.com, jgg@nvidia.com
References: <20261029084043.19409-1-zenghui.yu@linux.dev>
 <20261029061405-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20261029061405-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 6:15 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 29, 2026 at 04:40:43PM +0800, Zenghui Yu wrote:
> > From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> >
> > Lockdep reports the following circular locking dependency when a virtio-net
> > device is probed with lockdep enabled on a system whose devices sit behind
> > an IOMMU:
> >
> >     ======================================================
> >     WARNING: possible circular locking dependency detected
> >     7.3.0-rc1+ #84 Not tainted
> >     ------------------------------------------------------
> >     kworker/u34:0/57 is trying to acquire lock:
> >     ffff800104f83ee8 (&md->mutex){+.+.}-{4:4}, at: msi_domain_get_virq+0xf0/0x118
> >
> >     but task is already holding lock:
> >     ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c
> >
> >     which lock already depends on the new lock.
> >
> >     Chain exists of:
> >       &md->mutex --> &group->mutex --> cpu_hotplug_lock
> >
> > The cycle is composed of three dependencies:
> >
> > * cpu_hotplug_lock -> &md->mutex (which triggers the splat). virtio_net's
> >   init_vqs() calls cpus_read_lock() around virtnet_set_affinity(), which
> >   reaches vp_set_vq_affinity(). That calls pci_irq_vector(), which takes
> >   the per-device MSI mutex (&dev->msi.data->mutex) via
> >   msi_domain_get_virq().
> >
> > * &md->mutex -> &domain->mutex -> &group->mutex.  MSI-X allocation of any
> >   device behind the IOMMU holds the MSI mutex while allocating interrupts
> >   through the IRQ domain hierarchy. The MSI parent domain (GICv2m, or ITS
> >   likewise) calls iommu_dma_prepare_msi() from its .alloc() to map the MSI
> >   doorbell, which takes the IOMMU group mutex.
> >
> > * &group->mutex -> cpu_hotplug_lock. bus_iommu_probe() calls
> >   iommu_setup_dma_ops() under the group mutex; initializing the IOVA
> >   rcaches registers a cpuhp instance, which takes cpu_hotplug_lock.
> >
> > The cycle only became complete since commit 288683c92b1a ("iommu: Make
> > iommu_dma_prepare_msi() into a generic operation"), where
> > iommu_dma_prepare_msi() switched to use the group mutex.
> >
> > pci_irq_vector() is a pure lookup of a vector that is bound to the
> > queue for the whole lifetime of the queue, so there is no reason to
> > take the MSI mutex for it from cpu hotplug locked contexts.
> >
> > Cache the IRQ number in virtio_pci_vq_info {} at vector binding time and
> > make vp_set_vq_affinity() use the cached value.
> >
> > This also covers the CPU hotplug callbacks
> > (virtnet_cpu_online/virtnet_cpu_dead), which call virtnet_set_affinity()
> > with cpu_hotplug_lock already held.
> >
> > Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 12 +++++++++++-
> >  drivers/virtio/virtio_pci_common.h |  3 +++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b90c174450b2..2f42300a8a84 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -224,6 +224,16 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
> >  		goto out_info;
> >  
> >  	info->vq = vq;
> > +
> > +	/*
> > +	 * Cache the Linux IRQ number so that later users (e.g.
> > +	 * vp_set_vq_affinity() from cpu hotplug locked contexts)
> > +	 * don't have to take the MSI mutex via pci_irq_vector().
> > +	 */
> 
> I don't think this comment is helpful. Commit log is enough.
> 
> > +	info->virq = 0;
> > +	if (msix_vec != VIRTIO_MSI_NO_VECTOR)
> > +		info->virq = pci_irq_vector(vp_dev->pci_dev, msix_vec);
> 
> 	else
> 		info->virq = 0;
> 
> 	Please.

Thanks. I'll send an updated version shortly.

Zenghui
