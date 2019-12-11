From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 3/4] drm/virtio: fix mmap page attributes
Date: Wed, 11 Dec 2019 13:19:55 +0100
Message-ID: <20191211121957.18637-4-kraxel__3859.11115897528$1576066822$gmane$org@redhat.com>
References: <20191211121957.18637-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191211121957.18637-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

virtio-gpu uses cached mappings, set virtio_gpu_gem_funcs.pgprot
accordingly.

Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 017a9e0fc3bb..0b754c5bbcce 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -87,6 +87,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
 	.mmap = &drm_gem_shmem_mmap,
+	.pgprot = &drm_gem_pgprot_cached,
 };
 
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
-- 
2.18.1
