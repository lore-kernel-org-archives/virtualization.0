From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v17 1/6] lib/xbitmap: Introduce xbitmap
Date: Mon, 06 Nov 2017 16:15:29 +0800
Message-ID: <5A001A21.80901__24883.8865700693$1509956003$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-2-git-send-email-wei.w.wang@intel.com>
	<201711031955.FFE57823.VFLMFtFJSOOQHO@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201711031955.FFE57823.VFLMFtFJSOOQHO@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2017 06:55 PM, Tetsuo Handa wrote:
> I'm commenting without understanding the logic.
>
> Wei Wang wrote:
>> +
>> +bool xb_preload(gfp_t gfp);
>> +
> Want __must_check annotation, for __radix_tree_preload() is marked
> with __must_check annotation. By error failing to check result of
> xb_preload() will lead to preemption kept disabled unexpectedly.
>

I don't disagree with this, but I find its wrappers, e.g. 
radix_tree_preload() and radix_tree_maybe_preload(), don't seem to have 
__must_chek added.


>
>> +int xb_set_bit(struct xb *xb, unsigned long bit)
>> +{
>> +	int err;
>> +	unsigned long index = bit / IDA_BITMAP_BITS;
>> +	struct radix_tree_root *root = &xb->xbrt;
>> +	struct radix_tree_node *node;
>> +	void **slot;
>> +	struct ida_bitmap *bitmap;
>> +	unsigned long ebit;
>> +
>> +	bit %= IDA_BITMAP_BITS;
>> +	ebit = bit + 2;
>> +
>> +	err = __radix_tree_create(root, index, 0, &node, &slot);
>> +	if (err)
>> +		return err;
>> +	bitmap = rcu_dereference_raw(*slot);
>> +	if (radix_tree_exception(bitmap)) {
>> +		unsigned long tmp = (unsigned long)bitmap;
>> +
>> +		if (ebit < BITS_PER_LONG) {
>> +			tmp |= 1UL << ebit;
>> +			rcu_assign_pointer(*slot, (void *)tmp);
>> +			return 0;
>> +		}
>> +		bitmap = this_cpu_xchg(ida_bitmap, NULL);
>> +		if (!bitmap)
> Please write locking rules, in order to explain how memory
> allocated by __radix_tree_create() will not leak.
>

For the memory allocated by __radix_tree_create(), I think we could add:

     if (!bitmap) {
         __radix_tree_delete(root, node, slot);
         break;
     }


For the locking rules, how about adding the following "Developer notes:" 
at the top of the file:

"
Locks are required to ensure that concurrent calls to xb_set_bit, 
xb_preload_and_set_bit, xb_test_bit, xb_clear_bit, xb_clear_bit_range, 
xb_find_next_set_bit and xb_find_next_zero_bit, for the same ida bitmap 
will not happen.
"

>> +bool xb_test_bit(struct xb *xb, unsigned long bit)
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
> Why not bit >= BITS_PER_LONG here?

Yes, I think it should be ">=" here. Thanks.

Best,
Wei
