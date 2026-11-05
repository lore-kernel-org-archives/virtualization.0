Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907053;
	b=zKBKqZzzFwobJvYvzbi2wYacl2mPLPZyXhdhqZMK6as2xpMRRBevRMHHn9uDUdJlJwhr
	 SAxaRRullpQQaRqMgxtqdy+cK2Jfi33udI82E89Sg1Qj/1q+jweUKyNAtMMcJWF5heVc1
	 AqT4D9LLp/TybQz9/GUZX7VRPB1UxiaSQw7R36bjvuiJPX4Z+PHTkKqzmkUQJdlyCJXKl
	 gKgfns0CqS+TM6L4CQKDmAOJ4lNj7/DYNTCPMV4OZ4oGiiJYEI01ghP3x44fqnRBD+rNB
	 PTlUBWFDu6zvdeuRHz9iRvL7OgVp/XicxQzf9pAUMtrbKF3czUPLUKBqUfWIuwZqG2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907053;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=LWKujJlVMB3Jy7qFHjeMEqp9ayxxgo+goyxCDzgrOOk=;
	b=WxTYfYmHeou2K6dHZfPCFou7D5t+RW136Rxg53nP0RqDaH7ckdvss+eTtqHfd91U9cnC
	 lBoaE/aCA73FNHpYKbxtLzuFb2nTd0FrmlA29Q1APmzZLc8WHm22/n4DHx54tbjsET7ml
	 0ok3qtqNIwyqXgo71nUkV5PLYyPdm5BWkpD2JenoO30YN3dWZ3DtGUOenvPonKohTitz2
	 6s2gc1AJ9ZQCJOJz5V0HkOJqvXzdcqL3Ct1KHPgByXf7argxmTmXejxfAYnpUlnMtVuBM
	 hfVAh6fw4zp27PmbTpapHZUmpp6YpadoEcyIKjK+UpSQzI3hLgXbI4MbsIGsveB235w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Rt1zOHS4;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6493606D524
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6493606D524
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Rt1zOHS4
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5J5oNd3790915;
	Thu, 5 Nov 2026 11:30:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=LWKujJlVMB3Jy7qFHjeMEqp9ayxxgo+goyxCD
	zgrOOk=; b=Rt1zOHS48ApWczNmlWfHsaAeA4fjcLsXI0/MOomL+2/T8tfE5x9sD
	8+cSrwTxymV4nKr9kk+/mz4P8BWar/Oc7vNCCupqaBoDuATL4gga9qVxRDt/VFEp
	ZmUW6PxxlAP6krdUx+AkNUoVUOfMad6H/HlLYr/2koHYBDi9bfFYXxuDOy+Ls3AY
	masTqHh/+/Dt13knbXV/zuhhqFUgfTKl/MrXZLGtYBjREfdJykCmQ4Pn8ghEKlJi
	zVTRsfsFAJPTZLRGdKiFeD89qJarhbf2PwwyMLvTjd1gBbsefkVUmPMWoexBGIYD
	IuFNoQLbo5HOdgN3knbHCly3Q9iIjNhow==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrtsp2t8x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Nov 2026 11:30:48 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 5 Nov
 2026 19:30:46 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Thu, 5 Nov 2026 11:30:36 -0800
