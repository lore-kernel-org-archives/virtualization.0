From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/6] virtio: console: Separate out get_config in a separate
	function
Date: Fri, 19 Mar 2010 17:36:46 +0530
Message-ID: <1269000408-29962-5-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-4-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Getting config information is done in probe() as well as
config_work_handler().

Separate it out so that we only code it once.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   85 +++++++++++++++++++++++------------------
 1 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index dc15c92..9f2cbf0 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1227,6 +1227,46 @@ static u32 get_ports_map_size(u32 max_nr_ports)
 	return sizeof(u32) * ((max_nr_ports + 31)/ 32);
 }
 
+static struct virtio_console_config *get_config(struct virtio_device *vdev,
+						bool multiport)
+{
+	struct virtio_console_config *config;
+	u32 max_nr_ports;
+
+	if (!multiport) {
+		config = kmalloc(sizeof(struct virtio_console_config),
+				 GFP_KERNEL);
+		if (!config)
+			return NULL;
+
+		config->max_nr_ports = 1;
+		return config;
+	}
+
+	vdev->config->get(vdev, offsetof(struct virtio_console_config,
+					 max_nr_ports),
+			  &max_nr_ports, sizeof(max_nr_ports));
+
+	/*
+	 * We have a variable-sized config space that's dependent on
+	 * the maximum number of ports a guest can have.  So we first
+	 * get the max number of ports we can have and then allocate
+	 * the config space
+	 */
+	config = kmalloc(sizeof(struct virtio_console_config)
+			 + get_ports_map_size(max_nr_ports),
+			 GFP_KERNEL);
+	if (!config)
+		return NULL;
+
+	config->max_nr_ports = max_nr_ports;
+	vdev->config->get(vdev, offsetof(struct virtio_console_config,
+					 ports_map),
+			  config->ports_map,
+			  get_ports_map_size(max_nr_ports));
+	return config;
+}
+
 /*
  * The workhandler for config-space updates.
  *
@@ -1394,49 +1434,20 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		goto free;
 	}
 
+	multiport = false;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
-		u32 max_nr_ports;
-
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 max_nr_ports),
-				  &max_nr_ports, sizeof(max_nr_ports));
-		/*
-		 * We have a variable-sized config space that's
-		 * dependent on the maximum number of ports a guest
-		 * can have.  So we first get the max number of ports
-		 * we can have and then allocate the config space
-		 */
-		portdev->config = kmalloc(sizeof(struct virtio_console_config)
-					  + get_ports_map_size(max_nr_ports),
-					  GFP_KERNEL);
-		if (!portdev->config) {
-			err = -ENOMEM;
-			goto free_chrdev;
-		}
-
-		portdev->config->max_nr_ports = max_nr_ports;
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 ports_map),
-				  portdev->config->ports_map,
-				  get_ports_map_size(max_nr_ports));
-	} else {
-		multiport = false;
-
-		portdev->config = kmalloc(sizeof(struct virtio_console_config),
-					  GFP_KERNEL);
-		if (!portdev->config) {
-			err = -ENOMEM;
-			goto free_chrdev;
-		}
-
-		portdev->config->max_nr_ports = 1;
+		/* Let the Host know we support multiple ports.*/
+		vdev->config->finalize_features(vdev);
 	}
 
-	/* Let the Host know we support multiple ports.*/
-	vdev->config->finalize_features(vdev);
+	portdev->config = get_config(vdev, multiport);
+	if (!portdev->config) {
+		err = -ENOMEM;
+		goto free_chrdev;
+	}
 
 	err = init_vqs(portdev);
 	if (err < 0) {
-- 
1.6.2.5
