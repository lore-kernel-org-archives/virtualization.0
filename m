From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 40/59] Storage: hv: storvsc: Get rid of some unnecessary
	DPRINTs from storvsc.c
Date: Thu, 25 Aug 2011 09:49:06 -0700
Message-ID: <1314290965-2698-40-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of some unnecessary DPRINTs from storvsc.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 2b914e4..3730f3f 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -125,8 +125,6 @@ static int storvsc_channel_init(struct hv_device *device)
 	vstor_packet->operation = VSTOR_OPERATION_BEGIN_INITIALIZATION;
 	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
 
-	DPRINT_INFO(STORVSC, "BEGIN_INITIALIZATION_OPERATION...");
-
 	ret = vmbus_sendpacket(device->channel, vstor_packet,
 			       sizeof(struct vstor_packet),
 			       (unsigned long)request,
@@ -145,7 +143,6 @@ static int storvsc_channel_init(struct hv_device *device)
 	    vstor_packet->status != 0)
 		goto cleanup;
 
-	DPRINT_INFO(STORVSC, "QUERY_PROTOCOL_VERSION_OPERATION...");
 
 	/* reuse the packet for version range supported */
 	memset(vstor_packet, 0, sizeof(struct vstor_packet));
@@ -174,8 +171,6 @@ static int storvsc_channel_init(struct hv_device *device)
 	    vstor_packet->status != 0)
 		goto cleanup;
 
-	/* Query channel properties */
-	DPRINT_INFO(STORVSC, "QUERY_PROPERTIES_OPERATION...");
 
 	memset(vstor_packet, 0, sizeof(struct vstor_packet));
 	vstor_packet->operation = VSTOR_OPERATION_QUERY_PROPERTIES;
@@ -207,8 +202,6 @@ static int storvsc_channel_init(struct hv_device *device)
 	stor_device->target_id
 		= vstor_packet->storage_channel_properties.target_id;
 
-	DPRINT_INFO(STORVSC, "END_INITIALIZATION_OPERATION...");
-
 	memset(vstor_packet, 0, sizeof(struct vstor_packet));
 	vstor_packet->operation = VSTOR_OPERATION_END_INITIALIZATION;
 	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
@@ -232,7 +225,6 @@ static int storvsc_channel_init(struct hv_device *device)
 	    vstor_packet->status != 0)
 		goto cleanup;
 
-	DPRINT_INFO(STORVSC, "**** storage channel up and running!! ****");
 
 cleanup:
 	put_stor_device(device);
@@ -305,13 +297,8 @@ static void storvsc_on_receive(struct hv_device *device,
 		storvsc_on_io_completion(device, vstor_packet, request);
 		break;
 	case VSTOR_OPERATION_REMOVE_DEVICE:
-		DPRINT_INFO(STORVSC, "REMOVE_DEVICE_OPERATION");
-		/* TODO: */
-		break;
 
 	default:
-		DPRINT_INFO(STORVSC, "Unknown operation received - %d",
-			    vstor_packet->operation);
 		break;
 	}
 }
@@ -421,9 +408,6 @@ int storvsc_dev_remove(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
 
-	DPRINT_INFO(STORVSC, "disabling storage device (%p)...",
-		    device->ext);
-
 	stor_device = release_stor_device(device);
 
 	/*
-- 
1.7.4.1
