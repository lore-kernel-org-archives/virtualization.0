From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Tue, 5 Jan 2010 20:16:15 +0000
Message-ID: <20100105201615.GJ14376__27591.1506069408$1262722710$gmane$org@shareable.org>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<20100104083035.GA7461@lst.de>
	<201001052326.33216.rusty@rustcorp.com.au>
	<4B433783.6090400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B433783.6090400@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> On 01/05/2010 02:56 PM, Rusty Russell wrote:
> >
> >>Those should be the same for any sane interface.  They are for classical
> >>disk devices with larger block sizes (MO, s390 dasd) and also for the
> >>now appearing 4k sector scsi disks.  But in the ide world people are
> >>concerned about dos/window legacy compatiblity so they came up with a
> >>nasty hack:
> >>
> >>  - there is a physical block size as used by the disk internally
> >>    (4k initially)
> >>  - all the interfaces to the operating system still happen in the
> >>    traditional 512 byte blocks to not break any existing assumptions
> >>  - to make sure modern operating systems can optimize for the larger
> >>    physical sectors the disks expose this size, too.
> >>  - even worse disks can also have alignment hacks for the traditional
> >>    DOS partitions tables, so that the 512 byte block zero might even
> >>    have an offset into the first larger physical block.  This is also
> >>    exposed in the ATA identify information.
> >>
> >>All in all I don't think this mess is a good idea to replicate in
> >>virtio.  Virtio by defintion requires virtualization aware guests, so we
> >>should just follow the SCSI way of larger real block sizes here.
> >>     
> >Yes.  The current VIRTIO_BLK_F_BLK_SIZE says "please use this block size".
> >We haven't actually specified what happens if the guest doesn't, but the
> >spec says "must", and the Linux implementation does so AFAICT.
> >
> >If we want a "soft" size, we could add that as a separate feature.
> >   
> 
> No - I agree with Christoph, there's no reason to use a 512/4096 
> monstrosity with virtio.

It would be good if virtio relayed the backing device's basic topology
hints, so:

    - If the backing dev is a real disk with 512-byte sectors,
      virtio should indicate 512-byte blocks to the guest.

    - If the backing dev is a real disk with 4096-byte sectors,
      virtio should indicate 4096-byte blocks to the guest.

With databases and filesystems, if you care about data integrity:

    - If the backing dev is a real disk with 4096-byte sectors,
      or a file whose access is through a 4096-byte-per-page cache,
      virtio must indicate 4096-byte blocks otherwise guest
      journalling is not host-powerfail safe.

You get the idea.  If there is only one parameter, it really should be
at least as large as the smallest unit which may be corrupted by
writes when errors occur.

-- Jamie
