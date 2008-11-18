From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] kvm-s390: implement config_changed for virtio on s390
Date: Tue, 18 Nov 2008 12:47:41 +0100
Message-ID: <200811181247.41739.borntraeger__622.384544885968$1227009013$gmane$org@de.ibm.com>
References: <200811181245.03931.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811181245.03931.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest@ozlabs.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch implements config_changed for the s390 virtio transport.

We use the least significant bit of the interrupt parameter field
to decide, if this interrupt should call the virtio virtqueue callback
or the config_changed callback.

This method is compatible with old host and guest code. Old 64 bit guests
will not check the bit and trigger a harmless additional vring_interrupt
call. Old host code will never set this bit, this is also safe.

I dont know if we will implement 31bit guest support, but this interface 
is also 31-bit safe

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/kvm/kvm_virtio.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

Index: kvm/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- kvm.orig/drivers/s390/kvm/kvm_virtio.c
+++ kvm/drivers/s390/kvm/kvm_virtio.c
@@ -295,13 +295,29 @@ static void scan_devices(void)
  */
 static void kvm_extint_handler(u16 code)
 {
-	void *data = (void *) *(long *) __LC_PFAULT_INTPARM;
-	u16 subcode = S390_lowcore.cpu_addr;
+	struct virtqueue *vq;
+	u16 subcode;
+	int config_changed;
 
+ 	subcode = S390_lowcore.cpu_addr;
 	if ((subcode & 0xff00) != VIRTIO_SUBCODE_64)
 		return;
 
-	vring_interrupt(0, data);
+	/* The LSB is overloaded, we have to mask it */
+	vq = (struct virtqueue *) ((*(long *) __LC_PFAULT_INTPARM) & ~1UL);
+
+	/* We use the LSB of extparam, to decide, if this interrupt is a config
+	 * change or a "standard" interrupt */
+	config_changed =  (*(long *)  __LC_PFAULT_INTPARM & 1);
+
+	if (config_changed) {
+		struct virtio_driver *drv;
+		drv = container_of(vq->vdev->dev.driver,
+				   struct virtio_driver, driver);
+		if (drv->config_changed)
+			drv->config_changed(vq->vdev);
+	} else
+		vring_interrupt(0, vq);
 }
 
 /*
