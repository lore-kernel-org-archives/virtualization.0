Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4718FDA2
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130889; cv=none; b=GM3plzT3pCeql/u41EzMDCZfDrSKlboo/F8MYqylDAQEqWv8JnQuWGd2rxNDiKLo1tOi3I2Ndiqw6QQQu2Qt+o54boM0hq6CcMOxQGDxCuj97Rr1TlE2MHfeWaKznvzCnjIVFWhEod5jMpgPydJWbHmyVl9w3eJRhZv+MmlyKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130889; c=relaxed/simple;
	bh=hqVVdHyP0GO0EWVvV1Fu13sGpUa11Nqx0KTkMaqHaZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECZqGTac7KCHfh3K8I6GecOSZykUz4JU7ItOdTBW9DUhX6x3zlk+Z8vJdPRwAiFM45SHv/7LutKLzPoU+mqaZmapG0PmjJ2q6+gbqMK9X27NCknYpnT47aIcQmvkeQxlJ6EBywmjWEUgQDqE4P7kiO4Gp7hstCwcRQwu2P4oTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WD7K9CCd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WD7K9CCd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723130887; x=1754666887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hqVVdHyP0GO0EWVvV1Fu13sGpUa11Nqx0KTkMaqHaZI=;
  b=WD7K9CCdl1hlDMAqni3vBa+0mAy1BPG+BSa/0KEAXFO0fxcZZ+ea59l9
   OcEsNm6KBwakwWKEdyockbi6C1iNkts6iTcmMB/dUzm15IDoEN+s9fRbn
   C3aSpykwY0iDuctkKfBrPUzgjPTevT63MqBwfX4zb6qw/5r/HfMP1KGlX
   Z8LN+7ozNSqTb4ro9Of+mftRq46BJrmTh1i31a02xygsl7xSYV4LLU7bU
   RAhHzvam76mf++LJuREdiI13lk56qAkInh/YXT0lbawn6oWDGy+ePJigN
   sLAT3bYMv5w4hrniLvCR+EuM/r4KrB+3NwgVnWTg11HTOBpO+kmgTf/Cj
   g==;
X-CSE-ConnectionGUID: CKx7NUojRyeC3ruUGcA9RQ==
X-CSE-MsgGUID: eDnwvtlCTvSLxB8Q87TnSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21122333"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21122333"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 08:28:06 -0700
X-CSE-ConnectionGUID: kK/XGJ65Sbib/+B2ukQc8w==
X-CSE-MsgGUID: FNopWHpHS9e2KN76mn+Evg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="62105608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 08 Aug 2024 08:28:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DC67B3BA; Thu, 08 Aug 2024 18:28:02 +0300 (EEST)
Date: Thu, 8 Aug 2024 18:28:02 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <lszslulefumddbqnhni55sgdfddptw3yb5vfavgnlyiv6wi3vn@44e4tttbvwaz>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <20240808075701-mutt-send-email-mst@kernel.org>
 <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
 <20240808105006-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808105006-mutt-send-email-mst@kernel.org>

On Thu, Aug 08, 2024 at 11:03:30AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 08, 2024 at 04:15:25PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Aug 08, 2024 at 08:10:34AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> > > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > > accesses during the hang.
> > > > 
> > > > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > > > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > > > 	...
> > > > 
> > > > It was traced down to virtio-console. Kexec works fine if virtio-console
> > > > is not in use.
> > > 
> > > virtio is not doing a lot of 16 bit reads.
> > > Are these the reads:
> > > 
> > >                 virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > >                 virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > > 
> > > ?
> > > 
> > > write is a bit puzzling too. This one?
> > > 
> > > bool vp_notify(struct virtqueue *vq)
> > > {       
> > >         /* we write the queue's selector into the notification register to
> > >          * signal the other end */
> > >         iowrite16(vq->index, (void __iomem *)vq->priv);
> > >         return true;
> > > }
> > 
> > Given that we are talking about console issue, any suggestion on how to
> > check?
> 
> 
> If you do lspci -v on the device, we'll know where the BARs are,
> and can compare to 0x102877002, 0x102877A44.

00:01.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
	Subsystem: Red Hat, Inc. Device 1100
	Flags: bus master, fast devsel, latency 0, IRQ 21
	Memory at 80005000 (32-bit, non-prefetchable) [size=4K]
	Memory at 380000000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [98] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci

00:02.0 Communication controller: Red Hat, Inc. Virtio 1.0 socket (rev 01)
	Subsystem: Red Hat, Inc. Device 1100
	Flags: bus master, fast devsel, latency 0, IRQ 22
	Memory at 80004000 (32-bit, non-prefetchable) [size=4K]
	Memory at 380000004000 (64-bit, prefetchable) [size=16K]
	Capabilities: [98] MSI-X: Enable- Count=3 Masked-
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci

00:03.0 Communication controller: Red Hat, Inc. Virtio 1.0 console (rev 01)
	Subsystem: Red Hat, Inc. Device 1100
	Flags: bus master, fast devsel, latency 0, IRQ 23
	Memory at 80003000 (32-bit, non-prefetchable) [size=4K]
	Memory at 380000008000 (64-bit, prefetchable) [size=16K]
	Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci

00:04.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)
	Subsystem: Red Hat, Inc. Device 1100
	Flags: bus master, fast devsel, latency 0, IRQ 20
	Memory at 80002000 (32-bit, non-prefetchable) [size=4K]
	Memory at 38000000c000 (64-bit, prefetchable) [size=16K]
	Capabilities: [98] MSI-X: Enable+ Count=17 Masked-
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci

00:05.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)
	Subsystem: Red Hat, Inc. Device 1100
	Flags: bus master, fast devsel, latency 0, IRQ 21
	Memory at 80001000 (32-bit, non-prefetchable) [size=4K]
	Memory at 380000010000 (64-bit, prefetchable) [size=16K]
	Capabilities: [98] MSI-X: Enable+ Count=17 Masked-
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci
....
Invalid read at addr 0x100C37904, size 2, region '(null)', reason: rejected
Invalid read at addr 0x1036F9002, size 2, region '(null)', reason: rejected
Invalid read at addr 0x1036F9002, size 2, region '(null)', reason: rejected
Invalid write at addr 0x1036F9A44, size 2, region '(null)', reason: rejected
Invalid read at addr 0x1036F7002, size 2, region '(null)', reason: rejected
Invalid read at addr 0x1036F7002, size 2, region '(null)', reason: rejected
Invalid write at addr 0x1036F7A44, size 2, region '(null)', reason: rejected
....

Yeah, looks like it is not BARs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
