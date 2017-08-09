From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 1/5] Introduce xbitmap
Date: Wed, 9 Aug 2017 14:36:36 -0700
Message-ID: <20170809143636.e2c2d2713f58768c1427855d@linux-foundation.org>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, yang.zhang.wz@gmail.com, virtualization@lists.linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  3 Aug 2017 14:38:15 +0800 Wei Wang <wei.w.wang@intel.com> wrote:

> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().

Would like to see some additional details here justifying the change. 
The sole user is virtio-balloon, yes?  What alternatives were examined
and what are the benefits of this approach?

Have you identified any other subsystems which could utilize this?

>
> ...
>
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -37,6 +37,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/xbitmap.h>
>  
>  
>  /* Number of nodes in fully populated tree of given height */
> @@ -78,6 +79,14 @@ static struct kmem_cache *radix_tree_node_cachep;
>  #define IDA_PRELOAD_SIZE	(IDA_MAX_PATH * 2 - 1)
>  
>  /*
> + * The XB can go up to unsigned long, but also uses a bitmap.

This comment is hard to understand.

> + */
> +#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
> +#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
> +					      RADIX_TREE_MAP_SHIFT))
> +#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)
> +
>
> ...
>  
> +void xb_preload(gfp_t gfp)
> +{
> +	__radix_tree_preload(gfp, XB_PRELOAD_SIZE);
> +	if (!this_cpu_read(ida_bitmap)) {
> +		struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
> +
> +		if (!bitmap)
> +			return;
> +		bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
> +		kfree(bitmap);
> +	}
> +}
> +EXPORT_SYMBOL(xb_preload);

Please document the exported API.  It's conventional to do this in
kerneldoc but for some reason kerneldoc makes people write
uninteresting and unuseful documentation.  Be sure to cover the
*useful* stuff: what it does, why it does it, under which circumstances
it should be used, what the caller-provided locking should look like,
what the return values mean, etc.  Stuff which programmers actually
will benefit from knowing.

> +int xb_set_bit(struct xb *xb, unsigned long bit)
>
> ...
>
> +int xb_clear_bit(struct xb *xb, unsigned long bit)

There's quite a lot of common code here.  Did you investigate factoring
that out in some fashion?

> +bool xb_test_bit(const struct xb *xb, unsigned long bit)
> +{
> +	unsigned long index = bit / IDA_BITMAP_BITS;
> +	const struct radix_tree_root *root = &xb->xbrt;
> +	struct ida_bitmap *bitmap = radix_tree_lookup(root, index);
> +
> +	bit %= IDA_BITMAP_BITS;
> +
> +	if (!bitmap)
> +		return false;
> +	if (radix_tree_exception(bitmap)) {
> +		bit += RADIX_TREE_EXCEPTIONAL_SHIFT;
> +		if (bit > BITS_PER_LONG)
> +			return false;
> +		return (unsigned long)bitmap & (1UL << bit);
> +	}
> +	return test_bit(bit, bitmap->bitmap);
> +}
> +

Missing EXPORT_SYMBOL?


Perhaps all this code should go into a new lib/xbitmap.c.
