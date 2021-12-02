Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46967C433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 04:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76B6282849;
	Thu,  2 Dec 2021 04:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRNRM13kqH1Y; Thu,  2 Dec 2021 04:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7C5982C8E;
	Thu,  2 Dec 2021 04:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B86C002F;
	Thu,  2 Dec 2021 04:23:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7F1C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 04:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7946D4049E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 04:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 61fEOK9BVsmi
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 04:23:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A610403BA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6TCadSUl981LrFbUJjWNoh+cZ+yv8X2gsObvv0m91Bu/wAJqGYdSkRnIKF3pevRMejYOEvdpQNCZO3YrLRLnw+ZG4t/LwekhwCHN6QA8oBBPdT7cWISu4hi1GeDzBbWPwIC8l4NPyPvR3Ce99BI4vb5qqzxyAFXdySAdlLTNFUC+g27qgSyOzF5x7eakFzgMo+GVnA2pO9SmHoGTM1YjyEPG8ExAPrhl8z6KFcjemRfKbKABkhYsMAjmf8frc+6WYPmdYisD5smhSzrGqJKIkndj6D4jwxv4pJFvhcEFQdTo6IbXrEgiVbPRrkhhHZYkQyOcbFtTJbWl3wayam5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODQ79hkxgSlPh2Eun7Po8t9WTe6wKeiTcQawTBiqr5w=;
 b=NuHDkyElfKup7CGSqHGLr5c5ICjRdLcwZxP6WDCrLd5R8YVmUH+itYbCVXsE62NUdhNuQzFa4ol2koSbLJ4FlVo1StWmBc00VF/gY++Ycn4sXztP0O+i3Cjwv4d2+Xf+WRfg4yVVD4P+DWPqCLcpEQSjQ0Utmm68IkW/wYut3d2szlQInWjB37QQgWO//2v2nYW3KdAmF44RVgPB29jjc5D2HEuBKR/A4XXcopjFKA8Z08CCPvEvV9kSC3vPaQJltQ65CTwIyc2ujIhubwRH5aGZy7QeZs6SXwY+KWCq3MRAnNSOlUkcKpr+u9nde9XMiUgJEqdnAEksmQxCaiDUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODQ79hkxgSlPh2Eun7Po8t9WTe6wKeiTcQawTBiqr5w=;
 b=B518aAyKy/XDe8J1CX0ixXlRZ6NUWSGo24+a7tCezXEmfk9m0FDlRqF9T1NVMDqJLRCaQk47vYuEiHCPSb2NG0i7jfIFPdqoPYEiLfp3jrM/rnwxRk8OKRD5WXpspffcTAuxjlpPxHSyb2UuyvgDyjZPp/Vby9oInZqKekG9Ikk602mioEPBIViUJYVPQyK2ElUUdtoDmjG+ujQvI0OVJhFuQV2by9KPt2Zb1s+mCmhoF4pVlu1f3x+g38JOlw263SCRHQDD/S6BJINSrK6I28XeAHxsvSxl1+xlbUk0x4qcu8KWiGVgaNfr7VQjWkhviD2j2VFmbdoT+g8K4rWkqA==
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by CY4PR12MB1816.namprd12.prod.outlook.com (2603:10b6:903:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 04:23:05 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b0) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 04:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 04:23:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Dec
 2021 20:23:03 -0800
Received: from unicorn01.mtl.labs.mlnx (172.20.187.5) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; 
 Wed, 1 Dec 2021 20:23:01 -0800
To: <dsahern@gmail.com>, <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: [iproute2-next 3/4] vdpa: Enable user to set mac address of vdpa
 device
