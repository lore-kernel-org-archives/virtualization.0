From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm: virtio: fix kmem_cache_alloc error check
Date: Mon, 13 Mar 2017 09:22:26 +0100
Message-ID: <1489393346-13874-1-git-send-email-kraxel__23764.3693261363$1489393367$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

kmem_cache_alloc returns NULL on error, not ERR_PTR.

Fixes: f5985bf9cadd4e3ed8d5d9a9cbbb2e39cdb81cd9
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 472e349..9eb96fb2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -97,8 +97,8 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
 	struct virtio_gpu_vbuffer *vbuf;
 
 	vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
-	if (IS_ERR(vbuf))
-		return ERR_CAST(vbuf);
+	if (!vbuf)
+		return ERR_PTR(-ENOMEM);
 	memset(vbuf, 0, VBUFFER_SIZE);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE);
-- 
1.8.3.1
