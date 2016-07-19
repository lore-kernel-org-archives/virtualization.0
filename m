From: Wei Yongjun <weiyj_lk@163.com>
Subject: [PATCH -next] drm/virtio: Fix non static symbol warning
Date: Tue, 19 Jul 2016 12:45:56 +0000
Message-ID: <1468932356-26678-1-git-send-email-weiyj_lk__49913.8381834657$1469306734$gmane$org@163.com>
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
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

drivers/gpu/drm/virtio/virtgpu_display.c:349:37: warning:
  symbol 'virtio_mode_config_helpers' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index fdfc711..4e192aa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -346,7 +346,7 @@ static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
 
-struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
+static struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
 	.atomic_commit_tail = vgdev_atomic_commit_tail,
 };
