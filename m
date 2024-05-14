Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48117F377;
	Tue, 14 May 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702785; cv=none; b=NEun3Um9bEGGnquTheASlTXH63mi1bPm5ZVu+FTWuwFueyni+RyBmocKJefY4YX4Amxutidy6DDG4MnKTLzYhKqlrm5oRnNCH1BuBTgoTgqipGeGuIfmxxgtP6sS/d7fx5v/Pkk+8oc4a7+HD3uiKKym3s4ClgmyuNA/VMKGNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702785; c=relaxed/simple;
	bh=3VTQ+qFOzuuwKQuIMtg6jrQG+DYa6Ub+oWWIBNCsk9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h10eteANwmfv1WXSneaG3/GPXjJGvP8WgOMOaL4r+kKqG79eN58j2ngNZADIjiNuxlmcBz9E18bkx1WDwh2HCsNnfPEGzKwrV7ILQBwP+gOpjhjNRrnPA8sfG3zX3oUHgJGAb8iPvcXTbYV1XhaXvAeKm78DFvC/6jRqbLZfOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUqFM2oB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUqFM2oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AF9C2BD10;
	Tue, 14 May 2024 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715702784;
	bh=3VTQ+qFOzuuwKQuIMtg6jrQG+DYa6Ub+oWWIBNCsk9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUqFM2oBjAvHJ/UAsphzwNVxAS/h89U5UNISVKOlo6P7HmSfPZaNT3cbWEfj5zGdj
	 G2TagUbzZMfzxu4VP5MvOZhiEUlxbC6ypsUF0Sv1nxg0L03EB0prEA4cf0DvTe562e
	 G0nQx62d8SGgLPVvtfsUqZ7nxV20q/vh8fUjXS6k=
Date: Tue, 14 May 2024 18:06:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, dev@lists.cloudhypervisor.org
Subject: Re: [RFC PATCH v1 1/2] virt: memctl: control guest physical memory
 properties
Message-ID: <2024051414-untie-deviant-ed35@gregkh>
References: <20240514020301.1835794-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514020301.1835794-1-yuanchu@google.com>

On Mon, May 13, 2024 at 07:03:00PM -0700, Yuanchu Xie wrote:
> Memctl provides a way for the guest to control its physical memory
> properties, and enables optimizations and security features. For
> example, the guest can provide information to the host where parts of a
> hugepage may be unbacked, or sensitive data may not be swapped out, etc.
> 
> Memctl allows guests to manipulate its gPTE entries in the SLAT, and
> also some other properties of the memory map the back's host memory.
> This is achieved by using the KVM_CAP_SYNC_MMU capability. When this
> capability is available, the changes in the backing of the memory region
> on the host are automatically reflected into the guest. For example, an
> mmap() or madvise() that affects the region will be made visible
> immediately.
> 
> There are two components of the implementation: the guest Linux driver
> and Virtual Machine Monitor (VMM) device. A guest-allocated shared
> buffer is negotiated per-cpu through a few PCI MMIO registers, the VMM
> device assigns a unique command for each per-cpu buffer. The guest
> writes its memctl request in the per-cpu buffer, then writes the
> corresponding command into the command register, calling into the VMM
> device to perform the memctl request.
> 
> The synchronous per-cpu shared buffer approach avoids the kick and busy
> waiting that the guest would have to do with virtio virtqueue transport.
> 
> We provide both kernel and userspace APIs
> Kernel API
> long memctl_vmm_call(__u64 func_code, __u64 addr, __u64 length, __u64 arg,
> 		     struct memctl_buf *buf);
> 
> Kernel drivers can take advantage of the memctl calls to provide
> paravirtualization of kernel stacks or page zeroing.
> 
> User API
> >From the userland, the memctl guest driver is controlled via ioctl(2)
> call. It requires CAP_SYS_ADMIN.
> 
> ioctl(fd, MEMCTL_IOCTL, union memctl_vmm *memctl_vmm);
> 
> Guest userland applications can tag VMAs and guest hugepages, or advise
> the host on how to handle sensitive guest pages.
> 
> Supported function codes and their use cases:
> MEMCTL_FREE/REMOVE/DONTNEED/PAGEOUT. For the guest. One can reduce the
> struct page and page table lookup overhead by using hugepages backed by
> smaller pages on the host. These memctl commands can allow for partial
> freeing of private guest hugepages to save memory. They also allow
> kernel memory, such as kernel stacks and task_structs to be
> paravirtualized.
> 
> MEMCTL_UNMERGEABLE is useful for security, when the VM does not want to
> share its backing pages.
> The same with MADV_DONTDUMP, so sensitive pages are not included in a
> dump.
> MLOCK/UNLOCK can advise the host that sensitive information is not
> swapped out on the host.
> 
> MEMCTL_MPROTECT_NONE/R/W/RW. For guest stacks backed by hugepages, stack
> guard pages can be handled in the host and memory can be saved in the
> hugepage.
> 
> MEMCTL_SET_VMA_ANON_NAME is useful for observability and debugging how
> guest memory is being mapped on the host.
> 
> Sample program making use of MEMCTL_SET_VMA_ANON_NAME and
> MEMCTL_DONTNEED:
> https://github.com/Dummyc0m/memctl-set-anon-vma-name/tree/main
> https://github.com/Dummyc0m/memctl-set-anon-vma-name/tree/dontneed
> 
> The VMM implementation is being proposed for Cloud Hypervisor:
> https://github.com/Dummyc0m/cloud-hypervisor/
> 
> Cloud Hypervisor issue:
> https://github.com/cloud-hypervisor/cloud-hypervisor/issues/6318
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>  drivers/virt/Kconfig                          |   2 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/memctl/Kconfig                   |  10 +
>  drivers/virt/memctl/Makefile                  |   2 +
>  drivers/virt/memctl/memctl.c                  | 425 ++++++++++++++++++
>  include/linux/memctl.h                        |  27 ++
>  include/uapi/linux/memctl.h                   |  81 ++++

