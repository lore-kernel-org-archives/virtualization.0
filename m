From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] drm/virtio: implement prime mmap
Date: Wed, 27 Feb 2019 15:44:39 +0100
Message-ID: <20190227144441.6755-2-kraxel__32538.7546721444$1551279283$gmane$org@redhat.com>
References: <20190227144441.6755-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190227144441.6755-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Sync gem vm_node.start with ttm vm_node.start,
then we can just call drm_gem_prime_mmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index c59ec34c80a5..b4c9199349e7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -56,7 +56,10 @@ void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 }
 
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
-		       struct vm_area_struct *area)
+			   struct vm_area_struct *vma)
 {
-	return -ENODEV;
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+
+	bo->gem_base.vma_node.vm_node.start = bo->tbo.vma_node.vm_node.start;
+	return drm_gem_prime_mmap(obj, vma);
 }
-- 
2.9.3
