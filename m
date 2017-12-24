From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v20 3/7 RESEND] xbitmap: add more operations
Date: Sun, 24 Dec 2017 15:31:28 +0800
Message-ID: <5A3F57D0.9050007__47681.3079826117$1514100469$gmane$org@intel.com>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>	<20171221210327.GB25009@bombadil.infradead.org>	<201712231159.ECI73411.tFFFJOHOVMOLQS@I-love.SAKURA.ne.jp>	<20171223032959.GA11578@bombadil.infradead.org>
	<201712232333.BAH82874.FFFtOMHSLVQOOJ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712232333.BAH82874.FFFtOMHSLVQOOJ@I-love.SAKURA.ne.jp>
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

On 12/23/2017 10:33 PM, Tetsuo Handa wrote:
>>>> +	bitmap = rcu_dereference_raw(*slot);
>>>> +	if (!bitmap) {
>>>> +		bitmap = this_cpu_xchg(ida_bitmap, NULL);
>>>> +		if (!bitmap)
>>>> +			return -ENOMEM;
>>> I can't understand this. I can understand if it were
>>>
>>>    BUG_ON(!bitmap);
>>>
>>> because you called xb_preload().
>>>
>>> But
>>>
>>> 	/*
>>> 	 * Regular test 2
>>> 	 * set bit 2000, 2001, 2040
>>> 	 * Next 1 in [0, 2048)		--> 2000
>>> 	 * Next 1 in [2000, 2002)	--> 2000
>>> 	 * Next 1 in [2002, 2041)	--> 2040
>>> 	 * Next 1 in [2002, 2040)	--> none
>>> 	 * Next 0 in [2000, 2048)	--> 2002
>>> 	 * Next 0 in [2048, 2060)	--> 2048
>>> 	 */
>>> 	xb_preload(GFP_KERNEL);
>>> 	assert(!xb_set_bit(&xb1, 2000));
>>> 	assert(!xb_set_bit(&xb1, 2001));
>>> 	assert(!xb_set_bit(&xb1, 2040));
>> [...]
>>> 	xb_preload_end();
>>>
>>> you are not calling xb_preload() prior to each xb_set_bit() call.
>>> This means that, if each xb_set_bit() is not surrounded with
>>> xb_preload()/xb_preload_end(), there is possibility of hitting
>>> this_cpu_xchg(ida_bitmap, NULL) == NULL.
>> This is just a lazy test.  We "know" that the bits in the range 1024-2047
>> will all land in the same bitmap, so there's no need to preload for each
>> of them.
> Testcases also serves as how to use that API.
> Assuming such thing leads to incorrect usage.

If callers are aware that the bits that they going to record locate in 
the same bitmap, I think they should also perform the xb_ APIs with only 
one preload. So the test cases here have shown them a correct example. 
We can probably add some comments above to explain this.


Best,
Wei
