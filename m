From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/1] update balloon size in balloon "probe"
Date: Fri, 23 Sep 2016 16:47:57 +0300
Message-ID: <1474638477-8658-1-git-send-email-den@openvz.org>
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
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: den@openvz.org, Konstantin Neumoin <kneumoin@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Konstantin Neumoin <kneumoin@virtuozzo.com>

Patch
    Commit 3d2a3774c1b046f548ebea0391a602fd5685a307
    Author: Michael S. Tsirkin <mst@redhat.com>
    Date:   Tue Mar 10 11:55:08 2015 +1030
    virtio-balloon: do not call blocking ops when !TASK_RUNNING
has added a regression. Original code with wait_event_interruptible
checked the condition before start waiting and started balloon operations
if necessary.

Right now balloon is not inflated if ballon target is set before the
driver is loaded.

Signed-off-by: Konstantin Neumoin <kneumoin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e7003d..0a6c10f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -577,6 +577,10 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	if (towards_target(vb))
+		virtballoon_changed(vdev);
+	update_balloon_size(vb);
+
 	return 0;
 
 out_del_vqs:
-- 
2.7.4
