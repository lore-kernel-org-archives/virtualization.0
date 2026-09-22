Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FE51C343
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080970; cv=none; b=McXDm2vaYLD5VKNgPF6I6rn1w9dWvjVm1VJcU2NOcdwqsGubrv/kUnE/il4UeSpYlsU7G8Ls3a0deKR3/nOT+Jea9JunqC/Lj/u0ikSIkwKQC2fAei2xdAl+aMLq0oMhdJipfwbCJD9iMl8wrK9Ja3K7xwhloFflxo0BrFHbEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080970; c=relaxed/simple;
	bh=0dv7Kq/Y2yfMwe2pkAmACfumsi7lCkjcetzeVbja76g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r+0VSrWDm6qxhw3j4vNSZVOQo7YfAZCpzL/GhEltN4CEzOAEDQHjOqHSPpDAceEwMG10Cc5I717MW7xUEOZmBITMRsQrBd1RjAFvyxya9ZIi70FNYjP2kRsrCK8iwExQhXQk/eJsDzlGG2b888PcSJd7np8jIflkOOJQZJQuplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieT9sz6m; arc=none smtp.client-ip=91.218.175.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ieT9sz6m"
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0dv7Kq/Y2yfMwe2pkAmACfumsi7lCkjcetzeVbja76g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790080966; v=1; x=1790685766;
 b=ieT9sz6mHyeM093cXvzTQQPW4bIaaSYVr/A9mFbhQEBF/Lub6w63VEYQGSWYwh6J+mIMwZoP
 fKyxlry9ECw6Gbgsk2egw/Bg5Y20VhBjd6r56t1lPeJ6zMScpEtgr1mvmcxsqv5gSvuV+Nt/nxz
 7ZtXbitvAQtzPvt8UbnVwFVI=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 739340d0d575985b;
	Tue, 22 Sep 2026 12:42:46 +0000
X-Mizu-Trace-ID: 739340d0d575985b
X-Migadu-Flow: FLOW_OUT
Message-ID: <c8afe60f-d475-42d4-a325-b93272ec92a4@linux.dev>
Date: Tue, 22 Sep 2026 20:42:37 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio_pci?] WARNING: possible circular locking dependency
 detected
From: Zenghui Yu <zenghui.yu@linux.dev>
To: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, nicolinc@nvidia.com,
 jgg@ziepe.ca
References: <98f2f4f9-a7fe-413e-a366-7bed08290697@linux.dev>
Content-Language: en-US
In-Reply-To: <98f2f4f9-a7fe-413e-a366-7bed08290697@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 8:37 PM, Zenghui Yu wrote:
> Hi folks,
> 
> I hit the following lockdep splat in an arm64 guest whose PCI devices sit
> behind an SMMUv3.

