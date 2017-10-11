From: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v3
Date: Wed, 11 Oct 2017 14:22:28 +0200
Message-ID: <20171011122228.dah6jed2rjnjgsgr@dhcp-192-218.str.redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E1A46A6@SHSMSX152.ccr.corp.intel.com>
	<20170926011826-mutt-send-email-mst@kernel.org>
	<7A0DC0C9-F148-4161-B2D1-8D8D14D8B9A1@cisco.com>
	<20170928023112-mutt-send-email-mst@kernel.org>
	<D0158A423229094DA7ABF71CF2FA0DA34E1AD49B@SHSMSX152.ccr.corp.intel.com>
	<20171001063817-mutt-send-email-mst@kernel.org>
	<20171004123901.oomueufqg52uhas4@localhost.localdomain>
	<20171004155532-mutt-send-email-mst@kernel.org>
	<D0158A423229094DA7ABF71CF2FA0DA34E7DE4D3@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E7DE4D3@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Steven Luong (sluong)" <sluong@cisco.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 10, 2017 at 09:56:44AM +0000, Liang, Cunming wrote:
>> > > DESC_WRAP: used by device to poll. Driver sets it to a *different*
>> > > value every time it overwrites a descriptor. How to achieve it?
>> > > since descriptors are written out in ring order, simply maintain the
>> > > current value internally (start value 1) and flip it every time you
>> > > overwrite the first descriptor.
>> > > Device leaves it intact when overwriting a descriptor.
>Ok, get it now.
>
>> >
>> > This is confusing me a bit.
>> >
>> > My understanding is: 1. the internally kept wrap value only flipped
>> > when the first descriptor is overwritten
>> >
>> > 2. the moment the first descriptor is written the internal wrap value
>> > is flipped 0->1 or 1->0 and this value is written to every descriptor
>> > DESC_WRAP until we reach the first descriptor again
>That's right, it's also my take.
>DESC_WRAP is only used by driver, device does nothing with that flag.
>
>>
>> Yes this is what I tried to say. Can you suggest a better wording then?

I'll give it a try.

>The term of DESC_WRAP is fine to me.

Couldn't think of a better name either. 

>> > > After writing down this explanation, I think the names aren't great.
>> > >
>> > > Let me try an alternative explanation.
>> > >
>> > > ---------------
>> > > A two-bit field, DRIVER_OWNER, signals the buffer ownership.
>> > > It has 4 possible values:
>> > > values 0x1, 0x11 are written by driver values 0x0, 0x10 are written
>> > > by device
>> >
>> > The 0x prefix might add to the confusion here. It is really just two
>> > bits, no?
>>
>> Ouch. Yes I meant 0b. Thanks!
>0b00, 0b10 are written by device?
>I suppose device can only clear high bit, can keep low bit no change.
>Then the value written by device can be either 0b01 or 0b00, but 0b10 means to set high bit, no?
>
>>
>> > > each time driver writes out a descriptor, it must make sure that the
>> > > high bit in OWNER changes.
>> > >
>> > > each time device writes out a descriptor, it must make sure that the
>> > > high bit in OWNER does not change.
>Typo here? It should be "..., it must make sure that the low bit in OWNER does not change."?
>For high bit in OWNER, each time devices writes out a descriptor, it must make sure to clear high bit in OWNER.
>
>> > >
>> > > this is exactly the same functionally, DRIVER is high bit and WRAP
>> > > is the low bit.  Does this make things clearer?
>> >
>> > So far it makes sense to me.
>It sounds good.

So I implemented two ideas in the DPDK prototype code. The code is
very rough and simple. I'll describe again how I understood the ideas.

1. The one discussed in this thread: Adding two flags DESC_DRIVER and DESC_WRAP. 

Driver code: keeps an internal wrap value. Every time we cross the ring
boundary at descriptor 0 the wrap value is flipped. For all
descriptors used from this point on we will set the DESC_WRAP flag if it wasn't
set before or the other way round. Driver code looks at the
DESC_DRIVER flag to check if the descriptor is available for it to
use.  

Device code: when dequeuing descriptors from the ring it keeps going
until it sees a different value in the DESC_WRAP bit. Device only
checks this bit but doesn't change it. Device clears DESC_DRIVER when
done with descriptor to signal to driver that descriptor can be reused.

https://github.com/jensfr/dpdk/tree/add-driver-and-wrap-flag

2. Driver writes ID of last written descriptor into index field of first
descriptor and turns on a flag DESC_SKIP in the descriptor. (This idea is from Michael)

Driver code: Let's say driver adds 32 descriptors to the ring at once.
It fills in starting at ring position 0 to 31. It will write 31 to the
index field of descriptor 0. 

Device code: When dequeueing descriptors from the ring it looks into
the first descriptor. For example, it looks at desc[0] and the index field is 31
instead of 0. In addition to this the flag DESC_SKIP is set. The
device can expect all descriptors in the ring from 0 to 31 to be ready
for it to dequeue and doesn't have to check the DESC_HW flag.

https://github.com/jensfr/dpdk/tree/desc-hw-index-hint


I tried implementing both ideas on top of the DPDK prototype code
(without the DESC_WB code) and ran a quick test with two testpmd
instances, one with a vhost-user interface and the other one with a
virtio-user device. 

From a performance point of view I saw no difference between both
implementations. 

I understand that DESC_DRIVER/DESC_WRAP would be better for virtio
hardware implementations?

regards,
Jens 
