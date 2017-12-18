From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Sun, 17 Dec 2017 18:59:27 -0800
Message-ID: <20171218025927.GB6683__48027.8729614385$1513565885$gmane$org@bombadil.infradead.org>
References: <201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
	<20171215192203.GC27160@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F739387C1D@shsmsx102.ccr.corp.intel.com>
	<20171217221842.GA6683@bombadil.infradead.org>
	<5A3728DC.3060509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A3728DC.3060509@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.sh
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 18, 2017 at 10:33:00AM +0800, Wei Wang wrote:
> > My only qualm is that I've been considering optimising the memory
> > consumption when an entire 1024-bit chunk is full; instead of keeping a
> > pointer to a 128-byte entry full of ones, store a special value in the
> > radix tree which means "every bit is set".
> > 
> > The downside is that we then have to pass GFP flags to xbit_clear() and
> > xbit_zero(), and they can fail.  It's not clear to me whether that's a
> > good tradeoff.
> 
> Yes, this will sacrifice performance. In many usages, users may set bits one
> by one, and each time when a bit is set, it needs to scan the whole
> ida_bitmap to see if all other bits are set, if so, it can free the
> ida_bitmap. I think this extra scanning of the ida_bitmap would add a lot
> overhead.

Not a huge amount of overhead.  An ida_bitmap is only two cachelines,
and the loop is simply 'check each word against ~0ul', so up to 16
load/test/loop instructions.  Plus we have to do that anyway to maintain
the free tag for IDAs.

> > But I need to get the XArray (which replaces the radix tree) finished first.
> 
> OK. It seems the new implementation wouldn't be done shortly.
> Other parts of this patch series are close to the end of review, and we hope
> to make some progress soon. Would it be acceptable that we continue with the
> basic xb_ implementation (e.g. as xbitmap 1.0) for this patch series? and
> xbit_ implementation can come as xbitmap 2.0 in the future?

Yes, absolutely, I don't want to hold you up behind the XArray.
