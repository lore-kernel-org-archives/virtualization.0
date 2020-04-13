From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread
 is a kthread
Date: Mon, 13 Apr 2020 15:27:30 +0200
Message-ID: <20200413132730.GB14455@lst.de>
References: <20200404094101.672954-1-hch@lst.de> <20200404094101.672954-3-hch@lst.de> <20200407030845.GA10586@joy-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200407030845.GA10586@joy-OptiPlex-7040>
Sender: linux-kernel-owner@vger.kernel.org
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 11:08:46PM -0400, Yan Zhao wrote:
> hi
> we were removing this code. see
> https://lore.kernel.org/kvm/20200313031109.7989-1-yan.y.zhao@intel.com/

This didn't make 5.7-rc1.

> The implementation of vfio_dma_rw() has been in vfio next tree.
> https://github.com/awilliam/linux-vfio/commit/8d46c0cca5f4dc0538173d62cd36b1119b5105bc


This made 5.7-rc1, so I'll update the series to take it into account.

T
> in vfio_dma_rw(),  we still use
> bool kthread = current->mm == NULL.
> because if current->mm != NULL and current->flags & PF_KTHREAD, instead
> of calling use_mm(), we first check if (current->mm == mm) and allow copy_to_user() if it's true.
> 
> Do you think it's all right?

I can't think of another way for a kernel thread to have a mm indeed.
