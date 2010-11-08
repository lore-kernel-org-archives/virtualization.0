From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 2/9] implementation of IEEE 802.1Qbg in lldpad, part 1
Date: Mon,  8 Nov 2010 17:11:53 +0100
Message-ID: <1289232720-27443-3-git-send-email-jens@linux.vnet.ibm.com>
References: <1289232720-27443-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289232720-27443-1-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch contains the first part of an initial implementation of the
IEEE 802.1Qbg standard: it implements code for the exchange of EVB
capabilities between a host with virtual machines and an adjacent switch.
For this it adds a new EVB TLV to LLDP.

Exchange of EVB TLV may be enabled or disabled on a per port basis.
Information about the information negotiated by the protocol can be
queried on the commandline with lldptool.

This patch adds support for querying and setting parameters used in
the exchange of EVB TLV messages.
The parameters that can be set are:

	- forwarding mode
	- host protocol capabilities (RTE, ECP, VDP)
	- no. of supported VSIs
	- retransmission timer exponent (RTE)

The parameters are implemented as a local policy: all frames received by
an adjacent switch are validated against this policy and taken over where
appropriate. Negotiated parameters are stored in lldpads config, picked up
again and used at the next start.

The patch applies to lldpad 0.9.38 and still contains code to log protocol
activity more verbosely than it would be necessary in the final version.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am             |   10 +-
 include/lldp.h          |   19 ++
 include/lldp_evb.h      |   80 ++++++
 include/lldp_evb_clif.h |   51 ++++
 include/lldp_evb_cmds.h |   31 +++
 include/lldp_tlv.h      |    1 +
 lldp_evb.c              |  672 +++++++++++++++++++++++++++++++++++++++++++++++
 lldp_evb_clif.c         |  226 ++++++++++++++++
 lldp_evb_cmds.c         |  522 ++++++++++++++++++++++++++++++++++++
 lldpad.c                |    2 +
 lldptool.c              |    2 +
 11 files changed, 1612 insertions(+), 4 deletions(-)
 create mode 100644 include/lldp_evb.h
 create mode 100644 include/lldp_evb_clif.h
 create mode 100644 include/lldp_evb_cmds.h
 create mode 100644 lldp_evb.c
 create mode 100644 lldp_evb_clif.c
 create mode 100644 lldp_evb_cmds.c

diff --git a/Makefile.am b/Makefile.am
index 743e16f..d59a6fa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -37,7 +37,7 @@ lldpad_include_HEADERS = include/dcb_types.h include/dcbtool.h \
 include/dcb_osdep.h include/clif.h include/lldp_dcbx_cmds.h include/common.h \
 include/lldpad.h include/os.h include/includes.h include/lldp_mand_cmds.h \
 include/clif_msgs.h include/lldp_basman_cmds.h include/lldp_8023_cmds.h \
-include/lldp_med_cmds.h include/lldp_dcbx_cfg.h
+include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h
 
 noinst_HEADERS = include/config.h include/ctrl_iface.h \
 include/dcb_driver_if_types.h include/dcb_driver_interface.h \
@@ -47,7 +47,7 @@ include/event_iface.h include/messages.h include/parse_cli.h include/version.h \
 include/lldptool_cli.h include/list.h \
 include/lldp_mand_clif.h include/lldp_basman_clif.h include/lldp_med_clif.h \
 include/lldp_8023_clif.h include/lldp_dcbx_clif.h include/lldptool.h \
-include/lldp_rtnl.h
+include/lldp_rtnl.h include/lldp_evb_clif.h
 
 lldpad_SOURCES = lldpad.c config.c  drv_cfg.c ctrl_iface.c event_iface.c eloop.c \
 common.c os_unix.c lldp_dcbx_cmds.c log.c lldpad_shm.c \
@@ -62,10 +62,12 @@ lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
 lldp_util.c include/lldp_util.h \
 lldp_mand.c include/lldp_mand.h \
 lldp_mand_cmds.c lldp_basman_cmds.c lldp_8023_cmds.c lldp_med_cmds.c \
+lldp_evb_cmds.c \
 lldp_tlv.c include/lldp_tlv.h \
 lldp_basman.c include/lldp_basman.h	\
 lldp_med.c include/lldp_med.h \
-lldp_8023.c include/lldp_8023.h
+lldp_8023.c include/lldp_8023.h \
+lldp_evb.c include/lldp_evb.h
 
 
 
@@ -74,7 +76,7 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
 lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
-lldp_dcbx_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
+lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 nltest_SOURCES = nltest.c nltest.h
 
diff --git a/include/lldp.h b/include/lldp.h
index 66532bd..0371844 100644
--- a/include/lldp.h
+++ b/include/lldp.h
@@ -45,6 +45,8 @@
 /* Telecommunications Industry Association TR-41 Committee */
 #define OUI_TIA_TR41	0x0012bb
 
+#define OUI_IEEE_8021Qbg	0x001b3f
+
 /* IEEE 802.3AB Clause 9: TLV Types */
 #define CHASSIS_ID_TLV    1
 #define PORT_ID_TLV       2
