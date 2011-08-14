From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH 1/3] virtio-console: Use virtio_config_val() for retrieving
	config
Date: Sun, 14 Aug 2011 17:52:31 +0300
Message-ID: <1313333553-23086-1-git-send-email-levinsasha928__30856.0501355261$1313345721$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch modifies virtio-console to use virtio_config_val() instead
of a 'if(virtio_has_feature()) vdev->config->get()' construct to retrieve
optional values from the config space.

Cc: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/char/virtio_console.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fb68b12..ed99f3b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1675,13 +1675,11 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	multiport = false;
 	portdev->config.max_nr_ports = 1;
-	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+	if (virtio_config_val(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+			      offsetof(struct virtio_console_config,
+				       max_nr_ports),
+			      &portdev->config.max_nr_ports) == 0)
 		multiport = true;
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 max_nr_ports),
-				  &portdev->config.max_nr_ports,
-				  sizeof(portdev->config.max_nr_ports));
-	}
 
 	err = init_vqs(portdev);
 	if (err < 0) {
-- 
1.7.6
