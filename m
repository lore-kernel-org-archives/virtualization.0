From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Tue, 09 Oct 2012 13:46:15 +1030
Message-ID: <87haq48hds.fsf__19612.1710855097$1349752947$gmane$org@rustcorp.com.au>
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
To: Anthony Liguori <aliguori@us.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> We'll never remove legacy so we shouldn't plan on it.  There are
> literally hundreds of thousands of VMs out there with the current virtio
> drivers installed in them.  We'll be supporting them for a very, very
> long time :-)

You will be supporting this for qemu on x86, sure.  As I think we're
still in the growth phase for virtio, I prioritize future spec
cleanliness pretty high.

But I think you'll be surprised how fast this is deprecated:
1) Bigger queues for block devices (guest-specified ringsize)
2) Smaller rings for openbios (guest-specified alignment)
3) All-mmio mode (powerpc)
4) Whatever network features get numbers > 31.

> I don't think we gain a lot by moving the ISR into a separate BAR.
> Splitting up registers like that seems weird to me too.

Confused.  I proposed the same split as you have, just ISR by itself.

> It's very normal to have a mirrored set of registers that are PIO in one
> bar and MMIO in a different BAR.
>
> If we added an additional constraints that BAR1 was mirrored except for
> the config space and the MSI section was always there, I think the end
> result would be nice.  IOW:

But it won't be the same, because we want all that extra stuff, like
more feature bits and queue size alignment.  (Admittedly queues past
16TB aren't a killer feature).

To make it concrete:

Current:
struct {
        __le32 host_features;   /* read-only */
        __le32 guest_features;  /* read/write */
        __le32 queue_pfn;       /* read/write */
        __le16 queue_size;      /* read-only */
        __le16 queue_sel;       /* read/write */
        __le16 queue_notify;    /* read/write */
        u8 status;              /* read/write */
        u8 isr;                 /* read-only, clear on read */
        /* Optional */
        __le16 msi_config_vector;       /* read/write */
        __le16 msi_queue_vector;        /* read/write */
        /* ... device features */
};

Proposed:
struct virtio_pci_cfg {
	/* About the whole device. */
	__le32 device_feature_select;	/* read-write */
	__le32 device_feature;		/* read-only */
	__le32 guest_feature_select;	/* read-write */
	__le32 guest_feature;		/* read-only */
	__le16 msix_config;		/* read-write */
	__u8 device_status;		/* read-write */
	__u8 unused;

	/* About a specific virtqueue. */
	__le16 queue_select;	/* read-write */
	__le16 queue_align;	/* read-write, power of 2. */
	__le16 queue_size;	/* read-write, power of 2. */
	__le16 queue_msix_vector;/* read-write */
	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
};

struct virtio_pci_isr {
        __u8 isr;                 /* read-only, clear on read */
};

We could also enforce LE in the per-device config space in this case,
another nice cleanup for PCI people.

> BAR0[pio]: virtio-pci registers + optional MSI section + virtio-config
> BAR1[mmio]: virtio-pci registers + MSI section + future extensions
> BAR2[mmio]: virtio-config
>
> We can continue to do ISR access via BAR0 for performance reasons.

But powerpc explicitly *doesnt* want a pio bar.  So let it be its own
bar, which can be either.

>> As to MMIO vs PIO, the BARs are self-describing, so we should explicitly
>> endorse that and leave it to the devices.
>>
>> The detection is simple: if BAR1 has non-zero length, it's new-style,
>> otherwise legacy.
>
> I agree that this is the best way to extend, but I think we should still
> use a transport feature bit.  We want to be able to detect within QEMU
> whether a guest is using these new features because we need to adjust
> migration state accordingly.
>
> Otherwise we would have to detect reads/writes to the new BARs to
> maintain whether the extended register state needs to be saved.  This
> gets nasty dealing with things like reset.

I don't think it'll be that bad; reset clears the device to unknown,
bar0 moves it from unknown->legacy mode, bar1/2/3 changes it from
unknown->modern mode, and anything else is bad (I prefer being strict so
we catch bad implementations from the beginning).

But I'm happy to implement it and see what it's like.

> A feature bit simplifies this all pretty well.

I suspect it will be quite ugly, actually.  The guest has to use BAR0 to
get the features to see if they can use BAR1.  Do they ack the feature
(via BAR0) before accessing BAR1?  If not, qemu can't rely on the
feature bit.

Cheers,
Rusty.
