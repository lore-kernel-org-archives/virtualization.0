Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52A76109D
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D52A76109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A40A8403F8;
	Tue, 26 Oct 2021 17:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e0P0yyyV7_Jm; Tue, 26 Oct 2021 17:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9600403F4;
	Tue, 26 Oct 2021 17:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46B01C0023;
	Tue, 26 Oct 2021 17:56:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C14C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C73380F94
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4q24mpOYe6_w
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 330D680F33
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APuWfZPwfgH9CoEuQTiFrxvZ6UKGOjgkJXAmpMuC9RISAh1MYADCg8HPAuJFdteC7kZpRPmQgKRMPupASnGdik9Visan8DLdh5xz2+QNpPcZUsIdenPfNtjnXKIAugGxYyoAxd+wHC6hMMT3S4souMmpmaiYzR31Ib/vsgH5QAncGeQHfPcrlKJTO+oosLUIgHTfSyFDP+6wmE4SWh016dlmMjS/kgsZK3ggHSqYt92IJiuBHF1scKyRALa3iZ9ESZi7iF13W12nQebPU6Zktd5ix8IlUR7rMZk/nqK9l5uzKKVNcD7MVwTtxzNWHD2ai/38ie/OG8klofAm0EZ4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yMQy4hlT6IOlrzz+Sm0NeECoppRNTmqsvqFnOdFVCI=;
 b=GHs/ku9AnhHjhBScuL8nz4odYN34URtE406792VvyyZu9Lp/MsZGI3kEaGc0kuJ1qdUyyr+z4xvRfoWp5a6HbhK0ZqLWpUY+OiRHrv3jAFbEZvdGWO7ClM2l+3eG89ncU9kx43BJjZW2y10h8nWyDuPD6iCxTal65Nx9xN2ZkiitgX+zcJ9EGWa7mat2TrDyGfdIa7E3geV39UyL1rIUvbVqBuDHW6kMmnFtcTaRD357ufcnkPebAXmORg37hqtiXVdHwo0XhHRtjw+6+bIUSOOYCB/AOHd5dXBry/WQNPPoDytG9p7CngqhJpcR3/L7BlFMmjgSy8gSTg4w7ajEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yMQy4hlT6IOlrzz+Sm0NeECoppRNTmqsvqFnOdFVCI=;
 b=IuQOwiIphjQq++PURe0R93Y6q0bGtTd0wUAouIfUl3Vv1wApESM1gC6qBiUZGAfaKSqZQkWiE4uh/Dqbv7dCM3OcunQsJWekhsXaycODl6GkVa8VsisS2Hn0Bq5Fu1dAu20pLlgraW0naMzZE0cO7TqMz9jJtYQtlgehFJbCEOAroZgvCGOYbf/f6ZhZGlK667P7y9p+voAFAZC/1APNAn2deCH8Amv+45Wj3c4lJgM/FMa6rX0BOXy9zuhptVM3q4wZ/fbNRPPAZU/Vz6XlWpdHmGCq846XY1KFn9x4R5tGqARhFX8Nng294otlGh34SD8WM5VL7wlvLmUeHcZInw==
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:56:00 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2c) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 17:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:55:58 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:50 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Date: Tue, 26 Oct 2021 20:55:15 +0300
Message-ID: <20211026175519.87795-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8df0ef2-5fe5-4e01-ba23-08d998a9de25
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0057:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005708B62C1D3E00CDB515B1DC849@DM5PR1201MB0057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMhJvSDpSRUWnV6MyJEHY17gLVxcFwoSuxwj8+tLogcnVEjnjXV/q12v3BVJpU3kX8lSFv7S7ZH67Zp7KeH3OTRlyOsbC3FlM1hfLei6HTCM5NrF4h/UJKPl16nJl0pVi7lF+xC5G3n9lBhhBiuM2h01fpYzuIiU0BConPxY4uIkBXcmgulEkG4P4PAC5l3A9tWdd19HBqIR1H+aFA8h94zKHVQew9Kz8LzB/TyKm6WooF4Wt7uxP2lboOjltMBQutAfy1/hcvha9cOt19ouzZGCgi1npC7rlpGeuaavU4j5YYz0UfIGzcxUiOoSgbZGwL7ZFoW91X6K/UHVMGzhtvlcjCeeqxagOKi22LoL4fvRTcdcgOxOSmiRZZ+hdADgDfakOklMgYPb9Nyb6dlJxph/oQhM3wpLHHRFO94POwsuWyJNjafk3S3REIA64LY9DrkeY//thV96SIHapLNCf3Al0M55ipqiThR/G63pvBuHBfev2SJxaV6TZkV58ryAukDT7A0BvEEYln3dQBHoWOHID6luQe9CKLhRsNlam2wnZ/9tTAXyshgmGAMJj9z9xfmy1Epy2c085oP3auNHCbh4znVK8hQYUZtxOtVuPpYIpVfhbgQObXXVwMnpIUXsm8jKmFnu3k6UrYjyqfqps8WuyZcF0hiEXTXm8u5wagGjvMeDBS1UjNsqxzwDyqR7VQA0dmGCaHvMAjWlu68HUw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(6666004)(316002)(356005)(36860700001)(4326008)(36756003)(82310400003)(16526019)(426003)(7636003)(26005)(2616005)(54906003)(70206006)(107886003)(47076005)(8676002)(1076003)(508600001)(70586007)(186003)(336012)(5660300002)(2906002)(83380400001)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:55:58.7528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df0ef2-5fe5-4e01-ba23-08d998a9de25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0057
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
Acked-by: Jason Wang <jasowang@redhat.com>

