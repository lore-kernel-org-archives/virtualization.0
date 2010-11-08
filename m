From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 8/9] lldpad support for libvirt netlink message
Date: Mon,  8 Nov 2010 17:11:59 +0100
Message-ID: <1289232720-27443-9-git-send-email-jens@linux.vnet.ibm.com>
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
Cc: chrisw@redhat.com, Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This code receives a IEEE 802.1Qbg virtual station instance from libvirt in
a SETLINK message. The parsed VSI is then handed over to VDP for processing.
The VDP state machine processes the VSI while libvirt polls the result using
GETLINK.

Requires at least Linux kernel 2.6.35-rc1.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
Signed-off-by: Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 event_iface.c         |  600 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/event_iface.h |    1 +
 include/lldp_vdp.h    |    2 +
 lldp_vdp.c            |    2 +-
 lldpad.c              |   10 +
 5 files changed, 604 insertions(+), 11 deletions(-)

diff --git a/event_iface.c b/event_iface.c
index 439e4d0..00ac3b1 100644
--- a/event_iface.c
+++ b/event_iface.c
@@ -3,6 +3,13 @@
   LLDP Agent Daemon (LLDPAD) Software
   Copyright(c) 2007-2010 Intel Corporation.
 
+  implementation of libvirt netlink interface
+  (c) Copyright IBM Corp. 2010
+
+  Author(s): Jens Osterkamp <jens@linux.vnet.ibm.com>
+	     Stefan Berger <stefanb@linux.vnet.ibm.com>
+	     Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>
+
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
   version 2, as published by the Free Software Foundation.
@@ -31,12 +38,16 @@
 #include <sys/socket.h>
 #include <linux/rtnetlink.h>
 #include <linux/if.h>
+#include <linux/if_link.h>
 #include <linux/if_vlan.h>
 #include <linux/sockios.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <linux/netlink.h>
+#include <netlink/msg.h>
 #include "lldpad.h"
 #include "lldp_mod.h"
+#include "lldp_vdp.h"
 #include "common.h"
 #include "eloop.h"
 #include "drv_cfg.h"
@@ -47,6 +58,7 @@
 #include "lldp/l2_packet.h"
 #include "config.h"
 #include "lldp/states.h"
+#include "messages.h"
 
 static void event_if_decode_rta(int type, struct rtattr *rta);
 
@@ -55,6 +67,32 @@ static void event_if_decode_rta(int type, struct rtattr *rta);
 static char *device_name = NULL;
 static int link_status = 0;
 
+static struct nla_policy ifla_vf_policy[IFLA_VF_MAX + 1] =
+{
+  [IFLA_VF_MAC]     = { .minlen = sizeof(struct ifla_vf_mac),
+			.maxlen = sizeof(struct ifla_vf_mac)},
+  [IFLA_VF_VLAN]    = { .minlen = sizeof(struct ifla_vf_vlan),
+                        .maxlen = sizeof(struct ifla_vf_vlan)},
+};
+
+static struct nla_policy ifla_vf_ports_policy[IFLA_VF_PORT_MAX + 1] =
+{
+  [IFLA_VF_PORT] = { .type = NLA_NESTED },
+};
+
+static struct nla_policy ifla_port_policy[IFLA_PORT_MAX + 1] =
+{
+  [IFLA_PORT_VF]            = { .type = NLA_U32 },
+  [IFLA_PORT_PROFILE]       = { .type = NLA_STRING },
+  [IFLA_PORT_VSI_TYPE]      = { .minlen = sizeof(struct ifla_port_vsi) },
+  [IFLA_PORT_INSTANCE_UUID] = { .minlen = PORT_UUID_MAX,
+                                .maxlen = PORT_UUID_MAX, },
+  [IFLA_PORT_HOST_UUID]     = { .minlen = PORT_UUID_MAX,
+                                .maxlen = PORT_UUID_MAX, },
+  [IFLA_PORT_REQUEST]       = { .type = NLA_U8  },
+  [IFLA_PORT_RESPONSE]      = { .type = NLA_U16 },
+};
+
 static void event_if_decode_rta(int type, struct rtattr *rta)
 {
 
@@ -220,15 +258,517 @@ static void event_if_decode_nlmsg(int route_type, void *data, int len)
 	}
 }
 
