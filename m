From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Subject: [PATCH 1/5] staging: hv: Convert camel cased local variables in channel_interface.c to lower cases
Date: Fri, 15 Oct 2010 10:14:03 -0700
Message-ID: <1287162847-27536-1-git-send-email-haiyangz@linuxonhyperv.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Convert camel cased local variables in channel_interface.c to lower cases

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/channel_interface.c |  126 ++++++++++++++++----------------
 1 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/hv/channel_interface.c b/drivers/staging/hv/channel_interface.c
index 4d35923..d9d345e 100644
--- a/drivers/staging/hv/channel_interface.c
+++ b/drivers/staging/hv/channel_interface.c
@@ -25,15 +25,15 @@
 #include "osd.h"
 #include "vmbus_private.h"
 
-static int IVmbusChannelOpen(struct hv_device *device, u32 SendBufferSize,
-			     u32 RecvRingBufferSize, void *UserData,
-			     u32 UserDataLen,
-			     void (*ChannelCallback)(void *context),
-			     void *Context)
+static int IVmbusChannelOpen(struct hv_device *device, u32 sendbuffer_size,
+			     u32 recv_ringbuffer_size, void *userdata,
+			     u32 userdatalen,
+			     void (*channel_callback)(void *context),
+			     void *context)
 {
-	return vmbus_open(device->context, SendBufferSize,
-				RecvRingBufferSize, UserData, UserDataLen,
-				ChannelCallback, Context);
+	return vmbus_open(device->context, sendbuffer_size,
+				recv_ringbuffer_size, userdata, userdatalen,
+				channel_callback, context);
 }
 
 static void IVmbusChannelClose(struct hv_device *device)
@@ -41,100 +41,102 @@ static void IVmbusChannelClose(struct hv_device *device)
 	vmbus_close(device->context);
 }
 
-static int IVmbusChannelSendPacket(struct hv_device *device, const void *Buffer,
-				   u32 BufferLen, u64 RequestId, u32 Type,
-				   u32 Flags)
+static int IVmbusChannelSendPacket(struct hv_device *device, const void *buffer,
+				   u32 bufferlen, u64 requestid, u32 type,
+				   u32 flags)
 {
-	return vmbus_sendpacket(device->context, Buffer, BufferLen,
-				      RequestId, Type, Flags);
+	return vmbus_sendpacket(device->context, buffer, bufferlen,
+				      requestid, type, flags);
 }
 
 static int IVmbusChannelSendPacketPageBuffer(struct hv_device *device,
-				struct hv_page_buffer PageBuffers[],
-				u32 PageCount, void *Buffer,
-				u32 BufferLen, u64 RequestId)
+				struct hv_page_buffer pagebuffers[],
+				u32 pagecount, void *buffer,
+				u32 bufferlen, u64 requestid)
 {
-	return vmbus_sendpacket_pagebuffer(device->context, PageBuffers,
-						PageCount, Buffer, BufferLen,
-						RequestId);
+	return vmbus_sendpacket_pagebuffer(device->context, pagebuffers,
+						pagecount, buffer, bufferlen,
+						requestid);
 }
 
 static int IVmbusChannelSendPacketMultiPageBuffer(struct hv_device *device,
-				struct hv_multipage_buffer *MultiPageBuffer,
-				void *Buffer, u32 BufferLen, u64 RequestId)
+				struct hv_multipage_buffer *multi_pagebuffer,
+				void *buffer, u32 bufferlen, u64 requestid)
 {
 	return vmbus_sendpacket_multipagebuffer(device->context,
-						     MultiPageBuffer, Buffer,
-						     BufferLen, RequestId);
+						     multi_pagebuffer, buffer,
+						     bufferlen, requestid);
 }
 
-static int IVmbusChannelRecvPacket(struct hv_device *device, void *Buffer,
-				   u32 BufferLen, u32 *BufferActualLen,
-				   u64 *RequestId)
+static int IVmbusChannelRecvPacket(struct hv_device *device, void *buffer,
+				   u32 bufferlen, u32 *buffer_actuallen,
+				   u64 *requestid)
 {
-	return vmbus_recvpacket(device->context, Buffer, BufferLen,
-				      BufferActualLen, RequestId);
+	return vmbus_recvpacket(device->context, buffer, bufferlen,
+				      buffer_actuallen, requestid);
 }
 
-static int IVmbusChannelRecvPacketRaw(struct hv_device *device, void *Buffer,
-				      u32 BufferLen, u32 *BufferActualLen,
-				      u64 *RequestId)
+static int IVmbusChannelRecvPacketRaw(struct hv_device *device, void *buffer,
+				      u32 bufferlen, u32 *buffer_actuallen,
+				      u64 *requestid)
 {
-	return vmbus_recvpacket_raw(device->context, Buffer, BufferLen,
-					 BufferActualLen, RequestId);
+	return vmbus_recvpacket_raw(device->context, buffer, bufferlen,
+					 buffer_actuallen, requestid);
 }
 
