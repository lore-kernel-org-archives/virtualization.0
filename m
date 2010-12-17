From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 3/4] Staging: hv: Implement key/value pair (KVP)
Date: Thu, 16 Dec 2010 18:54:16 -0700
Message-ID: <4D0A8B49.E57C.0030.1@novell.com>
References: <1292531082-14337-1-git-send-email-ksrinivasan@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: devel@linuxdriverproject.org, Virtualization@lists.osdl.org
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

 


This is an implementation of the key value/pair (KVP) functionality
for Linux guests hosted on HyperV. This component communicates
with the host to support the KVP functionality.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>
---
 drivers/staging/hv/Makefile       |    2 +-
 drivers/staging/hv/channel_mgmt.c |   23 +++-
 drivers/staging/hv/hv_kvp.c       |  346 +++++++++++++++++++++++++++++++++++++
 drivers/staging/hv/hv_kvp.h       |  184 ++++++++++++++++++++
 drivers/staging/hv/hv_util.c      |   14 ++
 drivers/staging/hv/utils.h        |    1 +
 6 files changed, 567 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/hv/hv_kvp.c
 create mode 100644 drivers/staging/hv/hv_kvp.h

diff --git a/drivers/staging/hv/Makefile b/drivers/staging/hv/Makefile
index 4c14138..606ce7d 100644
--- a/drivers/staging/hv/Makefile
+++ b/drivers/staging/hv/Makefile
@@ -10,4 +10,4 @@ hv_vmbus-y := vmbus_drv.o osd.o \
 hv_storvsc-y := storvsc_drv.o storvsc.o
 hv_blkvsc-y := blkvsc_drv.o blkvsc.o
 hv_netvsc-y := netvsc_drv.o netvsc.o rndis_filter.o
-hv_utils-y := hv_util.o
+hv_utils-y := hv_util.o hv_kvp.o
diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 0f4d609..375f164 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -34,8 +34,8 @@ struct vmbus_channel_message_table_entry {
 	void (*messageHandler)(struct vmbus_channel_message_header *msg);
 };
 
-#define MAX_MSG_TYPES                    3
-#define MAX_NUM_DEVICE_CLASSES_SUPPORTED 7
+#define MAX_MSG_TYPES                    4
+#define MAX_NUM_DEVICE_CLASSES_SUPPORTED 8
 
 static const struct hv_guid
 	gSupportedDeviceClasses[MAX_NUM_DEVICE_CLASSES_SUPPORTED] = {
@@ -98,6 +98,15 @@ static const struct hv_guid
 			0xab, 0x55, 0x38, 0x2f, 0x3b, 0xd5, 0x42, 0x2d
 		}
 	},
+	/* {A9A0F4E7-5A45-4d96-B827-8A841E8C03E6} */
+	/* KVP */
+	{
+		.data = {
+			0xe7, 0xf4, 0xa0, 0xa9, 0x45, 0x5a, 0x96, 0x4d,
+			0xb8, 0x27, 0x8a, 0x84, 0x1e, 0x8c, 0x3,  0xe6
+	}
+	},
+
 };
 
 
@@ -231,6 +240,16 @@ struct hyperv_service_callback hv_cb_utils[MAX_MSG_TYPES] = {
 		.callback = chn_cb_negotiate,
 		.log_msg = "Heartbeat channel functionality initialized"
 	},
+	/* {A9A0F4E7-5A45-4d96-B827-8A841E8C03E6} */
+	/* KVP */
+	{
+		.data = {
+			0xe7, 0xf4, 0xa0, 0xa9, 0x45, 0x5a, 0x96, 0x4d,
+			0xb8, 0x27, 0x8a, 0x84, 0x1e, 0x8c, 0x3,  0xe6
+		},
+		.callback = chn_cb_negotiate,
+		.log_msg = "KVP channel functionality initialized"
+	},
 };
 EXPORT_SYMBOL(hv_cb_utils);
 
