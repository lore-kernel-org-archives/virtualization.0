Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C94C48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250B061245
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250B061245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F29EC83C8A;
	Wed, 16 Jun 2021 19:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cb5eaOdns199; Wed, 16 Jun 2021 19:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 726B583C79;
	Wed, 16 Jun 2021 19:12:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D0C9C000E;
	Wed, 16 Jun 2021 19:12:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8296BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F837404BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5f5ZZVCddZMM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F78340158
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr6vv7lLG0I7LDBWCvkstDBilKj2FVi8h00lBJAzuhK48Dmze8KWs2y/azE2b95TDKSDxcTpoIXb05tENZYzG5fxo74AQPjhS/7Q6/U0XtjaR7fSRF2fxc+BnMWJ5UuwvUowqsJW5Xxicq90b0tWbiG3PmMhMivePdkjqeTS0eCFdZBhZv0ZvakoRD+c54s6ebDRkrnQlCjB6t52T2N5kqZ0w2MkXjRLpxhHvtFNZraU+98T9k+ySkxgzpzMktbEJEXwAOf7NbLjXyS2ylQl4VvRD6/Z3zqgjbjE6j+gwQ4GLkhAq0STz+Ei/MjjyKaVbguWUePr3TcGNr1gVg+a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzYKFoqmEtg9PgeBSESKtfqacxgdfGcWBGz2dsZnGYo=;
 b=DkqkYbhWqUOBTrQln66bVRu0n0MFon3wJ7K212SnYu9rzt0NhwhtLWSNEmuNnOvUZ0YywEpzWT8qZsv9XZLguzvjJjUADrG0BGtgedhkKFCuSyTKUoWwfkZ8ROzMwP6z0fA5TB70hUu6WBvz2S6cyPvwrzw3Wreng93SPQza/Zujrzw6cT4C44SYMcs286y7XUD9KKf1elYRPkkICUcROtQ2M0WvlsLt9KDJOcrPDjol/VJdRtKeFvEDyeF5s1vWd56USE6wFqRo7QILGtrd+u9wgLyCC5p3pmrmgiY7POv5WUmcgHOuBCaUTqvs2DgPEWtyr8r/3NwfIkVI+L2Iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzYKFoqmEtg9PgeBSESKtfqacxgdfGcWBGz2dsZnGYo=;
 b=OgoPrucDQOI+qTPOVgam1tdMxvuO4z+id85Sf2AeKzMbDSPHTN7jQQdpYT6c+WvgNDrHS/72Da6EV3vXIHsOYj1qtSR7rYZf1jpyv6ZGWNXaqX3y6qP9+vBXUxHMpxu/1Upga1gXVWuV8O8AvSfUQjQ2MthAOh6maiAW1nwlUFh+ZKpQP7/XT0ilMQfbBYSDkqaWTO2xO0yUU/RHmOaKe11SmH7cDJaVP6KTjQHbVwkao5qt+9v1VxRlCYoHmQnU5ZkWotxY6VxKMbLRv4x/WgpG9Z7t9VIMtvjmPkTxjPac99JIxQK+ImFiv/LZusVx2Mi+Rg0oAggLQa16o83U9A==
Received: from MWHPR22CA0053.namprd22.prod.outlook.com (2603:10b6:300:12a::15)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 19:12:18 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::6a) by MWHPR22CA0053.outlook.office365.com
 (2603:10b6:300:12a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:17 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:14 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 3/6] vdpa: Enable user to set mac and mtu of
 vdpa device
Date: Wed, 16 Jun 2021 22:11:52 +0300
Message-ID: <20210616191155.102303-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96422abc-7656-452c-a2a8-08d930faa8a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4045864E6A56EC17553E8227DC0F9@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqlxT4aWMJxvVDFua+r9NB5K56xbv4ZT1RmmMUfamQJOFDhRVXvs5KyO6YTu33d+2cJohKTa6LGS6mj2UPdRoCZ+wfiMh92CiCCBFnRZrK+o+e96yVrWEnJszaVkMm+0NFjgsSjSQ5i8Y6BCvzDn+7E5I2W161QowEUIAcPDLVuSMxuJaKgl0Nt+mAVJ2RWzvfQoJ5sHeOWS6qDhe4dztwvwREhbVKaEmOvfnTqHrl5CgR0Cs+y9BrQmuOQj4F1Ge1PQZUBgyfw62YOtG036vsWNS3UlwZh00jwQ//hCR828DBPMSAstiE1sYU0boIBQ38LPm9jjE0BFS2Txib7piLl0Zh7nvvkJNiFAG8flijN87X986vFm7ZDt8bqxQ/fFyCIfLrTVlAFyflEbAF8kleH4RRIm8Rlwkm33fCVcB7sja1xAX3JjxDhiS31kNNSX0s5nPSQfZmVi7hadvuK6ZcSf8V57mDUP+gqMqOgj6lzTiKuW0ZWUdr6+C/juitqsMrgM4OYZ1RM1uno7IEu4jfCBeH05i/PKeu4uVBJDmgaXCtgNS37JyCKcvhdsuBJMwXWexIIbVu5MkoErRiXzAhnoOixgZ6VdktGdfvKuErz6clWipSTKRNEQvJBHlReZvfK3FRKMKoQpbtVRb9MBLA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(426003)(86362001)(186003)(70206006)(316002)(54906003)(36906005)(107886003)(356005)(6916009)(2616005)(2906002)(6666004)(26005)(8936002)(8676002)(36860700001)(83380400001)(82310400003)(5660300002)(47076005)(336012)(478600001)(82740400003)(1076003)(36756003)(7636003)(70586007)(4326008)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:17.7688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96422abc-7656-452c-a2a8-08d930faa8a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
v2->v3:
 - using new setup_config callback to setup device params via mgmt tool
   to avoid mixing with existing set_config().
---
 drivers/vdpa/vdpa.c       | 91 ++++++++++++++++++++++++++++++++++++++-
 include/linux/vdpa.h      | 18 ++++++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1295528244c3..40874bd92126 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -14,7 +14,6 @@
 #include <uapi/linux/vdpa.h>
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
-#include <linux/virtio_net.h>
 #include <linux/virtio_ids.h>
 
 static LIST_HEAD(mdev_head);
@@ -849,10 +848,94 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (!vdev->config->setup_config)
+		return -EOPNOTSUPP;
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
+	err = vdev->config->setup_config(vdev, &config);
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
@@ -886,6 +969,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_config_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
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
index bf104f9f461a..9b7238d5310e 100644
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
@@ -70,6 +72,17 @@ struct vdpa_iova_range {
 	u64 last;
 };
 
+struct vdpa_dev_set_config {
+	struct {
+		u8 mac[ETH_ALEN];
+		u16 mtu;
+	} net;
+	struct {
+		u8 mac_valid: 1;
+		u8 mtu_valid: 1;
+	} net_mask;
+};
+
 /**
  * struct vdpa_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -169,6 +182,9 @@ struct vdpa_iova_range {
  *				@buf: buffer used to write from
  *				@len: the length to write to
  *				configuration space
+ * @setup_config:		Setup configuration space
+ *				@vdev: vdpa device
+ *				#config: configuration to apply to device
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
@@ -241,6 +257,8 @@ struct vdpa_config_ops {
 			   void *buf, unsigned int len);
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
+	int (*setup_config)(struct vdpa_device *vdev,
+			    const struct vdpa_dev_set_config *config);
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
