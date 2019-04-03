From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 4/5] ext4: disable map_sync for async flush
Date: Wed, 3 Apr 2019 13:30:49 +0200
Message-ID: <20190403113049.GF8836__31660.0227773719$1554291071$gmane$org@quack2.suse.cz>
References: <20190403104018.23947-1-pagupta@redhat.com>
	<20190403104018.23947-5-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190403104018.23947-5-pagupta@redhat.com>
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com, linux-nvdimm@lists.01.org, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, riel@surriel.com, stefanha@redhat.com, dan.j.williams@intel.com, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com, darrick.wong@oracle.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed 03-04-19 16:10:17, Pankaj Gupta wrote:
> Virtio pmem provides asynchronous host page cache flush
> mechanism. We don't support 'MAP_SYNC' with virtio pmem 
> and ext4. 
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 69d65d49837b..86e4bf464320 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -360,8 +360,10 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
>  static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file->f_mapping->host;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct dax_device *dax_dev = sbi->s_daxdev;
>  
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> +	if (unlikely(ext4_forced_shutdown(sbi)))
>  		return -EIO;
>  
>  	/*
> @@ -371,6 +373,13 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
> +	/* We don't support synchronous mappings with DAX files if
> +	 * dax_device is not synchronous.
> +	 */
> +	if (IS_DAX(file_inode(file)) && !dax_synchronous(dax_dev)
> +						&& (vma->vm_flags & VM_SYNC))
> +		return -EOPNOTSUPP;
> +
>  	file_accessed(file);
>  	if (IS_DAX(file_inode(file))) {
>  		vma->vm_ops = &ext4_dax_vm_ops;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
