From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 4 May 2010 21:32:55 +0100
Message-ID: <20100504203255.GB4360__35318.6663509861$1273005321$gmane$org@shareable.org>
References: <20100218222220.GA14847@redhat.com>
	<201005041408.25069.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005041408.25069.rusty@rustcorp.com.au>
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
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Fri, 19 Feb 2010 08:52:20 am Michael S. Tsirkin wrote:
> > I took a stub at documenting CMD and FLUSH request types in virtio
> > block.  Christoph, could you look over this please?
> > 
> > I note that the interface seems full of warts to me,
> > this might be a first step to cleaning them.
> 
> ISTR Christoph had withdrawn some patches in this area, and was waiting
> for him to resubmit?
> 
> I've given up on figuring out the block device.  What seem to me to be sane
> semantics along the lines of memory barriers are foreign to disk people: they
> want (and depend on) flushing everywhere.
> 
> For example, tdb transactions do not require a flush, they only require what
> I would call a barrier: that prior data be written out before any future data.
> Surely that would be more efficient in general than a flush!  In fact, TDB
> wants only writes to *that file* (and metadata) written out first; it has no
> ordering issues with other I/O on the same device.

I've just posted elsewhere on this thread, that an I/O level flush can
be more efficient than an I/O level barrier (implemented using a
cache-flush really), because the barrier has stricter ordering
requirements at the I/O scheduling level.

By the time you work up to tdb, another way to think of it is
distinguishing "eager fsync" from "fsync but I'm not in a hurry -
delay as long as is convenient".  The latter makes much more sense
with AIO.

> A generic I/O interface would allow you to specify "this request
> depends on these outstanding requests" and leave it at that.  It
> might have some sync flush command for dumb applications and OSes.

For filesystems, it would probably be easy to label in-place
overwrites and fdatasync data flushes when there's no file extension
with an opqaue per-file identifier for certain operations.  Typically
over-writing in place and fdatasync would match up and wouldn't need
ordering against anything else.  Other operations would tend to get
labelled as ordered against everything including these.

-- Jamie
