From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean
 a thread is a kthread
Date: Tue, 14 Apr 2020 09:00:13 +0200
Message-ID: <20200414070013.GA23680@lst.de>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
 <20200407030845.GA10586@joy-OptiPlex-7040> <20200413132730.GB14455@lst.de>
 <20200414000410.GE10586@joy-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200414000410.GE10586@joy-OptiPlex-7040>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jason Wang <jasowang@redhat.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, io-uring@vger.kernel.org, linux-mm@kvack.org, intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, intel-gvt-dev@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 13, 2020 at 08:04:10PM -0400, Yan Zhao wrote:
> > I can't think of another way for a kernel thread to have a mm indeed.
> for example, before calling to vfio_dma_rw(), a kernel thread has already
> called use_mm(), then its current->mm is not null, and it has flag
> PF_KTHREAD.
> in this case, we just want to allow the copy_to_user() directly if
> current->mm == mm, rather than call another use_mm() again.
> 
> do you think it makes sense?

I mean no other way than using use_mm.  That being said nesting
potentional use_mm callers sounds like a rather bad idea, and we
should avoid that.
