From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 16/17] lldpad support for libvirt netlink message
Date: Fri, 23 Jul 2010 12:34:32 +0200
Message-ID: <1279881273-10261-17-git-send-email-jens@linux.vnet.ibm.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
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
 event_iface.c |  617 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lldp_vdp.c    |    2 +-
 lldpad.c      |   10 +
 3 files changed, 622 insertions(+), 7 deletions(-)

diff --git a/event_iface.c b/event_iface.c
index 439e4d0..60cc2ed 100644
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
@@ -55,6 +66,39 @@ static void event_if_decode_rta(int type, struct rtattr *rta);
 static char *device_name = NULL;
 static int link_status = 0;
 
+static struct nla_policy ifla_policy[IFLA_MAX + 1] =
+{
+  [IFLA_VFINFO_LIST] = { .type = NLA_NESTED },
+  [IFLA_IFNAME]     = { .type = NLA_STRING },
+  [IFLA_VF_PORTS]   = { .type = NLA_NESTED },
+};
+
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
 
@@ -220,15 +264,537 @@ static void event_if_decode_nlmsg(int route_type, void *data, int len)
 	}
 }
 
-
 static void event_if_process_recvmsg(struct nlmsghdr *nlmsg)
 {
 
 	/* print out details */
+	fprintf(stderr, "%s:%s: nlmsg_type: %d\n", __FILE__, __FUNCTION__, nlmsg->nlmsg_type);
 	event_if_decode_nlmsg(nlmsg->nlmsg_type, NLMSG_DATA(nlmsg),
 		NLMSG_PAYLOAD(nlmsg, 0));
 }
 
