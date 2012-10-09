From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 09 Oct 2012 22:24:16 +0200
Message-ID: <507487F0.2050609@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
	<5073C52D.20802@redhat.com> <87wqyzll8r.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87wqyzll8r.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

>> Why use two bars for this?  You can put them into one mmio bar, together
>> with the msi-x vector table and PBA.  Of course a pci capability
>> describing the location is helpful for that ;)
> 
> You don't need a capability.  You can also just add a "config offset"
> field to the register set and then make the semantics that it occurs in
> the same region.

Yes, that will work too.  Removes some freedom to place the register
ranges, but given that we don't want burn bars and thus prefer to place
everything into a single mmio bar that shouldn't be an issue.  Real
hardware does this too btw (xhci for example).

>> Main advantage of defining a register set with just isr is that it
>> reduces pio address space consumtion for new virtio devices which don't
>> have to worry about the legacy layout (8 bytes which is minimum size for
>> io bars instead of 64 bytes).
> 
> Doing some rough math, we should have at least 16k of PIO space.  That
> let's us have well over 500 virtio-pci devices with the current register
> layout.

I've seen worries nevertheless, but given we have virtio-scsi now which
can handle lots of disks without needing lots of virtio-pci devices it
is probably not that a big issue any more.

>>>> The detection is simple: if BAR1 has non-zero length, it's new-style,
>>>> otherwise legacy.
>>
>> Doesn't fly.  BAR1 is in use today for MSI-X support.
> 
> But the location is specified via capabilities so we can change the
> location to be within BAR1 at a non-conflicting offset.

Sure.  Nevertheless "BAR1 has non-zero length" can't be used to detect
new-style virtio as old-style devices already have BAR1 with a non-zero
length.

So how about this:

(1) Add a vendor specific pci capability for new-style virtio.
    Specifies the pci bar used for new-style virtio registers.
    Guests can use it to figure whenever new-style virtio is
    supported and to map the correct bar (which will probably
    be bar 1 in most cases).

(2) Have virtio-offsets register set, located at the new-style bar,
    offset 0:

    struct virtio_offsets {
       __le32 num_offsets;        // so we can extend this later
       __le32 virtio_pci_offset;  // location of virtio-pci registers
       __le32 virtio_cfg_offset;  // location of virtio config space
    };

(3) place virtio-pci registers (same as 0..23 in bar 0) in the new-style
    bar, offset virtio_pci_offset

(4) place virtio config space (same as 20+/24+ in bar 0) in the
    new-style bar, offset virtio_cfg_offset

cheers,
  Gerd
