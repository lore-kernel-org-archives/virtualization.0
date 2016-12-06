From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 04/10] drm/virtio: annotate virtio_gpu_queue_ctrl_buffer_locked
Date: Tue, 6 Dec 2016 17:40:45 +0200
Message-ID: <1481038106-24899-5-git-send-email-mst__31196.221712935$1481038886$gmane$org@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481038106-24899-1-git-send-email-mst@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_gpu_queue_ctrl_buffer_locked is called with ctrlq.qlock taken, it
releases and acquires this lock.  This causes a sparse warning.  Add
appropriate annotations for sparse context checking.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 2f0c2f9..a6e2ce4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -297,6 +297,8 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 
 static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf)
+		__releases(&vgdev->ctrlq.qlock)
+		__acquires(&vgdev->ctrlq.qlock)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	struct scatterlist *sgs[3], vcmd, vout, vresp;
-- 
MST