-
 static void event_if_process_recvmsg(struct nlmsghdr *nlmsg)
 {
-
-	/* print out details */
+	LLDPAD_DBG("%s:%s: nlmsg_type: %d", __FILE__, __FUNCTION__, nlmsg->nlmsg_type);
 	event_if_decode_nlmsg(nlmsg->nlmsg_type, NLMSG_DATA(nlmsg),
 		NLMSG_PAYLOAD(nlmsg, 0));
 }
 
+static int event_if_parse_getmsg(struct nlmsghdr *nlh, int *ifindex,
+				 char *ifname)
+{
+	struct nlattr *tb[IFLA_MAX+1];
+	struct ifinfomsg *ifinfo;
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		LLDPAD_ERR("Error parsing GETLINK request...");
+		return -EINVAL;
+	}
+
+	if (tb[IFLA_IFNAME]) {
+		ifname = (char *)RTA_DATA(tb[IFLA_IFNAME]);
+		LLDPAD_DBG("IFLA_IFNAME=%s", ifname);
+	} else {
+		ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		*ifindex = ifinfo->ifi_index;
+		LLDPAD_DBG("interface index: %d", ifinfo->ifi_index);
+	}
+
+	return 0;
+}
+
+static int event_if_parse_setmsg(struct nlmsghdr *nlh)
+{
+	struct nlattr *tb[IFLA_MAX+1],
+		      *tb3[IFLA_PORT_MAX+1],
+		      *tb_vfinfo[IFLA_VF_MAX+1],
+		      *tb_vfinfo_list;
+	struct vsi_profile *profile, *p;
+	struct ifinfomsg *ifinfo;
+	char *ifname;
+	int rem;
+
+	profile = malloc(sizeof(struct vsi_profile));
+	if (!profile)
+		return -ENOMEM;
+	memset(profile, 0, sizeof(struct vsi_profile));
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		LLDPAD_ERR("Error parsing request...\n");
+		return -EINVAL;
+	}
+
+	LLDPAD_DBG("%s(%d): nlmsg_len %i", __FILE__, __LINE__, nlh->nlmsg_len);
+
+	if (tb[IFLA_IFNAME]) {
+		ifname = (char *)RTA_DATA(tb[IFLA_IFNAME]);
+		LLDPAD_DBG("IFLA_IFNAME=%s", ifname);
+	} else {
+		ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		LLDPAD_DBG("interface index: %d", ifinfo->ifi_index);
+	}
+
+	if (!tb[IFLA_VFINFO_LIST]) {
+		LLDPAD_ERR("IFLA_VFINFO_LIST missing.");
+		return -EINVAL;
+	} else {
+		LLDPAD_DBG("FOUND IFLA_VFINFO_LIST!");
+	}
+
+	nla_for_each_nested(tb_vfinfo_list, tb[IFLA_VFINFO_LIST], rem) {
+		if (nla_type(tb_vfinfo_list) != IFLA_VF_INFO) {
+			LLDPAD_ERR("nested parsing of IFLA_VFINFO_LIST failed.");
+			return -EINVAL;
+		}
+
+		if (nla_parse_nested(tb_vfinfo, IFLA_VF_MAX, tb_vfinfo_list,
+				     ifla_vf_policy)) {
+			LLDPAD_ERR("nested parsing of IFLA_VF_INFO failed.");
+			return -EINVAL;
+		}
+	}
+
+	if (tb_vfinfo[IFLA_VF_MAC]) {
+		struct ifla_vf_mac *mac = RTA_DATA(tb_vfinfo[IFLA_VF_MAC]);
+		u8 *m = mac->mac;
+		LLDPAD_DBG("IFLA_VF_MAC=%2x:%2x:%2x:%2x:%2x:%2x",
+			m[0], m[1], m[2], m[3], m[4], m[5]);
+		memcpy(&profile->mac, m, ETH_ALEN);
+	}
+
+	if (tb_vfinfo[IFLA_VF_VLAN]) {
+		struct ifla_vf_vlan *vlan = RTA_DATA(tb_vfinfo[IFLA_VF_VLAN]);
+		LLDPAD_DBG("IFLA_VF_VLAN=%d", vlan->vlan);
+		profile->vlan = (u16) vlan->vlan;
+	}
+
+	if (tb[IFLA_VF_PORTS]) {
+		struct nlattr *tb_vf_ports;
+
+		LLDPAD_DBG("FOUND IFLA_VF_PORTS");
+
+		nla_for_each_nested(tb_vf_ports, tb[IFLA_VF_PORTS], rem) {
+
+			LLDPAD_DBG("ITERATING");
+
+			if (nla_type(tb_vf_ports) != IFLA_VF_PORT) {
+				LLDPAD_DBG("not a IFLA_VF_PORT. skipping");
+				continue;
+			}
+
+			if (nla_parse_nested(tb3, IFLA_PORT_MAX, tb_vf_ports,
+					     ifla_port_policy)) {
+				LLDPAD_ERR("nested parsing on level 2 failed.");
+				return -EINVAL;
+			}
+
+			if (tb3[IFLA_PORT_VF]) {
+				LLDPAD_DBG("IFLA_PORT_VF=%d", *(uint32_t*)(RTA_DATA(tb3[IFLA_PORT_VF])));
+			}
+
+			if (tb3[IFLA_PORT_PROFILE]) {
+				LLDPAD_DBG("IFLA_PORT_PROFILE=%s", (char *)RTA_DATA(tb3[IFLA_PORT_PROFILE]));
+			}
+
+			if (tb3[IFLA_PORT_VSI_TYPE]) {
+				struct ifla_port_vsi *pvsi;
+				int tid = 0;
+
+				pvsi = (struct ifla_port_vsi*)RTA_DATA(tb3[IFLA_PORT_VSI_TYPE]);
+				tid = pvsi->vsi_type_id[2] << 16 |
+					pvsi->vsi_type_id[1] << 8 |
+					pvsi->vsi_type_id[0];
+
+				LLDPAD_DBG("mgr_id : %d", pvsi->vsi_mgr_id);
+				LLDPAD_DBG("type_id : %d", tid);
+				LLDPAD_DBG("type_version : %d",	pvsi->vsi_type_version);
+
+				profile->mgrid = pvsi->vsi_mgr_id;
+				profile->id = tid;
+				profile->version = pvsi->vsi_type_version;
+			}
+
+			if (tb3[IFLA_PORT_INSTANCE_UUID]) {
+				int i;
+				unsigned char *uuid;
+				uuid = (unsigned char *)RTA_DATA(tb3[IFLA_PORT_INSTANCE_UUID]);
+
+				char instance[INSTANCE_STRLEN+2];
+				instance2str(uuid, instance, sizeof(instance));
+				LLDPAD_DBG("IFLA_PORT_INSTANCE_UUID=%s", &instance[0]);
+
+				memcpy(&profile->instance,
+				       RTA_DATA(tb3[IFLA_PORT_INSTANCE_UUID]), 16);
+			}
+
+			if (tb3[IFLA_PORT_REQUEST]) {
+				LLDPAD_DBG("IFLA_PORT_REQUEST=%d",
+					*(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]));
+					profile->mode = *(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]);
+			}
+
+			if (tb3[IFLA_PORT_RESPONSE]) {
+				LLDPAD_DBG("IFLA_PORT_RESPONSE=%d",
+					*(uint16_t*)RTA_DATA(tb3[IFLA_PORT_RESPONSE]));
+				profile->response = *(uint16_t*)RTA_DATA(tb3[IFLA_PORT_RESPONSE]);
+			}
+		}
+	}
+
+	if (ifname) {
+		struct port *port = port_find_by_name(ifname);
+
+		if (port) {
+			profile->port = port;
+		} else {
+			LLDPAD_ERR("%s(%i): Could not find port for %s", __func__,
+			       __LINE__, ifname);
+			return -EEXIST;
+		}
+	}
+
+	p = vdp_add_profile(profile);
+
+	if (!p) {
+		free(profile);
+		return -EINVAL;
+	}
+
+	vdp_somethingChangedLocal(profile, VDP_PROFILE_REQ);
+	vdp_vsi_sm_station(p);
+
+	return 0;
+}
+
+static void event_if_parseResponseMsg(struct nlmsghdr *nlh)
+{
+	struct nlattr *tb[IFLA_MAX+1],
+		      *tb2[IFLA_VF_PORT_MAX + 1],
+		      *tb3[IFLA_PORT_MAX+1];
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		LLDPAD_ERR("Error parsing netlink response...");
+		return;
+	}
+
+	if (tb[IFLA_IFNAME]) {
+		LLDPAD_DBG("IFLA_IFNAME=%s", (char *)RTA_DATA(tb[IFLA_IFNAME]));
+	} else {
+		struct ifinfomsg *ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		LLDPAD_DBG("interface index: %d", ifinfo->ifi_index);
+	}
+
+	if (tb[IFLA_VF_PORTS]) {
+		if (nla_parse_nested(tb2, IFLA_VF_PORT_MAX, tb[IFLA_VF_PORTS],
+				     ifla_vf_ports_policy)) {
+			LLDPAD_ERR("nested parsing on level 1 failed.");
+			return;
+		}
+
+        if (tb2[IFLA_VF_PORT]) {
+		if (nla_parse_nested(tb3, IFLA_PORT_MAX, tb2[IFLA_VF_PORT],
+				     ifla_port_policy)) {
+			LLDPAD_ERR("nested parsing on level 2 failed.");
+			return;
+		}
+
+		if (tb3[IFLA_PORT_VF]) {
+			LLDPAD_DBG("IFLA_PORT_VF=%d", *(uint32_t*)(RTA_DATA(tb3[IFLA_PORT_VF])));
+		}
+
+		if (tb3[IFLA_PORT_PROFILE]) {
+			LLDPAD_DBG("IFLA_PORT_PROFILE=%s", (char *)RTA_DATA(tb3[IFLA_PORT_PROFILE]));
+		}
+
+		if (tb3[IFLA_PORT_VSI_TYPE]) {
+			struct ifla_port_vsi *pvsi;
+			int tid = 0;
+			pvsi = (struct ifla_port_vsi*)RTA_DATA(tb3[IFLA_PORT_VSI_TYPE]);
+			tid = pvsi->vsi_type_id[2] << 16 |
+				pvsi->vsi_type_id[1] << 8 |
+				pvsi->vsi_type_id[0];
+			LLDPAD_DBG("mgr_id : %d"
+				"type_id : %d"
+				"type_version : %d",
+				pvsi->vsi_mgr_id,
+				tid,
+				pvsi->vsi_type_version);
+		}
+
+		if (tb3[IFLA_PORT_INSTANCE_UUID]) {
+			int i;
+			unsigned char *uuid;
+			uuid = (unsigned char *)RTA_DATA(tb3[IFLA_PORT_INSTANCE_UUID]);
+
+			char instance[INSTANCE_STRLEN+2];
+			instance2str(uuid, instance, sizeof(instance));
+			LLDPAD_DBG("IFLA_PORT_INSTANCE_UUID=%s", &instance[0]);
+		}
+
+		if (tb3[IFLA_PORT_REQUEST]) {
+			LLDPAD_DBG("IFLA_PORT_REQUEST=%d",
+				*(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]));
+		}
+
+		if (tb3[IFLA_PORT_RESPONSE]) {
+			LLDPAD_DBG("IFLA_PORT_RESPONSE=%d",
+				*(uint16_t*)RTA_DATA(tb3[IFLA_PORT_RESPONSE]));
+		}
+	}
+	}
+}
+
+struct nl_msg *event_if_constructResponse(struct nlmsghdr *nlh, int ifindex)
+{
+	struct nl_msg *nl_msg;
+	struct nlattr *vf_ports = NULL, *vf_port;
+	struct ifinfomsg ifinfo;
+	struct vdp_data *vd;
+	uint32_t pid = nlh->nlmsg_pid;
+	uint32_t seq = nlh->nlmsg_seq;
+	char *ifname = malloc(IFNAMSIZ);
+	struct vsi_profile *p;
+
+	nl_msg = nlmsg_alloc();
+
+	if (!nl_msg) {
+		LLDPAD_ERR("%s(%i): Unable to allocate netlink message !", __func__, __LINE__);
+		return NULL;
+	}
+
+	if (!if_indextoname(ifindex, ifname)) {
+		LLDPAD_ERR("%s(%i): No name found for interface with index %i !", __func__, __LINE__,
+		       ifindex);
+	}
+
+	vd = vdp_data(ifname);
+	if (!vd) {
+		LLDPAD_ERR("%s(%i): Could not find vdp_data for %s !", __func__, __LINE__,
+		       ifname);
+		return NULL;
+	}
+
+	free(ifname);
+
+	if (nlmsg_put(nl_msg, pid, seq, NLMSG_DONE, 0, 0) == NULL)
+		goto err_exit;
+
+	ifinfo.ifi_index = ifindex;
+
+	if (nlmsg_append(nl_msg, &ifinfo, sizeof(ifinfo), NLMSG_ALIGNTO) < 0)
+		goto err_exit;
+
+	vf_ports = nla_nest_start(nl_msg, IFLA_VF_PORTS);
+
+	if (!vf_ports)
+		goto err_exit;
+
+	/* loop over all existing profiles on this interface and
+	 * put them into the nested IFLA_VF_PORT structure */
+	LIST_FOREACH(p, &vd->profile_head, profile) {
+		if (p) {
+			vdp_print_profile(p);
+
+			vf_port  = nla_nest_start(nl_msg, IFLA_VF_PORT);
+
+			if (!vf_port)
+				goto err_exit;
+
+			if (nla_put(nl_msg, IFLA_PORT_INSTANCE_UUID, 16, p->instance) < 0)
+				goto err_exit;
+
+			if (nla_put_u32(nl_msg, IFLA_PORT_VF, PORT_SELF_VF) < 0)
+				goto err_exit;
+
+			if (p->mode == p->state) {
+				if (nla_put_u16(nl_msg, IFLA_PORT_RESPONSE,
+						PORT_VDP_RESPONSE_SUCCESS) < 0)
+					goto err_exit;
+			} else {
+				if (p->state == VSI_EXIT) {
+					if (p->response > PORT_VDP_RESPONSE_SUCCESS) {
+						if (nla_put_u16(nl_msg, IFLA_PORT_RESPONSE, p->response) < 0)
+							goto err_exit;
+					} else {
+						if (nla_put_u16(nl_msg, IFLA_PORT_RESPONSE,
+								PORT_VDP_RESPONSE_INSUFFICIENT_RESOURCES) < 0)
+							goto err_exit;
+					}
+				}
+			}
+
+			nla_nest_end(nl_msg, vf_port);
+		}
+	}
+
+	if (vf_ports)
+		nla_nest_end(nl_msg, vf_ports);
+
+	return nl_msg;
+
+err_exit:
+	nlmsg_free(nl_msg);
+
+	return NULL;
+}
+
+struct nl_msg *event_if_simpleResponse(uint32_t pid, uint32_t seq, int err)
+{
+	struct nl_msg *nl_msg = nlmsg_alloc();
+	struct nlmsgerr nlmsgerr;
+
+	memset(&nlmsgerr, 0x0, sizeof(nlmsgerr));
+
+	nlmsgerr.error = err;
+	LLDPAD_DBG("RESPONSE error code: %d",err);
+
+	if (nlmsg_put(nl_msg, pid, seq, NLMSG_ERROR, 0, 0) == NULL)
+		goto err_exit;
+
+	if (nlmsg_append(nl_msg, &nlmsgerr, sizeof(nlmsgerr), NLMSG_ALIGNTO) < 0)
+		goto err_exit;
+
+	return nl_msg;
+
+err_exit:
+	nlmsg_free(nl_msg);
+
+	return NULL;
+}
+
+static void event_iface_receive_user_space(int sock, void *eloop_ctx, void *sock_ctx)
+{
+	struct nlmsghdr *nlh, *nlh2;
+	struct nl_msg *nl_msg;
+	struct msghdr msg;
+	struct sockaddr_nl dest_addr;
+	struct iovec iov;
+	int result;
+	int err;
+	int ifindex = 0;
+	char *ifname = NULL;
+
+	nlh = (struct nlmsghdr *)calloc(1,
+					NLMSG_SPACE(MAX_PAYLOAD));
+	if (!nlh) {
+		LLDPAD_ERR("%s(%i): could not allocate nlh !", __func__,
+		       __LINE__);
+		return;
+	}
+	memset(nlh, 0, NLMSG_SPACE(MAX_PAYLOAD));
+
+	memset(&dest_addr, 0, sizeof(dest_addr));
+	iov.iov_base = (void *)nlh;
+	iov.iov_len = NLMSG_SPACE(MAX_PAYLOAD);
+	msg.msg_name = (void *)&dest_addr;
+	msg.msg_namelen = sizeof(dest_addr);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_flags = 0;
+
+	LLDPAD_DBG("Waiting for message");
+	result = recvmsg(sock, &msg, MSG_DONTWAIT);
+
+	LLDPAD_DBG("%s(%i): ", __func__, __LINE__);
+	LLDPAD_DBG("recvmsg received %d bytes", result);
+
+	if(result < 0) {
+		LLDPAD_ERR("Error receiving from netlink socket : %s", strerror(errno));
+	}
+
+	LLDPAD_DBG("dest_addr.nl_pid: %d", dest_addr.nl_pid);
+	LLDPAD_DBG("nlh.nl_pid: %d", nlh->nlmsg_pid);
+	LLDPAD_DBG("nlh_type: %d", nlh->nlmsg_type);
+	LLDPAD_DBG("nlh_seq: 0x%x", nlh->nlmsg_seq);
+	LLDPAD_DBG("nlh_len: 0x%x", nlh->nlmsg_len);
+
+	switch (nlh->nlmsg_type) {
+		case RTM_SETLINK:
+			LLDPAD_DBG("RTM_SETLINK");
+
+			err = event_if_parse_setmsg(nlh);
+
+			/* send simple response wether profile was accepted
+			 * or not */
+			nl_msg = event_if_simpleResponse(nlh->nlmsg_pid,
+							 nlh->nlmsg_seq,
+							 err);
+			nlh2 = nlmsg_hdr(nl_msg);
+			break;
+		case RTM_GETLINK:
+			LLDPAD_DBG("RTM_GETLINK");
+
+			err = event_if_parse_getmsg(nlh, &ifindex, ifname);
+
+			if (err) {
+				nl_msg = event_if_simpleResponse(nlh->nlmsg_pid,
+								 nlh->nlmsg_seq,
+								 err);
+			} else if (ifname) {
+				ifindex = if_nametoindex(ifname);
+				LLDPAD_DBG("%s(%i): ifname %s (%d)", __func__,
+				       __LINE__, ifname, ifindex);
+			} else {
+				LLDPAD_DBG("%s(%i): ifindex %i", __func__,
+				       __LINE__, ifindex);
+			}
+
+			nl_msg = event_if_constructResponse(nlh, ifindex);
+
+			if (!nl_msg) {
+				LLDPAD_ERR("%s(%i): Unable to construct response !",
+				       __func__, __LINE__);
+				goto out_err;
+			}
+
+			nlh2 = nlmsg_hdr(nl_msg);
+
+			LLDPAD_DBG("RESPONSE:");
+
+			event_if_parseResponseMsg(nlh2);
+
+			break;
+	}
+
+	iov.iov_base = (void*)nlh2;
+	iov.iov_len = nlh2->nlmsg_len;
+
+	msg.msg_name = (void *)&dest_addr;
+	msg.msg_namelen = sizeof(dest_addr);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	result = sendmsg(sock, &msg, 0);
+
+	if (result < 0) {
+		LLDPAD_ERR("Error sending on netlink socket (%s) !", strerror(errno));
+	} else {
+		LLDPAD_DBG("Sent %d bytes !",result);
+	}
+
+out_err:
+	free(nlh);
+	nlmsg_free(nl_msg);
+
+	return;
+}
+
 static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 {
 	struct nlmsghdr *nlh;
@@ -236,12 +776,14 @@ static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 	char buf[MAX_MSG_SIZE];
 	socklen_t fromlen = sizeof(dest_addr);
 	int result;
-	
+
 	result = recvfrom(sock, buf, sizeof(buf), MSG_DONTWAIT,
 		       (struct sockaddr *) &dest_addr, &fromlen);
 
+	LLDPAD_DBG("%s:%s: result from receive: %d", __FILE__, __FUNCTION__, result);
+
 	if (result < 0) {
-		perror("recvfrom(Event interface)");
+		LLDPAD_ERR("recvfrom(event interface): %s", strerror(errno));
 		if ((errno == ENOBUFS) || (errno == EAGAIN))
 			eloop_register_timeout(INI_TIMER, 0, scan_port,
 					       NULL, NULL);
@@ -250,10 +792,15 @@ static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 
 	TRACE("PRINT BUF info.\n")
 
-	device_name = NULL;
-	link_status = IF_OPER_UNKNOWN;
-	nlh = (struct nlmsghdr *)buf;
-	event_if_process_recvmsg(nlh);
+	/* Separate handler for kernel messages from userspace messages*/
+	LLDPAD_DBG("%s:%s: dest_addr.nl_pid: %d", __FILE__, __FUNCTION__, dest_addr.nl_pid);
+
+	if (dest_addr.nl_pid == 0) {
+		device_name = NULL;
+		link_status = IF_OPER_UNKNOWN;
+		nlh = (struct nlmsghdr *)buf;
+		event_if_process_recvmsg(nlh);
+	}
 }
 
 int event_iface_init()
@@ -261,7 +808,7 @@ int event_iface_init()
 	int fd;
 	int rcv_size = MAX_MSG_SIZE;
 	struct sockaddr_nl snl;
-
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
 	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 
 	if (fd < 0)
@@ -282,6 +829,39 @@ int event_iface_init()
 	}
 
 	eloop_register_read_sock(fd, event_iface_receive, NULL, NULL);