---
changelog:
v5->v6:
 - fixed typo of device
v4->v5:
 - added comment for checking device capabilities
v3->v4:
 - provide config attributes during device addition time
---
 drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
 drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
 include/linux/vdpa.h                 | 17 ++++++++++++-
 7 files changed, 62 insertions(+), 8 deletions(-)

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
index b5bd1a553256..6bbdc0ece707 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2482,7 +2482,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
 	return ret;
 }
 
-static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
+			     const struct vdpa_dev_set_config *add_config)
 {
 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
 	struct virtio_net_config *config;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 973c56fb60b9..a1168a7fa8b8 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -14,7 +14,6 @@
 #include <uapi/linux/vdpa.h>
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
-#include <linux/virtio_net.h>
 #include <linux/virtio_ids.h>
 
 static LIST_HEAD(mdev_head);
@@ -480,9 +479,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
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
 
@@ -491,6 +496,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 
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
+	/* Skip checking capability if user didn't prefer to configure any
+	 * device networking attributes. It is likely that user might have used
+	 * a device specific method to configure such attributes or using device
+	 * default attributes.
+	 */
+	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
+	    !netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
 	mutex_lock(&vdpa_dev_mutex);
 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
 	if (IS_ERR(mdev)) {
@@ -498,8 +523,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
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
@@ -835,6 +866,9 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
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
index fafb7202482c..c3011ccda430 100644
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
@@ -397,6 +407,7 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
  * @dev_add: Add a vdpa device using alloc and register
  *	     @mdev: parent device to use for device addition
  *	     @name: name of the new vdpa device
+ *	     @config: config attributes to apply to the device under creation
  *	     Driver need to add a new device using _vdpa_register_device()
  *	     after fully initializing the vdpa device. Driver must return 0
  *	     on success or appropriate error code.
@@ -407,7 +418,8 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
  *	     _vdpa_unregister_device().
  */
 struct vdpa_mgmtdev_ops {
-	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
+	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
+		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
 };
 
@@ -416,12 +428,15 @@ struct vdpa_mgmtdev_ops {
  * @device: Management parent device
  * @ops: operations supported by management device
  * @id_table: Pointer to device id table of supported ids
+ * @config_attr_mask: bit mask of attributes of type enum vdpa_attr that
+ *		      management device support during dev_add callback
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
