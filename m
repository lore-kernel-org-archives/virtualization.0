From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v3 5/5] xfs: disable map_sync for virtio pmem
Date: Wed, 9 Jan 2019 13:08:24 -0500 (EST)
Message-ID: <739751810.61274195.1547057304156.JavaMail.zimbra__33501.2114876465$1547057357$gmane$org@redhat.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190109144736.17452-6-pagupta@redhat.com>
	<20190109162654.GW12689@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109162654.GW12689@magnolia>
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
Cc: jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@ml01.01.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, eblake@redhat.com, dave jiang <dave.jiang@intel.com>, vishal l verma <vishal.l.verma@intel.com>, mst@redhat.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, linux-ext4@vger.kernel.org, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


> > Virtio pmem provides asynchronous host page cache flush
> > mechanism. we don't support 'MAP_SYNC' with virtio pmem
> > and xfs.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index e474250..eae4aa4 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1190,6 +1190,14 @@ xfs_file_mmap(
> >  	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> >  		return -EOPNOTSUPP;
> >  
> > +	/* We don't support synchronous mappings with guest direct access
> > +	 * and virtio based host page cache mechanism.
> > +	 */
> > +	if (IS_DAX(file_inode(filp)) && virtio_pmem_host_cache_enabled(
> 
> Echoing what Jan said, this ought to be some sort of generic function
> that tells us whether or not memory mapped from the dax device will
> always still be accessible even after a crash (i.e. supports MAP_SYNC).

o.k
> 
> What if the underlying file on the host is itself on pmem and can be
> MAP_SYNC'd?  Shouldn't the guest be able to use MAP_SYNC as well?

Guest MAP_SYNC on actual host pmem will sync guest metadata, as guest 
writes are persistent on actual pmem. Host side Qemu MAP_SYNC enabling
work for pmem is in progress. It will make sure metadata at host side
is in consistent state after a crash or any other metadata corruption 
operation.

For virtio-pmem, we are emulating pmem device over regular storage on
host side. Guest need to call fsync followed by write to make sure
guest metadata is in consistent state(or journalled). Host backing file
data & metadata will also be persistent after guest to host fsync.

Thanks,
Pankaj
