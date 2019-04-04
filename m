From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v4 5/5] xfs: disable map_sync for async flush
Date: Thu, 4 Apr 2019 02:13:38 -0400 (EDT)
Message-ID: <1508883801.17367965.1554358418550.JavaMail.zimbra__17644.5044622355$1554358432$gmane$org@redhat.com>
References: <20190403104018.23947-1-pagupta@redhat.com>
	<20190403104018.23947-6-pagupta@redhat.com>
	<20190403220912.GB26298@dastard> <20190403223921.GM5147@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190403223921.GM5147@magnolia>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, Dave Chinner <david@fromorbit.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, riel@surriel.com, stefanha@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


> 
> On Thu, Apr 04, 2019 at 09:09:12AM +1100, Dave Chinner wrote:
> > On Wed, Apr 03, 2019 at 04:10:18PM +0530, Pankaj Gupta wrote:
> > > Virtio pmem provides asynchronous host page cache flush
> > > mechanism. we don't support 'MAP_SYNC' with virtio pmem
> > > and xfs.
> > > 
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 1f2e2845eb76..dced2eb8c91a 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1203,6 +1203,14 @@ xfs_file_mmap(
> > >  	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > >  		return -EOPNOTSUPP;
> > >  
> > > +	/* We don't support synchronous mappings with DAX files if
> > > +	 * dax_device is not synchronous.
> > > +	 */
> > > +	if (IS_DAX(file_inode(filp)) && !dax_synchronous(
> > > +		xfs_find_daxdev_for_inode(file_inode(filp))) &&
> > > +					(vma->vm_flags & VM_SYNC))
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	file_accessed(filp);
> > >  	vma->vm_ops = &xfs_file_vm_ops;
> > >  	if (IS_DAX(file_inode(filp)))
> > 
> > All this ad hoc IS_DAX conditional logic is getting pretty nasty.
> > 
> > xfs_file_mmap(
> > ....
> > {
> > 	struct inode	*inode = file_inode(filp);
> > 
> > 	if (vma->vm_flags & VM_SYNC) {
> > 		if (!IS_DAX(inode))
> > 			return -EOPNOTSUPP;
> > 		if (!dax_synchronous(xfs_find_daxdev_for_inode(inode))
> > 			return -EOPNOTSUPP;
> > 	}
> > 
> > 	file_accessed(filp);
> > 	vma->vm_ops = &xfs_file_vm_ops;
> > 	if (IS_DAX(inode))
> > 		vma->vm_flags |= VM_HUGEPAGE;
> > 	return 0;
> > }
> > 
> > 
> > Even better, factor out all the "MAP_SYNC supported" checks into a
> > helper so that the filesystem code just doesn't have to care about
> > the details of checking for DAX+MAP_SYNC support....
> 
> Seconded, since ext4 has nearly the same flag validation logic.

Agree.

Thanks,
Pankaj

> 
> --D
> 
> > 
> > Cheers,
> > 
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> 
