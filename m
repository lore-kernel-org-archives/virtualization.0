From: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread is
 a kthread
Date: Mon, 13 Apr 2020 20:04:10 -0400
Message-ID: <20200414000410.GE10586@joy-OptiPlex-7040>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
 <20200407030845.GA10586@joy-OptiPlex-7040>
 <20200413132730.GB14455@lst.de>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200413132730.GB14455@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, io-uring@vger.kernel.org, linux-mm@kvack.org, Zhenyu Wang <zhenyuw@linux.intel.com>, intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Zhi Wang <zhi.a.wang@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 13, 2020 at 03:27:30PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 06, 2020 at 11:08:46PM -0400, Yan Zhao wrote:
> > hi
> > we were removing this code. see
> > https://lore.kernel.org/kvm/20200313031109.7989-1-yan.y.zhao@intel.com/
> 
> This didn't make 5.7-rc1.
> 
> > The implementation of vfio_dma_rw() has been in vfio next tree.
> > https://github.com/awilliam/linux-vfio/commit/8d46c0cca5f4dc0538173d62cd36b1119b5105bc
> 
> 
> This made 5.7-rc1, so I'll update the series to take it into account.
> 
> T
> > in vfio_dma_rw(),  we still use
> > bool kthread = current->mm == NULL.
> > because if current->mm != NULL and current->flags & PF_KTHREAD, instead
> > of calling use_mm(), we first check if (current->mm == mm) and allow copy_to_user() if it's true.
> > 
> > Do you think it's all right?
> 
> I can't think of another way for a kernel thread to have a mm indeed.
for example, before calling to vfio_dma_rw(), a kernel thread has already
called use_mm(), then its current->mm is not null, and it has flag
PF_KTHREAD.
in this case, we just want to allow the copy_to_user() directly if
current->mm == mm, rather than call another use_mm() again.

do you think it makes sense?

Thanks
Yan

> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
