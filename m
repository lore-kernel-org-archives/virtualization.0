Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BF318B96;
	Wed,  1 Apr 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071753; cv=none; b=M+wSGURZF1i1ZHCcRs9oTRMonxbhFutuBr2ymyxrkvdCzZa0kglY4UGrUwSJauf1Q+SsoxrdA4a8iG+9gPkmgHGH9aMHfInGDV2KB8RxQEOkEou4ZquAIwjdDus994ebw39NDpXee9y08pxe2ahi/6D98rvGEUFIPhdIH432Lwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071753; c=relaxed/simple;
	bh=QpNdawBR8MNjH+dl99OApOmMCz7RIQZcRP+3w17laxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3ev70kG/m7Hv1Md3a5enK19s0asU6XUEvea2IKBwR7lijRbUv/4wKPgtKLltnItux6Z6o0jccxgW0ERTjawSxfNYlINB5IR2llPIFOLSkuYGj1P1XDL08P3zwnuU8nxE60SFdgXtCof0VjD/GgussnBx4Spf6SydQOTRI8bi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsDUYg5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsDUYg5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B832EC4CEF7;
	Wed,  1 Apr 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775071752;
	bh=QpNdawBR8MNjH+dl99OApOmMCz7RIQZcRP+3w17laxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YsDUYg5/nzOU9wTHKxnUYdS1hoYJbuh7PR6i1VnAfbp2vtLr+JpkZth7waYtCmgSX
	 jsOEeDZPcYsSB+boDH7TgVWBEoNwsmldst95LB3+JhdDzf1VgMJtXtrLR/whJpR50S
	 MqscAOM8l9TcUvOkj4/hqzLqdM6LTJShn76pxJTSx1Ep4doudzKrp1ka1gNRpIN7FK
	 YsGrL4QhFkydqAbdQ3IieDj6+rXnz/NNIqx+W91cfokgMwlH5mh5Epl5G/Qk6f5oDS
	 IdxPJLN11IZP+u86C4+JuxWKEd0rpyMKdjPpDJMbwTS0+7HgRlKUPXKZUkLS/wtTdg
	 /Zh3wEPAa/Bew==
Message-ID: <226c4984-fd33-410b-b3b1-0c31047cca3c@kernel.org>
Date: Wed, 1 Apr 2026 21:29:08 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio-mem: support Confidential Computing (CoCo)
 environments
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260401-coco-v1-1-b9c3072e2d9c@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260401-coco-v1-1-b9c3072e2d9c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/1/26 13:12, Marc-André Lureau wrote:
> In Confidential Computing (CoCo) environments such as Intel TDX or AMD
> SEV-SNP, hotplugged memory must be explicitly "accepted" (transitioned to
> a private/encrypted state) before it can be safely used by the guest.
> Conversely, before returning memory to the hypervisor during an unplug
> operation, it must be converted back to a shared/decrypted state.
> 
> Attempting to handle memory acceptance automatically using generic
> architecture-level memory hotplug notifiers (e.g., MEM_GOING_ONLINE)
> is not viable for devices like virtio-mem:
> 
> 1. Granularity Mismatch: virtio-mem can dynamically hot(un)plug memory
>    at a subblock granularity (e.g., 2MB chunks within a 128MB memory
>    block). Generic memory notifiers operate on the entire memory block.
> 2. Lifecycle Control: Memory must be explicitly accepted *before* it is
>    handed to the core memory management subsystem (the buddy allocator),
>    and it must be decrypted *before* being handed back to the device.
> 3. State Tracking (Offline -> Re-online): If memory is offlined and
>    re-onlined without proper state transitions, TDX will panic on
>    attempting to accept an already-accepted page (TDX_EPT_ENTRY_STATE_INCORRECT).
> 
> To address this, this patch implements explicit CoCo memory conversions
> directly within the virtio-mem driver using set_memory_encrypted() and
> set_memory_decrypted():
> 
> - During hotplug, explicitly accepts only the physically plugged subblocks
>   right before fake-onlining them into the buddy allocator.
> - During unplug, memory is explicitly transitioned to the shared state
>   before being handed back to the host. If the unplug operation fails,
>   the driver attempts to re-accept (encrypt) the memory. If this
>   re-acceptance fails, the memory is intentionally leaked to prevent
>   confidentiality breaches or fatal hypervisor faults.
> 
> This was discovered while testing virtio-mem resize with TDX guests.
> The associated QEMU virtio-mem + TDX patch series is under review at:
> https://patchew.org/QEMU/20260226140001.3622334-1-marcandre.lureau@redhat.com/
> 
> Note that QEMU punches the guest_memfd on KVM_HC_MAP_GPA_RANGE, when the
> guest memory is decrypted. There is thus no need to discard the guest_memfd
> in the virtio-mem device.
> 
> This patch is a follow-up and supersedes "[PATCH 0/2] x86/tdx: Fix
> memory hotplug in TDX guests".

