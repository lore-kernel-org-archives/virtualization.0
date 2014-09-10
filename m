From: Amos Kong <akong@redhat.com>
Subject: [PATCH v3 2/2] virtio-rng: skip reading when we start to remove the
	device
Date: Wed, 10 Sep 2014 14:11:37 +0800
Message-ID: <1410329497-14349-3-git-send-email-akong__26190.3917337351$1410329532$gmane$org@redhat.com>
References: <1410329497-14349-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410329497-14349-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, stable@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Before we really unregister the hwrng device, reading will get stuck if
the virtio device is reset. We should return error for reading when we
start to remove the device.

Signed-off-by: Amos Kong <akong@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/char/hw_random/virtio-rng.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 849b228..132c9cc 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -36,6 +36,7 @@ struct virtrng_info {
 	int index;
 	bool busy;
 	bool hwrng_register_done;
+	bool hwrng_removed;
 };
 
 
@@ -68,6 +69,9 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	int ret;
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
+	if (vi->hwrng_removed)
+		return -ENODEV;
+
 	if (!vi->busy) {
 		vi->busy = true;
 		init_completion(&vi->have_data);
@@ -137,6 +141,7 @@ static void remove_common(struct virtio_device *vdev)
 {
 	struct virtrng_info *vi = vdev->priv;
 
+	vi->hwrng_removed = true;
 	vi->data_avail = 0;
 	complete(&vi->have_data);
 	vdev->config->reset(vdev);
-- 
1.9.3
