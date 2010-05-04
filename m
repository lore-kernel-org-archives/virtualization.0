From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 2/3] implementation of IEEE 802.1Qbg in lldpad, part 1
Date: Tue,  4 May 2010 13:47:48 +0200
Message-ID: <1272973669-6694-3-git-send-email-jens@linux.vnet.ibm.com>
References: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
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
IEEE 802.1Qbg standard: It contains code for the exchange of EVB TLV
capabilities between a host with virtual machines and an adjacent switch.

Exchange of EVB TLV may be enabled or disabled on a per port basis.
Information about the information negotiated by the protocol can be
queried on the commandline with lldptool.

The patch applies to lldpad 0.9.34 and still contains code to log protocol
activity more verbosely than it would be necessary in the final version.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am             |   10 +-
 include/lldp.h          |   20 ++
 include/lldp_evb.h      |   58 +++++
 include/lldp_evb_clif.h |   33 +++
 include/lldp_evb_cmds.h |   31 +++
 include/lldp_tlv.h      |    1 +
 lldp_evb.c              |  567 +++++++++++++++++++++++++++++++++++++++++++++++
 lldp_evb_clif.c         |  232 +++++++++++++++++++
 lldp_evb_cmds.c         |  127 +++++++++++
 lldpad.c                |    2 +
 lldptool.c              |    2 +
 11 files changed, 1079 insertions(+), 4 deletions(-)
 create mode 100644 include/lldp_evb.h
 create mode 100644 include/lldp_evb_clif.h
 create mode 100644 include/lldp_evb_cmds.h
 create mode 100644 lldp_evb.c
 create mode 100644 lldp_evb_clif.c
 create mode 100644 lldp_evb_cmds.c

diff --git a/Makefile.am b/Makefile.am
index 68e4144..554baec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,7 +39,7 @@ lldpad_include_HEADERS = include/dcb_types.h include/dcbtool.h \
 include/dcb_osdep.h include/clif.h include/lldp_dcbx_cmds.h include/common.h \
 include/lldpad.h include/os.h include/includes.h include/lldp_mand_cmds.h \
 include/clif_msgs.h include/lldp_basman_cmds.h include/lldp_8023_cmds.h \
-include/lldp_med_cmds.h include/lldp_dcbx_cfg.h
+include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h
 
 noinst_HEADERS = include/config.h include/ctrl_iface.h \
 include/dcb_driver_if_types.h include/dcb_driver_interface.h \
@@ -49,7 +49,7 @@ include/event_iface.h include/messages.h include/parse_cli.h include/version.h \
 include/lldptool_cli.h include/list.h \
 include/lldp_mand_clif.h include/lldp_basman_clif.h include/lldp_med_clif.h \
 include/lldp_8023_clif.h include/lldp_dcbx_clif.h include/lldptool.h \
-include/lldp_rtnl.h
+include/lldp_rtnl.h include/lldp_evb_clif.h
 
 lldpad_SOURCES = lldpad.c config.c  drv_cfg.c ctrl_iface.c event_iface.c eloop.c \
 common.c os_unix.c lldp_dcbx_cmds.c log.c lldpad_shm.c \
@@ -64,10 +64,12 @@ lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
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
 
 
 
@@ -76,7 +78,7 @@ $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
 lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
-lldp_dcbx_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
+lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 nltest_SOURCES = nltest.c nltest.h
 
