From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 2/3]: An Implementation of HyperV KVP functionality
Date: Mon, 22 Nov 2010 13:27:26 -0700
Message-ID: <4CEA6FBE0200003000090BC0@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part220F893E.0__="
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

--=__Part220F893E.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The hv_utils module will be composed of more than one file;
rename hv_utils.c to accommodate this without changing the module name.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>



--=__Part220F893E.0__=
Content-Type: text/plain; name="hv_util_cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hv_util_cleanup.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject: The hv_utils =
module will be composed of more than one file; =0Arename hv_utils.c to =
accommodate this without changing the module name.=0A=0ASigned-off-by: K. =
Y. Srinivasan <ksrinivasan@novell.com>=0A=0A=0AIndex: linux.trees.git/drive=
rs/staging/hv/hv_util.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A--- /dev/null	1970-01-01 00:00:00.000000000 +0000=0A+++ =
linux.trees.git/drivers/staging/hv/hv_util.c	2010-11-19 17:30:48.0000000=
00 -0500=0A@@ -0,0 +1,311 @@=0A+/*=0A+ * Copyright (c) 2010, Microsoft =
Corporation.=0A+ *=0A+ * This program is free software; you can redistribut=
e it and/or modify it=0A+ * under the terms and conditions of the GNU =
General Public License,=0A+ * version 2, as published by the Free Software =
Foundation.=0A+ *=0A+ * This program is distributed in the hope it will be =
useful, but WITHOUT=0A+ * ANY WARRANTY; without even the implied warranty =
of MERCHANTABILITY or=0A+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU =
General Public License for=0A+ * more details.=0A+ *=0A+ * You should have =
received a copy of the GNU General Public License along with=0A+ * this =
program; if not, write to the Free Software Foundation, Inc., 59 Temple=0A+=
 * Place - Suite 330, Boston, MA 02111-1307 USA.=0A+ *=0A+ * Authors:=0A+ =
*   Haiyang Zhang <haiyangz@microsoft.com>=0A+ *   Hank Janssen  <hjanssen@=
microsoft.com>=0A+ */=0A+#include <linux/kernel.h>=0A+#include <linux/init.=
h>=0A+#include <linux/module.h>=0A+#include <linux/slab.h>=0A+#include =
<linux/sysctl.h>=0A+#include <linux/reboot.h>=0A+#include <linux/dmi.h>=0A+=
#include <linux/pci.h>=0A+=0A+#include "logging.h"=0A+#include "osd.h"=0A+#=
include "vmbus.h"=0A+#include "vmbus_packet_format.h"=0A+#include =
"vmbus_channel_interface.h"=0A+#include "version_info.h"=0A+#include =
"channel.h"=0A+#include "vmbus_private.h"=0A+#include "vmbus_api.h"=0A+#inc=
lude "utils.h"=0A+=0A+=0A+static void shutdown_onchannelcallback(void =
*context)=0A+{=0A+	struct vmbus_channel *channel =3D context;=0A+	u8 =
*buf;=0A+	u32 buflen, recvlen;=0A+	u64 requestid;=0A+	u8 =
 execute_shutdown =3D false;=0A+=0A+	struct shutdown_msg_data *shutdown_=
msg;=0A+=0A+	struct icmsg_hdr *icmsghdrp;=0A+	struct icmsg_negoti=
ate *negop =3D NULL;=0A+=0A+	buflen =3D PAGE_SIZE;=0A+	buf =3D =
kmalloc(buflen, GFP_ATOMIC);=0A+=0A+	vmbus_recvpacket(channel, buf, =
buflen, &recvlen, &requestid);=0A+=0A+	if (recvlen > 0) {=0A+		=
DPRINT_DBG(VMBUS, "shutdown packet: len=3D%d, requestid=3D%lld",=0A+		=
	   recvlen, requestid);=0A+=0A+		icmsghdrp =3D (struct =
icmsg_hdr *)&buf[=0A+			sizeof(struct vmbuspipe_hdr)];=0A+=
=0A+		if (icmsghdrp->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {=0A+	=
		prep_negotiate_resp(icmsghdrp, negop, buf);=0A+		} =
else {=0A+			shutdown_msg =3D (struct shutdown_msg_data =
*)&buf[=0A+				sizeof(struct vmbuspipe_hdr) +=0A+	=
			sizeof(struct icmsg_hdr)];=0A+=0A+			=
switch (shutdown_msg->flags) {=0A+			case 0:=0A+		=
	case 1:=0A+				icmsghdrp->status =3D =
HV_S_OK;=0A+				execute_shutdown =3D true;=0A+=0A+	=
			DPRINT_INFO(VMBUS, "Shutdown request received =
-"=0A+					    " gracefull shutdown initiated"=
);=0A+				break;=0A+			default:=0A=
+				icmsghdrp->status =3D HV_E_FAIL;=0A+		=
		execute_shutdown =3D false;=0A+=0A+				=
DPRINT_INFO(VMBUS, "Shutdown request received -"=0A+				=
	    " Invalid request");=0A+				break;=0A+	=
		};=0A+		}=0A+=0A+		icmsghdrp->icflags =
=3D ICMSGHDRFLAG_TRANSACTION=0A+			| ICMSGHDRFLAG_RESP=
ONSE;=0A+=0A+		vmbus_sendpacket(channel, buf,=0A+			=
	       recvlen, requestid,=0A+				       =
VmbusPacketTypeDataInBand, 0);=0A+	}=0A+=0A+	kfree(buf);=0A+=0A+=
	if (execute_shutdown =3D=3D true)=0A+		orderly_poweroff(fa=
lse);=0A+}=0A+=0A+/*=0A+ * Set guest time to host UTC time.=0A+ */=0A+stati=
c inline void do_adj_guesttime(u64 hosttime)=0A+{=0A+	s64 host_tns;=0A+	=
struct timespec host_ts;=0A+=0A+	host_tns =3D (hosttime - WLTIMEDELT=
A) * 100;=0A+	host_ts =3D ns_to_timespec(host_tns);=0A+=0A+	do_settimeo=
fday(&host_ts);=0A+}=0A+=0A+/*=0A+ * Synchronize time with host after =
reboot, restore, etc.=0A+ *=0A+ * ICTIMESYNCFLAG_SYNC flag bit indicates =
reboot, restore events of the VM.=0A+ * After reboot the flag ICTIMESYNCFLA=
G_SYNC is included in the first time=0A+ * message after the timesync =
channel is opened. Since the hv_utils module is=0A+ * loaded after =
hv_vmbus, the first message is usually missed. The other=0A+ * thing is, =
systime is automatically set to emulated hardware clock which may=0A+ * =
not be UTC time or in the same time zone. So, to override these effects, =
we=0A+ * use the first 50 time samples for initial system time setting.=0A+=
 */=0A+static inline void adj_guesttime(u64 hosttime, u8 flags)=0A+{=0A+	=
static s32 scnt =3D 50;=0A+=0A+	if ((flags & ICTIMESYNCFLAG_SYNC) !=3D 0) =
{=0A+		do_adj_guesttime(hosttime);=0A+		return;=0A+	=
}=0A+=0A+	if ((flags & ICTIMESYNCFLAG_SAMPLE) !=3D 0 && scnt > 0) =
{=0A+		scnt--;=0A+		do_adj_guesttime(hosttime);=0A+	=
}=0A+}=0A+=0A+/*=0A+ * Time Sync Channel message handler.=0A+ */=0A+static =
void timesync_onchannelcallback(void *context)=0A+{=0A+	struct vmbus_channe=
l *channel =3D context;=0A+	u8 *buf;=0A+	u32 buflen, recvlen;=0A+	=
u64 requestid;=0A+	struct icmsg_hdr *icmsghdrp;=0A+	struct =
ictimesync_data *timedatap;=0A+=0A+	buflen =3D PAGE_SIZE;=0A+	=
buf =3D kmalloc(buflen, GFP_ATOMIC);=0A+=0A+	vmbus_recvpacket(channel, =
buf, buflen, &recvlen, &requestid);=0A+=0A+	if (recvlen > 0) {=0A+		=
DPRINT_DBG(VMBUS, "timesync packet: recvlen=3D%d, requestid=3D%lld",=0A+	=
		recvlen, requestid);=0A+=0A+		icmsghdrp =3D =
(struct icmsg_hdr *)&buf[=0A+				sizeof(struct =
vmbuspipe_hdr)];=0A+=0A+		if (icmsghdrp->icmsgtype =3D=3D =
ICMSGTYPE_NEGOTIATE) {=0A+			prep_negotiate_resp(icmsghd=
rp, NULL, buf);=0A+		} else {=0A+			timedatap =
=3D (struct ictimesync_data *)&buf[=0A+				sizeof(stru=
ct vmbuspipe_hdr) +=0A+				sizeof(struct icmsg_hdr)];=
=0A+			adj_guesttime(timedatap->parenttime, timedatap->fla=
gs);=0A+		}=0A+=0A+		icmsghdrp->icflags =3D =
ICMSGHDRFLAG_TRANSACTION=0A+			| ICMSGHDRFLAG_RESPONSE;=0A=
+=0A+		vmbus_sendpacket(channel, buf,=0A+				=
recvlen, requestid,=0A+				VmbusPacketTypeDataInBand, =
0);=0A+	}=0A+=0A+	kfree(buf);=0A+}=0A+=0A+/*=0A+ * Heartbeat =
functionality.=0A+ * Every two seconds, Hyper-V send us a heartbeat =
request message.=0A+ * we respond to this message, and Hyper-V knows we =
are alive.=0A+ */=0A+static void heartbeat_onchannelcallback(void =
*context)=0A+{=0A+	struct vmbus_channel *channel =3D context;=0A+	u8 =
*buf;=0A+	u32 buflen, recvlen;=0A+	u64 requestid;=0A+	=
struct icmsg_hdr *icmsghdrp;=0A+	struct heartbeat_msg_data =
*heartbeat_msg;=0A+=0A+	buflen =3D PAGE_SIZE;=0A+	buf =3D kmalloc(buf=
len, GFP_ATOMIC);=0A+=0A+	vmbus_recvpacket(channel, buf, buflen, =
&recvlen, &requestid);=0A+=0A+	if (recvlen > 0) {=0A+		DPRINT_DBG(=
VMBUS, "heartbeat packet: len=3D%d, requestid=3D%lld",=0A+			=
   recvlen, requestid);=0A+=0A+		icmsghdrp =3D (struct icmsg_hdr =
*)&buf[=0A+			sizeof(struct vmbuspipe_hdr)];=0A+=0A+		=
icmsghdrp =3D (struct icmsg_hdr *)&buf[=0A+				=
sizeof(struct vmbuspipe_hdr)];=0A+=0A+		if (icmsghdrp->icmsgtype =
=3D=3D ICMSGTYPE_NEGOTIATE) {=0A+			prep_negotiate_resp=
(icmsghdrp, NULL, buf);=0A+		} else {=0A+			=
heartbeat_msg =3D (struct heartbeat_msg_data *)&buf[=0A+			=
	sizeof(struct vmbuspipe_hdr) +=0A+				=
sizeof(struct icmsg_hdr)];=0A+=0A+			DPRINT_DBG(VMBUS, =
"heartbeat seq =3D %lld",=0A+				   heartbeat_msg->s=
eq_num);=0A+=0A+			heartbeat_msg->seq_num +=3D 1;=0A+	=
	}=0A+=0A+		icmsghdrp->icflags =3D ICMSGHDRFLAG_TRANSAC=
TION=0A+			| ICMSGHDRFLAG_RESPONSE;=0A+=0A+		=
vmbus_sendpacket(channel, buf,=0A+				       =
recvlen, requestid,=0A+				       VmbusPacketTypeDataI=
nBand, 0);=0A+	}=0A+=0A+	kfree(buf);=0A+}=0A+=0A+static const =
struct pci_device_id __initconst=0A+hv_utils_pci_table[] __maybe_unused =
=3D {=0A+	{ PCI_DEVICE(0x1414, 0x5353) }, /* Hyper-V emulated VGA =
controller */=0A+	{ 0 }=0A+};=0A+MODULE_DEVICE_TABLE(pci, hv_utils_pc=
i_table);=0A+=0A+=0A+static const struct dmi_system_id __initconst=0A+hv_ut=
ils_dmi_table[] __maybe_unused  =3D {=0A+	{=0A+		.ident =3D =
"Hyper-V",=0A+		.matches =3D {=0A+			DMI_MATCH(D=
MI_SYS_VENDOR, "Microsoft Corporation"),=0A+			DMI_MATCH(D=
MI_PRODUCT_NAME, "Virtual Machine"),=0A+			DMI_MATCH(D=
MI_BOARD_NAME, "Virtual Machine"),=0A+		},=0A+	},=0A+	{ =
},=0A+};=0A+MODULE_DEVICE_TABLE(dmi, hv_utils_dmi_table);=0A+=0A+=0A+static=
 int __init init_hyperv_utils(void)=0A+{=0A+	printk(KERN_INFO "Registeri=
ng HyperV Utility Driver\n");=0A+=0A+	if (!dmi_check_system(hv_utils_dmi_=
table))=0A+		return -ENODEV;=0A+=0A+	hv_cb_utils[HV_SHUTDOWN_MSG=
].channel->OnChannelCallback =3D=0A+		&shutdown_onchannelcallback=
;=0A+	hv_cb_utils[HV_SHUTDOWN_MSG].callback =3D &shutdown_onchannelcallba=
ck;=0A+=0A+	hv_cb_utils[HV_TIMESYNC_MSG].channel->OnChannelCallback =
=3D=0A+		&timesync_onchannelcallback;=0A+	hv_cb_utils[HV_TIME=
SYNC_MSG].callback =3D &timesync_onchannelcallback;=0A+=0A+	hv_cb_utils=
[HV_HEARTBEAT_MSG].channel->OnChannelCallback =3D=0A+		&heartbeat_=
onchannelcallback;=0A+	hv_cb_utils[HV_HEARTBEAT_MSG].callback =3D =
&heartbeat_onchannelcallback;=0A+=0A+	return 0;=0A+}=0A+=0A+static void =
exit_hyperv_utils(void)=0A+{=0A+	printk(KERN_INFO "De-Registered =
HyperV Utility Driver\n");=0A+=0A+	hv_cb_utils[HV_SHUTDOWN_MSG].channe=
l->OnChannelCallback =3D=0A+		&chn_cb_negotiate;=0A+	hv_cb_utils=
[HV_SHUTDOWN_MSG].callback =3D &chn_cb_negotiate;=0A+=0A+	hv_cb_utils=
[HV_TIMESYNC_MSG].channel->OnChannelCallback =3D=0A+		&chn_cb_neg=
otiate;=0A+	hv_cb_utils[HV_TIMESYNC_MSG].callback =3D &chn_cb_negotiate=
;=0A+=0A+	hv_cb_utils[HV_HEARTBEAT_MSG].channel->OnChannelCallback =
=3D=0A+		&chn_cb_negotiate;=0A+	hv_cb_utils[HV_HEARTBEAT_MSG].callb=
ack =3D &chn_cb_negotiate;=0A+}=0A+=0A+module_init(init_hyperv_utils);=0A+m=
odule_exit(exit_hyperv_utils);=0A+=0A+MODULE_DESCRIPTION("Hyper-V =
Utilities");=0A+MODULE_VERSION(HV_DRV_VERSION);=0A+MODULE_LICENSE("GPL");=
=0AIndex: linux.trees.git/drivers/staging/hv/hv_utils.c=0A=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.git.orig/drivers/sta=
ging/hv/hv_utils.c	2010-11-15 08:24:46.000000000 -0500=0A+++ =
/dev/null	1970-01-01 00:00:00.000000000 +0000=0A@@ -1,311 +0,0 =
@@=0A-/*=0A- * Copyright (c) 2010, Microsoft Corporation.=0A- *=0A- * This =
program is free software; you can redistribute it and/or modify it=0A- * =
under the terms and conditions of the GNU General Public License,=0A- * =
version 2, as published by the Free Software Foundation.=0A- *=0A- * This =
program is distributed in the hope it will be useful, but WITHOUT=0A- * =
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or=0A- =
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License =
for=0A- * more details.=0A- *=0A- * You should have received a copy of the =
GNU General Public License along with=0A- * this program; if not, write to =
the Free Software Foundation, Inc., 59 Temple=0A- * Place - Suite 330, =
Boston, MA 02111-1307 USA.=0A- *=0A- * Authors:=0A- *   Haiyang Zhang =
<haiyangz@microsoft.com>=0A- *   Hank Janssen  <hjanssen@microsoft.com>=0A-=
 */=0A-#include <linux/kernel.h>=0A-#include <linux/init.h>=0A-#include =
<linux/module.h>=0A-#include <linux/slab.h>=0A-#include <linux/sysctl.h>=0A=
-#include <linux/reboot.h>=0A-#include <linux/dmi.h>=0A-#include <linux/pci=
.h>=0A-=0A-#include "logging.h"=0A-#include "osd.h"=0A-#include =
"vmbus.h"=0A-#include "vmbus_packet_format.h"=0A-#include "vmbus_channel_in=
terface.h"=0A-#include "version_info.h"=0A-#include "channel.h"=0A-#include=
 "vmbus_private.h"=0A-#include "vmbus_api.h"=0A-#include "utils.h"=0A-=0A-=
=0A-static void shutdown_onchannelcallback(void *context)=0A-{=0A-	=
struct vmbus_channel *channel =3D context;=0A-	u8 *buf;=0A-	u32 =
buflen, recvlen;=0A-	u64 requestid;=0A-	u8  execute_shutdown =3D =
false;=0A-=0A-	struct shutdown_msg_data *shutdown_msg;=0A-=0A-	struct =
icmsg_hdr *icmsghdrp;=0A-	struct icmsg_negotiate *negop =3D =
NULL;=0A-=0A-	buflen =3D PAGE_SIZE;=0A-	buf =3D kmalloc(buflen, =
GFP_ATOMIC);=0A-=0A-	vmbus_recvpacket(channel, buf, buflen, &recvlen, =
&requestid);=0A-=0A-	if (recvlen > 0) {=0A-		DPRINT_DBG(VMBUS, =
"shutdown packet: len=3D%d, requestid=3D%lld",=0A-			   =
recvlen, requestid);=0A-=0A-		icmsghdrp =3D (struct icmsg_hdr =
*)&buf[=0A-			sizeof(struct vmbuspipe_hdr)];=0A-=0A-		=
if (icmsghdrp->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {=0A-			=
prep_negotiate_resp(icmsghdrp, negop, buf);=0A-		} else {=0A-		=
	shutdown_msg =3D (struct shutdown_msg_data *)&buf[=0A-			=
	sizeof(struct vmbuspipe_hdr) +=0A-				=
sizeof(struct icmsg_hdr)];=0A-=0A-			switch (shutdown_ms=
g->flags) {=0A-			case 0:=0A-			case =
1:=0A-				icmsghdrp->status =3D HV_S_OK;=0A-		=
		execute_shutdown =3D true;=0A-=0A-				=
DPRINT_INFO(VMBUS, "Shutdown request received -"=0A-				=
	    " gracefull shutdown initiated");=0A-				=
break;=0A-			default:=0A-				=
icmsghdrp->status =3D HV_E_FAIL;=0A-				execute_shu=
tdown =3D false;=0A-=0A-				DPRINT_INFO(VMBUS, =
"Shutdown request received -"=0A-					   =
 " Invalid request");=0A-				break;=0A-		=
	};=0A-		}=0A-=0A-		icmsghdrp->icflags =3D =
ICMSGHDRFLAG_TRANSACTION=0A-			| ICMSGHDRFLAG_RESPONSE;=0A=
-=0A-		vmbus_sendpacket(channel, buf,=0A-				=
       recvlen, requestid,=0A-				       VmbusPacketT=
ypeDataInBand, 0);=0A-	}=0A-=0A-	kfree(buf);=0A-=0A-	if =
(execute_shutdown =3D=3D true)=0A-		orderly_poweroff(false);=0A=
-}=0A-=0A-/*=0A- * Set guest time to host UTC time.=0A- */=0A-static =
inline void do_adj_guesttime(u64 hosttime)=0A-{=0A-	s64 host_tns;=0A-	=
struct timespec host_ts;=0A-=0A-	host_tns =3D (hosttime - WLTIMEDELT=
A) * 100;=0A-	host_ts =3D ns_to_timespec(host_tns);=0A-=0A-	do_settimeo=
fday(&host_ts);=0A-}=0A-=0A-/*=0A- * Synchronize time with host after =
reboot, restore, etc.=0A- *=0A- * ICTIMESYNCFLAG_SYNC flag bit indicates =
reboot, restore events of the VM.=0A- * After reboot the flag ICTIMESYNCFLA=
G_SYNC is included in the first time=0A- * message after the timesync =
channel is opened. Since the hv_utils module is=0A- * loaded after =
hv_vmbus, the first message is usually missed. The other=0A- * thing is, =
systime is automatically set to emulated hardware clock which may=0A- * =
not be UTC time or in the same time zone. So, to override these effects, =
we=0A- * use the first 50 time samples for initial system time setting.=0A-=
 */=0A-static inline void adj_guesttime(u64 hosttime, u8 flags)=0A-{=0A-	=
static s32 scnt =3D 50;=0A-=0A-	if ((flags & ICTIMESYNCFLAG_SYNC) !=3D 0) =
{=0A-		do_adj_guesttime(hosttime);=0A-		return;=0A-	=
}=0A-=0A-	if ((flags & ICTIMESYNCFLAG_SAMPLE) !=3D 0 && scnt > 0) =
{=0A-		scnt--;=0A-		do_adj_guesttime(hosttime);=0A-	=
}=0A-}=0A-=0A-/*=0A- * Time Sync Channel message handler.=0A- */=0A-static =
void timesync_onchannelcallback(void *context)=0A-{=0A-	struct vmbus_channe=
l *channel =3D context;=0A-	u8 *buf;=0A-	u32 buflen, recvlen;=0A-	=
u64 requestid;=0A-	struct icmsg_hdr *icmsghdrp;=0A-	struct =
ictimesync_data *timedatap;=0A-=0A-	buflen =3D PAGE_SIZE;=0A-	=
buf =3D kmalloc(buflen, GFP_ATOMIC);=0A-=0A-	vmbus_recvpacket(channel, =
buf, buflen, &recvlen, &requestid);=0A-=0A-	if (recvlen > 0) {=0A-		=
DPRINT_DBG(VMBUS, "timesync packet: recvlen=3D%d, requestid=3D%lld",=0A-	=
		recvlen, requestid);=0A-=0A-		icmsghdrp =3D =
(struct icmsg_hdr *)&buf[=0A-				sizeof(struct =
vmbuspipe_hdr)];=0A-=0A-		if (icmsghdrp->icmsgtype =3D=3D =
ICMSGTYPE_NEGOTIATE) {=0A-			prep_negotiate_resp(icmsghd=
rp, NULL, buf);=0A-		} else {=0A-			timedatap =
=3D (struct ictimesync_data *)&buf[=0A-				sizeof(stru=
ct vmbuspipe_hdr) +=0A-				sizeof(struct icmsg_hdr)];=
=0A-			adj_guesttime(timedatap->parenttime, timedatap->fla=
gs);=0A-		}=0A-=0A-		icmsghdrp->icflags =3D =
ICMSGHDRFLAG_TRANSACTION=0A-			| ICMSGHDRFLAG_RESPONSE;=0A=
-=0A-		vmbus_sendpacket(channel, buf,=0A-				=
recvlen, requestid,=0A-				VmbusPacketTypeDataInBand, =
0);=0A-	}=0A-=0A-	kfree(buf);=0A-}=0A-=0A-/*=0A- * Heartbeat =
functionality.=0A- * Every two seconds, Hyper-V send us a heartbeat =
request message.=0A- * we respond to this message, and Hyper-V knows we =
are alive.=0A- */=0A-static void heartbeat_onchannelcallback(void =
*context)=0A-{=0A-	struct vmbus_channel *channel =3D context;=0A-	u8 =
*buf;=0A-	u32 buflen, recvlen;=0A-	u64 requestid;=0A-	=
struct icmsg_hdr *icmsghdrp;=0A-	struct heartbeat_msg_data =
*heartbeat_msg;=0A-=0A-	buflen =3D PAGE_SIZE;=0A-	buf =3D kmalloc(buf=
len, GFP_ATOMIC);=0A-=0A-	vmbus_recvpacket(channel, buf, buflen, =
&recvlen, &requestid);=0A-=0A-	if (recvlen > 0) {=0A-		DPRINT_DBG(=
VMBUS, "heartbeat packet: len=3D%d, requestid=3D%lld",=0A-			=
   recvlen, requestid);=0A-=0A-		icmsghdrp =3D (struct icmsg_hdr =
*)&buf[=0A-			sizeof(struct vmbuspipe_hdr)];=0A-=0A-		=
icmsghdrp =3D (struct icmsg_hdr *)&buf[=0A-				=
sizeof(struct vmbuspipe_hdr)];=0A-=0A-		if (icmsghdrp->icmsgtype =
=3D=3D ICMSGTYPE_NEGOTIATE) {=0A-			prep_negotiate_resp=
(icmsghdrp, NULL, buf);=0A-		} else {=0A-			=
heartbeat_msg =3D (struct heartbeat_msg_data *)&buf[=0A-			=
	sizeof(struct vmbuspipe_hdr) +=0A-				=
sizeof(struct icmsg_hdr)];=0A-=0A-			DPRINT_DBG(VMBUS, =
"heartbeat seq =3D %lld",=0A-				   heartbeat_msg->s=
eq_num);=0A-=0A-			heartbeat_msg->seq_num +=3D 1;=0A-	=
	}=0A-=0A-		icmsghdrp->icflags =3D ICMSGHDRFLAG_TRANSAC=
TION=0A-			| ICMSGHDRFLAG_RESPONSE;=0A-=0A-		=
vmbus_sendpacket(channel, buf,=0A-				       =
recvlen, requestid,=0A-				       VmbusPacketTypeDataI=
nBand, 0);=0A-	}=0A-=0A-	kfree(buf);=0A-}=0A-=0A-static const =
struct pci_device_id __initconst=0A-hv_utils_pci_table[] __maybe_unused =
=3D {=0A-	{ PCI_DEVICE(0x1414, 0x5353) }, /* Hyper-V emulated VGA =
controller */=0A-	{ 0 }=0A-};=0A-MODULE_DEVICE_TABLE(pci, hv_utils_pc=
i_table);=0A-=0A-=0A-static const struct dmi_system_id __initconst=0A-hv_ut=
ils_dmi_table[] __maybe_unused  =3D {=0A-	{=0A-		.ident =3D =
"Hyper-V",=0A-		.matches =3D {=0A-			DMI_MATCH(D=
MI_SYS_VENDOR, "Microsoft Corporation"),=0A-			DMI_MATCH(D=
MI_PRODUCT_NAME, "Virtual Machine"),=0A-			DMI_MATCH(D=
MI_BOARD_NAME, "Virtual Machine"),=0A-		},=0A-	},=0A-	{ =
},=0A-};=0A-MODULE_DEVICE_TABLE(dmi, hv_utils_dmi_table);=0A-=0A-=0A-static=
 int __init init_hyperv_utils(void)=0A-{=0A-	printk(KERN_INFO "Registeri=
ng HyperV Utility Driver\n");=0A-=0A-	if (!dmi_check_system(hv_utils_dmi_=
table))=0A-		return -ENODEV;=0A-=0A-	hv_cb_utils[HV_SHUTDOWN_MSG=
].channel->OnChannelCallback =3D=0A-		&shutdown_onchannelcallback=
;=0A-	hv_cb_utils[HV_SHUTDOWN_MSG].callback =3D &shutdown_onchannelcallba=
ck;=0A-=0A-	hv_cb_utils[HV_TIMESYNC_MSG].channel->OnChannelCallback =
=3D=0A-		&timesync_onchannelcallback;=0A-	hv_cb_utils[HV_TIME=
SYNC_MSG].callback =3D &timesync_onchannelcallback;=0A-=0A-	hv_cb_utils=
[HV_HEARTBEAT_MSG].channel->OnChannelCallback =3D=0A-		&heartbeat_=
onchannelcallback;=0A-	hv_cb_utils[HV_HEARTBEAT_MSG].callback =3D =
&heartbeat_onchannelcallback;=0A-=0A-	return 0;=0A-}=0A-=0A-static void =
exit_hyperv_utils(void)=0A-{=0A-	printk(KERN_INFO "De-Registered =
HyperV Utility Driver\n");=0A-=0A-	hv_cb_utils[HV_SHUTDOWN_MSG].channe=
l->OnChannelCallback =3D=0A-		&chn_cb_negotiate;=0A-	hv_cb_utils=
[HV_SHUTDOWN_MSG].callback =3D &chn_cb_negotiate;=0A-=0A-	hv_cb_utils=
[HV_TIMESYNC_MSG].channel->OnChannelCallback =3D=0A-		&chn_cb_neg=
otiate;=0A-	hv_cb_utils[HV_TIMESYNC_MSG].callback =3D &chn_cb_negotiate=
;=0A-=0A-	hv_cb_utils[HV_HEARTBEAT_MSG].channel->OnChannelCallback =
=3D=0A-		&chn_cb_negotiate;=0A-	hv_cb_utils[HV_HEARTBEAT_MSG].callb=
ack =3D &chn_cb_negotiate;=0A-}=0A-=0A-module_init(init_hyperv_utils);=0A-m=
odule_exit(exit_hyperv_utils);=0A-=0A-MODULE_DESCRIPTION("Hyper-V =
Utilities");=0A-MODULE_VERSION(HV_DRV_VERSION);=0A-MODULE_LICENSE("GPL");=
=0AIndex: linux.trees.git/drivers/staging/hv/Makefile=0A=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.git.orig/drivers/stagin=
g/hv/Makefile	2010-11-15 08:24:46.000000000 -0500=0A+++ linux.trees.git/d=
rivers/staging/hv/Makefile	2010-11-19 17:30:48.000000000 -0500=0A@@ =
-10,3 +10,4 @@ hv_vmbus-y :=3D vmbus_drv.o osd.o \=0A hv_storvsc-y :=3D =
storvsc_drv.o storvsc.o=0A hv_blkvsc-y :=3D blkvsc_drv.o blkvsc.o=0A =
hv_netvsc-y :=3D netvsc_drv.o netvsc.o rndis_filter.o=0A+hv_utils-y :=3D =
hv_util.o=0A
--=__Part220F893E.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__Part220F893E.0__=--
