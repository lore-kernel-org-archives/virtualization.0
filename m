From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v6 6/6] xfs: disable map_sync for async flush
Date: Wed, 24 Apr 2019 00:55:40 -0400 (EDT)
Message-ID: <476344290.23160847.1556081740211.JavaMail.zimbra__8853.35952495865$1556081756$gmane$org@redhat.com>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-7-pagupta@redhat.com>
	<20190423220217.GA29573@dread.disaster.area>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190423220217.GA29573@dread.disaster.area>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Chinner <david@fromorbit.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammed
List-Id: virtualization@lists.linuxfoundation.org


> 
> On Tue, Apr 23, 2019 at 01:36:12PM +0530, Pankaj Gupta wrote:
> > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > with asynchronous dax_device. Virtio pmem provides
> > asynchronous host page cache flush mechanism. We don't
> > support 'MAP_SYNC' with virtio pmem and xfs.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 1f2e2845eb76..0e59be018511 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1196,11 +1196,13 @@ xfs_file_mmap(
> >  	struct file	*filp,
> >  	struct vm_area_struct *vma)
> >  {
> > -	/*
> > -	 * We don't support synchronous mappings for non-DAX files. At least
> > -	 * until someone comes with a sensible use case.
> > +	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
> > +						(file_inode(filp));
> > +
> > +	/* We don't support synchronous mappings for non-DAX files and
> > +	 * for DAX files if underneath dax_device is not synchronous.
> >  	 */
> 
> 	/*
> 	 * This is the correct multi-line comment format. Please
> 	 * update the patch to maintain the existing comment format.
> 	 */

Sure. Will correct this for both xfs & ext4.

Thanks,
Pankaj

> 
> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
> 
