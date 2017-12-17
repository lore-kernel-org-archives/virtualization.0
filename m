From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v19 3/7] xbitmap: add more operations
Date: Sun, 17 Dec 2017 13:47:21 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739387C1D__41745.3094305985$1513518334$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
	<20171215192203.GC27160@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171215192203.GC27160@bombadil.infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, akpm@li
List-Id: virtualization@lists.linuxfoundation.org

On Saturday, December 16, 2017 3:22 AM, Matthew Wilcox wrote:
> On Fri, Dec 15, 2017 at 10:49:15AM -0800, Matthew Wilcox wrote:
> > Here's the API I'm looking at right now.  The user need take no lock;
> > the locking (spinlock) is handled internally to the implementation.

Another place I saw your comment " The xb_ API requires you to handle your own locking" which seems conflict with the above "the user need take no lock".
Doesn't the caller need a lock to avoid concurrent accesses to the ida bitmap?


> I looked at the API some more and found some flaws:
>  - how does xbit_alloc communicate back which bit it allocated?
>  - What if xbit_find_set() is called on a completely empty array with
>    a range of 0, ULONG_MAX -- there's no invalid number to return.

We'll change it to "bool xb_find_set(.., unsigned long *result)", returning false indicates no "1" bit is found.


>  - xbit_clear() can't return an error.  Neither can xbit_zero().

I found the current xbit_clear implementation only returns 0, and there isn't an error to be returned from this function. In this case, is it better to make the function "void"?


>  - Need to add __must_check to various return values to discourage sloppy
>    programming
> 
> So I modify the proposed API we compete with thusly:
> 
> bool xbit_test(struct xbitmap *, unsigned long bit); int __must_check
> xbit_set(struct xbitmap *, unsigned long bit, gfp_t); void xbit_clear(struct
> xbitmap *, unsigned long bit); int __must_check xbit_alloc(struct xbitmap *,
> unsigned long *bit, gfp_t);
> 
> int __must_check xbit_fill(struct xbitmap *, unsigned long start,
>                         unsigned long nbits, gfp_t); void xbit_zero(struct xbitmap *,
> unsigned long start, unsigned long nbits); int __must_check
> xbit_alloc_range(struct xbitmap *, unsigned long *bit,
>                         unsigned long nbits, gfp_t);
> 
> bool xbit_find_clear(struct xbitmap *, unsigned long *start, unsigned long
> max); bool xbit_find_set(struct xbitmap *, unsigned long *start, unsigned
> long max);
> 
> (I'm a little sceptical about the API accepting 'max' for the find functions and
> 'nbits' in the fill/zero/alloc_range functions, but I think that matches how
> people want to use it, and it matches how bitmap.h works)

Are you suggesting to rename the current xb_ APIs to the above xbit_ names (with parameter changes)? 

Why would we need xbit_alloc, which looks like ida_get_new, I think set/clear should be adequate to the current usages.

Best,
Wei
