From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 3/3] VDP commandline interface
Date: Thu, 17 Jun 2010 15:57:11 +0200
Message-ID: <1276783031-10239-4-git-send-email-jens@linux.vnet.ibm.com>
References: <1276783031-10239-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1276783031-10239-1-git-send-email-jens@linux.vnet.ibm.com>
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

This patch implements the command line interface to control the VDP module.
In station role, it allows to register a new VSI (guest interface) profile
and query its state. In bridge role, it allows to query the state of all
registered profiles.
With lldptool it is possible to set the role from default "station" to
"bridge".
The configuration of the role for a port is saved to lldpads config file.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 Makefile.am             |   12 +-
 include/lldp_vdp_clif.h |   38 +++++
 include/lldp_vdp_cmds.h |   44 ++++++
 lldp_vdp_clif.c         |  136 ++++++++++++++++
 lldp_vdp_cmds.c         |  392 +++++++++++++++++++++++++++++++++++++++++++++++
 lldptool.c              |    2 +
 6 files changed, 619 insertions(+), 5 deletions(-)
 create mode 100644 include/lldp_vdp_clif.h
 create mode 100644 include/lldp_vdp_cmds.h
 create mode 100644 lldp_vdp_clif.c
 create mode 100644 lldp_vdp_cmds.c

diff --git a/Makefile.am b/Makefile.am
index e2ecce4..d16f9f2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,7 +39,8 @@ lldpad_include_HEADERS = include/dcb_types.h include/dcbtool.h \
 include/dcb_osdep.h include/clif.h include/lldp_dcbx_cmds.h include/common.h \
 include/lldpad.h include/os.h include/includes.h include/lldp_mand_cmds.h \
 include/clif_msgs.h include/lldp_basman_cmds.h include/lldp_8023_cmds.h \
-include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h
+include/lldp_med_cmds.h include/lldp_dcbx_cfg.h include/lldp_evb_cmds.h \
+include/lldp_vdp_cmds.h
 
 noinst_HEADERS = include/config.h include/ctrl_iface.h \
 include/dcb_driver_if_types.h include/dcb_driver_interface.h \
@@ -49,7 +50,7 @@ include/event_iface.h include/messages.h include/parse_cli.h include/version.h \
 include/lldptool_cli.h include/list.h \
 include/lldp_mand_clif.h include/lldp_basman_clif.h include/lldp_med_clif.h \
 include/lldp_8023_clif.h include/lldp_dcbx_clif.h include/lldptool.h \
-include/lldp_rtnl.h include/lldp_evb_clif.h
+include/lldp_rtnl.h include/lldp_evb_clif.h include/lldp_vdp_clif.h
 
 lldpad_SOURCES = lldpad.c config.c  drv_cfg.c ctrl_iface.c event_iface.c eloop.c \
 common.c os_unix.c lldp_dcbx_cmds.c log.c lldpad_shm.c \
@@ -66,20 +67,21 @@ lldp_dcbx_cfg.c include/lldp_dcbx_cfg.h \
 lldp_util.c include/lldp_util.h \
 lldp_mand.c include/lldp_mand.h \
 lldp_mand_cmds.c lldp_basman_cmds.c lldp_8023_cmds.c lldp_med_cmds.c \
-lldp_evb_cmds.c \
+lldp_evb_cmds.c lldp_vdp_cmds.c \
 lldp_tlv.c include/lldp_tlv.h \
 lldp_basman.c include/lldp_basman.h	\
 lldp_med.c include/lldp_med.h \
 lldp_8023.c include/lldp_8023.h \
 lldp_evb.c include/lldp_evb.h \
-lldp_vdp.c include/lldp_vdp.h
+lldp_vdp.c include/lldp_vdp.h \
+lldp_vdp_cmds.h
 
 dcbtool_SOURCES = dcbtool.c clif.c dcbtool_cmds.c parse_cli.l \
 $(lldpad_include_HEADERS) $(noinst_HEADERS)
 
 lldptool_SOURCES = lldptool.c clif.c lldptool_cmds.c common.c os_unix.c \
 lldp_mand_clif.c lldp_basman_clif.c lldp_med_clif.c lldp_8023_clif.c \
-lldp_dcbx_clif.c lldp_evb_clif.c $(lldpad_include_HEADERS) \
+lldp_dcbx_clif.c lldp_evb_clif.c lldp_vdp_clif.c $(lldpad_include_HEADERS) \
 $(noinst_HEADERS)
 
 nltest_SOURCES = nltest.c nltest.h
