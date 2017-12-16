From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Sat, 16 Dec 2017 18:14:12 +0800
Message-ID: <5A34F1F4.6010900__19808.0874899917$1513419181$gmane$org@intel.com>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>	<5A311C5E.7000304@intel.com>	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
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

On 12/15/2017 12:29 AM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> I used the example of xb_clear_bit_range(), and xb_find_next_bit() is
>> the same fundamentally. Please let me know if anywhere still looks fuzzy.
> I don't think it is the same for xb_find_next_bit() with set == 0.
>
> +		if (radix_tree_exception(bmap)) {
> +			unsigned long tmp = (unsigned long)bmap;
> +			unsigned long ebit = bit + 2;
> +
> +			if (ebit >= BITS_PER_LONG)
> +				continue;
> +			if (set)
> +				ret = find_next_bit(&tmp, BITS_PER_LONG, ebit);
> +			else
> +				ret = find_next_zero_bit(&tmp, BITS_PER_LONG,
> +							 ebit);
> +			if (ret < BITS_PER_LONG)
> +				return ret - 2 + IDA_BITMAP_BITS * index;
>
> What I'm saying is that find_next_zero_bit() will not be called if you do
> "if (ebit >= BITS_PER_LONG) continue;" before calling find_next_zero_bit().
>
> When scanning "0000000000000000000000000000000000000000000000000000000000000001",
> "bit < BITS_PER_LONG - 2" case finds "0" in this word but
> "bit >= BITS_PER_LONG - 2" case finds "0" in next word or segment.
>
> I can't understand why this is correct behavior. It is too much puzzling.
>

OK, I'll post out a version without the exceptional path.

Best,
Wei