+
+	return 0;
+}
+
+int event_iface_init_user_space()
+{
+	int fd;
+	int rcv_size = MAX_MSG_SIZE;
+	struct sockaddr_nl snl;
+
+	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+
+	if (fd < 0)
+		return fd;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcv_size, sizeof(int)) < 0) {
+		close(fd);
+		return -EIO;
+	}
+
+	memset((void *)&snl, 0, sizeof(struct sockaddr_nl));
+	snl.nl_family = AF_NETLINK;
+	snl.nl_pid = getpid();  /* self pid */
+	snl.nl_groups = 0;
+
+	if (bind(fd, (struct sockaddr *)&snl, sizeof(struct sockaddr_nl)) < 0) {
+		close(fd);
+		LLDPAD_ERR("Error binding to netlink socket (%s) !", strerror(errno));
+		return -EIO;
+	}
+
+	eloop_register_read_sock(fd, event_iface_receive_user_space, NULL, NULL);
+
 	return 0;
 }
 
diff --git a/include/event_iface.h b/include/event_iface.h
index b2c93f0..d80158d 100644
--- a/include/event_iface.h
+++ b/include/event_iface.h
@@ -29,6 +29,7 @@
 #define  _EVENT_IFACE_H_
 
 int event_iface_init(void);
+int event_iface_init_user_space(void);
 int event_iface_deinit(void);
 int oper_add_device(char *device_name);
 
