From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH]: An implementation of HyperV  KVP  functionality
Date: Thu, 11 Nov 2010 13:03:10 -0700
Message-ID: <4CDBE98E02000030000902C9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part5D70C0EE.0__="
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
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

--=__Part5D70C0EE.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am enclosing a patch that implements the KVP (Key Value Pair) functionali=
ty for Linux guests on HyperV. This functionality allows Microsoft =
Management stack to query information from the guest. This functionality =
is implemented in two parts: (a) A kernel component that communicates with =
the host and (b) A user level daemon that implements data gathering. The =
attached patch (kvp.patch) implements the kernel component. I am also =
attaching the code for the user-level daemon (kvp_daemon.c)  for reference.=


Regards,

K. Y


--=__Part5D70C0EE.0__=
Content-Type: text/plain; name="kvp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="kvp.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0ASubject: An implementa=
tion of key/value pair feature (KVP) for Linux =0Aon HyperV.=0A=0ASigned-of=
f-by: K. Y. Srinivasan <ksrinivasan@novell.com> =0A=0AIndex: linux.trees.gi=
t/drivers/staging/hv/kvp.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.000000000 +0000=0A+++ =
linux.trees.git/drivers/staging/hv/kvp.c	2010-11-11 13:45:17.0000000=
00 -0500=0A@@ -0,0 +1,404 @@=0A+/*=0A+ * An implementation of key value =
pair (KVP) functionality for Linux.=0A+ *=0A+ *=0A+ * Copyright (C) 2010, =
Novell, Inc.=0A+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>=0A+ =
*=0A+ * This program is free software; you can redistribute it and/or =
modify it=0A+ * under the terms of the GNU General Public License version =
2 as published=0A+ * by the Free Software Foundation.=0A+ *=0A+ * This =
program is distributed in the hope that it will be useful, but=0A+ * =
WITHOUT ANY WARRANTY; without even the implied warranty of=0A+ * MERCHANTAB=
ILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or=0A+ * NON =
INFRINGEMENT.  See the GNU General Public License for more=0A+ * =
details.=0A+ *=0A+ * You should have received a copy of the GNU General =
Public License=0A+ * along with this program; if not, write to the Free =
Software=0A+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =
02110-1301 USA.=0A+ *=0A+ */=0A+=0A+=0A+#include <linux/net.h>=0A+#include =
<linux/nls.h>=0A+#include <linux/connector.h>=0A+=0A+#include "logging.h"=
=0A+#include "osd.h"=0A+#include "vmbus.h"=0A+#include "vmbus_packet_format=
.h"=0A+#include "vmbus_channel_interface.h"=0A+#include "version_info.h"=0A=
+#include "channel.h"=0A+#include "vmbus_private.h"=0A+#include "vmbus_api.=
h"=0A+#include "utils.h"=0A+#include "kvp.h"=0A+=0A+=0A+/*=0A+ *=0A+ * The =
following definitions are shared with the user-mode component; do not=0A+ =
* change any of this without making the corresponding changes in=0A+ * the =
KVP user-mode component.=0A+ */=0A+=0A+#define CN_KVP_VAL             0x1 =
/* This supports queries from the kernel */=0A+#define CN_KVP_USER_VAL     =
  0x2 /* This supports queries from the user */=0A+=0A+=0A+/*=0A+ * KVP =
protocol: The user mode component first registers with the=0A+ * the =
kernel component. Subsequently, the kernel component requests, data=0A+ * =
for the specified keys. In response to this message the user mode =
component=0A+ * fills in the value corresponding to the specified key. We =
overload the=0A+ * sequence field in the cn_msg header to define our KVP =
message types.=0A+ *=0A+ * XXXKYS: Have a shared header file between the =
user and kernel (TODO)=0A+ */=0A+=0A+enum kvp_op {=0A+	KVP_REGISTER =3D =
0, /* Register the user mode component */=0A+	KVP_KERNEL_GET,/*Kernel is =
requesting the value for the specified key*/=0A+	KVP_KERNEL_SET, =
/*Kernel is providing the value for the specified key*/=0A+	KVP_USER_GE=
T, /*User is requesting the value for the specified key*/=0A+	KVP_USER_SE=
T /*User is providing the value for the specified key*/=0A+};=0A+=0A+=0A+=
=0A+#define KVP_KEY_SIZE    512=0A+#define KVP_VALUE_SIZE  2048=0A+=0A+=0A+=
typedef struct kvp_msg {=0A+	__u32 kvp_key; /* Key */=0A+	__u8  =
kvp_value[0]; /* Corresponding value */=0A+} kvp_msg_t;=0A+=0A+/*=0A+ * =
End of shared definitions.=0A+ */=0A+=0A+/*=0A+ * Registry value types.=0A+=
 */=0A+=0A+#define REG_SZ 1=0A+=0A+/*=0A+ * Array of keys we support in =
