From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/6] xfs: disable map_sync for async flush
Date: Wed, 8 May 2019 01:49:04 -0400 (EDT)
Message-ID: <7976014.27184867.1557294544901.JavaMail.zimbra__37263.5097870202$1557294559$gmane$org@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-7-pagupta@redhat.com>
	<CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
	<20190507161736.GV5207@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190507161736.GV5207@magnolia>
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
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, kilobyte@angband.pl, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, lcapitul
List-Id: virtualization@lists.linuxfoundation.org


> 
> On Tue, May 07, 2019 at 08:37:01AM -0700, Dan Williams wrote:
> > On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > >
> > > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > > with asynchronous dax_device. Virtio pmem provides
> > > asynchronous host page cache flush mechanism. We don't
> > > support 'MAP_SYNC' with virtio pmem and xfs.
> > >
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > Darrick, does this look ok to take through the nvdimm tree?
> 
> <urk> forgot about this, sorry. :/
> 
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index a7ceae90110e..f17652cca5ff 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1203,11 +1203,14 @@ xfs_file_mmap(
> > >         struct file     *filp,
> > >         struct vm_area_struct *vma)
> > >  {
> > > +       struct dax_device       *dax_dev;
> > > +
> > > +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
> > >         /*
> > > -        * We don't support synchronous mappings for non-DAX files. At
> > > least
> > > -        * until someone comes with a sensible use case.
> > > +        * We don't support synchronous mappings for non-DAX files and
> > > +        * for DAX files if underneath dax_device is not synchronous.
> > >          */
> > > -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > > +       if (!daxdev_mapping_supported(vma, dax_dev))
> > >                 return -EOPNOTSUPP;
> 
> LGTM, and I'm fine with it going through nvdimm.  Nothing in
> xfs-5.2-merge touches that function so it should be clean.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thank you for the review.

Pankaj

> 
> --D
> 
> > >
> > >         file_accessed(filp);
> > > --
> > > 2.20.1
> > >
> 
> 