@@ -186,5 +188,22 @@ enum {
 #define LLDP_8023_LINKAGG_CAPABLE	(1 << 0)
 #define LLDP_8023_LINKAGG_ENABLED	(1 << 1)
 
+/* IEEE 802.1Qbg subtype */
+#define LLDP_EVB_SUBTYPE		0
+
+/* forwarding mode */
+#define LLDP_EVB_CAPABILITY_FORWARD_STANDARD		(1 << 7)
+#define LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY	(1 << 6)
+
+/* EVB supported protocols */
+#define LLDP_EVB_CAPABILITY_PROTOCOL_RTE		(1 << 2)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_ECP		(1 << 1)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_VDP		(1 << 0)
+
+/* EVB specific values */
+#define LLDP_EVB_DEFAULT_MAX_VSI			65535
+#define LLDP_EVB_DEFAULT_SVSI				3295
+#define LLDP_EVB_DEFAULT_RTE				15
+
 void somethingChangedLocal(char *ifname);
 #endif /* _LLDP_H */
diff --git a/include/lldp_evb.h b/include/lldp_evb.h
new file mode 100644
index 0000000..667f9ad
--- /dev/null
+++ b/include/lldp_evb.h
@@ -0,0 +1,80 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#ifndef _LLDP_EVB_H
+#define _LLDP_EVB_H
+
+#include "lldp_mod.h"
+
+#define LLDP_MOD_EVB	OUI_IEEE_8021Qbg
+#define LLDP_OUI_SUBTYPE	{ 0x00, 0x1b, 0x3f, 0x00 }
+
+typedef enum {
+	EVB_OFFER_CAPABILITIES = 0,
+	EVB_CONFIGURE,
+	EVB_CONFIRMATION
+} evb_state;
+
+struct tlv_info_evb {
+	u8 oui[3];
+	u8 sub;
+	/* supported forwarding mode */
+	u8 smode;
+	/* supported capabilities */
+	u8 scap;
+	/* currently configured forwarding mode */
+	u8 cmode;
+	/* currently configured capabilities */
+	u8 ccap;
+	/* supported no. of vsi */
+	u16 svsi;
+	/* currently configured no. of vsi */
+	u16 cvsi;
+	/* retransmission exponent */
+	u8 rte;
+} __attribute__ ((__packed__));
+
+struct evb_data {
+	char ifname[IFNAMSIZ];
+	struct unpacked_tlv *evb;
+	struct tlv_info_evb *tie;
+	/* local policy */
+	struct tlv_info_evb *policy;
+	int state;
+	LIST_ENTRY(evb_data) entry;
+};
+
+struct evb_user_data {
+	LIST_HEAD(evb_head, evb_data) head;
+};
+
+struct lldp_module *evb_register(void);
+void evb_unregister(struct lldp_module *mod);
+struct packed_tlv *evb_gettlv(struct port *port);
+void evb_ifdown(char *);
+void evb_ifup(char *);
+struct evb_data *evb_data(char *ifname);
+
+#endif /* _LLDP_EVB_H */
diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
new file mode 100644
index 0000000..acaee5e
--- /dev/null
+++ b/include/lldp_evb_clif.h
@@ -0,0 +1,51 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#ifndef _LLDP_EVB_CLIF_H
+#define _LLDP_EVB_CLIF_H
+
+struct lldp_module *evb_cli_register(void);
+void evb_cli_unregister(struct lldp_module *);
+int evb_print_tlv(u32, u16, char *);
+
+#define EVB_BUF_SIZE			256
+
+#define ARG_EVB_FORWARDING_MODE		"fmode"
+
+#define VAL_EVB_FMODE_BRIDGE		"bridge"
+#define VAL_EVB_FMODE_REFLECTIVE_RELAY	"reflectiverelay"
+
+#define ARG_EVB_CAPABILITIES		"capabilities"
+
+#define VAL_EVB_CAPA_RTE		"rte"
+#define VAL_EVB_CAPA_ECP		"ecp"
+#define VAL_EVB_CAPA_VDP		"vdp"
+#define VAL_EVB_CAPA_NONE		"none"
+
+#define ARG_EVB_VSIS			"vsis"
+
+#define ARG_EVB_RTE			"rte"
+
+#endif
diff --git a/include/lldp_evb_cmds.h b/include/lldp_evb_cmds.h
new file mode 100644
index 0000000..1367e5d
--- /dev/null
+++ b/include/lldp_evb_cmds.h
@@ -0,0 +1,31 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#ifndef _LLDP_EVB_CMDS_H
+#define _LLDP_EVB_CMDS_H
+
+struct arg_handlers *evb_get_arg_handlers();
+
+#endif
diff --git a/include/lldp_tlv.h b/include/lldp_tlv.h
index a32cc71..fe3a75a 100644
--- a/include/lldp_tlv.h
+++ b/include/lldp_tlv.h
@@ -144,6 +144,7 @@ int tlv_ok(struct unpacked_tlv *tlv);
 #define TLVID_8021(sub)		TLVID(OUI_IEEE_8021, (sub))
 #define TLVID_8023(sub)		TLVID(OUI_IEEE_8023, (sub))
 #define TLVID_MED(sub)		TLVID(OUI_TIA_TR41, (sub))
+#define TLVID_8021Qbg(sub)	TLVID(OUI_IEEE_8021Qbg, (sub))
 
 /* the size in bytes needed for a packed tlv from unpacked tlv */
 #define TLVSIZE(t) ((t) ? (2 + (t)->length) : 0)
diff --git a/lldp_evb.c b/lldp_evb.c
new file mode 100644
index 0000000..50ee17d
--- /dev/null
+++ b/lldp_evb.c
@@ -0,0 +1,672 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#include <net/if.h>
+#include <sys/queue.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/utsname.h>
+#include <linux/if_bridge.h>
+#include <string.h>
+#include "lldp.h"
+#include "lldp_evb.h"
+#include "messages.h"
+#include "config.h"
+#include "common.h"
+#include "lldp_mand_clif.h"
+#include "lldp_evb_clif.h"
+#include "lldp_evb_cmds.h"
+
+extern struct lldp_head lldp_head;
+
+struct evb_data *evb_data(char *ifname)
+{
+	struct evb_user_data *ud;
+	struct evb_data *ed = NULL;
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
+	if (ud) {
+		LIST_FOREACH(ed, &ud->head, entry) {
+			if (!strncmp(ifname, ed->ifname, IFNAMSIZ))
+				return ed;
+		}
+	}
+	return NULL;
+}
+
+static void evb_print_tlvinfo(struct tlv_info_evb *tie)
+{
+	LLDPAD_INFO("%s(%i): supported forwarding mode: %02x\n", __FILE__, __LINE__,  tie->smode);
+	LLDPAD_INFO("%s(%i): configured forwarding mode: %02x\n", __FILE__, __LINE__,  tie->cmode);
+	LLDPAD_INFO("%s(%i): supported capabilities: %02x\n", __FILE__, __LINE__,  tie->scap);
+	LLDPAD_INFO("%s(%i): configured capabilities: %02x\n", __FILE__, __LINE__,  tie->ccap);
+	LLDPAD_INFO("%s(%i): supported no. of vsis: %04i\n", __FILE__, __LINE__,  tie->svsi);
+	LLDPAD_INFO("%s(%i): configured no. of vsis: %04i\n", __FILE__, __LINE__,  tie->cvsi);
+	LLDPAD_INFO("%s(%i): rte: %02i\n", __FILE__, __LINE__,  tie->rte);
+}
+
+static void evb_dump_tlv(struct unpacked_tlv *tlv)
+{
+	int i;
+	char *s, *t;
+
+	s = t = malloc(256);
+
+	 if (!s) {
+		LLDPAD_ERR("%s(%i): unable to allocate string !\n", __func__, __LINE__);
+	 }
+
+	LLDPAD_DBG("%s:type %i, length %i, info ", __func__, tlv->type, tlv->length);
+
+	for (i=0; i < tlv->length; i++) {
+		int c;
+		c = sprintf(s, "%02x ", tlv->info[i]);
+		s += c;
+	}
+
+	LLDPAD_DBG("%s\n", t);
+
+	free(t);
+}
+
+/*
+ * evb_bld_cfg_tlv - build the EVB TLV
+ * @ed: the evb data struct
+ *
+ * Returns 0 on success
+ */
+static int evb_bld_cfg_tlv(struct evb_data *ed)
+{
+	int rc = 0;
+	int i;
+	struct unpacked_tlv *tlv = NULL;
+
+	/* free ed->evb if it exists */
+	FREE_UNPKD_TLV(ed, evb);
+
+	if (!is_tlv_txenabled(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
+		LLDPAD_ERR("%s:%s:EVB tx is currently disabled !\n",
+			__func__, ed->ifname);
+		rc = EINVAL;
+		goto out_err;
+	}
+
+	if (ed->tie->smode != ed->policy->smode) {
+		ed->tie->smode = ed->policy->smode;
+		ed->state = EVB_OFFER_CAPABILITIES;
+	}
+
+	tlv = create_tlv();
+	if (!tlv)
+		goto out_err;
+
+	tlv->type = ORG_SPECIFIC_TLV;
+	tlv->length = sizeof(struct tlv_info_evb);
+	tlv->info = (u8 *)malloc(tlv->length);
+	if(!tlv->info) {
+		free(tlv);
+		tlv = NULL;
+		rc = ENOMEM;
+		goto out_err;
+	}
+	memcpy(tlv->info, ed->tie, tlv->length);
+
+	LLDPAD_DBG("%s(%i): TLV about to be sent out:", __func__, __LINE__);
+	evb_dump_tlv(tlv);
+
+	ed->evb = tlv;
+out_err:
+	return rc;
+}
+
+static void evb_free_tlv(struct evb_data *ed)
+{
+	if (ed)
+		FREE_UNPKD_TLV(ed, evb);
+}
+
+/* evb_init_cfg_tlv:
+ *
+ * fill up tlv_info_evb structure with reasonable info
+ */
+static int evb_init_cfg_tlv(struct evb_data *ed)
+{
+	char arg_path[EVB_BUF_SIZE];
+	char *param;
+
+	/* load policy from config */
+	ed->policy = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
+
+	if (!ed->policy)
+		return ENOMEM;
+
+	/* set defaults */
+	hton24(ed->policy->oui, LLDP_MOD_EVB);
+	ed->policy->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	ed->policy->scap = LLDP_EVB_CAPABILITY_PROTOCOL_RTE | LLDP_EVB_CAPABILITY_PROTOCOL_ECP |
+		LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+	ed->policy->cmode = 0;
+	ed->policy->ccap = 0;
+	ed->policy->svsi = LLDP_EVB_DEFAULT_SVSI;
+	ed->policy->rte = LLDP_EVB_DEFAULT_RTE;
+
+	/* pull forwarding mode into policy */
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.fmode",
+		 TLVID_PREFIX, TLVID_8021Qbg(LLDP_EVB_SUBTYPE));
+
+	if (get_cfg(ed->ifname, arg_path, (void *) &param, CONFIG_TYPE_STRING)) {
+		LLDPAD_WARN("%s:%s: loading EVB policy for forwarding mode failed, using default.\n",
+			__func__, ed->ifname);
+	} else {
+		if (strcasestr(param, VAL_EVB_FMODE_BRIDGE)) {
+			ed->policy->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+		}
+
+		if (strcasestr(param, VAL_EVB_FMODE_REFLECTIVE_RELAY)) {
+			ed->policy->smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
+		}
+
+		LLDPAD_DBG("%s:%s: policy param fmode = %s.\n", __func__, ed->ifname, param);
+		LLDPAD_DBG("%s:%s: policy param smode = %x.\n", __func__, ed->ifname, ed->policy->smode);
+	}
+
+	/* pull capabilities into policy */
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.capabilities",
+		 TLVID_PREFIX, TLVID_8021Qbg(LLDP_EVB_SUBTYPE));
+
+	if (get_cfg(ed->ifname, arg_path, (void *) &param, CONFIG_TYPE_STRING)) {
+		LLDPAD_WARN("%s:%s: loading EVB policy for capabilities failed, using default.\n",
+			__func__, ed->ifname);
+	} else {
+		if (strcasestr(param, VAL_EVB_CAPA_RTE)) {
+			ed->policy->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_RTE;
+		}
+
+		if (strcasestr(param, VAL_EVB_CAPA_ECP)) {
+			ed->policy->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
+		}
+
+		if (strcasestr(param, VAL_EVB_CAPA_VDP)) {
+			ed->policy->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+		}
+
+		LLDPAD_DBG("%s:%s: policy param capabilities = %s.\n", __func__, ed->ifname, param);
+		LLDPAD_DBG("%s:%s: policy param scap = %x.\n", __func__, ed->ifname, ed->policy->scap);
+	}
+
+	/* pull rte into policy */
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.rte",
+		 TLVID_PREFIX, TLVID_8021Qbg(LLDP_EVB_SUBTYPE));
+
+	if (get_cfg(ed->ifname, arg_path, (void *) &param, CONFIG_TYPE_STRING)) {
+		LLDPAD_WARN("%s:%s: loading EVB policy for rte failed, using default.\n",
+			__func__, ed->ifname);
+	} else {
+		ed->policy->rte = atoi(param);
+
+		LLDPAD_DBG("%s:%s: policy param rte = %s.\n", __func__, ed->ifname, param);
+		LLDPAD_DBG("%s:%s: policy param rte = %i.\n", __func__, ed->ifname, ed->policy->rte);
+	}
+
+	/* pull vsis into policy */
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.vsis",
+		 TLVID_PREFIX, TLVID_8021Qbg(LLDP_EVB_SUBTYPE));
+
+	if (get_cfg(ed->ifname, arg_path, (void *) &param, CONFIG_TYPE_STRING)) {
+		LLDPAD_WARN("%s:%s: loading EVB policy for vsis failed, using default.\n",
+			__func__, ed->ifname);
+	} else {
+		ed->policy->svsi = atoi(param);
+
+		LLDPAD_DBG("%s:%s: policy param vsis = %s.\n", __func__, ed->ifname, param);
+		LLDPAD_DBG("%s:%s: policy param vsis = %i.\n", __func__, ed->ifname, ed->policy->svsi);
+	}
+
+	/* load last used EVB TLV ... */
+	ed->tie = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
+
+	if (!ed->tie) {
+		free(ed->policy);
+		return ENOMEM;
+	}
+
+	if (get_config_tlvinfo_bin(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
+		LLDPAD_INFO("%s:%s: loading last used EVB TLV failed, using default.\n",
+			__func__, ed->ifname);
+		hton24(ed->tie->oui, LLDP_MOD_EVB);
+		ed->tie->smode = ed->policy->smode;
+		ed->tie->cmode = 0x0;
+		ed->tie->scap  = ed->policy->scap;
+		ed->tie->ccap = 0x0;
+		ed->tie->svsi = LLDP_EVB_DEFAULT_SVSI;
+		ed->tie->cvsi = 0x0;
+		ed->tie->rte = LLDP_EVB_DEFAULT_RTE;
+	} else {
+		LLDPAD_INFO("%s(%i): loaded last used EVB TLV from file.\n", __FILE__, __LINE__);
+	}
+
+	return 0;
+}
+
+static int evb_bld_tlv(struct evb_data *ed)
+{
+	int rc = 0;
+
+	if (!port_find_by_name(ed->ifname)) {
+		rc = EEXIST;
+		goto out_err;
+	}
+
+	if (!init_cfg()) {
+		rc = ENOENT;
+		goto out_err;
+	}
+
+	if (evb_bld_cfg_tlv(ed)) {
+		LLDPAD_ERR("%s:%s:evb_bld_cfg_tlv() failed\n",
+				__func__, ed->ifname);
+		rc = EINVAL;
+		goto out_err_destroy;
+	}
+
+	return rc;
+
+out_err_destroy:
+	destroy_cfg();
+out_err:
+	return rc;
+}
+
+static void evb_free_data(struct evb_user_data *ud)
+{
+	struct evb_data *ed;
+	if (ud) {
+		while (!LIST_EMPTY(&ud->head)) {
+			ed = LIST_FIRST(&ud->head);
+			LIST_REMOVE(ed, entry);
+			evb_free_tlv(ed);
+			free(ed);
+		}
+	}
+}
+
+struct packed_tlv *evb_gettlv(struct port *port)
+{
+	int size;
+	struct evb_data *ed;
+	struct packed_tlv *ptlv = NULL;
+
+	ed = evb_data(port->ifname);
+	if (!ed)
+		goto out_err;
+
+	evb_free_tlv(ed);
+
+	if (evb_bld_tlv(ed)) {
+		LLDPAD_ERR("%s:%s evb_bld_tlv failed\n",
+			__func__, port->ifname);
+		goto out_err;
+	}
+
+	size = TLVSIZE(ed->evb);
+
+	if (!size)
+		goto out_err;
+
+	ptlv = create_ptlv();
+	if (!ptlv)
+		goto out_err;
+
+	ptlv->tlv = malloc(size);
+	if (!ptlv->tlv)
+		goto out_free;
+
+	ptlv->size = 0;
+	PACK_TLV_AFTER(ed->evb, ptlv, size, out_free);
+	return ptlv;
+
+out_free:
+	/* FIXME: free function returns pointer ? */
+	ptlv = free_pkd_tlv(ptlv);
+out_err:
+	LLDPAD_ERR("%s:%s: failed\n", __func__, port->ifname);
+	return NULL;
+}
+
+/* evb_check_and_fill
+ *
+ * checks values received in TLV and takes over some values
+ */
+int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
+{
+	/* sanity check of received data in tie */
+	if ((tie->smode & (LLDP_EVB_CAPABILITY_FORWARD_STANDARD |
+			  LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)) == 0) {
+		LLDPAD_ERR("Neither standard nor rr set as forwarding mode !");
+		return TLV_ERR;
+	}
+
+	if ((tie->svsi < 0) || (tie->svsi > LLDP_EVB_DEFAULT_MAX_VSI)) {
+		LLDPAD_ERR("nr of supported vsis (%i) exceeds allow value range !", tie->svsi);
+		return TLV_ERR;
+	}
+
+	if ((tie->cvsi < 0) || (tie->cvsi > LLDP_EVB_DEFAULT_MAX_VSI)) {
+		LLDPAD_ERR("nr of configured vsis (%i) exceeds allow value range !", tie->cvsi);
+		return TLV_ERR;
+	}
+
+	/* check bridge capabilities against local policy*/
+	/* if bridge supports RR and we support it as well, request it
+	 * by setting smode in tlv to be sent out (ed->tie->smode) */
+	if ( (tie->smode & ed->policy->smode) ==
+	     LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY ) {
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
+	} else {
+		ed->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	}
+
+	/* If both sides support RTE, set it */
+	if ((tie->scap & ed->policy->scap) & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
+		ed->tie->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_RTE;
+
+	/* If both sides support ECP, set it */
+	if ((tie->scap & ed->policy->scap) & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+		ed->tie->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
+
+	/* If both sides support VDP, set it */
+	if ((tie->scap & ed->policy->scap) & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		ed->tie->scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+
+	/* If supported caps include VDP take over min value of both */
+	if (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		ed->tie->cvsi = MIN(ed->policy->svsi,tie->svsi);
+
+	/* If both sides support RTE and value offer is > 0, set it */
+	if ((ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
+		(tie->rte > 0) && (ed->policy->rte > 0))
+		ed->tie->rte = MAX(ed->policy->rte,tie->rte);
+
+	if (set_config_tlvinfo_bin(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
+		LLDPAD_ERR("%s(%i): error saving tlv_info_evb !\n", __FILE__, __LINE__);
+	} else {
+		LLDPAD_INFO("%s(%i): saved tlv_info_evb to config !\n", __FILE__, __LINE__);
+	}
+
+	/* maybe switch has already set the mode based on the saved info sent
+	 * out on ifup */
+
+	if (tie->cmode == ed->tie->smode)
+		ed->tie->cmode = tie->cmode;
+
+	return TLV_OK;
+}
+
+/* evb_compare
+ *
+ * compare our own and received tlv_info_evb
+ */
+static int evb_compare(struct evb_data *ed, struct tlv_info_evb *tie)
+{
+	LLDPAD_DBG("%s(%i): \n", __func__, __LINE__);
+
+	if (ed->tie->cmode == tie->cmode)
+		return 0;
+	else
+		return 1;
+}
+
+/* evb_statemachine:
+ *
+ * handle possible states during EVB capabilities exchange
+ *
+ * possible states:	EVB_OFFER_CAPABILITIES
+ *			EVB_CONFIGURE
+ *			EVB_CONFIRMATION
+ */
+static void evb_statemachine(struct evb_data *ed, struct tlv_info_evb *tie)
+{
+	switch(ed->state) {
+	case EVB_OFFER_CAPABILITIES:
+		/* waiting for valid packets to pour in
+		 * if valid packet was received,
+		 *		- check parameters with what we have offered for this if,
+		 *		- fill structure with data,
+		 *		- enable local tx
+		 *		- switch to EVB_CONFIGURE
+		 */
+		LLDPAD_DBG("%s: state -> EVB_OFFER_CAPABILITIES\n", __func__);
+		if (evb_check_and_fill(ed, tie) != TLV_OK) {
+			LLDPAD_ERR("Invalid contents of EVB Cfg TLV !\n");
+			return;
+		}
+		somethingChangedLocal(ed->ifname); /* trigger tx with new values */
+		ed->state = EVB_CONFIGURE;
+		break;
+	case EVB_CONFIGURE:
+		/* we received a valid packet, if contents is same with our local settings
+		 * we can switch state to EVB_CONFIRMATION.*/
+		LLDPAD_DBG("%s: state -> EVB_CONFIGURE\n", __func__);
+		if (evb_compare(ed, tie)) {
+			ed->state= EVB_OFFER_CAPABILITIES;
+		} else {
+			LLDPAD_ERR("tlv_info_evb now equal !\n");
+			ed->state = EVB_CONFIRMATION;
+		}
+		somethingChangedLocal(ed->ifname);
+		break;
+	case EVB_CONFIRMATION:
+		/* we are already in confirmation and received a new packet with
+		 * different parameters ? Check parameters. switch state back to
+		 * EVB_CONFIGURE ? */
+		LLDPAD_DBG("%s: state -> EVB_CONFIRMATION\n", __func__);
+		break;
+	default:
+		LLDPAD_ERR("EVB statemachine reached invalid state !\n");
+		break;
+	}
+}
+
+/*
+ * evb_rchange: process RX TLV LLDPDU
+ *
+ * TLV not consumed on error
+ */
+static int evb_rchange(struct port *port, struct unpacked_tlv *tlv)
+{
+	int i;
+	struct evb_data *ed;
+	struct tlv_info_evb *tie = (struct tlv_info_evb *) tlv->info;
+	u8 oui_subtype[OUI_SUB_SIZE] = LLDP_OUI_SUBTYPE;
+
+	if (!init_cfg()) {
+		return SUBTYPE_INVALID;
+	}
+
+	ed = evb_data(port->ifname);
+
+	if (!ed)
+		return SUBTYPE_INVALID;
+
+	if (tlv->type == TYPE_127) {
+		/* check for length */
+		if (tlv->length < (OUI_SUB_SIZE)) {
+			return TLV_ERR;
+		}
+
+		/* check for oui */
+		if (memcmp(tlv->info, &oui_subtype, OUI_SUB_SIZE)) {
+			return SUBTYPE_INVALID;
+		}
+
+		/* disable rx if tx has been disabled by administrator */
+		if (!is_tlv_txenabled(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
+			LLDPAD_WARN("%s:%s:EVB Config disabled\n",
+				__func__, ed->ifname);
+			return TLV_OK;
+		}
+
+		LLDPAD_DBG("%s(%i): received tlv:", __func__, __LINE__);
+		evb_dump_tlv(tlv);
+		evb_print_tlvinfo(tie);
+
+		/* change state */
+		evb_statemachine(ed, tie);
+
+		/* check which values have been taken over */
+		LLDPAD_DBG("%s(%i): new tlv:", __func__, __LINE__);
+		evb_print_tlvinfo(ed->tie);
+	}
+
+	return TLV_OK;
+}
+
+void evb_ifdown(char *ifname)
+{
+	struct evb_data *ed;
+
+	LLDPAD_DBG("%s called !\n", __func__);
+
+	ed = evb_data(ifname);
+	if (!ed)
+		goto out_err;
+
+	free(ed->policy);
+	free(ed->tie);
+	LIST_REMOVE(ed, entry);
+	evb_free_tlv(ed);
+	free(ed);
+	LLDPAD_INFO("%s:port %s removed\n", __func__, ifname);
+	return;
+out_err:
+	LLDPAD_ERR("%s:port %s remove failed\n", __func__, ifname);
+
+	return;
+}
+
+void evb_ifup(char *ifname)
+{
+	struct evb_data *ed;
+	struct evb_user_data *ud;
+
+	ed = evb_data(ifname);
+	if (ed) {
+		LLDPAD_DBG("%s:%s exists\n", __func__, ifname);
+		goto out_err;
+	}
+
+	/* not found, alloc/init per-port tlv data */
+	ed = (struct evb_data *) calloc(1, sizeof(struct evb_data));
+	if (!ed) {
+		LLDPAD_ERR("%s:%s malloc %ld failed\n",
+			 __func__, ifname, sizeof(*ed));
+		goto out_err;
+	}
+	strncpy(ed->ifname, ifname, IFNAMSIZ);
+
+	if (!init_cfg()) {
+		LLDPAD_ERR("%s:%s init_cfg failed\n", __func__, ifname);
+		goto out_free;
+	}
+
+	if (evb_init_cfg_tlv(ed)) {
+		LLDPAD_ERR("%s:%s evb_init_cfg_tlv failed\n", __func__, ifname);
+		goto out_free;
+	}
+
+	ed->state = EVB_OFFER_CAPABILITIES;
+
+	if (evb_bld_tlv(ed)) {
+		LLDPAD_ERR("%s:%s evb_bld_tlv failed\n", __func__, ifname);
+		goto out_free;
+	}
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
+	LIST_INSERT_HEAD(&ud->head, ed, entry);
+	LLDPAD_DBG("%s:port %s added\n", __func__, ifname);
+	return;
+
+out_free:
+	free(ed->tie);
+	free(ed->policy);
+	free(ed);
+
+out_err:
+	return;
+}
+
+static const struct lldp_mod_ops evb_ops =  {
+	.lldp_mod_register	= evb_register,
+	.lldp_mod_unregister	= evb_unregister,
+	.lldp_mod_gettlv	= evb_gettlv,
+	.lldp_mod_rchange	= evb_rchange,
+	.lldp_mod_ifup		= evb_ifup,
+	.lldp_mod_ifdown	= evb_ifdown,
+	.get_arg_handler	= evb_get_arg_handlers,
+};
+
+struct lldp_module *evb_register(void)
+{
+	struct lldp_module *mod;
+	struct evb_user_data *ud;
+
+	mod = malloc(sizeof(*mod));
+	if (!mod) {
+		LLDPAD_ERR("failed to malloc module data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module data");
+		goto out_err;
+	}
+	ud = malloc(sizeof(struct evb_user_data));
+	if (!ud) {
+		free(mod);
+		LLDPAD_ERR("failed to malloc module user data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module user data");
+		goto out_err;
+	}
+	LIST_INIT(&ud->head);
+	mod->id = LLDP_MOD_EVB;
+	mod->ops = &evb_ops;
+	mod->data = ud;
+	LLDPAD_DBG("%s:done\n", __func__);
+	return mod;
+
+out_err:
+	LLDPAD_ERR("%s:failed\n", __func__);
+	return NULL;
+}
+
+void evb_unregister(struct lldp_module *mod)
+{
+	if (mod->data) {
+		evb_free_data((struct evb_user_data *) mod->data);
+		free(mod->data);
+	}
+	free(mod);
+	LLDPAD_DBG("%s:done", __func__);
+}
diff --git a/lldp_evb_clif.c b/lldp_evb_clif.c
new file mode 100644
index 0000000..7479d74
--- /dev/null
+++ b/lldp_evb_clif.c
@@ -0,0 +1,226 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#include "includes.h"
+#include "common.h"
+#include <stdio.h>
+#include <syslog.h>
+#include <sys/un.h>
+#include <sys/stat.h>
+#include "lldp_mod.h"
+#include "lldptool.h"
+#include "lldp.h"
+#include "lldp_evb.h"
+#include "lldp_evb_clif.h"
+
+void evb_print_cfg_tlv(u16, char *info);
+int evb_print_help();
+
+u32 evb_lookup_tlv_name(char *tlvid_str);
+
+static const struct lldp_mod_ops evb_ops_clif = {
+	.lldp_mod_register	= evb_cli_register,
+	.lldp_mod_unregister	= evb_cli_unregister,
+	.print_tlv		= evb_print_tlv,
+	.lookup_tlv_name	= evb_lookup_tlv_name,
+	.print_help		= evb_print_help,
+};
+
+struct type_name_info evb_tlv_names[] = {
+	{ (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE,
+		"EVB Configuration TLV",
+		"evbCfg", evb_print_cfg_tlv },
+	{ INVALID_TLVID,     NULL,        NULL }
+};
+
+int evb_print_help()
+{
+	struct type_name_info *tn = &evb_tlv_names[0];
+
+	while (tn->type != INVALID_TLVID) {
+		if (tn->key && strlen(tn->key) && tn->name) {
+			printf("   %s", tn->key);
+			if (strlen(tn->key)+3 <= 8)
+				printf("\t");
+			printf("\t: %s\n", tn->name);
+		}
+		tn++;
+	}
+
+	return 0;
+}
+
+struct lldp_module *evb_cli_register(void)
+{
+	struct lldp_module *mod;
+
+	mod = malloc(sizeof(*mod));
+	if (!mod) {
+		fprintf(stderr, "failed to malloc module data\n");
+		return NULL;
+	}
+	mod->id = LLDP_MOD_EVB;
+	mod->ops = &evb_ops_clif;
+
+	return mod;
+}
+
+void evb_cli_unregister(struct lldp_module *mod)
+{
+	free(mod);
+}
+
+void evb_print_cfg_tlv(u16 len, char *info)
+{
+	u8 smode;
+	u8 scap;
+	u8 cmode;
+	u8 ccap;
+	u16 svsi;
+	u16 cvsi;
+	u8 rte;
+
+	if (len != 9) {
+		printf("Bad Cfg TLV: %s\n", info);
+		return;
+	}
+
+	if (!hexstr2bin(info, &smode, sizeof(smode))) {
+		printf("supported forwarding mode: (0x%02hhx)", smode);
+
+		if (smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
+			printf(" reflective relay");
+
+		if (smode & LLDP_EVB_CAPABILITY_FORWARD_STANDARD)
+			printf(" standard 802.1Q");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode smode !\n");
+	}
+
+	if (!hexstr2bin(info+2, &scap, sizeof(scap))) {
+		printf("\tsupported capabilities: (0x%02hhx)", scap);
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
+		     printf(" RTE");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+		     printf(" ECP");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		     printf(" VDP");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode scap !\n");
+	}
+
+	if (!hexstr2bin(info+4, &cmode, sizeof(cmode))) {
+		printf("\tconfigured forwarding mode: (0x%02hhx)", cmode);
+
+		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
+			printf(" reflective relay");
+
+		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_STANDARD)
+			printf(" standard 802.1Q");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode cmode !\n");
+	}
+
+	if (!hexstr2bin(info+6, &ccap, sizeof(ccap))) {
+		printf("\tconfigured capabilities: (0x%02hhx)", ccap);
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
+		     printf(" RTE");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+		     printf(" ECP");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		     printf(" VDP");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode ccap !\n");
+	}
+
+	if (!hexstr2bin(info+8, (u8 *)&svsi, sizeof(svsi))) {
+		printf("\tno. of supported VSIs: %04i\n",svsi);
+	} else {
+		printf("Unable to decode svsi !\n");
+	}
+
+	if (!hexstr2bin(info+12, (u8 *)&cvsi, sizeof(cvsi))) {
+		printf("\tno. of configured VSIs: %04i\n",cvsi);
+	} else {
+		printf("Unable to decode cvsi !\n");
+	}
+
+	if (!hexstr2bin(info+16, &rte, sizeof(rte))) {
+		printf("\tRTE: %i\n",rte);
+	} else {
+		printf("Unable to decode cvsi !\n");
+	}
+
+	printf("\n");
+}
+
+/* return 1: if it printed the TLV
+ *        0: if it did not
+ */
+int evb_print_tlv(u32 tlvid, u16 len, char *info)
+{
+	struct type_name_info *tn = &evb_tlv_names[0];
+
+	while (tn->type != INVALID_TLVID) {
+		if (tlvid == tn->type) {
+			printf("%s\n", tn->name);
+			if (tn->print_info) {
+				printf("\t");
+				tn->print_info(len-4, info);
+			}
+			return 1;
+		}
+		tn++;
+	}
+
+	return 0;
+}
+
+u32 evb_lookup_tlv_name(char *tlvid_str)
+{
+	struct type_name_info *tn = &evb_tlv_names[0];
+
+	while (tn->type != INVALID_TLVID) {
+		if (!strcasecmp(tn->key, tlvid_str))
+			return tn->type;
+		tn++;
+	}
+	return INVALID_TLVID;
+}
+
diff --git a/lldp_evb_cmds.c b/lldp_evb_cmds.c
new file mode 100644
index 0000000..bee0ec8
--- /dev/null
+++ b/lldp_evb_cmds.c
@@ -0,0 +1,522 @@
+/*******************************************************************************
+
+  implementation of EVB TLVs for LLDP
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms and conditions of the GNU General Public License,
+  version 2, as published by the Free Software Foundation.
+
+  This program is distributed in the hope it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+  more details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc.,
+  51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+  The full GNU General Public License is included in this distribution in
+  the file called "COPYING".
+
+*******************************************************************************/
+
+#include "includes.h"
+#include "common.h"
+#include <stdio.h>
+#include <syslog.h>
+#include <sys/un.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+#include <string.h>
+#include "lldpad.h"
+#include "ctrl_iface.h"
+#include "lldp.h"
+#include "lldp_evb.h"
+#include "lldp_mand_clif.h"
+#include "lldp_evb_clif.h"
+#include "lldp/ports.h"
+#include "libconfig.h"
+#include "config.h"
+#include "clif_msgs.h"
+#include "lldp/states.h"
+
+static int get_arg_tlvtxenable(struct cmd *, char *, char *, char *);
+static int set_arg_tlvtxenable(struct cmd *, char *, char *, char *);
+
+static int get_arg_fmode(struct cmd *, char *, char *, char *);
+static int set_arg_fmode(struct cmd *, char *, char *, char *);
+
+static int get_arg_rte(struct cmd *, char *, char *, char *);
+static int set_arg_rte(struct cmd *, char *, char *, char *);
+
+static int get_arg_vsis(struct cmd *, char *, char *, char *);
+static int set_arg_vsis(struct cmd *, char *, char *, char *);
+
+static int get_arg_capabilities(struct cmd *, char *, char *, char *);
+static int set_arg_capabilities(struct cmd *, char *, char *, char *);
+
+static struct arg_handlers arg_handlers[] = {
+	{ ARG_EVB_FORWARDING_MODE, get_arg_fmode, set_arg_fmode },
+	{ ARG_EVB_CAPABILITIES, get_arg_capabilities, set_arg_capabilities },
+	{ ARG_EVB_VSIS, get_arg_vsis, set_arg_vsis },
+	{ ARG_EVB_RTE, get_arg_rte, set_arg_rte },
+	{ ARG_TLVTXENABLE, get_arg_tlvtxenable, set_arg_tlvtxenable },
+	{ NULL }
+};
+
+static int get_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char *s;
+	char arg_path[EVB_BUF_SIZE];
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		snprintf(arg_path, sizeof(arg_path), "%s%08x.%s",
+			 TLVID_PREFIX, cmd->tlvid, arg);
+
+		if (get_cfg(cmd->ifname, arg_path, (void *)&value,
+					CONFIG_TYPE_BOOL))
+			value = false;
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	if (value)
+		s = VAL_YES;
+	else
+		s = VAL_NO;
+
+	sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
+		(unsigned int) strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char arg_path[EVB_BUF_SIZE];
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	if (!strcasecmp(argvalue, VAL_YES))
+		value = 1;
+	else if (!strcasecmp(argvalue, VAL_NO))
+		value = 0;
+	else
+		return cmd_invalid;
+
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.%s",
+		 TLVID_PREFIX, cmd->tlvid, arg);
+
+	if (set_cfg(cmd->ifname, arg_path, (void *)&value, CONFIG_TYPE_BOOL))
+		return cmd_failed;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+static int get_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char *s;
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	if (ed->policy->smode & LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY)
+		s = VAL_EVB_FMODE_REFLECTIVE_RELAY;
+	else
+		s = VAL_EVB_FMODE_BRIDGE;
+
+	sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
+		(unsigned int) strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_fmode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	u8 smode;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	smode = 0;
+
+	if (!strcasecmp(argvalue, VAL_EVB_FMODE_BRIDGE)) {
+		smode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	}
+
+	if (!strcasecmp(argvalue, VAL_EVB_FMODE_REFLECTIVE_RELAY)) {
+		smode = LLDP_EVB_CAPABILITY_FORWARD_REFLECTIVE_RELAY;
+	}
+
+	if (smode == 0) {
+		return cmd_invalid;
+	} else {
+		ed->policy->smode = smode;
+	}
+
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.fmode",
+		 TLVID_PREFIX, cmd->tlvid);
+
+	if (set_cfg(ed->ifname, arg_path, (void *) &argvalue, CONFIG_TYPE_STRING)) {
+		printf("%s:%s: saving EVB forwarding mode failed.\n",
+			__func__, ed->ifname);
+		return cmd_invalid;
+	}
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+static int get_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int c;
+	char *s, *t;
+	struct evb_data *ed;
+
+	printf("%s(%i): arg %s, argvalue %s !\n", __func__, __LINE__, arg, argvalue);
+
+	s = t = malloc(EVB_BUF_SIZE);
+
+	if (!s)
+		goto out_free;
+
+	memset(s, 0, EVB_BUF_SIZE);
+
+	if (cmd->cmd != cmd_gettlv)
+		goto out_free;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		goto out_free;
+	default:
+		free(t);
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		goto out_free;
+
+	if (ed->policy->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) {
+		c = sprintf(s, VAL_EVB_CAPA_RTE " ");
+		if (c <= 0)
+			goto out_free;
+		s += c;
+	}
+
+	if (ed->policy->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP) {
+		c = sprintf(s, VAL_EVB_CAPA_ECP " ");
+		if (c <= 0)
+			goto out_free;
+		s += c;
+	}
+
+	if (ed->policy->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP) {
+		c = sprintf(s, VAL_EVB_CAPA_VDP " ");
+		if (c <= 0)
+			goto out_free;
+		s += c;
+	}
+
+	sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
+		(unsigned int) strlen(t), t);
+
+	free(t);
+	return cmd_success;
+
+out_free:
+	free(t);
+	return cmd_invalid;
+}
+
+static int set_arg_capabilities(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	u8 scap = 0;
+	char arg_path[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_RTE))
+		scap |= LLDP_EVB_CAPABILITY_PROTOCOL_RTE;
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_ECP))
+		scap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
+
+	if (strcasestr(argvalue, VAL_EVB_CAPA_VDP))
+		scap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+
+	ed->policy->scap = scap;
+
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.capabilities",
+		 TLVID_PREFIX, cmd->tlvid);
+
+	if (set_cfg(ed->ifname, arg_path, (void *) &argvalue, CONFIG_TYPE_STRING)) {
+		printf("%s:%s: saving EVB capabilities failed.\n",
+			__func__, ed->ifname);
+		return cmd_invalid;
+	}
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+static int get_arg_rte(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char s[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+
+	if (sprintf(s, "%i", ed->policy->rte) <= 0)
+		return cmd_invalid;
+
+	sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
+		(unsigned int) strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_rte(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value, err;
+	char arg_path[EVB_BUF_SIZE];
+	char svalue[10];
+	struct evb_data *ed = NULL;
+
+	if (cmd->cmd != cmd_settlv)
+		goto out_err;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		goto out_err;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	value = atoi(argvalue);
+
+	if ((value < 0))
+		goto out_err;
+
+	ed->policy->rte = value;
+
+	err = snprintf(arg_path, sizeof(arg_path), "%s%08x.rte",
+		       TLVID_PREFIX, cmd->tlvid);
+
+	if (err < 0)
+		goto out_err;
+
+	err = snprintf(svalue, sizeof(svalue), "%i", value);
+
+	if (err < 0)
+		goto out_err;
+
+	if (set_cfg(ed->ifname, arg_path, (void *) svalue, CONFIG_TYPE_STRING))
+		goto out_err;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+
+out_err:
+	printf("%s:%s: saving EVB rte failed.\n", __func__, ed->ifname);
+	return cmd_invalid;
+}
+
+static int get_arg_vsis(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char s[EVB_BUF_SIZE];
+	struct evb_data *ed;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	ed = evb_data((char *) &cmd->ifname);
+	if (!ed)
+		return cmd_invalid;
+
+	if (sprintf(s, "%04i", ed->policy->svsi) <= 0)
+		return cmd_invalid;
+
+	sprintf(obuf, "%02x%s%04x%s", (unsigned int) strlen(arg), arg,
+		(unsigned int) strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_vsis(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value, err;
+	char arg_path[EVB_BUF_SIZE];
+	char svalue[10];
+	char *sv;
+	struct evb_data *ed = NULL;
+
+	ed = evb_data((char *) &cmd->ifname);
+
+	if (!ed)
+		return cmd_invalid;
+
+	if (cmd->cmd != cmd_settlv)
+		goto out_err;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		goto out_err;
+	default:
+		return cmd_not_applicable;
+	}
+
+	value = atoi(argvalue);
+
+	if ((value < 0) || (value > LLDP_EVB_DEFAULT_MAX_VSI))
+		goto out_err;
+
+	ed->policy->svsi = value;
+
+	err = snprintf(arg_path, sizeof(arg_path), "%s%08x.vsis",
+		       TLVID_PREFIX, cmd->tlvid);
+
+	if (err < 0)
+		goto out_err;
+
+	err = snprintf(svalue, sizeof(svalue), "%i", value);
+
+	if (err < 0)
+		goto out_err;
+
+	sv = &svalue[0];
+
+	if (set_cfg(ed->ifname, arg_path, (void *) &sv, CONFIG_TYPE_STRING))
+		goto out_err;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+
+out_err:
+	printf("%s:%s: saving EVB vsis failed.\n", __func__, ed->ifname);
+	return cmd_invalid;
+}
+
+struct arg_handlers *evb_get_arg_handlers()
+{
+	return &arg_handlers[0];
+}
diff --git a/lldpad.c b/lldpad.c
index a89b5a4..571da31 100644
--- a/lldpad.c
+++ b/lldpad.c
@@ -49,6 +49,7 @@
 #include "lldp_dcbx.h"
 #include "lldp_med.h"
 #include "lldp_8023.h"
+#include "lldp_evb.h"
 #include "config.h"
 #include "lldpad_shm.h"
 #include "clif.h"
@@ -63,6 +64,7 @@ struct lldp_module *(*register_tlv_table[])(void) = {
 	dcbx_register,
 	med_register,
 	ieee8023_register,
+	evb_register,
 	NULL,
 };
 
diff --git a/lldptool.c b/lldptool.c
index 5cf2846..7e166fe 100644
--- a/lldptool.c
+++ b/lldptool.c
@@ -39,6 +39,7 @@
 #include "lldp_med_clif.h"
 #include "lldp_8023_clif.h"
 #include "lldp_dcbx_clif.h"
+#include "lldp_evb_clif.h"
 #include "lldptool.h"
 #include "lldptool_cli.h"
 #include "lldp_mod.h"
@@ -156,6 +157,7 @@ struct lldp_module *(*register_tlv_table[])(void) = {
 	ieee8023_cli_register,
 	med_cli_register,
 	dcbx_cli_register,
+	evb_cli_register,
 	NULL,
 };
 
-- 
1.7.1