Hi!


Two things:

1) How do we know which state hotplugged memory is when we get it, and
   which state hotunplugged memory must have before returning it?

I assume that other hypervisors (pKVM?) might have different demands in
the future. Should that be specified in the spec?

2) Should we indicate through a device feature flag that the driver
   actually supports CoCo VMs?


> 
> Assisted-by: Claude:claude-opus-4-6
> Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 183 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 173 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 48051e9e98abf..518bc0aae5304 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -23,6 +23,8 @@
>  #include <linux/log2.h>
>  #include <linux/vmalloc.h>
>  #include <linux/suspend.h>
> +#include <linux/set_memory.h>
> +#include <linux/cc_platform.h>
>  
>  #include <acpi/acpi_numa.h>
>  
> @@ -864,19 +866,90 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
>  	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
>  }
>  
> +/*
> + * In CoCo (TDX, SEV-SNP) environments, hotplugged memory must be explicitly
> + * accepted before use (private/encrypted), and converted to shared/decrypted
> + * before returning to the hypervisor on unplug.
> + */
> +static int virtio_mem_coco_set_encrypted(uint64_t addr, uint64_t size)
> +{

Where is the "acceptance" happening? Do we have to use the term
"acceptance" in this file at all when all we're doing is calling
set_memory_encrypted()?

> +	return set_memory_encrypted((unsigned long)__va(addr), PFN_DOWN(size));
> +}
> +
> +static int virtio_mem_coco_set_decrypted(uint64_t addr, uint64_t size)
> +{
> +	return set_memory_decrypted((unsigned long)__va(addr), PFN_DOWN(size));
> +}
> +
> +/*
> + * Convert all plugged subblocks of a memory block back to shared/decrypted.
> + * Used to undo set_encrypted on failure or cancel.
> + */
> +static void virtio_mem_sbm_coco_set_decrypted(struct virtio_mem *vm,
> +					      unsigned long mb_id)
> +{
> +	int sb_id, count;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id += count) {
> +		count = 1;
> +		if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> +			continue;
> +		while (sb_id + count < vm->sbm.sbs_per_mb &&
> +		       virtio_mem_sbm_test_sb_plugged(vm, mb_id,
> +						      sb_id + count, 1))
> +			count++;
> +		virtio_mem_coco_set_decrypted(
> +			virtio_mem_mb_id_to_phys(mb_id) +
> +				sb_id * vm->sbm.sb_size,
> +			(uint64_t)count * vm->sbm.sb_size);
> +	}
> +}
> +
>  static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
>  					      unsigned long mb_id)
>  {
> +	int sb_id, count, rc;
> +
>  	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
>  	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
>  	case VIRTIO_MEM_SBM_MB_OFFLINE:
> -		return NOTIFY_OK;
> -	default:
>  		break;
> +	default:
> +		dev_warn_ratelimited(&vm->vdev->dev,
> +				     "memory block onlining denied\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return NOTIFY_OK;
> +
> +	/*
> +	 * In CoCo environments, explicitly accept plugged subblocks before
> +	 * they get onlined and handed to the buddy. Only accept at subblock
> +	 * granularity -- unplugged subblocks have no backing in the secure
> +	 * page tables (SEPT) and accepting them would fail.
> +	 */
> +	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id += count) {
> +		count = 1;
> +		if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> +			continue;
> +		/* Coalesce consecutive plugged subblocks */
> +		while (sb_id + count < vm->sbm.sbs_per_mb &&
> +		       virtio_mem_sbm_test_sb_plugged(vm, mb_id,
> +						      sb_id + count, 1))
> +			count++;
> +		rc = virtio_mem_coco_set_encrypted(
> +			virtio_mem_mb_id_to_phys(mb_id) +
> +				sb_id * vm->sbm.sb_size,
> +			(uint64_t)count * vm->sbm.sb_size);
> +		if (rc)
> +			return NOTIFY_BAD;
>  	}

This looks extremely similar to the reverse of
virtio_mem_sbm_coco_set_decrypted() and should be similarly factored out
in a helper.

> -	dev_warn_ratelimited(&vm->vdev->dev,
> -			     "memory block onlining denied\n");
> -	return NOTIFY_BAD;
> +
> +	return NOTIFY_OK;
>  }
>  
>  static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
> @@ -1055,8 +1128,16 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>  			break;
>  		}
>  		vm->hotplug_active = true;
> -		if (vm->in_sbm)
> +		if (vm->in_sbm) {
>  			rc = virtio_mem_sbm_notify_going_online(vm, id);
> +		} else {
> +			/*
> +			 * For BBM, accept the whole memory block range. Unlike
> +			 * SBM, the entire big block is always plugged.
> +			 */
> +			if (virtio_mem_coco_set_encrypted(start, size))
> +				rc = NOTIFY_BAD;
> +		}
>  		break;
>  	case MEM_OFFLINE:
>  		if (vm->in_sbm)
> @@ -1106,6 +1187,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>  	case MEM_CANCEL_ONLINE:
>  		if (!vm->hotplug_active)
>  			break;
> +		/*
> +		 * Undo CoCo acceptance done in MEM_GOING_ONLINE. Pages were
> +		 * made private but never onlined -- convert back to shared.
> +		 */