+static int event_if_parse_getmsg(struct nlmsghdr *nlh, int *ifindex,
+				 char *ifname)
+{
+	struct nlattr *tb[IFLA_MAX+1];
+	struct ifinfomsg *ifinfo;
+
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		fprintf(stderr, "Error parsing request...\n");
+		return -EINVAL;
+	}
+
+	if (tb[IFLA_IFNAME]) {
+		ifname = (char *)RTA_DATA(tb[IFLA_IFNAME]);
+		fprintf(stderr, "IFLA_IFNAME=%s\n", ifname);
+	} else {
+		ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		*ifindex = ifinfo->ifi_index;
+		fprintf(stderr, "interface index: %d\n", ifinfo->ifi_index);
+	}
+
+	return 0;
+}
+
+static int event_if_parse_setmsg(struct nlmsghdr *nlh)
+{
+	struct nlattr *tb[IFLA_MAX+1],
+		      *tb2[IFLA_VF_PORT_MAX + 1],
+		      *tb3[IFLA_PORT_MAX+1],
+		      *tb_vfinfo[IFLA_VF_MAX+1],
+		      *tb_vfinfo_list;
+	struct vsi_profile *profile, *p;
+	struct ifinfomsg *ifinfo;
+	char *ifname;
+	int rem;
+
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+	profile = malloc(sizeof(struct vsi_profile));
+	if (!profile)
+		return -ENOMEM;
+	memset(profile, 0, sizeof(struct vsi_profile));
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		fprintf(stderr, "Error parsing request...\n");
+		return -EINVAL;
+	}
+
+	fprintf(stderr, "%s(%d): nlmsg_len %i\n", __FILE__, __LINE__, nlh->nlmsg_len);
+
+	if (tb[IFLA_IFNAME]) {
+		ifname = (char *)RTA_DATA(tb[IFLA_IFNAME]);
+		fprintf(stderr, "IFLA_IFNAME=%s\n", ifname);
+	} else {
+		ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		fprintf(stderr, "interface index: %d\n", ifinfo->ifi_index);
+	}
+
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+	if (!tb[IFLA_VFINFO_LIST]) {
+		fprintf(stderr, "IFLA_VFINFO_LIST missing.\n");
+		return -EINVAL;
+	} else {
+		fprintf(stderr, "FOUND IFLA_VFINFO_LIST!\n");
+	}
+
+	nla_for_each_nested(tb_vfinfo_list, tb[IFLA_VFINFO_LIST], rem) {
+		if (nla_type(tb_vfinfo_list) != IFLA_VF_INFO) {
+			fprintf(stderr, "nested parsing of IFLA_VFINFO_LIST failed.\n");
+			return -EINVAL;
+		}
+
+		if (nla_parse_nested(tb_vfinfo, IFLA_VF_MAX, tb_vfinfo_list,
+				     ifla_vf_policy)) {
+			fprintf(stderr, "nested parsing of IFLA_VF_INFO failed.\n");
+			return -EINVAL;
+		}
+	}
+
+	if (tb_vfinfo[IFLA_VF_MAC]) {
+		struct ifla_vf_mac *mac = RTA_DATA(tb_vfinfo[IFLA_VF_MAC]);
+		u8 *m = mac->mac;
+		fprintf(stderr, "IFLA_VF_MAC=%2x:%2x:%2x:%2x:%2x:%2x\n",
+			m[0], m[1], m[2], m[3], m[4], m[5]);
+		memcpy(&profile->mac, m, ETH_ALEN);
+	}
+
+	if (tb_vfinfo[IFLA_VF_VLAN]) {
+		struct ifla_vf_vlan *vlan = RTA_DATA(tb_vfinfo[IFLA_VF_VLAN]);
+		fprintf(stderr, "IFLA_VF_VLAN=%d\n", vlan->vlan);
+		profile->vlan = (u16) vlan->vlan;
+	}
+
+	if (tb[IFLA_VF_PORTS]) {
+		struct nlattr *tb_vf_ports;
+
+		fprintf(stderr,"FOUND IFLA_VF_PORTS\n");
+
+		nla_for_each_nested(tb_vf_ports, tb[IFLA_VF_PORTS], rem) {
+
+			fprintf(stderr,"ITERATING\n");
+
+			if (nla_type(tb_vf_ports) != IFLA_VF_PORT) {
+				fprintf(stderr,"not a IFLA_VF_PORT. skipping\n");
+				continue;
+			}
+
+			if (nla_parse_nested(tb3, IFLA_PORT_MAX, tb_vf_ports,
+					     ifla_port_policy)) {
+				fprintf(stderr, "nested parsing on level 2 failed.\n");
+				return -EINVAL;
+			}
+
+			fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+			if (tb3[IFLA_PORT_VF]) {
+				fprintf(stderr, "IFLA_PORT_VF=%d\n", *(uint32_t*)(RTA_DATA(tb3[IFLA_PORT_VF])));
+			}
+
+			if (tb3[IFLA_PORT_PROFILE]) {
+				fprintf(stderr, "IFLA_PORT_PROFILE=%s\n", (char *)RTA_DATA(tb3[IFLA_PORT_PROFILE]));
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
+				fprintf(stderr, "mgr_id : %d\n"
+					"type_id : %d\n"
+					"type_version : %d\n",
+					pvsi->vsi_mgr_id,
+					tid,
+					pvsi->vsi_type_version);
+
+				profile->mgrid = pvsi->vsi_mgr_id;
+				memcpy(profile->id, pvsi->vsi_type_id, 3);
+				profile->version = pvsi->vsi_type_version;
+			}
+
+			if (tb3[IFLA_PORT_INSTANCE_UUID]) {
+				int i;
+				unsigned char *uuid;
+				uuid = (unsigned char *)RTA_DATA(tb3[IFLA_PORT_INSTANCE_UUID]);
+				fprintf(stderr, "IFLA_PORT_INSTANCE_UUID=");
+
+				for (i = 0; i < 16; i++) {
+					fprintf(stderr, "%x",uuid[i]);
+				}
+
+				fprintf(stderr, "\n");
+
+				memcpy(&profile->instance,
+				       RTA_DATA(tb3[IFLA_PORT_INSTANCE_UUID]), 16);
+			}
+
+			if (tb3[IFLA_PORT_REQUEST]) {
+				fprintf(stderr, "IFLA_PORT_REQUEST=%d\n",
+					*(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]));
+					profile->mode = *(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]);
+			}
+
+			if (tb3[IFLA_PORT_RESPONSE]) {
+				fprintf(stderr, "IFLA_PORT_RESPONSE=%d\n",
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
+			printf("%s(%i): Could not find port for %s\n", __func__,
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
+		      *tb3[IFLA_PORT_MAX+1],
+		      *tb_vfinfo[IFLA_VF_MAX+1],
+		      *tb_vfinfo_list;
+
+	int rem;
+
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		fprintf(stderr, "Error parsing response...\n");
+		return;
+	}
+
+	if (tb[IFLA_IFNAME]) {
+		fprintf(stderr, "IFLA_IFNAME=%s\n", (char *)RTA_DATA(tb[IFLA_IFNAME]));
+	} else {
+		struct ifinfomsg *ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+		fprintf(stderr, "interface index: %d\n", ifinfo->ifi_index);
+	}
+
+	if (tb[IFLA_VF_PORTS]) {
+		if (nla_parse_nested(tb2, IFLA_VF_PORT_MAX, tb[IFLA_VF_PORTS],
+				     ifla_vf_ports_policy)) {
+			fprintf(stderr, "nested parsing on level 1 failed.\n");
+			return;
+		}
+
+        if (tb2[IFLA_VF_PORT]) {
+		if (nla_parse_nested(tb3, IFLA_PORT_MAX, tb2[IFLA_VF_PORT],
+				     ifla_port_policy)) {
+			fprintf(stderr, "nested parsing on level 2 failed.\n");
+			return;
+		}
+
+		if (tb3[IFLA_PORT_VF]) {
+			fprintf(stderr, "IFLA_PORT_VF=%d\n", *(uint32_t*)(RTA_DATA(tb3[IFLA_PORT_VF])));
+		}
+
+		if (tb3[IFLA_PORT_PROFILE]) {
+			fprintf(stderr, "IFLA_PORT_PROFILE=%s\n", (char *)RTA_DATA(tb3[IFLA_PORT_PROFILE]));
+		}
+
+		if (tb3[IFLA_PORT_VSI_TYPE]) {
+			struct ifla_port_vsi *pvsi;
+			int tid = 0;
+			pvsi = (struct ifla_port_vsi*)RTA_DATA(tb3[IFLA_PORT_VSI_TYPE]);
+			tid = pvsi->vsi_type_id[2] << 16 |
+				pvsi->vsi_type_id[1] << 8 |
+				pvsi->vsi_type_id[0];
+			fprintf(stderr, "mgr_id : %d\n"
+				"type_id : %d\n"
+				"type_version : %d\n",
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
+			fprintf(stderr, "IFLA_PORT_INSTANCE_UUID=");
+
+			for (i = 0; i < 16; i++) {
+				fprintf(stderr, "%x",uuid[i]);
+			}
+
+			fprintf(stderr, "\n");
+		}
+
+		if (tb3[IFLA_PORT_REQUEST]) {
+			fprintf(stderr, "IFLA_PORT_REQUEST=%d\n",
+				*(uint8_t*)RTA_DATA(tb3[IFLA_PORT_REQUEST]));
+		}
+
+		if (tb3[IFLA_PORT_RESPONSE]) {
+			fprintf(stderr, "IFLA_PORT_RESPONSE=%d\n",
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
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
+
+	nl_msg = nlmsg_alloc();
+
+	if (!nl_msg) {
+		printf("%s(%i): Unable to allocate netlink message !\n", __func__, __LINE__);
+		return NULL;
+	}
+
+	if (!if_indextoname(ifindex, ifname)) {
+		printf("%s(%i): No name found for interface with index %i !\n", __func__, __LINE__,
+		       ifindex);
+	}
+
+	vd = vdp_data(ifname);
+	if (!vd) {
+		printf("%s(%i): Could not find vdp_data for %i !\n", __func__, __LINE__,
+		       ifname);
+		return NULL;
+	}
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
+			/*
+			if (nla_put_u16(nl_msg, IFLA_PORT_RESPONSE, p->response) < 0)
+				goto err_exit;
+				*/
+
+			if (nla_put_u16(nl_msg, IFLA_PORT_RESPONSE, PORT_VDP_RESPONSE_SUCCESS) < 0)
+				goto err_exit;
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
+	fprintf(stderr,"RESPONSE ERROR CODE: %d\n",err);
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
+	struct nlmsghdr *nlh;
+	struct nl_msg *nl_msg;
+	struct msghdr msg;
+	struct sockaddr_nl dest_addr;
+	char buf[MAX_MSG_SIZE];
+	socklen_t fromlen = sizeof(dest_addr);
+	struct iovec iov;
+	int result;
+	int err;
+	int ifindex;
+	char *ifname = NULL;
+
+	nlh = (struct nlmsghdr *)calloc(1,
+					NLMSG_SPACE(MAX_PAYLOAD));
+	if (!nlh) {
+		printf("%s(%i): could not allocate nlh !\n", __func__,
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
+	fprintf(stderr, "Waiting for message \n");
+	result = recvmsg(sock, &msg, MSG_DONTWAIT);
+
+	fprintf(stderr, "%s:%s: recvmsg received %d bytes\n", __FILE__, __FUNCTION__, result);
+
+	if(result < 0) {
+		fprintf(stderr,"Error receiving from netlink socket : %s\n", strerror(errno));
+	}
+
+	fprintf(stderr, "%s:%s: dest_addr.nl_pid: %d\n", __FILE__, __FUNCTION__, dest_addr.nl_pid);
+	fprintf(stderr, "%s:%s: nlh.nl_pid: %d\n", __FILE__, __FUNCTION__, nlh->nlmsg_pid);
+	fprintf(stderr, "%s:%s: nlh_type: %d\n", __FILE__, __FUNCTION__, nlh->nlmsg_type);
+	fprintf(stderr, "%s:%s: nlh_seq: 0x%x\n", __FILE__, __FUNCTION__, nlh->nlmsg_seq);
+	fprintf(stderr, "%s:%s: nlh_len: 0x%x\n", __FILE__, __FUNCTION__, nlh->nlmsg_len);
+
+	switch (nlh->nlmsg_type) {
+		case RTM_SETLINK:
+			fprintf(stderr,"--> RTM_SETLINK\n");
+
+			err = event_if_parse_setmsg(nlh);
+
+			/* send simple response wether profile was accepted
+			 * or not */
+			nl_msg = event_if_simpleResponse(nlh->nlmsg_pid,
+							 nlh->nlmsg_seq,
+							 err);
+			nlh = nlmsg_hdr(nl_msg);
+			break;
+		case RTM_GETLINK:
+			fprintf(stderr,"--> RTM_GETLINK\n");
+
+			err = event_if_parse_getmsg(nlh, &ifindex, ifname);
+
+			if (err) {
+				nl_msg = event_if_simpleResponse(nlh->nlmsg_pid,
+								 nlh->nlmsg_seq,
+								 err);
+			} else if (ifname) {
+				ifindex = if_nametoindex(ifname);
+				printf("%s(%i): ifname %s (%d)\n", __func__,
+				       __LINE__, ifname, ifindex);
+			} else {
+				ifname = malloc(IFNAMSIZ);
+				printf("%s(%i): ifindex %i\n", __func__,
+				       __LINE__, ifindex);
+				printf("%s(%i): ifname %s\n", __func__,
+				       __LINE__, if_indextoname(ifindex, ifname));
+			}
+
+			nl_msg = event_if_constructResponse(nlh, ifindex);
+
+			if (!nl_msg) {
+				printf("%s(%i): Unable to construct response !\n",
+				       __func__, __LINE__);
+				goto out_err;
+			}
+
+			nlh = nlmsg_hdr(nl_msg);
+
+			fprintf(stderr, "------------\nRESPONSE:\n");
+
+			event_if_parseResponseMsg(nlh);
+
+			fprintf(stderr, "------------\n");
+			break;
+	}
+
+	iov.iov_base = (void*)nlh;
+	iov.iov_len = nlh->nlmsg_len;
+
+	msg.msg_name = (void *)&dest_addr;
+	msg.msg_namelen = sizeof(dest_addr);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	result = sendmsg(sock, &msg, 0);
+
+	if (result < 0) {
+		fprintf(stderr,"Error sending on netlink socket : %s\n", strerror(errno));
+	} else {
+		fprintf(stderr,"sent %zd bytes!\n",result);
+	}
+
+out_err:
+	free(nlh);
+	nlmsg_free(nl_msg);
+}
+
 static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 {
 	struct nlmsghdr *nlh;
@@ -236,10 +802,11 @@ static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 	char buf[MAX_MSG_SIZE];
 	socklen_t fromlen = sizeof(dest_addr);
 	int result;
-	
+
 	result = recvfrom(sock, buf, sizeof(buf), MSG_DONTWAIT,
 		       (struct sockaddr *) &dest_addr, &fromlen);
 
+	fprintf(stderr, "%s:%s: result: %d\n", __FILE__, __FUNCTION__, result);
 	if (result < 0) {
 		perror("recvfrom(Event interface)");
 		if ((errno == ENOBUFS) || (errno == EAGAIN))
@@ -250,10 +817,14 @@ static void event_iface_receive(int sock, void *eloop_ctx, void *sock_ctx)
 
 	TRACE("PRINT BUF info.\n")
 
-	device_name = NULL;
-	link_status = IF_OPER_UNKNOWN;
-	nlh = (struct nlmsghdr *)buf;
-	event_if_process_recvmsg(nlh);
+	/* Separate handler for kernel messages from userspace messages*/
+	fprintf(stderr, "%s:%s: dest_addr.nl_pid: %d\n", __FILE__, __FUNCTION__, dest_addr.nl_pid);
+	if (dest_addr.nl_pid == 0) {
+		device_name = NULL;
+		link_status = IF_OPER_UNKNOWN;
+		nlh = (struct nlmsghdr *)buf;
+		event_if_process_recvmsg(nlh);
+	}
 }
 
 int event_iface_init()
@@ -262,6 +833,7 @@ int event_iface_init()
 	int rcv_size = MAX_MSG_SIZE;
 	struct sockaddr_nl snl;
 
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
 	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 
 	if (fd < 0)
@@ -282,6 +854,39 @@ int event_iface_init()
 	}
 
 	eloop_register_read_sock(fd, event_iface_receive, NULL, NULL);
+	//	event_iface_init2();
+	return 0;
+}
+
+int event_iface_init_user_space()
+{
+	int fd;
+	int rcv_size = MAX_MSG_SIZE;
+	struct sockaddr_nl snl;
+
+	fprintf(stderr, "%s:%s:%d\n", __FILE__, __FUNCTION__, __LINE__);
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
+		fprintf(stderr,"Error binding to netlink socket : %s\n", strerror(errno));
+		return -EIO;
+	}
+
+	eloop_register_read_sock(fd, event_iface_receive_user_space, NULL, NULL);
 	return 0;
 }
 
diff --git a/lldp_vdp.c b/lldp_vdp.c
index a511a43..95edc27 100644
--- a/lldp_vdp.c
+++ b/lldp_vdp.c
@@ -104,7 +104,7 @@ static void vdp_free_data(struct vdp_user_data *ud)
  * prints the contents of a profile first to a string using the PRINT_PROFILE
  * macro, and then to the screen. Used for debug purposes.
  */
-static inline void vdp_print_profile(struct vsi_profile *profile)
+void vdp_print_profile(struct vsi_profile *profile)
 {
 	char *s, *t;
 
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