The complete log is:

 ======================================================
 WARNING: possible circular locking dependency detected
 7.3.0-rc1+ #84 Not tainted
 ------------------------------------------------------
 kworker/u34:0/57 is trying to acquire lock:
 ffff800104f83ee8 (&md->mutex){+.+.}-{4:4}, at: msi_domain_get_virq+0xf0/0x118
        
 but task is already holding lock:
 ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c
        
 which lock already depends on the new lock.

        
 the existing dependency chain (in reverse order) is:
        
 -> #3 (cpu_hotplug_lock){++++}-{0:0}:
        percpu_down_read_internal.constprop.0+0x3c/0x154
        __cpuhp_state_add_instance+0x24/0x54
        iova_domain_init_rcaches+0x240/0x2e4
        iommu_setup_dma_ops+0x1e0/0x5c8
        iommu_device_register+0x174/0x2a8
        arm_smmu_device_probe+0x10b4/0x1558
        platform_probe+0x5c/0xac
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __driver_attach+0x7c/0x1e0
        bus_for_each_dev+0x74/0xd0
        driver_attach+0x24/0x30
        bus_add_driver+0xfc/0x27c
        driver_register+0x60/0x128
        __platform_driver_register+0x28/0x34
        arm_smmu_driver_init+0x28/0x34
        do_one_initcall+0x64/0x530
        kernel_init_freeable+0x28c/0x458
        kernel_init+0x2c/0x1e4
        ret_from_fork+0x10/0x20
   
 -> #2 (&group->mutex){+.+.}-{4:4}:
        __mutex_lock+0x90/0x858
        mutex_lock_nested+0x24/0x30
        iommu_dma_prepare_msi+0x38/0xf8
        gicv2m_irq_domain_alloc+0xf4/0x274
        irq_domain_alloc_irqs_parent+0x24/0x38
        msi_domain_alloc+0x7c/0x144
        irq_domain_alloc_irqs_locked+0x140/0x3ec
        __irq_domain_alloc_irqs+0x70/0xc4
        __msi_domain_alloc_irqs+0x19c/0x514
        __msi_domain_alloc_locked+0x134/0x188
        msi_domain_alloc_irqs_all_locked+0x54/0xb4
        pci_msi_setup_msi_irqs+0x38/0x44
        __pci_enable_msix_range+0x3b4/0x5ac
        pci_alloc_irq_vectors_affinity+0xc0/0x138
        vp_find_vqs_msix+0x2dc/0x548
        vp_find_vqs+0x44/0x2ac
        vp_modern_find_vqs+0x1c/0x70
        init_vq+0x298/0x468
        virtblk_probe+0x168/0x948
        virtio_dev_probe+0x1bc/0x2ec
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        device_add+0x654/0x874
        register_virtio_device+0x20c/0x264
        virtio_pci_probe+0x100/0x1e0
        local_pci_probe+0x40/0xa8
        pci_call_probe+0x64/0x2ec
        pci_device_probe+0xac/0x134
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        deferred_probe_work_func+0xcc/0x11c
        process_one_work+0x264/0x87c
        worker_thread+0x230/0x374
        kthread+0x138/0x144
        ret_from_fork+0x10/0x20

 -> #1 (&domain->mutex){+.+.}-{4:4}:
        __mutex_lock+0x90/0x858
        mutex_lock_nested+0x24/0x30
        __irq_domain_alloc_irqs+0x50/0xc4
        __msi_domain_alloc_irqs+0x19c/0x514
        __msi_domain_alloc_locked+0x134/0x188
        msi_domain_alloc_irqs_all_locked+0x54/0xb4
        pci_msi_setup_msi_irqs+0x38/0x44
        __pci_enable_msix_range+0x3b4/0x5ac
        pci_alloc_irq_vectors_affinity+0xc0/0x138
        vp_find_vqs_msix+0x2dc/0x548
        vp_find_vqs+0x44/0x2ac
        vp_modern_find_vqs+0x1c/0x70
        init_vq+0x298/0x468
        virtblk_probe+0x168/0x948
        virtio_dev_probe+0x1bc/0x2ec
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        device_add+0x654/0x874
        register_virtio_device+0x20c/0x264
        virtio_pci_probe+0x100/0x1e0
        local_pci_probe+0x40/0xa8
        pci_call_probe+0x64/0x2ec
        pci_device_probe+0xac/0x134
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        deferred_probe_work_func+0xcc/0x11c
        process_one_work+0x264/0x87c
        worker_thread+0x230/0x374
        kthread+0x138/0x144
        ret_from_fork+0x10/0x20

 -> #0 (&md->mutex){+.+.}-{4:4}:
        __lock_acquire+0x13b0/0x20e4
        lock_acquire+0x1e4/0x468
        __mutex_lock+0x90/0x858
        mutex_lock_nested+0x24/0x30
        msi_domain_get_virq+0xf0/0x118
        pci_irq_vector+0x34/0x5c
        vp_set_vq_affinity+0x60/0xd0
        virtnet_set_affinity+0x18c/0x2dc
        virtnet_probe+0x650/0xdcc
        virtio_dev_probe+0x1bc/0x2ec
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        device_add+0x654/0x874
        register_virtio_device+0x20c/0x264
        virtio_pci_probe+0x100/0x1e0
        local_pci_probe+0x40/0xa8
        pci_call_probe+0x64/0x2ec
        pci_device_probe+0xac/0x134
        really_probe+0xe0/0x34c
        __driver_probe_device+0x198/0x1c8
        driver_probe_device+0x40/0x11c
        __device_attach_driver+0xd4/0x14c
        bus_for_each_drv+0x80/0xdc
        __device_attach+0xa8/0x1c8
        device_initial_probe+0x50/0x54
        bus_probe_device+0x38/0xa8
        deferred_probe_work_func+0xcc/0x11c
        process_one_work+0x264/0x87c
        worker_thread+0x230/0x374
        kthread+0x138/0x144
        ret_from_fork+0x10/0x20

 other info that might help us debug this:

 Chain exists of:
   &md->mutex --> &group->mutex --> cpu_hotplug_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(cpu_hotplug_lock);
                                lock(&group->mutex);
                                lock(cpu_hotplug_lock);
   lock(&md->mutex);

  *** DEADLOCK ***

 locks held by kworker/u34:0/57: 5, last CPU#7:
  #0: ffff8000004a2940 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x6d4/0x87c
  #1: ffffc00083d63df0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x214/0x87c
  #2: ffff800001c441f8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x38/0x1c8
  #3: ffff800104f2b1b0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x38/0x1c8
  #4: ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c

 stack backtrace:
 CPU: 7 UID: 0 PID: 57 Comm: kworker/u34:0 Not tainted 7.3.0-rc1+ #84 PREEMPT
 Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202608-prebuilt.qemu.org 08/12/2026
 Workqueue: events_unbound deferred_probe_work_func
 Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0xd8/0x168
  dump_stack+0x18/0x24
  print_circular_bug+0x294/0x378
  check_noncircular+0x15c/0x170
  __lock_acquire+0x13b0/0x20e4
  lock_acquire+0x1e4/0x468
  __mutex_lock+0x90/0x858
  mutex_lock_nested+0x24/0x30
  msi_domain_get_virq+0xf0/0x118
  pci_irq_vector+0x34/0x5c
  vp_set_vq_affinity+0x60/0xd0
  virtnet_set_affinity+0x18c/0x2dc
  virtnet_probe+0x650/0xdcc
  virtio_dev_probe+0x1bc/0x2ec
  really_probe+0xe0/0x34c
  __driver_probe_device+0x198/0x1c8
  driver_probe_device+0x40/0x11c
  __device_attach_driver+0xd4/0x14c
  bus_for_each_drv+0x80/0xdc
  __device_attach+0xa8/0x1c8
  device_initial_probe+0x50/0x54
  bus_probe_device+0x38/0xa8
  device_add+0x654/0x874
  register_virtio_device+0x20c/0x264
  virtio_pci_probe+0x100/0x1e0
  local_pci_probe+0x40/0xa8
  pci_call_probe+0x64/0x2ec
  pci_device_probe+0xac/0x134
  really_probe+0xe0/0x34c
  __driver_probe_device+0x198/0x1c8
  driver_probe_device+0x40/0x11c
  __device_attach_driver+0xd4/0x14c
  bus_for_each_drv+0x80/0xdc
  __device_attach+0xa8/0x1c8
  device_initial_probe+0x50/0x54
  bus_probe_device+0x38/0xa8
  deferred_probe_work_func+0xcc/0x11c
  process_one_work+0x264/0x87c
  worker_thread+0x230/0x374
  kthread+0x138/0x144
  ret_from_fork+0x10/0x20