diff --git a/include/lldp_vdp_clif.h b/include/lldp_vdp_clif.h
new file mode 100644
index 0000000..9fcfacb
--- /dev/null
+++ b/include/lldp_vdp_clif.h
@@ -0,0 +1,38 @@
+/*******************************************************************************
+
+  implementation of VDP according to IEEE 802.1Qbg
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
+#ifndef _LLDP_VDP_CLIF_H
+#define _LLDP_VDP_CLIF_H
+
+struct lldp_module *vdp_cli_register(void);
+void vdp_cli_unregister(struct lldp_module *);
+int vdp_print_tlv(u32, u16, char *);
+
+#define VDP_BUF_SIZE			256
+
+#define ARG_VDP_MODE			"mode"
+#define ARG_VDP_ROLE			"role"
+
+#endif
diff --git a/include/lldp_vdp_cmds.h b/include/lldp_vdp_cmds.h
new file mode 100644
index 0000000..5e64c27
--- /dev/null
+++ b/include/lldp_vdp_cmds.h
@@ -0,0 +1,44 @@
+/*******************************************************************************
+
+  implementation of VDP according to IEEE 802.1Qbg
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
+#ifndef _LLDP_VDP_CMDS_H
+#define _LLDP_VDP_CMDS_H
+
+struct arg_handlers *vdp_get_arg_handlers();
+
+enum {
+	MODE = 0,
+	MGRID,
+	TYPEID,
+	TYPEIDVERSION,
+	INSTANCEID,
+	MAC,
+	VLAN,
+};
+
+#define VAL_STATION	"station"
+#define VAL_BRIDGE	"bridge"
+
+#endif
diff --git a/lldp_vdp_clif.c b/lldp_vdp_clif.c
new file mode 100644
index 0000000..7d5f5b3
--- /dev/null
+++ b/lldp_vdp_clif.c
@@ -0,0 +1,136 @@
+/*******************************************************************************
+
+  implementation of VDP according to IEEE 802.1Qbg
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
+#include "lldp_vdp.h"
+#include "lldp_vdp_clif.h"
+
+void vdp_print_cfg_tlv(u16, char *info);
+int vdp_print_help();
+
+u32 vdp_lookup_tlv_name(char *tlvid_str);
+
+static const struct lldp_mod_ops vdp_ops_clif = {
+	.lldp_mod_register	= vdp_cli_register,
+	.lldp_mod_unregister	= vdp_cli_unregister,
+	.print_tlv		= vdp_print_tlv,
+	.lookup_tlv_name	= vdp_lookup_tlv_name,
+	.print_help		= vdp_print_help,
+};
+
+struct type_name_info vdp_tlv_names[] = {
+	{ (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE,
+		"VDP protocol configuration",
+		"vdp", vdp_print_cfg_tlv },
+	{ INVALID_TLVID,     NULL,        NULL }
+};
+
+int vdp_print_help()
+{
+	struct type_name_info *tn = &vdp_tlv_names[0];
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
+struct lldp_module *vdp_cli_register(void)
+{
+	struct lldp_module *mod;
+
+	mod = malloc(sizeof(*mod));
+	if (!mod) {
+		fprintf(stderr, "failed to malloc module data\n");
+		return NULL;
+	}
+	mod->id = LLDP_MOD_VDP;
+	mod->ops = &vdp_ops_clif;
+
+	return mod;
+}
+
+void vdp_cli_unregister(struct lldp_module *mod)
+{
+	free(mod);
+}
+
+void vdp_print_cfg_tlv(u16 len, char *info)
+{
+	/* TODO: this should print out all associated VSI mac/vlan pairs */
+	printf("This should print out all associated VSI mac/vlan pairs !\n");
+
+	return;
+}
+
+/* return 1: if it printed the TLV
+ *        0: if it did not
+ */
+int vdp_print_tlv(u32 tlvid, u16 len, char *info)
+{
+	struct type_name_info *tn = &vdp_tlv_names[0];
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
+u32 vdp_lookup_tlv_name(char *tlvid_str)
+{
+	struct type_name_info *tn = &vdp_tlv_names[0];
+
+	while (tn->type != INVALID_TLVID) {
+		if (!strcasecmp(tn->key, tlvid_str))
+			return tn->type;
+		tn++;
+	}
+	return INVALID_TLVID;
+}
+
diff --git a/lldp_vdp_cmds.c b/lldp_vdp_cmds.c
new file mode 100644
index 0000000..56ba376
--- /dev/null
+++ b/lldp_vdp_cmds.c
@@ -0,0 +1,392 @@
+/*******************************************************************************
+
+  implementation of VDP according to IEEE 802.1Qbg
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
+#include "lldp_vdp.h"
+#include "lldp_mand_clif.h"
+#include "lldp_vdp_clif.h"
+#include "lldp_vdp_cmds.h"
+#include "lldp/ports.h"
+#include "libconfig.h"
+#include "config.h"
+#include "clif_msgs.h"
+#include "lldp/states.h"
+
+static int get_arg_tlvtxenable(struct cmd *, char *, char *, char *);
+static int set_arg_tlvtxenable(struct cmd *, char *, char *, char *);
+
+static int get_arg_mode(struct cmd *, char *, char *, char *);
+static int set_arg_mode(struct cmd *, char *, char *, char *);
+
+static int get_arg_role(struct cmd *, char *, char *, char *);
+static int set_arg_role(struct cmd *, char *, char *, char *);
+
+static struct arg_handlers arg_handlers[] = {
+	{ ARG_VDP_MODE, get_arg_mode, set_arg_mode },
+	{ ARG_VDP_ROLE, get_arg_role, set_arg_role },
+	{ ARG_TLVTXENABLE, get_arg_tlvtxenable, set_arg_tlvtxenable },
+	{ NULL }
+};
+
+static int get_arg_tlvtxenable(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char *s;
+	char arg_path[VDP_BUF_SIZE];
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE:
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
+	char arg_path[VDP_BUF_SIZE];
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE:
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
+	return cmd_success;
+}
+
+static int get_arg_mode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	char *s, *t;
+	char arg_path[VDP_BUF_SIZE];
+	struct vsi_profile *np;
+	struct vdp_data *vd;
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	s = t = malloc(VDP_BUF_SIZE);
+	if (!s)
+		return cmd_invalid;
+	memset(s, 0, VDP_BUF_SIZE);
+
+	vd = vdp_data(cmd->ifname);
+	if (!vd) {
+		printf("%s(%i): vdp_data for %s not found !\n", __func__, __LINE__,
+		       cmd->ifname);
+		return cmd_invalid;
+	}
+
+	LIST_FOREACH(np, &vd->profile_head, profile) {
+		PRINT_PROFILE(t, np);
+	}
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static void str2instance(struct vsi_profile *profile, char *buffer)
+{
+	int i, j = 0;
+	u8 mac[50];
+
+	for(i=0; i <= strlen(buffer); i++) {
+		if (buffer[i] == '-') {
+			continue;
+		}
+
+		if ((sscanf(&buffer[i], "%02x", &profile->instance[j]) == 1) ||
+		    (sscanf(&buffer[i], "%02X", &profile->instance[j]) == 1)) {
+			i++;
+			j++;
+			continue;
+		}
+	}
+
+}
+
+/* INSTANCE_STRLEN = strlen("fa9b7fff-b0a0-4893e-beef4ff18f8f") */
+#define INSTANCE_STRLEN 32
+
+int instance2str(const u8 *p, char *dst, size_t size)
+{
+	if (dst && size > INSTANCE_STRLEN) {
+		snprintf(dst, size, "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x",
+			 p[0], p[1], p[2], p[3],
+			 p[4], p[5], p[6], p[7],
+			 p[8], p[9], p[10], p[11],
+			 p[12], p[13], p[14], p[15]);
+		return 0;
+	}
+	return -1;
+}
+
+static void vdp_fill_profile(struct vsi_profile *profile, char *buffer, int field)
+{
+	int id;
+
+	switch(field) {
+		case MODE:
+			profile->mode = atoi(buffer);
+			break;
+		case MGRID:
+			profile->mgrid = atoi(buffer);
+			break;
+		case TYPEID:
+			id = atoi(buffer);
+			profile->id[0] = (u8) (id & 0xff);
+			profile->id[1] = (u8) ((id >> 8) & 0xff);
+			profile->id[2] = (u8) ((id >> 16) & 0xff);
+			break;
+		case TYPEIDVERSION:
+			profile->version = atoi(buffer);
+			break;
+		case INSTANCEID:
+			str2instance(profile, buffer);
+			break;
+		case MAC:
+			str2mac(buffer, &profile->mac[0], MAC_ADDR_LEN);
+			break;
+		case VLAN:
+			profile->vlan = atoi(buffer);
+			break;
+		default:
+			printf("Unknown field in buffer !\n");
+			break;
+	}
+}
+
+static struct vsi_profile *vdp_parse_mode_line(char * argvalue)
+{
+	int i, arglen, field;
+	char *cmdstring, *buf;
+	char *buffer;
+	struct vsi_profile *profile;
+
+	profile = malloc(sizeof(struct vsi_profile));
+	if (!profile)
+		return NULL;
+	memset(profile, 0, sizeof(struct vsi_profile));
+
+	arglen = strlen(argvalue);
+	cmdstring = argvalue;
+	buffer = malloc(arglen);
+	if (!buffer)
+		goto out_free;
+	buf = buffer;
+	field = 0;
+
+	for (i=0; i <= arglen; i++) {
+		*buffer = *cmdstring;
+
+		if ((*cmdstring == ',') || (*cmdstring == '\0')) {
+			*buffer++ = '\0';
+			vdp_fill_profile(profile, buf, field);
+			field++;
+			buffer = buf;
+			memset(buffer, 0, arglen);
+			cmdstring++;
+			continue;
+		}
+
+		buffer++;
+		cmdstring++;
+	}
+
+	return profile;
+
+out_free:
+	free(profile);
+	return NULL;
+}
+
+static int set_arg_mode(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int i, arglen;
+	char *cmdstring, *buf;
+	char *buffer;
+	struct vsi_profile *profile, *p;
+
+	arglen = strlen(argvalue);
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_EVB_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	profile = vdp_parse_mode_line(argvalue);
+	profile->port = port_find_by_name(cmd->ifname);
+
+	p = vdp_add_profile(profile);
+
+	if (!p) {
+		free(profile);
+		return cmd_invalid;
+	}
+
+	vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
+	vdp_vsi_sm_station(p);
+
+	return cmd_success;
+}
+
+static int get_arg_role(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char *s;
+	char arg_path[VDP_BUF_SIZE];
+
+	if (cmd->cmd != cmd_gettlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE:
+		if (get_config_setting(cmd->ifname, ARG_VDP_ROLE, (void *)&value,
+					CONFIG_TYPE_INT))
+			value = VDP_ROLE_STATION;
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	if (value == VDP_ROLE_BRIDGE)
+		s = VAL_BRIDGE;
+	else
+		s = VAL_STATION;
+
+	sprintf(obuf, "%02x%s%04x%s", strlen(arg), arg, strlen(s), s);
+
+	return cmd_success;
+}
+
+static int set_arg_role(struct cmd *cmd, char *arg, char *argvalue,
+			       char *obuf)
+{
+	int value;
+	char arg_path[VDP_BUF_SIZE];
+
+	if (cmd->cmd != cmd_settlv)
+		return cmd_invalid;
+
+	switch (cmd->tlvid) {
+	case (LLDP_MOD_VDP << 8) | LLDP_VDP_SUBTYPE:
+		break;
+	case INVALID_TLVID:
+		return cmd_invalid;
+	default:
+		return cmd_not_applicable;
+	}
+
+	if (!strcasecmp(argvalue, VAL_BRIDGE))
+		value = VDP_ROLE_BRIDGE;
+	else if (!strcasecmp(argvalue, VAL_STATION))
+		value = VDP_ROLE_STATION;
+	else
+		return cmd_invalid;
+
+	if (set_cfg(cmd->ifname, ARG_VDP_ROLE, (void *)&value, CONFIG_TYPE_INT))
+		return cmd_failed;
+
+	return cmd_success;
+}
+
+
+struct arg_handlers *vdp_get_arg_handlers()
+{
+	return &arg_handlers[0];
+}
diff --git a/lldptool.c b/lldptool.c
index a06a279..97b097d 100644
--- a/lldptool.c
+++ b/lldptool.c
@@ -40,6 +40,7 @@
 #include "lldp_8023_clif.h"
 #include "lldp_dcbx_clif.h"
 #include "lldp_evb_clif.h"
+#include "lldp_vdp_clif.h"
 #include "lldptool.h"
 #include "lldptool_cli.h"
 #include "lldp_mod.h"
@@ -158,6 +159,7 @@ struct lldp_module *(*register_tlv_table[])(void) = {
 	med_cli_register,
 	dcbx_cli_register,
 	evb_cli_register,
+	vdp_cli_register,
 	NULL,
 };
 
-- 
1.7.1
