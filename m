From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Wed, 10 Oct 2012 13:24:45 +1030
Message-ID: <87zk3v6npm.fsf__27353.0989689336$1349863373$gmane$org@rustcorp.com.au>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
	<507333F1.1060000@redhat.com> <874nm4u1in.fsf@codemonkey.ws>
	<87sj9o8qn7.fsf@rustcorp.com.au> <87sj9oh0pm.fsf@codemonkey.ws>
	<5073C52D.20802@redhat.com> <87wqyzll8r.fsf@codemonkey.ws>
	<507487F0.2050609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <507487F0.2050609@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann <kraxel@redhat.com> writes:
> So how about this:
>
> (1) Add a vendor specific pci capability for new-style virtio.
>     Specifies the pci bar used for new-style virtio registers.
>     Guests can use it to figure whenever new-style virtio is
>     supported and to map the correct bar (which will probably
>     be bar 1 in most cases).

This was closer to the original proposal[1], which I really liked (you
can layout bars however you want).  Anthony thought that vendor
capabilities were a PCI-e feature, but it seems they're blessed in PCI
2.3.

So let's return to that proposal, giving something like this:

/* IDs for different capabilities.  Must all exist. */
/* FIXME: Do we win from separating ISR, NOTIFY and COMMON? */
/* Common configuration */
#define VIRTIO_PCI_CAP_COMMON_CFG	1
/* Notifications */
#define VIRTIO_PCI_CAP_NOTIFY_CFG	2
/* ISR access */
#define VIRTIO_PCI_CAP_ISR_CFG		3
/* Device specific confiuration */
#define VIRTIO_PCI_CAP_DEVICE_CFG	4

/* This is the PCI capability header: */
struct virtio_pci_cap {
	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
	u8 cap_next;	/* Generic PCI field: next ptr. */
	u8 cap_len;	/* Generic PCI field: sizeof(struct virtio_pci_cap). */
	u8 cfg_type;	/* One of the VIRTIO_PCI_CAP_*_CFG. */
	u8 bar;		/* Where to find it. */
	u8 unused;
	__le16 offset;	/* Offset within bar. */
	__le32 length;	/* Length. */
};

This means qemu can point the isr_cfg into the legacy area if it wants.
In fact, it can put everything in BAR0 if it wants.

Thoughts?
Rusty.
