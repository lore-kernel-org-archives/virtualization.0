From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 4 May 2010 21:17:05 +0100
Message-ID: <20100504201705.GA4360__27772.5764936351$1273004425$gmane$org@shareable.org>
References: <20100218222220.GA14847@redhat.com>
	<201005041408.25069.rusty@rustcorp.com.au>
	<20100504084133.GH27497@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100504084133.GH27497@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <qemu@kernel.dk>
Cc: tytso@mit.edu, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Neil Brown <neilb@suse.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Jens Axboe wrote:
> On Tue, May 04 2010, Rusty Russell wrote:
> > ISTR someone mentioning a desire for such an API years ago, so CC'ing the
> > usual I/O suspects...
> 
> It would be nice to have a more fuller API for this, but the reality is
> that only the flush approach is really workable. Even just strict
> ordering of requests could only be supported on SCSI, and even there the
> kernel still lacks proper guarantees on error handling to prevent
> reordering there.

There's a few I/O scheduling differences that might be useful:

1. The I/O scheduler could freely move WRITEs before a FLUSH but not
   before a BARRIER.  That might be useful for time-critical WRITEs,
   and those issued by high I/O priority.

2. The I/O scheduler could move WRITEs after a FLUSH if the FLUSH is
   only for data belonging to a particular file (e.g. fdatasync with
   no file size change, even on btrfs if O_DIRECT was used for the
   writes being committed).  That would entail tagging FLUSHes and
   WRITEs with a fs-specific identifier (such as inode number), opaque
   to the scheduler which only checks equality.

3. By delaying FLUSHes through reordering as above, the I/O scheduler
   could merge multiple FLUSHes into a single command.

4. On MD/RAID, BARRIER requires every backing device to quiesce before
   sending the low-level cache-flush, and all of those to finish
   before resuming each backing device.  FLUSH doesn't require as much
   synchronising.  (With per-file FLUSH; see 2; it could even avoid
   FLUSH altogether to some backing devices for small files).

In other words, FLUSH can be more relaxed than BARRIER inside the
kernel.  It's ironic that we think of fsync as stronger than
fbarrier outside the kernel :-)

-- Jamie
