From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with native
	pr_XXX
Date: Tue, 22 Feb 2011 15:32:40 -0800
Message-ID: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: hjanssen@microsoft.com, haiyangz@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This group of patches removes all DPRINT from hv_vmbus.ko.
It is divided in several patches due to size.

All DPRINT calls have been removed, and where needed have been
replaced with pr_XX native calls. Many debug DPRINT calls have
been removed outright.

The amount of clutter this driver prints has been 
significantly reduced.

Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/logging.h   |    1 +
 drivers/staging/hv/vmbus_drv.c |  145 +++++++++++-----------------------------
 2 files changed, 39 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/hv/logging.h b/drivers/staging/hv/logging.h
index 1799951..517d721 100644
--- a/drivers/staging/hv/logging.h
+++ b/drivers/staging/hv/logging.h
@@ -31,6 +31,7 @@
 /* #include <linux/init.h> */
 /* #include <linux/module.h> */
 
+#define VMBUS_MOD                       "hv_vmbus"
 
 #define VMBUS				0x0001
 #define STORVSC				0x0002
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 459c707..a560a80 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -279,22 +279,16 @@ static int vmbus_on_isr(struct hv_driver *drv)
 	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Check if there are actual msgs to be process */
-	if (msg->header.message_type != HVMSG_NONE) {
-		DPRINT_DBG(VMBUS, "received msg type %d size %d",
-				msg->header.message_type,
-				msg->header.payload_size);
+	if (msg->header.message_type != HVMSG_NONE)
 		ret |= 0x1;
-	}
 
 	/* TODO: Check if there are events to be process */
 	page_addr = hv_context.synic_event_page[cpu];
 	event = (union hv_synic_event_flags *)page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Since we are a child, we only need to check bit 0 */
-	if (test_and_clear_bit(0, (unsigned long *) &event->flags32[0])) {
-		DPRINT_DBG(VMBUS, "received event %d", event->flags32[0]);
+	if (test_and_clear_bit(0, (unsigned long *) &event->flags32[0]))
 		ret |= 0x2;
-	}
 
 	return ret;
 }
@@ -468,17 +462,6 @@ static int vmbus_bus_init(void)
 	int ret;
 	unsigned int vector;
 
-	DPRINT_INFO(VMBUS, "+++++++ HV Driver version = %s +++++++",
-		    HV_DRV_VERSION);
-	DPRINT_INFO(VMBUS, "+++++++ Vmbus supported version = %d +++++++",
-			VMBUS_REVISION_NUMBER);
-	DPRINT_INFO(VMBUS, "+++++++ Vmbus using SINT %d +++++++",
-			VMBUS_MESSAGE_SINT);
-	DPRINT_DBG(VMBUS, "sizeof(vmbus_channel_packet_page_buffer)=%zd, "
-			"sizeof(VMBUS_CHANNEL_PACKET_MULITPAGE_BUFFER)=%zd",
-			sizeof(struct vmbus_channel_packet_page_buffer),
-			sizeof(struct vmbus_channel_packet_multipage_buffer));
-
 	driver->name = driver_name;
 	memcpy(&driver->dev_type, &device_type, sizeof(struct hv_guid));
 
@@ -490,15 +473,8 @@ static int vmbus_bus_init(void)
 	/* Hypervisor initialization...setup hypercall page..etc */
 	ret = hv_init();
 	if (ret != 0) {
-		DPRINT_ERR(VMBUS, "Unable to initialize the hypervisor - 0x%x",
-				ret);
-		goto cleanup;
-	}
-
-	/* Sanity checks */
-	if (!driver->dev_add) {
-		DPRINT_ERR(VMBUS_DRV, "OnDeviceAdd() routine not set");
-		ret = -1;
+		pr_err("%s: %s - Unable to initialize hypervisor - 0x%x",
+		       VMBUS_MOD, __func__, ret);
 		goto cleanup;
 	}
 
