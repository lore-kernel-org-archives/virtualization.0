From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Thu, 14 Dec 2017 19:47:29 +0800
Message-ID: <5A3264D1.8090405__29883.2819601104$1513251951$gmane$org@intel.com>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5A31F445.6070504@intel.com>
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

On 12/14/2017 11:47 AM, Wei Wang wrote:
> On 12/13/2017 10:16 PM, Tetsuo Handa wrote:
>
>
>>
>>>                           if (set)
>>>                                   ret = find_next_bit(&tmp,
>>> BITS_PER_LONG, ebit);
>>>                           else
>>>                                   ret = find_next_zero_bit(&tmp,
>>> BITS_PER_LONG,
>>> ebit);
>>>                           if (ret < BITS_PER_LONG)
>>>                                   return ret - 2 + ida_start;
>>>                   } else if (bitmap) {
>>>                           if (set)
>>>                                   ret = find_next_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>>>                           else
>>>                                   ret = 
>>> find_next_zero_bit(bitmap->bitmap,
>>> IDA_BITMAP_BITS, bit);
>> "bit" may not be 0 for the first round and "bit" is always 0 afterwords.
>> But where is the guaranteed that "end" is a multiple of 
>> IDA_BITMAP_BITS ?
>> Please explain why it is correct to use IDA_BITMAP_BITS unconditionally
>> for the last round.
>
> There missed something here, it will be:
>
> nbits = min(end - ida_start + 1, IDA_BITMAP_BITS - bit);


captured a bug here, should be:
nbits = min(end - ida_start + 1, (unsigned long)IDA_BITMAP_BITS);


> if (set)
>     ret = find_next_bit(bitmap->bitmap, nbits, bit);
> else
>     ret = find_next_zero_bit(bitmap->bitmap,
>                                            nbits, bit);
> if (ret < nbits)
>     return ret + ida_start;
>
>

Best,
Wei
