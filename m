Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D9C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD7E61507
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FD7E61507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1381A40744;
	Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-_ulRo8SsDr; Thu, 21 Oct 2021 16:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5FF64072E;
	Thu, 21 Oct 2021 16:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCB17C0033;
	Thu, 21 Oct 2021 16:35:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FC3C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A06060661
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8eJbQp4tf4S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 709CC606A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPqu65nPLcrpwnGgQ5ms43VmgNixDTPtQg19Jkz/CKWx//RZkfi7LP8k7pTudWJmxJRVpJZilDiFFBegl7OWbpl/U3PwwLfPq88ID2lgps0859rluTN9I4X8s1DqzcvdcHA8CY8Qy8m9IcoTfr5Rw5/EcAgQQwQSB48rDHEDWDgkrF3F6GLNA/ZFf/mKagU0N75htcdrrqkbOZwNVC5KLynoGVZG4KQkgSE60VIMfHbcZkwwuNWvKerwhTzBaTAHTFaWDKPm+2x90lisPo6ntPUe5Irtv+L+HetQwk78HQHHmdksbbrRMC5MGvSg3gHNqSk9jDyYlTtyq13BJwKsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3x//WUE6hMmEwe4aMK/JV+8tThNsJORmPTadACBSDM=;
 b=OfJUi5BZgXMdXQB9rzAd2bIYMpRncYUuvL4+W3pm+eJQp1/wAJSqlR30dmYqrRj/N8iTx2d3k2cjC5H5bYXhjgL/XvvsVKfViqR6k8Hewl+s0tZ5kh66grWst53jGHdjUMkqJNKXuI0r4fvsRQZ0pr11QA71eXFtR2H711qF/CM4+Om7N+viAlG2yZKLR+H/i4cihjMBALE552Hwww8RkvE/GosA/zO+HX/sO7dSMb+z0JN1g8ldRyKoR6nQblDoIABoao25uiaxjqQr8jzOMbCM4JhKR06UW5HV5P3VY2lfML8AwHcDGOHK1lC6CUw6dBTGeQSRlaLiG48oiyTLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3x//WUE6hMmEwe4aMK/JV+8tThNsJORmPTadACBSDM=;
 b=eYLYfXnK0L+sn7k5cMTKnej2JaZBY9rkaXkbLtZC8NqCeqDXEDQOKPv7LKouZQdDhoHffOKaGsApHB7nsskgnANaL9NJ0iHdBPxEzPGO34wWbG/T9g2T4xyb/lV9uohstCScZSf/CLtsrbM9sTHNe0/ZGhYcDl4qqOy8jaNpOBsOSSO5hyikV/rjkMDhu9uP1TiniiyUjs8946sTCEiCF2YT55xN5+C5skunyincS4tykKeVfckoKf0MHtaHmxm/M0AeYkAnUzni4kqKYBCy9Ybtr2/SwTk0vXjkloMPbH80AP5piZ2HVQ6CXiTc6YMMfR0Zge7v4vLOsCnEOdXZjg==
Received: from CO2PR06CA0071.namprd06.prod.outlook.com (2603:10b6:104:3::29)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:35:33 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::b) by CO2PR06CA0071.outlook.office365.com
 (2603:10b6:104:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:32 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:24 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Date: Thu, 21 Oct 2021 19:35:05 +0300
Message-ID: <20211021163509.6978-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd9d523f-37ff-413f-9e51-08d994b0cd55
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362A9CB34A3C6898DCB8246DCBF9@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SS5rf5vnwPJx3U92Ys8CGNsT3M7F2bMsr35l5jBoQYAOQOSJJrUTjLVKT6KeGV/xrlPxFL42J/Qu0M3o0uKHWZVPSNdkb0eQCQptBW/ujbpZzMMNPyx8ymsOnb9OXLYJKkkLt8j/bGe1smE9zgMTnLbYKvF4vWyvREuXCmtYUBvQoZLoLxVgQXHqzJGiOVyUSO0DTem/HZuBjJayoceB22PSG4a7BtlQ7vqfSY7R4kOBYxnzqWSyKe818t0mANHfmWU9yIvt+8HkftjS+i22OjchZzsr2a4+9iuj5ZHIRyaiYsfnzCSHlbbidG0QxzyzsIkz3feu3KnHsi2agHcqwv9P01E0kkzBOozxvjuUsvVadf96fHnEg7Me5WCk8yjq2O1ZRNeJJFufq7gemXuNWNZsLTNjQcWGSRpoi9UI0lReukeR+7lu2KGNYQJPGSR7jtSMv0T3A2ti/fbdW7WojvGCRJlA9EtGEnR0n0DxSdOv0tjEGW9i6ZIFsxz5MhNmy3ODdnbaVdgAqbJqSeKLjiCjr3sOJCbcYy7wPupG5sYwRNBPa7BFNqO2nVgkSWlMToJdh+xxtwGDOPywD9PcRezqkhRkAKUUxyBPedGY1m+UlPIGJ3NTTOTqJ5cZjbhGqxHgTH+CLx7lM0p6PDBEbCXeGtUz4zyHEGtrYo1rA6SJFHUqPERq+vcVWSuBferAPMowicy7cx6lddHKogFjwA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(316002)(36906005)(82310400003)(36860700001)(4326008)(47076005)(186003)(2616005)(6916009)(36756003)(508600001)(26005)(54906003)(16526019)(6666004)(7636003)(86362001)(336012)(8936002)(5660300002)(8676002)(2906002)(83380400001)(107886003)(356005)(1076003)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:32.3694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9d523f-37ff-413f-9e51-08d994b0cd55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
Cc: elic@nvidia.com, mst@redhat.com
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

$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000

$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000

$ vdpa dev config show -jp
{
    "config": {
        "bar": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 9000,
        }
    }
}

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v3->v4:
 - provide config attributes during device addition time
