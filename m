From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 2/2] drm/virtio: Handle buffers from the compositor
Date: Fri, 26 Jan 2018 14:58:02 +0100
Message-ID: <20180126135803.29781-3-tomeu.vizoso@collabora.com>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

When retrieving queued messages from the compositor in the host for
clients in the guest, handle buffers that may be passed.

These buffers should have been mapped to the guest's address space, for
example via the KVM_SET_USER_MEMORY_REGION ioctl.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d4230b1fa91d..57b1ad51d251 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -545,14 +545,58 @@ static unsigned int winsrv_poll(struct file *filp,
 	return mask;
 }
 
+struct virtio_gpu_winsrv_region {
+	uint64_t pfn;
+	size_t size;
+};
+
+static int winsrv_fd_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct virtio_gpu_winsrv_region *region = filp->private_data;
+	unsigned long vm_size = vma->vm_end - vma->vm_start;
+	int ret = 0;
+
+	if (vm_size +
+	    (vma->vm_pgoff << PAGE_SHIFT) > PAGE_ALIGN(region->size))
+		return -EINVAL;
+
+	ret = io_remap_pfn_range(vma, vma->vm_start, region->pfn, vm_size,
+				 vma->vm_page_prot);
+	if (ret)
+		return ret;
+
+	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+
+	return ret;
+}
+
+static int winsrv_fd_release(struct inode *inodep, struct file *filp)
+{
+	struct virtio_gpu_winsrv_region *region = filp->private_data;
+
+	kfree(region);
+
+	return 0;
+}
+
+static const struct file_operations winsrv_fd_fops = {
+	.mmap = winsrv_fd_mmap,
+	.release = winsrv_fd_release,
+};
+
 static int winsrv_ioctl_rx(struct virtio_gpu_device *vgdev,
 			   struct virtio_gpu_winsrv_conn *conn,
 			   struct drm_virtgpu_winsrv *cmd)
 {
 	struct virtio_gpu_winsrv_rx_qentry *qentry, *tmp;
 	struct virtio_gpu_winsrv_rx *virtio_cmd;
+	struct virtio_gpu_winsrv_region *region;
 	int available_len = cmd->len;
 	int read_count = 0;
+	int i;
+
+	for (i = 0; i < VIRTGPU_WINSRV_MAX_ALLOCS; i++)
+		cmd->fds[i] = -1;
 
 	list_for_each_entry_safe(qentry, tmp, &conn->cmdq, next) {
 		virtio_cmd = qentry->cmd;
@@ -567,6 +611,16 @@ static int winsrv_ioctl_rx(struct virtio_gpu_device *vgdev,
 				return -EFAULT;
 		}
 
+		for (i = 0; virtio_cmd->pfns[i]; i++) {
+			region = kmalloc(sizeof(*region), GFP_KERNEL);
+			region->pfn = virtio_cmd->pfns[i];
+			region->size = virtio_cmd->lens[i];
+			cmd->fds[i] = anon_inode_getfd("[winsrv_fd]",
+						       &winsrv_fd_fops,
+						       region,
+						       O_CLOEXEC | O_RDWR);
+		}
+
 		available_len -= virtio_cmd->len;
 		read_count += virtio_cmd->len;
 
-- 
2.14.3