You are mixing your PCI driver in with the memctl core code, is that
intentional?  Will there never be another PCI device for this type of
interface other than this one PCI device?

And if so, why export anything, why isn't this all in one body of code?

>  8 files changed, 550 insertions(+)
>  create mode 100644 drivers/virt/memctl/Kconfig
>  create mode 100644 drivers/virt/memctl/Makefile
>  create mode 100644 drivers/virt/memctl/memctl.c
>  create mode 100644 include/linux/memctl.h
>  create mode 100644 include/uapi/linux/memctl.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..789d1251c0be 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -368,6 +368,8 @@ Code  Seq#    Include File                                           Comments
>  0xCD  01     linux/reiserfs_fs.h
>  0xCE  01-02  uapi/linux/cxl_mem.h                                    Compute Express Link Memory Devices
>  0xCF  02     fs/smb/client/cifs_ioctl.h
> +0xDA  00     linux/memctl.h                                          Memctl Device
> +                                                                     <mailto:yuanchu@google.com>
>  0xDB  00-0F  drivers/char/mwave/mwavepub.h
>  0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
>                                                                       <mailto:aherrman@de.ibm.com>
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 40129b6f0eca..419496558cfc 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -50,4 +50,6 @@ source "drivers/virt/acrn/Kconfig"
>  
>  source "drivers/virt/coco/Kconfig"
>  
> +source "drivers/virt/memctl/Kconfig"
> +
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index f29901bd7820..68e152e7cef1 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -10,3 +10,4 @@ obj-y				+= vboxguest/
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
>  obj-y				+= coco/
> +obj-$(CONFIG_MEMCTL)		+= memctl/
> diff --git a/drivers/virt/memctl/Kconfig b/drivers/virt/memctl/Kconfig
> new file mode 100644
> index 000000000000..981ed9b76f97
> --- /dev/null
> +++ b/drivers/virt/memctl/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config MEMCTL
> +	tristate "memctl Guest Service Module"
> +	depends on KVM_GUEST && 64BIT
> +	help
> +	  memctl is a guest kernel module that allows to communicate
> +	  with hypervisor / VMM and control the guest memory backing.
> +
> +	  To compile as a module, choose M, the module will be called
> +	  memctl. If unsure, say N.

Pretty generic name for a hardware-specific driver :(



> diff --git a/drivers/virt/memctl/Makefile b/drivers/virt/memctl/Makefile
> new file mode 100644
> index 000000000000..410829a3c297
> --- /dev/null
> +++ b/drivers/virt/memctl/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_MEMCTL)	:= memctl.o
> diff --git a/drivers/virt/memctl/memctl.c b/drivers/virt/memctl/memctl.c
> new file mode 100644
> index 000000000000..661a552f98d8
> --- /dev/null
> +++ b/drivers/virt/memctl/memctl.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Control guest memory mappings
> + *
> + * Author: Yuanchu Xie <yuanchu@google.com>
> + * Author: Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +#define pr_fmt(fmt) "memctl %s: " fmt, __func__

You have real devices here, use dev_*() calls instead of pr_*() please,
which means you can remove this define.


> +
> +#include <linux/spinlock.h>
> +#include <linux/cpumask.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/percpu.h>
> +#include <linux/types.h>
> +#include <linux/gfp.h>
> +#include <linux/compiler.h>
> +#include <linux/fs.h>
> +#include <linux/sched/clock.h>
> +#include <linux/wait.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/resource_ext.h>
> +#include <linux/memctl.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +
> +#define PCI_VENDOR_ID_GOOGLE		0x1ae0
> +#define PCI_DEVICE_ID_GOOGLE_MEMCTL	0x0087
> +
> +#define MEMCTL_VERSION "0.01"

Versions mean nothing once code is merged, please remove this.

> +
> +enum memctl_transport_command {
> +	MEMCTL_TRANSPORT_RESET = 0x060FE6D2,
> +	MEMCTL_TRANSPORT_REGISTER = 0x0E359539,
> +	MEMCTL_TRANSPORT_READY = 0x0CA8D227,
> +	MEMCTL_TRANSPORT_DISCONNECT = 0x030F5DA0,
> +	MEMCTL_TRANSPORT_ACK = 0x03CF5196,
> +	MEMCTL_TRANSPORT_ERROR = 0x01FBA249,

What are these magic values?  What endian are they, native?  Hardware?
something else?

> +};
> +
> +struct memctl_transport {
> +	union {
> +		struct {
> +			u64 buf_phys_addr;
> +		} reg;
> +		struct {
> +			u32 command;
> +			u32 _padding;
> +		} resp;

Endain-ness of all of this as it goes to the hardware, right?

> +	};
> +	u32 command;
> +};
> +
> +struct memctl_percpu_channel {
> +	struct memctl_buf buf;
> +	u64 buf_phys_addr;
> +	u32 command;
> +};
> +
> +struct memctl {
> +	void __iomem *base_addr;
> +	/* cache the info call */
> +	struct memctl_vmm_info memctl_vmm_info;
> +	struct memctl_percpu_channel __percpu *pcpu_channels;
> +};
> +
> +static DEFINE_RWLOCK(memctl_lock);
> +static struct memctl *memctl __read_mostly;
> +
> +static void memctl_write_command(void __iomem *base_addr, u32 command)
> +{
> +	iowrite32(command,
> +		  base_addr + offsetof(struct memctl_transport, command));

Yup, you write this to hardware, please use proper structures and types
for that, otherwise you will have problems in the near future.

thanks,

greg k-h
