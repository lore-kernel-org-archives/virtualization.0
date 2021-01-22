Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119AC433DB
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 11:27:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825122DCC
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 11:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825122DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 50E6B2E0EB;
	Fri, 22 Jan 2021 11:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o+Sx1-MbvKZq; Fri, 22 Jan 2021 11:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 023FA2E0DC;
	Fri, 22 Jan 2021 11:27:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC97C08A1;
	Fri, 22 Jan 2021 11:27:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D9DCC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3E1322E0E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-QasZOI4ogj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by silver.osuosl.org (Postfix) with ESMTPS id A8E4E2E0DC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:27:17 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600ab6940002>; Fri, 22 Jan 2021 03:27:16 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 22 Jan 2021 11:27:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next 2/2] vdpa: Add vdpa tool
Date: Fri, 22 Jan 2021 13:26:54 +0200
Message-ID: <20210122112654.9593-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210122112654.9593-1-parav@nvidia.com>
References: <20210122112654.9593-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611314837; bh=KkRdGRQtbOEoLosxxNRCJZKnNuFc6rWyWj/ibFF6IGw=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=o2yVTxviFQpGn+yroVSBEuul+X3c6GV485fkDNvrnJNaFfhY2cDZ/euSXXo4hg9S8
 /XUBV3ouLQRXcGL4JLIhLDPrAcXBV2NVWFcF8quUM8bJwtrZBEV2cS7LcgQZg6WvGk
 NCPcAGYETeGOQhXbGaArqAIwGYmeoaaYc2xo571Vhg7i6GkJviCJG/oT/5TMhUe18q
 1rj8+qHrryTFCRJruBUOrnxpwkVnvpHmtN+P+umTMn1mN/t3famRQHpv8UTvjwXzOb
 MPkSffm9xVuTMIQDo8Mfvn5QIIXEuLvAUg6CY8ngJu7uCuakCetSIdGD4dk9/NuUW0
 mxE5EXqTokKLQ==
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

vdpa tool is created to create, delete and query vdpa devices.
examples:
Show vdpa management device that supports creating, deleting vdpa devices.

$ vdpa mgmtdev show
vdpasim:
  supported_classes net

$ vdpa mgmtdev show -jp
{
    "show": {
        "vdpasim": {
            "supported_classes": [ "net" ]
        }
    }
}

Create a vdpa device of type networking named as "foo2" from
the management device vdpasim_net:

$ vdpa dev add mgmtdev vdpasim_net name foo2

Show the newly created vdpa device by its name:
$ vdpa dev show foo2
foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2 max_vq_size 256

$ vdpa dev show foo2 -jp
{
    "dev": {
        "foo2": {
            "type": "network",
            "mgmtdev": "vdpasim_net",
            "vendor_id": 0,
            "max_vqs": 2,
            "max_vq_size": 256
        }
    }
}

Delete the vdpa device after its use:
$ vdpa dev del foo2

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 Makefile                |   2 +-
 man/man8/vdpa-dev.8     |  96 +++++
 man/man8/vdpa-mgmtdev.8 |  53 +++
 man/man8/vdpa.8         |  76 ++++
 vdpa/Makefile           |  24 ++
 vdpa/vdpa.c             | 828 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1078 insertions(+), 1 deletion(-)
 create mode 100644 man/man8/vdpa-dev.8
 create mode 100644 man/man8/vdpa-mgmtdev.8
 create mode 100644 man/man8/vdpa.8
 create mode 100644 vdpa/Makefile
 create mode 100644 vdpa/vdpa.c

diff --git a/Makefile b/Makefile
index e64c6599..19bd163e 100644
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,7 @@ WFLAGS += -Wmissing-declarations -Wold-style-definition -Wformat=2
 CFLAGS := $(WFLAGS) $(CCOPTS) -I../include -I../include/uapi $(DEFINES) $(CFLAGS)
 YACCFLAGS = -d -t -v
 
-SUBDIRS=lib ip tc bridge misc netem genl tipc devlink rdma dcb man
+SUBDIRS=lib ip tc bridge misc netem genl tipc devlink rdma dcb man vdpa
 
 LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
 LDLIBS += $(LIBNETLINK)
diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
new file mode 100644
index 00000000..36433519
--- /dev/null
+++ b/man/man8/vdpa-dev.8
@@ -0,0 +1,96 @@
+.TH DEVLINK\-DEV 8 "5 Jan 2021" "iproute2" "Linux"
+.SH NAME
+vdpa-dev \- vdpa device configuration
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.B vdpa
+.B dev
+.RI "[ " OPTIONS " ] "
+.RI  " { " COMMAND | " "
+.BR help " }"
+.sp
+
+.ti -8
+.IR OPTIONS " := { "
+\fB\-V\fR[\fIersion\fR]
+}
+
+.ti -8
+.B vdpa dev show
+.RI "[ " DEV " ]"
+
+.ti -8
+.B vdpa dev help
+
+.ti -8
+.B vdpa dev add
+.B name
+.I NAME
+.B mgmtdev
+.I MGMTDEV
+
+.ti -8
+.B vdpa dev del
+.I DEV
+
+.SH "DESCRIPTION"
+.SS vdpa dev show - display vdpa device attributes
+
+.PP
+.I "DEV"
+- specifies the vdpa device to show.
+If this argument is omitted all devices are listed.
+
+.in +4
+Format is:
+.in +2
+VDPA_DEVICE_NAME
+
+.SS vdpa dev add - add a new vdpa device.
+
+.TP
+.BI name " NAME"
+Name of the new vdpa device to add.
+
+.TP
+.BI mgmtdev " MGMTDEV"
+Name of the management device to use for device addition.
+
+.SS vdpa dev del - Delete the vdpa device.
+
+.PP
+.I "DEV"
+- specifies the vdpa device to delete.
+
+.SH "EXAMPLES"
+.PP
+vdpa dev show
+.RS 4
+Shows the all vdpa devices on the system.
+.RE
+.PP
+vdpa dev show foo
+.RS 4
+Shows the specified vdpa device.
+.RE
+.PP
+vdpa dev add name foo mgmtdev vdpa_sim_net
+.RS 4
+Add the vdpa device named foo on the management device vdpa_sim_net.
+.RE
+.PP
+vdpa dev del foo
+.RS 4
+Delete the vdpa device named foo which was previously created.
+.RE
+
+.SH SEE ALSO
+.BR vdpa (8),
+.BR vdpa-mgmtdev (8),
+.br
+
+.SH AUTHOR
+Parav Pandit <parav@nvidia.com>
diff --git a/man/man8/vdpa-mgmtdev.8 b/man/man8/vdpa-mgmtdev.8
new file mode 100644
index 00000000..cae2cbd0
--- /dev/null
+++ b/man/man8/vdpa-mgmtdev.8
@@ -0,0 +1,53 @@
+.TH DEVLINK\-DEV 8 "5 Jan 2021" "iproute2" "Linux"
+.SH NAME
+vdpa-dev \- vdpa management device view
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.B vdpa
+.B mgmtdev
+.RI  " { " COMMAND | " "
+.BR help " }"
+.sp
+
+.ti -8
+.IR OPTIONS " := { "
+\fB\-V\fR[\fIersion\fR]
+}
+
+.ti -8
+.B vdpa mgmtdev show
+.RI "[ " MGMTDEV " ]"
+
+.ti -8
+.B vdpa mgmtdev help
+
+.SH "DESCRIPTION"
+.SS vdpa mgmtdev show - display vdpa management device attributes
+
+.PP
+.I "MGMTDEV"
+- specifies the vdpa management device to show.
+If this argument is omitted all management devices are listed.
+
+.SH "EXAMPLES"
+.PP
+vdpa mgmtdev show
+.RS 4
+Shows all the vdpa management devices on the system.
+.RE
+.PP
+vdpa mgmtdev show bar
+.RS 4
+Shows the specified vdpa management device.
+.RE
+
+.SH SEE ALSO
+.BR vdpa (8),
+.BR vdpa-dev (8),
+.br
+
+.SH AUTHOR
+Parav Pandit <parav@nvidia.com>
diff --git a/man/man8/vdpa.8 b/man/man8/vdpa.8
new file mode 100644
index 00000000..d1aaecec
--- /dev/null
+++ b/man/man8/vdpa.8
@@ -0,0 +1,76 @@
+.TH VDPA 8 "5 Jan 2021" "iproute2" "Linux"
+.SH NAME
+vdpa \- vdpa management tool
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.B vdpa
+.RI "[ " OPTIONS " ] { " dev | mgmtdev " } { " COMMAND " | "
+.BR help " }"
+.sp
+
+.SH OPTIONS
+
+.TP
+.BR "\-V" , " --Version"
+Print the version of the
+.B vdpa
+utility and exit.
+
+.TP
+.BR "\-j" , " --json"
+Generate JSON output.
+
+.TP
+.BR "\-p" , " --pretty"
+When combined with -j generate a pretty JSON output.
+
+.SS
+.I OBJECT
+
+.TP
+.B dev
+- vdpa device.
+
+.TP
+.B mgmtdev
+- vdpa management device.
+
+.SS
+.I COMMAND
+
+Specifies the action to perform on the object.
+The set of possible actions depends on the object type.
+It is possible to
+.B show
+(or
+.B list
+) objects. The
+.B help
+command is available for all objects. It prints
+out a list of available commands and argument syntax conventions.
+.sp
+If no command is given, some default command is assumed.
+Usually it is
+.B show
+or, if the objects of this class cannot be listed,
+.BR "help" .
+
+.SH EXIT STATUS
+Exit status is 0 if command was successful or a positive integer upon failure.
+
+.SH SEE ALSO
+.BR vdpa-dev (8),
+.BR vdpa-mgmtdev (8),
+.br
+
+.SH REPORTING BUGS
+Report any bugs to the Network Developers mailing list
+.B <netdev@vger.kernel.org>
+where the development and maintenance is primarily done.
+You do not have to be subscribed to the list to send a message there.
+
+.SH AUTHOR
+Parav Pandit <parav@nvidia.com>
diff --git a/vdpa/Makefile b/vdpa/Makefile
new file mode 100644
index 00000000..275f9ded
--- /dev/null
+++ b/vdpa/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../config.mk
+
+TARGETS :=
+
+ifeq ($(HAVE_MNL),y)
+
+VDPAOBJ = vdpa.o
+TARGETS += vdpa
+
+endif
+
+all: $(TARGETS) $(LIBS)
+
+vdpa: $(VDPAOBJ)
+	$(QUIET_LINK)$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@
+
+install: all
+	for i in $(TARGETS); \
+	do install -m 0755 $$i $(DESTDIR)$(SBINDIR); \
+	done
+
+clean:
+	rm -f $(VDPAOBJ) $(TARGETS)
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
new file mode 100644
index 00000000..942524b7
--- /dev/null
+++ b/vdpa/vdpa.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <linux/vdpa.h>
+#include <linux/virtio_ids.h>
+#include <linux/netlink.h>
+#include <libmnl/libmnl.h>
+#include "mnl_utils.h"
+
+#include "version.h"
+#include "json_print.h"
+#include "utils.h"
+
+static int g_indent_level;
+
+#define INDENT_STR_STEP 2
+#define INDENT_STR_MAXLEN 32
+static char g_indent_str[INDENT_STR_MAXLEN + 1] = "";
+
+struct vdpa_socket {
+	struct mnl_socket *nl;
+	char *buf;
+	uint32_t family;
+	unsigned int seq;
+};
+
+static int vdpa_socket_sndrcv(struct vdpa_socket *nlg, const struct nlmsghdr *nlh,
+			      mnl_cb_t data_cb, void *data)
+{
+	int err;
+
+	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
+	if (err < 0) {
+		perror("Failed to send data");
+		return -errno;
+	}
+
+	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf, MNL_SOCKET_BUFFER_SIZE,
+				   data_cb, data);
+	if (err < 0) {
+		fprintf(stderr, "vdpa answers: %s\n", strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
+
+static int get_family_id_attr_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, CTRL_ATTR_MAX) < 0)
+		return MNL_CB_ERROR;
+
+	if (type == CTRL_ATTR_FAMILY_ID &&
+	    mnl_attr_validate(attr, MNL_TYPE_U16) < 0)
+		return MNL_CB_ERROR;
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+static int get_family_id_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
+	uint32_t *p_id = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), get_family_id_attr_cb, tb);
+	if (!tb[CTRL_ATTR_FAMILY_ID])
+		return MNL_CB_ERROR;
+	*p_id = mnl_attr_get_u16(tb[CTRL_ATTR_FAMILY_ID]);
+	return MNL_CB_OK;
+}
+
+static int family_get(struct vdpa_socket *nlg)
+{
+	struct genlmsghdr hdr = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	hdr.cmd = CTRL_CMD_GETFAMILY;
+	hdr.version = 0x1;
+
+	nlh = mnlu_msg_prepare(nlg->buf, GENL_ID_CTRL,
+			       NLM_F_REQUEST | NLM_F_ACK,
+			       &hdr, sizeof(hdr));
+
+	mnl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME, VDPA_GENL_NAME);
+
+	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
+	if (err < 0)
+		return err;
+
+	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
+				   MNL_SOCKET_BUFFER_SIZE,
+				   get_family_id_cb, &nlg->family);
+	return err;
+}
+
+static int vdpa_socket_open(struct vdpa_socket *nlg)
+{
+	int err;
+
+	nlg->buf = malloc(MNL_SOCKET_BUFFER_SIZE);
+	if (!nlg->buf)
+		goto err_buf_alloc;
+
+	nlg->nl = mnlu_socket_open(NETLINK_GENERIC);
+	if (!nlg->nl)
+		goto err_socket_open;
+
+	err = family_get(nlg);
+	if (err)
+		goto err_socket;
+
+	return 0;
+
+err_socket:
+	mnl_socket_close(nlg->nl);
+err_socket_open:
+	free(nlg->buf);
+err_buf_alloc:
+	return -1;
+}
+
+static void vdpa_socket_close(struct vdpa_socket *nlg)
+{
+	mnl_socket_close(nlg->nl);
+	free(nlg->buf);
+}
+
+#define VDPA_OPT_MGMTDEV_HANDLE		BIT(0)
+#define VDPA_OPT_VDEV_MGMTDEV_HANDLE	BIT(1)
+#define VDPA_OPT_VDEV_NAME 		BIT(2)
+#define VDPA_OPT_VDEV_HANDLE 		BIT(3)
+
+struct vdpa_opts {
+	uint64_t present; /* flags of present items */
+	const char *mdev_bus_name;
+	const char *mdev_name;
+	const char *vdev_name;
+	unsigned int device_id;
+};
+
+struct vdpa {
+	struct vdpa_socket nlg;
+	struct vdpa_opts opts;
+	bool json_output;
+};
+
+static void indent_inc(void)
+{
+	if (g_indent_level + INDENT_STR_STEP > INDENT_STR_MAXLEN)
+		return;
+	g_indent_level += INDENT_STR_STEP;
+	memset(g_indent_str, ' ', sizeof(g_indent_str));
+	g_indent_str[g_indent_level] = '\0';
+}
+
+static void indent_dec(void)
+{
+	if (g_indent_level - INDENT_STR_STEP < 0)
+		return;
+	g_indent_level -= INDENT_STR_STEP;
+	g_indent_str[g_indent_level] = '\0';
+}
+
+static void indent_print(void)
+{
+	if (g_indent_level)
+		printf("%s", g_indent_str);
+}
+
+static void pr_out_section_start(struct vdpa *vdpa, const char *name)
+{
+	open_json_object(NULL);
+	open_json_object(name);
+}
+
+static void pr_out_section_end(struct vdpa *vdpa)
+{
+	close_json_object();
+	close_json_object();
+}
+
+static void pr_out_array_start(struct vdpa *vdpa, const char *name)
+{
+	if (!vdpa->json_output) {
+		print_nl();
+		indent_inc();
+		indent_print();
+	}
+	open_json_array(PRINT_ANY, name);
+}
+
+static void pr_out_array_end(struct vdpa *vdpa)
+{
+	close_json_array(PRINT_JSON, NULL);
+	if (!vdpa->json_output)
+		indent_dec();
+}
+
+static const enum mnl_attr_data_type vdpa_policy[VDPA_ATTR_MAX + 1] = {
+	[VDPA_ATTR_MGMTDEV_BUS_NAME] = MNL_TYPE_NUL_STRING,
+	[VDPA_ATTR_MGMTDEV_DEV_NAME] = MNL_TYPE_NUL_STRING,
+	[VDPA_ATTR_DEV_NAME] = MNL_TYPE_STRING,
+	[VDPA_ATTR_DEV_ID] = MNL_TYPE_U32,
+	[VDPA_ATTR_DEV_VENDOR_ID] = MNL_TYPE_U32,
+	[VDPA_ATTR_DEV_MAX_VQS] = MNL_TYPE_U32,
+	[VDPA_ATTR_DEV_MAX_VQ_SIZE] = MNL_TYPE_U16,
+};
+
+static int attr_cb(const struct nlattr *attr, void *data)
+{
+	const struct nlattr **tb = data;
+	int type;
+
+	if (mnl_attr_type_valid(attr, VDPA_ATTR_MAX) < 0)
+		return MNL_CB_OK;
+
+	type = mnl_attr_get_type(attr);
+	if (mnl_attr_validate(attr, vdpa_policy[type]) < 0)
+		return MNL_CB_ERROR;
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+static unsigned int strslashcount(char *str)
+{
+	unsigned int count = 0;
+	char *pos = str;
+
+	while ((pos = strchr(pos, '/'))) {
+		count++;
+		pos++;
+	}
+	return count;
+}
+
+static int strslashrsplit(char *str, const char **before, const char **after)
+{
+	char *slash;
+
+	slash = strrchr(str, '/');
+	if (!slash)
+		return -EINVAL;
+	*slash = '\0';
+	*before = str;
+	*after = slash + 1;
+	return 0;
+}
+
+static int vdpa_argv_handle(struct vdpa *vdpa, int argc, char **argv,
+			    const char **p_mdev_bus_name,
+			    const char **p_mdev_name)
+{
+	unsigned int slashcount;
+	char *str;
+
+	if (argc <= 0 || *argv == NULL) {
+		fprintf(stderr,
+			"vdpa identification (\"mgmtdev_bus_name/mgmtdev_name\") expected\n");
+		return -EINVAL;
+	}
+	str = *argv;
+	slashcount = strslashcount(str);
+	if (slashcount > 1) {
+		fprintf(stderr,
+			"Wrong vdpa mgmtdev identification string format\n");
+		fprintf(stderr, "Expected \"mgmtdev_bus_name/mgmtdev_name\"\n");
+		fprintf(stderr, "Expected \"mgmtdev_name\"\n");
+		return -EINVAL;
+	}
+	switch (slashcount) {
+	case 0:
+		*p_mdev_bus_name = NULL;
+		*p_mdev_name = str;
+		return 0;
+	case 1:
+		strslashrsplit(str, p_mdev_bus_name, p_mdev_name);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vdpa_argv_str(struct vdpa *vdpa, int argc, char **argv,
+			 const char **p_str)
+{
+	if (argc <= 0 || *argv == NULL) {
+		fprintf(stderr, "String parameter expected\n");
+		return -EINVAL;
+	}
+	*p_str = *argv;
+	return 0;
+}
+
+struct vdpa_args_metadata {
+	uint64_t o_flag;
+	const char *err_msg;
+};
+
+static const struct vdpa_args_metadata vdpa_args_required[] = {
+	{VDPA_OPT_VDEV_MGMTDEV_HANDLE, "management device handle not set."},
+	{VDPA_OPT_VDEV_NAME, "device name is not set."},
+	{VDPA_OPT_VDEV_HANDLE, "device name is not set."},
+};
+
+static int vdpa_args_finding_required_validate(uint64_t o_required,
+					       uint64_t o_found)
+{
+	uint64_t o_flag;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vdpa_args_required); i++) {
+		o_flag = vdpa_args_required[i].o_flag;
+		if ((o_required & o_flag) && !(o_found & o_flag)) {
+			fprintf(stderr, "%s\n", vdpa_args_required[i].err_msg);
+			return -EINVAL;
+		}
+	}
+	if (o_required & ~o_found) {
+		fprintf(stderr, "BUG: unknown argument required but not found\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
+{
+	struct vdpa_opts *opts = &vdpa->opts;
+
+	if ((opts->present & VDPA_OPT_MGMTDEV_HANDLE) ||
+	    (opts->present & VDPA_OPT_VDEV_MGMTDEV_HANDLE)) {
+		if (opts->mdev_bus_name)
+			mnl_attr_put_strz(nlh, VDPA_ATTR_MGMTDEV_BUS_NAME,
+					  opts->mdev_bus_name);
+		mnl_attr_put_strz(nlh, VDPA_ATTR_MGMTDEV_DEV_NAME,
+				  opts->mdev_name);
+	}
+	if ((opts->present & VDPA_OPT_VDEV_NAME) ||
+	    (opts->present & VDPA_OPT_VDEV_HANDLE))
+		mnl_attr_put_strz(nlh, VDPA_ATTR_DEV_NAME, opts->vdev_name);
+}
+
+static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
+			   uint64_t o_required)
+{
+	struct vdpa_opts *opts = &vdpa->opts;
+	uint64_t o_all = o_required;
+	uint64_t o_found = 0;
+	int err;
+
+	if (o_required & VDPA_OPT_MGMTDEV_HANDLE) {
+		err = vdpa_argv_handle(vdpa, argc, argv, &opts->mdev_bus_name,
+				       &opts->mdev_name);
+		if (err)
+			return err;
+
+		NEXT_ARG_FWD();
+		o_found |= VDPA_OPT_MGMTDEV_HANDLE;
+	} else if (o_required & VDPA_OPT_VDEV_HANDLE) {
+		err = vdpa_argv_str(vdpa, argc, argv, &opts->vdev_name);
+		if (err)
+			return err;
+
+		NEXT_ARG_FWD();
+		o_found |= VDPA_OPT_VDEV_HANDLE;
+	}
+
+	while (NEXT_ARG_OK()) {
+		if ((matches(*argv, "name") == 0) && (o_all & VDPA_OPT_VDEV_NAME)) {
+			const char *namestr;
+
+			NEXT_ARG_FWD();
+			err = vdpa_argv_str(vdpa, argc, argv, &namestr);
+			if (err)
+				return err;
+			opts->vdev_name = namestr;
+			NEXT_ARG_FWD();
+			o_found |= VDPA_OPT_VDEV_NAME;
+		} else if ((matches(*argv, "mgmtdev")  == 0) &&
+			   (o_all & VDPA_OPT_VDEV_MGMTDEV_HANDLE)) {
+			NEXT_ARG_FWD();
+			err = vdpa_argv_handle(vdpa, argc, argv,
+					       &opts->mdev_bus_name,
+					       &opts->mdev_name);
+			if (err)
+				return err;
+
+			NEXT_ARG_FWD();
+			o_found |= VDPA_OPT_VDEV_MGMTDEV_HANDLE;
+		} else {
+			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
+			return -EINVAL;
+		}
+	}
+
+	opts->present = o_found;
+
+	return vdpa_args_finding_required_validate(o_required, o_found);
+}
+
+static int vdpa_argv_parse_put(struct nlmsghdr *nlh, struct vdpa *vdpa,
+			       int argc, char **argv,
+			       uint64_t o_required)
+{
+	int err;
+
+	err = vdpa_argv_parse(vdpa, argc, argv, o_required);
+	if (err)
+		return err;
+	vdpa_opts_put(nlh, vdpa);
+	return 0;
+}
+
+static void cmd_mgmtdev_help(void)
+{
+	fprintf(stderr, "Usage: vdpa mgmtdev show [ DEV ]\n");
+}
+
+static void pr_out_handle_start(struct vdpa *vdpa, struct nlattr **tb)
+{
+	const char *mdev_bus_name = NULL;
+	const char *mdev_name;
+	SPRINT_BUF(buf);
+
+	mdev_name = mnl_attr_get_str(tb[VDPA_ATTR_MGMTDEV_DEV_NAME]);
+	if (tb[VDPA_ATTR_MGMTDEV_BUS_NAME]) {
+		mdev_bus_name = mnl_attr_get_str(tb[VDPA_ATTR_MGMTDEV_BUS_NAME]);
+		sprintf(buf, "%s/%s", mdev_bus_name, mdev_name);
+	} else {
+		sprintf(buf, "%s", mdev_name);
+	}
+
+	if (vdpa->json_output)
+		open_json_object(buf);
+	else
+		printf("%s: ", buf);
+}
+
+static void pr_out_handle_end(struct vdpa *vdpa)
+{
+	if (vdpa->json_output)
+		close_json_object();
+	else
+		print_nl();
+}
+
+static void __pr_out_vdev_handle_start(struct vdpa *vdpa, const char *vdev_name)
+{
+	SPRINT_BUF(buf);
+
+	sprintf(buf, "%s", vdev_name);
+	if (vdpa->json_output)
+		open_json_object(buf);
+	else
+		printf("%s: ", buf);
+}
+
+static void pr_out_vdev_handle_start(struct vdpa *vdpa, struct nlattr **tb)
+{
+	const char *vdev_name;
+
+	vdev_name = mnl_attr_get_str(tb[VDPA_ATTR_DEV_NAME]);
+	__pr_out_vdev_handle_start(vdpa, vdev_name);
+}
+
+static void pr_out_vdev_handle_end(struct vdpa *vdpa)
+{
+	if (vdpa->json_output)
+		close_json_object();
+	else
+		print_nl();
+}
+
+static void pr_out_mgmtdev_show(struct vdpa *vdpa, const struct nlmsghdr *nlh,
+				  struct nlattr **tb)
+{
+	int i;
+
+	pr_out_handle_start(vdpa, tb);
+
+	if (tb[VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES]) {
+		uint64_t classes = mnl_attr_get_u64(tb[VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES]);
+
+		pr_out_array_start(vdpa, "supported_classes");
+
+		for (i = 1; i < 64; i++) {
+			if ((classes & (1ULL << i)) == 0)
+				continue;
+
+			switch (i) {
+			case VIRTIO_ID_NET:
+				print_string(PRINT_ANY, NULL, " %s", "net");
+				break;
+			case VIRTIO_ID_BLOCK:
+				print_string(PRINT_ANY, NULL, " %s", "block");
+				break;
+			default:
+				print_string(PRINT_ANY, NULL, " %s", "unknown");
+				break;
+			}
+		}
+		pr_out_array_end(vdpa);
+	}
+
+	pr_out_handle_end(vdpa);
+}
+
+static int cmd_mgmtdev_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[VDPA_ATTR_MAX + 1] = {};
+	struct vdpa *vdpa = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+
+	if (!tb[VDPA_ATTR_MGMTDEV_DEV_NAME])
+		return MNL_CB_ERROR;
+
+	pr_out_mgmtdev_show(vdpa, nlh, tb);
+
+	return MNL_CB_OK;
+}
+
+static struct nlmsghdr *
+vdpa_prepare(struct vdpa_socket *nlg, uint16_t flags, uint8_t cmd)
+{
+	struct genlmsghdr hdr = {};
+	struct nlmsghdr *nlh;
+
+	hdr.cmd = cmd;
+	hdr.version = VDPA_GENL_VERSION;
+	nlh = mnlu_msg_prepare(nlg->buf, nlg->family, flags, &hdr, sizeof(hdr));
+	return nlh;
+}
+
+static int cmd_mgmtdev_show(struct vdpa *vdpa, int argc, char **argv)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlmsghdr *nlh;
+	int err;
+
+	if (argc == 0)
+		flags |= NLM_F_DUMP;
+
+	nlh = vdpa_prepare(&vdpa->nlg, flags, VDPA_CMD_MGMTDEV_GET);
+	if (argc > 0) {
+		err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
+					  VDPA_OPT_MGMTDEV_HANDLE);
+		if (err)
+			return err;
+	}
+
+	pr_out_section_start(vdpa, "mgmtdev");
+	err = vdpa_socket_sndrcv(&vdpa->nlg, nlh, cmd_mgmtdev_show_cb, vdpa);
+	pr_out_section_end(vdpa);
+	return err;
+}
+
+static int cmd_mgmtdev(struct vdpa *vdpa, int argc, char **argv)
+{
+	if (!argc || matches(*argv, "help") == 0) {
+		cmd_mgmtdev_help();
+		return 0;
+	} else if (matches(*argv, "show") == 0 ||
+		   matches(*argv, "list") == 0) {
+		return cmd_mgmtdev_show(vdpa, argc - 1, argv + 1);
+	}
+	fprintf(stderr, "Command \"%s\" not found\n", *argv);
+	return -ENOENT;
+}
+
+static void cmd_dev_help(void)
+{
+	fprintf(stderr, "Usage: vdpa dev show [ DEV ]\n");
+	fprintf(stderr, "       vdpa dev add name NAME mgmtdev MANAGEMENTDEV\n");
+	fprintf(stderr, "       vdpa dev del DEV\n");
+}
+
+static const char *device_type_name(uint32_t type)
+{
+	switch (type) {
+	case 0x1: return "network";
+	case 0x2: return "block";
+	default: return "<unknown type>";
+	}
+}
+
+static void pr_out_dev(struct vdpa *vdpa, struct nlattr **tb)
+{
+	const char *mdev_name = mnl_attr_get_str(tb[VDPA_ATTR_MGMTDEV_DEV_NAME]);
+	uint32_t device_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
+	const char *mdev_bus_name = NULL;
+	char mgmtdev_buf[128];
+
+	if (tb[VDPA_ATTR_MGMTDEV_BUS_NAME])
+		mdev_bus_name = mnl_attr_get_str(tb[VDPA_ATTR_MGMTDEV_BUS_NAME]);
+
+	if (mdev_bus_name)
+		sprintf(mgmtdev_buf, "%s/%s", mdev_bus_name, mdev_name);
+	else
+		sprintf(mgmtdev_buf, "%s", mdev_name);
+	pr_out_vdev_handle_start(vdpa, tb);
+	print_string(PRINT_ANY, "type", "type %s", device_type_name(device_id));
+	print_string(PRINT_ANY, "mgmtdev", " mgmtdev %s", mgmtdev_buf);
+
+	if (tb[VDPA_ATTR_DEV_VENDOR_ID])
+		print_uint(PRINT_ANY, "vendor_id", " vendor_id %u",
+			   mnl_attr_get_u32(tb[VDPA_ATTR_DEV_VENDOR_ID]));
+	if (tb[VDPA_ATTR_DEV_MAX_VQS])
+		print_uint(PRINT_ANY, "max_vqs", " max_vqs %u",
+			   mnl_attr_get_u32(tb[VDPA_ATTR_DEV_MAX_VQS]));
+	if (tb[VDPA_ATTR_DEV_MAX_VQ_SIZE])
+		print_uint(PRINT_ANY, "max_vq_size", " max_vq_size %u",
+			   mnl_attr_get_u16(tb[VDPA_ATTR_DEV_MAX_VQ_SIZE]));
+	pr_out_vdev_handle_end(vdpa);
+}
+
+static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[VDPA_ATTR_MAX + 1] = {};
+	struct vdpa *vdpa = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+	if (!tb[VDPA_ATTR_MGMTDEV_DEV_NAME] ||
+	    !tb[VDPA_ATTR_DEV_NAME] || !tb[VDPA_ATTR_DEV_ID])
+		return MNL_CB_ERROR;
+	pr_out_dev(vdpa, tb);
+	return MNL_CB_OK;
+}
+
+static int cmd_dev_show(struct vdpa *vdpa, int argc, char **argv)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlmsghdr *nlh;
+	int err;
+
+	if (argc <= 0)
+		flags |= NLM_F_DUMP;
+
+	nlh = vdpa_prepare(&vdpa->nlg, flags, VDPA_CMD_DEV_GET);
+	if (argc > 0) {
+		err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
+					  VDPA_OPT_VDEV_HANDLE);
+		if (err)
+			return err;
+	}
+
+	pr_out_section_start(vdpa, "dev");
+	err = vdpa_socket_sndrcv(&vdpa->nlg, nlh, cmd_dev_show_cb, vdpa);
+	pr_out_section_end(vdpa);
+	return err;
+}
+
+static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = vdpa_prepare(&vdpa->nlg, NLM_F_REQUEST | NLM_F_ACK,
+			   VDPA_CMD_DEV_NEW);
+	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
+				  VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME);
+	if (err)
+		return err;
+
+	return vdpa_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
+}
+
+static int cmd_dev_del(struct vdpa *vdpa,  int argc, char **argv)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = vdpa_prepare(&vdpa->nlg, NLM_F_REQUEST | NLM_F_ACK,
+			   VDPA_CMD_DEV_DEL);
+	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv, VDPA_OPT_VDEV_HANDLE);
+	if (err)
+		return err;
+
+	return vdpa_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
+}
+
+static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
+{
+	if (!argc)
+		return cmd_dev_show(vdpa, argc - 1, argv + 1);
+
+	if (matches(*argv, "help") == 0) {
+		cmd_dev_help();
+		return 0;
+	} else if (matches(*argv, "show") == 0 ||
+		   matches(*argv, "list") == 0) {
+		return cmd_dev_show(vdpa, argc - 1, argv + 1);
+	} else if (matches(*argv, "add") == 0) {
+		return cmd_dev_add(vdpa, argc - 1, argv + 1);
+	} else if (matches(*argv, "del") == 0) {
+		return cmd_dev_del(vdpa, argc - 1, argv + 1);
+	}
+	fprintf(stderr, "Command \"%s\" not found\n", *argv);
+	return -ENOENT;
+}
+
+static void help(void)
+{
+	fprintf(stderr,
+		"Usage: vdpa [ OPTIONS ] OBJECT { COMMAND | help }\n"
+		"where  OBJECT := { mgmtdev | dev }\n"
+		"       OPTIONS := { -V[ersion] | -n[o-nice-names] | -j[son] | -p[retty] | -v[erbose] }\n");
+}
+
+static int vdpa_cmd(struct vdpa *vdpa, int argc, char **argv)
+{
+	if (!argc || matches(*argv, "help") == 0) {
+		help();
+		return 0;
+	} else if (matches(*argv, "mgmtdev") == 0) {
+		return cmd_mgmtdev(vdpa, argc - 1, argv + 1);
+	} else if (matches(*argv, "dev") == 0) {
+		return cmd_dev(vdpa, argc - 1, argv + 1);
+	}
+	fprintf(stderr, "Object \"%s\" not found\n", *argv);
+	return -ENOENT;
+}
+
+static int vdpa_init(struct vdpa *vdpa)
+{
+	int err;
+
+	err = vdpa_socket_open(&vdpa->nlg);
+	if (err) {
+		fprintf(stderr, "Failed to connect to vdpa Netlink\n");
+		return -errno;
+	}
+	new_json_obj_plain(vdpa->json_output);
+	return 0;
+}
+
+static void vdpa_fini(struct vdpa *vdpa)
+{
+	delete_json_obj_plain();
+	vdpa_socket_close(&vdpa->nlg);
+}
+
+static struct vdpa *vdpa_alloc(void)
+{
+	return calloc(1, sizeof(struct vdpa));
+}
+
+static void vdpa_free(struct vdpa *vdpa)
+{
+	free(vdpa);
+}
+
+int main(int argc, char **argv)
+{
+	static const struct option long_options[] = {
+		{ "Version",		no_argument,	NULL, 'V' },
+		{ "json",		no_argument,	NULL, 'j' },
+		{ "pretty",		no_argument,	NULL, 'p' },
+		{ "help",		no_argument,	NULL, 'h' },
+		{ NULL, 0, NULL, 0 }
+	};
+	struct vdpa *vdpa;
+	int opt;
+	int err;
+	int ret;
+
+	vdpa = vdpa_alloc();
+	if (!vdpa) {
+		fprintf(stderr, "Failed to allocate memory for vdpa\n");
+		return EXIT_FAILURE;
+	}
+
+	while ((opt = getopt_long(argc, argv, "Vjpsh", long_options, NULL)) >= 0) {
+		switch (opt) {
+		case 'V':
+			printf("vdpa utility, iproute2-%s\n", version);
+			ret = EXIT_SUCCESS;
+			goto vdpa_free;
+		case 'j':
+			vdpa->json_output = true;
+			break;
+		case 'p':
+			pretty = true;
+			break;
+		case 'h':
+			help();
+			ret = EXIT_SUCCESS;
+			goto vdpa_free;
+		default:
+			fprintf(stderr, "Unknown option.\n");
+			help();
+			ret = EXIT_FAILURE;
+			goto vdpa_free;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	err = vdpa_init(vdpa);
+	if (err) {
+		ret = EXIT_FAILURE;
+		goto vdpa_free;
+	}
+
+	err = vdpa_cmd(vdpa, argc, argv);
+	if (err) {
+		ret = EXIT_FAILURE;
+		goto vdpa_fini;
+	}
+
+	ret = EXIT_SUCCESS;
+
+vdpa_fini:
+	vdpa_fini(vdpa);
+vdpa_free:
+	vdpa_free(vdpa);
+	return ret;
+}
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
