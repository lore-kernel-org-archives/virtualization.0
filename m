From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Mon, 08 Oct 2012 20:51:33 -0500
Message-ID: <87sj9oh0pm.fsf@codemonkey.ws>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sj9o8qn7.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Anthony Liguori <aliguori@us.ibm.com> writes:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>>   Hi,
>>>
>>>>> So we could have for virtio something like this:
>>>>>
>>>>>         Capabilities: [??] virtio-regs:
>>>>>                 legacy: BAR=0 offset=0
>>>>>                 virtio-pci: BAR=1 offset=1000
>>>>>                 virtio-cfg: BAR=1 offset=1800
>>>> 
>>>> This would be a vendor specific PCI capability so lspci wouldn't
>>>> automatically know how to parse it.
>>>
>>> Sure, would need a patch to actually parse+print the cap,
>>> /me was just trying to make my point clear in a simple way.
>>>
>>>>>>> 2) ISTR an argument about mapping the ISR register separately, for
>>>>>>>    performance, but I can't find a reference to it.
>>>>>>
>>>>>> I think the rationale is that ISR really needs to be PIO but everything
>>>>>> else doesn't.  PIO is much faster on x86 because it doesn't require
>>>>>> walking page tables or instruction emulation to handle the exit.
>>>>>
>>>>> Is this still a pressing issue?  With MSI-X enabled ISR isn't needed,
>>>>> correct?  Which would imply that pretty much only old guests without
>>>>> MSI-X support need this, and we don't need to worry that much when
>>>>> designing something new ...
>>>> 
>>>> It wasn't that long ago that MSI-X wasn't supported..  I think we should
>>>> continue to keep ISR as PIO as it is a fast path.
>>>
>>> No problem if we allow to have both legacy layout and new layout at the
>>> same time.  Guests can continue to use ISR @ BAR0 in PIO space for
>>> existing virtio devices, even in case they want use mmio for other
>>> registers -> all fine.
>>>
>>> New virtio devices can support MSI-X from day one and decide to not
>>> expose a legacy layout PIO bar.
>>
>> I think having BAR1 be an MMIO mirror of the registers + a BAR2 for
>> virtio configuration space is probably not that bad of a solution.
>
> Well, we also want to clean up the registers, so how about:
>
> BAR0: legacy, as is.  If you access this, don't use the others.
> BAR1: new format virtio-pci layout.  If you use this, don't use BAR0.
> BAR2: virtio-cfg.  If you use this, don't use BAR0.
> BAR3: ISR. If you use this, don't use BAR0.
>
> I prefer the cases exclusive (ie. use one or the other) as a clear path
> to remove the legacy layout; and leaving the ISR in BAR0 leaves us with
> an ugly corner case in future (ISR is BAR0 + 19?  WTF?).

We'll never remove legacy so we shouldn't plan on it.  There are
literally hundreds of thousands of VMs out there with the current virtio
drivers installed in them.  We'll be supporting them for a very, very
long time :-)

I don't think we gain a lot by moving the ISR into a separate BAR.
Splitting up registers like that seems weird to me too.

It's very normal to have a mirrored set of registers that are PIO in one
bar and MMIO in a different BAR.

If we added an additional constraints that BAR1 was mirrored except for
the config space and the MSI section was always there, I think the end
result would be nice.  IOW:

BAR0[pio]: virtio-pci registers + optional MSI section + virtio-config
BAR1[mmio]: virtio-pci registers + MSI section + future extensions
BAR2[mmio]: virtio-config

We can continue to do ISR access via BAR0 for performance reasons.

> As to MMIO vs PIO, the BARs are self-describing, so we should explicitly
> endorse that and leave it to the devices.
>
> The detection is simple: if BAR1 has non-zero length, it's new-style,
> otherwise legacy.

I agree that this is the best way to extend, but I think we should still
use a transport feature bit.  We want to be able to detect within QEMU
whether a guest is using these new features because we need to adjust
migration state accordingly.

Otherwise we would have to detect reads/writes to the new BARs to
maintain whether the extended register state needs to be saved.  This
gets nasty dealing with things like reset.

A feature bit simplifies this all pretty well.

Regards,

Anthony Liguori

>
> Thoughts?
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
