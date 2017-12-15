From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Fri, 15 Dec 2017 10:49:15 -0800
Message-ID: <20171215184915.GB27160__33556.3124776401$1513363793$gmane$org@bombadil.infradead.org>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 16, 2017 at 01:21:52AM +0900, Tetsuo Handa wrote:
> My understanding is that virtio-balloon wants to handle sparsely spreaded
> unsigned long values (which is PATCH 4/7) and wants to find all chunks of
> consecutive "1" bits efficiently. Therefore, I guess that holding the values
> in ascending order at store time is faster than sorting the values at read
> time. I don't know how to use radix tree API, but I think that B+ tree API
> suits for holding the values in ascending order.
> 
> We wait for Wei to post radix tree version combined into one patch and then
> compare performance between radix tree version and B+ tree version (shown
> below)?

Sure.  We all benefit from some friendly competition.  Even if a
competition between trees might remind one of the Entmoot ;-)

But let's not hold back -- let's figure out some good workloads to use
in our competition.  And we should also decide on the API / locking
constraints.  And of course we should compete based on not just speed,
but also memory consumption (both as a runtime overhead for a given set
of bits and as code size).  If you can replace the IDR, you get to count
that savings against the cost of your implementation.

Here's the API I'm looking at right now.  The user need take no lock;
the locking (spinlock) is handled internally to the implementation.

void xbit_init(struct xbitmap *xb);
int xbit_alloc(struct xbitmap *, unsigned long bit, gfp_t);
int xbit_alloc_range(struct xbitmap *, unsigned long start,
                        unsigned long nbits, gfp_t);
int xbit_set(struct xbitmap *, unsigned long bit, gfp_t);
bool xbit_test(struct xbitmap *, unsigned long bit);
int xbit_clear(struct xbitmap *, unsigned long bit);
int xbit_zero(struct xbitmap *, unsigned long start, unsigned long nbits);
int xbit_fill(struct xbitmap *, unsigned long start, unsigned long nbits,
                        gfp_t);
unsigned long xbit_find_clear(struct xbitmap *, unsigned long start,
                        unsigned long max);
unsigned long xbit_find_set(struct xbitmap *, unsigned long start,
                        unsigned long max);

> static bool set_ulong(struct ulong_list_head *head, const unsigned long value)
> {
> 	if (!ptr) {
> 		ptr = kzalloc(sizeof(*ptr), GFP_NOWAIT | __GFP_NOWARN);
> 		if (!ptr)
> 			goto out1;
> 		ptr->bitmap = kzalloc(BITMAP_LEN / 8,
> 				      GFP_NOWAIT | __GFP_NOWARN);
> 		if (!ptr->bitmap)
> 			goto out2;
> 		if (btree_insertl(&head->btree, ~segment, ptr,
> 				   GFP_NOWAIT | __GFP_NOWARN))
> 			goto out3;
> out3:
> 	kfree(ptr->bitmap);
> out2:
> 	kfree(ptr);
> out1:
> 	return false;
> }

And what is the user supposed to do if this returns false?  How do they
make headway?  The xb_ API is clear -- you call xb_prealloc and that
ensures forward progress.
