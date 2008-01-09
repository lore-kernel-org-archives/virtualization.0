From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Wed, 9 Jan 2008 14:20:02 +1100
Message-ID: <200801091420.03107.rusty__12357.0298696452$1199849010$gmane$org@rustcorp.com.au>
References: <20080108153356.GA21726@dmt> <20080108161005.GA22168@dmt>
	<4783A245.90002@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4783A245.90002@qumranet.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 09 January 2008 03:18:13 Avi Kivity wrote:
> Marcelo Tosatti wrote:
> > Do you have any suggestion on how to retrieve the IRQ of the virtio
> > device, or some other notification mechanism?

Unfortunately, irqs are logically assigned to virtio queues, not devices.  Yet
configuration info is per-device.

> One way would be to send a "look at config" queue message, but it seems
> that it is a fairly generic operation.  Maybe virtio can add support for
> it, with a new callback.

This is the first time we've had to do this, but I don't think it's the last,
so we should consider it carefully.

Chatted with Anthony, and this is what we came up with:
===
virtio: configuration change callback

Various drivers want to know when their configuration information
changes: the balloon driver is the immediate user, but the network
driver may one day have a "carrier" status as well.

This introduces that callback, and adds it to the virtio PCI
implementation.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci.c |   10 ++++++++++
 include/linux/virtio.h      |    3 +++
 include/linux/virtio_pci.h  |    3 +++
 3 files changed, 16 insertions(+)

diff -r 7494c7702462 drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c	Wed Jan 09 11:00:21 2008 +1100
+++ b/drivers/virtio/virtio_pci.c	Wed Jan 09 11:18:19 2008 +1100
@@ -184,6 +184,16 @@ static irqreturn_t vp_interrupt(int irq,
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
 		return IRQ_NONE;
+
+	/* Configuration change?  Tell driver if it wants to know. */
+	if (isr & VIRTIO_PCI_ISR_CONFIG) {
+		struct virtio_driver *drv;
+		drv = container_of(vp_dev->vdev.dev.driver,
+				   struct virtio_driver, driver);
+
+		if (drv->config_changed)
+			drv->config_changed(&vp_dev->vdev);
+	}
 
 	spin_lock(&vp_dev->lock);
 	list_for_each_entry(info, &vp_dev->virtqueues, node) {
diff -r 7494c7702462 include/linux/virtio.h
--- a/include/linux/virtio.h	Wed Jan 09 11:00:21 2008 +1100
+++ b/include/linux/virtio.h	Wed Jan 09 11:18:19 2008 +1100
@@ -98,12 +98,15 @@ void unregister_virtio_device(struct vir
  * @probe: the function to call when a device is found.  Returns a token for
  *    remove, or PTR_ERR().
  * @remove: the function when a device is removed.
+ * @config_changed: optional function to call when the device configuration
+ *    changes; may be called in interrupt context.
  */
 struct virtio_driver {
 	struct device_driver driver;
 	const struct virtio_device_id *id_table;
 	int (*probe)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
+	void (*config_changed)(struct virtio_device *dev);
 };
 
 int register_virtio_driver(struct virtio_driver *drv);
diff -r 7494c7702462 include/linux/virtio_pci.h
--- a/include/linux/virtio_pci.h	Wed Jan 09 11:00:21 2008 +1100
+++ b/include/linux/virtio_pci.h	Wed Jan 09 11:18:19 2008 +1100
@@ -45,6 +45,9 @@
  * a read-and-acknowledge. */
 #define VIRTIO_PCI_ISR			19
 
+/* The bit of the ISR which indicates a device configuration change. */
+#define VIRTIO_PCI_ISR_CONFIG		0x2
+
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
 #define VIRTIO_PCI_CONFIG		20
