Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1B18CC1D;
	Sat,  4 Jan 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735982180; cv=none; b=CyKpryiDzZ/R5SL+tCi1hDYcMr1HQFPZm8NdaJjmAcwOsbHoLWp15Qdv1XDjeDu10HUpEGULlDl4D/ebUfqU27Cyczfk4ZAVBp6aGCTVdvJqKHz1HRGtf90idYIVA2c8RJrGTbvkOXliTGB75G/V/Yne17bdCU5NwcpQdqYobtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735982180; c=relaxed/simple;
	bh=6VBIhXx0eivTlNHc2gJrHjg2QXuMuBMEWXQy/CT7ASE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6EaG1DKcQASs/JcFTm5xE4vO3w7Yq4g6Npct4Or2D8i0k8YX3zlFOaTVHi1S5EprqlMIssjH/s7ZCiGwbBB3wky12dJo2SeOQ/ZtPFzX1Jt10mx0tVRwuZDNPxMkrfwXbdcn2pw/U1vwHhRp5W+4nvHHJneQJh+vD9ymBfNPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4uzfjBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4uzfjBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A06C4CED1;
	Sat,  4 Jan 2025 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735982179;
	bh=6VBIhXx0eivTlNHc2gJrHjg2QXuMuBMEWXQy/CT7ASE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4uzfjBuHB/1X3vOeSx39WvaaW/y89VKoT8fvU+3fipJnwtmLPncurGunWvxm0HXs
	 Y5AuKSc61ruvgtmw43UrYiHe1gUrF4SSBdXoCPHDafo9Y3BPkstyQuW6/CRhnlUztW
	 mzcSIIWaguGYVwPXDcoAKlDJcYkGAuG7f58Ha7+w=
Date: Sat, 4 Jan 2025 10:15:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [PATCH v5 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <2025010448-citizen-untrained-d607@gregkh>
References: <20241203002328.694071-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203002328.694071-1-yuanchu@google.com>

On Mon, Dec 02, 2024 at 04:23:27PM -0800, Yuanchu Xie wrote:
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
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> 
> ---
> PATCH v4 -> v5
> - use drvdata and friends to enable multiple devices

And now you are "burning" a whole major number for this, right?  Why not
just use a misc device for every individual one?  That should be much
simpler and take away a lot of the generic code you have added here
(your class structure, your major/minor number handling, etc.)

> PATCH v3 -> v4
> - changed dev_info to dev_dbg so the driver is quiet when it works
>   properly.
> - Edited the changelog section to be included in the diffstat.
> 
> PATCH v2 -> v3
> - added PVMEMCONTROL_MERGEABLE for memory dedupe.
> - updated link to the upstream Cloud Hypervisor repo, and specify the
>   feature required to enable the device.
> 
> PATCH v1 -> v2
> - fixed byte order sparse warning. ioread/write already does
>   little-endian.
> - add include for linux/percpu.h
> 
> RFC v1 -> PATCH v1
> - renamed memctl to pvmemcontrol
> - defined device endianness as little endian
> 
> v1:
> https://lore.kernel.org/linux-mm/20240518072422.771698-1-yuanchu@google.com/
> v2:
> https://lore.kernel.org/linux-mm/20240612021207.3314369-1-yuanchu@google.com/
> v3:
> https://lore.kernel.org/linux-mm/20241016193947.48534-1-yuanchu@google.com/
> v4:
> https://lore.kernel.org/linux-mm/20241021204849.1580384-1-yuanchu@google.com/
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>  drivers/virt/Kconfig                          |   2 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/pvmemcontrol/Kconfig             |  10 +
>  drivers/virt/pvmemcontrol/Makefile            |   2 +
>  drivers/virt/pvmemcontrol/pvmemcontrol.c      | 499 ++++++++++++++++++

Why a whole subdirectory for just one .c file?  Why not put it in
drivers/virt/ ?

thanks,

greg k-h