Linux.=0A+ *=0A+ */=0A+#define KVP_MAX_KEY	10=0A+#define KVP_LIC_VERSI=
ON 1=0A+=0A+=0A+static char *kvp_keys[KVP_MAX_KEY] =3D {"FullyQualifiedDoma=
inName",=0A+				"IntegrationServicesVersion",=0A+	=
			"NetworkAddressIPv4",=0A+				=
"NetworkAddressIPv6",=0A+				"OSBuildNumber",=0A=
+				"OSName",=0A+				=
"OSMajorVersion",=0A+				"OSMinorVersion",=0A+		=
		"OSVersion",=0A+				"ProcessorA=
rchitecture",=0A+				};=0A+=0A+/*=0A+ * Global =
state maintained for transaction that is being processed.=0A+ * Note that =
only one transaction can be active at any point in time.=0A+ *=0A+ * This =
state is set when we receive a request from the host; we=0A+ * cleanup =
this state when the transaction is completed - when we respond=0A+ * to =
the host with the key value.=0A+ */=0A+=0A+static u8 *recv_buffer; /* the =
receive buffer that we allocated */=0A+static int recv_len; /* number of =
bytes received. */=0A+static struct vmbus_channel *recv_channel; /*chn on =
which we got the request*/=0A+static u64 recv_req_id; /* request ID. =
*/=0A+static int kvp_current_index;=0A+=0A+static int=0A+kvp_send_key(int =
index);=0A+=0A+static=0A+void kvp_respond_to_host(int key, char *value);=0A=
+=0A+static struct cb_id kvp_id =3D { CN_KVP_IDX, CN_KVP_VAL };=0A+static =
char kvp_name[] =3D "kvp_kernel_module";=0A+=0A+static bool kvp_transaction=
_active;=0A+=0A+static struct timer_list kvp_timer;=0A+=0A+static void =
kvp_timer_func(unsigned long __data)=0A+{=0A+	u32	key =3D *((u32 =
*)__data);=0A+	/*=0A+	 * If the timer fires, the user-mode component has =
not responded;=0A+	 * process the pending transaction.=0A+	 */=0A+	=
kvp_respond_to_host(key, "Guest timed out");=0A+}=0A+=0A+/*=0A+ * Callback =
when data is received from user mode.=0A+ */=0A+=0A+static void=0A+kvp_cn_c=
allback(struct cn_msg *msg, struct netlink_skb_parms *nsp)=0A+{=0A+	=
struct kvp_msg *message;=0A+=0A+	message =3D (struct kvp_msg =
*)msg->data;=0A+	if (msg->seq =3D=3D KVP_REGISTER)=0A+		=
printk(KERN_WARNING "KVP: user-mode registering done.\n");=0A+=0A+	if =
(msg->seq =3D=3D KVP_USER_SET) {=0A+		/*=0A+		 * =
Complete the transaction by forwarding the key value=0A+		 * =
to the host. But first, cancel the timeout.=0A+		 */=0A+		if =
(del_timer_sync(&kvp_timer))=0A+			kvp_respond_to_host=
(message->kvp_key,=0A+						message->kv=
p_value);=0A+	}=0A+}=0A+=0A+static int=0A+kvp_send_key(int index)=0A+{=0A=
+	struct cn_msg *msg;=0A+=0A+	msg =3D kzalloc(sizeof(*msg) + =
sizeof(kvp_msg_t) , GFP_ATOMIC);=0A+=0A+	if (msg) {=0A+		=
msg->id.idx =3D  CN_KVP_IDX;=0A+		msg->id.val =3D CN_KVP_VAL;=
=0A+		msg->seq =3D KVP_KERNEL_GET;=0A+		((kvp_msg_t=
 *)msg->data)->kvp_key =3D index;=0A+		msg->len =3D sizeof(kvp_msg=
_t);=0A+		cn_netlink_send(msg, 0, GFP_ATOMIC);=0A+		=
kfree(msg);=0A+		return 0;=0A+	}=0A+	return 1;=0A+}=0A+=0A+/*=0A=
+ * Send a response back to the host.=0A+ * key specifies the key for =
which the value is being returned.=0A+ */=0A+=0A+static=0A+void kvp_respond=
_to_host(int key, char *value)=0A+{=0A+	ic_kvp_msg_t *kvp_msg;=0A+	=
ic_kvp_msg_enumerate_t *kvp_data;=0A+	char	*key_name;=0A+	struct =
icmsg_hdr *icmsghdrp;=0A+	int	keylen, valuelen;=0A+	u8	=
*buf;=0A+	u32	buf_len;=0A+	struct vmbus_channel *channel;=0A+	=
u64	req_id;=0A+=0A+	/*=0A+	 * If a transaction is not active; log and =
return.=0A+	 */=0A+=0A+	if (!kvp_transaction_active) {=0A+		=
/*=0A+		 * This is a spurious call!=0A+		 */=0A+		=
printk(KERN_WARNING "KVP: Transaction not active\n");=0A+		=
return;=0A+	}=0A+	/*=0A+	 * Copy the global state for completing =
the transaction. Note that=0A+	 * only one transaction can be active at a =
time.=0A+	 */=0A+=0A+	buf =3D recv_buffer;=0A+	buf_len =
=3D recv_len;=0A+	channel =3D recv_channel;=0A+	req_id =3D =
recv_req_id;=0A+=0A+	kvp_transaction_active =3D false;=0A+=0A+	=
icmsghdrp =3D (struct icmsg_hdr *)&buf[sizeof(struct vmbuspipe_hdr)];=0A+	=
kvp_msg =3D (ic_kvp_msg_t *)&buf[sizeof(struct vmbuspipe_hdr) +=0A+		=
			sizeof(struct icmsg_hdr)];=0A+	kvp_data =3D =
&kvp_msg->kvp_data;=0A+	key_name =3D kvp_keys[key];=0A+=0A+	/*=0A+	 * =
The windows host expects the key/value pair to be encoded=0A+	 * in =
utf16.=0A+	 */=0A+	keylen =3D utf8s_to_utf16s(key_name, strlen(key_nam=
e),=0A+				(wchar_t *)kvp_data->data.key);=0A+	=
kvp_data->data.key_size =3D 2*(keylen + 1); /* utf16 encoding */=0A+	=
valuelen =3D utf8s_to_utf16s(value, strlen(value),=0A+				=
(wchar_t *)kvp_data->data.value);=0A+	kvp_data->data.value_size =3D =
2*(valuelen + 1); /* utf16 encoding */=0A+=0A+	kvp_data->data.value_type =
=3D REG_SZ; /* all our values are strings */=0A+	icmsghdrp->status =
=3D HV_S_OK;=0A+=0A+	icmsghdrp->icflags =3D ICMSGHDRFLAG_TRANSACTION | =
ICMSGHDRFLAG_RESPONSE;=0A+=0A+	vmbus_sendpacket(channel, buf, buf_len, =
req_id,=0A+				VmbusPacketTypeDataInBand, =
0);=0A+=0A+	/*=0A+	 * Free up the buffer that was allocatted when we =
received a message=0A+	 * from the host.=0A+	 */=0A+	kfree(buf);=0A+}=0A=
+=0A+/*=0A+ * This callback is invoked when we get a KVP message from the =
host.=0A+ * The host ensures that only one KVP transaction can be active =
at a time.=0A+ * KVP implementation in Linux needs to forward the key to a =
user-mde=0A+ * component to retrive the corresponding value. Consequently, =
we cannot=0A+ * respond to the host in the conext of this callback. Since =
the host=0A+ * guarantees that at most only one transaction can be active =
at a time,=0A+ * we stash away the transaction state in a set of global =
variables.=0A+ */=0A+=0A+void kvp_onchannelcallback(void *context)=0A+{=0A+=
	struct vmbus_channel *channel =3D context;=0A+	u8 *buf;=0A+	=
u32 buflen, recvlen;=0A+	u64 requestid;=0A+=0A+	ic_kvp_msg_t =
*kvp_msg;=0A+	ic_kvp_msg_enumerate_t *kvp_data;=0A+=0A+	struct =
icmsg_hdr *icmsghdrp;=0A+	struct icmsg_negotiate *negop =3D =
NULL;=0A+=0A+=0A+	buflen =3D PAGE_SIZE;=0A+	buf =3D kmalloc(buf=
len, GFP_ATOMIC);=0A+=0A+	vmbus_recvpacket(channel, buf, buflen, =
&recvlen, &requestid);=0A+=0A+	if (recvlen > 0) {=0A+		DPRINT_DBG(=
VMBUS, "KVP packet: len=3D%d, requestid=3D%lld",=0A+			   =
recvlen, requestid);=0A+=0A+		icmsghdrp =3D (struct icmsg_hdr =
*)&buf[=0A+			sizeof(struct vmbuspipe_hdr)];=0A+=0A+		=
if (icmsghdrp->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {=0A+			=
prep_negotiate_resp(icmsghdrp, negop, buf);=0A+		} else {=0A+		=
	kvp_msg =3D (ic_kvp_msg_t *)&buf[=0A+				=
sizeof(struct vmbuspipe_hdr) +=0A+				sizeof(stru=
ct icmsg_hdr)];=0A+=0A+			kvp_data =3D &kvp_msg->kvp_data;=0A=
+=0A+			/*=0A+			 * We only support the =
"get" operation on=0A+			 * "ICKvpExchangePoolAuto" =
pool.=0A+			 */=0A+=0A+			if =
((kvp_msg->kvp_hdr.pool !=3D ICKvpExchangePoolAuto) ||=0A+			=
	(kvp_msg->kvp_hdr.operation !=3D=0A+				=
ICKvpExchangeOperationEnumerate) ||=0A+				kvp_transac=
tion_active) {=0A+				if (kvp_transaction_active)=
=0A+					printk(KERN_WARNING=0A+			=
			"KVP: Invalid call\n");=0A+				=
icmsghdrp->status =3D HV_E_FAIL;=0A+				goto =
callback_done;=0A+			}=0A+=0A+			=
/*=0A+			 * Stash away this global state for completing =
the=0A+			 * transaction; note transactions are serialized.=
=0A+			 */=0A+			recv_buffer =3D buf;=0A+	=
		recv_len =3D recvlen;=0A+			recv_channe=
l =3D channel;=0A+			recv_req_id =3D requestid;=0A+=0A+	=
		switch (kvp_data->index) {=0A+			case =
(KVP_MAX_KEY):=0A+				/*=0A+				=
 * We don't support this key=0A+				 * and any =
key beyond this.=0A+				 */=0A+				=
icmsghdrp->status =3D HV_E_FAIL;=0A+				goto =
callback_done;=0A+=0A+			case (KVP_LIC_VERSION):=0A+		=
		kvp_transaction_active =3D true;=0A+				=
kvp_respond_to_host(kvp_data->index,=0A+					=
	HV_DRV_VERSION);=0A+				return;=0A+		=
	default:=0A+				/*=0A+				=
 * Get the information from the=0A+				 * =
user-mode component.=0A+				 * component. This =
transaction will be=0A+				 * completed when we get =
the value from=0A+				 * the user-mode component.=
=0A+				 * Set a timeout to deal with=0A+		=
		 * user-mode not responding.=0A+				=
 */=0A+				kvp_current_index =3D kvp_data->index;=0A+	=
			mod_timer(&kvp_timer, jiffies+75);=0A+			=
	kvp_transaction_active =3D true;=0A+				=
kvp_send_key(kvp_data->index);=0A+				return;=0A+=
			}=0A+=0A+		}=0A+=0A+callback_done:=0A+=
=0A+		icmsghdrp->icflags =3D ICMSGHDRFLAG_TRANSACTION=0A+		=
	| ICMSGHDRFLAG_RESPONSE;=0A+=0A+		vmbus_sendpacket(ch=
annel, buf,=0A+				       recvlen, requestid,=0A+		=
		       VmbusPacketTypeDataInBand, 0);=0A+	}=0A+=0A+	=
kfree(buf);=0A+=0A+=0A+}=0A+=0A+int=0A+kvp_init(void)=0A+{=0A+	int =
err;=0A+=0A+	err =3D cn_add_callback(&kvp_id, kvp_name, kvp_cn_callback)=
;=0A+	if (err)=0A+		return err;=0A+=0A+	setup_timer(&kvp_ti=
mer, kvp_timer_func,=0A+		(unsigned long)&kvp_current_index);=
=0A+	return 0;=0A+}=0A+=0A+void kvp_deinit(void)=0A+{=0A+	cn_del_call=
back(&kvp_id);=0A+	del_timer_sync(&kvp_timer);=0A+}=0A+=0AIndex: =
linux.trees.git/drivers/staging/hv/Makefile=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.git.orig/drivers/staging/hv/Make=
file	2010-11-10 14:01:55.000000000 -0500=0A+++ linux.trees.git/drivers/s=
taging/hv/Makefile	2010-11-11 11:24:54.000000000 -0500=0A@@ -2,7 +2,7 =
@@ obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o hv_t=0A obj-$(CONFIG_HYPERV=
_STORAGE)	+=3D hv_storvsc.o=0A obj-$(CONFIG_HYPERV_BLOCK)	+=3D =
hv_blkvsc.o=0A obj-$(CONFIG_HYPERV_NET)	+=3D hv_netvsc.o=0A-obj-$(CONFIG_HY=
PERV_UTILS)	+=3D hv_utils.o=0A+obj-$(CONFIG_HYPERV_UTILS)	+=3D =
hv_util.o=0A =0A hv_vmbus-y :=3D vmbus_drv.o osd.o \=0A 		 =
vmbus.o hv.o connection.o channel.o \=0A@@ -10,3 +10,4 @@ hv_vmbus-y :=3D =
vmbus_drv.o osd.o \=0A hv_storvsc-y :=3D storvsc_drv.o storvsc.o=0A =
hv_blkvsc-y :=3D blkvsc_drv.o blkvsc.o=0A hv_netvsc-y :=3D netvsc_drv.o =
netvsc.o rndis_filter.o=0A+hv_util-y :=3D  hv_utils.o kvp.o=0AIndex: =
linux.trees.git/drivers/staging/hv/kvp.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.000000000 =
+0000=0A+++ linux.trees.git/drivers/staging/hv/kvp.h	2010-11-10 =
14:03:47.000000000 -0500=0A@@ -0,0 +1,101 @@=0A+/*=0A+ * An implementation =
of key value pair (KVP) functionality for Linux.=0A+ *=0A+ *=0A+ * =
Copyright (C) 2010, Novell, Inc.=0A+ * Author : K. Y. Srinivasan <ksrinivas=
an@novell.com>=0A+ *=0A+ * This program is free software; you can =
redistribute it and/or modify it=0A+ * under the terms of the GNU General =
Public License version 2 as published=0A+ * by the Free Software Foundation=
.=0A+ *=0A+ * This program is distributed in the hope that it will be =
useful, but=0A+ * WITHOUT ANY WARRANTY; without even the implied warranty =
of=0A+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE =
or=0A+ * NON INFRINGEMENT.  See the GNU General Public License for =
more=0A+ * details.=0A+ *=0A+ * You should have received a copy of the GNU =
General Public License=0A+ * along with this program; if not, write to the =
Free Software=0A+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, =
MA 02110-1301 USA.=0A+ *=0A+ */=0A+#ifndef	_KVP_H=0A+#define	=
_KVP_H_=0A+=0A+/*=0A+ * Maximum value size - used for both key names and =
value data, and includes=0A+ * any applicable NULL terminators.=0A+ *=0A+ =
* Note:  This limit is somewhat arbitrary, but falls easily within what =
is=0A+ * supported for all native guests (back to Win 2000) and what is =
reasonable=0A+ * for the IC KVP exchange functionality.  Note that Windows =
Me/98/95 are=0A+ * limited to 255 character key names.=0A+ *=0A+ * MSDN =
recommends not storing data values larger than 2048 bytes in the=0A+ * =
registry.=0A+ *=0A+ * Note:  This value is used in defining the KVP =
exchange message - this value=0A+ * cannot be modified without affecting =
the message size and compatability.=0A+ */=0A+=0A+/*=0A+ * bytes, =
including any null terminators=0A+ */=0A+#define IC_KVP_EXCHANGE_MAX_VALUE_=
SIZE          (2048)=0A+=0A+=0A+/*=0A+ * Maximum key size - the registry =
limit for the length of an entry name=0A+ * is 256 characters, including =
the null terminator=0A+ */=0A+=0A+#define IC_KVP_EXCHANGE_MAX_KEY_SIZE     =
       (512)=0A+=0A+=0A+typedef enum {=0A+	ICKvpExchangeOperationGet =
=3D 0,=0A+	ICKvpExchangeOperationSet,=0A+	ICKvpExchangeOperationDelet=
e,=0A+	ICKvpExchangeOperationEnumerate,=0A+	ICKvpExchangeOperationCount=
 /* Number of operations, must be last. */=0A+} IC_KVP_EXCHANGE_OPERATION;=
=0A+=0A+typedef enum {=0A+	ICKvpExchangePoolExternal =3D 0,=0A+	=
ICKvpExchangePoolGuest,=0A+	ICKvpExchangePoolAuto,=0A+	ICKvpExchan=
gePoolAutoExternal,=0A+	ICKvpExchangePoolInternal,=0A+	ICKvpExchangePoolCo=
unt /* Number of pools, must be last. */=0A+} IC_KVP_EXCHANGE_POOL;=0A+=0A+=
typedef struct ic_kvp_hdr {=0A+	u8 operation;=0A+	u8 pool;=0A+} =
ic_kvp_hdr_t;=0A+=0A+typedef struct ic_kvp_exchg_msg_value {=0A+	=
u32 value_type;=0A+	u32 key_size;=0A+	u32 value_size;=0A+	u8 =
key[IC_KVP_EXCHANGE_MAX_KEY_SIZE];=0A+	u8 value[IC_KVP_EXCHANGE_MAX_VALUE_=
SIZE];=0A+} ic_kvp_exchg_msg_value_t;=0A+=0A+typedef struct ic_kvp__msg_enu=
merate {=0A+	u32 index;=0A+	ic_kvp_exchg_msg_value_t data;=0A+} =
ic_kvp_msg_enumerate_t;=0A+=0A+typedef struct ic_kvp_msg {=0A+	ic_kvp_hdr_=
t	kvp_hdr;=0A+	ic_kvp_msg_enumerate_t	kvp_data;=0A+} ic_kvp_msg_t=
;=0A+=0A+int kvp_init(void);=0A+void kvp_deinit(void);=0A+void kvp_onchanne=
lcallback(void *);=0A+=0A+#endif	/* _KVP_H */=0A+=0AIndex: =
linux.trees.git/drivers/staging/hv/utils.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.git.orig/drivers/staging/hv/utils.h=
	2010-11-10 10:30:23.000000000 -0500=0A+++ linux.trees.git/drivers/s=
taging/hv/utils.h	2010-11-10 14:03:47.000000000 -0500=0A@@ -102,6 =
+102,7 @@ struct ictimesync_data{=0A #define HV_SHUTDOWN_MSG		=
0=0A #define HV_TIMESYNC_MSG		1=0A #define HV_HEARTBEAT_MSG	=
2=0A+#define HV_KVP_MSG		3=0A =0A struct hyperv_service_callback =
{=0A 	u8 msg_type;=0AIndex: linux.trees.git/drivers/staging/hv/hv_utils.c=
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.gi=
t.orig/drivers/staging/hv/hv_utils.c	2010-11-10 14:02:40.000000000 =
-0500=0A+++ linux.trees.git/drivers/staging/hv/hv_utils.c	2010-11-11 =
13:42:38.000000000 -0500=0A@@ -37,6 +37,7 @@=0A #include "vmbus_private.h"=
=0A #include "vmbus_api.h"=0A #include "utils.h"=0A+#include "kvp.h"=0A =
=0A =0A static void shutdown_onchannelcallback(void *context)=0A@@ -268,6 =
+269,9 @@ static int __init init_hyperv_utils(void=0A {=0A 	printk(KERN=
_INFO "Registering HyperV Utility Driver\n");=0A =0A+	if (kvp_init())=0A+=
		return -ENODEV;=0A+=0A 	if (!dmi_check_system(hv_utils_dmi_=
table))=0A 		return -ENODEV;=0A =0A@@ -283,6 +287,10 @@ static =
int __init init_hyperv_utils(void=0A 		&heartbeat_onchannelcallbac=
k;=0A 	hv_cb_utils[HV_HEARTBEAT_MSG].callback =3D &heartbeat_onchannelcall=
back;=0A =0A+	hv_cb_utils[HV_KVP_MSG].channel->OnChannelCallback =3D=0A+	=
	&kvp_onchannelcallback;=0A+=0A+=0A 	return 0;=0A }=0A =0A@@ =
-301,6 +309,12 @@ static void exit_hyperv_utils(void)=0A 	hv_cb_utils=
[HV_HEARTBEAT_MSG].channel->OnChannelCallback =3D=0A 		&chn_cb_neg=
otiate;=0A 	hv_cb_utils[HV_HEARTBEAT_MSG].callback =3D &chn_cb_negotiat=
e;=0A+=0A+	hv_cb_utils[HV_KVP_MSG].channel->OnChannelCallback =3D=0A+	=
	&chn_cb_negotiate;=0A+=0A+	kvp_deinit();=0A+=0A }=0A =0A =
module_init(init_hyperv_utils);=0AIndex: linux.trees.git/include/linux/conn=
ector.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- =
linux.trees.git.orig/include/linux/connector.h	2010-11-09 17:22:15.0000000=
00 -0500=0A+++ linux.trees.git/include/linux/connector.h	2010-11-11 =
13:14:52.000000000 -0500=0A@@ -42,8 +42,9 @@=0A #define CN_VAL_DM_USERSPACE=
_LOG		0x1=0A #define CN_IDX_DRBD			0x8=0A =
#define CN_VAL_DRBD			0x1=0A+#define CN_KVP_IDX		=
	0x9     /* MSFT KVP functionality */=0A =0A-#define CN_NETLINK_USER=
S		8=0A+#define CN_NETLINK_USERS		10=0A =0A /*=0A  * =
Maximum connector's message size.=0A
--=__Part5D70C0EE.0__=
Content-Type: application/octet-stream; name="kvp_daemon.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kvp_daemon.c"

LyoKICogQW4gaW1wbGVtZW50YXRpb24gb2Yga2V5IHZhbHVlIHBhaXIgKEtWUCkgZnVuY3Rpb25h
bGl0eSBmb3IgTGludXguCiAqCiAqCiAqIENvcHlyaWdodCAoQykgMjAxMCwgTm92ZWxsLCBJbmMu
CiAqIEF1dGhvciA6IEsuIFkuIFNyaW5pdmFzYW4gPGtzcmluaXZhc2FuQG5vdmVsbC5jb20+CiAq
CiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5IGl0CiAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZAogKiBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLgogKgogKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CiAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKICogTUVSQ0hBTlRBQklMSVRZ
IE9SIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLCBHT09EIFRJVExFIG9yCiAqIE5P
TiBJTkZSSU5HRU1FTlQuICBTZWUgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlCiAqIGRldGFpbHMuCiAqCiAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFt
OyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCiAqIEZvdW5kYXRpb24sIEluYy4s
IDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4K
ICoKICovCgoKI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgoj
aW5jbHVkZSA8c3lzL3BvbGwuaD4KI2luY2x1ZGUgPHN5cy91dHNuYW1lLmg+CiNpbmNsdWRlIDxh
c20vdHlwZXMuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5j
bHVkZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRlIDxsaW51eC9jb25uZWN0b3IuaD4KI2luY2x1ZGUg
PGxpbnV4L25ldGxpbmsuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPGlmYWRk
cnMuaD4KI2luY2x1ZGUgPG5ldGRiLmg+CiNpbmNsdWRlIDxzeXNsb2cuaD4KCi8qCiAqIEtZUzog
VE9ETy4gTmVlZCB0byByZWdpc3RlciB0aGVzZSBpbiB0aGUga2VybmVsLgogKgogKiBUaGUgZm9s
bG93aW5nIGRlZmluaXRpb25zIGFyZSBzaGFyZWQgd2l0aCB0aGUgaW4ta2VybmVsIGNvbXBvbmVu
dDsgZG8gbm90CiAqIGNoYW5nZSBhbnkgb2YgdGhpcyB3aXRob3V0IG1ha2luZyB0aGUgY29ycmVz
cG9uZGluZyBjaGFuZ2VzIGluIAogKiB0aGUgS1ZQIGtlcm5lbCBjb21wb25lbnQuCiAqLwojZGVm
aW5lIENOX0tWUF9JRFgJCTB4OSAgICAgLyogTVNGVCBLVlAgZnVuY3Rpb25hbGl0eSAqLwojZGVm
aW5lIENOX0tWUF9WQUwJCTB4MSAvKiBUaGlzIHN1cHBvcnRzIHF1ZXJpZXMgZnJvbSB0aGUga2Vy
bmVsICovCiNkZWZpbmUgQ05fS1ZQX1VTRVJfVkFMCQkweDIgLyogVGhpcyBzdXBwb3J0cyBxdWVy
aWVzIGZyb20gdGhlIHVzZXIgICovCgovKgogKiBLVlAgcHJvdG9jb2w6IFRoZSB1c2VyIG1vZGUg
Y29tcG9uZW50IGZpcnN0IHJlZ2lzdGVycyB3aXRoIHRoZSAKICogdGhlIGtlcm5lbCBjb21wb25l
bnQuIFN1YnNlcXVlbnRseSwgdGhlIGtlcm5lbCBjb21wb25lbnQgcmVxdWVzdHMsIGRhdGEKICog
Zm9yIHRoZSBzcGVjaWZpZWQga2V5cy4gSW4gcmVzcG9uc2UgdG8gdGhpcyBtZXNzYWdlIHRoZSB1
c2VyIG1vZGUgY29tcG9uZW50CiAqIGZpbGxzIGluIHRoZSB2YWx1ZSBjb3JyZXNwb25kaW5nIHRv
IHRoZSBzcGVjaWZpZWQga2V5LiBXZSBvdmVybG9hZCB0aGUgCiAqIHNlcXVlbmNlIGZpZWxkIGlu
IHRoZSBjbl9tc2cgaGVhZGVyIHRvIGRlZmluZSBvdXIgS1ZQIG1lc3NhZ2UgdHlwZXMuCiAqCiAq
IFdlIHVzZSB0aGlzIGluZnJhc3RydWN0dXJlIGZvciBhbHNvIHN1cHBvcnRpbmcgcXVlcmllcyBm
cm9tIHVzZXIgbW9kZQogKiBhcHBsaWNhdGlvbiBmb3Igc3RhdGUgdGhhdCBtYXkgYmUgbWFpbnRh
aW5lZCBpbiB0aGUgS1ZQIGtlcm5lbCBjb21wb25lbnQuCiAqCiAqIFhYWEtZUzogSGF2ZSBhIHNo
YXJlZCBoZWFkZXIgZmlsZSBiZXR3ZWVuIHRoZSB1c2VyIGFuZCBrZXJuZWwgKFRPRE8pCiAqLwoK
ZW51bSBrdnBfb3AgewoJS1ZQX1JFR0lTVEVSID0gMCwgLyogUmVnaXN0ZXIgdGhlIHVzZXIgbW9k
ZSBjb21wb25lbnQqLwoJS1ZQX0tFUk5FTF9HRVQsIC8qS2VybmVsIGlzIHJlcXVlc3RpbmcgdGhl
IHZhbHVlIGZvciB0aGUgc3BlY2lmaWVkIGtleSovCglLVlBfS0VSTkVMX1NFVCwgLypLZXJuZWwg
aXMgcHJvdmlkaW5nIHRoZSB2YWx1ZSBmb3IgdGhlIHNwZWNpZmllZCBrZXkqLwoJS1ZQX1VTRVJf
R0VULCAvKlVzZXIgaXMgcmVxdWVzdGluZyB0aGUgdmFsdWUgZm9yIHRoZSBzcGVjaWZpZWQga2V5
Ki8KCUtWUF9VU0VSX1NFVCAvKlVzZXIgaXMgcHJvdmlkaW5nIHRoZSB2YWx1ZSBmb3IgdGhlIHNw
ZWNpZmllZCBrZXkqLwp9OwoKI2RlZmluZSBLVlBfS0VZX1NJWkUJNTEyCiNkZWZpbmUgS1ZQX1ZB
TFVFX1NJWkUJMjA0OAoJCnR5cGVkZWYgc3RydWN0IGt2cF9tc2cgewoJX191MzIJa3ZwX2tleTsK
CV9fdTgJa3ZwX3ZhbHVlW0tWUF9WQUxVRV9TSVpFXTsKfSBrdnBfbXNnX3Q7Cgp0eXBlZGVmIGVu
dW0gewoJRnVsbHlRdWFsaWZpZWREb21haW5OYW1lID0gMCwKCUludGVncmF0aW9uU2VydmljZXNW
ZXJzaW9uLCAvKlRoaXMga2V5IGlzIHNlcnZpY2VkIGluIHRoZSBrZXJuZWwqLwoJTmV0d29ya0Fk
ZHJlc3NJUHY0LAoJTmV0d29ya0FkZHJlc3NJUHY2LAoJT1NCdWlsZE51bWJlciwKCU9TTmFtZSwK
CU9TTWFqb3JWZXJzaW9uLAoJT1NNaW5vclZlcnNpb24sCglPU1ZlcnNpb24sCglQcm9jZXNzb3JB
cmNoaXRlY3R1cmUKfSBrdnBfa2V5X25hbWVfdDsKIAovKgogKiBFbmQgb2Ygc2hhcmVkIGRlZmlu
aXRpb25zLgogKi8KCnN0YXRpYyBjaGFyIGt2cF9zZW5kX2J1ZmZlcls0MDk2XTsKc3RhdGljIGNo
YXIga3ZwX3JlY3ZfYnVmZmVyWzQwOTZdOwpzdGF0aWMgc3RydWN0IHNvY2thZGRyX25sIGFkZHI7
CgpzdGF0aWMgY2hhciBvc19uYW1lWzEwMF07CnN0YXRpYyBjaGFyIG9zX21ham9yWzUwXTsKc3Rh
dGljIGNoYXIgb3NfbWlub3JbNTBdOwpzdGF0aWMgY2hhciBwcm9jZXNzb3JfYXJjaFs1MF07CnN0
YXRpYyBjaGFyIG9zX2J1aWxkWzEwMF07Cgp2b2lkIGt2cF9nZXRfb3NfaW5mbyh2b2lkKQp7CglG
SUxFCSpmaWxlOwoJY2hhcgkqZW9sOwoJc3RydWN0IHV0c25hbWUgYnVmOwoKCXVuYW1lKCZidWYp
OwoJc3RyY3B5KG9zX2J1aWxkLCBidWYucmVsZWFzZSk7CglzdHJjcHkocHJvY2Vzc29yX2FyY2gs
IGJ1Zi5tYWNoaW5lKTsKCglpZiAoKGZpbGUgPSBmb3BlbigiL2V0Yy9TdVNFLXJlbGVhc2UiLCAi
ciIpKSAhPSBOVUxMKQoJCWdvdG8ga3ZwX29zaW5mb19mb3VuZDsKCWlmICgoZmlsZSAgPSBmb3Bl
bigiL2V0Yy9TdVNFLXJlbGVhc2UiLCAiciIpKSAhPSBOVUxMKQoJCWdvdG8ga3ZwX29zaW5mb19m
b3VuZDsKCS8qCgkgKiBBZGQgY29kZSBmb3Igb3RoZXIgc3VwcG9ydGVkIHBsYXRmb3Jtcy4KCSAq
LwoKCS8qCgkgKiBXZSBkb24ndCBoYXZlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBvcy4KCSAqLwoJ
c3RyY3B5KG9zX25hbWUsICJMaW51eCIpOwoJc3RyY3B5KG9zX21ham9yLCAiMCIpOwoJc3RyY3B5
KG9zX21pbm9yLCAiMCIpOwoJcmV0dXJuOwoKa3ZwX29zaW5mb19mb3VuZDoKCWZnZXRzKG9zX25h
bWUsIDk5LCBmaWxlKTsKCWVvbCA9IGluZGV4KG9zX25hbWUsICdcbicpOwoJKmVvbCA9ICdcMCc7
CglmZ2V0cyhvc19tYWpvciwgNDksIGZpbGUpOwoJZW9sID0gaW5kZXgob3NfbWFqb3IsICdcbicp
OwoJKmVvbCA9ICdcMCc7CglmZ2V0cyhvc19taW5vciwgNDksIGZpbGUpOwoJZW9sID0gaW5kZXgo
b3NfbWlub3IsICdcbicpOwoJKmVvbCA9ICdcMCc7CglmY2xvc2UoZmlsZSk7CglyZXR1cm47Cn0K
CQpzdGF0aWMgaW50Cmt2cF9nZXRfaXBfYWRkcmVzcyhpbnQgZmFtaWx5LCBjaGFyICpidWZmZXIs
IGludCBsZW5ndGgpCnsKCXN0cnVjdCBpZmFkZHJzICppZmFwOwoJc3RydWN0IGlmYWRkcnMgKmN1
cnA7CglpbnQgaXB2NF9sZW4gPSBzdHJsZW4oIjI1NS4yNTUuMjU1LjI1NSIpICsgMTsKCWludCBp
cHY2X2xlbiA9IHN0cmxlbigiZmZmZjpmZmZmOmZmZmY6ZmZmZjpmZmZmOmZmZmY6ZmZmZjpmZmZm
IikrMTsgCglpbnQgb2Zmc2V0ID0gMDsKCWNvbnN0IGNoYXIgKnN0cjsKCWNoYXIgdG1wWzUwXTsK
CWludCBlcnJvciA9IDA7CgoJLyoKCSAqIE9uIGVudHJ5IGludG8gdGhpcyBmdW5jdGlvbiwgdGhl
IGJ1ZmZlciBpcyBjYXBhYmxlIG9mIGhvbGRpbmcgdGhlCgkgKiBtYXhpbXVtIGtleSB2YWx1ZSAo
MjA0OCBieXRlcykuCgkgKi8KCQoJaWYgKGdldGlmYWRkcnMoJmlmYXApKSB7CgkJc3RyY3B5KGJ1
ZmZlciwgImdldGlmYWRkcnMgZmFpbGVkXG4iKTsKCQlyZXR1cm4gMTsKCX0KCgljdXJwID0gaWZh
cDsKCXdoaWxlIChjdXJwICE9IE5VTEwpIHsKCQlpZiAoKGN1cnAtPmlmYV9hZGRyICE9IE5VTEwp
ICYmICAKCQkgICAoY3VycC0+aWZhX2FkZHItPnNhX2ZhbWlseSA9PSBmYW1pbHkpKSB7CgkJCWlm
IChmYW1pbHkgPT0gQUZfSU5FVCkgewoJCQkJc3RydWN0IHNvY2thZGRyX2luICphZGRyID0gCgkJ
CQkoc3RydWN0IHNvY2thZGRyX2luICopIGN1cnAtPmlmYV9hZGRyOwoKCQkJCWlmICghKHN0ciA9
IGluZXRfbnRvcChmYW1pbHksICZhZGRyLT5zaW5fYWRkciwgCgkJCQkJdG1wLCA1MCkpKSB7CgkJ
CQkJc3RyY3B5KGJ1ZmZlciwgImluZXRfbnRvcCBmYWlsZWRcbiIpOwoJCQkJCWVycm9yID0gMTsK
CQkJCQlnb3RvIGdldGFkZHJfZG9uZTsKCQkJCX0KCQkJCWlmIChvZmZzZXQgPT0gMCkgCgkJCQkJ
c3RyY3B5KGJ1ZmZlciwgdG1wKTsKCQkJCWVsc2UgCgkJCQkJc3RyY2F0KGJ1ZmZlciwgdG1wKTsK
CQkJCXN0cmNhdChidWZmZXIsICI7Iik7CgkJCQkKCQkJCW9mZnNldCArPSBzdHJsZW4oc3RyKSAr
MTsKCQkJCWlmICgobGVuZ3RoIC0gb2Zmc2V0KSA8IChpcHY0X2xlbiArIDEpKSB7CgkJCQkJZ290
byBnZXRhZGRyX2RvbmU7CgkJCQl9CgkJCX0gZWxzZSB7CgkJCS8qCgkJIAkgKiBXZSBvbmx5IHN1
cHBvcnQgQUZfSU5FVCBhbmQgQUZfSU5FVDYKCQkJICogYW5kIHRoZSBsaXN0IG9mIGFkZHJlc3Nl
cyBpcyBzZXBlcmF0ZWQgYnkgYSAiOyIuCgkJCSAqLwoJCQkJc3RydWN0IHNvY2thZGRyX2luNiAq
YWRkciA9IAoJCQkJKHN0cnVjdCBzb2NrYWRkcl9pbjYgKikgY3VycC0+aWZhX2FkZHI7CgoJCQkJ
aWYgKCEoc3RyID0gaW5ldF9udG9wKGZhbWlseSwKCQkJCQkmYWRkci0+c2luNl9hZGRyLnM2X2Fk
ZHIsCgkJCQkJdG1wLCA1MCkpKSB7CgkJCQkJc3RyY3B5KGJ1ZmZlciwgImluZXRfbnRvcCBmYWls
ZWRcbiIpOwoJCQkJCWVycm9yID0gMTsKCQkJCQlnb3RvIGdldGFkZHJfZG9uZTsKCQkJCX0KCQkJ
CWlmIChvZmZzZXQgPT0gMCkgCgkJCQkJc3RyY3B5KGJ1ZmZlciwgdG1wKTsKCQkJCWVsc2UgCgkJ
CQkJc3RyY2F0KGJ1ZmZlciwgdG1wKTsKCQkJCXN0cmNhdChidWZmZXIsICI7Iik7CgkJCQlvZmZz
ZXQgKz0gc3RybGVuKHN0cikgKzE7CgkJCQlpZiAoKGxlbmd0aCAtIG9mZnNldCkgPCAoaXB2Nl9s
ZW4gKzEpKSB7CgkJCQkJZ290byBnZXRhZGRyX2RvbmU7CgkJCQl9CgkJCX0KCQkJCQoJCX0KCQlj
dXJwID0gY3VycC0+aWZhX25leHQ7Cgl9CgpnZXRhZGRyX2RvbmU6CglmcmVlaWZhZGRycyhpZmFw
KTsKCXJldHVybiBlcnJvcjsKfQoKCnN0YXRpYyBpbnQKa3ZwX2dldF9kb21haW5fbmFtZShjaGFy
ICpidWZmZXIsIGludCBsZW5ndGgpCnsKCXN0cnVjdCBhZGRyaW5mbwloaW50cywgKmluZm8gOwoJ
Z2V0aG9zdG5hbWUoYnVmZmVyLCBsZW5ndGgpOwoJaW50IGVycm9yID0wOwoKCW1lbXNldCgmaGlu
dHMsIDAsIHNpemVvZihoaW50cykpOwoJaGludHMuYWlfZmFtaWx5ID0gQUZfSU5FVDsgLypHZXQg
b25seSBpcHY0IGFkZHJpbmZvLiAqLwoJaGludHMuYWlfc29ja3R5cGUgPSBTT0NLX1NUUkVBTTsK
CWhpbnRzLmFpX2ZsYWdzID0gQUlfQ0FOT05OQU1FOwoJCglpZiAoKGVycm9yID0gZ2V0YWRkcmlu
Zm8oYnVmZmVyLCAiaHR0cCIsICZoaW50cywgJmluZm8pKSAhPTApIHsKCQlzdHJjcHkoYnVmZmVy
LCAiZ2V0YWRkcmluZm8gZmFpbGVkXG4iKTsKCQllcnJvciA9IDE7CgkJZ290byBnZXRfZG9tYWlu
X2RvbmU7Cgl9CglzdHJjcHkoYnVmZmVyLCBpbmZvLT5haV9jYW5vbm5hbWUpOwpnZXRfZG9tYWlu
X2RvbmU6CglmcmVlYWRkcmluZm8oaW5mbyk7CglyZXR1cm4gKGVycm9yKTsKfQoKc3RhdGljIGlu
dCAKbmV0bGlua19zZW5kKGludCBmZCwgc3RydWN0IGNuX21zZyAqbXNnKQp7CglzdHJ1Y3Qgbmxt
c2doZHIgKm5saDsKCXVuc2lnbmVkIGludCBzaXplOwoJc3RydWN0IG1zZ2hkciBtZXNzYWdlOwoJ
Y2hhciBidWZmZXJbNjRdOwoJc3RydWN0IGlvdmVjIGlvdlsyXTsKCglzaXplID0gTkxNU0dfU1BB
Q0Uoc2l6ZW9mKHN0cnVjdCBjbl9tc2cpICsgbXNnLT5sZW4pOwoKCW5saCA9IChzdHJ1Y3Qgbmxt
c2doZHIgKilidWZmZXI7CglubGgtPm5sbXNnX3NlcSA9IDA7CglubGgtPm5sbXNnX3BpZCA9IGdl
dHBpZCgpOwoJbmxoLT5ubG1zZ190eXBlID0gTkxNU0dfRE9ORTsKCW5saC0+bmxtc2dfbGVuID0g
TkxNU0dfTEVOR1RIKHNpemUgLSBzaXplb2YoKm5saCkpOwoJbmxoLT5ubG1zZ19mbGFncyA9IDA7
CgkKCWlvdlswXS5pb3ZfYmFzZSA9IG5saDsKCWlvdlswXS5pb3ZfbGVuID0gc2l6ZW9mKCpubGgp
OwoKCWlvdlsxXS5pb3ZfYmFzZSA9IG1zZzsKCWlvdlsxXS5pb3ZfbGVuID0gc2l6ZTsKCgltZW1z
ZXQoJm1lc3NhZ2UsIDAsIHNpemVvZihtZXNzYWdlKSk7CgltZXNzYWdlLm1zZ19uYW1lID0gJmFk
ZHI7CgltZXNzYWdlLm1zZ19uYW1lbGVuID0gc2l6ZW9mKGFkZHIpOyAKCW1lc3NhZ2UubXNnX2lv
diA9IGlvdjsKCW1lc3NhZ2UubXNnX2lvdmxlbiA9IDI7CgoJcmV0dXJuIChzZW5kbXNnKGZkLCAm
bWVzc2FnZSwgMCkpOwp9CgptYWluKHZvaWQpCnsKCWludCBmZCwgbGVuLCBzb2NrX29wdDsKCWlu
dCBlcnJvcjsKCXN0cnVjdCBjbl9tc2cgKm1lc3NhZ2U7CglzdHJ1Y3QgcG9sbGZkIHBmZDsKCXN0
cnVjdCBubG1zZ2hkciAqaW5jb21pbmdfbXNnOwoJc3RydWN0IGNuX21zZwkqaW5jb21pbmdfY25f
bXNnOwoJY2hhcgkqa2V5X3ZhbHVlOwoJa3ZwX2tleV9uYW1lX3Qga2V5X25hbWU7CgoJZGFlbW9u
KDEsIDApOwoJb3BlbmxvZygiS1ZQIiwgMCwgTE9HX1VTRVIpOwoJc3lzbG9nKExPR19JTkZPLCAi
S1ZQIHN0YXJ0aW5nOyBwaWQgaXM6JWQiLCBnZXRwaWQoKSk7CgkvKgoJICogUmV0cmlldmUgT1Mg
cmVsZWFzZSBpbmZvcm1hdGlvbi4KCSAqLwoJa3ZwX2dldF9vc19pbmZvKCk7CgoJZmQgPSBzb2Nr
ZXQoQUZfTkVUTElOSywgU09DS19ER1JBTSwgTkVUTElOS19DT05ORUNUT1IpOwoJaWYgKGZkIDwg
MCkgewoJCXN5c2xvZyhMT0dfRVJSLCAibmV0bGluayBzb2NrZXQgY3JlYXRpb24gZmFpbGVkOyBl
cnJvcjolZCIsZmQpOwoJCWV4aXQgLTE7Cgl9CglhZGRyLm5sX2ZhbWlseSA9IEFGX05FVExJTks7
CglhZGRyLm5sX3BhZCA9IDA7CglhZGRyLm5sX3BpZCA9IDA7CglhZGRyLm5sX2dyb3VwcyA9IENO
X0tWUF9JRFg7CgoKCWlmICgoZXJyb3IgPSBiaW5kKGZkLCAoc3RydWN0IHNvY2thZGRyICopJmFk
ZHIsIHNpemVvZihhZGRyKSkpIDwgMCkgewoJCXN5c2xvZyhMT0dfRVJSLCAiYmluZCBmYWlsZWQ7
IGVycm9yOiVkIixlcnJvcik7CgkJY2xvc2UoZmQpOwoJCWV4aXQgLTE7Cgl9Cglzb2NrX29wdCA9
IGFkZHIubmxfZ3JvdXBzOwoJc2V0c29ja29wdChmZCwgMjcwLCAxLCAmc29ja19vcHQsIHNpemVv
Zihzb2NrX29wdCkpOwoJLyoKCSAqIFJlZ2lzdGVyIG91cnNlbHZlcyB3aXRoIHRoZSBrZXJuZWwu
CgkgKi8KCW1lc3NhZ2UgPSAoc3RydWN0IGNuX21zZyAqKWt2cF9zZW5kX2J1ZmZlcjsKCW1lc3Nh
Z2UtPmlkLmlkeCA9IENOX0tWUF9JRFg7CgltZXNzYWdlLT5pZC52YWwgPSBDTl9LVlBfVkFMOwoJ
bWVzc2FnZS0+c2VxID0gS1ZQX1JFR0lTVEVSOwoJbWVzc2FnZS0+YWNrID0gMDsKCW1lc3NhZ2Ut
PmxlbiA9IDA7CgoJbGVuID0gbmV0bGlua19zZW5kKGZkLCBtZXNzYWdlKTsKCWlmIChsZW4gPCAw
KSB7CgkJc3lzbG9nKExPR19FUlIsICJuZXRsaW5rX3NlbmQgZmFpbGVkOyBlcnJvcjolZCIsIGxl
bik7CgkJY2xvc2UoZmQpOwoJCWV4aXQgLTE7Cgl9CgkKCXBmZC5mZCA9IGZkOwoJCgl3aGlsZSAo
MSkgewoJCXBmZC5ldmVudHMgPSBQT0xMSU47CgkJcGZkLnJldmVudHMgPSAwOwoJCXBvbGwoJnBm
ZCwgMSwgLTEpOwoKCQlsZW4gPSByZWN2KGZkLCBrdnBfcmVjdl9idWZmZXIsIHNpemVvZihrdnBf
cmVjdl9idWZmZXIpLCAwKTsKCgkJaWYgKGxlbiA8IDApIHsKCQkJc3lzbG9nKExPR19FUlIsICJy
ZWN2IGZhaWxlZDsgZXJyb3I6JWQiLCBsZW4pOwoJCQljbG9zZShmZCk7CgkJCXJldHVybiAtMTsK
CQl9CgkKCQlpbmNvbWluZ19tc2cgPSAoc3RydWN0IG5sbXNnaGRyICopa3ZwX3JlY3ZfYnVmZmVy
OwoJCWluY29taW5nX2NuX21zZyA9IChzdHJ1Y3QgY25fbXNnICopTkxNU0dfREFUQShpbmNvbWlu
Z19tc2cpOwoKCQlpZiAoaW5jb21pbmdfY25fbXNnLT5zZXEgIT0gS1ZQX0tFUk5FTF9HRVQpIHsK
CQkJY29udGludWU7CgkJfQoKCQlrZXlfbmFtZSA9IAoJCSgoc3RydWN0IGt2cF9tc2cgKilpbmNv
bWluZ19jbl9tc2ctPmRhdGEpLT5rdnBfa2V5OwoJCWtleV92YWx1ZSA9CgkJKChzdHJ1Y3Qga3Zw
X21zZyAqKWluY29taW5nX2NuX21zZy0+ZGF0YSktPmt2cF92YWx1ZTsKCgkJc3dpdGNoIChrZXlf
bmFtZSkgewoJCQljYXNlIEZ1bGx5UXVhbGlmaWVkRG9tYWluTmFtZToKCQkJCWt2cF9nZXRfZG9t
YWluX25hbWUoa2V5X3ZhbHVlLCBLVlBfVkFMVUVfU0laRSk7CgkJCQlicmVhazsKCQkJY2FzZSBO
ZXR3b3JrQWRkcmVzc0lQdjQ6CgkJCQlrdnBfZ2V0X2lwX2FkZHJlc3MoQUZfSU5FVCwga2V5X3Zh
bHVlLCAKCQkJCQkJS1ZQX1ZBTFVFX1NJWkUpOwoJCQkJYnJlYWs7CgkJCWNhc2UgTmV0d29ya0Fk
ZHJlc3NJUHY2OgoJCQkJa3ZwX2dldF9pcF9hZGRyZXNzKEFGX0lORVQ2LCBrZXlfdmFsdWUsIAoJ
CQkJCQlLVlBfVkFMVUVfU0laRSk7CgkJCQlicmVhazsKCQkJY2FzZSBPU0J1aWxkTnVtYmVyOgoJ
CQkJc3RyY3B5KGtleV92YWx1ZSwgb3NfYnVpbGQpOwoJCQkJYnJlYWs7CgkJCWNhc2UgT1NOYW1l
OgoJCQkJc3RyY3B5KGtleV92YWx1ZSwgb3NfbmFtZSk7CgkJCQlicmVhazsKCQkJY2FzZSBPU01h
am9yVmVyc2lvbjoKCQkJCXN0cmNweShrZXlfdmFsdWUsIG9zX21ham9yKTsKCQkJCWJyZWFrOwoJ
CQljYXNlIE9TTWlub3JWZXJzaW9uOgoJCQkJc3RyY3B5KGtleV92YWx1ZSwgb3NfbWlub3IpOwoJ
CQkJYnJlYWs7CgkJCWNhc2UgT1NWZXJzaW9uOgoJCQkJc3RyY3B5KGtleV92YWx1ZSwgb3NfYnVp
bGQpOwoJCQkJYnJlYWs7CgkJCWNhc2UgUHJvY2Vzc29yQXJjaGl0ZWN0dXJlOgoJCQkJc3RyY3B5
KGtleV92YWx1ZSwgcHJvY2Vzc29yX2FyY2gpOwoJCQkJYnJlYWs7CgkJCWRlZmF1bHQ6CQoJCQkJ
c3RyY3B5KGtleV92YWx1ZSwgIlVua25vd24gS2V5Iik7CgkJCQlicmVhazsKCQl9CgkJLyoKCQkg
KiBTZW5kIHRoZSB2YWx1ZSBiYWNrIHRvIHRoZSBrZXJuZWwuIFRoZSByZXNwb25zZSBpcyAKCQkg
KiBhbHJlYWR5IGluIHRoZSByZWNlaXZlIGJ1ZmZlci4gVXBkYXRlIHRoZSBjbl9tc2cgaGVhZGVy
IHRvIAoJCSAqIHJlZmxlY3QgdGhlIGtleSB2YWx1ZSB0aGF0IGhhcyBiZWVuIGFkZGVkIHRvIHRo
ZSBtZXNzYWdlCgkJICovCgoJCWluY29taW5nX2NuX21zZy0+aWQuaWR4ID0gQ05fS1ZQX0lEWDsK
CQlpbmNvbWluZ19jbl9tc2ctPmlkLnZhbCA9IENOX0tWUF9WQUw7CgkJaW5jb21pbmdfY25fbXNn
LT5zZXEgPSBLVlBfVVNFUl9TRVQ7IAoJCWluY29taW5nX2NuX21zZy0+YWNrID0gMDsKCQlpbmNv
bWluZ19jbl9tc2ctPmxlbiA9IEtWUF9LRVlfU0laRSArIHN0cmxlbihrZXlfdmFsdWUpOwoKCQls
ZW4gPSBuZXRsaW5rX3NlbmQoZmQsIGluY29taW5nX2NuX21zZyk7CgkJaWYgKGxlbiA8IDApIHsK
CQkJc3lzbG9nKExPR19FUlIsICJuZXRfbGluayBzZW5kIGZhaWxlZDsgZXJyb3I6JWQiLCBsZW4p
OwoJCQlleGl0IC0xOwoJCX0KCX0KCn0K

--=__Part5D70C0EE.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__Part5D70C0EE.0__=--
