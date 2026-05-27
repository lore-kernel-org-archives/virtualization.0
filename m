Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C13BB673
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877329; cv=none; b=qAT/ikQFADA5mBA4I8Wa8vVjOaLLzA4aiq+g7usKm98TqY5f+OWusJuL6RPEZZ2p+N5oXF7qhY25udxD5oMAJsZBXCHNsEohxZfDLsCSxGpahZr4zZ73oqfUOlqkplA03YQYIecWCcOyznoPEm2ypCarji1dncNwVfxKlxIAIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877329; c=relaxed/simple;
	bh=81mP1Qu+OcfsmnmEx6OYjyoC65sZHp22hNqfi1yGwBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEFJL6v2Q7Zdwma2NG5sviFkCdKIGpCAdyu0H9EK9iU2Z8RI9HR12au7vL8PeWSeOi5km7kts0knF+N6W2SWQTJfLC7v4cDoXWRkbU8rsq8c93MYtXok4BOYVk+/zMh72fTz7BQT579CtteaUAhMhVuPJYn9lcwAPudGQ1+QXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isiqo2vf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isiqo2vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779877327; x=1811413327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81mP1Qu+OcfsmnmEx6OYjyoC65sZHp22hNqfi1yGwBQ=;
  b=isiqo2vf1rmLENND8xT6iimsCB1T7eEJR1kfpCwiB3hhGkPDybsfWIp8
   rCqN2dXSSkhxhlVLWzF+w+puMAwNlv9l7e/191K9rulnUIqYrU3zixj/E
   ToMGYsTPKIOHNdLyM14wSBBohFwi0dzUAvxFM9Yv1L1Rkdp7byXTaaQX/
   Qb1WCTVXW7D7ObYqBpqzhPINE5J2SD1JeccwifZlKt5QIAbiDKzvAtrjS
   Mi7OSQWSVxUfGgyS6352JOTyo8SINwibak9RkBebm5SWFKByQRj8mKuGS
   ZfhcZKQ8yzm/IKxa5tovbJbHn/Zz7kfWovlu0H/779TdbSRaywfjmlj72
   A==;
X-CSE-ConnectionGUID: 5R+WshTvRGunAmE6HrGmEg==
X-CSE-MsgGUID: mBNnU1cfS926m03Qs3eeBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84595080"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="84595080"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 03:22:07 -0700
X-CSE-ConnectionGUID: tL663z+aTqaEJwFUkBULkg==
X-CSE-MsgGUID: 39jNYRuFSnmaemdLcL5QNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="237760858"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 03:22:04 -0700
Message-ID: <523b346d-4f7d-4d89-9839-42a5c167fed3@intel.com>
Date: Wed, 27 May 2026 18:22:02 +0800
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
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20260401-coco-v1-1-b9c3072e2d9c@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260401-coco-v1-1-b9c3072e2d9c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/2026 7:12 PM, Marc-André Lureau wrote:
> In Confidential Computing (CoCo) environments such as Intel TDX or AMD
> SEV-SNP, hotplugged memory must be explicitly "accepted" (transitioned to
> a private/encrypted state) before it can be safely used by the guest.
> Conversely, before returning memory to the hypervisor during an unplug
> operation, it must be converted back to a shared/decrypted state.

It's not a must to convert it back to shared. The memory is going to be 
unplugged, the guest doesn't need to care the state of it unless there 
is restriction that private memory cannot be unplugged. But we don't 
have such restriction.

As I explained in the QEMU thread[1], the VMM needs to discard the 
memory (both shared and private) on unplug. If the VMM fails to do so, 
the memory is actually not unplugged and the guest is still able to 
access them.

If the VMM fails to discard/remove the private memory, either 
unintentionally or intentionally, it's the bug of the VMM. For TDX, this 
kind of VMM bug can lead to re-accept error. To make TDX guest more 
robust, we can let the guest release the memory itself on unplug, as 
suggested by Paolo[2] and Kiryl[3], so that it can survive even with 
buggy vmm. Converting the memory to shared is another approach for guest 
to proactively "release" the private memory. But the justification of it 
is not "guest must do so".

[1] 
https://lore.kernel.org/qemu-devel/7a9fe710-679e-4366-9eeb-3aba148773d7@intel.com/
[2] 
https://lore.kernel.org/lkml/CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com/
[3] https://lore.kernel.org/lkml/acprNlPP7J_ttMrz@thinkstation/

> Attempting to handle memory acceptance automatically using generic
> architecture-level memory hotplug notifiers (e.g., MEM_GOING_ONLINE)
> is not viable for devices like virtio-mem:
> 
> 1. Granularity Mismatch: virtio-mem can dynamically hot(un)plug memory
>     at a subblock granularity (e.g., 2MB chunks within a 128MB memory
>     block). Generic memory notifiers operate on the entire memory block.
> 2. Lifecycle Control: Memory must be explicitly accepted *before* it is
>     handed to the core memory management subsystem (the buddy allocator),
>     and it must be decrypted *before* being handed back to the device.
> 3. State Tracking (Offline -> Re-online): If memory is offlined and
>     re-onlined without proper state transitions, TDX will panic on
>     attempting to accept an already-accepted page (TDX_EPT_ENTRY_STATE_INCORRECT).
> 
> To address this, this patch implements explicit CoCo memory conversions
> directly within the virtio-mem driver using set_memory_encrypted() and
> set_memory_decrypted():
> 
> - During hotplug, explicitly accepts only the physically plugged subblocks
>    right before fake-onlining them into the buddy allocator.
> - During unplug, memory is explicitly transitioned to the shared state
>    before being handed back to the host. If the unplug operation fails,
>    the driver attempts to re-accept (encrypt) the memory. If this
>    re-acceptance fails, the memory is intentionally leaked to prevent
>    confidentiality breaches or fatal hypervisor faults.
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
> 


