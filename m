From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: Re: [PATCH] virtio_ring: Shadow available ring flags & index
Date: Mon, 23 Nov 2015 16:46:39 +0000
Message-ID: <C37D651A908B024F974696C65296B57B4B1A9338__5091.42704909227$1448297234$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1447201267-30024-1-git-send-email-venkateshs@google.com>
	<20151111142647-mutt-send-email-mst@redhat.com>
	<20151113234140.GA6512@google.com>
	<C37D651A908B024F974696C65296B57B4B1942C3@SHSMSX101.ccr.corp.intel.com>
	<20151118040818.GA17436@google.com> <20151118042839.GA24662@google.com>
	<C37D651A908B024F974696C65296B57B4B19D2A4@SHSMSX101.ccr.corp.intel.com>
	<20151120183011.GA24228@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Venkatesh Srinivas <venkateshs@google.com>
Cc: "Abhinkar, Bindiya S" <bindiya.s.abhinkar@intel.com>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Venkatesh Srinivas <vsrinivas@ops101.org>, "Lu,
	Patrick" <patrick.lu@intel.com>, "luto@kernel.org" <luto@kernel.org>, "Wang, Zhihong" <zhihong.wang@intel.com>, David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/21/2015 2:30 AM, Venkatesh Srinivas wrote:
> On Thu, Nov 19, 2015 at 04:15:48PM +0000, Xie, Huawei wrote:
>> On 11/18/2015 12:28 PM, Venkatesh Srinivas wrote:
>>> On Tue, Nov 17, 2015 at 08:08:18PM -0800, Venkatesh Srinivas wrote:
>>>> On Mon, Nov 16, 2015 at 7:46 PM, Xie, Huawei <huawei.xie@intel.com> wrote:
>>>>
>>>>> On 11/14/2015 7:41 AM, Venkatesh Srinivas wrote:
>>>>>> On Wed, Nov 11, 2015 at 02:34:33PM +0200, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Nov 10, 2015 at 04:21:07PM -0800, Venkatesh Srinivas wrote:
>>>>>>>> Improves cacheline transfer flow of available ring header.
>>>>>>>>
>>>>>>>> Virtqueues are implemented as a pair of rings, one producer->consumer
>>>>>>>> avail ring and one consumer->producer used ring; preceding the
>>>>>>>> avail ring in memory are two contiguous u16 fields -- avail->flags
>>>>>>>> and avail->idx. A producer posts work by writing to avail->idx and
>>>>>>>> a consumer reads avail->idx.
>>>>>>>>
>>>>>>>> The flags and idx fields only need to be written by a producer CPU
>>>>>>>> and only read by a consumer CPU; when the producer and consumer are
>>>>>>>> running on different CPUs and the virtio_ring code is structured to
>>>>>>>> only have source writes/sink reads, we can continuously transfer the
>>>>>>>> avail header cacheline between 'M' states between cores. This flow
>>>>>>>> optimizes core -> core bandwidth on certain CPUs.
>>>>>>>>
>>>>>>>> (see: "Software Optimization Guide for AMD Family 15h Processors",
>>>>>>>> Section 11.6; similar language appears in the 10h guide and should
>>>>>>>> apply to CPUs w/ exclusive caches, using LLC as a transfer cache)
>>>>>>>>
>>>>>>>> Unfortunately the existing virtio_ring code issued reads to the
>>>>>>>> avail->idx and read-modify-writes to avail->flags on the producer.
>>>>>>>>
>>>>>>>> This change shadows the flags and index fields in producer memory;
>>>>>>>> the vring code now reads from the shadows and only ever writes to
>>>>>>>> avail->flags and avail->idx, allowing the cacheline to transfer
>>>>>>>> core -> core optimally.
>>>>>>> Sounds logical, I'll apply this after a  bit of testing
>>>>>>> of my own, thanks!
>>>>>> Thanks!
>>>>> Venkatesh:
>>>>> Is it that your patch only applies to CPUs w/ exclusive caches?
>>>> No --- it applies when the inter-cache coherence flow is optimized by
>>>> 'M' -> 'M' transfers and when producer reads might interfere w/
>>>> consumer prefetchw/reads. The AMD Optimization guides have specific
>>>> language on this subject, but other platforms may benefit.
>>>> (see Intel #'s below)
>> For core2core case(not HT paire), after consumer reads that M cache line
>> for avail_idx, is that line still in the producer core's L1 data cache
>> with state changing from M->O state?
> Textbook MOESI would not allow that state combination -- when the consumer
> gets the line in 'M' state, the producer cannot hold it in 'O' state.
Hi Venkatesh:
On consumer core, you are using (prefetchw + load) to get the cache line
anyway, even it doesn't mean to write, right? That makes sense for your
cache line transfer.
If using load only, the cache line on producer core should be changed
from M -> O, meaning dirty sharing, and the consumer gets the line with
S state.

I might miss something important in your case. Could you give more
detailed description?
For non-shadow case,
1) Producer updates flags or idx, cache line is set to be M state.
2) When consumer reads the idx or flags, cache line is set to be S state
on consumer core, while the cache line on producer is set to be O state.
What is the problem reading avail idx/flag whose cache line is either M
or O state on producer core? What is the benefit with and without prefetchw?

>
> On the AMD Piledriver, per the Optimization guide, I use PREFETCHW/Load to
> get the line in 'M' state on the consumer (invalidating it in the Producer's
> cache):
>
> "* Use PREFETCHW on the consumer side, even if the consumer will not modify
>    the data"
>
> That, plus the "Optimizing Inter-Core Data Transfer" section imply that
> PREFETCHW + MOV will cause the consumer to load the line into 'M' state.
>
> PREFETCHW was not available on Intel CPUs pre-Broadwell; from the public
> documentation alone, I don't think we can tell what transition the producer's
> cacheline undergoes on these cores. For that matter, the latest documentation
> I can find (for Nehalem), indicated there was no 'O' state -- Nehalem
> implemented MESIF, not MOESI.
By O, i mean AMD MOESI, and i thought you were using only load to load
the cache line on the consumer core. If you are using prefetchw + load,
that makes sense for the state transfer.
>
> HTH,
> -- vs;
>
