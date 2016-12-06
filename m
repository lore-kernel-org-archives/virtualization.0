From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 03/10] drm/virtio: fix lock context imbalance
Date: Tue, 6 Dec 2016 17:40:42 +0200
Message-ID: <1481038106-24899-4-git-send-email-mst__46647.1320404255$1481038872$gmane$org@redhat.com>
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

When virtio_gpu_free_vbufs exits due to list empty, it does not
drop the free_vbufs lock that it took.
list empty is not expected to happen anyway, but it can't hurt to fix
this and drop the lock.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5a0f8a7..2f0c2f9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -109,8 +109,10 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
 
 	spin_lock(&vgdev->free_vbufs_lock);
 	for (i = 0; i < count; i++) {
-		if (WARN_ON(list_empty(&vgdev->free_vbufs)))
+		if (WARN_ON(list_empty(&vgdev->free_vbufs))) {
+			spin_unlock(&vgdev->free_vbufs_lock);
 			return;
+		}
 		vbuf = list_first_entry(&vgdev->free_vbufs,
 					struct virtio_gpu_vbuffer, list);
 		list_del(&vbuf->list);
-- 
MST
