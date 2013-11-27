From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v3 RFC 1/4] virtio: add surprize_removal to virtio_device
Date: Wed, 27 Nov 2013 11:32:37 +0100
Message-ID: <1385548360-31943-2-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Add new entry surprize_removal to struct virtio_device.

When a virtio transport driver is notified about a lost device
it should set surprize_removal to true.

A backend driver can test this flag in order to perform specific
actions that might be appropriate wrt the device loss.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c | 1 +
 include/linux/virtio.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ee59b74..290d1e2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -115,6 +115,7 @@ static int virtio_dev_probe(struct device *_d)
 
 	/* We have a driver! */
 	add_status(dev, VIRTIO_CONFIG_S_DRIVER);
+	dev->surprize_removal = false;
 
 	/* Figure out what features the device supports. */
 	device_features = dev->config->get_features(dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f15f6e7..131404a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -98,6 +98,7 @@ struct virtio_device {
 	struct list_head vqs;
 	/* Note that this is a Linux set_bit-style bitmap. */
 	unsigned long features[1];
+	bool surprize_removal;
 	void *priv;
 };
 
-- 
1.8.3.1
