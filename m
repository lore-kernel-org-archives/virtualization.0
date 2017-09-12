From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v15 1/5] lib/xbitmap: Introduce xbitmap
Date: Tue, 12 Sep 2017 21:23:57 +0800
Message-ID: <59B7DFED.6060502__29896.2625129663$1505222489$gmane$org@intel.com>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-2-git-send-email-wei.w.wang@intel.com>
	<20170911125455.GA32538@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170911125455.GA32538@bombadil.infradead.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 09/11/2017 08:54 PM, Matthew Wilcox wrote:
> On Mon, Aug 28, 2017 at 06:08:29PM +0800, Wei Wang wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> The eXtensible Bitmap is a sparse bitmap representation which is
>> efficient for set bits which tend to cluster.  It supports up to
>> 'unsigned long' worth of bits, and this commit adds the bare bones --
>> xb_set_bit(), xb_clear_bit() and xb_test_bit().
>>
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
> This is quite naughty of you.  You've modified the xbitmap implementation
> without any indication in the changelog that you did so.

This was changed in the previous version and included in that
v13->v14 ChangeLog: https://lkml.org/lkml/2017/8/16/923


> I don't
> think the modifications you made are an improvement, but without any
> argumentation from you I don't know why you think they're an improvement.

Probably it shouldn't be modified when the discussion is incomplete:
https://lkml.org/lkml/2017/8/10/36
Sorry about that. Hope we could get more feedback from you on the
changes later.

If you want, we can continue this part from the the v13 patch, which might
be closer to the implementation that you like: 
https://lkml.org/lkml/2017/8/3/60

>> diff --git a/lib/xbitmap.c b/lib/xbitmap.c
>> new file mode 100644
>> index 0000000..8c55296
>> --- /dev/null
>> +++ b/lib/xbitmap.c
>> @@ -0,0 +1,176 @@
>> +#include <linux/slab.h>
>> +#include <linux/xbitmap.h>
>> +
>> +/*
>> + * The xbitmap implementation supports up to ULONG_MAX bits, and it is
>> + * implemented based on ida bitmaps. So, given an unsigned long index,
>> + * the high order XB_INDEX_BITS bits of the index is used to find the
>> + * corresponding item (i.e. ida bitmap) from the radix tree, and the low
>> + * order (i.e. ilog2(IDA_BITMAP_BITS)) bits of the index are indexed into
>> + * the ida bitmap to find the bit.
>> + */
>> +#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
>> +#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
>> +					      RADIX_TREE_MAP_SHIFT))
>> +#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)
> I don't understand why you moved the xb_preload code here from the
> radix tree.  I want all the code which touches the preload implementation
> together in one place, which is the radix tree.

Based on the previous comments (put all the code to lib/xbitmap.c) and your
comment here, I will move xb_preload() and the above Macro to radix-tree.c,
while leaving the rest in xbitmap.c.

Would this be something you expected? Or would you like to move all back
to radix-tree.c like that in v13?


Best,
Wei
