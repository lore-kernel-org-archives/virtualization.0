Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1154BD6
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNAtmNsc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B60FF814B1
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 14:51:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B60FF814B1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eNAtmNsc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l5Lh7MOVlZer
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 14:51:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 31AB98138E
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 14:51:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31AB98138E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700664702; x=1732200702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Lp3IDM3ar4jYOzHbknAigUjAPfa74EA/HlhJuCNIfU=;
  b=eNAtmNscaJTe8CMwrAV3+nxQdYIaonSHUjF6TnitWnAvqu606iHshhON
   ZbMYeSIeiXODrpFSob0rqVYuBl/BGgfUTW1m5+cO9BjUG3lEgBlXn0y1Q
   FFiNCaZ+Dpw7efnJbC3raelwu99x6wbI26gGJP03xdrNGGzAWBQeECZfB
   tj/bgA2hMWJc/RwEQ5KOm8zWhQIbx5V5fMlQljLONMNFMC8fvMk2GEJ0I
   54MHG0gs8EWsTuu4isd4c/a682gGgwfiND61fbRvwSy7RKL3Q7liShSna
   oig3HXu7fIcfm7eF21EF2MelarU5DOi4oEjJauZZxgZ967GWxtepBQ1TZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10729187"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="10729187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 06:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="14944713"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 22 Nov 2023 06:51:20 -0800
Date: Wed, 22 Nov 2023 22:49:27 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Oded Gabbay <ogabbay@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.a.wang@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fpga@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-usb@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-aio@kvack.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Subject: Re: [PATCH v2 2/4] eventfd: simplify eventfd_signal()
Message-ID: <ZV4U96z12KSi4GGw@yilunxu-OptiPlex-7050>
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
 <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>

On Wed, Nov 22, 2023 at 01:48:23PM +0100, Christian Brauner wrote:
> Ever since the evenfd type was introduced back in 2007 in commit
> e1ad7468c77d ("signal/timer/event: eventfd core") the eventfd_signal()
> function only ever passed 1 as a value for @n. There's no point in
> keeping that additional argument.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  arch/x86/kvm/hyperv.c                     |  2 +-
>  arch/x86/kvm/xen.c                        |  2 +-
>  drivers/accel/habanalabs/common/device.c  |  2 +-
>  drivers/fpga/dfl.c                        |  2 +-
>  drivers/gpu/drm/drm_syncobj.c             |  6 +++---
>  drivers/gpu/drm/i915/gvt/interrupt.c      |  2 +-
>  drivers/infiniband/hw/mlx5/devx.c         |  2 +-
>  drivers/misc/ocxl/file.c                  |  2 +-
>  drivers/s390/cio/vfio_ccw_chp.c           |  2 +-
>  drivers/s390/cio/vfio_ccw_drv.c           |  4 ++--
>  drivers/s390/cio/vfio_ccw_ops.c           |  6 +++---
>  drivers/s390/crypto/vfio_ap_ops.c         |  2 +-
>  drivers/usb/gadget/function/f_fs.c        |  4 ++--
>  drivers/vdpa/vdpa_user/vduse_dev.c        |  6 +++---
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |  2 +-
>  drivers/vfio/pci/vfio_pci_core.c          |  6 +++---
>  drivers/vfio/pci/vfio_pci_intrs.c         | 12 ++++++------
>  drivers/vfio/platform/vfio_platform_irq.c |  4 ++--
>  drivers/vhost/vdpa.c                      |  4 ++--
>  drivers/vhost/vhost.c                     | 10 +++++-----
>  drivers/vhost/vhost.h                     |  2 +-
>  drivers/virt/acrn/ioeventfd.c             |  2 +-
>  drivers/xen/privcmd.c                     |  2 +-
>  fs/aio.c                                  |  2 +-
>  fs/eventfd.c                              |  9 +++------
>  include/linux/eventfd.h                   |  4 ++--
>  mm/memcontrol.c                           | 10 +++++-----
>  mm/vmpressure.c                           |  2 +-
>  samples/vfio-mdev/mtty.c                  |  4 ++--
>  virt/kvm/eventfd.c                        |  4 ++--
>  30 files changed, 60 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index dd7a783d53b5..e73f88050f08 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1872,7 +1872,7 @@ static irqreturn_t dfl_irq_handler(int irq, void *arg)
>  {
>  	struct eventfd_ctx *trigger = arg;
>  
> -	eventfd_signal(trigger, 1);
> +	eventfd_signal(trigger);

For FPGA part,

Acked-by: Xu Yilun <yilun.xu@intel.com>

>  	return IRQ_HANDLED;
>  }
