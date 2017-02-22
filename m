From: "Chien, Roger S" <roger.s.chien@intel.com>
Subject: RE: [virtio-dev] packed ring layout proposal v2
Date: Wed, 22 Feb 2017 14:46:47 +0000
Message-ID: <58248A67F315F644AC7E6E5AD11DC3533ABEA25E__19610.5683608495$1487967525$gmane$org@SHSMSX104.ccr.corp.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
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
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Here are some feedbacks w.r.t virtio v1.1 proposal from FPGA implementation view point. 

1) As the Gary presented, depends on flags to determine ownership of descriptors is not efficiency. And for QPI FPGA platform, it may also lead to race condition because current design only support whole cache line read/write and no partial  byte enabled. Even with partial byte enable, it will cause the CPU/FPGA to invalidate the whole cache line even when you just toggle one bit (For RX, return the descriptor to SW....)

2) S/G is a nightmare to HW, because next descriptor is only available when you have it. So the HW is unable to parallelize descriptor fetching & buffer fetching. Indirect table is better (compare to indirect linked list). But it even better if we can put chained descriptors inside the original descriptor table and using a flag to indicate that their buffers belong to the a large piece (but may be conflict to flexibility to increase/decrease descriptors in run time)

3) Better to keep power of 2 ring size from HW viewpoint. But not so painful if we need to support non power of 2 ring size. (Single AND mask versus comparator)


-----Original Message-----
From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On Behalf Of Michael S. Tsirkin
Sent: Wednesday, February 8, 2017 11:20 AM
To: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
Subject: [virtio-dev] packed ring layout proposal v2

This is an update from v1 version.
Changes:
- update event suppression mechanism
- separate options for indirect and direct s/g
- lots of new features

---

Performance analysis of this is in my kvm forum 2016 presentation.
The idea is to have a r/w descriptor in a ring structure, replacing the used and available ring, index and descriptor buffer.

* Descriptor ring:

Guest adds descriptors with unique index values and DESC_HW set in flags.
Host overwrites used descriptors with correct len, index, and DESC_HW clear.  Flags are always set/cleared last.

#define DESC_HW 0x0080

struct desc {
        __le64 addr;
        __le32 len;
        __le16 index;
        __le16 flags;
};

When DESC_HW is set, descriptor belongs to device. When it is clear, it belongs to the driver.

We can use 1 bit to set direction
/* This marks a buffer as write-only (otherwise read-only). */
#define VRING_DESC_F_WRITE      2

* Scatter/gather support

We can use 1 bit to chain s/g entries in a request, same as virtio 1.0:

/* This marks a buffer as continuing via the next field. */
#define VRING_DESC_F_NEXT       1

Unlike virtio 1.0, all descriptors must have distinct ID values.

Also unlike virtio 1.0, use of this flag will be an optional feature (e.g. VIRTIO_F_DESC_NEXT) so both devices and drivers can opt out of it.

* Indirect buffers

Can be marked like in virtio 1.0:

/* This means the buffer contains a table of buffer descriptors. */
#define VRING_DESC_F_INDIRECT   4

Unlike virtio 1.0, this is a table, not a list:
struct indirect_descriptor_table {
        /* The actual descriptors (16 bytes each) */
        struct virtq_desc desc[len / 16]; };

The first descriptor is located at start of the indirect descriptor table, additional indirect descriptors come immediately afterwards.
DESC_F_WRITE is the only valid flag for descriptors in the indirect table. Others should be set to 0 and are ignored.  id is also set to 0 and should be ignored.

virtio 1.0 seems to allow a s/g entry followed by an indirect descriptor. This does not seem useful, so we do not allow that anymore.

This support would be an optional feature, same as in virtio 1.0

* Batching descriptors:

virtio 1.0 allows passing a batch of descriptors in both directions, by incrementing the used/avail index by values > 1.  We can support this by chaining a list of descriptors through a bit the flags field.
To allow use together with s/g, a different bit will be used.

#define VRING_DESC_F_BATCH_NEXT 0x0010