diff --git a/drivers/staging/hv/hv_kvp.c b/drivers/staging/hv/hv_kvp.c
new file mode 100644
index 0000000..5458631
--- /dev/null
+++ b/drivers/staging/hv/hv_kvp.c
@@ -0,0 +1,346 @@
+/*
+ * An implementation of key value pair (KVP) functionality for Linux.
+ *
+ *
+ * Copyright (C) 2010, Novell, Inc.
+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+
+#include <linux/net.h>
+#include <linux/nls.h>
+#include <linux/connector.h>
+#include <linux/workqueue.h>
+
+#include "logging.h"
+#include "osd.h"
+#include "vmbus.h"
+#include "vmbus_packet_format.h"
+#include "vmbus_channel_interface.h"
+#include "version_info.h"
+#include "channel.h"
+#include "vmbus_private.h"
+#include "vmbus_api.h"
+#include "utils.h"
+#include "hv_kvp.h"
+
+
+
+/*
+ * Global state maintained for transaction that is being processed.
+ * Note that only one transaction can be active at any point in time.
+ *
+ * This state is set when we receive a request from the host; we
+ * cleanup this state when the transaction is completed - when we respond
+ * to the host with the key value.
+ */
+
+static struct {
+	bool active; /* transaction status - active or not */
+	int recv_len; /* number of bytes received. */
+	struct vmbus_channel *recv_channel; /* chn we got the request */
+	u64 recv_req_id; /* request ID. */
+} kvp_transaction;
+
+static int kvp_send_key(int index);
+
+static void kvp_respond_to_host(char *key, char *value, int error);
+static void kvp_work_func(struct work_struct *dummy);
+static void kvp_register(void);
+
+static DECLARE_DELAYED_WORK(kvp_work, kvp_work_func);
+
+static struct cb_id kvp_id = { CN_KVP_IDX, CN_KVP_VAL };
+static const char kvp_name[] = "kvp_kernel_module";
+static int timeout_fired;
+static u8 *recv_buffer;
+/*
+ * Register the kernel component with the user-level daemon.
+ * As part of this registration, pass the LIC version number.
+ */
+
+static void
+kvp_register(void)
+{
+
+	struct cn_msg *msg;
+
+	msg = kzalloc(sizeof(*msg) + strlen(HV_DRV_VERSION) + 1 , GFP_ATOMIC);
+
+	if (msg) {
+		msg->id.idx =  CN_KVP_IDX;
+		msg->id.val = CN_KVP_VAL;
+		msg->seq = KVP_REGISTER;
+		strcpy(msg->data, HV_DRV_VERSION);
+		msg->len = strlen(HV_DRV_VERSION) + 1;
+		cn_netlink_send(msg, 0, GFP_ATOMIC);
+		kfree(msg);
+	}
+}
+static void
+kvp_work_func(struct work_struct *dummy)
+{
+	/*
+	 * If the timer fires, the user-mode component has not responded;
+	 * process the pending transaction.
+	 */
+	kvp_respond_to_host("Unknown key", "Guest timed out", timeout_fired);
+	timeout_fired = 1;
+}
+
+/*
+ * Callback when data is received from user mode.
+ */
+
+static void
+kvp_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *nsp)
+{
+	struct hv_ku_msg *message;
+
+	message = (struct hv_ku_msg *)msg->data;
+	if (msg->seq == KVP_REGISTER) {
+		printk(KERN_INFO "KVP: user-mode registering done.\n");
+		kvp_register();
+	}
+
+	if (msg->seq == KVP_USER_SET) {
+		/*
+		 * Complete the transaction by forwarding the key value
+		 * to the host. But first, cancel the timeout.
+		 */
+		if (cancel_delayed_work_sync(&kvp_work))
+			kvp_respond_to_host(message->kvp_key,
+						message->kvp_value,
+						!strlen(message->kvp_key));
+	}
+}
+
+static int
+kvp_send_key(int index)
+{
+	struct cn_msg *msg;
+
+	msg = kzalloc(sizeof(*msg) + sizeof(struct hv_kvp_msg) , GFP_ATOMIC);
+
+	if (msg) {
+		msg->id.idx =  CN_KVP_IDX;
+		msg->id.val = CN_KVP_VAL;
+		msg->seq = KVP_KERNEL_GET;
+		((struct hv_ku_msg *)msg->data)->kvp_index = index;
+		msg->len = sizeof(struct hv_ku_msg);
+		cn_netlink_send(msg, 0, GFP_ATOMIC);
+		kfree(msg);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Send a response back to the host.
+ */
+
+static void
+kvp_respond_to_host(char *key, char *value, int error)
+{
+	struct hv_kvp_msg  *kvp_msg;
+	struct hv_kvp_msg_enumerate  *kvp_data;
+	char	*key_name;
+	struct icmsg_hdr *icmsghdrp;
+	int	keylen, valuelen;
+	u32	buf_len;
+	struct vmbus_channel *channel;
+	u64	req_id;
+
+	/*
+	 * If a transaction is not active; log and return.
+	 */
+
+	if (!kvp_transaction.active) {
+		/*
+		 * This is a spurious call!
+		 */
+		printk(KERN_WARNING "KVP: Transaction not active\n");
+		return;
+	}
+	/*
+	 * Copy the global state for completing the transaction. Note that
+	 * only one transaction can be active at a time.
+	 */
+
+	buf_len = kvp_transaction.recv_len;
+	channel = kvp_transaction.recv_channel;
+	req_id = kvp_transaction.recv_req_id;
+
+	icmsghdrp = (struct icmsg_hdr *)
+			&recv_buffer[sizeof(struct vmbuspipe_hdr)];
+	kvp_msg = (struct hv_kvp_msg *)
+			&recv_buffer[sizeof(struct vmbuspipe_hdr) +
+			sizeof(struct icmsg_hdr)];
+	kvp_data = &kvp_msg->kvp_data;
+	key_name = key;
+
+	/*
+	 * If the error parameter is set, terminate the host's enumeration.
+	 */
+	if (error) {
+		/*
+		 * We don't support this index or the we have timedout;
+		 * terminate the host-side iteration by returning an error.
+		 */
+		icmsghdrp->status = HV_E_FAIL;
+		goto response_done;
+	}
+
+	/*
+	 * The windows host expects the key/value pair to be encoded
+	 * in utf16.
+	 */
+	keylen = utf8s_to_utf16s(key_name, strlen(key_name),
+				(wchar_t *)kvp_data->data.key);
+	kvp_data->data.key_size = 2*(keylen + 1); /* utf16 encoding */
+	valuelen = utf8s_to_utf16s(value, strlen(value),
+				(wchar_t *)kvp_data->data.value);
+	kvp_data->data.value_size = 2*(valuelen + 1); /* utf16 encoding */
+
+	kvp_data->data.value_type = REG_SZ; /* all our values are strings */
+	icmsghdrp->status = HV_S_OK;
+
+response_done:
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
+
+	vmbus_sendpacket(channel, recv_buffer, buf_len, req_id,
+				VmbusPacketTypeDataInBand, 0);
+
+	kvp_transaction.active = false;
+}
+
+/*
+ * This callback is invoked when we get a KVP message from the host.
+ * The host ensures that only one KVP transaction can be active at a time.
+ * KVP implementation in Linux needs to forward the key to a user-mde
+ * component to retrive the corresponding value. Consequently, we cannot
+ * respond to the host in the conext of this callback. Since the host
+ * guarantees that at most only one transaction can be active at a time,
+ * we stash away the transaction state in a set of global variables.
+ */
+
+void hv_kvp_onchannelcallback(void *context)
+{
+	struct vmbus_channel *channel = context;
+	u32 recvlen;
+	u64 requestid;
+
+	struct hv_kvp_msg *kvp_msg;
+	struct hv_kvp_msg_enumerate *kvp_data;
+
+	struct icmsg_hdr *icmsghdrp;
+	struct icmsg_negotiate *negop = NULL;
+
+
+	if (kvp_transaction.active)
+		return;
+
+
+	vmbus_recvpacket(channel, recv_buffer, PAGE_SIZE, &recvlen, &requestid);
+
+	if (recvlen > 0) {
+		DPRINT_DBG(VMBUS, "KVP packet: len=%d, requestid=%lld",
+			   recvlen, requestid);
+
+		icmsghdrp = (struct icmsg_hdr *)&recv_buffer[
+			sizeof(struct vmbuspipe_hdr)];
+
+		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+			prep_negotiate_resp(icmsghdrp, negop, recv_buffer);
+		} else {
+			kvp_msg = (struct hv_kvp_msg *)&recv_buffer[
+				sizeof(struct vmbuspipe_hdr) +
+				sizeof(struct icmsg_hdr)];
+
+			kvp_data = &kvp_msg->kvp_data;
+
+			/*
+			 * We only support the "get" operation on
+			 * "KVP_POOL_AUTO" pool.
+			 */
+
+			if ((kvp_msg->kvp_hdr.pool != KVP_POOL_AUTO) ||
+				(kvp_msg->kvp_hdr.operation !=
+				KVP_OP_ENUMERATE)) {
+				icmsghdrp->status = HV_E_FAIL;
+				goto callback_done;
+			}
+
+			/*
+			 * Stash away this global state for completing the
+			 * transaction; note transactions are serialized.
+			 */
+			kvp_transaction.recv_len = recvlen;
+			kvp_transaction.recv_channel = channel;
+			kvp_transaction.recv_req_id = requestid;
+			kvp_transaction.active = true;
+
+			/*
+			 * Get the information from the
+			 * user-mode component.
+			 * component. This transaction will be
+			 * completed when we get the value from
+			 * the user-mode component.
+			 * Set a timeout to deal with
+			 * user-mode not responding.
+			 */
+			kvp_send_key(kvp_data->index);
+			schedule_delayed_work(&kvp_work, 100);
+
+			return;
+
+		}
+
+callback_done:
+
+		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
+			| ICMSGHDRFLAG_RESPONSE;
+
+		vmbus_sendpacket(channel, recv_buffer,
+				       recvlen, requestid,
+				       VmbusPacketTypeDataInBand, 0);
+	}
+
+}
+
+int
+hv_kvp_init(void)
+{
+	int err;
+
+	err = cn_add_callback(&kvp_id, kvp_name, kvp_cn_callback);
+	if (err)
+		return err;
+	recv_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!recv_buffer)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void hv_kvp_deinit(void)
+{
+	cn_del_callback(&kvp_id);
+	cancel_delayed_work_sync(&kvp_work);
+	kfree(recv_buffer);
+}
diff --git a/drivers/staging/hv/hv_kvp.h b/drivers/staging/hv/hv_kvp.h
new file mode 100644
index 0000000..e069f59
--- /dev/null
+++ b/drivers/staging/hv/hv_kvp.h
@@ -0,0 +1,184 @@
+/*
+ * An implementation of HyperV key value pair (KVP) functionality for Linux.
+ *
+ *
+ * Copyright (C) 2010, Novell, Inc.
+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef	_KVP_H
+#define	_KVP_H_
+
+/*
+ * Maximum value size - used for both key names and value data, and includes
+ * any applicable NULL terminators.
+ *
+ * Note:  This limit is somewhat arbitrary, but falls easily within what is
+ * supported for all native guests (back to Win 2000) and what is reasonable
+ * for the IC KVP exchange functionality.  Note that Windows Me/98/95 are
+ * limited to 255 character key names.
+ *
+ * MSDN recommends not storing data values larger than 2048 bytes in the
+ * registry.
+ *
+ * Note:  This value is used in defining the KVP exchange message - this value
+ * cannot be modified without affecting the message size and compatability.
+ */
+
+/*
+ * bytes, including any null terminators
+ */
+#define HV_KVP_EXCHANGE_MAX_VALUE_SIZE          (2048)
+
+
+/*
+ * Maximum key size - the registry limit for the length of an entry name
+ * is 256 characters, including the null terminator
+ */
+
+#define HV_KVP_EXCHANGE_MAX_KEY_SIZE            (512)
+
+/*
+ * In Linux, we implement the KVP functionality in two components:
+ * 1) The kernel component which is packaged as part of the hv_utils driver
+ * is responsible for communicating with the host and responsible for
+ * implementing the host/guest protocol. 2) A user level daemon that is
+ * responsible for data gathering.
+ *
+ * Host/Guest Protocol: The host iterates over an index and expects the guest
+ * to assign a key name to the index and also return the value corresponding to
+ * the key. The host will have atmost one KVP transaction outstanding at any
+ * given point in time. The host side iteration stops when the guest returns
+ * an error. Microsoft has specified the following mapping of key names to
+ * host specified index:
+ *
+ *	Index		Key Name
+ *	0		FullyQualifiedDomainName
+ *	1		IntegrationServicesVersion
+ *	2		NetworkAddressIPv4
+ *	3		NetworkAddressIPv6
+ *	4		OSBuildNumber
+ *	5		OSName
+ *	6		OSMajorVersion
+ *	7		OSMinorVersion
+ *	8		OSVersion
+ *	9		ProcessorArchitecture
+ *
+ * The Windows host expects the Key Name and Key Value to be encoded in utf16.
+ *
+ * Guest Kernel/KVP Daemon Protocol: As noted earlier, we implement all of the
+ * data gathering functionality in a user mode daemon. The user level daemon
+ * is also responsible for binding the key name to the index as well. The
+ * kernel and user-level daemon communicate using a connector channel.
+ *
+ * The user mode component first registers with the
+ * the kernel component. Subsequently, the kernel component requests, data
+ * for the specified keys. In response to this message the user mode component
+ * fills in the value corresponding to the specified key. We overload the
+ * sequence field in the cn_msg header to define our KVP message types.
+ *
+ *
+ * The kernel component simply acts as a conduit for communication between the
+ * Windows host and the user-level daemon. The kernel component passes up the
+ * index received from the Host to the user-level daemon. If the index is
+ * valid (supported), the corresponding key as well as its
+ * value (both are strings) is returned. If the index is invalid
+ * (not supported), a NULL key string is returned.
+ */
+
+/*
+ *
+ * The following definitions are shared with the user-mode component; do not
+ * change any of this without making the corresponding changes in
+ * the KVP user-mode component.
+ */
+
+#define CN_KVP_VAL             0x1 /* This supports queries from the kernel */
+#define CN_KVP_USER_VAL       0x2 /* This supports queries from the user */
+
+enum hv_ku_op {
+	KVP_REGISTER = 0, /* Register the user mode component */
+	KVP_KERNEL_GET, /* Kernel is requesting the value */
+	KVP_KERNEL_SET, /* Kernel is providing the value */
+	KVP_USER_GET,  /* User is requesting the value */
+	KVP_USER_SET  /* User is providing the value */
+};
+
+struct hv_ku_msg {
+	__u32 kvp_index; /* Key index */
+	__u8  kvp_key[HV_KVP_EXCHANGE_MAX_KEY_SIZE]; /* Key name */
+	__u8  kvp_value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE]; /* Key  value */
+};
+
+
+
+
+#ifdef __KERNEL__
+
+/*
+ * Registry value types.
+ */
+
+#define REG_SZ 1
+
+enum hv_kvp_exchg_op {
+	KVP_OP_GET = 0,
+	KVP_OP_SET,
+	KVP_OP_DELETE,
+	KVP_OP_ENUMERATE,
+	KVP_OP_COUNT /* Number of operations, must be last. */
+};
+
+enum hv_kvp_exchg_pool {
+	KVP_POOL_EXTERNAL = 0,
+	KVP_POOL_GUEST,
+	KVP_POOL_AUTO,
+	KVP_POOL_AUTO_EXTERNAL,
+	KVP_POOL_AUTO_INTERNAL,
+	KVP_POOL_COUNT /* Number of pools, must be last. */
+};
+
+struct hv_kvp_hdr {
+	u8 operation;
+	u8 pool;
+};
+
+struct hv_kvp_exchg_msg_value {
+	u32 value_type;
+	u32 key_size;
+	u32 value_size;
+	u8 key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
+	u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
+};
+
+struct hv_kvp_msg_enumerate {
+	u32 index;
+	struct hv_kvp_exchg_msg_value data;
+};
+
+struct hv_kvp_msg {
+	struct hv_kvp_hdr	kvp_hdr;
+	struct hv_kvp_msg_enumerate	kvp_data;
+};
+
+int hv_kvp_init(void);
+void hv_kvp_deinit(void);
+void hv_kvp_onchannelcallback(void *);
+
+#endif /* __KERNEL__ */
+#endif	/* _KVP_H */
+
diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index 0074581..dea0513 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -37,6 +37,7 @@
 #include "vmbus_private.h"
 #include "vmbus_api.h"
 #include "utils.h"