@@ -522,8 +498,8 @@ static int vmbus_bus_init(void)
 			  driver->name, NULL);
 
 	if (ret != 0) {
-		DPRINT_ERR(VMBUS_DRV, "ERROR - Unable to request IRQ %d",
-			   vmbus_irq);
+		pr_err("%s: %s ERROR - Unable to request IRQ %d",
+			VMBUS_MOD, __func__, vmbus_irq);
 
 		bus_unregister(&vmbus_drv_ctx->bus);
 
@@ -532,15 +508,15 @@ static int vmbus_bus_init(void)
 	}
 	vector = VMBUS_IRQ_VECTOR;
 
-	DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", vmbus_irq, vector);
+	pr_info("%s: irq 0x%x vector 0x%x", VMBUS_MOD, vmbus_irq, vector);
 
 	/* Call to bus driver to add the root device */
 	memset(dev_ctx, 0, sizeof(struct vm_device));
 
 	ret = driver->dev_add(&dev_ctx->device_obj, &vector);
 	if (ret != 0) {
-		DPRINT_ERR(VMBUS_DRV,
-			   "ERROR - Unable to add vmbus root device");
+		pr_err("%s: %s ERROR - Unable to add hv_vmbus root device",
+		       VMBUS_MOD, __func__);
 
 		free_irq(vmbus_irq, NULL);
 
@@ -567,8 +543,8 @@ static int vmbus_bus_init(void)
 	/* Setup the bus as root device */
 	ret = device_register(&dev_ctx->device);
 	if (ret) {
-		DPRINT_ERR(VMBUS_DRV,
-			   "ERROR - Unable to register vmbus root device");
+		pr_err("%s: %s ERROR Unable to register vmbus root device",
+		       VMBUS_MOD, __func__);
 
 		free_irq(vmbus_irq, NULL);
 		bus_unregister(&vmbus_drv_ctx->bus);
@@ -631,9 +607,6 @@ int vmbus_child_driver_register(struct driver_context *driver_ctx)
 {
 	int ret;
 
-	DPRINT_INFO(VMBUS_DRV, "child driver (%p) registering - name %s",
-		    driver_ctx, driver_ctx->driver.name);
-
 	/* The child driver on this vmbus */
 	driver_ctx->driver.bus = &vmbus_drv.bus;
 
@@ -641,6 +614,13 @@ int vmbus_child_driver_register(struct driver_context *driver_ctx)
 
 	vmbus_request_offers();
 
+	if (ret)
+		pr_err("%s: %s Unable to register Hyper-V driver %s",
+		       VMBUS_MOD, __func__, driver_ctx->driver.name);
+	else
+		pr_info("%s: Hyper-V driver registering %s", VMBUS_MOD,
+			driver_ctx->driver.name);
+
 	return ret;
 }
 EXPORT_SYMBOL(vmbus_child_driver_register);
@@ -658,11 +638,11 @@ EXPORT_SYMBOL(vmbus_child_driver_register);
  */
 void vmbus_child_driver_unregister(struct driver_context *driver_ctx)
 {
-	DPRINT_INFO(VMBUS_DRV, "child driver (%p) unregistering - name %s",
-		    driver_ctx, driver_ctx->driver.name);
-
 	driver_unregister(&driver_ctx->driver);
 
+	pr_info("%s: child driver unregistering - %s", VMBUS_MOD,
+		driver_ctx->driver.name);
+
 	driver_ctx->driver.bus = NULL;
 }
 EXPORT_SYMBOL(vmbus_child_driver_unregister);
@@ -681,30 +661,11 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 	/* Allocate the new child device */
 	child_device_ctx = kzalloc(sizeof(struct vm_device), GFP_KERNEL);
 	if (!child_device_ctx) {
-		DPRINT_ERR(VMBUS_DRV,
-			"unable to allocate device_context for child device");
+		pr_err("%s: %s Unable to allocate device_context child device",
+		       VMBUS_MOD, __func__);
 		return NULL;
 	}
 
-	DPRINT_DBG(VMBUS_DRV, "child device (%p) allocated - "
-		"type {%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-		"%02x%02x%02x%02x%02x%02x%02x%02x},"
-		"id {%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-		"%02x%02x%02x%02x%02x%02x%02x%02x}",
-		&child_device_ctx->device,
-		type->data[3], type->data[2], type->data[1], type->data[0],
-		type->data[5], type->data[4], type->data[7], type->data[6],
-		type->data[8], type->data[9], type->data[10], type->data[11],
-		type->data[12], type->data[13], type->data[14], type->data[15],
-		instance->data[3], instance->data[2],
-		instance->data[1], instance->data[0],
-		instance->data[5], instance->data[4],
-		instance->data[7], instance->data[6],
-		instance->data[8], instance->data[9],
-		instance->data[10], instance->data[11],
-		instance->data[12], instance->data[13],
-		instance->data[14], instance->data[15]);
-
 	child_device_obj = &child_device_ctx->device_obj;
 	child_device_obj->channel = channel;
 	memcpy(&child_device_obj->dev_type, type, sizeof(struct hv_guid));
