Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096D2144CE;
	Wed, 16 Oct 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107777; cv=none; b=ap+xgehOjxuXqKEsDr+0cOroUyhJYZkWSDzcyIsOEWgYFKhUJ0QUZ+qYteDJwkTbHbyA9V9sY4aPnHMiUdogJA38X3019XuhEh2CYsPt3ZcL49PBlMyNnWkbI2zBMYqVxoeR3KYqm2+gD0tqodDHUs7oZfg7KxcoEs6raju7g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107777; c=relaxed/simple;
	bh=LLzFnTpTL1+XFRq4+TKXAgrc///vCyQPUGO2IHwl6Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+086pJyNtyuJEwqZXnzbYxLWQJEj32i/fRBoOp5YGmRj2nCVMdc4xfT8+vro+LB+9DsCfmTOe2Jg2vlrKAeBjUB3q3PBD+ewvmAytuz0RUc2/gO3RcDMf0QE1pBe1t1zvTbPiF4VOvKwCN/V4uESnY80TwiEIuW/wvri+0CgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NMHJxKd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NMHJxKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E39CC4CECD;
	Wed, 16 Oct 2024 19:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729107777;
	bh=LLzFnTpTL1+XFRq4+TKXAgrc///vCyQPUGO2IHwl6Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0NMHJxKdPXrNVTJJELxvcjP6EXndmZPKY/cVa8r0jrIipsik5JX8iDyHowdWGprVf
	 9/NrWwBchzPp3veG3nCJTj5bZtgrghrA/UrbB3NhfiaDta1rG+G1i1KcQYazyRbnHr
	 tYnYkPICnlWj/mOfQIIsaTXRNwNGrRy9DzO3sJQI=
Date: Wed, 16 Oct 2024 21:42:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v3 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2024101628-audibly-maverick-e1fe@gregkh>
References: <20241016193947.48534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016193947.48534-1-yuanchu@google.com>

On Wed, Oct 16, 2024 at 12:39:46PM -0700, Yuanchu Xie wrote:
> Pvmemcontrol provides a way for the guest to control its physical memory
> properties and enables optimizations and security features. For example,
> the guest can provide information to the host where parts of a hugepage
> may be unbacked, or sensitive data may not be swapped out, etc.
> 
> Pvmemcontrol allows guests to manipulate its gPTE entries in the SLAT,
> and also some other properties of the memory mapping on the host.
> This is achieved by using the KVM_CAP_SYNC_MMU capability. When this
> capability is available, the changes in the backing of the memory region
> on the host are automatically reflected into the guest. For example, an
> mmap() or madvise() that affects the region will be made visible
> immediately.
> 
> There are two components of the implementation: the guest Linux driver
> and Virtual Machine Monitor (VMM) device. A guest-allocated shared
> buffer is negotiated per-cpu through a few PCI MMIO registers; the VMM
> device assigns a unique command for each per-cpu buffer. The guest
> writes its pvmemcontrol request in the per-cpu buffer, then writes the
> corresponding command into the command register, calling into the VMM
> device to perform the pvmemcontrol request.
> 
> The synchronous per-cpu shared buffer approach avoids the kick and busy
> waiting that the guest would have to do with virtio virtqueue transport.
> 
> User API
> >From the userland, the pvmemcontrol guest driver is controlled via the
> ioctl(2) call. It requires CAP_SYS_ADMIN.
> 
> ioctl(fd, PVMEMCONTROL_IOCTL, struct pvmemcontrol_buf *buf);
> 
> Guest userland applications can tag VMAs and guest hugepages, or advise
> the host on how to handle sensitive guest pages.
> 
> Supported function codes and their use cases:
> PVMEMCONTROL_FREE/REMOVE/DONTNEED/PAGEOUT. For the guest. One can reduce
> the struct page and page table lookup overhead by using hugepages backed
> by smaller pages on the host. These pvmemcontrol commands can allow for
> partial freeing of private guest hugepages to save memory. They also
> allow kernel memory, such as kernel stacks and task_structs to be
> paravirtualized if we expose kernel APIs.
> 
> PVMEMCONTROL_MERGEABLE can inform the host KSM to deduplicate VM pages.
> 
> PVMEMCONTROL_UNMERGEABLE is useful for security, when the VM does not
> want to share its backing pages.
> The same with PVMEMCONTROL_DONTDUMP, so sensitive pages are not included
> in a dump.
> MLOCK/UNLOCK can advise the host that sensitive information is not
> swapped out on the host.
> 
> PVMEMCONTROL_MPROTECT_NONE/R/W/RW. For guest stacks backed by hugepages,
> stack guard pages can be handled in the host and memory can be saved in
> the hugepage.
> 
> PVMEMCONTROL_SET_VMA_ANON_NAME is useful for observability and debugging
> how guest memory is being mapped on the host.
> 
> Sample program making use of PVMEMCONTROL_DONTNEED:
> https://github.com/Dummyc0m/pvmemcontrol-user
> 
> The VMM implementation is part of Cloud Hypervisor, the feature
> pvmemcontrol can be enabled and the VMM can then provide the device to a
> supporting guest.
> https://github.com/cloud-hypervisor/cloud-hypervisor
> 
> -
> Changelog
> PATCH v2 -> v3
> - added PVMEMCONTROL_MERGEABLE for memory dedupe.
> - updated link to the upstream Cloud Hypervisor repo, and specify the
>   feature required to enable the device.
> PATCH v1 -> v2
> - fixed byte order sparse warning. ioread/write already does
>   little-endian.
> - add include for linux/percpu.h
> RFC v1 -> PATCH v1
> - renamed memctl to pvmemcontrol
> - defined device endianness as little endian

As per the kernel documentation, this changelog is in the wrong place.
Please put it in the correct location.

thanks,

greg k-h
