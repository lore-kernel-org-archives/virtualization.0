From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Wed, 5 May 2010 14:28:41 +0930
Message-ID: <201005051428.41735.rusty__7969.15612086213$1273035573$gmane$org@rustcorp.com.au>
References: <20100218222220.GA14847@redhat.com>
	<20100504084133.GH27497@kernel.dk>
	<20100504201705.GA4360@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504201705.GA4360@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Jens Axboe <qemu@kernel.dk>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 5 May 2010 05:47:05 am Jamie Lokier wrote:
> Jens Axboe wrote:
> > On Tue, May 04 2010, Rusty Russell wrote:
> > > ISTR someone mentioning a desire for such an API years ago, so CC'ing the
> > > usual I/O suspects...
> > 
> > It would be nice to have a more fuller API for this, but the reality is
> > that only the flush approach is really workable. Even just strict
> > ordering of requests could only be supported on SCSI, and even there the
> > kernel still lacks proper guarantees on error handling to prevent
> > reordering there.
> 
> There's a few I/O scheduling differences that might be useful:
> 
> 1. The I/O scheduler could freely move WRITEs before a FLUSH but not
>    before a BARRIER.  That might be useful for time-critical WRITEs,
>    and those issued by high I/O priority.

This is only because noone actually wants flushes or barriers, though
I/O people seem to only offer that.  We really want "<these writes> must
occur before <this write>".  That offers maximum choice to the I/O subsystem
and potentially to smart (virtual?) disks.

> 2. The I/O scheduler could move WRITEs after a FLUSH if the FLUSH is
>    only for data belonging to a particular file (e.g. fdatasync with
>    no file size change, even on btrfs if O_DIRECT was used for the
>    writes being committed).  That would entail tagging FLUSHes and
>    WRITEs with a fs-specific identifier (such as inode number), opaque
>    to the scheduler which only checks equality.

This is closer.  In userspace I'd be happy with a "all prior writes to this
struct file before all future writes".  Even if the original guarantees were
stronger (ie. inode basis).  We currently implement transactions using 4 fsync
/msync pairs.

	write_recovery_data(fd);
	fsync(fd);
	msync(mmap);
	write_recovery_header(fd);
	fsync(fd);
	msync(mmap);
	overwrite_with_new_data(fd);
	fsync(fd);
	msync(mmap);
	remove_recovery_header(fd);
	fsync(fd);
	msync(mmap);

Yet we really only need ordering, not guarantees about it actually hitting
disk before returning.

> In other words, FLUSH can be more relaxed than BARRIER inside the
> kernel.  It's ironic that we think of fsync as stronger than
> fbarrier outside the kernel :-)

It's an implementation detail; barrier has less flexibility because it has
less information about what is required. I'm saying I want to give you as
much information as I can, even if you don't use it yet.

Thanks,
Rusty.
