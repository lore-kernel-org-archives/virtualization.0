From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 09 Oct 2012 08:33:17 +0200
Message-ID: <5073C52D.20802@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sj9oh0pm.fsf@codemonkey.ws>
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

>> Well, we also want to clean up the registers, so how about:
>>
>> BAR0: legacy, as is.  If you access this, don't use the others.

Ok.

>> BAR1: new format virtio-pci layout.  If you use this, don't use BAR0.
>> BAR2: virtio-cfg.  If you use this, don't use BAR0.

Why use two bars for this?  You can put them into one mmio bar, together
with the msi-x vector table and PBA.  Of course a pci capability
describing the location is helpful for that ;)

>> BAR3: ISR. If you use this, don't use BAR0.

Again, I wouldn't hardcode that but use a capability.

>> I prefer the cases exclusive (ie. use one or the other) as a clear path
>> to remove the legacy layout; and leaving the ISR in BAR0 leaves us with
>> an ugly corner case in future (ISR is BAR0 + 19?  WTF?).

Ok, so we have four register sets:

  (1) legacy layout
  (2) new virtio-pci
  (3) new virtio-config
  (4) new virtio-isr

We can have a vendor pci capability, with a dword for each register set:

  bit  31    -- present bit
  bits 26-24 -- bar
  bits 23-0  -- offset

So current drivers which must support legacy can use this:

  legacy layout     -- present, bar 0, offset 0
  new virtio-pci    -- present, bar 1, offset 0
  new virtio-config -- present, bar 1, offset 256
  new virtio-isr    -- present, bar 0, offset 19

[ For completeness: msi-x capability could add this: ]

  msi-x vector table            bar 1, offset 512
  msi-x pba                     bar 1, offset 768

> We'll never remove legacy so we shouldn't plan on it.  There are
> literally hundreds of thousands of VMs out there with the current virtio
> drivers installed in them.  We'll be supporting them for a very, very
> long time :-)

But new devices (virtio-qxl being a candidate) don't have old guests and
don't need to worry.

They could use this if they care about fast isr:

  legacy layout     -- not present
  new virtio-pci    -- present, bar 1, offset 0
  new virtio-config -- present, bar 1, offset 256
  new virtio-isr    -- present, bar 0, offset 0

Or this if they don't worry about isr performance:

  legacy layout     -- not present
  new virtio-pci    -- present, bar 0, offset 0
  new virtio-config -- present, bar 0, offset 256
  new virtio-isr    -- not present

> I don't think we gain a lot by moving the ISR into a separate BAR.
> Splitting up registers like that seems weird to me too.

Main advantage of defining a register set with just isr is that it
reduces pio address space consumtion for new virtio devices which don't
have to worry about the legacy layout (8 bytes which is minimum size for
io bars instead of 64 bytes).

> If we added an additional constraints that BAR1 was mirrored except for

Why add constraints?  We want something future-proof, don't we?

>> The detection is simple: if BAR1 has non-zero length, it's new-style,
>> otherwise legacy.

Doesn't fly.  BAR1 is in use today for MSI-X support.

> I agree that this is the best way to extend, but I think we should still
> use a transport feature bit.  We want to be able to detect within QEMU
> whether a guest is using these new features because we need to adjust
> migration state accordingly.

Why does migration need adjustments?

[ Not that I want veto a feature bit, but I don't see the need yet ]

cheers,
  Gerd
