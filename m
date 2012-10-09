From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 09 Oct 2012 10:26:44 -0500
Message-ID: <87wqyzll8r.fsf__16340.6415297233$1349796438$gmane$org@codemonkey.ws>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
	<5073C52D.20802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5073C52D.20802@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>>> Well, we also want to clean up the registers, so how about:
>>>
>>> BAR0: legacy, as is.  If you access this, don't use the others.
>
> Ok.
>
>>> BAR1: new format virtio-pci layout.  If you use this, don't use BAR0.
>>> BAR2: virtio-cfg.  If you use this, don't use BAR0.
>
> Why use two bars for this?  You can put them into one mmio bar, together
> with the msi-x vector table and PBA.  Of course a pci capability
> describing the location is helpful for that ;)

You don't need a capability.  You can also just add a "config offset"
field to the register set and then make the semantics that it occurs in
the same region.

>
>>> BAR3: ISR. If you use this, don't use BAR0.
>
> Again, I wouldn't hardcode that but use a capability.
>
>>> I prefer the cases exclusive (ie. use one or the other) as a clear path
>>> to remove the legacy layout; and leaving the ISR in BAR0 leaves us with
>>> an ugly corner case in future (ISR is BAR0 + 19?  WTF?).
>
> Ok, so we have four register sets:
>
>   (1) legacy layout
>   (2) new virtio-pci
>   (3) new virtio-config
>   (4) new virtio-isr
>
> We can have a vendor pci capability, with a dword for each register set:
>
>   bit  31    -- present bit
>   bits 26-24 -- bar
>   bits 23-0  -- offset
>
> So current drivers which must support legacy can use this:
>
>   legacy layout     -- present, bar 0, offset 0
>   new virtio-pci    -- present, bar 1, offset 0
>   new virtio-config -- present, bar 1, offset 256
>   new virtio-isr    -- present, bar 0, offset 19
>
> [ For completeness: msi-x capability could add this: ]
>
>   msi-x vector table            bar 1, offset 512
>   msi-x pba                     bar 1, offset 768
>
>> We'll never remove legacy so we shouldn't plan on it.  There are
>> literally hundreds of thousands of VMs out there with the current virtio
>> drivers installed in them.  We'll be supporting them for a very, very
>> long time :-)
>
> But new devices (virtio-qxl being a candidate) don't have old guests and
> don't need to worry.
>
> They could use this if they care about fast isr:
>
>   legacy layout     -- not present
>   new virtio-pci    -- present, bar 1, offset 0
>   new virtio-config -- present, bar 1, offset 256
>   new virtio-isr    -- present, bar 0, offset 0
>
> Or this if they don't worry about isr performance:
>
>   legacy layout     -- not present
>   new virtio-pci    -- present, bar 0, offset 0
>   new virtio-config -- present, bar 0, offset 256
>   new virtio-isr    -- not present
>
>> I don't think we gain a lot by moving the ISR into a separate BAR.
>> Splitting up registers like that seems weird to me too.
>
> Main advantage of defining a register set with just isr is that it
> reduces pio address space consumtion for new virtio devices which don't
> have to worry about the legacy layout (8 bytes which is minimum size for
> io bars instead of 64 bytes).

Doing some rough math, we should have at least 16k of PIO space.  That
let's us have well over 500 virtio-pci devices with the current register
layout.

I don't think we're at risk of running out of space...

>> If we added an additional constraints that BAR1 was mirrored except for
>
> Why add constraints?  We want something future-proof, don't we?
>
>>> The detection is simple: if BAR1 has non-zero length, it's new-style,
>>> otherwise legacy.
>
> Doesn't fly.  BAR1 is in use today for MSI-X support.

But the location is specified via capabilities so we can change the
location to be within BAR1 at a non-conflicting offset.

>> I agree that this is the best way to extend, but I think we should still
>> use a transport feature bit.  We want to be able to detect within QEMU
>> whether a guest is using these new features because we need to adjust
>> migration state accordingly.
>
> Why does migration need adjustments?

Because there is additional state in the "new" layout.  We need to
understand whether a guest is relying on that state or not.

For instance, extended virtio features.  If a guest is in the process
of reading extended virtio features, it may not have changed any state
but we must ensure that we don't migrate to an older verison of QEMU w/o
the extended virtio features.

This cannot be handled by subsections today because there is no guest
written state that's affected.

Regards,

Anthony Liguori

>
> [ Not that I want veto a feature bit, but I don't see the need yet ]
>
> cheers,
>   Gerd
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