@@ -730,9 +691,6 @@ int vmbus_child_device_register(struct hv_device *root_device_obj,
 				to_vm_device(child_device_obj);
 	static atomic_t device_num = ATOMIC_INIT(0);
 
-	DPRINT_DBG(VMBUS_DRV, "child device (%p) registering",
-		   child_device_ctx);
-
 	/* Set the device name. Otherwise, device_register() will fail. */
 	dev_set_name(&child_device_ctx->device, "vmbus_0_%d",
 		     atomic_inc_return(&device_num));
@@ -752,11 +710,11 @@ int vmbus_child_device_register(struct hv_device *root_device_obj,
 	ret = child_device_ctx->probe_error;
 
 	if (ret)
-		DPRINT_ERR(VMBUS_DRV, "unable to register child device (%p)",
-			   &child_device_ctx->device);
+		pr_err("%s: %s Unable to register child device",
+		       VMBUS_MOD, __func__);
 	else
-		DPRINT_INFO(VMBUS_DRV, "child device (%p) registered",
-			    &child_device_ctx->device);
+		pr_info("%s: Child device (%s) registered", VMBUS_MOD,
+			dev_name(&child_device_ctx->device));
 
 	return ret;
 }
@@ -769,17 +727,14 @@ void vmbus_child_device_unregister(struct hv_device *device_obj)
 {
 	struct vm_device *device_ctx = to_vm_device(device_obj);
 
-	DPRINT_INFO(VMBUS_DRV, "unregistering child device (%p)",
-		    &device_ctx->device);
-
 	/*
 	 * Kick off the process of unregistering the device.
 	 * This will call vmbus_remove() and eventually vmbus_device_release()
 	 */
 	device_unregister(&device_ctx->device);
 
-	DPRINT_INFO(VMBUS_DRV, "child device (%p) unregistered",
-		    &device_ctx->device);
+	pr_info("%s: child device %s unregistered", VMBUS_MOD,
+		    dev_name(&device_ctx->device));
 }
 
 /*
@@ -794,21 +749,6 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
 	struct vm_device *device_ctx = device_to_vm_device(device);
 	int ret;
 
-	DPRINT_INFO(VMBUS_DRV, "generating uevent - VMBUS_DEVICE_CLASS_GUID={"
-		    "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-		    "%02x%02x%02x%02x%02x%02x%02x%02x}",
-		    device_ctx->class_id.data[3], device_ctx->class_id.data[2],
-		    device_ctx->class_id.data[1], device_ctx->class_id.data[0],
-		    device_ctx->class_id.data[5], device_ctx->class_id.data[4],
-		    device_ctx->class_id.data[7], device_ctx->class_id.data[6],
-		    device_ctx->class_id.data[8], device_ctx->class_id.data[9],
-		    device_ctx->class_id.data[10],
-		    device_ctx->class_id.data[11],
-		    device_ctx->class_id.data[12],
-		    device_ctx->class_id.data[13],
-		    device_ctx->class_id.data[14],
-		    device_ctx->class_id.data[15]);
-
 	ret = add_uevent_var(env, "VMBUS_DEVICE_CLASS_GUID={"
 			     "%02x%02x%02x%02x-%02x%02x-%02x%02x-"
 			     "%02x%02x%02x%02x%02x%02x%02x%02x}",
@@ -877,10 +817,6 @@ static int vmbus_match(struct device *device, struct device_driver *driver)
 			(struct vmbus_driver_context *)driver_ctx;
 
 		device_ctx->device_obj.drv = &vmbus_drv_ctx->drv_obj;
-		DPRINT_INFO(VMBUS_DRV,
-			    "device object (%p) set to driver object (%p)",
-			    &device_ctx->device_obj,
-			    device_ctx->device_obj.drv);
 
 		match = 1;
 	}
@@ -922,18 +858,17 @@ static int vmbus_probe(struct device *child_device)
 	if (driver_ctx->probe) {
 		ret = device_ctx->probe_error = driver_ctx->probe(child_device);
 		if (ret != 0) {
-			DPRINT_ERR(VMBUS_DRV, "probe() failed for device %s "
-				   "(%p) on driver %s (%d)...",
-				   dev_name(child_device), child_device,
-				   child_device->driver->name, ret);
+			pr_err("%s: %s failed for device %s (%d)",
+			       VMBUS_MOD, __func__,
+			       dev_name(child_device), ret);
 
 			INIT_WORK(&device_ctx->probe_failed_work_item,
 				  vmbus_probe_failed_cb);
 			schedule_work(&device_ctx->probe_failed_work_item);
 		}
 	} else {
-		DPRINT_ERR(VMBUS_DRV, "probe() method not set for driver - %s",
-			   child_device->driver->name);
+		pr_err("%s: %s not set for driver - %s",
+		       VMBUS_MOD, __func__, dev_name(child_device));
 		ret = -1;
 	}
 	return ret;
@@ -966,9 +901,8 @@ static int vmbus_remove(struct device *child_device)
 		if (driver_ctx->remove) {
 			ret = driver_ctx->remove(child_device);
 		} else {
-			DPRINT_ERR(VMBUS_DRV,
-				   "remove() method not set for driver - %s",
-				   child_device->driver->name);
+			pr_err("%s: %s not set for driver - %s",
+			       VMBUS_MOD, __func__, dev_name(child_device));
 			ret = -1;
 		}
 	}
@@ -1086,10 +1020,8 @@ MODULE_DEVICE_TABLE(dmi, microsoft_hv_dmi_table);
 
 static int __init vmbus_init(void)
 {
-	DPRINT_INFO(VMBUS_DRV,
-		"Vmbus initializing.... current log level 0x%x (%x,%x)",
-		vmbus_loglevel, HIWORD(vmbus_loglevel), LOWORD(vmbus_loglevel));
-	/* Todo: it is used for loglevel, to be ported to new kernel. */
+	pr_info("%s: initializing Version %s. Supported Hyper-V Rev %d.",
+		VMBUS_MOD, HV_DRV_VERSION, VMBUS_REVISION_NUMBER);
 
 	if (!dmi_check_system(microsoft_hv_dmi_table))
 		return -ENODEV;
@@ -1100,7 +1032,6 @@ static int __init vmbus_init(void)
 static void __exit vmbus_exit(void)
 {
 	vmbus_bus_exit();
-	/* Todo: it is used for loglevel, to be ported to new kernel. */
 }
 
 /*
-- 
1.6.0.2
