Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E3C43460
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DED613BC
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DED613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E250584A65;
	Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGoy6BU4bqrw; Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 247C084A4E;
	Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4CF3C0016;
	Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6C09C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 786D140FAD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KgSqBIUm7n9B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB08140F9B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpoxr0Iq98W0pzbJ76aKgPLWRJtrGQ1A2QrD/xDTwjXUvLHAqk/KJotMPrzb4NNQA+uITjhAcroVdtwfQAVjzpxeLZIjBHd9bKhbIfAhimzDVuIyWOCSrLpJiwonXiCPcKb0cVEixuvrpfi/1nX9Qh4oSH07CxnU2vOdfbKezWSYOxZVFMF33IJy94eqRvuCoRsqPhDr2yHMjsPOgWtZahY647+EecXqJquB5eBCK2z8AtuZGS1YQXvcA/FK6R4bxK6clgAFxkgG5WpdxOAOno+rWRpTP9b+safZ/SCqh023ewheZJ3mO4DiSezAyJc4nX2jx9jNPsAiYT7d9kMYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2sLYFSaNAXCs/X5IunLUbfrCxe/Bz0IaIKjB5hw2LY=;
 b=DFjqCbJHh+I+gTGEuOewYustzcY3tUtegrHDzFK417WRecsq+XjCyg4ZLFJzOOQsMeT0R95tI7B/8Qgj6u/XHV1QcOzcpu3p0qSb4/rTih/YU3FrJiCgz9M+ry26PNrhnTWDjqXWuoA8jWN4NETwKXalzOlMOWi9H+hsoRzjQ/6DNOxP1OXAjKlf9vF4xXj3OYmhugbOkjoMe84bvahbHrv+eGNakKvE8tqqlP8r0XG200obMoySWN7g866qpKyQ6AaSgTQULkopF8LOQNkA6gW979IQrFt6XthQ2Uf7lZxdfIWutkaTUPNZ+42QfKP+f6qcZbKiv0++G/aYwnKnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2sLYFSaNAXCs/X5IunLUbfrCxe/Bz0IaIKjB5hw2LY=;
 b=YdB7RnubEtbFRArlMJMJGZC9k66a2ohmGnLCXB5uOSfix+8V06U1o7NuBSrscymFvipfdC/ED7lZxawmLOtnCPuvae0m5vnQ58PG9+vsMQSNSiCbqnctRX5AzCIKLyRB9YhOqZczjtjDovhCxH8GUvKgqmKLlBSlYqyyG6YoboyDpoiOHs4uYoSi/M+SaUL1p55TWHVVz3d8d92GWl8yhDcL5kOcmyGfNx5u0BgH1et22br41Qh7wRaFOroLFKMR0ztrUy7oxuns7FY8nVHngbKe1BH8DWbuwhWpn7am7IWt+bOohtMY3G2bBwo9dKTSmNkgrI4MMXXebDcoltCduQ==
Received: from MWHPR19CA0056.namprd19.prod.outlook.com (2603:10b6:300:94::18)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:18 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::2f) by MWHPR19CA0056.outlook.office365.com
 (2603:10b6:300:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:18 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 05/14] vdpa: Enable user to set mac and mtu of
 vdpa device
Date: Tue, 6 Apr 2021 20:04:48 +0300
Message-ID: <20210406170457.98481-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db01a602-7947-4968-3924-08d8f91e27e1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4172:
X-Microsoft-Antispam-PRVS: <DM6PR12MB417257E31F19052E7EC3A538DC769@DM6PR12MB4172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXKXyFak1r7taYUwu/MQS85pdo2pizaWRSlOMJHWActN16hvDYInl4AsX8KXCBRdxVhQhjbRar817c5esjPyWVyBRkR/FtR7vIrXAydoNJSN5uHh43KEtn1Q7lzPpsfpGqvBbqh5bdsKTg2OTOr4HUH91VL5DelXxgjrBo9S87VrfnMMTtoC47q4cMrjkKklNO5ArY0/2o6+mrIPE6ZVjf0RQxOpKtiZufVw0zfnGwr81hYwTHk8lPlt4W2ViIK/C7jqaEN9MdbZAt0kFx55gpraUhQ4I9AVK1Iwl59SsaMS3YpGnW+xBw8JZYPvUOiGkHXR/ExyQAi3eKXygdittQB6k3/7J4wHyhsn7JuJfbBMTklaJ1f5kv6vUNQOvIiG8XzvXAx3iW5pkofdXGFS4ai939fHm8U1NA65uG6Q0ym5fZ17f02bsghoK3R2kzA4NCYhsk6oVOjclXXflQsZlRnajuVkLiTFd34ReYyAlg07z7uRIrqRBWO+HlItgss+xK3wUf/GvOJZ0agR3uWIJeK/RpGRZYXmGHkn+GubNVmsfb06KigHAdV9algQT3D6WaVNuUc/LJiUGprWeisXt3lgrCTp6N38E1I+aYr2yTMdxMx8uUFl+isCfJf0kXplIy6UCNPUObgWywYgIZX+Uw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(82740400003)(47076005)(16526019)(82310400003)(478600001)(316002)(8936002)(1076003)(6916009)(6666004)(70206006)(36906005)(186003)(70586007)(36756003)(26005)(83380400001)(54906003)(8676002)(36860700001)(86362001)(336012)(2616005)(426003)(7636003)(2906002)(356005)(4326008)(5660300002)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:18.5292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db01a602-7947-4968-3924-08d8f91e27e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

