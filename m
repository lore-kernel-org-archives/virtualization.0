Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B4AC433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 07:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEC7F410BD;
	Thu, 10 Nov 2022 07:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEC7F410BD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+K5vGJw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vd1pjEGzWmrl; Thu, 10 Nov 2022 07:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC94941061;
	Thu, 10 Nov 2022 07:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC94941061
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C47EBC0032;
	Thu, 10 Nov 2022 07:58:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D676FC007B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1F8B8188B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1F8B8188B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+K5vGJw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJxQkuzRcUW8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBF108146B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBF108146B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668067117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M6sH1zCJVBe30EusnL+C19gqs0oRp5i4d5XNacJ1JZY=;
 b=d+K5vGJwU774AiQU7hJ3vGs65/LyC9D1p9t0xEZHt8s8eQPwNYLn66/SctEpmdNV3/bq/7
 siRuk7Q2b8dVIXalRMnnGxaTs8npDfWZe1pMaQTeZtecRqV3eBZHOAzV4KFOT/LrdKRbFp
 8jPXs5cbYDYN9G778PvRr0WQXDrtGDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-XojLt8CTN3mxcGsAdtr9Hw-1; Thu, 10 Nov 2022 02:58:30 -0500
X-MC-Unique: XojLt8CTN3mxcGsAdtr9Hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28E13811E81;
 Thu, 10 Nov 2022 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-174.pek2.redhat.com
 [10.72.12.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CFDC2027061;
 Thu, 10 Nov 2022 07:58:24 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] vdpa: allow provisioning device features
Date: Thu, 10 Nov 2022 15:58:21 +0800
Message-Id: <20221110075821.3818-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

This patch allows device features to be provisioned via vdpa. This
will be useful for preserving migration compatibility between source
and destination:

# vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
# dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
      negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 man/man8/vdpa-dev.8            | 10 ++++++++++
 vdpa/include/uapi/linux/vdpa.h |  1 +
 vdpa/vdpa.c                    | 27 ++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
index 9faf3838..bb45b4a6 100644
--- a/man/man8/vdpa-dev.8
+++ b/man/man8/vdpa-dev.8
@@ -31,6 +31,7 @@ vdpa-dev \- vdpa device configuration
 .I NAME
 .B mgmtdev
 .I MGMTDEV
+.RI "[ device_features " DEVICE_FEATURES " ]"
 .RI "[ mac " MACADDR " ]"
 .RI "[ mtu " MTU " ]"
 .RI "[ max_vqp " MAX_VQ_PAIRS " ]"
@@ -74,6 +75,10 @@ Name of the new vdpa device to add.
 Name of the management device to use for device addition.
 
 .PP
+.BI device_features " DEVICE_FEAETURES"
+- specifies the device features that is provisioned for the new vdpa device.
+This is optional.
+
 .BI mac " MACADDR"
 - specifies the mac address for the new vdpa device.
 This is applicable only for the network type of vdpa device. This is optional.
@@ -127,6 +132,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net
 Add the vdpa device named foo on the management device vdpa_sim_net.
 .RE
 .PP
+vdpa dev add name foo mgmtdev vdpa_sim_net device_features 0x300020000
+.RS 4
+Add the vdpa device named foo on the management device vdpa_sim_net with device_features of 0x300020000
+.RE
+.PP
 vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55
 .RS 4
 Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55.
diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
index 94e4dad1..7c961991 100644
--- a/vdpa/include/uapi/linux/vdpa.h
+++ b/vdpa/include/uapi/linux/vdpa.h
@@ -51,6 +51,7 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
 	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
 	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
+	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index b73e40b4..9a866d61 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -27,6 +27,7 @@
 #define VDPA_OPT_VDEV_MTU		BIT(5)
 #define VDPA_OPT_MAX_VQP		BIT(6)
 #define VDPA_OPT_QUEUE_INDEX		BIT(7)
+#define VDPA_OPT_VDEV_FEATURES		BIT(8)
 
 struct vdpa_opts {
 	uint64_t present; /* flags of present items */
@@ -38,6 +39,7 @@ struct vdpa_opts {
 	uint16_t mtu;
 	uint16_t max_vqp;
 	uint32_t queue_idx;
+	__u64 device_features;
 };
 
 struct vdpa {
@@ -187,6 +189,17 @@ static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
 	return get_u32(result, *argv, 10);
 }
 
+static int vdpa_argv_u64_hex(struct vdpa *vdpa, int argc, char **argv,
+			     __u64 *result)
+{
+	if (argc <= 0 || !*argv) {
+		fprintf(stderr, "number expected\n");
+		return -EINVAL;
+	}
+
+	return get_u64(result, *argv, 16);
+}
+
 struct vdpa_args_metadata {
 	uint64_t o_flag;
 	const char *err_msg;
@@ -244,6 +257,10 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
 		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
 	if (opts->present & VDPA_OPT_QUEUE_INDEX)
 		mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
+	if (opts->present & VDPA_OPT_VDEV_FEATURES) {
+		mnl_attr_put_u64(nlh, VDPA_ATTR_DEV_FEATURES,
+				opts->device_features);
+	}
 }
 
 static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
@@ -329,6 +346,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 
 			NEXT_ARG_FWD();
 			o_found |= VDPA_OPT_QUEUE_INDEX;
+		} else if (!strcmp(*argv, "device_features") &&
+			   (o_optional & VDPA_OPT_VDEV_FEATURES)) {
+			NEXT_ARG_FWD();
+			err = vdpa_argv_u64_hex(vdpa, argc, argv,
+						&opts->device_features);
+			if (err)
+				return err;
+			o_found |= VDPA_OPT_VDEV_FEATURES;
 		} else {
 			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
 			return -EINVAL;
@@ -708,7 +733,7 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
 	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
 				  VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME,
 				  VDPA_OPT_VDEV_MAC | VDPA_OPT_VDEV_MTU |
-				  VDPA_OPT_MAX_VQP);
+				  VDPA_OPT_MAX_VQP | VDPA_OPT_VDEV_FEATURES);
 	if (err)
 		return err;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