Subject: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the guest
 vsock device to a netns
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
In-Reply-To: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger
	<stephen@networkplumber.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux.dev>,
        Bobby Eshleman <bobbyeshleman@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX4Y0jUXK6sO4V
 ymJOmIh0eXvrL9kRQ7hfFZKzWekgv8vDJ/+VhAepO2QW6GlQNUD/8TxOKqQYV6hc/m3nvpNm8ww
 wZaKc70tzrcLF0eu9c71rt0iCtSQAJytvSDrhTD4Efje1pFNynYoROqTiiLgr+YWSsNs4rDaAS0
 7Hl51FFlR142xS4hfYBU2nWp1NL3UXF+BK/WHOjwvQUkjm1ctnQ64ReNIDRD3oWEMSbCRxUE++b
 0vS/tePHmHIvcgTfDeCZlZwPoxY9n12GhQoi/l7of6gKtKxiS3HmrYHQ0BWv6c8s4xQS2K3x/7o
 /+qRKhs6A3O5pqhibkv+QzvZkg+5O3UMt6XVjvzIo171vOgaS6VE1R69fTyyawrN1TB+n8sh8N9
 v5qEZvgeMEvCdC7olYoEEJV4pBK1w6ocE63Z+JcplWsp3I1rbkGgJOWGoUhTJPMGpEpSFQdRLN0
 mZXW/u8zteBY4LuwQbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX5+AVcw9Lb/IJ
 eL6e8+Wms9GrET2E9FA9fOUWYhJyosG6ddf5UJMa3anM8WcIbBMBP5MhKYLDbz+NrImtiRLcHeB
 qe2A4PduJA32SC+miuql8cX8MUD+r3Q=
X-Proofpoint-ORIG-GUID: NKeGyjiuHspadr7czb298zIRnrsY9CyH
X-Proofpoint-GUID: NKeGyjiuHspadr7czb298zIRnrsY9CyH
X-Authority-Analysis: v=2.4 cv=NqlE4MdJ c=1 sm=1 tr=0 ts=6aecd968 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=VEq9NWtHcDJz48dA:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=eYwCztzd3u1KTHULkCoA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01

The guest's vsock device is not a netdev, so rtnetlink cannot move it
between network namespaces. Add an "ip vsock" object that goes through
the "vsock" generic netlink family instead:

  ip vsock set netns { PID | NETNSNAME | NETNSFILE }
  ip vsock show

"set" issues VSOCK_CMD_DEV_NETNS_SET from inside the target namespace,
since the kernel moves the device to the namespace the request was sent
from. "show" issues VSOCK_CMD_DEV_NETNS_GET and prints where the device
is, relative to the current namespace.

Link: https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 ip/Makefile         |   2 +-
 ip/ip.c             |   3 +-
 ip/ip_common.h      |   1 +
 ip/ipvsock.c        | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-vsock.8 | 121 +++++++++++++++++++++++++++++++
 man/man8/ip.8       |   7 +-
 6 files changed, 336 insertions(+), 3 deletions(-)

diff --git a/ip/Makefile b/ip/Makefile
index 978f68413025..681140ef8ec4 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
     ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
     iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
-    iplink_netkit.o ipstats.o iplink_ovpn.o
+    iplink_netkit.o ipstats.o iplink_ovpn.o ipvsock.o
 
 RTMONOBJ=rtmon.o
 
diff --git a/ip/ip.c b/ip/ip.c
index e4b71bde94b4..68deac93a538 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -63,7 +63,7 @@ static void usage(void)
 		"                   macsec | maddress | monitor | mptcp | mroute | mrule |\n"
 		"                   neighbor | neighbour | netconf | netns | nexthop | ntable |\n"
 		"                   ntbl | route | rule | sr | stats | tap | tcpmetrics |\n"
-		"                   token | tunnel | tuntap | vrf | xfrm }\n"
+		"                   token | tunnel | tuntap | vrf | vsock | xfrm }\n"
 		"       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |\n"
 		"                    -h[uman-readable] | -iec | -j[son] | -p[retty] |\n"
 		"                    -f[amily] { inet | inet6 | mpls | bridge | link } |\n"
