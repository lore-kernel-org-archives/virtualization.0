From: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread is
 a kthread
Date: Mon, 6 Apr 2020 23:08:46 -0400
Message-ID: <20200407030845.GA10586@joy-OptiPlex-7040>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200404094101.672954-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 04, 2020 at 11:40:57AM +0200, Christoph Hellwig wrote:
> Use the proper API instead.
> 
> Fixes: f440c8a572d7 ("drm/i915/gvt/kvmgt: read/write GPA via KVM API")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index 074c4efb58eb..5848400620b4 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -2037,7 +2037,7 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
>  	struct kvmgt_guest_info *info;
>  	struct kvm *kvm;
>  	int idx, ret;
> -	bool kthread = current->mm == NULL;
> +	bool kthread = (current->flags & PF_KTHREAD);
>  
>  	if (!handle_valid(handle))
>  		return -ESRCH;
> -- 
> 2.25.1
>
hi
we were removing this code. see
https://lore.kernel.org/kvm/20200313031109.7989-1-yan.y.zhao@intel.com/

The implementation of vfio_dma_rw() has been in vfio next tree.
https://github.com/awilliam/linux-vfio/commit/8d46c0cca5f4dc0538173d62cd36b1119b5105bc

in vfio_dma_rw(),  we still use
bool kthread = current->mm == NULL.
because if current->mm != NULL and current->flags & PF_KTHREAD, instead
of calling use_mm(), we first check if (current->mm == mm) and allow copy_to_user() if it's true.

Do you think it's all right?

Thanks
Yan



> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
