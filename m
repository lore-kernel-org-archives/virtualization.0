From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/2] kvm-s390: implement config_changed for virtio on s390
Date: Tue, 18 Nov 2008 22:44:13 +0100
Message-ID: <200811182244.14079.borntraeger__5751.26165426827$1227044817$gmane$org@de.ibm.com>
References: <200811181245.03931.borntraeger@de.ibm.com>
	<200811181247.41739.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811181247.41739.borntraeger@de.ibm.com>
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

Hmpf. There was a thinko. Overloading the LSB of the token address does not 
work with old kernels and new userspace on 64bit. My test did not trigger 
because I only tested with virtio_console and my userspace checks for the 
feature bit. 

Can you replace the kvm-s390 patch with this one?
It basically moves the "is a config change bit" from LC_PFAULT_INTPARM to 
LC_EXT_PARAMS. The content of both defined locations can be defined by the 
transport. On 31bit both locations are identical.

This gives us:
64bit:
LC_PFAULT_INTPARM	0x11b8	(8Byte)	token
LC_EXT_PARAMS		0x80	(4Byte) unused->changebit
LSB of token is not overloaded, change is compatible.

31bit:
LC_PFAULT_INTPARM	0x80	(4Byte) token + changebit
LC_EXT_PARAMS		0x80	(4byte) token + changebit
LSB of token is overloaded, but 31bit transport does not exist yet.
No need to worry about compatibility.

-

[PATCH 2/2] kvm-s390: implement config_changed for virtio on s390

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch implements config_changed for the s390 virtio transport.

We use the least significant bit of the interrupt parameter field
to decide, if this interrupt should call the virtio virtqueue callback
or the config_changed callback.

This method is compatible with old host and guest code. Old 64 bit guests
will not check the bit and trigger a harmless additional vring_interrupt
call. Old host code will never set this bit, this is also safe.

This patch also takes care of a potential future 31 bit virtio transport
for s390. On 31 bit _LC_PFAULT_INTPARM and __LC_EXT_PARAMS are identical.
We exploit the alignment of the token and fold the change bit into the
lsb of the token itself.


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
+	/* The LSB might be overloaded, we have to mask it */
+	vq = (struct virtqueue *) ((*(long *) __LC_PFAULT_INTPARM) & ~1UL);
+
+	/* We use the LSB of extparam, to decide, if this interrupt is a config
+	 * change or a "standard" interrupt */
+	config_changed =  (*(int *)  __LC_EXT_PARAMS & 1);
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
