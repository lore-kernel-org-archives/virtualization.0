From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] virtio: balloon: drop restore_common()
Date: Fri, 27 Apr 2012 00:45:55 +0530
Message-ID: <c4adb90765b1de563169ed6168bf700f83652392.1335467427.git.amit.shah@redhat.com>
References: <cover.1335467427.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1335467427.git.amit.shah@redhat.com>
In-Reply-To: <cover.1335467427.git.amit.shah@redhat.com>
References: <cover.1335467427.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

restore_common() was used when there were different thaw and freeze PM
callbacks implemented.  We removed thaw in commit
f38f8387cbdc4138a492ce9f2a5f04fd3cd3cf33.

restore_common() can be removed and virtballoon_restore() can itself do
the restore ops.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_balloon.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c2d05a8..6921326 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -418,7 +418,7 @@ static int virtballoon_freeze(struct virtio_device *vdev)
 	return 0;
 }
 
-static int restore_common(struct virtio_device *vdev)
+static int virtballoon_restore(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 	int ret;
@@ -431,11 +431,6 @@ static int restore_common(struct virtio_device *vdev)
 	update_balloon_size(vb);
 	return 0;
 }
-
-static int virtballoon_restore(struct virtio_device *vdev)
-{
-	return restore_common(vdev);
-}
 #endif
 
 static unsigned int features[] = {
-- 
1.7.7.6
