From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: [PATCH v2] virtio-blk physical block size
Date: Tue, 5 Jan 2010 23:26:32 +1030
Message-ID: <201001052326.33216.rusty__27030.9860738509$1262696271$gmane$org@rustcorp.com.au>
References: <1262018363-15871-1-git-send-email-avi@redhat.com>
	<201001041338.52621.rusty@rustcorp.com.au>
	<20100104083035.GA7461@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100104083035.GA7461@lst.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 4 Jan 2010 07:00:35 pm Christoph Hellwig wrote:
> On Mon, Jan 04, 2010 at 01:38:51PM +1030, Rusty Russell wrote:
> > I thought this was what I was doing, but I have shown over and over that
> > I have no idea about block devices.
> > 
> > Our current driver treats BLK_SIZE as the logical and physical size (see
> > blk_queue_logical_block_size).
> > 
> > I have no idea what "logical" vs. "physical" actually means.  Anyone?  Most
> > importantly, is it some Linux-internal difference or a real I/O-visible
> > distinction?
> 
> Those should be the same for any sane interface.  They are for classical
> disk devices with larger block sizes (MO, s390 dasd) and also for the
> now appearing 4k sector scsi disks.  But in the ide world people are
> concerned about dos/window legacy compatiblity so they came up with a
> nasty hack:
> 
>  - there is a physical block size as used by the disk internally
>    (4k initially)
>  - all the interfaces to the operating system still happen in the
>    traditional 512 byte blocks to not break any existing assumptions
>  - to make sure modern operating systems can optimize for the larger
>    physical sectors the disks expose this size, too.
>  - even worse disks can also have alignment hacks for the traditional
>    DOS partitions tables, so that the 512 byte block zero might even
>    have an offset into the first larger physical block.  This is also
>    exposed in the ATA identify information.
> 
> All in all I don't think this mess is a good idea to replicate in
> virtio.  Virtio by defintion requires virtualization aware guests, so we
> should just follow the SCSI way of larger real block sizes here.

Yes.  The current VIRTIO_BLK_F_BLK_SIZE says "please use this block size".
We haven't actually specified what happens if the guest doesn't, but the
spec says "must", and the Linux implementation does so AFAICT.

If we want a "soft" size, we could add that as a separate feature.

Cheers,
Rusty.
