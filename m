Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D8EEA8
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122931; cv=none; b=loJE7L1eVttvVXo8v5mM9bfH+gYCyK9WPPXq4MwmX099H+XlAZVFdbKGicPdvzbESzuExenjDJ0TMZ4LlgoBRBn9x7n7Ap5ql/1F6Jv1En6QXmjCI/EZgGfmKf4l+3x2CGybZzoF0LeooTIHfdpjZzJtLYdXDegK5DOMsmy7MLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122931; c=relaxed/simple;
	bh=N8pWANWB+eqxnggvwNDLltgkeHdajqd+8sIVS1brylI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF9JctvBakFIVV2jttrzzWaNvRY4PnQoSNZid0XNXJfZ2MU1oEHGBjvlygbdD66Dus+/nc689nwYO+IFF4gh271zPQgrRkyQfbg1Q6a5vudn1slkoMAotAZFNa3f9uKR6glvuLS2GA5pcChPlyHrWKJHjmImLzPXfaDBdWtxFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL2leIiv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL2leIiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723122928; x=1754658928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8pWANWB+eqxnggvwNDLltgkeHdajqd+8sIVS1brylI=;
  b=XL2leIivuevWbbmf2ogS1VtxXWVJgMMB3k+yf1+DjJVsId8pdWj3lvkQ
   DZxO9OluPnIUCCx6E+o4b/fwinarzWJ2fQ2snZPI3vkU6GfXJOytzTEQh
   sL5Fd2lierjEk8wt/4g4KlH3dLj6W3F7e/qWHvcojc2E+K1CsJgzi9cLY
   WlVuRyb6mN4jNZ3KspJXGtVONBa0T3KRotmi7NhR8Z2fJkHrRS8GCsL0k
   8Doq0Rorol4ts3PD/PJPXMV3++CVzK/UZXMeFDWFQRIuIa62BJv/D9iYl
   /ndA+b4sgYxJvJZQkyp4sVZpWittBPXRba34Qewhu22bcIQpfr8ektAp7
   g==;
X-CSE-ConnectionGUID: o5KbxHYCScOpsDWa5UWdEw==
X-CSE-MsgGUID: JPKVZMNXRFKvg+Cbo7vgWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46650392"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="46650392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:15:28 -0700
X-CSE-ConnectionGUID: j/tvhK6nRT+q6G028onx/A==
X-CSE-MsgGUID: tS4X46kUTs2ZDrR463gOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57178231"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 06:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 515A64C7; Thu, 08 Aug 2024 16:15:25 +0300 (EEST)
Date: Thu, 8 Aug 2024 16:15:25 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <yknu4iege3drk6t2x7pvm2l2cocg4r5qk5jzmboej6dqk5ym2z@g4clogtuuibe>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <20240808075701-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808075701-mutt-send-email-mst@kernel.org>

On Thu, Aug 08, 2024 at 08:10:34AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > accesses during the hang.
> > 
> > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > 	...
> > 
> > It was traced down to virtio-console. Kexec works fine if virtio-console
> > is not in use.
> 
> virtio is not doing a lot of 16 bit reads.
> Are these the reads:
> 
>                 virtio_cread(vdev, struct virtio_console_config, cols, &cols);
>                 virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> 
> ?
> 
> write is a bit puzzling too. This one?
> 
> bool vp_notify(struct virtqueue *vq)
> {       
>         /* we write the queue's selector into the notification register to
>          * signal the other end */
>         iowrite16(vq->index, (void __iomem *)vq->priv);
>         return true;
> }

Given that we are talking about console issue, any suggestion on how to
check?

> > 
> > Looks like virtio-console continues to write to the MMIO even after
> > underlying virtio-pci device is removed.
> 
> You mention both MMIO and pci, I am confused.

By MMIO, I mean accesses to PCI BARs. But it is only my *guess* on the
situation, I have limited knowledge of the area. I am not drivers guy.

> Removed by what? In what sense?

So device_shutdown() iterates over all device and we hit the problem when
we get to virtio-pci devices and call pci_device_shutdown on them.

I *think* PCI BAR (or something else?) becomes unavailable after that but
it is still accessed.

> > 
> > The problem can be mitigated by removing all virtio devices on virtio
> > bus shutdown.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> 
> A bit worried about doing so much activity on shutdown,
> and for all devices, too. I'd like to understand what
> is going on a bit better - could be a symptom of
> a bigger problem (e.g. missing handling for suprise
> removal?).

I probably should have marked the patch as RFC. The patch was intended to
start conversation. I am not sure it is correct. This patch just happened
to work in our setup.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
