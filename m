Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4E0C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 10:35:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA4F64F58
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 10:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA4F64F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C2B15859D9;
	Tue,  2 Feb 2021 10:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoROjGU8duyM; Tue,  2 Feb 2021 10:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2CB8185955;
	Tue,  2 Feb 2021 10:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D0C9C1DA8;
	Tue,  2 Feb 2021 10:35:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87590C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 10:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 62CF2204D1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 10:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xeOljmPNKy9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 10:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by silver.osuosl.org (Postfix) with ESMTPS id E2E3221509
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 10:35:38 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60192afa0000>; Tue, 02 Feb 2021 02:35:38 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Tue, 2 Feb 2021 10:35:37 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <dsahern@gmail.com>, <stephen@networkplumber.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH iproute2-next v3 3/5] utils: Add generic socket helpers
Date: Tue, 2 Feb 2021 12:35:16 +0200
Message-ID: <20210202103518.3858-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210202103518.3858-1-parav@nvidia.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612262138; bh=0vc9oIhSCphJBgS2b+BRbxBgWC7qIQCJt2iCtMo/YR4=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=BGkp6h5n8fRszi+YEgOuZUeZbyQQQ1thHiNcLkVvka8MCeg1ySro99CcBBsDUDrwT
 fdL2V7aA6so1x/85U8YHb1BrdHHGqEEiL4l1VRn02k7CNxXBbfHBQiL36tfaOpVoYL
 p3VTqyekp5nh6BesVUP+nXasLduwNkOnnX3UIxlRCfTqKf0NX5ixUtRwOxtuRgw2yY
 rrqFsojThrOalH8SRyBK2H0WMF41Uf+tox84xi1V8dVxXne/l4NjgXf61A1BMkcAkl
 DglreuW3uCBpOgT29fnT7dOFvRWw7msoih5RF0lQjBlPns3g+h57djNtrkjFeuBnDB
 tEeOdQs1Zma6g==
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

Subsequent patch needs to
(a) query and use socket family
(b) send/receive messages using this family

Hence add helper routines to open, close, query family and to perform
send receive operations.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
 - split patch from add vdpa tool for socket helpers
---
 include/mnl_utils.h |  16 ++++++
 lib/mnl_utils.c     | 121 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index fa826ef1..9e7d6879 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -2,6 +2,22 @@
 #ifndef __MNL_UTILS_H__
 #define __MNL_UTILS_H__ 1
 
+struct mnlu_gen_socket {
+	struct mnl_socket *nl;
+	char *buf;
+	uint32_t family;
+	unsigned int seq;
+	uint8_t version;
+};
+
+int mnlu_gen_socket_open(struct mnlu_gen_socket *nlg, const char *family_name,
+			 uint8_t version);
+void mnlu_gen_socket_close(struct mnlu_gen_socket *nlg);
+struct nlmsghdr *mnlu_gen_socket_cmd_prepare(struct mnlu_gen_socket *nlg,
+					     uint8_t cmd, uint16_t flags);
+int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *nlh,
+			   mnl_cb_t data_cb, void *data);
+
 struct mnl_socket *mnlu_socket_open(int bus);
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size);
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 46384ff8..4f699455 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <time.h>
 #include <libmnl/libmnl.h>
+#include <linux/genetlink.h>
 
 #include "libnetlink.h"
 #include "mnl_utils.h"
@@ -108,3 +109,123 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 
 	return err;
 }
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
+static int family_get(struct mnlu_gen_socket *nlg, const char *family_name)
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
+	mnl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
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
+int mnlu_gen_socket_open(struct mnlu_gen_socket *nlg, const char *family_name,
+			 uint8_t version)
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
+	err = family_get(nlg, family_name);
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
+void mnlu_gen_socket_close(struct mnlu_gen_socket *nlg)
+{
+	mnl_socket_close(nlg->nl);
+	free(nlg->buf);
+}
+
+struct nlmsghdr *mnlu_gen_socket_cmd_prepare(struct mnlu_gen_socket *nlg,
+					     uint8_t cmd, uint16_t flags)
+{
+	struct genlmsghdr hdr = {};
+	struct nlmsghdr *nlh;
+
+	hdr.cmd = cmd;
+	hdr.version = nlg->version;
+	nlh = mnlu_msg_prepare(nlg->buf, nlg->family, flags, &hdr, sizeof(hdr));
+	nlg->seq = nlh->nlmsg_seq;
+	return nlh;
+}
+
+int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *nlh,
+			   mnl_cb_t data_cb, void *data)
+{
+	int err;
+
+	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
+	if (err < 0) {
+		perror("Failed to send data");
+		return -errno;
+	}
+
+	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
+				   MNL_SOCKET_BUFFER_SIZE,
+				   data_cb, data);
+	if (err < 0) {
+		fprintf(stderr, "kernel answers: %s\n", strerror(errno));
+		return -errno;
+	}
+	return 0;
+}
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