-static int IVmbusChannelEstablishGpadl(struct hv_device *device, void *Buffer,
-				       u32 BufferLen, u32 *GpadlHandle)
+static int IVmbusChannelEstablishGpadl(struct hv_device *device, void *buffer,
+				       u32 bufferlen, u32 *gpadl_handle)
 {
-	return vmbus_establish_gpadl(device->context, Buffer, BufferLen,
-					  GpadlHandle);
+	return vmbus_establish_gpadl(device->context, buffer, bufferlen,
+					  gpadl_handle);
 }
 
-static int IVmbusChannelTeardownGpadl(struct hv_device *device, u32 GpadlHandle)
+static int IVmbusChannelTeardownGpadl(struct hv_device *device,
+				      u32 gpadl_handle)
 {
-	return vmbus_teardown_gpadl(device->context, GpadlHandle);
+	return vmbus_teardown_gpadl(device->context, gpadl_handle);
 
 }
 
 
 void GetChannelInfo(struct hv_device *device, struct hv_device_info *info)
 {
-	struct vmbus_channel_debug_info debugInfo;
+	struct vmbus_channel_debug_info debug_info;
 
 	if (!device->context)
 		return;
 
-	vmbus_get_debug_info(device->context, &debugInfo);
+	vmbus_get_debug_info(device->context, &debug_info);
 
-	info->ChannelId = debugInfo.RelId;
-	info->ChannelState = debugInfo.State;
-	memcpy(&info->ChannelType, &debugInfo.InterfaceType,
+	info->ChannelId = debug_info.RelId;
+	info->ChannelState = debug_info.State;
+	memcpy(&info->ChannelType, &debug_info.InterfaceType,
 	       sizeof(struct hv_guid));
-	memcpy(&info->ChannelInstance, &debugInfo.InterfaceInstance,
+	memcpy(&info->ChannelInstance, &debug_info.InterfaceInstance,
 	       sizeof(struct hv_guid));
 
-	info->MonitorId = debugInfo.MonitorId;
+	info->MonitorId = debug_info.MonitorId;
 
-	info->ServerMonitorPending = debugInfo.ServerMonitorPending;
-	info->ServerMonitorLatency = debugInfo.ServerMonitorLatency;
-	info->ServerMonitorConnectionId = debugInfo.ServerMonitorConnectionId;
+	info->ServerMonitorPending = debug_info.ServerMonitorPending;
+	info->ServerMonitorLatency = debug_info.ServerMonitorLatency;
+	info->ServerMonitorConnectionId = debug_info.ServerMonitorConnectionId;
 
-	info->ClientMonitorPending = debugInfo.ClientMonitorPending;
-	info->ClientMonitorLatency = debugInfo.ClientMonitorLatency;
-	info->ClientMonitorConnectionId = debugInfo.ClientMonitorConnectionId;
+	info->ClientMonitorPending = debug_info.ClientMonitorPending;
+	info->ClientMonitorLatency = debug_info.ClientMonitorLatency;
+	info->ClientMonitorConnectionId = debug_info.ClientMonitorConnectionId;
 
-	info->Inbound.InterruptMask = debugInfo.Inbound.CurrentInterruptMask;
-	info->Inbound.ReadIndex = debugInfo.Inbound.CurrentReadIndex;
-	info->Inbound.WriteIndex = debugInfo.Inbound.CurrentWriteIndex;
-	info->Inbound.BytesAvailToRead = debugInfo.Inbound.BytesAvailToRead;
-	info->Inbound.BytesAvailToWrite = debugInfo.Inbound.BytesAvailToWrite;
+	info->Inbound.InterruptMask = debug_info.Inbound.CurrentInterruptMask;
+	info->Inbound.ReadIndex = debug_info.Inbound.CurrentReadIndex;
+	info->Inbound.WriteIndex = debug_info.Inbound.CurrentWriteIndex;
+	info->Inbound.BytesAvailToRead = debug_info.Inbound.BytesAvailToRead;
+	info->Inbound.BytesAvailToWrite = debug_info.Inbound.BytesAvailToWrite;
 
-	info->Outbound.InterruptMask = debugInfo.Outbound.CurrentInterruptMask;
-	info->Outbound.ReadIndex = debugInfo.Outbound.CurrentReadIndex;
-	info->Outbound.WriteIndex = debugInfo.Outbound.CurrentWriteIndex;
-	info->Outbound.BytesAvailToRead = debugInfo.Outbound.BytesAvailToRead;
-	info->Outbound.BytesAvailToWrite = debugInfo.Outbound.BytesAvailToWrite;
+	info->Outbound.InterruptMask = debug_info.Outbound.CurrentInterruptMask;
+	info->Outbound.ReadIndex = debug_info.Outbound.CurrentReadIndex;
+	info->Outbound.WriteIndex = debug_info.Outbound.CurrentWriteIndex;
+	info->Outbound.BytesAvailToRead = debug_info.Outbound.BytesAvailToRead;
+	info->Outbound.BytesAvailToWrite =
+		debug_info.Outbound.BytesAvailToWrite;
 }
 
 
-- 
1.6.3.2