Date: Thu, 2 Dec 2021 06:22:38 +0200
Message-ID: <20211202042239.2454-4-parav@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202042239.2454-1-parav@nvidia.com>
References: <20211202042239.2454-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aedeaaf-9590-46e2-0ea3-08d9b54b6f57
X-MS-TrafficTypeDiagnostic: CY4PR12MB1816:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1816370962422EDDE090C246DC699@CY4PR12MB1816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdGFRFe7ubLMRX2R80Rm+dsvtI3WrGoPe9uCX4WfTUKA6gaBK1DaX0Ql6IXS3dLpmrLGUDhTdkk5yOQAi9eey3a9v4ROVXudfQnC3EiDVLP33e0yvD8GGe4dW4wT7Bx1O9ZRoLNatBaZ4ZPkdsCAKMRhCyNmIx2JNkYgxLLZVOvtK1Tx59xtI0tjcKxIsXh2sE2yJ+IoY/PTuXLMG3tGtNMj+d8buD3qtW/K59knfJlvePl3DWim0fPnOiIm0bq7GNn57zPKnlu4VM1pUgNmc6ulw43Uu3W87OBHjKLdv4HgQ5bEj6VbWB3rGI8LemXWKlaHIRq8UWi1Oggh4KBbapxyQTbH8tGayHa0XzKX1mxszQNu2Zrd5BvynaPvlR+BORUWCD2HuP5lutrwBWSVeYyg9j2YhRNH8bhE9+f/I4Xy3iy+u8xP4VSR3jcak+ve8hInVpUANONJo06NWbkTz2JvvKvh1xIKkCnQPZ/VlEDFyfrjxx/I/eZ7XSUzCN36v8tG4ftNXIikU9TVnSxY65+5hfyRYZW3DV2PMw+iuFybT8WqvN0wXfF1zfERysd/RfFBX9DeE1kn+GQ2ZIrpWSkhf0sPRrSpnlZcys1DGd238h+N9TmSEWLUsYRV6u8HyKi6ER+2SLDfzk5Eo/HSpzJwq+XYP0qaoUqGbVCyg+5Gs+LCi65ojqNpEF/TXpJceEQqb0GQQS+jwxLyRYToaVX5mG1kFfKy8/lNq+nGqxyIPhM91TSW3uVe40CjmzYD2X5w6Hk+zpZQn02AIEc26Q==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(356005)(5660300002)(8936002)(70586007)(36756003)(2616005)(2906002)(186003)(16526019)(107886003)(36860700001)(6666004)(40460700001)(1076003)(86362001)(8676002)(7636003)(336012)(4326008)(82310400004)(316002)(83380400001)(47076005)(426003)(26005)(54906003)(508600001)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:23:04.3068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aedeaaf-9590-46e2-0ea3-08d9b54b6f57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1816
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

vdpa: Enable user to set mtu of the vdpa device

Implement mtu setting for vdpa device.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net

Add the device with specified mac address:
$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 1500

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 vdpa/vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index ba704254..9d20bdb4 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -4,6 +4,7 @@
 #include <getopt.h>
 #include <errno.h>
 #include <linux/genetlink.h>
+#include <linux/if_ether.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_net.h>
@@ -20,6 +21,7 @@
 #define VDPA_OPT_VDEV_MGMTDEV_HANDLE	BIT(1)
 #define VDPA_OPT_VDEV_NAME		BIT(2)
 #define VDPA_OPT_VDEV_HANDLE		BIT(3)
