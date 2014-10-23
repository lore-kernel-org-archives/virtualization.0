From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v4 10/17] virtio: simplify feature bit handling
Date: Thu, 23 Oct 2014 19:24:40 +0300
Message-ID: <1414081380-14623-11-git-send-email-mst@redhat.com>
References: <1414081380-14623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414081380-14623-1-git-send-email-mst@redhat.com>
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

Now that we use u64 for bits, we can simply & them together.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a3df817..0f44cff 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -160,6 +160,7 @@ static int virtio_dev_probe(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	u64 device_features;
+	u64 driver_features;
 	unsigned status;
 
 	/* We have a driver! */
@@ -168,15 +169,16 @@ static int virtio_dev_probe(struct device *_d)
 	/* Figure out what features the device supports. */
 	device_features = dev->config->get_features(dev);
 
-	/* Features supported by both device and driver into dev->features. */
-	dev->features = 0;
+	/* Figure out what features the driver supports. */
+	driver_features = 0;
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
 		BUG_ON(f >= 64);
-		if (device_features & (1ULL << f))
-			dev->features |= (1ULL << f);
+		driver_features |= (1ULL << f);
 	}
 
+	dev->features = driver_features & device_features;
+
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
 		if (device_features & (1ULL << i))
-- 
MST