I think that comment can be mostly dropped. The code is pretty clear.

> +		if (vm->in_sbm)
> +			virtio_mem_sbm_coco_set_decrypted(vm, id);
> +		else
> +			virtio_mem_coco_set_decrypted(start, size);
>  		vm->hotplug_active = false;
>  		mutex_unlock(&vm->hotplug_mutex);
>  		break;
> @@ -1583,12 +1672,17 @@ static int virtio_mem_bbm_plug_bb(struct virtio_mem *vm, unsigned long bb_id)
>   * memory block. Will fail if any subblock cannot get unplugged (instead of
>   * skipping it).
>   *
> + * If @coco_shared is true, convert each subblock range to shared/decrypted
> + * before unplugging. This is required for offline blocks that have a direct
> + * map but must not be used for blocks in PLUGGED state (no direct map).
> + *
>   * Will not modify the state of the memory block.
>   *
>   * Note: can fail after some subblocks were unplugged.
>   */
>  static int virtio_mem_sbm_unplug_any_sb_raw(struct virtio_mem *vm,
> -					    unsigned long mb_id, uint64_t *nb_sb)
> +					    unsigned long mb_id, uint64_t *nb_sb,
> +					    bool coco_shared)
>  {
>  	int sb_id, count;
>  	int rc;
> @@ -1609,6 +1703,15 @@ static int virtio_mem_sbm_unplug_any_sb_raw(struct virtio_mem *vm,
>  			sb_id--;
>  		}
>  
> +		if (coco_shared) {
> +			rc = virtio_mem_coco_set_decrypted(
> +				virtio_mem_mb_id_to_phys(mb_id) +
> +					sb_id * vm->sbm.sb_size,
> +				(uint64_t)count * vm->sbm.sb_size);

There has to be some way to make this readable.

Like local variables or different helpers.

Same applies to similar code below.

> +			if (rc)
> +				return rc;
> +		}
> +
>  		rc = virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
>  		if (rc)
>  			return rc;
> @@ -1630,7 +1733,11 @@ static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
>  {
>  	uint64_t nb_sb = vm->sbm.sbs_per_mb;
>  
> -	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb);
> +	/*
> +	 * Called for PLUGGED blocks (add_memory failed) -- no direct map
> +	 * exists, so CoCo conversion is not possible.
> +	 */

Isn't it rather "nothing to undo"?

> +	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb, false);
>  }
>  
>  /*
> @@ -1744,6 +1851,17 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
>  		if (old_state == VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
>  			continue;
>  
> +		/* Accept memory for CoCo before fake-onlining into buddy */
> +		rc = virtio_mem_coco_set_encrypted(
> +			virtio_mem_mb_id_to_phys(mb_id) +
> +				sb_id * vm->sbm.sb_size,
> +			(uint64_t)count * vm->sbm.sb_size);
> +		if (rc) {
> +			virtio_mem_sbm_unplug_sb(vm, mb_id, sb_id, count);
> +			*nb_sb += count;
> +			return rc;
> +		}
> +
>  		/* fake-online the pages if the memory block is online */
>  		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>  			       sb_id * vm->sbm.sb_size);
> @@ -1941,7 +2059,8 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
>  {
>  	int rc;
>  
> -	rc = virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, nb_sb);
> +	/* Offline blocks have a direct map -- convert for CoCo before unplug */
> +	rc = virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, nb_sb, true);
>  
>  	/* some subblocks might have been unplugged even on failure */
>  	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
> @@ -1989,10 +2108,32 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
>  	if (rc)
>  		return rc;
>  
> +	/* Convert private→shared for CoCo before handing back to device */
> +	rc = virtio_mem_coco_set_decrypted(
> +		virtio_mem_mb_id_to_phys(mb_id) +
> +			sb_id * vm->sbm.sb_size,
> +		(uint64_t)count * vm->sbm.sb_size);

God this is ugly.



-- 
Cheers,

David
