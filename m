From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_balloon: set DRIVER_OK before using device
Date: Wed, 4 Mar 2015 14:14:21 +0100
Message-ID: <1425474779-29412-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio spec requires that all drivers set DRIVER_OK
before using devices. While balloon isn't yet
included in the virtio 1 spec, previous spec versions
also required this.

virtio balloon might violate this rule: probe calls
kthread_run before setting DRIVER_OK, which might run
immediately and cause balloon to inflate/deflate.

To fix, call virtio_device_ready before running the kthread.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5a6ad6d..6a356e3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -508,6 +508,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (err < 0)
 		goto out_oom_notify;
 
+	virtio_device_ready(vdev);
+
 	vb->thread = kthread_run(balloon, vb, "vballoon");
 	if (IS_ERR(vb->thread)) {
 		err = PTR_ERR(vb->thread);
-- 
MST
