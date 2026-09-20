Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3546F486
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928546; cv=pass; b=pZ2D/t+3oHZIJLsIEXfVrnm2HuaQuBIKkO2FGefKCo2GABnJ1huir8wO6x477G/rB1njeK3SSlhqomOLQcak2lR7NuQ0mWCpFiBBKZfhEjLyPCr6XGmJNglWTJEQqm4N1Oyf047v2FnfljRDYZL+/RiTCps+w+bAE6WCQ/DuN48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928546; c=relaxed/simple;
	bh=SWYgA7a2AnBCZyxhPoQJ4kwc2g45Ge/C8Nlyg+8JLQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCSQDoi+wsUFtdHhbBKaIsIIel/Vp3opIUSHxi/7F3aRsbl+ilpqWSaxCqT9cGfJWddoDAGup3S6Evjycy1BXssxjaUAOHdmjmsGkRhSU+XE9GGR0n4FhUHfVpXXoJNlWj869BpM+yjujZ3Ltl+FptNgG2X/7giLHFlfUVasKZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=crUSShq0; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="crUSShq0"
ARC-Seal: i=1; a=rsa-sha256; t=1789928529; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bq8/J1e5YFxbf5jgWSPsQ4iejkPHgTwD50Z7w56qy3kKtcsubCvjMle/jcFy8eQFOy6auBPUczH2jUessURTwQL4uIZi0yLYpxthaOlcqzceMJ4EE394oK+YPEx2tOa7vVcIy82P3C23q3cJ5rKc3B9RMXYmrvsxARoiwa3Uz7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789928529; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WKC7u7DErebUD+5Od97+FE9LeFRLqa0me2EXhZGrxm8=; 
	b=Wcd8KlYud1m1D0EtXrZ7fA92+6XC/Twouu48RUk6CKskDNep/Zci0B2ak+WvBB5VlusMDwqzPQ34GoNfO7M5k1TXNS+rZ2SwmkHSfMghut2rjqe/dWY+4I+mks6TKP5L93nIIKAKd7CyHuinn3IKOp7GZ2gwZbPlPeZgYfJP4OE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789928529;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WKC7u7DErebUD+5Od97+FE9LeFRLqa0me2EXhZGrxm8=;
	b=crUSShq0HiMsAEW6w+Wc0TEmf47N1e0QmH5GyyAgs4VsjYggcmhtBVWAE3wM7V6p
	/CO4+NrgMhgumXonDdwECPXH5ytHS/NrXOHN8YB5lF43eqIT5dXOZhl88byOp4/LM5/
	ITAoA3DxJ4Np/lpMUL5at0Mxoxd+B067xfa8m3/4=
Received: by smtp.zohomail.com with SMTPS id 17899285281451003.8605223749015;
	Sun, 20 Sep 2026 11:22:08 -0700 (PDT)
Message-ID: <e9c843a9-4703-4a07-af5c-d184e52593a4@collabora.com>
Date: Sun, 20 Sep 2026 21:22:03 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/virtio: sync shmem backing on guest-bound
 transfers