---
 drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
 drivers/vdpa/vdpa.c                  | 33 ++++++++++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
 include/linux/vdpa.h                 | 17 +++++++++++++-
 7 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index dcd648e1f7e7..6dc75ca70b37 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
 	return dev_type;
 }
 
-static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
+static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+			      const struct vdpa_dev_set_config *config)
 {
 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
 	struct ifcvf_adapter *adapter;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index bd56de7484dc..ca05f69054b6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2404,7 +2404,8 @@ struct mlx5_vdpa_mgmtdev {
 	struct mlx5_vdpa_net *ndev;
 };
 
-static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
+			     const struct vdpa_dev_set_config *add_config)
 {
 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
 	struct virtio_net_config *config;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a50a6aa1cfc4..daa34a61c898 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -14,7 +14,6 @@
 #include <uapi/linux/vdpa.h>
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
-#include <linux/virtio_net.h>
 #include <linux/virtio_ids.h>
 
 static LIST_HEAD(mdev_head);
@@ -472,9 +471,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
+#define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
+				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
+
 static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct vdpa_dev_set_config config = {};
+	struct nlattr **nl_attrs = info->attrs;
 	struct vdpa_mgmt_dev *mdev;
+	const u8 *macaddr;
 	const char *name;
 	int err = 0;
 
@@ -483,6 +488,21 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 
 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
 
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
+	}
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
+		config.net.mtu =
+			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
+	}
+
+	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
+	    !netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
 	mutex_lock(&vdpa_dev_mutex);
 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
 	if (IS_ERR(mdev)) {
@@ -490,8 +510,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "All provided attributes are not supported");
+		err = -EOPNOTSUPP;
+		goto err;
+	}
 
-	err = mdev->ops->dev_add(mdev, name);
+	err = mdev->ops->dev_add(mdev, name, &config);
 err:
 	mutex_unlock(&vdpa_dev_mutex);
 	return err;
@@ -822,6 +848,9 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index a790903f243e..42d401d43911 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
 	.release = vdpasim_blk_mgmtdev_release,
 };
 
-static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
+static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 	struct vdpasim *simdev;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a1ab6163f7d1..d681e423e64f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
 	.release = vdpasim_net_mgmtdev_release,
 };
 
-static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
+static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 	struct vdpasim *simdev;
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 841667a896dd..c9204c62f339 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 	return 0;
 }
 
-static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
+static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
+			const struct vdpa_dev_set_config *config)
 {
 	struct vduse_dev *dev;
 	int ret;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 111153c9ee71..315da5f918dc 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,8 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/virtio_net.h>
+#include <linux/if_ether.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -93,6 +95,14 @@ struct vdpa_iova_range {
 	u64 last;
 };
 
+struct vdpa_dev_set_config {
+	struct {
+		u8 mac[ETH_ALEN];
+		u16 mtu;
+	} net;
+	u64 mask;
+};
+
 /**
  * Corresponding file area for device memory mapping
  * @file: vma->vm_file for the mapping
@@ -393,6 +403,7 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
  * @dev_add: Add a vdpa device using alloc and register
  *	     @mdev: parent device to use for device addition
  *	     @name: name of the new vdpa device
+ *	     @config: config attributes to apply to the device under creation
  *	     Driver need to add a new device using _vdpa_register_device()
  *	     after fully initializing the vdpa device. Driver must return 0
  *	     on success or appropriate error code.
@@ -403,7 +414,8 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
  *	     _vdpa_unregister_device().
  */
 struct vdpa_mgmtdev_ops {
-	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
+	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
+		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
 };
 
@@ -412,12 +424,15 @@ struct vdpa_mgmtdev_ops {
  * @device: Management parent device
  * @ops: operations supported by management device
  * @id_table: Pointer to device id table of supported ids
+ * @config_attr_mask: bit mask of attributes of type enum vdpa_attr that
+ *		      management devie support during dev_add callback
  * @list: list entry
  */
 struct vdpa_mgmt_dev {
 	struct device *device;
 	const struct vdpa_mgmtdev_ops *ops;
 	const struct virtio_device_id *id_table;
+	u64 config_attr_mask;
 	struct list_head list;
 };
 
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
