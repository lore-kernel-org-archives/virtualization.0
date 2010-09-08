From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/1] staging: hv: Convert vmbus driver interface function
	pointer table to constant
Date: Wed, 8 Sep 2010 20:29:45 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF72854C92E8__4192.1284552247$1283977826$gmane$org@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualiz>
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Convert vmbus driver interface function pointer table to constant
The vmbus interface functions are assigned to a constant - vmbus_ops.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/TODO                |    2 --
 drivers/staging/hv/channel_interface.c |   29 +++++++++++++++--------------
 drivers/staging/hv/channel_interface.h |    2 --
 drivers/staging/hv/vmbus.c             |    9 ---------
 drivers/staging/hv/vmbus_api.h         |    4 +++-
 drivers/staging/hv/vmbus_drv.c         |    4 +---
 6 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index 66a89c8..582fd4a 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -2,8 +2,6 @@ TODO:
 	- fix remaining checkpatch warnings and errors
 	- audit the vmbus to verify it is working properly with the
 	  driver model
-	- convert vmbus driver interface function pointer tables
-          to constant, a.k.a vmbus_ops
 	- see if the vmbus can be merged with the other virtual busses
 	  in the kernel
 	- audit the network driver
diff --git a/drivers/staging/hv/channel_interface.c b/drivers/staging/hv/channel_interface.c
index d9f51ac..3f6a1cb 100644
--- a/drivers/staging/hv/channel_interface.c
+++ b/drivers/staging/hv/channel_interface.c
@@ -97,20 +97,6 @@ static int IVmbusChannelTeardownGpadl(struct hv_device *device, u32 GpadlHandle)
 
 }
 
-void GetChannelInterface(struct vmbus_channel_interface *iface)
-{
-	iface->Open = IVmbusChannelOpen;
-	iface->Close	= IVmbusChannelClose;
-	iface->SendPacket = IVmbusChannelSendPacket;
-	iface->SendPacketPageBuffer = IVmbusChannelSendPacketPageBuffer;
-	iface->SendPacketMultiPageBuffer =
-					IVmbusChannelSendPacketMultiPageBuffer;
-	iface->RecvPacket = IVmbusChannelRecvPacket;
-	iface->RecvPacketRaw	= IVmbusChannelRecvPacketRaw;
-	iface->EstablishGpadl = IVmbusChannelEstablishGpadl;
-	iface->TeardownGpadl = IVmbusChannelTeardownGpadl;
-	iface->GetInfo = GetChannelInfo;
-}
 
 void GetChannelInfo(struct hv_device *device, struct hv_device_info *info)
 {
@@ -150,3 +136,18 @@ void GetChannelInfo(struct hv_device *device, struct hv_device_info *info)
 	info->Outbound.BytesAvailToRead = debugInfo.Outbound.BytesAvailToRead;
 	info->Outbound.BytesAvailToWrite = debugInfo.Outbound.BytesAvailToWrite;
 }
+
+
+/* vmbus interface function pointer table */
+const struct vmbus_channel_interface vmbus_ops = {
+	.Open = IVmbusChannelOpen,
+	.Close = IVmbusChannelClose,
+	.SendPacket = IVmbusChannelSendPacket,
+	.SendPacketPageBuffer = IVmbusChannelSendPacketPageBuffer,
+	.SendPacketMultiPageBuffer = IVmbusChannelSendPacketMultiPageBuffer,
+	.RecvPacket = IVmbusChannelRecvPacket,
+	.RecvPacketRaw	= IVmbusChannelRecvPacketRaw,
+	.EstablishGpadl = IVmbusChannelEstablishGpadl,
+	.TeardownGpadl = IVmbusChannelTeardownGpadl,
+	.GetInfo = GetChannelInfo,
+};
diff --git a/drivers/staging/hv/channel_interface.h b/drivers/staging/hv/channel_interface.h
index 6acaf6c..ec88219 100644
--- a/drivers/staging/hv/channel_interface.h
+++ b/drivers/staging/hv/channel_interface.h
@@ -27,8 +27,6 @@
 
 #include "vmbus_api.h"
 
-void GetChannelInterface(struct vmbus_channel_interface *ChannelInterface);
-
 void GetChannelInfo(struct hv_device *Device,
 		    struct hv_device_info *DeviceInfo);
 
diff --git a/drivers/staging/hv/vmbus.c b/drivers/staging/hv/vmbus.c
index ca1e18a..db2afa3 100644
--- a/drivers/staging/hv/vmbus.c
+++ b/drivers/staging/hv/vmbus.c
@@ -61,14 +61,6 @@ static void VmbusGetChannelOffers(void)
 }
 
 /*
- * VmbusGetChannelInterface - Get the channel interface
- */
-static void VmbusGetChannelInterface(struct vmbus_channel_interface *Interface)
-{
-	GetChannelInterface(Interface);
-}
-
-/*
  * VmbusGetChannelInfo - Get the device info for the specified device object
  */
 static void VmbusGetChannelInfo(struct hv_device *DeviceObject,
@@ -279,7 +271,6 @@ int VmbusInitialize(struct hv_driver *drv)
 	driver->OnMsgDpc		= VmbusOnMsgDPC;
 	driver->OnEventDpc		= VmbusOnEventDPC;
 	driver->GetChannelOffers	= VmbusGetChannelOffers;
-	driver->GetChannelInterface	= VmbusGetChannelInterface;
 	driver->GetChannelInfo		= VmbusGetChannelInfo;
 
 	/* Hypervisor initialization...setup hypercall page..etc */
diff --git a/drivers/staging/hv/vmbus_api.h b/drivers/staging/hv/vmbus_api.h
index 4275be3..7f3d7dc 100644
--- a/drivers/staging/hv/vmbus_api.h
+++ b/drivers/staging/hv/vmbus_api.h
@@ -129,6 +129,9 @@ struct vmbus_channel_interface {
 	void (*GetInfo)(struct hv_device *dev, struct hv_device_info *devinfo);
 };
 
+extern const struct vmbus_channel_interface vmbus_ops;
+
+
 /* Base driver object */
 struct hv_driver {
 	const char *name;
@@ -183,7 +186,6 @@ struct vmbus_driver {
 	void (*OnEventDpc)(struct hv_driver *driver);
 	void (*GetChannelOffers)(void);
 
-	void (*GetChannelInterface)(struct vmbus_channel_interface *i);
 	void (*GetChannelInfo)(struct hv_device *dev,
 			       struct hv_device_info *devinfo);
 };
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 092f02e..ad29887 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -458,9 +458,7 @@ EXPORT_SYMBOL(vmbus_child_driver_unregister);
  */
 void vmbus_get_interface(struct vmbus_channel_interface *interface)
 {
-	struct vmbus_driver *vmbus_drv_obj = &g_vmbus_drv.drv_obj;
-
-	vmbus_drv_obj->GetChannelInterface(interface);
+	*interface = vmbus_ops;
 }
 EXPORT_SYMBOL(vmbus_get_interface);
 
-- 
1.6.3.2
