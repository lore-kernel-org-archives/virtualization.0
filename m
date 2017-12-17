From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Sun, 17 Dec 2017 14:18:42 -0800
Message-ID: <20171217221842.GA6683__1364.54031239754$1513549067$gmane$org@bombadil.infradead.org>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
	<20171215192203.GC27160@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F739387C1D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F739387C1D@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.sh
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 17, 2017 at 01:47:21PM +0000, Wang, Wei W wrote:
> On Saturday, December 16, 2017 3:22 AM, Matthew Wilcox wrote:
> > On Fri, Dec 15, 2017 at 10:49:15AM -0800, Matthew Wilcox wrote:
> > > Here's the API I'm looking at right now.  The user need take no lock;
> > > the locking (spinlock) is handled internally to the implementation.
> 
> Another place I saw your comment " The xb_ API requires you to handle your own locking" which seems conflict with the above "the user need take no lock".
> Doesn't the caller need a lock to avoid concurrent accesses to the ida bitmap?

Yes, the xb_ implementation requires you to handle your own locking.
The xbit_ API that I'm proposing will take care of the locking for you.
There's also no preallocation in the API.

> We'll change it to "bool xb_find_set(.., unsigned long *result)", returning false indicates no "1" bit is found.

I put a replacement proposal in the next paragraph:
bool xbit_find_set(struct xbitmap *, unsigned long *start, unsigned long max);

Maybe 'start' is the wrong name for that parameter.  Let's call it 'bit'.
It's both "where to start" and "first bit found".

> >  - xbit_clear() can't return an error.  Neither can xbit_zero().
> 
> I found the current xbit_clear implementation only returns 0, and there isn't an error to be returned from this function. In this case, is it better to make the function "void"?

Yes, I think so.

My only qualm is that I've been considering optimising the memory
consumption when an entire 1024-bit chunk is full; instead of keeping a
pointer to a 128-byte entry full of ones, store a special value in the
radix tree which means "every bit is set".

The downside is that we then have to pass GFP flags to xbit_clear() and
xbit_zero(), and they can fail.  It's not clear to me whether that's a
good tradeoff.

> Are you suggesting to rename the current xb_ APIs to the above xbit_ names (with parameter changes)? 
> 
> Why would we need xbit_alloc, which looks like ida_get_new, I think set/clear should be adequate to the current usages.

I'm intending on replacing the xb_ and ida_ implementations with this one.
It removes the preload API which makes it easier to use, and it handles
the locking for you.

But I need to get the XArray (which replaces the radix tree) finished first.
