From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 3/3]: An implementation of HyperV KVP functionality
Date: Mon, 22 Nov 2010 13:45:37 -0700
Message-ID: <4CEA74010200003000090BD0@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7954D261.0__="
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
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

--=__Part7954D261.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

An implementation of key/value pair feature (KVP) for Linux  on HyperV. In =
this version of the patch I have addressed all the comments I have =
received to date. I have also included the code for the user-level daemon =
here for your reference.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>




--=__Part7954D261.0__=
Content-Type: text/plain; name="hv_kvp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hv_kvp.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0ASubject: An implementa=
tion of key/value pair feature (KVP) for Linux =0Aon HyperV.=0A=0ASigned-of=
f-by: K. Y. Srinivasan <ksrinivasan@novell.com> =0A=0AIndex: linux.trees.gi=
t/drivers/staging/hv/Makefile=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A--- linux.trees.git.orig/drivers/staging/hv/Makefile	=
2010-11-19 17:57:16.000000000 -0500=0A+++ linux.trees.git/drivers/staging/h=
v/Makefile	2010-11-19 17:57:17.000000000 -0500=0A@@ -10,4 +10,4 @@ =
hv_vmbus-y :=3D vmbus_drv.o osd.o \=0A hv_storvsc-y :=3D storvsc_drv.o =
storvsc.o=0A hv_blkvsc-y :=3D blkvsc_drv.o blkvsc.o=0A hv_netvsc-y :=3D =
netvsc_drv.o netvsc.o rndis_filter.o=0A-hv_utils-y :=3D hv_util.o=0A+hv_uti=
ls-y :=3D hv_util.o hv_kvp.o=0AIndex: linux.trees.git/drivers/staging/hv/ut=
ils.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- =
linux.trees.git.orig/drivers/staging/hv/utils.h	2010-11-19 17:30:48.0000000=
00 -0500=0A+++ linux.trees.git/drivers/staging/hv/utils.h	2010-11-19 =
17:57:17.000000000 -0500=0A@@ -102,6 +102,7 @@ struct ictimesync_data{=0A =
#define HV_SHUTDOWN_MSG		0=0A #define HV_TIMESYNC_MSG		=
1=0A #define HV_HEARTBEAT_MSG	2=0A+#define HV_KVP_MSG		3=0A =0A =
struct hyperv_service_callback {=0A 	u8 msg_type;=0AIndex: linux.trees.g=
it/drivers/staging/hv/hv_kvp.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.000000000 +0000=0A+++ =
linux.trees.git/drivers/staging/hv/hv_kvp.c	2010-11-19 18:02:21.0000000=
00 -0500=0A@@ -0,0 +1,356 @@=0A+/*=0A+ * An implementation of key value =
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
<linux/nls.h>=0A+#include <linux/connector.h>=0A+#include <linux/workqueue.=
h>=0A+=0A+#include "logging.h"=0A+#include "osd.h"=0A+#include "vmbus.h"=0A=
+#include "vmbus_packet_format.h"=0A+#include "vmbus_channel_interface.h"=
=0A+#include "version_info.h"=0A+#include "channel.h"=0A+#include =
"vmbus_private.h"=0A+#include "vmbus_api.h"=0A+#include "utils.h"=0A+#inclu=
de "hv_kvp.h"=0A+=0A+=0A+=0A+/*=0A+ * Global state maintained for =
transaction that is being processed.=0A+ * Note that only one transaction =
can be active at any point in time.=0A+ *=0A+ * This state is set when we =
receive a request from the host; we=0A+ * cleanup this state when the =
transaction is completed - when we respond=0A+ * to the host with the key =
value.=0A+ */=0A+=0A+static struct {=0A+	bool active; /* transaction=
 status - active or not */=0A+	u8 *recv_buffer; /* the receive buffer =
that we allocated */=0A+	int recv_len; /* number of bytes received. =
*/=0A+	struct vmbus_channel *recv_channel; /* chn we got the request =
*/=0A+	u64 recv_req_id; /* request ID. */=0A+} kvp_transaction;=0A+=0A+sta=
tic int kvp_send_key(int index);=0A+=0A+static void kvp_respond_to_host(cha=
r *key, char *value, int error);=0A+static void kvp_work_func(struct =
work_struct *dummy);=0A+static void kvp_register(void);=0A+=0A+static =
DECLARE_DELAYED_WORK(kvp_work, kvp_work_func);=0A+=0A+static struct cb_id =
kvp_id =3D { CN_KVP_IDX, CN_KVP_VAL };=0A+static const char kvp_name[] =3D =
"kvp_kernel_module";=0A+static int timeout_fired;=0A+=0A+/*=0A+ * Register =
the kernel component with the user-level daemon.=0A+ * As part of this =
registration, pass the LIC version number.=0A+ */=0A+=0A+static void=0A+kvp=
_register(void)=0A+{=0A+=0A+	struct cn_msg *msg;=0A+=0A+	msg =3D =
kzalloc(sizeof(*msg) + strlen(HV_DRV_VERSION) + 1 , GFP_ATOMIC);=0A+=0A+	=
if (msg) {=0A+		msg->id.idx =3D  CN_KVP_IDX;=0A+		=
msg->id.val =3D CN_KVP_VAL;=0A+		msg->seq =3D KVP_REGISTER;=0A+		=
strcpy(msg->data, HV_DRV_VERSION);=0A+		msg->len =3D strlen(HV_DRV_=
VERSION) + 1;=0A+		cn_netlink_send(msg, 0, GFP_ATOMIC);=0A+	=
	kfree(msg);=0A+	}=0A+}=0A+static void=0A+kvp_work_func(struct =
work_struct *dummy)=0A+{=0A+	/*=0A+	 * If the timer fires, the =
user-mode component has not responded;=0A+	 * process the pending =
transaction.=0A+	 */=0A+	kvp_respond_to_host("Unknown key", "Guest =
timed out", timeout_fired);=0A+	timeout_fired =3D 1;=0A+}=0A+=0A+/*=0A+ * =
Callback when data is received from user mode.=0A+ */=0A+=0A+static =
void=0A+kvp_cn_callback(struct cn_msg *msg, struct netlink_skb_parms =
*nsp)=0A+{=0A+	struct hv_ku_msg *message;=0A+=0A+	message =3D =
(struct hv_ku_msg *)msg->data;=0A+	if (msg->seq =3D=3D KVP_REGISTER) =
{=0A+		printk(KERN_INFO "KVP: user-mode registering done.\n");=0A+=
		kvp_register();=0A+	}=0A+=0A+	if (msg->seq =
=3D=3D KVP_USER_SET) {=0A+		/*=0A+		 * Complete the =
transaction by forwarding the key value=0A+		 * to the host. =
But first, cancel the timeout.=0A+		 */=0A+		if =
(cancel_delayed_work_sync(&kvp_work))=0A+			kvp_respond=
_to_host(message->kvp_key,=0A+						=
message->kvp_value,=0A+						!strlen(mes=
sage->kvp_key));=0A+	}=0A+}=0A+=0A+static int=0A+kvp_send_key(int =
index)=0A+{=0A+	struct cn_msg *msg;=0A+=0A+	msg =3D kzalloc(sizeof(*msg=
) + sizeof(struct hv_kvp_msg) , GFP_ATOMIC);=0A+=0A+	if (msg) {=0A+		=
msg->id.idx =3D  CN_KVP_IDX;=0A+		msg->id.val =3D CN_KVP_VAL;=
=0A+		msg->seq =3D KVP_KERNEL_GET;=0A+		((struct =
hv_ku_msg *)msg->data)->kvp_index =3D index;=0A+		msg->len =
=3D sizeof(struct hv_ku_msg);=0A+		cn_netlink_send(msg, 0, =
GFP_ATOMIC);=0A+		kfree(msg);=0A+		return 0;=0A+	=
}=0A+	return 1;=0A+}=0A+=0A+/*=0A+ * Send a response back to the =
host.=0A+ */=0A+=0A+static void=0A+kvp_respond_to_host(char *key, char =
*value, int error)=0A+{=0A+	struct hv_kvp_msg  *kvp_msg;=0A+	=
struct hv_kvp_msg_enumerate  *kvp_data;=0A+	char	*key_name;=0A+	=
struct icmsg_hdr *icmsghdrp;=0A+	int	keylen, valuelen;=0A+	u8	=
*buf;=0A+	u32	buf_len;=0A+	struct vmbus_channel *channel;=0A+	=
u64	req_id;=0A+=0A+	/*=0A+	 * If a transaction is not active; log and =
return.=0A+	 */=0A+=0A+	if (!kvp_transaction.active) {=0A+		=
/*=0A+		 * This is a spurious call!=0A+		 */=0A+		=
printk(KERN_WARNING "KVP: Transaction not active\n");=0A+		=
return;=0A+	}=0A+	/*=0A+	 * Copy the global state for completing =
the transaction. Note that=0A+	 * only one transaction can be active at a =
time.=0A+	 */=0A+=0A+	buf =3D kvp_transaction.recv_buffer;=0A+	=
buf_len =3D kvp_transaction.recv_len;=0A+	channel =3D kvp_transaction=
.recv_channel;=0A+	req_id =3D kvp_transaction.recv_req_id;=0A+	=
kvp_transaction.active =3D false;=0A+=0A+	icmsghdrp =3D (struct =
icmsg_hdr *)&buf[sizeof(struct vmbuspipe_hdr)];=0A+	kvp_msg =3D =
(struct hv_kvp_msg *)&buf[sizeof(struct vmbuspipe_hdr) +=0A+			=
		sizeof(struct icmsg_hdr)];=0A+	kvp_data =3D &kvp_msg->kvp_=
data;=0A+	key_name =3D key;=0A+=0A+	/*=0A+	 * If the error =
parameter is set, terminate the host's enumeration.=0A+	 */=0A+	if (error) =
{=0A+		/*=0A+		 * We don't support this index or the we =
have timedout;=0A+		 * terminate the host-side iteration by =
returning an error.=0A+		 */=0A+		icmsghdrp->status =3D =
HV_E_FAIL;=0A+		goto response_done;=0A+	}=0A+=0A+	/*=0A+	 * =
The windows host expects the key/value pair to be encoded=0A+	 * in =
utf16.=0A+	 */=0A+	keylen =3D utf8s_to_utf16s(key_name, strlen(key_nam=
e),=0A+				(wchar_t *)kvp_data->data.key);=0A+	=
kvp_data->data.key_size =3D 2*(keylen + 1); /* utf16 encoding */=0A+	=
valuelen =3D utf8s_to_utf16s(value, strlen(value),=0A+				=
(wchar_t *)kvp_data->data.value);=0A+	kvp_data->data.value_size =3D =
2*(valuelen + 1); /* utf16 encoding */=0A+=0A+	kvp_data->data.value_type =
=3D REG_SZ; /* all our values are strings */=0A+	icmsghdrp->status =
=3D HV_S_OK;=0A+=0A+response_done:=0A+	icmsghdrp->icflags =3D ICMSGHDRFLAG=
_TRANSACTION | ICMSGHDRFLAG_RESPONSE;=0A+=0A+	vmbus_sendpacket(channel, =
buf, buf_len, req_id,=0A+				VmbusPacketTypeData=
InBand, 0);=0A+=0A+	/*=0A+	 * Free up the buffer that was allocatted =
when we received a message=0A+	 * from the host.=0A+	 */=0A+	kfree(buf);=
=0A+}=0A+=0A+/*=0A+ * This callback is invoked when we get a KVP message =
from the host.=0A+ * The host ensures that only one KVP transaction can be =
active at a time.=0A+ * KVP implementation in Linux needs to forward the =
key to a user-mde=0A+ * component to retrive the corresponding value. =
Consequently, we cannot=0A+ * respond to the host in the conext of this =
callback. Since the host=0A+ * guarantees that at most only one transaction=
 can be active at a time,=0A+ * we stash away the transaction state in a =
set of global variables.=0A+ */=0A+=0A+void hv_kvp_onchannelcallback(void =
*context)=0A+{=0A+	struct vmbus_channel *channel =3D context;=0A+	u8 =
*buf;=0A+	u32 buflen, recvlen;=0A+	u64 requestid;=0A+=0A+	=
struct hv_kvp_msg *kvp_msg;=0A+	struct hv_kvp_msg_enumerate *kvp_data;=0A+=
=0A+	struct icmsg_hdr *icmsghdrp;=0A+	struct icmsg_negotiate =
*negop =3D NULL;=0A+=0A+=0A+	buflen =3D PAGE_SIZE;=0A+	buf =3D =
kmalloc(buflen, GFP_ATOMIC);=0A+=0A+	vmbus_recvpacket(channel, buf, =
buflen, &recvlen, &requestid);=0A+=0A+	if (recvlen > 0) {=0A+		=
DPRINT_DBG(VMBUS, "KVP packet: len=3D%d, requestid=3D%lld",=0A+			=
   recvlen, requestid);=0A+=0A+		icmsghdrp =3D (struct icmsg_hdr =
*)&buf[=0A+			sizeof(struct vmbuspipe_hdr)];=0A+=0A+		=
if (icmsghdrp->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {=0A+			=
prep_negotiate_resp(icmsghdrp, negop, buf);=0A+		} else {=0A+		=
	kvp_msg =3D (struct hv_kvp_msg *)&buf[=0A+				=
sizeof(struct vmbuspipe_hdr) +=0A+				sizeof(stru=
ct icmsg_hdr)];=0A+=0A+			kvp_data =3D &kvp_msg->kvp_data;=0A=
+=0A+			/*=0A+			 * We only support the =
"get" operation on=0A+			 * "KVP_POOL_AUTO" pool.=0A+		=
	 */=0A+=0A+			if ((kvp_msg->kvp_hdr.pool !=3D =
KVP_POOL_AUTO) ||=0A+				(kvp_msg->kvp_hdr.operation=
 !=3D=0A+				KVP_OP_ENUMERATE) ||=0A+		=
		kvp_transaction.active) {=0A+				if =
(kvp_transaction.active)=0A+					printk(KERN=
_WARNING=0A+						"KVP: Invalid =
call\n");=0A+				icmsghdrp->status =3D HV_E_FAIL;=0A=
+				goto callback_done;=0A+			=
}=0A+=0A+			/*=0A+			 * Stash away this =
global state for completing the=0A+			 * transaction; =
note transactions are serialized.=0A+			 */=0A+			=
kvp_transaction.recv_buffer =3D buf;=0A+			kvp_transac=
tion.recv_len =3D recvlen;=0A+			kvp_transaction.recv_channe=
l =3D channel;=0A+			kvp_transaction.recv_req_id =3D =
requestid;=0A+			kvp_transaction.active =3D true;=0A+=0A+	=
		/*=0A+			 * Get the information from =
the=0A+			 * user-mode component.=0A+			 * =
component. This transaction will be=0A+			 * completed when =
we get the value from=0A+			 * the user-mode component.=
=0A+			 * Set a timeout to deal with=0A+			=
 * user-mode not responding.=0A+			 */=0A+			=
kvp_send_key(kvp_data->index);=0A+			schedule_delayed_wo=
rk(&kvp_work, 100);=0A+=0A+			return;=0A+=0A+		=
}=0A+=0A+callback_done:=0A+=0A+		icmsghdrp->icflags =3D ICMSGHDRFLAG=
_TRANSACTION=0A+			| ICMSGHDRFLAG_RESPONSE;=0A+=0A+	=
	vmbus_sendpacket(channel, buf,=0A+				   =
    recvlen, requestid,=0A+				       VmbusPacketT=
ypeDataInBand, 0);=0A+	}=0A+=0A+	kfree(buf);=0A+=0A+=0A+}=0A+=0A+int=
=0A+hv_kvp_init(void)=0A+{=0A+	int err;=0A+=0A+	err =3D cn_add_call=
back(&kvp_id, kvp_name, kvp_cn_callback);=0A+	if (err)=0A+		=
return err;=0A+=0A+	return 0;=0A+}=0A+=0A+void hv_kvp_deinit(void)=0A+{=
=0A+	cn_del_callback(&kvp_id);=0A+	cancel_delayed_work_sync(&kvp_work)=
;=0A+}=0AIndex: linux.trees.git/drivers/staging/hv/hv_kvp.h=0A=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- /dev/null	1970-01-01 =
00:00:00.000000000 +0000=0A+++ linux.trees.git/drivers/staging/hv/hv_kvp.h	=
2010-11-19 17:59:40.000000000 -0500=0A@@ -0,0 +1,184 @@=0A+/*=0A+ * An =
implementation of HyperV key value pair (KVP) functionality for Linux.=0A+ =
*=0A+ *=0A+ * Copyright (C) 2010, Novell, Inc.=0A+ * Author : K. Y. =
Srinivasan <ksrinivasan@novell.com>=0A+ *=0A+ * This program is free =
software; you can redistribute it and/or modify it=0A+ * under the terms =
of the GNU General Public License version 2 as published=0A+ * by the Free =
Software Foundation.=0A+ *=0A+ * This program is distributed in the hope =
that it will be useful, but=0A+ * WITHOUT ANY WARRANTY; without even the =
implied warranty of=0A+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR =
PURPOSE, GOOD TITLE or=0A+ * NON INFRINGEMENT.  See the GNU General Public =
License for more=0A+ * details.=0A+ *=0A+ * You should have received a =
copy of the GNU General Public License=0A+ * along with this program; if =
not, write to the Free Software=0A+ * Foundation, Inc., 51 Franklin St, =
Fifth Floor, Boston, MA 02110-1301 USA.=0A+ *=0A+ */=0A+#ifndef	_KVP_H=0A+#=
define	_KVP_H_=0A+=0A+/*=0A+ * Maximum value size - used for both key =
names and value data, and includes=0A+ * any applicable NULL terminators.=
=0A+ *=0A+ * Note:  This limit is somewhat arbitrary, but falls easily =
within what is=0A+ * supported for all native guests (back to Win 2000) =
and what is reasonable=0A+ * for the IC KVP exchange functionality.  Note =
that Windows Me/98/95 are=0A+ * limited to 255 character key names.=0A+ =
*=0A+ * MSDN recommends not storing data values larger than 2048 bytes in =
the=0A+ * registry.=0A+ *=0A+ * Note:  This value is used in defining the =
KVP exchange message - this value=0A+ * cannot be modified without =
affecting the message size and compatability.=0A+ */=0A+=0A+/*=0A+ * =
bytes, including any null terminators=0A+ */=0A+#define HV_KVP_EXCHANGE_MAX=
_VALUE_SIZE          (2048)=0A+=0A+=0A+/*=0A+ * Maximum key size - the =
registry limit for the length of an entry name=0A+ * is 256 characters, =
including the null terminator=0A+ */=0A+=0A+#define HV_KVP_EXCHANGE_MAX_KEY=
_SIZE            (512)=0A+=0A+/*=0A+ * In Linux, we implement the KVP =
functionality in two components:=0A+ * 1) The kernel component which is =
packaged as part of the hv_utils driver=0A+ * is responsible for communicat=
ing with the host and responsible for=0A+ * implementing the host/guest =
protocol. 2) A user level daemon that is=0A+ * responsible for data =
gathering.=0A+ *=0A+ * Host/Guest Protocol: The host iterates over an =
index and expects the guest=0A+ * to assign a key name to the index and =
also return the value corresponding to=0A+ * the key. The host will have =
atmost one KVP transaction outstanding at any=0A+ * given point in time. =
The host side iteration stops when the guest returns=0A+ * an error. =
Microsoft has specified the following mapping of key names to=0A+ * host =
specified index:=0A+ *=0A+ *	Index		Key Name=0A+ *	0		=
FullyQualifiedDomainName=0A+ *	1		IntegrationServicesVersion=
=0A+ *	2		NetworkAddressIPv4=0A+ *	3		=
NetworkAddressIPv6=0A+ *	4		OSBuildNumber=0A+ *	5	=
	OSName=0A+ *	6		OSMajorVersion=0A+ *	7		=
OSMinorVersion=0A+ *	8		OSVersion=0A+ *	9		=
ProcessorArchitecture=0A+ *=0A+ * The Windows host expects the Key Name =
and Key Value to be encoded in utf16.=0A+ *=0A+ * Guest Kernel/KVP Daemon =
Protocol: As noted earlier, we implement all of the=0A+ * data gathering =
functionality in a user mode daemon. The user level daemon=0A+ * is also =
responsible for binding the key name to the index as well. The=0A+ * =
kernel and user-level daemon communicate using a connector channel.=0A+ =
*=0A+ * The user mode component first registers with the=0A+ * the kernel =
component. Subsequently, the kernel component requests, data=0A+ * for the =
specified keys. In response to this message the user mode component=0A+ * =
fills in the value corresponding to the specified key. We overload the=0A+ =
* sequence field in the cn_msg header to define our KVP message types.=0A+ =
*=0A+ *=0A+ * The kernel component simply acts as a conduit for communicati=
on between the=0A+ * Windows host and the user-level daemon. The kernel =
component passes up the=0A+ * index received from the Host to the =
user-level daemon. If the index is=0A+ * valid (supported), the correspondi=
ng key as well as its=0A+ * value (both are strings) is returned. If the =
index is invalid=0A+ * (not supported), a NULL key string is returned.=0A+ =
*/=0A+=0A+/*=0A+ *=0A+ * The following definitions are shared with the =
user-mode component; do not=0A+ * change any of this without making the =
corresponding changes in=0A+ * the KVP user-mode component.=0A+ */=0A+=0A+#=
define CN_KVP_VAL             0x1 /* This supports queries from the kernel =
*/=0A+#define CN_KVP_USER_VAL       0x2 /* This supports queries from the =
user */=0A+=0A+enum hv_ku_op {=0A+	KVP_REGISTER =3D 0, /* Register =
the user mode component */=0A+	KVP_KERNEL_GET, /* Kernel is requesting =
the value */=0A+	KVP_KERNEL_SET, /* Kernel is providing the value =
*/=0A+	KVP_USER_GET,  /* User is requesting the value */=0A+	KVP_USER_SE=
T  /* User is providing the value */=0A+};=0A+=0A+struct hv_ku_msg {=0A+	=
__u32 kvp_index; /* Key index */=0A+	__u8  kvp_key[HV_KVP_EXCHANGE_MAX_K=
EY_SIZE]; /* Key name */=0A+	__u8  kvp_value[HV_KVP_EXCHANGE_MAX_VALUE_S=
IZE]; /* Key  value */=0A+};=0A+=0A+=0A+=0A+=0A+#ifdef __KERNEL__=0A+=0A+/*=
=0A+ * Registry value types.=0A+ */=0A+=0A+#define REG_SZ 1=0A+=0A+enum =
hv_kvp_exchg_op {=0A+	KVP_OP_GET =3D 0,=0A+	KVP_OP_SET,=0A+	KVP_OP_DELE=
TE,=0A+	KVP_OP_ENUMERATE,=0A+	KVP_OP_COUNT /* Number of operations, must =
be last. */=0A+};=0A+=0A+enum hv_kvp_exchg_pool {=0A+	KVP_POOL_EXTERNAL =
=3D 0,=0A+	KVP_POOL_GUEST,=0A+	KVP_POOL_AUTO,=0A+	KVP_POOL_AU=
TO_EXTERNAL,=0A+	KVP_POOL_AUTO_INTERNAL,=0A+	KVP_POOL_COUNT /* =
Number of pools, must be last. */=0A+};=0A+=0A+struct hv_kvp_hdr {=0A+	u8 =
operation;=0A+	u8 pool;=0A+};=0A+=0A+struct hv_kvp_exchg_msg_value {=0A+	=
u32 value_type;=0A+	u32 key_size;=0A+	u32 value_size;=0A+	u8 =
key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];=0A+	u8 value[HV_KVP_EXCHANGE_MAX_VALUE_=
SIZE];=0A+};=0A+=0A+struct hv_kvp_msg_enumerate {=0A+	u32 index;=0A+	=
struct hv_kvp_exchg_msg_value data;=0A+};=0A+=0A+struct hv_kvp_msg {=0A+	=
struct hv_kvp_hdr	kvp_hdr;=0A+	struct hv_kvp_msg_enumerate	=
kvp_data;=0A+};=0A+=0A+int hv_kvp_init(void);=0A+void hv_kvp_deinit(void);=
=0A+void hv_kvp_onchannelcallback(void *);=0A+=0A+#endif /* __KERNEL__ =
*/=0A+#endif	/* _KVP_H */=0A+=0AIndex: linux.trees.git/drivers/staging/h=
v/hv_util.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- =
linux.trees.git.orig/drivers/staging/hv/hv_util.c	2010-11-19 =
17:57:16.000000000 -0500=0A+++ linux.trees.git/drivers/staging/hv/hv_util.c=
	2010-11-19 17:57:17.000000000 -0500=0A@@ -37,6 +37,7 @@=0A =
#include "vmbus_private.h"=0A #include "vmbus_api.h"=0A #include =
"utils.h"=0A+#include "hv_kvp.h"=0A =0A =0A static void shutdown_onchannelc=
allback(void *context)=0A@@ -268,6 +269,10 @@ static int __init init_hyperv=
_utils(void=0A {=0A 	printk(KERN_INFO "Registering HyperV Utility =
Driver\n");=0A =0A+	if (hv_kvp_init())=0A+		return -ENODEV;=0A+=
=0A+=0A 	if (!dmi_check_system(hv_utils_dmi_table))=0A 		=
return -ENODEV;=0A =0A@@ -283,6 +288,11 @@ static int __init init_hyperv_ut=
ils(void=0A 		&heartbeat_onchannelcallback;=0A 	hv_cb_utils=
[HV_HEARTBEAT_MSG].callback =3D &heartbeat_onchannelcallback;=0A =0A+	=
hv_cb_utils[HV_KVP_MSG].channel->OnChannelCallback =3D=0A+		=
&hv_kvp_onchannelcallback;=0A+=0A+=0A+=0A 	return 0;=0A }=0A =0A@@ =
-301,6 +311,13 @@ static void exit_hyperv_utils(void)=0A 	hv_cb_utils=
[HV_HEARTBEAT_MSG].channel->OnChannelCallback =3D=0A 		&chn_cb_neg=
otiate;=0A 	hv_cb_utils[HV_HEARTBEAT_MSG].callback =3D &chn_cb_negotiat=
e;=0A+=0A+	hv_cb_utils[HV_KVP_MSG].channel->OnChannelCallback =3D=0A+	=
	&chn_cb_negotiate;=0A+=0A+	hv_kvp_deinit();=0A+=0A+=0A }=0A =
=0A module_init(init_hyperv_utils);=0AIndex: linux.trees.git/drivers/stagin=
g/hv/channel_mgmt.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A--- linux.trees.git.orig/drivers/staging/hv/channel_mgmt.c	2010-11-19 =
17:30:48.000000000 -0500=0A+++ linux.trees.git/drivers/staging/hv/channel_m=
gmt.c	2010-11-19 18:00:40.000000000 -0500=0A@@ -34,8 +34,8 @@ struct =
vmbus_channel_message_table_entry=0A 	void (*messageHandler)(struct =
vmbus_channel_message_header *msg);=0A };=0A =0A-#define MAX_MSG_TYPES     =
               3=0A-#define MAX_NUM_DEVICE_CLASSES_SUPPORTED 7=0A+#define =
MAX_MSG_TYPES                    4=0A+#define MAX_NUM_DEVICE_CLASSES_SUPPOR=
TED 8=0A =0A static const struct hv_guid=0A 	gSupportedDeviceClasses[MAX=
_NUM_DEVICE_CLASSES_SUPPORTED] =3D {=0A@@ -98,6 +98,15 @@ static const =
struct hv_guid=0A 			0xab, 0x55, 0x38, 0x2f, 0x3b, =
0xd5, 0x42, 0x2d=0A 		}=0A 	},=0A+	/* {A9A0F4E7-5A45-4d96-B827=
-8A841E8C03E6} */=0A+	/* KVP */=0A+	{=0A+		.data =3D {=0A+		=
	0xe7, 0xf4, 0xa0, 0xa9, 0x45, 0x5a, 0x96, 0x4d,=0A+			=
0xb8, 0x27, 0x8a, 0x84, 0x1e, 0x8c, 0x3,  0xe6=0A+	}=0A+	},=0A+=0A =
};=0A =0A =0A@@ -231,6 +240,16 @@ struct hyperv_service_callback =
hv_cb_uti=0A 		.callback =3D chn_cb_negotiate,=0A 		=
.log_msg =3D "Heartbeat channel functionality initialized"=0A 	},=0A+	/* =
{A9A0F4E7-5A45-4d96-B827-8A841E8C03E6} */=0A+	/* KVP */=0A+	{=0A+		=
.data =3D {=0A+			0xe7, 0xf4, 0xa0, 0xa9, 0x45, 0x5a, 0x96, =
0x4d,=0A+			0xb8, 0x27, 0x8a, 0x84, 0x1e, 0x8c, 0x3,  =
0xe6=0A+		},=0A+		.callback =3D chn_cb_negotiate,=0A+=
		.log_msg =3D "KVP channel functionality initialized"=0A+	=
},=0A };=0A EXPORT_SYMBOL(hv_cb_utils);=0A =0A
--=__Part7954D261.0__=
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
ZWNpZmllZCBrZXkqLwp9OwoKI2RlZmluZSBIVl9LVlBfRVhDSEFOR0VfTUFYX0tFWV9TSVpFCTUx
MgojZGVmaW5lIEhWX0tWUF9FWENIQU5HRV9NQVhfVkFMVUVfU0laRQkyMDQ4CgkKc3RydWN0IGh2
X2t1X21zZyB7CglfX3UzMglrdnBfaW5kZXg7CglfX3U4ICBrdnBfa2V5W0hWX0tWUF9FWENIQU5H
RV9NQVhfS0VZX1NJWkVdOyAvKiBLZXkgbmFtZSAqLwoJX191OCAga3ZwX3ZhbHVlW0hWX0tWUF9F
WENIQU5HRV9NQVhfVkFMVUVfU0laRV07IC8qIEtleSAgdmFsdWUgKi8KfTsKCmVudW0ga2V5X2lu
ZGV4IHsKCUZ1bGx5UXVhbGlmaWVkRG9tYWluTmFtZSA9IDAsCglJbnRlZ3JhdGlvblNlcnZpY2Vz
VmVyc2lvbiwgLypUaGlzIGtleSBpcyBzZXJ2aWNlZCBpbiB0aGUga2VybmVsKi8KCU5ldHdvcmtB
ZGRyZXNzSVB2NCwKCU5ldHdvcmtBZGRyZXNzSVB2NiwKCU9TQnVpbGROdW1iZXIsCglPU05hbWUs
CglPU01ham9yVmVyc2lvbiwKCU9TTWlub3JWZXJzaW9uLAoJT1NWZXJzaW9uLAoJUHJvY2Vzc29y
QXJjaGl0ZWN0dXJlCn07CiAKLyoKICogRW5kIG9mIHNoYXJlZCBkZWZpbml0aW9ucy4KICovCgpz
dGF0aWMgY2hhciBrdnBfc2VuZF9idWZmZXJbNDA5Nl07CnN0YXRpYyBjaGFyIGt2cF9yZWN2X2J1
ZmZlcls0MDk2XTsKc3RhdGljIHN0cnVjdCBzb2NrYWRkcl9ubCBhZGRyOwoKc3RhdGljIGNoYXIg
b3NfbmFtZVsxMDBdOwpzdGF0aWMgY2hhciBvc19tYWpvcls1MF07CnN0YXRpYyBjaGFyIG9zX21p
bm9yWzUwXTsKc3RhdGljIGNoYXIgcHJvY2Vzc29yX2FyY2hbNTBdOwpzdGF0aWMgY2hhciBvc19i
dWlsZFsxMDBdOwpzdGF0aWMgY2hhciAqbGljX3ZlcnNpb247Cgp2b2lkIGt2cF9nZXRfb3NfaW5m
byh2b2lkKQp7CglGSUxFCSpmaWxlOwoJY2hhcgkqZW9sOwoJc3RydWN0IHV0c25hbWUgYnVmOwoK
CXVuYW1lKCZidWYpOwoJc3RyY3B5KG9zX2J1aWxkLCBidWYucmVsZWFzZSk7CglzdHJjcHkocHJv
Y2Vzc29yX2FyY2gsIGJ1Zi5tYWNoaW5lKTsKCglpZiAoKGZpbGUgPSBmb3BlbigiL2V0Yy9TdVNF
LXJlbGVhc2UiLCAiciIpKSAhPSBOVUxMKQoJCWdvdG8ga3ZwX29zaW5mb19mb3VuZDsKCWlmICgo
ZmlsZSAgPSBmb3BlbigiL2V0Yy9TdVNFLXJlbGVhc2UiLCAiciIpKSAhPSBOVUxMKQoJCWdvdG8g
a3ZwX29zaW5mb19mb3VuZDsKCS8qCgkgKiBBZGQgY29kZSBmb3Igb3RoZXIgc3VwcG9ydGVkIHBs
YXRmb3Jtcy4KCSAqLwoKCS8qCgkgKiBXZSBkb24ndCBoYXZlIGluZm9ybWF0aW9uIGFib3V0IHRo
ZSBvcy4KCSAqLwoJc3RyY3B5KG9zX25hbWUsICJMaW51eCIpOwoJc3RyY3B5KG9zX21ham9yLCAi
MCIpOwoJc3RyY3B5KG9zX21pbm9yLCAiMCIpOwoJcmV0dXJuOwoKa3ZwX29zaW5mb19mb3VuZDoK
CWZnZXRzKG9zX25hbWUsIDk5LCBmaWxlKTsKCWVvbCA9IGluZGV4KG9zX25hbWUsICdcbicpOwoJ
KmVvbCA9ICdcMCc7CglmZ2V0cyhvc19tYWpvciwgNDksIGZpbGUpOwoJZW9sID0gaW5kZXgob3Nf
bWFqb3IsICdcbicpOwoJKmVvbCA9ICdcMCc7CglmZ2V0cyhvc19taW5vciwgNDksIGZpbGUpOwoJ
ZW9sID0gaW5kZXgob3NfbWlub3IsICdcbicpOwoJKmVvbCA9ICdcMCc7CglmY2xvc2UoZmlsZSk7
CglyZXR1cm47Cn0KCQpzdGF0aWMgaW50Cmt2cF9nZXRfaXBfYWRkcmVzcyhpbnQgZmFtaWx5LCBj
aGFyICpidWZmZXIsIGludCBsZW5ndGgpCnsKCXN0cnVjdCBpZmFkZHJzICppZmFwOwoJc3RydWN0
IGlmYWRkcnMgKmN1cnA7CglpbnQgaXB2NF9sZW4gPSBzdHJsZW4oIjI1NS4yNTUuMjU1LjI1NSIp
ICsgMTsKCWludCBpcHY2X2xlbiA9IHN0cmxlbigiZmZmZjpmZmZmOmZmZmY6ZmZmZjpmZmZmOmZm
ZmY6ZmZmZjpmZmZmIikrMTsgCglpbnQgb2Zmc2V0ID0gMDsKCWNvbnN0IGNoYXIgKnN0cjsKCWNo
YXIgdG1wWzUwXTsKCWludCBlcnJvciA9IDA7CgoJLyoKCSAqIE9uIGVudHJ5IGludG8gdGhpcyBm
dW5jdGlvbiwgdGhlIGJ1ZmZlciBpcyBjYXBhYmxlIG9mIGhvbGRpbmcgdGhlCgkgKiBtYXhpbXVt
IGtleSB2YWx1ZSAoMjA0OCBieXRlcykuCgkgKi8KCQoJaWYgKGdldGlmYWRkcnMoJmlmYXApKSB7
CgkJc3RyY3B5KGJ1ZmZlciwgImdldGlmYWRkcnMgZmFpbGVkXG4iKTsKCQlyZXR1cm4gMTsKCX0K
CgljdXJwID0gaWZhcDsKCXdoaWxlIChjdXJwICE9IE5VTEwpIHsKCQlpZiAoKGN1cnAtPmlmYV9h
ZGRyICE9IE5VTEwpICYmICAKCQkgICAoY3VycC0+aWZhX2FkZHItPnNhX2ZhbWlseSA9PSBmYW1p
bHkpKSB7CgkJCWlmIChmYW1pbHkgPT0gQUZfSU5FVCkgewoJCQkJc3RydWN0IHNvY2thZGRyX2lu
ICphZGRyID0gCgkJCQkoc3RydWN0IHNvY2thZGRyX2luICopIGN1cnAtPmlmYV9hZGRyOwoKCQkJ
CWlmICghKHN0ciA9IGluZXRfbnRvcChmYW1pbHksICZhZGRyLT5zaW5fYWRkciwgCgkJCQkJdG1w
LCA1MCkpKSB7CgkJCQkJc3RyY3B5KGJ1ZmZlciwgImluZXRfbnRvcCBmYWlsZWRcbiIpOwoJCQkJ
CWVycm9yID0gMTsKCQkJCQlnb3RvIGdldGFkZHJfZG9uZTsKCQkJCX0KCQkJCWlmIChvZmZzZXQg
PT0gMCkgCgkJCQkJc3RyY3B5KGJ1ZmZlciwgdG1wKTsKCQkJCWVsc2UgCgkJCQkJc3RyY2F0KGJ1
ZmZlciwgdG1wKTsKCQkJCXN0cmNhdChidWZmZXIsICI7Iik7CgkJCQkKCQkJCW9mZnNldCArPSBz
dHJsZW4oc3RyKSArMTsKCQkJCWlmICgobGVuZ3RoIC0gb2Zmc2V0KSA8IChpcHY0X2xlbiArIDEp
KSB7CgkJCQkJZ290byBnZXRhZGRyX2RvbmU7CgkJCQl9CgkJCX0gZWxzZSB7CgkJCS8qCgkJIAkg
KiBXZSBvbmx5IHN1cHBvcnQgQUZfSU5FVCBhbmQgQUZfSU5FVDYKCQkJICogYW5kIHRoZSBsaXN0
IG9mIGFkZHJlc3NlcyBpcyBzZXBlcmF0ZWQgYnkgYSAiOyIuCgkJCSAqLwoJCQkJc3RydWN0IHNv
Y2thZGRyX2luNiAqYWRkciA9IAoJCQkJKHN0cnVjdCBzb2NrYWRkcl9pbjYgKikgY3VycC0+aWZh
X2FkZHI7CgoJCQkJaWYgKCEoc3RyID0gaW5ldF9udG9wKGZhbWlseSwKCQkJCQkmYWRkci0+c2lu
Nl9hZGRyLnM2X2FkZHIsCgkJCQkJdG1wLCA1MCkpKSB7CgkJCQkJc3RyY3B5KGJ1ZmZlciwgImlu
ZXRfbnRvcCBmYWlsZWRcbiIpOwoJCQkJCWVycm9yID0gMTsKCQkJCQlnb3RvIGdldGFkZHJfZG9u
ZTsKCQkJCX0KCQkJCWlmIChvZmZzZXQgPT0gMCkgCgkJCQkJc3RyY3B5KGJ1ZmZlciwgdG1wKTsK
CQkJCWVsc2UgCgkJCQkJc3RyY2F0KGJ1ZmZlciwgdG1wKTsKCQkJCXN0cmNhdChidWZmZXIsICI7
Iik7CgkJCQlvZmZzZXQgKz0gc3RybGVuKHN0cikgKzE7CgkJCQlpZiAoKGxlbmd0aCAtIG9mZnNl
dCkgPCAoaXB2Nl9sZW4gKzEpKSB7CgkJCQkJZ290byBnZXRhZGRyX2RvbmU7CgkJCQl9CgkJCX0K
CQkJCQoJCX0KCQljdXJwID0gY3VycC0+aWZhX25leHQ7Cgl9CgpnZXRhZGRyX2RvbmU6CglmcmVl
aWZhZGRycyhpZmFwKTsKCXJldHVybiBlcnJvcjsKfQoKCnN0YXRpYyBpbnQKa3ZwX2dldF9kb21h
aW5fbmFtZShjaGFyICpidWZmZXIsIGludCBsZW5ndGgpCnsKCXN0cnVjdCBhZGRyaW5mbwloaW50
cywgKmluZm8gOwoJZ2V0aG9zdG5hbWUoYnVmZmVyLCBsZW5ndGgpOwoJaW50IGVycm9yID0wOwoK
CW1lbXNldCgmaGludHMsIDAsIHNpemVvZihoaW50cykpOwoJaGludHMuYWlfZmFtaWx5ID0gQUZf
SU5FVDsgLypHZXQgb25seSBpcHY0IGFkZHJpbmZvLiAqLwoJaGludHMuYWlfc29ja3R5cGUgPSBT
T0NLX1NUUkVBTTsKCWhpbnRzLmFpX2ZsYWdzID0gQUlfQ0FOT05OQU1FOwoJCglpZiAoKGVycm9y
ID0gZ2V0YWRkcmluZm8oYnVmZmVyLCAiaHR0cCIsICZoaW50cywgJmluZm8pKSAhPTApIHsKCQlz
dHJjcHkoYnVmZmVyLCAiZ2V0YWRkcmluZm8gZmFpbGVkXG4iKTsKCQllcnJvciA9IDE7CgkJZ290
byBnZXRfZG9tYWluX2RvbmU7Cgl9CglzdHJjcHkoYnVmZmVyLCBpbmZvLT5haV9jYW5vbm5hbWUp
OwpnZXRfZG9tYWluX2RvbmU6CglmcmVlYWRkcmluZm8oaW5mbyk7CglyZXR1cm4gKGVycm9yKTsK
fQoKc3RhdGljIGludCAKbmV0bGlua19zZW5kKGludCBmZCwgc3RydWN0IGNuX21zZyAqbXNnKQp7
CglzdHJ1Y3Qgbmxtc2doZHIgKm5saDsKCXVuc2lnbmVkIGludCBzaXplOwoJc3RydWN0IG1zZ2hk
ciBtZXNzYWdlOwoJY2hhciBidWZmZXJbNjRdOwoJc3RydWN0IGlvdmVjIGlvdlsyXTsKCglzaXpl
ID0gTkxNU0dfU1BBQ0Uoc2l6ZW9mKHN0cnVjdCBjbl9tc2cpICsgbXNnLT5sZW4pOwoKCW5saCA9
IChzdHJ1Y3Qgbmxtc2doZHIgKilidWZmZXI7CglubGgtPm5sbXNnX3NlcSA9IDA7CglubGgtPm5s
bXNnX3BpZCA9IGdldHBpZCgpOwoJbmxoLT5ubG1zZ190eXBlID0gTkxNU0dfRE9ORTsKCW5saC0+
bmxtc2dfbGVuID0gTkxNU0dfTEVOR1RIKHNpemUgLSBzaXplb2YoKm5saCkpOwoJbmxoLT5ubG1z
Z19mbGFncyA9IDA7CgkKCWlvdlswXS5pb3ZfYmFzZSA9IG5saDsKCWlvdlswXS5pb3ZfbGVuID0g
c2l6ZW9mKCpubGgpOwoKCWlvdlsxXS5pb3ZfYmFzZSA9IG1zZzsKCWlvdlsxXS5pb3ZfbGVuID0g
c2l6ZTsKCgltZW1zZXQoJm1lc3NhZ2UsIDAsIHNpemVvZihtZXNzYWdlKSk7CgltZXNzYWdlLm1z
Z19uYW1lID0gJmFkZHI7CgltZXNzYWdlLm1zZ19uYW1lbGVuID0gc2l6ZW9mKGFkZHIpOyAKCW1l
c3NhZ2UubXNnX2lvdiA9IGlvdjsKCW1lc3NhZ2UubXNnX2lvdmxlbiA9IDI7CgoJcmV0dXJuIChz
ZW5kbXNnKGZkLCAmbWVzc2FnZSwgMCkpOwp9CgptYWluKHZvaWQpCnsKCWludCBmZCwgbGVuLCBz
b2NrX29wdDsKCWludCBlcnJvcjsKCXN0cnVjdCBjbl9tc2cgKm1lc3NhZ2U7CglzdHJ1Y3QgcG9s
bGZkIHBmZDsKCXN0cnVjdCBubG1zZ2hkciAqaW5jb21pbmdfbXNnOwoJc3RydWN0IGNuX21zZwkq
aW5jb21pbmdfY25fbXNnOwoJY2hhcgkqa2V5X3ZhbHVlOwoJY2hhcgkqa2V5X25hbWU7CglpbnQJ
IGtleV9pbmRleDsKCglkYWVtb24oMSwgMCk7CglvcGVubG9nKCJLVlAiLCAwLCBMT0dfVVNFUik7
CglzeXNsb2coTE9HX0lORk8sICJLVlAgc3RhcnRpbmc7IHBpZCBpczolZCIsIGdldHBpZCgpKTsK
CS8qCgkgKiBSZXRyaWV2ZSBPUyByZWxlYXNlIGluZm9ybWF0aW9uLgoJICovCglrdnBfZ2V0X29z
X2luZm8oKTsKCglmZCA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX0RHUkFNLCBORVRMSU5LX0NP
Tk5FQ1RPUik7CglpZiAoZmQgPCAwKSB7CgkJc3lzbG9nKExPR19FUlIsICJuZXRsaW5rIHNvY2tl
dCBjcmVhdGlvbiBmYWlsZWQ7IGVycm9yOiVkIixmZCk7CgkJZXhpdCAtMTsKCX0KCWFkZHIubmxf
ZmFtaWx5ID0gQUZfTkVUTElOSzsKCWFkZHIubmxfcGFkID0gMDsKCWFkZHIubmxfcGlkID0gMDsK
CWFkZHIubmxfZ3JvdXBzID0gQ05fS1ZQX0lEWDsKCgoJaWYgKChlcnJvciA9IGJpbmQoZmQsIChz
dHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSkgPCAwKSB7CgkJc3lzbG9nKExP
R19FUlIsICJiaW5kIGZhaWxlZDsgZXJyb3I6JWQiLGVycm9yKTsKCQljbG9zZShmZCk7CgkJZXhp
dCAtMTsKCX0KCXNvY2tfb3B0ID0gYWRkci5ubF9ncm91cHM7CglzZXRzb2Nrb3B0KGZkLCAyNzAs
IDEsICZzb2NrX29wdCwgc2l6ZW9mKHNvY2tfb3B0KSk7CgkvKgoJICogUmVnaXN0ZXIgb3Vyc2Vs
dmVzIHdpdGggdGhlIGtlcm5lbC4KCSAqLwoJbWVzc2FnZSA9IChzdHJ1Y3QgY25fbXNnICopa3Zw
X3NlbmRfYnVmZmVyOwoJbWVzc2FnZS0+aWQuaWR4ID0gQ05fS1ZQX0lEWDsKCW1lc3NhZ2UtPmlk
LnZhbCA9IENOX0tWUF9WQUw7CgltZXNzYWdlLT5zZXEgPSBLVlBfUkVHSVNURVI7CgltZXNzYWdl
LT5hY2sgPSAwOwoJbWVzc2FnZS0+bGVuID0gMDsKCglsZW4gPSBuZXRsaW5rX3NlbmQoZmQsIG1l
c3NhZ2UpOwoJaWYgKGxlbiA8IDApIHsKCQlzeXNsb2coTE9HX0VSUiwgIm5ldGxpbmtfc2VuZCBm
YWlsZWQ7IGVycm9yOiVkIiwgbGVuKTsKCQljbG9zZShmZCk7CgkJZXhpdCAtMTsKCX0KCQoJcGZk
LmZkID0gZmQ7CgkKCXdoaWxlICgxKSB7CgkJcGZkLmV2ZW50cyA9IFBPTExJTjsKCQlwZmQucmV2
ZW50cyA9IDA7CgkJcG9sbCgmcGZkLCAxLCAtMSk7CgoJCWxlbiA9IHJlY3YoZmQsIGt2cF9yZWN2
X2J1ZmZlciwgc2l6ZW9mKGt2cF9yZWN2X2J1ZmZlciksIDApOwoKCQlpZiAobGVuIDwgMCkgewoJ
CQlzeXNsb2coTE9HX0VSUiwgInJlY3YgZmFpbGVkOyBlcnJvcjolZCIsIGxlbik7CgkJCWNsb3Nl
KGZkKTsKCQkJcmV0dXJuIC0xOwoJCX0KCQoJCWluY29taW5nX21zZyA9IChzdHJ1Y3Qgbmxtc2do
ZHIgKilrdnBfcmVjdl9idWZmZXI7CgkJaW5jb21pbmdfY25fbXNnID0gKHN0cnVjdCBjbl9tc2cg
KilOTE1TR19EQVRBKGluY29taW5nX21zZyk7CgoJCXN3aXRjaCAoaW5jb21pbmdfY25fbXNnLT5z
ZXEpIHsKCQljYXNlIEtWUF9SRUdJU1RFUjoKCQkJLyoKCQkJICogRHJpdmVyIGlzIHJlZ2lzdGVy
aW5nIHdpdGggdXM7IHN0YXNoIGF3YXkgdGhlIHZlcnNpb24gCgkJCSAqIGluZm9ybWF0aW9uLgoJ
CQkgKi8KCQkJbGljX3ZlcnNpb24gPSBtYWxsb2Moc3RybGVuKGluY29taW5nX2NuX21zZy0+ZGF0
YSkgKyAxKTsKCQkJaWYgKGxpY192ZXJzaW9uKSB7IAoJCQkJc3RyY3B5KGxpY192ZXJzaW9uLCBp
bmNvbWluZ19jbl9tc2ctPmRhdGEpOwoJCQkJc3lzbG9nKExPR19JTkZPLCAiS1ZQIExJQyBWZXJz
aW9uOiAlcyIsIGxpY192ZXJzaW9uKTsKCQkJfSBlbHNlIHsKCQkJCXN5c2xvZyhMT0dfRVJSLCAi
bWFsbG9jIGZhaWxlZCIpOwoJCQl9CgkJCWNvbnRpbnVlOwoJCQkKCQljYXNlIEtWUF9LRVJORUxf
R0VUOgoJCQlicmVhazsKCQlkZWZhdWx0OgoJCQljb250aW51ZTsKCQl9CgoJCWtleV9pbmRleCA9
IAoJCSgoc3RydWN0IGh2X2t1X21zZyAqKWluY29taW5nX2NuX21zZy0+ZGF0YSktPmt2cF9pbmRl
eDsKCQlrZXlfbmFtZSA9CgkJKChzdHJ1Y3QgaHZfa3VfbXNnICopaW5jb21pbmdfY25fbXNnLT5k
YXRhKS0+a3ZwX2tleTsKCQlrZXlfdmFsdWUgPQoJCSgoc3RydWN0IGh2X2t1X21zZyAqKWluY29t
aW5nX2NuX21zZy0+ZGF0YSktPmt2cF92YWx1ZTsKCgkJc3dpdGNoIChrZXlfaW5kZXgpIHsKCQkJ
Y2FzZSBGdWxseVF1YWxpZmllZERvbWFpbk5hbWU6CgkJCQlrdnBfZ2V0X2RvbWFpbl9uYW1lKGtl
eV92YWx1ZSwKCQkJCQkJSFZfS1ZQX0VYQ0hBTkdFX01BWF9WQUxVRV9TSVpFKTsKCQkJCXN0cmNw
eShrZXlfbmFtZSwgIkZ1bGx5UXVhbGlmaWVkRG9tYWluTmFtZSIpOwoJCQkJYnJlYWs7CgkJCWNh
c2UgSW50ZWdyYXRpb25TZXJ2aWNlc1ZlcnNpb246CgkJCQlzdHJjcHkoa2V5X25hbWUsICJJbnRl
Z3JhdGlvblNlcnZpY2VzVmVyc2lvbiIpOwoJCQkJc3RyY3B5KGtleV92YWx1ZSwgbGljX3ZlcnNp
b24pOwoJCQkJYnJlYWs7CQoJCQljYXNlIE5ldHdvcmtBZGRyZXNzSVB2NDoKCQkJCWt2cF9nZXRf
aXBfYWRkcmVzcyhBRl9JTkVULCBrZXlfdmFsdWUsIAoJCQkJCQlIVl9LVlBfRVhDSEFOR0VfTUFY
X1ZBTFVFX1NJWkUpOwoJCQkJc3RyY3B5KGtleV9uYW1lLCAiTmV0d29ya0FkZHJlc3NJUHY0Iik7
CgkJCQlicmVhazsKCQkJY2FzZSBOZXR3b3JrQWRkcmVzc0lQdjY6CgkJCQlrdnBfZ2V0X2lwX2Fk
ZHJlc3MoQUZfSU5FVDYsIGtleV92YWx1ZSwgCgkJCQkJCUhWX0tWUF9FWENIQU5HRV9NQVhfVkFM
VUVfU0laRSk7CgkJCQlzdHJjcHkoa2V5X25hbWUsICJOZXR3b3JrQWRkcmVzc0lQdjYiKTsKCQkJ
CWJyZWFrOwoJCQljYXNlIE9TQnVpbGROdW1iZXI6CgkJCQlzdHJjcHkoa2V5X3ZhbHVlLCBvc19i
dWlsZCk7CgkJCQlzdHJjcHkoa2V5X25hbWUsICJPU0J1aWxkTnVtYmVyIik7CgkJCQlicmVhazsK
CQkJY2FzZSBPU05hbWU6CgkJCQlzdHJjcHkoa2V5X3ZhbHVlLCBvc19uYW1lKTsKCQkJCXN0cmNw
eShrZXlfbmFtZSwgIk9TTmFtZSIpOwoJCQkJYnJlYWs7CgkJCWNhc2UgT1NNYWpvclZlcnNpb246
CgkJCQlzdHJjcHkoa2V5X3ZhbHVlLCBvc19tYWpvcik7CgkJCQlzdHJjcHkoa2V5X25hbWUsICJP
U01ham9yVmVyc2lvbiIpOwoJCQkJYnJlYWs7CgkJCWNhc2UgT1NNaW5vclZlcnNpb246CgkJCQlz
dHJjcHkoa2V5X3ZhbHVlLCBvc19taW5vcik7CgkJCQlzdHJjcHkoa2V5X25hbWUsICJPU01pbm9y
VmVyc2lvbiIpOwoJCQkJYnJlYWs7CgkJCWNhc2UgT1NWZXJzaW9uOgoJCQkJc3RyY3B5KGtleV92
YWx1ZSwgb3NfYnVpbGQpOwoJCQkJc3RyY3B5KGtleV9uYW1lLCAiT1NWZXJzaW9uIik7CgkJCQli
cmVhazsKCQkJY2FzZSBQcm9jZXNzb3JBcmNoaXRlY3R1cmU6CgkJCQlzdHJjcHkoa2V5X3ZhbHVl
LCBwcm9jZXNzb3JfYXJjaCk7CgkJCQlzdHJjcHkoa2V5X25hbWUsICJQcm9jZXNzb3JBcmNoaXRl
Y3R1cmUiKTsKCQkJCWJyZWFrOwoJCQlkZWZhdWx0OgkKCQkJCXN0cmNweShrZXlfdmFsdWUsICJV
bmtub3duIEtleSIpOwoJCQkJLyoKCQkJCSAqIFdlIHVzZSBhIG51bGwga2V5IG5hbWUgdG8gdGVy
bWluYXRlIGVudW1lcmF0aW9uLgoJCQkJICovCgkJCQlzdHJjcHkoa2V5X25hbWUsICIiKTsKCQkJ
CWJyZWFrOwoJCX0KCQkvKgoJCSAqIFNlbmQgdGhlIHZhbHVlIGJhY2sgdG8gdGhlIGtlcm5lbC4g
VGhlIHJlc3BvbnNlIGlzIAoJCSAqIGFscmVhZHkgaW4gdGhlIHJlY2VpdmUgYnVmZmVyLiBVcGRh
dGUgdGhlIGNuX21zZyBoZWFkZXIgdG8gCgkJICogcmVmbGVjdCB0aGUga2V5IHZhbHVlIHRoYXQg
aGFzIGJlZW4gYWRkZWQgdG8gdGhlIG1lc3NhZ2UKCQkgKi8KCgkJaW5jb21pbmdfY25fbXNnLT5p
ZC5pZHggPSBDTl9LVlBfSURYOwoJCWluY29taW5nX2NuX21zZy0+aWQudmFsID0gQ05fS1ZQX1ZB
TDsKCQlpbmNvbWluZ19jbl9tc2ctPnNlcSA9IEtWUF9VU0VSX1NFVDsgCgkJaW5jb21pbmdfY25f
bXNnLT5hY2sgPSAwOwoJCWluY29taW5nX2NuX21zZy0+bGVuID0gc2l6ZW9mKHN0cnVjdCBodl9r
dV9tc2cpOwoKCQlsZW4gPSBuZXRsaW5rX3NlbmQoZmQsIGluY29taW5nX2NuX21zZyk7CgkJaWYg
KGxlbiA8IDApIHsKCQkJc3lzbG9nKExPR19FUlIsICJuZXRfbGluayBzZW5kIGZhaWxlZDsgZXJy
b3I6JWQiLCBsZW4pOwoJCQlleGl0IC0xOwoJCX0KCX0KCn0K

--=__Part7954D261.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__Part7954D261.0__=--
