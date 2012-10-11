From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using PCI config space to indicate config location
Date: Thu, 11 Oct 2012 12:23:34 +0200
Message-ID: <20121011102333.GA5552@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <20121010083033.GA4799@redhat.com>
	<87bog9957l.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87bog9957l.fsf@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 11, 2012 at 11:48:22AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Mon, Oct 08, 2012 at 12:51:25PM +1030, Rusty Russell wrote:
> >> Note before anyone gets confused; we were talking about using the PCI
> >> config space to indicate what BAR(s) the virtio stuff is in.  An
> >> alternative would be to simply specify a new layout format in BAR1.
> >
> > One problem we are still left with is this: device specific
> > config accesses are still non atomic.
> > This is a problem for multibyte fields such as MAC address
> > where MAC could change while we are accessing it.
> 
> It's also a problem for related fields, eg. console width and height, or
> disk geometry.
> 
> > I was thinking about some backwards compatible way to solve this, but if
> > we are willing to break compatiblity or use some mode switch, how about
> > we give up on virtio config space completely, and do everything besides
> > IO and ISR through guest memory?
> 
> I think there's still a benefit in the simple publishing of information:
> I don't really want to add a control queue for the console.

One reason I thought using a vq is handy is because this would
let us get by with a single MSI vector. Currently we need at least 2
for config changes + a shared one for vqs.
But I don't insist.

>  But
> inevitably, once-static information can change in later versions, and
> it's horrible to have config information plus a bit that says "don't use
> this, use the control queue".
> 
> Here's a table from a quick audit:
> 
> Driver          Config       Device changes    Driver writes... after init?
> net             Y            Y                 N                N
> block           Y            Y                 Y                Y
> console         Y            Y                 N                N
> rng             N            N                 N                N
> balloon         Y            Y                 Y                Y
> scsi            Y            N                 Y                N
> 9p              Y            N                 N                N
> 
> For config space reads, I suggest the driver publish a generation count.

You mean device?

> For writes, the standard seems to be a commit latch.  We could abuse the
> generation count for this: the driver writes to it to commit config
> changes.

I think this will work. There are a couple of things that bother me:

This assumes read accesses have no side effects, and these are sometimes handy.
Also the semantics for write aren't very clear to me.
I guess device must buffer data until generation count write?
This assumes the device has a buffer to store writes,
and it must track each byte written. I kind of dislike this
tracking of accessed bytes. Also, device would need to resolve conflicts
if any in some device specific way.

Maybe it's a good idea to make the buffer accesses explicit instead?
IOW require driver to declare intent to read/request write of a specific
config range.  We could for example do it like this:
	__le32 config_offset;
	__le32 config_len;
	__u8 config_cmd; /* write-only: 0 - read, 1 - write
			    config_len bytes at config_offset
			    from/to config space to/from device memory */
But maybe this is over-engineering?



> ie:
> /* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> struct virtio_pci_common_cfg {
> 	/* About the whole device. */
> 	__le32 device_feature_select;	/* read-write */
> 	__le32 device_feature;		/* read-only */
> 	__le32 guest_feature_select;	/* read-write */
> 	__le32 guest_feature;		/* read-only */
>         __le32 config_gen_and_latch;    /* read-write */
> 	__le16 msix_config;		/* read-write */
> 	__u8 device_status;		/* read-write */
> 	__u8 unused;
> 
> 	/* About a specific virtqueue. */
> 	__le16 queue_select;	/* read-write */
> 	__le16 queue_align;	/* read-write, power of 2. */
> 	__le16 queue_size;	/* read-write, power of 2. */
> 	__le16 queue_msix_vector;/* read-write */
> 	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
> };
> 
> Thoughts?
> Rusty.
> PS.  Let's make all the virtio-device config LE, too...

We'll need some new API for devices then: currently we pass bytes.

-- 
MST
