From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/2] S390: take a full byte as ext_param indicator
Date: Mon, 23 Aug 2010 23:31:16 +0200
Message-ID: <1282599077-29857-1-git-send-email-agraf__13941.5607009598$1282599128$gmane$org@suse.de>
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
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Currenty the ext_param field only distinguishes between "config change" and
"vring interrupt". We can do a lot more with it though, so let's enable a
full byte of possible values and constants to #defines while at it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 drivers/s390/kvm/kvm_virtio.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 4e298bc..ada7e2c 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -27,6 +27,9 @@
 #include <asm/s390_ext.h>
 
 #define VIRTIO_SUBCODE_64 0x0D00
+#define VIRTIO_PARAM_MASK		0xff
+#define VIRTIO_PARAM_VRING_INTERRUPT	0x0
+#define VIRTIO_PARAM_CONFIG_CHANGED	0x1
 
 /*
  * The pointer to our (page) of device descriptions.
@@ -334,7 +337,7 @@ static void kvm_extint_handler(u16 code)
 {
 	struct virtqueue *vq;
 	u16 subcode;
-	int config_changed;
+	u32 param;
 
 	subcode = S390_lowcore.cpu_addr;
 	if ((subcode & 0xff00) != VIRTIO_SUBCODE_64)
@@ -343,18 +346,25 @@ static void kvm_extint_handler(u16 code)
 	/* The LSB might be overloaded, we have to mask it */
 	vq = (struct virtqueue *)(S390_lowcore.ext_params2 & ~1UL);
 
-	/* We use the LSB of extparam, to decide, if this interrupt is a config
-	 * change or a "standard" interrupt */
-	config_changed = S390_lowcore.ext_params & 1;
+	/* We use ext_params to decide what this interrupt means */
+	param = S390_lowcore.ext_params & VIRTIO_PARAM_MASK;
 
-	if (config_changed) {
+	switch (param) {
+	case VIRTIO_PARAM_CONFIG_CHANGED:
+	{
 		struct virtio_driver *drv;
 		drv = container_of(vq->vdev->dev.driver,
 				   struct virtio_driver, driver);
 		if (drv->config_changed)
 			drv->config_changed(vq->vdev);
-	} else
+
+		break;
+	}
+	case VIRTIO_PARAM_VRING_INTERRUPT:
+	default:
 		vring_interrupt(0, vq);
+		break;
+	}
 }
 
 /*
-- 
1.6.0.2
