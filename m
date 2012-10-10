From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Wed, 10 Oct 2012 14:14:11 +1030
Message-ID: <87wqyz6lf8.fsf@rustcorp.com.au>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
	<87haq48hds.fsf@rustcorp.com.au> <874nm3ycj8.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <874nm3ycj8.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> Rusty Russell <rusty@rustcorp.com.au> writes:
>
>> Anthony Liguori <aliguori@us.ibm.com> writes:
>>> We'll never remove legacy so we shouldn't plan on it.  There are
>>> literally hundreds of thousands of VMs out there with the current virtio
>>> drivers installed in them.  We'll be supporting them for a very, very
>>> long time :-)
>>
>> You will be supporting this for qemu on x86, sure.
>
> And PPC.

Yeah, Ben was a bit early fixing the virtio bugs I guess.  Oh well.

>> As I think we're
>> still in the growth phase for virtio, I prioritize future spec
>> cleanliness pretty high.
>>
>> But I think you'll be surprised how fast this is deprecated:
>> 1) Bigger queues for block devices (guest-specified ringsize)
>> 2) Smaller rings for openbios (guest-specified alignment)
>> 3) All-mmio mode (powerpc)
>> 4) Whatever network features get numbers > 31.
>
> We can do all of these things with incremental change to the existing
> layout.  That's the only way what I'm suggesting is different.

Now extend your proposal to add all those features we want.  We add
if()s to the driver that we need to keep forever.  Let's just look at
what your proposal get us:

bool has_feature(struct virtio_pci_dev *dev, u32 num)
{
        /* Do we need to set selector? */
        if (dev->extended_features) {
                unsigned long selector_off = VIRTIO_PCI_HOST_FEATURES_SELECT;
                if (dev->using_bar0 && !dev->msi_active)
                        selector_off -= 32;
                writel(dev->config + selector_off, num / 32);
                num &= 31;
        } else if (num > 31)
                return false;
        return readl(dev->config + VIRTIO_PCI_HOST_FEATURES) & (1 << num);
}

vs two cases which independent with methods set at detection time:

virtio_pci_legacy.c:
bool has_feature(struct virtio_pci_dev *dev, u32 num)
{
        if (num > 31)
                return false;
        return readl(dev->config + VIRTIO_PCI_LEGACY_HOST_FEATURES) & (1 << num);
}

virtio_pci_new.c:
bool has_feature(struct virtio_pci_dev *dev, u32 num)
{
        writel(dev->config + VIRTIO_PCI_HOST_FEATURES_SELECT, num / 32);
        num &= 31;
        return readl(dev->config + VIRTIO_PCI_HOST_FEATURES) & (1 << num);
}

> You want to reorder all of the fields and have a driver flag day.  But I
> strongly suspect we'll decide we need to do the same exercise again in 4
> years when we now need to figure out how to take advantage of
> transactional memory or some other whiz-bang hardware feature.

It's not a flag day, as it's backwards compatible.

Sure, we might have a clean cut again.  I'm not afraid to rewrite this
code to make it cleaner; perhaps this is somewhere qemu could benefit
from a similar approach.

> What I'm suggesting is:
>
>> struct {
>>         __le32 host_features;   /* read-only */
>>         __le32 guest_features;  /* read/write */
>>         __le32 queue_pfn;       /* read/write */
>>         __le16 queue_size;      /* read-only */
>>         __le16 queue_sel;       /* read/write */
>>         __le16 queue_notify;    /* read/write */
>>         u8 status;              /* read/write */
>>         u8 isr;                 /* read-only, clear on read */
>>         __le16 msi_config_vector;       /* read/write */
>>         __le16 msi_queue_vector;        /* read/write */
>>         __le32 host_feature_select;     /* read/write */
>>         __le32 guest_feature_select;    /* read/write */
>>         __le32 queue_pfn_hi;            /* read/write */
>> };
>
> With the additional semantic that the virtio-config space is overlayed
> on top of the register set in BAR0 unless the
> VIRTIO_PCI_F_SEPARATE_CONFIG feature is acknowledged.  This feature
> acts as a latch and when set, removes the config space overlay.
>
> If the config space overlays the registers, the offset in BAR0 of the
> overlay depends on whether MSI is enabled or not in the PCI device.
>
> BAR1 is an MMIO mirror of BAR0 except that the config space is never
> overlayed in BAR1 regardless of VIRTIO_PCI_F_SEPARATE_CONFIG.

Creating a horrible mess for new code in order to support old code.
But I have to maintain the new code, and this is horrible.

> You mean, "accesses to bar1/2/3" change it to modern mode.  That's a
> pretty big side effect of a read.

They don't need to, but I'd prefer they did to keep implementations
from mixing old and new.

> See above.  A guest could happily just use BAR1/BAR2 and completely
> ignore BAR0 provided that BAR1/BAR2 are present.

But x86 guests want BAR0 because IO space is faster than MMIO.  Right?
So, not "happily".

> It also means the guest drivers don't need separate code paths for
> "legacy" vs. "modern".  They can switch between the two by just changing
> a single pointer.

This is wrong.  Of course they have separate code paths, but now you've
got lots of crossover, rather than two distinct ones.

> The implementation ends up being pretty trivial too.  We can use the
> same MemoryRegion in QEMU for both PIO and MMIO.  The kernel code stays
> the same.  It just takes a couple if()s to handle whether there's a
> config overlay or not.

"A couple of ifs" for every feature, and they nest.  You end up with
exponential complexity and an untestable mess.  That's why this change
is an opportunity.

Not a feature bit for 64 bit device offsets, and another for extended
features and another for size negotiation and another for alignment
setting.  That would be a maintenance nightmare for no good reason.

Cheers,
Rusty.
