From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v4 5/5] xfs: disable map_sync for async flush
Date: Wed,  3 Apr 2019 16:10:18 +0530
Message-ID: <20190403104018.23947-6-pagupta__26348.5501449153$1554288169$gmane$org@redhat.com>
References: <20190403104018.23947-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190403104018.23947-1-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: pagupta@redhat.com, jack@suse.cz, mst@redhat.com, david@fromorbit.com, lcapitulino@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com, darrick.wong@oracle.com, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com, lenb@kernel.org, riel@surriel.com, stefanha@redhat.com, dan.j.williams@intel.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Virtio pmem provides asynchronous host page cache flush
mechanism. we don't support 'MAP_SYNC' with virtio pmem 
and xfs.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1f2e2845eb76..dced2eb8c91a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1203,6 +1203,14 @@ xfs_file_mmap(
 	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
+	/* We don't support synchronous mappings with DAX files if
+	 * dax_device is not synchronous.
+	 */
+	if (IS_DAX(file_inode(filp)) && !dax_synchronous(
+		xfs_find_daxdev_for_inode(file_inode(filp))) &&
+					(vma->vm_flags & VM_SYNC))
+		return -EOPNOTSUPP;
+
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(file_inode(filp)))
-- 
2.20.1