Batching works for both driver and device descriptors.



* Processing descriptors in and out of order

Device processing all descriptors in order can simply flip the DESC_HW bit as it is done with descriptors.

Device can write descriptors out in order as they are used, overwriting descriptors that are there.

Device must not use a descriptor until DESC_HW is set.
It is only required to look at the first descriptor submitted.

Driver must not overwrite a descriptor until DESC_HW is clear.
It is only required to look at the first descriptor submitted.

* Device specific descriptor flags
We have a lot of unused space in the descriptor.  This can be put to good use by reserving some flag bits for device use.
For example, network device can set a bit to request that header in the descriptor is suppressed (in case it's all 0s anyway). This reduces cache utilization.

Note: this feature can be supported in virtio 1.0 as well, as we have unused bits in both descriptor and used ring there.

* Descriptor length in device descriptors

virtio 1.0 places strict requirements on descriptor length. For example it must be 0 in used ring of TX VQ of a network device since nothing is written.  In practice guests do not seem to use this, so we can simplify devices a bit by removing this requirement - if length is unused it should be ignored by driver.

Some devices use identically-sized buffers in all descriptors.
Ignoring length for driver descriptors there could be an option too.

* Writing at an offset

Some devices might want to write into some descriptors at an offset, the offset would be in config space, and a descriptor flag could indicate this:

#define VRING_DESC_F_OFFSET 0x0020

How exactly to use the offset would be device specific, for example it can be used to align beginning of packet in the 1st buffer for mergeable buffers to cache line boundary while also aligning rest of buffers.

* Non power-of-2 ring sizes

As the ring simply wraps around, there's no reason to require ring size to be power of two.
It can be made a separate feature though.


* Interrupt/event suppression

virtio 1.0 has two mechanisms for suppression but only one can be used at a time. we pack them together in a structure - one for interrupts, one for notifications:

struct event {
	__le16 idx;
	__le16 flags;
}

Both fields would be optional, with a feature bit:
VIRTIO_F_EVENT_IDX
VIRTIO_F_EVENT_FLAGS

* Flags can be used like in virtio 1.0, by storing a special value there:

#define VRING_F_EVENT_ENABLE  0x0

#define VRING_F_EVENT_DISABLE 0x1

* Event index would be in the range 0 to 2 * Queue Size (to detect wrap arounds) and wrap to 0 after that.

The assumption is that each side maintains an internal descriptor counter 0 to 2 * Queue Size that wraps to 0.
In that case, interrupt triggers when counter reaches the given value.

* If both features are negotiated, a special flags value can be used to switch to event idx:

#define VRING_F_EVENT_IDX     0x2


* Prototype

A partial prototype can be found under
tools/virtio/ringtest/ring.c

Test run:
[mst@tuck ringtest]$ time ./ring 
real    0m0.399s
user    0m0.791s
sys     0m0.000s
[mst@tuck ringtest]$ time ./virtio_ring_0_9
real    0m0.503s
user    0m0.999s
sys     0m0.000s

It is planned to update it to this interface. Future changes and enhancements can (and should) be tested against this prototype.

* Feature sets
In particular are we going overboard with feature bits?  It becomes hard to support all combinations in drivers and devices.  Maybe we should document reasonable feature sets to be supported for each device.

* Known issues/ideas

This layout is optimized for host/guest communication, in a sense even more aggressively than virtio 1.0.
It might be suboptimal for PCI hardware implementations.
However, one notes that current virtio pci drivers are unlikely to work with PCI hardware implementations anyway (e.g. due to use of SMP barriers for ordering).

Suggestions for improving this are welcome but need to be tested to make sure our main use case does not regress.  Of course some improvements might be made optional, but if we add too many of these driver becomes unmanageable.

---

Note: should this proposal be accepted and approved, one or more
      claims disclosed to the TC admin and listed on the Virtio TC
      IPR page https://www.oasis-open.org/committees/virtio/ipr.php
      might become Essential Claims.

--
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
