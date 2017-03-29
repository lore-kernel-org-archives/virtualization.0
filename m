From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_console: fix uninitialized variable use
Date: Wed, 29 Mar 2017 23:27:16 +0300
Message-ID: <1490819164-7648-1-git-send-email-mst@redhat.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Galbraith <efault@gmx.de>, virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

We try to disable callbacks on c_ivq even without multiport
even though that vq is not initialized in this configuration.

Fixes: c743d09dbd01 ("virtio: console: Disable callbacks for virtqueues at start of S4 freeze")
Suggested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Hi Mike
	if you like, pls send me your Signed-off-by and I'll
	change the patch to make you an author.
	More importantly, pls let me know whether this helps
	resolve the issues about hybernation for you!

 drivers/char/virtio_console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5da4c8e..d0699c5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2202,14 +2202,16 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	vdev->config->reset(vdev);
 
-	virtqueue_disable_cb(portdev->c_ivq);
+	if (use_multiport(portdev))
+		virtqueue_disable_cb(portdev->c_ivq);
 	cancel_work_sync(&portdev->control_work);
 	cancel_work_sync(&portdev->config_work);
 	/*
 	 * Once more: if control_work_handler() was running, it would
 	 * enable the cb as the last step.
 	 */
-	virtqueue_disable_cb(portdev->c_ivq);
+	if (use_multiport(portdev))
+		virtqueue_disable_cb(portdev->c_ivq);
 	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
-- 
MST
