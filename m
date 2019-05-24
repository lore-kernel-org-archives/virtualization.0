From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/qxl: drop WARN_ONCE()
Date: Fri, 24 May 2019 12:42:50 +0200
Message-ID: <20190524104251.22761-1-kraxel__7504.34351373173$1558694584$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

There is no good reason to flood the kernel log with a WARN
stacktrace just because someone tried to mmap a prime buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_prime.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 114653b471c6..7d3816fca5a8 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -77,6 +77,5 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
 		       struct vm_area_struct *area)
 {
-	WARN_ONCE(1, "not implemented");
 	return -ENOSYS;
 }
-- 
2.18.1