@@ -113,6 +113,7 @@ static const struct cmd {
 	{ "netns",	do_netns },
 	{ "netconf",	do_ipnetconf },
 	{ "vrf",	do_ipvrf},
+	{ "vsock",	do_ipvsock },
 	{ "sr",		do_seg6 },
 	{ "nexthop",	do_ipnh },
 	{ "mptcp",	do_mptcp },
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 3f55ea336b37..c82b1132e43c 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -93,6 +93,7 @@ int do_ipnh(int argc, char **argv);
 int do_mptcp(int argc, char **argv);
 int do_ioam6(int argc, char **argv);
 int do_ipstats(int argc, char **argv);
+int do_ipvsock(int argc, char **argv);
 
 int iplink_get(char *name, __u32 filt_mask);
 int iplink_ifla_xstats(int argc, char **argv);
diff --git a/ip/ipvsock.c b/ip/ipvsock.c
new file mode 100644
index 000000000000..ed4347dd0084
--- /dev/null
+++ b/ip/ipvsock.c
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ipvsock.c		"ip vsock"
+ *
+ * The guest's vsock device is not a netdev, so rtnetlink cannot move it.
+ * The "vsock" generic netlink family moves it with VSOCK_CMD_DEV_NETNS_SET
+ * and reports where it is with VSOCK_CMD_DEV_NETNS_GET. There is nothing to
+ * name in a request: the kernel serves it in the namespace of the socket it
+ * arrived on, so the destination is chosen by sending it from there, and the
+ * reported namespace is an nsid relative to the sender.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <linux/genetlink.h>
+#include <linux/net_namespace.h>
+#include <linux/vsock_netlink.h>
+
+#include "libgenl.h"
+#include "utils.h"
+#include "ip_common.h"
+#include "json_print.h"
+#include "namespace.h"
+
+static void usage(void) __attribute__((noreturn));
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage:	ip vsock set netns { PID | NETNSNAME | NETNSFILE }\n"
+		"	ip vsock show\n");
+	exit(-1);
+}
+
+static int vsock_talk(__u8 cmd, struct nlmsghdr **answer)
+{
+	GENL_REQUEST(req, 128, 0, 0, VSOCK_FAMILY_VERSION, cmd, NLM_F_REQUEST);
+	struct rtnl_handle grth = { .fd = -1 };
+	int family = -1;
+	int ret;
+
+	if (genl_init_handle(&grth, VSOCK_FAMILY_NAME, &family)) {
+		fprintf(stderr,
+			"Cannot resolve the \"%s\" netlink family, the kernel may not support moving the vsock device.\n",
+			VSOCK_FAMILY_NAME);
+		return -1;
+	}
+
+	req.n.nlmsg_type = family;
+
+	ret = rtnl_talk(&grth, &req.n, answer);
+	rtnl_close(&grth);
+
+	return ret < 0 ? -2 : 0;
+}
+
+static int vsock_dev_netns_set(const char *netns)
+{
+	int netns_fd, orig_fd, ret;
+
+	netns_fd = netns_get_fd(netns);
+	if (netns_fd < 0) {
+		fprintf(stderr, "Invalid \"netns\" value \"%s\"\n", netns);
+		return -1;
+	}
+
+	orig_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (orig_fd < 0) {
+		fprintf(stderr, "Cannot open namespace: %s\n", strerror(errno));
+		close(netns_fd);
+		return -1;
+	}
+
+	if (setns(netns_fd, CLONE_NEWNET) < 0) {
+		fprintf(stderr, "Cannot set namespace: %s\n", strerror(errno));
+		ret = -1;
+		goto out;
+	}
+
+	/* VSOCK_CMD_DEV_NETNS_SET has no reply, so wait for the ACK. */
+	ret = vsock_talk(VSOCK_CMD_DEV_NETNS_SET, NULL);
+
+	if (setns(orig_fd, CLONE_NEWNET) < 0) {
+		fprintf(stderr, "Cannot restore namespace: %s\n",
+			strerror(errno));
+		ret = -1;
+	}
+
+out:
+	close(orig_fd);
+	close(netns_fd);
+
+	return ret;
+}
+
+static void vsock_print_netnsid(int id)
+{
+	char *name;
+
+	if (is_json_context()) {
+		print_int(PRINT_JSON, "netnsid", NULL, id);
+		return;
+	}
+
+	if (id == NETNSA_NSID_NOT_ASSIGNED) {
+		print_string(PRINT_FP, NULL, " netnsid %s", "unknown");
+		return;
+	}
+
+	name = get_name_from_nsid(id);
+	if (name)
+		print_string(PRINT_FP, NULL, " netns %s", name);
+	else
+		print_int(PRINT_FP, NULL, " netnsid %d", id);
+}
+
+static int vsock_dev_netns_show(void)
+{
+	struct rtattr *tb[VSOCK_A_MAX + 1];
+	struct nlmsghdr *answer;
+	struct genlmsghdr *ghdr;
+	int len, ret;
+
+	ret = vsock_talk(VSOCK_CMD_DEV_NETNS_GET, &answer);
+	if (ret)
+		return ret;
+
+	ghdr = NLMSG_DATA(answer);
+	len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	if (len < 0) {
+		fprintf(stderr, "Wrong vsock reply length %d\n", len);
+		free(answer);
+		return -1;
+	}
+
+	parse_rtattr(tb, VSOCK_A_MAX, (void *)ghdr + GENL_HDRLEN, len);
+
+	new_json_obj(json);
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "dev", "%s", "vsock");
+	if (tb[VSOCK_A_NETNS_ID])
+		vsock_print_netnsid(rta_getattr_s32(tb[VSOCK_A_NETNS_ID]));
+	print_nl();
+	close_json_object();
+	delete_json_obj();
+
+	free(answer);
+
+	return 0;
+}
+
+static int vsock_set(int argc, char **argv)
+{
+	const char *netns = NULL;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "netns") == 0) {
+			NEXT_ARG();
+			if (netns)
+				duparg("netns", *argv);
+			netns = *argv;
+		} else if (matches(*argv, "help") == 0) {
+			usage();
+		} else {
+			invarg("unknown argument", *argv);
+		}
+		argc--;
+		argv++;
+	}
+
+	if (!netns) {
+		fprintf(stderr, "Not enough information: \"netns\" argument is required.\n");
+		exit(-1);
+	}
+
+	return vsock_dev_netns_set(netns);
+}
+
+int do_ipvsock(int argc, char **argv)
+{
+	if (argc < 1)
+		return vsock_dev_netns_show();
+
+	if (matches(*argv, "show") == 0 ||
+	    matches(*argv, "list") == 0) {
+		if (argc > 1)
+			invarg("unknown argument", argv[1]);
+		return vsock_dev_netns_show();
+	}
+
+	if (matches(*argv, "set") == 0)
+		return vsock_set(argc - 1, argv + 1);
+
+	if (matches(*argv, "help") == 0)
+		usage();
+
+	fprintf(stderr, "Command \"%s\" is unknown, try \"ip vsock help\".\n",
+		*argv);
+	exit(-1);
+}
diff --git a/man/man8/ip-vsock.8 b/man/man8/ip-vsock.8
new file mode 100644
index 000000000000..18e618241523
--- /dev/null
+++ b/man/man8/ip-vsock.8
@@ -0,0 +1,121 @@
+.TH IP\-VSOCK 8 "5 Nov 2026" "iproute2" "Linux"
+.SH "NAME"
+ip-vsock \- guest vsock device network namespace management
+.SH "SYNOPSIS"
+.sp
+.ad l
+.in +8
+.ti -8
+.B ip
+.RI "[ " OPTIONS " ]"
+.B vsock
+.RI "{ " COMMAND " | "
+.BR help " }"
+.sp
+
+.ti -8
+.B ip vsock set netns
+.RI "{ " PID " | " NETNSNAME " | " NETNSFILE " }"
+
+.ti -8
+.B ip vsock show
+
+.SH DESCRIPTION
+The
+.B ip vsock
+command manages the network namespace of the guest's vsock device, the one
+owned by the guest-to-host transport. That device is not a network device, so
+it cannot be moved with
+.BR "ip link set" " ... " netns .
+Instead,
+.B ip vsock
+uses the
+.B vsock
+generic netlink family.
+
+.SS ip vsock set netns - move the guest vsock device to a network namespace
+
+Move the device to the network namespace associated with process
+.IR "PID " or
+the name
+.IR "NETNSNAME " or
+the file
+.IR "NETNSFILE" .
+This is carried out with the
+.B VSOCK_CMD_DEV_NETNS_SET
+command, which the kernel serves in the namespace the request is sent from, so
+.B ip vsock
+sends it from inside the destination namespace.
+
+The vsock mode of the destination namespace, reported by
+.IR /proc/sys/net/vsock/ns_mode " and inherited from the creating namespace's"
+.IR /proc/sys/net/vsock/child_ns_mode ,
+then decides who may use the device. A
+.B global
+mode namespace shares it with every other global mode namespace, while a
+.B local
+mode namespace reserves the connection to the host for itself.
+
+The device starts out in the initial namespace, so moving it back there is how
+an assignment is undone. An assignment keeps the namespace alive, so deleting
+the namespace does not move the device. Connections made before the move, from
+a namespace that can no longer reach the device, are reset.
+
+Support is transport dependent: a guest-to-host transport that does not
+implement the move refuses the request with
+.BR EOPNOTSUPP ,
+as does a loaded host-to-guest transport that cannot check the device's CID.
+The move is refused with
+.B EADDRINUSE
+if a guest in the destination namespace already uses the device's CID. The
+command requires
+.B CAP_NET_ADMIN
+in the initial user namespace.
+
+.SS ip vsock show - show the network namespace of the guest vsock device
+
+Show the network namespace the device is in, relative to the current one,
+using the
+.B VSOCK_CMD_DEV_NETNS_GET
+command. This is also what
+.B ip vsock
+does when given no command. Nothing follows
+.B vsock
+when the device is in the current namespace. Otherwise the namespace is printed
+as
+.BI "netns " NETNSNAME
+if it has a name, or as
+.BI "netnsid " ID
+if it does not. When the current namespace cannot reach the device, or no nsid
+can be allocated for the device's namespace, the kernel does not say where the
+device is, and
+.B netnsid unknown
+is printed instead.
+
+.SH EXAMPLES
+.PP
+ip netns add guest
+.br
+ip vsock set netns guest
+.RS 4
+Move the guest vsock device to the network namespace "guest".
+.RE
+.PP
+ip vsock show
+.RS 4
+Show which network namespace the guest vsock device is in.
+.RE
+.PP
+ip vsock set netns 1
+.RS 4
+Move the device back to the initial network namespace, undoing the assignment.
+.RE
+
+.SH SEE ALSO
+.br
+.BR ip (8),
+.BR ip-netns (8),
+.BR vsock (7)
+
+.SH AUTHOR
+Bobby Eshleman <bobbyeshleman@meta.com>
diff --git a/man/man8/ip.8 b/man/man8/ip.8
index fdae57c5f651..0f0a1560e2c3 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -24,7 +24,7 @@ ip \- show / manipulate routing, network devices, interfaces and tunnels
  mroute " | " mrule " | " neighbor " | " neighbour " | " netconf " | "\
  netns " | " nexthop " | " ntable " | " ntbl " | " route " | " rule " | "\
  sr " | " tap " | " tcpmetrics " | " token " | " tunnel " | " tuntap " | "\
- vrf " | " xfrm " }"
+ vrf " | " vsock " | " xfrm " }"
 .sp
 
 .ti -8
@@ -356,6 +356,10 @@ Request the kernel to send the applied configuration back.
 .B vrf
 - manage virtual routing and forwarding devices.
 
+.TP
+.B vsock
+- manage the network namespace of the guest vsock device.
+
 .TP
 .B xfrm
 - manage IPSec policies.
@@ -463,6 +467,7 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR ip-token (8),
 .BR ip-tunnel (8),
 .BR ip-vrf (8),
+.BR ip-vsock (8),
 .BR ip-xfrm (8)
 .br
 .RB "IP Command reference " ip-cref.ps

-- 
2.53.0-Meta

