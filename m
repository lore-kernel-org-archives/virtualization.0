From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm/virtio: implement prime pin/unpin
Date: Wed, 27 Feb 2019 15:44:40 +0100
Message-ID: <20190227144441.6755-3-kraxel__20561.8344874651$1551279250$gmane$org@redhat.com>
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

virtio-gpu objects never move around, so effectively they are pinned
all the time.  This makes the the implementation pretty easy ;)

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index b4c9199349e7..0fcae0e46abd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -30,13 +30,13 @@
 
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
-	return -ENODEV;
+	/* nothing: all virtio-gpu objects are pinned all the time */
+	return 0;
 }
 
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
+	/* nothing */
 }
 
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
-- 
2.9.3