+#define VDPA_OPT_VDEV_MAC		BIT(4)
 
 struct vdpa_opts {
 	uint64_t present; /* flags of present items */
@@ -27,6 +29,7 @@ struct vdpa_opts {
 	char *mdev_name;
 	const char *vdev_name;
 	unsigned int device_id;
+	char mac[ETH_ALEN];
 };
 
 struct vdpa {
@@ -136,6 +139,21 @@ static int vdpa_argv_str(struct vdpa *vdpa, int argc, char **argv,
 	return 0;
 }
 
+static int vdpa_argv_mac(struct vdpa *vdpa, int argc, char **argv, char *mac)
+{
+	int alen;
+
+	if (argc <= 0 || *argv == NULL) {
+		fprintf(stderr, "String parameter expected\n");
+		return -EINVAL;
+	}
+
+	alen = ll_addr_a2n(mac, ETH_ALEN, *argv);
+	if (alen < 0)
+		return -EINVAL;
+	return 0;
+}
+
 struct vdpa_args_metadata {
 	uint64_t o_flag;
 	const char *err_msg;
@@ -183,13 +201,16 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
 	if ((opts->present & VDPA_OPT_VDEV_NAME) ||
 	    (opts->present & VDPA_OPT_VDEV_HANDLE))
 		mnl_attr_put_strz(nlh, VDPA_ATTR_DEV_NAME, opts->vdev_name);
+	if (opts->present & VDPA_OPT_VDEV_MAC)
+		mnl_attr_put(nlh, VDPA_ATTR_DEV_NET_CFG_MACADDR,
+			     sizeof(opts->mac), opts->mac);
 }
 
 static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
-			   uint64_t o_required)
+			   uint64_t o_required, uint64_t o_optional)
 {
+	uint64_t o_all = o_required | o_optional;
 	struct vdpa_opts *opts = &vdpa->opts;
-	uint64_t o_all = o_required;
 	uint64_t o_found = 0;
 	int err;
 
@@ -233,6 +254,15 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 
 			NEXT_ARG_FWD();
 			o_found |= VDPA_OPT_VDEV_MGMTDEV_HANDLE;
+		} else if ((matches(*argv, "mac")  == 0) &&
+			   (o_all & VDPA_OPT_VDEV_MAC)) {
+			NEXT_ARG_FWD();
+			err = vdpa_argv_mac(vdpa, argc, argv, opts->mac);
+			if (err)
+				return err;
+
+			NEXT_ARG_FWD();
+			o_found |= VDPA_OPT_VDEV_MAC;
 		} else {
 			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
 			return -EINVAL;
@@ -246,11 +276,11 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 
 static int vdpa_argv_parse_put(struct nlmsghdr *nlh, struct vdpa *vdpa,
 			       int argc, char **argv,
-			       uint64_t o_required)
+			       uint64_t o_required, uint64_t o_optional)
 {
 	int err;
 
-	err = vdpa_argv_parse(vdpa, argc, argv, o_required);
+	err = vdpa_argv_parse(vdpa, argc, argv, o_required, o_optional);
 	if (err)
 		return err;
 	vdpa_opts_put(nlh, vdpa);
@@ -386,7 +416,7 @@ static int cmd_mgmtdev_show(struct vdpa *vdpa, int argc, char **argv)
 					  flags);
 	if (argc > 0) {
 		err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
-					  VDPA_OPT_MGMTDEV_HANDLE);
+					  VDPA_OPT_MGMTDEV_HANDLE, 0);
 		if (err)
 			return err;
 	}
@@ -413,7 +443,7 @@ static int cmd_mgmtdev(struct vdpa *vdpa, int argc, char **argv)
 static void cmd_dev_help(void)
 {
 	fprintf(stderr, "Usage: vdpa dev show [ DEV ]\n");
-	fprintf(stderr, "       vdpa dev add name NAME mgmtdev MANAGEMENTDEV\n");
+	fprintf(stderr, "       vdpa dev add name NAME mgmtdev MANAGEMENTDEV [ mac MACADDR ]\n");
 	fprintf(stderr, "       vdpa dev del DEV\n");
 	fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");
 }
@@ -483,7 +513,7 @@ static int cmd_dev_show(struct vdpa *vdpa, int argc, char **argv)
 	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_GET, flags);
 	if (argc > 0) {
 		err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
-					  VDPA_OPT_VDEV_HANDLE);
+					  VDPA_OPT_VDEV_HANDLE, 0);
 		if (err)
 			return err;
 	}
@@ -502,7 +532,8 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc, char **argv)
 	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_NEW,
 					  NLM_F_REQUEST | NLM_F_ACK);
 	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
-				  VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME);
+				  VDPA_OPT_VDEV_MGMTDEV_HANDLE | VDPA_OPT_VDEV_NAME,
+				  VDPA_OPT_VDEV_MAC);
 	if (err)
 		return err;
 
@@ -516,7 +547,8 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc, char **argv)
 
 	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_DEL,
 					  NLM_F_REQUEST | NLM_F_ACK);
-	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv, VDPA_OPT_VDEV_HANDLE);
+	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv, VDPA_OPT_VDEV_HANDLE,
+				  0);
 	if (err)
 		return err;
 
@@ -597,7 +629,7 @@ static int cmd_dev_config_show(struct vdpa *vdpa, int argc, char **argv)
 					  flags);
 	if (argc > 0) {
 		err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
-					  VDPA_OPT_VDEV_HANDLE);
+					  VDPA_OPT_VDEV_HANDLE, 0);
 		if (err)
 			return err;
 	}
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
