From: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread is
 a kthread
Date: Tue, 14 Apr 2020 03:03:44 -0400
Message-ID: <20200414070344.GF10586@joy-OptiPlex-7040>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
 <20200407030845.GA10586@joy-OptiPlex-7040>
 <20200413132730.GB14455@lst.de>
 <20200414000410.GE10586@joy-OptiPlex-7040>
 <20200414070013.GA23680@lst.de>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200414070013.GA23680@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, io-uring@vger.kernel.org, linux-mm@kvack.org, Zhenyu Wang <zhenyuw@linux.intel.com>, intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Zhi Wang <zhi.a.wang@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 14, 2020 at 09:00:13AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 13, 2020 at 08:04:10PM -0400, Yan Zhao wrote:
> > > I can't think of another way for a kernel thread to have a mm indeed.
> > for example, before calling to vfio_dma_rw(), a kernel thread has already
> > called use_mm(), then its current->mm is not null, and it has flag
> > PF_KTHREAD.
> > in this case, we just want to allow the copy_to_user() directly if
> > current->mm == mm, rather than call another use_mm() again.
> > 
> > do you think it makes sense?
> 
> I mean no other way than using use_mm.  That being said nesting
> potentional use_mm callers sounds like a rather bad idea, and we
> should avoid that.
yes, agree.
I was explaining why we just use "current->mm == NULL"
(not "current->flag & PF_KTHREAD") as a criteria to call use_mm()
in vfio_dma_rw(), which you might ask us when you take that part into your
series. :)
