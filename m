From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
Date: Tue, 15 Jan 2019 08:25:01 +1100
Message-ID: <20190114212501.GG4205__39268.5011880987$1547693579$gmane$org@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
	<1326478078.61913951.1547192704870.JavaMail.zimbra@redhat.com>
	<20190113232902.GD4205@dastard>
	<20190113233820.GX6310@bombadil.infradead.org>
	<942065073.64011540.1547450140670.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <942065073.64011540.1547450140670.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@ml01.01.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, eblake@redhat.com, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, mst@redhat.com, Matthew Wilcox <willy@infradead.org>, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, riel@surriel.com, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 02:15:40AM -0500, Pankaj Gupta wrote:
> 
> > > Until you have images (and hence host page cache) shared between
> > > multiple guests. People will want to do this, because it means they
> > > only need a single set of pages in host memory for executable
> > > binaries rather than a set of pages per guest. Then you have
> > > multiple guests being able to detect residency of the same set of
> > > pages. If the guests can then, in any way, control eviction of the
> > > pages from the host cache, then we have a guest-to-guest information
> > > leak channel.
> > 
> > I don't think we should ever be considering something that would allow a
> > guest to evict page's from the host's pagecache [1].  The guest should
> > be able to kick its own references to the host's pagecache out of its
> > own pagecache, but not be able to influence whether the host or another
> > guest has a read-only mapping cached.
> > 
> > [1] Unless the guest is allowed to modify the host's file; obviously
> > truncation, holepunching, etc are going to evict pages from the host's
> > page cache.
> 
> This is so correct. Guest does not not evict host page cache pages directly. 

They don't right now.

But someone is going to end up asking for discard to work so that
the guest can free unused space in the underlying spares image (i.e.
make use of fstrim or mount -o discard) because they have workloads
that have bursts of space usage and they need to trim the image
files afterwards to keep their overall space usage under control.

And then....

> In case of virtio-pmem & DAX, guest clears guest page cache exceptional entries.
> Its solely decision of host to take action on the host page cache pages.
> 
> In case of virtio-pmem, guest does not modify host file directly i.e don't
> perform hole punch & truncation operation directly on host file.  

... this will no longer be true, and the nuclear landmine in this
driver interface will have been armed....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
