From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v20 3/7 RESEND] xbitmap: add more operations
Date: Fri, 22 Dec 2017 16:45:33 +0800
Message-ID: <5A3CC62D.6020001__27614.0249254697$1513932116$gmane$org@intel.com>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>	<20171221141805.GA27695@bombadil.infradead.org>
	<201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/21/2017 10:37 PM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>>> +/**
>>> + * xb_find_set - find the next set bit in a range of bits
>>> + * @xb: the xbitmap to search from
>>> + * @offset: the offset in the range to start searching
>>> + * @size: the size of the range
>>> + *
>>> + * Returns: the found bit or, @size if no set bit is found.
>>> + */
>>> +unsigned long xb_find_set(struct xb *xb, unsigned long size,
>>> +			  unsigned long offset)
>>> +{
>>> +	struct radix_tree_root *root = &xb->xbrt;
>>> +	struct radix_tree_node *node;
>>> +	void __rcu **slot;
>>> +	struct ida_bitmap *bitmap;
>>> +	unsigned long index = offset / IDA_BITMAP_BITS;
>>> +	unsigned long index_end = size / IDA_BITMAP_BITS;
>>> +	unsigned long bit = offset % IDA_BITMAP_BITS;
>>> +
>>> +	if (unlikely(offset >= size))
>>> +		return size;
>>> +
>>> +	while (index <= index_end) {
>>> +		unsigned long ret;
>>> +		unsigned int nbits = size - index * IDA_BITMAP_BITS;
>>> +
>>> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
>>> +
>>> +		if (!node && !bitmap)
>>> +			return size;
>>> +
>>> +		if (bitmap) {
>>> +			if (nbits > IDA_BITMAP_BITS)
>>> +				nbits = IDA_BITMAP_BITS;
>>> +
>>> +			ret = find_next_bit(bitmap->bitmap, nbits, bit);
>>> +			if (ret != nbits)
>>> +				return ret + index * IDA_BITMAP_BITS;
>>> +		}
>>> +		bit = 0;
>>> +		index++;
>>> +	}
>>> +
>>> +	return size;
>>> +}
>>> +EXPORT_SYMBOL(xb_find_set);
>> This is going to be slower than the implementation I sent yesterday.  If I
>> call:
>> 	xb_init(xb);
>> 	xb_set_bit(xb, ULONG_MAX);
>> 	xb_find_set(xb, ULONG_MAX, 0);
>>
>> it's going to call __radix_tree_lookup() 16 quadrillion times.
>> My implementation will walk the tree precisely once.
>>
> Yes. Wei's patch still can not work.
> We should start reviewing Matthew's implementation.

It runs without any issue on my machine. I didn't generate an "xbitmap" 
executable (I just found adding xbitmap executable causes a build error 
due to a Makefile error), instead, I tested it within "main" and it 
passed all the tests.

Matthew has implemented a new version, let's start from there.

Best,
Wei
