From: Neil Brown <neilb@suse.de>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Wed, 5 May 2010 16:03:43 +1000
Message-ID: <20100505160343.264fd015__4192.31723431057$1273039511$gmane$org@notabene.brown>
References: <20100218222220.GA14847@redhat.com>
	<20100504084133.GH27497@kernel.dk>
	<20100504201705.GA4360@shareable.org>
	<201005051428.41735.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005051428.41735.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Jens Axboe <qemu@kernel.dk>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 5 May 2010 14:28:41 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Wed, 5 May 2010 05:47:05 am Jamie Lokier wrote:
> > Jens Axboe wrote:
> > > On Tue, May 04 2010, Rusty Russell wrote:
> > > > ISTR someone mentioning a desire for such an API years ago, so CC'ing the
> > > > usual I/O suspects...
> > > 
> > > It would be nice to have a more fuller API for this, but the reality is
> > > that only the flush approach is really workable. Even just strict
> > > ordering of requests could only be supported on SCSI, and even there the
> > > kernel still lacks proper guarantees on error handling to prevent
> > > reordering there.
> > 
> > There's a few I/O scheduling differences that might be useful:
> > 
> > 1. The I/O scheduler could freely move WRITEs before a FLUSH but not
> >    before a BARRIER.  That might be useful for time-critical WRITEs,
> >    and those issued by high I/O priority.
> 
> This is only because noone actually wants flushes or barriers, though
> I/O people seem to only offer that.  We really want "<these writes> must
> occur before <this write>".  That offers maximum choice to the I/O subsystem
> and potentially to smart (virtual?) disks.
> 
> > 2. The I/O scheduler could move WRITEs after a FLUSH if the FLUSH is
> >    only for data belonging to a particular file (e.g. fdatasync with
> >    no file size change, even on btrfs if O_DIRECT was used for the
> >    writes being committed).  That would entail tagging FLUSHes and
> >    WRITEs with a fs-specific identifier (such as inode number), opaque
> >    to the scheduler which only checks equality.
> 
> This is closer.  In userspace I'd be happy with a "all prior writes to this
> struct file before all future writes".  Even if the original guarantees were
> stronger (ie. inode basis).  We currently implement transactions using 4 fsync
> /msync pairs.
> 
> 	write_recovery_data(fd);
> 	fsync(fd);
> 	msync(mmap);
> 	write_recovery_header(fd);
> 	fsync(fd);
> 	msync(mmap);
> 	overwrite_with_new_data(fd);
> 	fsync(fd);
> 	msync(mmap);
> 	remove_recovery_header(fd);
> 	fsync(fd);
> 	msync(mmap);

Seems over-zealous.
If the recovery_header held a strong checksum of the recovery_data you would
not need the first fsync, and as long as you have two places to write recovery
data, you don't need the 3rd and 4th syncs.
Just:
  write_internally_checksummed_recovery_data_and_header_to_unused_log_space()
  fsync / msync
  overwrite_with_new_data()

To recovery you choose the most recent log_space and replay the content.
That may be a redundant operation, but that is no loss.

Also cannot see the point of msync if you have already performed an fsync,
and if there is a point, I would expect you to call msync before
fsync... Maybe there is some subtlety there that I am not aware of.

> 
> Yet we really only need ordering, not guarantees about it actually hitting
> disk before returning.
> 
> > In other words, FLUSH can be more relaxed than BARRIER inside the
> > kernel.  It's ironic that we think of fsync as stronger than
> > fbarrier outside the kernel :-)
> 
> It's an implementation detail; barrier has less flexibility because it has
> less information about what is required. I'm saying I want to give you as
> much information as I can, even if you don't use it yet.

Only we know that approach doesn't work.
People will learn that they don't need to give the extra information to still
achieve the same result - just like they did with ext3 and fsync.
Then when we improve the implementation to only provide the guarantees that
you asked for, people will complain that they are getting empty files that
they didn't expect.

The abstraction I would like to see is a simple 'barrier' that contains no
data and has a filesystem-wide effect.

If a filesystem wanted a 'full' barrier such as the current BIO_RW_BARRER,
it would send an empty barrier, then the data, then another empty barrier.
(However I suspect most filesystems don't really need barriers on both sides.)
A low level driver might merge these together if the underlying hardware
supported that combined operation (which I believe some do).
I think this merging would be less complex that the current need to split a
BIO_RW_BARRIER in to the three separate operations when only a flush is
possible (I know it would make md code a lot nicer :-).

I would probably expose this to user-space as extra flags to sync_file_range:
   SYNC_FILE_RANGE_BARRIER_BEFORE
   SYNC_FILE_RANGE_BARRIER_AFTER

This would make it clear that a barrier does *not* imply a sync, it only
applies to data for which a sync has already been requested. So data that has
already been 'synced' is stored strictly before data which has not yet been
submitted with write() (or by changing a mmapped area).
The barrier would still be filesystem wide in that if you
SYNC_FILE_WRITE_WRITE one file, then SYNC_FILE_RANGE_BARRIER_BEFORE another
file on the same filesystem, the pages scheduled in the first file would be
affect by the barrier request on the second file.

Implementing this would probably require a new address_space_operation so
that the filesystem would have a chance to ensure all necessary writes were
queued before issuing the barrier.


NeilBrown
