From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v15 2/5] lib/xbitmap: add xb_find_next_bit() and xb_zero()
Date: Sat, 30 Sep 2017 04:24:26 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73931DE83__10505.0207268961$1506745496$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-3-git-send-email-wei.w.wang@intel.com>
	<20170911132710.GB32538@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170911132710.GB32538@bombadil.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mhocko@kernel.org" <mhocko>
List-Id: virtualization@lists.linuxfoundation.org

On Monday, September 11, 2017 9:27 PM, Matthew Wilcox wrote
> On Mon, Aug 28, 2017 at 06:08:30PM +0800, Wei Wang wrote:
> > +/**
> > + *  xb_zero - zero a range of bits in the xbitmap
> > + *  @xb: the xbitmap that the bits reside in
> > + *  @start: the start of the range, inclusive
> > + *  @end: the end of the range, inclusive  */ void xb_zero(struct xb
> > +*xb, unsigned long start, unsigned long end) {
> > +	unsigned long i;
> > +
> > +	for (i = start; i <= end; i++)
> > +		xb_clear_bit(xb, i);
> > +}
> > +EXPORT_SYMBOL(xb_zero);
> 
> Um.  This is not exactly going to be quick if you're clearing a range of bits.
> I think it needs to be more along the lines of this:
> 
> void xb_clear(struct xb *xb, unsigned long start, unsigned long end) {
>         struct radix_tree_root *root = &xb->xbrt;
>         struct radix_tree_node *node;
>         void **slot;
>         struct ida_bitmap *bitmap;
> 
>         for (; end < start; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
>                 unsigned long index = start / IDA_BITMAP_BITS;
>                 unsigned long bit = start % IDA_BITMAP_BITS;
> 
>                 bitmap = __radix_tree_lookup(root, index, &node, &slot);
>                 if (radix_tree_exception(bitmap)) {
>                         unsigned long ebit = bit + 2;
>                         unsigned long tmp = (unsigned long)bitmap;
>                         if (ebit >= BITS_PER_LONG)
>                                 continue;
>                         tmp &= ... something ...;
>                         if (tmp == RADIX_TREE_EXCEPTIONAL_ENTRY)
>                                 __radix_tree_delete(root, node, slot);
>                         else
>                                 rcu_assign_pointer(*slot, (void *)tmp);
>                 } else if (bitmap) {
>                         unsigned int nbits = end - start + 1;
>                         if (nbits + bit > IDA_BITMAP_BITS)
>                                 nbits = IDA_BITMAP_BITS - bit;
>                         bitmap_clear(bitmap->bitmap, bit, nbits);
>                         if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
>                                 kfree(bitmap);
>                                 __radix_tree_delete(root, node, slot);
>                         }
>                 }
>         }
> }
> 
> Also note that this should be called xb_clear(), not xb_zero() to fit in with
> bitmap_clear().  And this needs a thorough test suite testing all values for 'start'
> and 'end' between 0 and at least 1024; probably much higher.  And a variable
> number of bits need to be set before calling
> xb_clear() in the test suite.
> 
> Also, this implementation above is missing a few tricks.  For example, if 'bit' is 0
> and 'nbits' == IDA_BITMAP_BITS, we can simply call kfree without first zeroing
> out the bits and then checking if the whole thing is zero.

Thanks for the optimization suggestions. We've seen significant improvement of
the ballooning time. Some other optimizations (stated in the changelog) haven't
been included in the new version. If possible, we can leave that to a second step
optimization outside this patch series.

Best,
Wei
