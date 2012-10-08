From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Mon, 08 Oct 2012 08:58:34 -0500
Message-ID: <87bogddq0l.fsf__18057.0666598671$1349704742$gmane$org@codemonkey.ws>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87y5jhpuu2.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> (Topic updated, cc's trimmed).
>
> Anthony Liguori <aliguori@us.ibm.com> writes:
>> Rusty Russell <rusty@rustcorp.com.au> writes:
>>> 4) The only significant change to the spec is that we use PCI
>>>    capabilities, so we can have infinite feature bits.
>>>    (see http://lists.linuxfoundation.org/pipermail/virtualization/2011-December/019198.html)
>>
>> We discussed this on IRC last night.  I don't think PCI capabilites are
>> a good mechanism to use...
>>
>> PCI capabilities are there to organize how the PCI config space is
>> allocated to allow vendor extensions to co-exist with future PCI
>> extensions.
>>
>> But we've never used the PCI config space within virtio-pci.  We do
>> everything in BAR0.  I don't think there's any real advantage of using
>> the config space vs. a BAR for virtio-pci.
>
> Note before anyone gets confused; we were talking about using the PCI
> config space to indicate what BAR(s) the virtio stuff is in.  An
> alternative would be to simply specify a new layout format in BAR1.
>
> The arguments for a more flexible format that I know of:
>
> 1) virtio-pci has already extended the pci-specific part of the
>    configuration once (for MSI-X), so I don't want to assume it won't
>    happen again.

"configuration" is the wrong word here.

The virtio-pci BAR0 layout is:

   0..19   virtio-pci registers
   20+     virtio configuration space

MSI-X needed to add additional virtio-pci registers, so now we have:

   0..19   virtio-pci registers

if MSI-X:
   20..23  virtio-pci MSI-X registers
   24+     virtio configuration space
else:
   20+     virtio configuration space

I agree, this stinks.

But I think we could solve this in a different way.  I think we could
just move the virtio configuration space to BAR1 by using a transport
feature bit.

That then frees up the entire BAR0 for use as virtio-pci registers.  We
can then always include the virtio-pci MSI-X register space and
introduce all new virtio-pci registers as simply being appended.

This new feature bit then becomes essentially a virtio configuration
latch.  When unacked, virtio configuration hides new registers, when
acked, those new registers are exposed.

Another option is to simply put new registers after the virtio
configuration blob.

> 2) ISTR an argument about mapping the ISR register separately, for
>    performance, but I can't find a reference to it.

I think the rationale is that ISR really needs to be PIO but everything
else doesn't.  PIO is much faster on x86 because it doesn't require
walking page tables or instruction emulation to handle the exit.

The argument to move the remaining registers to MMIO is to allow 64-bit
accesses to registers which isn't possible with PIO.

>> This maps really nicely to non-PCI transports too.
>
> This isn't right.  Noone else can use the PCI layout.  While parts are
> common, other parts are pci-specific (MSI-X and ISR for example), and
> yet other parts are specified by PCI elsewhere (eg interrupt numbers).
>
>> But extending the
>> PCI config space (especially dealing with capability allocation) is
>> pretty gnarly and there isn't an obvious equivalent outside of PCI.
>
> That's OK, because general changes should be done with feature bits, and
> the others all have an infinite number.  Being the first, virtio-pci has
> some unique limitations we'd like to fix.
>
>> There are very devices that we emulate today that make use of extended
>> PCI device registers outside the platform devices (that have no BARs).
>
> This sentence confused me?

There is a missing "few".  "There are very few devices..."

Extending the PCI configuration space is unusual for PCI devices.  That
was the point.

Regards,

Anthony Liguori

>
> Thanks,
> Rusty.
