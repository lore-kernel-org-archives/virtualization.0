From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 1/1] virtio: update balloon size in balloon "probe"
Date: Thu, 29 Sep 2016 13:17:12 +0300
Message-ID: <1475144232-10579-1-git-send-email-den@openvz.org>
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
Cc: den@openvz.org, Konstantin Neumoin <kneumoin@virtuozzo.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Konstantin Neumoin <kneumoin@virtuozzo.com>

The following commit 'fad7b7b27b6a (virtio_balloon: Use a workqueue
instead of "vballoon" kthread)' has added a regression. Original code with
kthread starts the thread inside probe and checks the necessity to update
balloon inside the thread immediately.

Nowadays the code behaves differently. Work is queued only on the first
command from the host after the negotiation. Thus there is a window
especially at the guest startup or the module reloading when the balloon
size is not updated until the notification from the host.

This patch adds balloon size check at the end of the probe to match
original behaviour.

Signed-off-by: Konstantin Neumoin <kneumoin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

Changes from v1:
- fixed description
- removed update_balloon_size() call

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e7003d..181793f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -577,6 +577,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	if (towards_target(vb))
+		virtballoon_changed(vdev);
 	return 0;
 
 out_del_vqs:
-- 
2.7.4