diff --git a/include/lldp.h b/include/lldp.h
index 66532bd..21347b0 100644
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
@@ -186,5 +188,23 @@ enum {
 #define LLDP_8023_LINKAGG_CAPABLE	(1 << 0)
 #define LLDP_8023_LINKAGG_ENABLED	(1 << 1)
 
+/* IEEE 802.1Qbg subtype */
+#define LLDP_EVB_SUBTYPE		0
+
+/* forwarding mode */
+#define LLDP_EVB_CAPABILITY_FORWARD_STANDARD		(1 << 7)
+#define LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY	(1 << 6)
+
+/* EVB supported protocols */
+#define LLDP_EVB_CAPABILITY_PROTOCOL_RTE		(1 << 3)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_ECP		(1 << 2)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_VDPL		(1 << 1)
+#define LLDP_EVB_CAPABILITY_PROTOCOL_VDP		(1 << 0)
+
+/* EVB specific values */
+#define LLDP_EVB_DEFAULT_MAX_VSI			4096
+#define LLDP_EVB_DEFAULT_SVSI				3295
+#define LLDP_EVB_DEFAULT_RTE				15
+
 void somethingChangedLocal(char *ifname);
 #endif /* _LLDP_H */
diff --git a/include/lldp_evb.h b/include/lldp_evb.h
new file mode 100644
index 0000000..3559dde
--- /dev/null
+++ b/include/lldp_evb.h
@@ -0,0 +1,58 @@
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
+struct evb_data {
+	char ifname[IFNAMSIZ];
+	struct unpacked_tlv *evb;
+	struct tlv_info_evb *tie;
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
+
+#endif /* _LLDP_EVB_H */
diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
new file mode 100644
index 0000000..56011d1
--- /dev/null
+++ b/include/lldp_evb_clif.h
@@ -0,0 +1,33 @@
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
+int evb_print_tlv(u32, u16, u8 *);
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
index 0000000..304a9f4
--- /dev/null
+++ b/lldp_evb.c
@@ -0,0 +1,567 @@
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
+#include "lldp.h"
+#include "lldp_evb.h"
+#include "messages.h"
+#include "config.h"
+#include "common.h"
+#include "lldp_evb_clif.h"
+#include "lldp_evb_cmds.h"
+
+extern struct lldp_head lldp_head;
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
+static struct evb_data *evb_data(const char *ifname)
+{
+	struct evb_user_data *ud;
+	struct evb_data *bd = NULL;
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
+	if (ud) {
+		LIST_FOREACH(bd, &ud->head, entry) {
+			if (!strncmp(ifname, bd->ifname, IFNAMSIZ))
+				return bd;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * evb_bld_cfg_tlv - build the EVB TLV
+ * @bd: the evb data struct
+ *
+ * Returns 0 on success
+ */
+static int evb_bld_cfg_tlv(struct evb_data *bd)
+{
+	int rc = 0;
+	int i;
+	struct unpacked_tlv *tlv = NULL;
+	struct tlv_info_evb evb;
+
+	/* free bd->evb if it exists */
+	FREE_UNPKD_TLV(bd, evb);
+
+	if (!is_tlv_txenabled(bd->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE))) {
+		fprintf(stderr, "### %s:%s:EVB Config disabled\n",
+			__func__, bd->ifname);
+		rc = EINVAL;
+		goto out_err;
+	}
+
+	/* load from config */
+	memset(&evb, 0, sizeof(evb));
+	if (get_config_tlvinfo_bin(bd->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
+			       (void *)&evb, sizeof(evb))) {
+		hton24(evb.oui, LLDP_MOD_EVB);
+		fprintf(stderr, "### %s:%s:Build EVB Config from scratch\n",
+			__func__, bd->ifname);
+		evb.sub = LLDP_EVB_SUBTYPE;
+		evb.smode = bd->tie->smode;
+		evb.scap = bd->tie->scap;
+		evb.cmode = bd->tie->cmode;
+		evb.ccap = bd->tie->ccap;
+		evb.svsi = bd->tie->svsi;
+		evb.cvsi = bd->tie->cvsi;
+		evb.rte = bd->tie->rte;
+	}
+
+	tlv = create_tlv();
+	if (!tlv)
+		goto out_err;
+
+	tlv->type = ORG_SPECIFIC_TLV;
+	tlv->length = sizeof(evb);
+	tlv->info = (u8 *)malloc(tlv->length);
+	if(!tlv->info) {
+		free(tlv);
+		tlv = NULL;
+		rc = ENOMEM;
+		goto out_err;
+	}
+	memcpy(tlv->info, &evb, tlv->length);
+
+	printf("### %s:type %i, length %i, info ", __func__, tlv->type, tlv->length);
+
+	for (i=0; i < tlv->length; i++) {
+		printf("%02x ", tlv->info[i]);
+	}
+
+	printf("\n");
+
+	bd->evb = tlv;
+out_err:
+	return rc;
+}
+
+static void evb_free_tlv(struct evb_data *bd)
+{
+	if (bd) {
+		FREE_UNPKD_TLV(bd, evb);
+	}
+}
+
+/* evb_init_cfg_tlv:
+ *
+ * fill up tlv_info_evb structure with reasonable info
+ */
+static int evb_init_cfg_tlv(struct evb_data *bd)
+{
+	bd->tie = (struct tlv_info_evb *) calloc(1, sizeof(struct tlv_info_evb));
+	if (!bd->tie)
+		return ENOMEM;
+
+	/* TODO: these should be set reasonable default, and must be able to change via config */
+	/* if possible, we request RR */
+	bd->tie->smode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
+	/* capabilities we support */
+	bd->tie->scap = LLDP_EVB_CAPABILITY_PROTOCOL_RTE | LLDP_EVB_CAPABILITY_PROTOCOL_ECP
+		| LLDP_EVB_CAPABILITY_PROTOCOL_VDP | LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
+	/* FIXME: for test: support something different than bridge */
+	bd->tie->svsi = LLDP_EVB_DEFAULT_SVSI;
+	bd->tie->rte = LLDP_EVB_DEFAULT_RTE;
+
+	return 0;
+}
+
+static int evb_bld_tlv(struct evb_data *bd)
+{
+	int rc = 0;
+
+	if (!port_find_by_name(bd->ifname)) {
+		rc = EEXIST;
+		goto out_err;
+	}
+
+	if (!init_cfg()) {
+		rc = ENOENT;
+		goto out_err;
+	}
+
+	if (evb_bld_cfg_tlv(bd)) {
+		fprintf(stderr, "### %s:%s:evb_bld_cfg_tlv() failed\n",
+				__func__, bd->ifname);
+		rc = EINVAL;
+		goto out_err_destroy;
+	}
+
+out_err_destroy:
+	destroy_cfg();
+
+out_err:
+	return rc;
+}
+
+static void evb_free_data(struct evb_user_data *ud)
+{
+	struct evb_data *bd;
+	if (ud) {
+		while (!LIST_EMPTY(&ud->head)) {
+			bd = LIST_FIRST(&ud->head);
+			LIST_REMOVE(bd, entry);
+			evb_free_tlv(bd);
+			free(bd);
+		}
+	}
+}
+
+struct packed_tlv *evb_gettlv(struct port *port)
+{
+	int size;
+	struct evb_data *bd;
+	struct packed_tlv *ptlv = NULL;
+
+	bd = evb_data(port->ifname);
+	if (!bd)
+		goto out_err;
+
+	evb_free_tlv(bd);
+
+	if (evb_bld_tlv(bd)) {
+		fprintf(stderr, "### %s:%s evb_bld_tlv failed\n",
+			__func__, port->ifname);
+		goto out_err;
+	}
+
+	size = TLVSIZE(bd->evb);
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
+	PACK_TLV_AFTER(bd->evb, ptlv, size, out_free);
+	return ptlv;
+out_free:
+	/* FIXME: free function returns pointer ? */
+	ptlv = free_pkd_tlv(ptlv);
+out_err:
+	fprintf(stderr,"### %s:%s: failed\n", __func__, port->ifname);
+	return NULL;
+
+}
+
+/* evb_check_and_fill
+ *
+ * checks values received in TLV and takes over some values
+ */
+int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
+{
+	if ((tie->smode & (LLDP_EVB_CAPABILITY_FORWARD_STANDARD |
+			  LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)) == 0)
+		return TLV_ERR;
+
+	if ((tie->scap & (LLDP_EVB_CAPABILITY_PROTOCOL_RTE |
+			  LLDP_EVB_CAPABILITY_PROTOCOL_ECP |
+			  LLDP_EVB_CAPABILITY_PROTOCOL_VDP |
+			  LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)) == 0)
+		return TLV_ERR;
+
+	if ((tie->svsi < 0) || (tie->svsi > LLDP_EVB_DEFAULT_MAX_VSI))
+		return TLV_ERR;
+
+	if ((tie->cvsi < 0) || (tie->cvsi > LLDP_EVB_DEFAULT_MAX_VSI))
+		return TLV_ERR;
+
+	/* If both sides support RR, set it */
+	if ((tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY) &&
+	    (ed->tie->smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)) {
+		ed->tie->cmode = LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY;
+	} else {
+		ed->tie->cmode = LLDP_EVB_CAPABILITY_FORWARD_STANDARD;
+	}
+
+	/* If both sides support RTE, set it */
+	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
+	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE))
+		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_RTE;
+
+	/* If both sides support ECP, set it */
+	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP) &&
+	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP))
+		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_ECP;
+
+	/* If both sides support VDPL, set it */
+	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL) &&
+	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL))
+		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDPL;
+
+	/* If both sides support VDP, set it */
+	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP) &&
+	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP))
+		ed->tie->ccap |= LLDP_EVB_CAPABILITY_PROTOCOL_VDP;
+
+	/* If supported caps include VDP take over min value of both */
+	if (tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		ed->tie->cvsi = MIN(ed->tie->svsi,tie->svsi);
+
+	/* If both sides support RTE and value offer is > 0, set it */
+	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
+	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
+		(tie->rte > 0))
+		ed->tie->rte = MIN(ed->tie->svsi,tie->rte);
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
+	if ((ed->tie->smode == tie->smode) &&
+	    (ed->tie->scap == tie->scap) &&
+	    (ed->tie->cmode == tie->cmode) &&
+	    (ed->tie->ccap == tie->ccap) &&
+	    (ed->tie->svsi == tie->svsi) &&
+	    (ed->tie->cvsi == tie->cvsi))
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
+		printf("%s: state -> EVB_OFFER_CAPABILITIES\n", __func__);
+		if (!evb_check_and_fill(ed, tie)) {
+			fprintf(stderr, "Invalid contents of EVB Cfg TLV !\n");
+			return;
+		}
+		somethingChangedLocal(ed->ifname); /* trigger tx with new values */
+		ed->state = EVB_CONFIGURE;
+		break;
+	case EVB_CONFIGURE:
+		/* we received a valid packet, if contents is same with our local settings
+		 * we can switch state to EVB_CONFIRMATION.*/
+		printf("%s: state -> EVB_CONFIGURE\n", __func__);
+		if (evb_compare(ed, tie)) {
+			ed->state= EVB_OFFER_CAPABILITIES;
+		} else {
+			printf("tlv_info_evb now equal !\n");
+			ed->state = EVB_CONFIRMATION;
+		}
+		somethingChangedLocal(ed->ifname);
+		break;
+	case EVB_CONFIRMATION:
+		/* we are already in confirmation and received a new packet with
+		 * different parameters ? Check parameters. switch state back to
+		 * EVB_CONFIGURE ? */
+		printf("%s: state -> EVB_CONFIRMATION\n", __func__);
+		break;
+	default:
+		fprintf(stderr, "EVB statemachine reached invalid state !\n");
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
+	int i, offset;
+	struct evb_data *ed;
+	struct tlv_info_evb *tie = (struct tlv_info_evb *) tlv->info;
+	u8 oui_subtype[OUI_SUB_SIZE] = LLDP_OUI_SUBTYPE;
+
+	ed = evb_data(port->ifname);
+
+	/* TODO: disable rx if tx has been disabled by administrator ?
+	if (!is_tlv_txenabled(ed->ifname, TLVID_8021(LLDP_EVB_SUBTYPE))) {
+		fprintf(stderr, "### %s:%s:EVB Config disabled\n",
+			__func__, ed->ifname);
+		return TLV_OK;
+	}
+	*/
+
+	if (!ed)
+		return SUBTYPE_INVALID;
+
+	fprintf(stderr, "%s:type %i, length %i, info ", __func__, tlv->type, tlv->length);
+
+	for (i=0; i < tlv->length; i++) {
+		fprintf(stderr, "%02x ", tlv->info[i]);
+	}
+
+	printf("\n");
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
+		/* decode values */
+		fprintf(stderr, "### %s:now ready to decode values !\n", __func__);
+
+		offset = OUI_SUB_SIZE;
+
+		/* received valid values, save them */
+		fprintf(stderr,"### supported forwarding mode: %02x\n", tie->smode);
+		fprintf(stderr,"### configured forwarding mode: %02x\n", tie->cmode);
+		fprintf(stderr,"### supported capabilities: %02x\n", tie->scap);
+		fprintf(stderr,"### configured capabilities: %02x\n", tie->ccap);
+		fprintf(stderr,"### supported no. of vsis: %04i\n", tie->svsi);
+		fprintf(stderr,"### configured no. of vsis: %04i\n", tie->cvsi);
+		fprintf(stderr,"### rte: %02i\n", tie->rte);
+
+		/* change state */
+		evb_statemachine(ed, tie);
+	}
+
+	return TLV_OK;
+}
+
+void evb_ifdown(char *ifname)
+{
+	struct evb_data *bd;
+
+	bd = evb_data(ifname);
+	if (!bd)
+		goto out_err;
+
+	LIST_REMOVE(bd, entry);
+	evb_free_tlv(bd);
+	free(bd);
+	fprintf(stderr, "### %s:port %s removed\n", __func__, ifname);
+	return;
+out_err:
+	fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);
+
+	return;
+}
+
+void evb_ifup(char *ifname)
+{
+	struct evb_data *bd;
+	struct evb_user_data *ud;
+
+	bd = evb_data(ifname);
+	if (bd) {
+		fprintf(stderr, "### %s:%s exists\n", __func__, ifname);
+		goto out_err;
+	}
+
+	/* not found, alloc/init per-port tlv data */
+	bd = (struct evb_data *) calloc(1, sizeof(struct evb_data));
+	if (!bd) {
+		fprintf(stderr, "### %s:%s malloc %ld failed\n",
+			 __func__, ifname, sizeof(*bd));
+		goto out_err;
+	}
+	strncpy(bd->ifname, ifname, IFNAMSIZ);
+
+	if (evb_init_cfg_tlv(bd)) {
+		fprintf(stderr, "### %s:%s evb_init_cfg_tlv failed\n", __func__, ifname);
+		free(bd);
+		goto out_err;
+	}
+
+	bd->state = EVB_OFFER_CAPABILITIES;
+
+	if (evb_bld_tlv(bd)) {
+		fprintf(stderr, "### %s:%s evb_bld_tlv failed\n", __func__, ifname);
+		free(bd);
+		goto out_err;
+	}
+
+	ud = find_module_user_data_by_if(ifname, &lldp_head, LLDP_MOD_EVB);
+	LIST_INSERT_HEAD(&ud->head, bd, entry);
+	fprintf(stderr, "### %s:port %s added\n", __func__, ifname);
+	return;
+
+out_err:
+	fprintf(stderr, "### %s:port %s adding failed\n", __func__, ifname);
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
+		fprintf(stderr, "failed to malloc module data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module data");
+		goto out_err;
+	}
+	ud = malloc(sizeof(struct evb_user_data));
+	if (!ud) {
+		free(mod);
+		fprintf(stderr, "failed to malloc module user data\n");
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to malloc module user data");
+		goto out_err;
+	}
+	LIST_INIT(&ud->head);
+	mod->id = LLDP_MOD_EVB;
+	mod->ops = &evb_ops;
+	mod->data = ud;
+	fprintf(stderr, "### %s:done\n", __func__);
+	return mod;
+
+out_err:
+	fprintf(stderr, "### %s:failed\n", __func__);
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
+	fprintf(stderr, "### %s:done\n", __func__);
+}
diff --git a/lldp_evb_clif.c b/lldp_evb_clif.c
new file mode 100644
index 0000000..d1773fe
--- /dev/null
+++ b/lldp_evb_clif.c
@@ -0,0 +1,232 @@
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
+		printf("supported forwarding mode:");
+
+		if (smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
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
+		printf("\tsupported capabilities:");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
+		     printf(" RTE");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+		     printf(" ECP");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)
+		     printf(" VDPL");
+
+		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		     printf(" VDP");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode scap !\n");
+	}
+
+	if (!hexstr2bin(info, &cmode, sizeof(cmode))) {
+		printf("\tconfigured forwarding mode:");
+
+		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
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
+	if (!hexstr2bin(info+4, &ccap, sizeof(ccap))) {
+		printf("\tconfigured capabilities:");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
+		     printf(" RTE");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_ECP)
+		     printf(" ECP");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_VDPL)
+		     printf(" VDPL");
+
+		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_VDP)
+		     printf(" VDP");
+
+		printf("\n");
+	} else {
+		printf("Unable to decode ccap !\n");
+	}
+
+	if (!hexstr2bin(info+8, (u16 *)&svsi, sizeof(svsi))) {
+		printf("\tno. of supported VSIs: %04i\n",svsi);
+	} else {
+		printf("Unable to decode svsi !\n");
+	}
+
+	if (!hexstr2bin(info+12, (u16 *)&cvsi, sizeof(cvsi))) {
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
+int evb_print_tlv(u32 tlvid, u16 len, u8 *info)
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
index 0000000..b6f6ad5
--- /dev/null
+++ b/lldp_evb_cmds.c
@@ -0,0 +1,127 @@
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
+static struct arg_handlers arg_handlers[] = {
+	{ ARG_TLVTXENABLE, get_arg_tlvtxenable, set_arg_tlvtxenable },
+	{ NULL }
+};
+
+static int get_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char *s;
+	char arg_path[256];
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_EVB << 8) | LLDP_EVB_SUBTYPE:
+		snprintf(arg_path, sizeof(arg_path), "%s%08x.%s",
+			 TLVID_PREFIX, cmd->tlvid, arg);
+
+		if (get_config_setting(cmd->ifname, arg_path, (void *)&value,
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
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char arg_path[256];
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
+	snprintf(arg_path, sizeof(arg_path), "%s%08x.%s", TLVID_PREFIX,
+		 cmd->tlvid, arg);
+
+	if (set_cfg(cmd->ifname, arg_path, (void *)&value, CONFIG_TYPE_BOOL))
+		return cmd_failed;
+
+	somethingChangedLocal(cmd->ifname);
+
+	return cmd_success;
+}
+
+struct arg_handlers *evb_get_arg_handlers()
+{
+	return &arg_handlers[0];
+}
diff --git a/lldpad.c b/lldpad.c
index e89abcd..711a995 100644
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
index a48df28..a06a279 100644
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
1.7.0.1