diff --git a/include/lldp_vdp.h b/include/lldp_vdp.h
index b97d8c0..53f814c 100644
--- a/include/lldp_vdp.h
+++ b/include/lldp_vdp.h
@@ -134,6 +134,8 @@ struct vdp_data *vdp_data(char *ifname);
 struct packed_tlv *vdp_gettlv(struct vdp_data *vd, struct vsi_profile *profile);
 void vdp_vsi_sm_station(struct vsi_profile *profile);
 struct vsi_profile *vdp_add_profile(struct vsi_profile *profile);
+void vdp_somethingChangedLocal(struct vsi_profile *profile, int mode);
+void vdp_print_profile(struct vsi_profile *profile);
 
 #define MAC_ADDR_STRLEN		18
 #define INSTANCE_STRLEN		32
diff --git a/lldp_vdp.c b/lldp_vdp.c
index 01bcbf7..3a507e9 100644
--- a/lldp_vdp.c
+++ b/lldp_vdp.c
@@ -105,7 +105,7 @@ static void vdp_free_data(struct vdp_user_data *ud)
  * prints the contents of a profile first to a string using the PRINT_PROFILE
  * macro, and then to the screen. Used for debug purposes.
  */
-static inline void vdp_print_profile(struct vsi_profile *profile)
+void vdp_print_profile(struct vsi_profile *profile)
 {
 	LLDPAD_DBG("profile:\n");
 
diff --git a/lldpad.c b/lldpad.c
index c0938af..69faa29 100644
--- a/lldpad.c
+++ b/lldpad.c
@@ -374,6 +374,16 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	/* setup event netlink interface for user space processes.
+	 * This needs to be setup first to ensure it gets lldpads
+	 * pid as netlink address.
+	 */
+	if (event_iface_init_user_space() < 0) {
+		log_message(MSG_ERR_SERVICE_START_FAILURE,
+			"%s", "failed to register user space event interface");
+		exit(1);
+	}
+
 	init_modules("");
 
 
-- 
1.7.1
