From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: Re: [PATCH] virtio_ring: Shadow available ring flags & index
Date: Tue, 17 Nov 2015 03:46:24 +0000
Message-ID: <C37D651A908B024F974696C65296B57B4B1942C3@SHSMSX101.ccr.corp.intel.com>
References: <1447201267-30024-1-git-send-email-venkateshs@google.com>
	<20151111142647-mutt-send-email-mst@redhat.com>
	<20151113234140.GA6512@google.com>
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
To: Venkatesh Srinivas <venkateshs@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Venkatesh Srinivas <vsrinivas@ops101.org>, "luto@kernel.org" <luto@kernel.org>, David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/14/2015 7:41 AM, Venkatesh Srinivas wrote:
> On Wed, Nov 11, 2015 at 02:34:33PM +0200, Michael S. Tsirkin wrote:
>> On Tue, Nov 10, 2015 at 04:21:07PM -0800, Venkatesh Srinivas wrote:
>>> Improves cacheline transfer flow of available ring header.
>>>
>>> Virtqueues are implemented as a pair of rings, one producer->consumer
>>> avail ring and one consumer->producer used ring; preceding the
>>> avail ring in memory are two contiguous u16 fields -- avail->flags
>>> and avail->idx. A producer posts work by writing to avail->idx and
>>> a consumer reads avail->idx.
>>>
>>> The flags and idx fields only need to be written by a producer CPU
>>> and only read by a consumer CPU; when the producer and consumer are
>>> running on different CPUs and the virtio_ring code is structured to
>>> only have source writes/sink reads, we can continuously transfer the
>>> avail header cacheline between 'M' states between cores. This flow
>>> optimizes core -> core bandwidth on certain CPUs.
>>>
>>> (see: "Software Optimization Guide for AMD Family 15h Processors",
>>> Section 11.6; similar language appears in the 10h guide and should
>>> apply to CPUs w/ exclusive caches, using LLC as a transfer cache)
>>>
>>> Unfortunately the existing virtio_ring code issued reads to the
>>> avail->idx and read-modify-writes to avail->flags on the producer.
>>>
>>> This change shadows the flags and index fields in producer memory;
>>> the vring code now reads from the shadows and only ever writes to
>>> avail->flags and avail->idx, allowing the cacheline to transfer
>>> core -> core optimally.
>> Sounds logical, I'll apply this after a  bit of testing
>> of my own, thanks!
> Thanks!
Venkatesh:
Is it that your patch only applies to CPUs w/ exclusive caches? Do you
have perf data on Intel CPUs?
For the perf metric you provide, why not L1-dcache-load-misses which is
more meaning full?
>
>>> In a concurrent version of vring_bench, the time required for
>>> 10,000,000 buffer checkout/returns was reduced by ~2% (average
>>> across many runs) on an AMD Piledriver (15h) CPU:
>>>
>>> (w/o shadowing):
>>>  Performance counter stats for './vring_bench':
>>>      5,451,082,016      L1-dcache-loads
>>>      ...
>>>        2.221477739 seconds time elapsed
>>>
>>> (w/ shadowing):
>>>  Performance counter stats for './vring_bench':
>>>      5,405,701,361      L1-dcache-loads
>>>      ...
>>>        2.168405376 seconds time elapsed
>> Could you supply the full command line you used
>> to test this?
> Yes --
>
> perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores \
> 	./vring_bench
>
> The standard version of vring_bench is single-threaded (posted on this list
> but never submitted); my tests were with a version that has a worker thread
> polling the VQ. How should I share it? Should I just attach it to an email
> here?
>
>>> The further away (in a NUMA sense) virtio producers and consumers are
>>> from each other, the more we expect to benefit. Physical implementations
>>> of virtio devices and implementations of virtio where the consumer polls
>>> vring avail indexes (vhost) should also benefit.
>>>
>>> Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
>> Here's a similar patch for the ring itself:
>> https://lkml.org/lkml/2015/9/10/111
>>
>> Does it help you as well?
> I tested your patch in our environment; our virtqueues do not support
> Indirect entries and your patch does not manage to elide many writes, so I
> do not see a performance difference. In an environment with Indirect, your
> patch will likely be a win.
>
> (My patch gets most of its win by eliminating reads on the producer; when
> the producer reads avail fields at the same time the consumer is polling,
> we see cacheline transfers that hurt performance. Your patch eliminates
> writes, which is nice, but our tests w/ polling are not as sensitive to
> writes from the producer.)
>
> I have two quick comments on your patch --
> 1) I think you need to kfree vq->avail when deleting the virtqueue.
>
> 2) Should we avoid allocating a cache for virtqueues that are not
>    performance critical? (ex: virtio-scsi eventq/controlq, virtio-net
>    controlq)
>
> Should I post comments in reply to the original patch email (given that it
> is ~2 months old)?
>
> Thanks!
> -- vs;
>
