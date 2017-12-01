From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v18 05/10] xbitmap: add more operations
Date: Fri, 01 Dec 2017 16:02:30 +0800
Message-ID: <5A210C96.8050208__37770.5023660839$1512115245$gmane$org@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 11/30/2017 06:34 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> + * @start: the start of the bit range, inclusive
>> + * @end: the end of the bit range, inclusive
>> + *
>> + * This function is used to clear a bit in the xbitmap. If all the bits of the
>> + * bitmap are 0, the bitmap will be freed.
>> + */
>> +void xb_clear_bit_range(struct xb *xb, unsigned long start, unsigned long end)
>> +{
>> +	struct radix_tree_root *root = &xb->xbrt;
>> +	struct radix_tree_node *node;
>> +	void **slot;
>> +	struct ida_bitmap *bitmap;
>> +	unsigned int nbits;
>> +
>> +	for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
>> +		unsigned long index = start / IDA_BITMAP_BITS;
>> +		unsigned long bit = start % IDA_BITMAP_BITS;
>> +
>> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
>> +		if (radix_tree_exception(bitmap)) {
>> +			unsigned long ebit = bit + 2;
>> +			unsigned long tmp = (unsigned long)bitmap;
>> +
>> +			nbits = min(end - start + 1, BITS_PER_LONG - ebit);
> "nbits = min(end - start + 1," seems to expect that start == end is legal
> for clearing only 1 bit. But this function is no-op if start == end.
> Please clarify what "inclusive" intended.

If xb_clear_bit_range(xb,10,10), then it is effectively the same as 
xb_clear_bit(10). Why would it be illegal?

"@start inclusive" means that the @start will also be included to be 
cleared.

>
>> +static inline __always_inline void bitmap_clear(unsigned long *map,
>> +						unsigned int start,
>> +						unsigned int nbits)
>> +{
>> +	if (__builtin_constant_p(nbits) && nbits == 1)
>> +		__clear_bit(start, map);
>> +	else if (__builtin_constant_p(start & 7) && IS_ALIGNED(start, 8) &&
>> +		 __builtin_constant_p(nbits & 7) && IS_ALIGNED(nbits, 8))
> It looks strange to apply __builtin_constant_p test to variables after "& 7".
>

I think this is normal - if the variables are known at compile time, the 
calculation will be done at compile time (termed constant folding).


Best,
Wei
