From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v13 1/5] Introduce xbitmap
Date: Thu, 10 Aug 2017 13:59:12 +0800
Message-ID: <598BF630.3060308__40838.8207237751$1502344913$gmane$org@intel.com>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>	<1501742299-4369-2-git-send-email-wei.w.wang@intel.com>
	<20170809143636.e2c2d2713f58768c1427855d@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170809143636.e2c2d2713f58768c1427855d@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, yang.zhang.wz@gmail.com, virtualization@lists.linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/2017 05:36 AM, Andrew Morton wrote:
> On Thu,  3 Aug 2017 14:38:15 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> The eXtensible Bitmap is a sparse bitmap representation which is
>> efficient for set bits which tend to cluster.  It supports up to
>> 'unsigned long' worth of bits, and this commit adds the bare bones --
>> xb_set_bit(), xb_clear_bit() and xb_test_bit().
> Would like to see some additional details here justifying the change.
> The sole user is virtio-balloon, yes?  What alternatives were examined
> and what are the benefits of this approach?
>
> Have you identified any other subsystems which could utilize this?


The idea and implementation comes from Matthew, but I can share
my thought here (mostly from a user perspective):

This seems to be the first kind that uses bitmaps based on radix like
structures for id recording purposes.  The id is given by the user,
which is different from ida (ida is used for id allocation purpose). A
bitmap is allocated on demand when an id provided by the user to
record beyond the existing id range that the allocated bitmaps can
cover. Benefits are actually from the radix implementation - efficient
storage and quick lookup.

We use it in virtio-balloon to record the pfns of balloon pages, that is,
a pfn is an id to be recorded into the bitmap. The bitmaps are latter
searched for continuous "1" bits, which correspond to continuous pfns.

Virtio-ballon is the first user of it. I'm not sure about other subsystems,
but other developers may notice it and use it once it's available there.


>> ...
>>
>> --- a/lib/radix-tree.c
>> +++ b/lib/radix-tree.c
>> @@ -37,6 +37,7 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>> +#include <linux/xbitmap.h>
>>   
>>   
>>   /* Number of nodes in fully populated tree of given height */
>> @@ -78,6 +79,14 @@ static struct kmem_cache *radix_tree_node_cachep;
>>   #define IDA_PRELOAD_SIZE	(IDA_MAX_PATH * 2 - 1)
>>   
>>   /*
>> + * The XB can go up to unsigned long, but also uses a bitmap.
> This comment is hard to understand.

Also not sure bout it.

>
>> + */
>> +#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
>> +#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
>> +					      RADIX_TREE_MAP_SHIFT))
>> +#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)
>> +
>>
>> ...
>>   
>> +void xb_preload(gfp_t gfp)
>> +{
>> +	__radix_tree_preload(gfp, XB_PRELOAD_SIZE);
>> +	if (!this_cpu_read(ida_bitmap)) {
>> +		struct ida_bitmap *bitmap = kmalloc(sizeof(*bitmap), gfp);
>> +
>> +		if (!bitmap)
>> +			return;
>> +		bitmap = this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);
>> +		kfree(bitmap);
>> +	}
>> +}
>> +EXPORT_SYMBOL(xb_preload);
> Please document the exported API.  It's conventional to do this in
> kerneldoc but for some reason kerneldoc makes people write
> uninteresting and unuseful documentation.  Be sure to cover the
> *useful* stuff: what it does, why it does it, under which circumstances
> it should be used, what the caller-provided locking should look like,
> what the return values mean, etc.  Stuff which programmers actually
> will benefit from knowing.

OK.

>
>> +int xb_set_bit(struct xb *xb, unsigned long bit)
>>
>> ...
>>
>> +int xb_clear_bit(struct xb *xb, unsigned long bit)
> There's quite a lot of common code here.  Did you investigate factoring
> that out in some fashion?


If we combine the functions into one
xb_bit_ops(struct xb *xb, unsigned long bit, enum xb_ops ops),
it will be a big function with some if (ops == set/clear/test)-else,
not sure if that would look good.


>
>> +bool xb_test_bit(const struct xb *xb, unsigned long bit)
>> +{
>> +	unsigned long index = bit / IDA_BITMAP_BITS;
>> +	const struct radix_tree_root *root = &xb->xbrt;
>> +	struct ida_bitmap *bitmap = radix_tree_lookup(root, index);
>> +
>> +	bit %= IDA_BITMAP_BITS;
>> +
>> +	if (!bitmap)
>> +		return false;
>> +	if (radix_tree_exception(bitmap)) {
>> +		bit += RADIX_TREE_EXCEPTIONAL_SHIFT;
>> +		if (bit > BITS_PER_LONG)
>> +			return false;
>> +		return (unsigned long)bitmap & (1UL << bit);
>> +	}
>> +	return test_bit(bit, bitmap->bitmap);
>> +}
>> +
> Missing EXPORT_SYMBOL?

Yes, will add that, thanks.

>
> Perhaps all this code should go into a new lib/xbitmap.c.

Ok, will relocate.


Best,
Wei
