From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] virtio_balloon: refill by config handler
Date: Fri, 1 Jan 2016 12:13:48 +0200
Message-ID: <1451643122-21561-1-git-send-email-mst@redhat.com>
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
Cc: Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>, Jeff Epler <jepler@unpythonic.net>, Jiri Kosina <jkosina@suse.cz>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Peter Mladek reported that balloon might never refill completely after
restore.  This is because fill_balloon is only called once there.
Calling fill_balloon repeatedly seems too aggressive,
especially in light of the fact that it sleeps on failure: let's
wake the config change handler and fill it asynchronously.

Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I was unable to test this - for some reason my test VM
doesn't resume (with or without the patch).
Petr, does this work for you?

 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7efc329..ee29473 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -589,7 +589,7 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	fill_balloon(vb, towards_target(vb));
+	wake_up(&vb->config_change);
 	update_balloon_size(vb);
 	return 0;
 }
-- 
MST