$ vdpa dev add name bar mgmtdev vdpasim_net

$ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000

$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0

$ vdpa dev config show -jp
{
    "config": {
        "bar": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 9000,
            "speed": 0,
            "duplex": 0
        }
    }
}

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v1->v2:
 - fixed mtu range checking for max
 - using NLA_POLICY_ETH_ADDR
 - set config moved to device ops instead of mgmtdev ops
 - merged build and set to single routine
 - ensuring that user has NET_ADMIN capability for configuring network
   attributes
---
 drivers/vdpa/vdpa.c       | 90 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      | 15 +++++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9da8deb8c0f2..6a6ef1a085e8 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -881,10 +881,94 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
 	return msg->len;
 }
 
+static int vdpa_dev_net_config_set(struct vdpa_device *vdev,
+				   struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr **nl_attrs = info->attrs;
+	struct vdpa_dev_set_config config = {};
+	const u8 *macaddr;
+	int err;
+
+	if (!vdev->config->set_ce_config)
+		return -EOPNOTSUPP;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
+		config.net_mask.mac_valid = true;
+	}
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
+		config.net.mtu =
+			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
+		config.net_mask.mtu_valid = true;
+	}
+
+	mutex_lock(&vdev->cf_mutex);
+	err = vdev->config->set_ce_config(vdev, &config);
+	mutex_unlock(&vdev->cf_mutex);
+	return err;
+}
+
+static int vdpa_dev_config_set(struct vdpa_device *vdev, struct sk_buff *skb,
+			       struct genl_info *info)
+{
+	int err = -EOPNOTSUPP;
+	u32 device_id;
+
+	if (!vdev->mdev)
+		return -EOPNOTSUPP;
+
+	device_id = vdev->config->get_device_id(vdev);
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		err = vdpa_dev_net_config_set(vdev, skb, info);
+		break;
+	default:
+		break;
+	}
+	return err;
+}
+
+static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct vdpa_device *vdev;
+	const char *devname;
+	struct device *dev;
+	int err;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+
+	mutex_lock(&vdpa_dev_mutex);
+	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
+	if (!dev) {
+		mutex_unlock(&vdpa_dev_mutex);
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		return -ENODEV;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		mutex_unlock(&vdpa_dev_mutex);
+		put_device(dev);
+		return -EINVAL;
+	}
+	err = vdpa_dev_config_set(vdev, skb, info);
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
@@ -919,6 +1003,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_CONFIG_SET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = vdpa_nl_cmd_dev_config_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index dcbbecb5dea8..b59e1a214161 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -104,6 +104,14 @@ struct vdpa_dev_config {
 	struct vdpa_net_dev_config net;
 };
 
+struct vdpa_dev_set_config {
+	struct vdpa_net_dev_config net;
+	struct {
+		u8 mac_valid: 1;
+		u8 mtu_valid: 1;
+	} net_mask;
+};
+
 /**
  * struct vdpa_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -204,6 +212,11 @@ struct vdpa_dev_config {
  *				cpu endianness.
  *				@vdev: vdpa device
  *				@config: pointer to config buffer used to read to
+ * @set_ce_config:		Set one or more device configuration in
+ *				cpu endianness.
+ *				@vdev: vdpa device
+ *				@config: configuration to update
+ *				Returns 0 on success or error code
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
@@ -277,6 +290,8 @@ struct vdpa_config_ops {
 			   const void *buf, unsigned int len);
 	void (*get_ce_config)(struct vdpa_device *vdev,
 			      struct vdpa_dev_config *config);
+	int (*set_ce_config)(struct vdpa_device *vdev,
+			     const struct vdpa_dev_set_config *config);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 5c31ecc3b956..ec349789b8d1 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -18,6 +18,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_DEL,
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
+	VDPA_CMD_DEV_CONFIG_SET,
 };
 
 enum vdpa_attr {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
