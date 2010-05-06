From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Thu, 6 May 2010 16:25:02 +0100
Message-ID: <20100506152502.GB28512__15706.9010580473$1273159905$gmane$org@shareable.org>
References: <20100218222220.GA14847@redhat.com>
	<20100504084133.GH27497@kernel.dk>
	<20100504201705.GA4360@shareable.org>
	<201005051428.41735.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Jens Axboe <qemu@kernel.dk>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
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

We do want flushes for the "D" in ACID - such things as after
receiving a mail, or blog update into a database file (could be TDB),
and confirming that to the sender, to have high confidence that the
update won't disappear on system crash or power failure.

Less obviously, it's also needed for the "C" in ACID when more than
one file is involved.  "C" is about differently updated things staying
consistent with each other.

For example, imagine you have a TDB file mapping Samba usernames to
passwords, and another mapping Samba usernames to local usernames.  (I
don't know if you do this; it's just an illustration).

To rename a Samba user involves updating both.  Let's ignore transient
transactional issues :-) and just think about what happens with
per-file barriers and no sync, when a crash happens long after the
updates, and before the system has written out all data and issued low
level cache flushes.

After restarting, due to lack of sync, the Samba username could be
present in one file and not the other.

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

I agree, and I've started a few threads about it over the last couple of years.

An fsync_range() system call would be very easy to use and
(most importantly) easy to understand.

With optional flags to weaken it (into fdatasync, barrier without sync,
sync without barrier, one-sided barrier, no lowlevel cache-flush, don't rush,
etc.), it would be very versatile, and still easy to understand.

With an AIO version, and another flag meaning don't rush, just return
when satisfied, and I suspect it would be useful for the most
demanding I/O apps.

-- Jamie