To: benjamin@edera.io, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>
References: <20260814-virtgpu-from-host-sync-v4-1-64dd736b1779@edera.io>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260814-virtgpu-from-host-sync-v4-1-64dd736b1779@edera.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/15/26 01:20, Benjamin Leggett via B4 Relay wrote:
> From: Benjamin Leggett <benjamin@edera.io>
> 
> virtio_gpu_cmd_transfer_to_host_{2d,3d}() sync the shmem backing for the
> device before the transfer, but nothing syncs for the CPU when a transfer
> runs the other way. That breaks two ways. Where the DMA layer bounces, the
> device writes into the bounce buffer while the guest keeps reading the
> original pages. Where DMA is not coherent, the device writes memory while
> the CPU keeps stale cache lines, because nothing reaches
> arch_sync_dma_for_cpu(). Either way DRM_IOCTL_VIRTGPU_TRANSFER_FROM_HOST
> hands back stale data.
> 
> Sashiko originally found this in
> https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.kernel.org
> but the suggestion there to fix this with dma_sync_sgtable_for_cpu()
> isn't a sufficient fix, for two reasons.
> 
> - The transfer is asynchronous. virtio_gpu_cmd_transfer_from_host_3d() only
> queues the command, so a sync there would run before the device had written
> anything. It belongs on completion, and ahead of any fence signalling.
> A waiter woken by the fence would otherwise race the sync and read the
> backing pages regardless. It needs its own pass over the reclaim list
> rather than a step inside the existing one, because
> virtio_gpu_fence_event_process() also signals every earlier fence in the
> same context, so any entry in that loop may signal an earlier entry's
> fence.
> 
> - The transfer is also partial, carrying an offset, a level and a box.
> Where the mapping bounces, a sync for the CPU copies the whole mapping
> back, so unless the mapping is primed first the regions the device did not
> write come back holding whatever the bounce buffer contained, discarding
> data the guest owned.
> 
> So the fix: Prime the mapping before queueing, tag the vbuffer, and sync
> for the CPU on completion before the fence is signalled.
> 
> A second transfer must not snapshot the mapping while an earlier one is
> still in flight, or the snapshot would predate whatever the CPU wrote once
> the earlier fence signalled and the later sync would discard it.
> 
> To mitigate this, wait for outstanding fences under the reservation before
> priming.
> 
> Neither sync copies anything unless the mapping genuinely bounces:
> swiotlb_sync_single_for_cpu() and its Xen counterpart look the address up
> in the bounce pool and return early when it is absent. On a platform with
> non-coherent DMA they still perform the necessary cache maintenance.
> 
> The range cannot be narrowed to the box, since for a non-blob resource
> virtio_gpu_transfer_from_host_ioctl() rejects a caller-supplied stride and
> layer_stride, leaving the layout to the host and the guest with no way to
> work out which bytes the device writes. A host3d guest blob does carry
> both, so its extent could be bounded, but the sync is left whole there too
> rather than special-cased: priming makes the untouched regions round-trip
> unchanged either way.
> 
> Behaviour changes worth noting:
> 
> - TRANSFER_FROM_HOST can now block, where before it returned as soon as the
> command was queued. Repeated readbacks of one resource serialise, and a
> readback can wait behind an earlier queued command that touched it, since
> virtio_gpu_array_add_fence() tags uploads, execbufs and plane flushes
> alike with DMA_RESV_USAGE_WRITE. -ERESTARTSYS was already possible here
> via dma_resv_lock_interruptible().
> 
> - A CPU write racing an in-flight transfer to the same resource is now
> lost, where before it survived and the transfer was lost instead. Priming
> captures the pages as of queueing, so a write landing before completion is
> overwritten by the sync.
> 
> - TRANSFER_TO_HOST can also block now, but only while a guest-bound
> transfer on the same resource is outstanding, which happens only for
> callers that issue both without waiting.
> 
> - Where a batch of completions contains a guest-bound transfer, the sync
> pass delays fence signalling for the whole batch. Only bounced pages are
> copied and the swiotlb pool bounds it. A batch with no such transfer is
> unaffected.
> 
> Tested under QEMU on x86 with swiotlb=force and virtio-vga-gl
> iommu_platform=on, which forces both preconditions required to hit the
> original bug.
> 
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.kernel.org/
> Signed-off-by: Benjamin Leggett <benjamin@edera.io>
> ---
> This depends on 6a736d2f9d0c ("drm/virtio: use the DMA API for resource backing on Xen"), currently in
> drm-misc-fixes only, so it needs to go through the same branch.
> ---
> Changes in v4:
> - drm/virtio: use DMA_RESV_USAGE_READ.
> - Link to v3: https://lore.kernel.org/r/20260814-virtgpu-from-host-sync-v3-1-f2538afd7d6e@edera.io
> 
> Changes in v3:
> - drm/virtio: use smp_load_acquire()/smp_store_release().
> - Link to v2: https://lore.kernel.org/r/20260814-virtgpu-from-host-sync-v2-1-fa3910caf3e5@edera.io
> 
> Changes in v2:
> - drm/virtio: add guard on virtio_gpu_transfer_to_host_ioctl.
> - Link to v1: https://lore.kernel.org/r/20260814-virtgpu-from-host-sync-v1-1-814e3afb5b08@edera.io
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  5 ++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 43 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 46 ++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
