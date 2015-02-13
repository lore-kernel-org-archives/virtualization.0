From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: don't set VIRTIO_CONFIG_S_DRIVER_OK twice.
Date: Fri, 13 Feb 2015 15:37:17 +1030
Message-ID: <87pp9e9z7e.fsf__14194.3688308404$1423805575$gmane$org@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

I noticed this with the console device.  It's not *wrong*, just a bit
weird.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9f70dfc4751..5ce2aa48fc6e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -236,7 +236,10 @@ static int virtio_dev_probe(struct device *_d)
 	if (err)
 		goto err;
 
-	add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
+
 	if (drv->scan)
 		drv->scan(dev);