+#include "hv_kvp.h"
 
 static u8 *shut_txf_buf;
 static u8 *time_txf_buf;
@@ -255,6 +256,10 @@ static int __init init_hyperv_utils(void)
 {
 	printk(KERN_INFO "Registering HyperV Utility Driver\n");
 
+	if (hv_kvp_init())
+		return -ENODEV;
+
+
 	if (!dmi_check_system(hv_utils_dmi_table))
 		return -ENODEV;
 
@@ -283,6 +288,11 @@ static int __init init_hyperv_utils(void)
 		&heartbeat_onchannelcallback;
 	hv_cb_utils[HV_HEARTBEAT_MSG].callback = &heartbeat_onchannelcallback;
 
+	hv_cb_utils[HV_KVP_MSG].channel->onchannel_callback =
+		&hv_kvp_onchannelcallback;
+
+
+
 	return 0;
 }
 
@@ -302,6 +312,10 @@ static void exit_hyperv_utils(void)
 		&chn_cb_negotiate;
 	hv_cb_utils[HV_HEARTBEAT_MSG].callback = &chn_cb_negotiate;
 
+	hv_cb_utils[HV_KVP_MSG].channel->onchannel_callback =
+		&chn_cb_negotiate;
+	hv_kvp_deinit();
+
 	kfree(shut_txf_buf);
 	kfree(time_txf_buf);
 	kfree(hbeat_txf_buf);
diff --git a/drivers/staging/hv/utils.h b/drivers/staging/hv/utils.h
index 7c07499..6d27d15 100644
--- a/drivers/staging/hv/utils.h
+++ b/drivers/staging/hv/utils.h
@@ -102,6 +102,7 @@ struct ictimesync_data{
 #define HV_SHUTDOWN_MSG		0
 #define HV_TIMESYNC_MSG		1
 #define HV_HEARTBEAT_MSG	2
+#define HV_KVP_MSG		3
 
 struct hyperv_service_callback {
 	u8 msg_type;
-- 
1.7.1
