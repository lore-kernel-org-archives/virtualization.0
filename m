Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BACC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E40861246
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40861246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C2F4065B;
	Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJhUN-Ua3tiD; Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCDF540641;
	Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4F0FC000E;
	Wed, 16 Jun 2021 19:12:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 945B2C0024
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 775E7608B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsYIUPVI9kvu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42FDA6087A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNAmm3FdafveIZvoHYmF3+oXHM0dxnQSefbG8fxGPu9Vu0AairqiPxxiQhtqDoKRKtPWwswqQXd81zbRno+tWMGX6kSsnOqm3L+pcZM3MdRSag30xEeb8am2vwygoDUn1EwGCEwLUM25/r2lsO6VyrkPjD1qm2hBjlahkxoTC5BsKYsdhra9aKJrHKIGQ1uH6Ga808ful0B5n7XrZn6Vr1x8M/8Xp/KeRc08YcgSi65S8HAXpEAQntPUH4G/ymOIkXeJIlv9vJ697Y/piUeRFH2UL/AwlfuiUJNxminV9rJQrqgGNmgBzy1VZ6ZbzXE3yQxhFYFnfGlXkLuFGqM/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UEFL6G3e+4XMehtktLf/5+AQUYXR0qu7pT6PRP/Hlw=;
 b=kmp4LocwzUu1LzHKXcU/EVdEh4CV/VKLbcov5xtgIf4ES4U+eIM7mreeFP2RHN6nvXCQeY1FCMyaBKIHZRYGyCuQIe1qFVXGfiF3IC7MOka0GygDVBv8jULfdlJc8AsiGZKMrGo6jF18iEsVBztoHNbh65/+FFNrzjs3Kf2LFxpD96uXZsmELCmIq64kd++CGJT/tJO5sUJ8yVBeIl9Hc7vbLUPCCgFUk26kPZDEv5QdQ4ke8SYDw3CNzV/NXaPJxVZ2uSBXBFJi/XTrrx/SLTLFLl5/gLoOvZ7P36Ce18+ZpS7jLrwsa+v58husVGvPb/C63xhcY5atspzuP64avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UEFL6G3e+4XMehtktLf/5+AQUYXR0qu7pT6PRP/Hlw=;
 b=ch6UQxXTzM587vy/HpOdXCcQZBUhjqL210C29ZlMvB2rYwx8w9kORoCSBoG9vVXU+DKIFtJj1Tz/X7h6IXR3Upo+9dedoJ7gEr4VGhorvFpJTsx0VJRVSjHdYfOML9WSbIyY2/OZMWP0tgiCbGBXVOPlnZIa7fvz+2Pjj3AVX9Vlsz0xlz80UhyjPmw3lgmp2p3knV1+8MTGbPaOHdMfUlptzFpTt8ATlrjgxEVRCNARtOURM1DCjN9PI3mcFr6/+oH7sUNRbyDrOmqvFPq3A1fMV4IerELDmbxckYkhhpaOUf1hNm0ysD6hB9tOZPXfWAcVdcMZ85cC2Nul6stmuw==
Received: from MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 19:12:14 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::40) by MWHPR22CA0060.outlook.office365.com
 (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Date: Wed, 16 Jun 2021 22:11:51 +0300
Message-ID: <20210616191155.102303-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56649dc-9f51-4b1f-335f-08d930faa6c7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52309A3462520E81F33D2B03DC0F9@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bx/uPzYsMwKpjv+M6G3LWXS34T6ZSbSfA1bk57OBvZ902qxd9GcwejLBSBnAGaAXHhu2RCE525K6Qazr8Z0DyPhGwCPbdWCJUAW6MCpWo0llfFzUZq+E+SEtYhylh1v9FxU+FuAe4c3tZDk2ZjQZFvXJLGxv5Dza4/q9ELgoLjuZMHj35VA995RmHi3c824SXHCXwNdEsrhE7DQei7gQjQCGUUUNQXOOEWTB/vSqL5+SEzDgzM6czLpyFxDO8THCOcGxSerau2ILMxLk9BG/7TdLTu/6Ag7m9KkKyvlnEWH4tGRTXIC6N76ITO42OEeW7ImHyUTfpqIBL3+6odrVT8kaflZrmg6UyrBYhV+5CypKJ4HGp5gV7pZyZlt8EIjUaZ9uPzXg73rvqTmytj6Z9FwhaVaBUcntiXaVZPZMmNHenQrDPmddqqO+zV6qCui3tHv115AS/XDaFFdMymNsNNqrSHhpGSig91AYkSmwGnW83ULpbt2FYakZ+7LDucIIWzVOR7A7w++oGGtwvImln1Lp29zdDOn6Yne8NJv34q14MBIE+xMnYWEn2tS2S2rN88ewhYsfZ6xTIy0ZQQ9w0JMY3FVj1y1iezn81zXvFijuXOoln052mWIRLI48PLMHx1BW67Obcc9h+SZ/+E3tHdjzgmrWzjHOlyIczvPM/Vo=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(426003)(36906005)(7636003)(82740400003)(478600001)(26005)(6916009)(1076003)(6666004)(336012)(36860700001)(316002)(5660300002)(86362001)(2906002)(107886003)(16526019)(82310400003)(47076005)(36756003)(70586007)(8676002)(54906003)(356005)(70206006)(186003)(83380400001)(2616005)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:14.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d56649dc-9f51-4b1f-335f-08d930faa6c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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

Introduce a command to query a device config layout.

An example query of network vdpa device:

$ vdpa dev add name bar mgmtdev vdpasim_net

$ vdpa dev config show
bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500 speed 0 duplex 0

$ vdpa dev config show -jp
{
    "config": {
        "bar": {
            "mac": "00:35:09:19:48:05",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500,
            "speed": 0,
            "duplex": 0
        }
    }
}

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c       | 212 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   2 +
 include/uapi/linux/vdpa.h |  11 ++
 3 files changed, 225 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bc44cdc34114..1295528244c3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -14,6 +14,8 @@
 #include <uapi/linux/vdpa.h>
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ids.h>
 
 static LIST_HEAD(mdev_head);
 /* A global mutex that protects vdpa management device and device level operations. */
@@ -60,6 +62,7 @@ static void vdpa_release_dev(struct device *d)
 		ops->free(vdev);
 
 	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	mutex_destroy(&vdev->cf_mutex);
 	kfree(vdev);
 }
 
@@ -114,6 +117,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	if (err)
 		goto err_name;
 
+	mutex_init(&vdev->cf_mutex);
 	device_initialize(&vdev->dev);
 
 	return vdev;
@@ -296,6 +300,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 
+	mutex_lock(&vdev->cf_mutex);
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
 	 * If it does happen we assume a legacy guest.
@@ -303,6 +308,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 	if (!vdev->features_valid)
 		vdpa_set_features(vdev, 0);
 	ops->get_config(vdev, offset, buf, len);
+	mutex_unlock(&vdev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
@@ -316,7 +322,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
 void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
 		     void *buf, unsigned int length)
 {
+	mutex_lock(&vdev->cf_mutex);
 	vdev->config->set_config(vdev, offset, buf, length);
+	mutex_unlock(&vdev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_set_config);
 
@@ -643,6 +651,204 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
 	return msg->len;
 }
 
+static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
+				       struct sk_buff *msg, u64 features,
+				       const struct virtio_net_config *config)
+{
+	u16 val_u16;
+
+	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
+		return 0;
+
+	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
+	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
+}
+
+static int vdpa_dev_net_rss_config_fill(struct vdpa_device *vdev,
+					struct sk_buff *msg, u64 features,
+					const struct virtio_net_config *config)
+{
+	u16 val_u16;
+	u16 val_u32;
+
+	if ((features & (1ULL << VIRTIO_NET_F_RSS)) == 0)
+		return 0;
+
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,
+		       config->rss_max_key_size))
+		return -EMSGSIZE;
+
+	val_u16 = le16_to_cpu(config->rss_max_key_size);
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN, val_u16))
+		return -EMSGSIZE;
+
+	val_u32 = le32_to_cpu(config->supported_hash_types);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES, val_u32))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
+{
+	struct virtio_net_config config = {};
+	u64 features;
+	u32 val_u32;
+	u16 val_u16;
+	int err;
+
+	vdpa_get_config(vdev, 0, &config, sizeof(config));
+
+	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
+		    config.mac))
+		return -EMSGSIZE;
+
+	val_u16 = le16_to_cpu(config.status);
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
+		return -EMSGSIZE;
+
+	val_u16 = le16_to_cpu(config.mtu);
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
+		return -EMSGSIZE;
+
+	val_u32 = le32_to_cpu(config.speed);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, val_u32))
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, config.duplex))
+		return -EMSGSIZE;
+
+	features = vdev->config->get_features(vdev);
+
+	err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
+	if (err)
+		return err;
+	return vdpa_dev_net_rss_config_fill(vdev, msg, features, &config);
+}
+
+static int
+vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
+		     int flags, struct netlink_ext_ack *extack)
+{
+	u32 device_id;
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
+			  VDPA_CMD_DEV_CONFIG_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
+		err = -EMSGSIZE;
+		goto msg_err;
+	}
+
+	device_id = vdev->config->get_device_id(vdev);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
+		err = -EMSGSIZE;
+		goto msg_err;
+	}
+
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		err = vdpa_dev_net_config_fill(vdev, msg);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+	if (err)
+		goto msg_err;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+msg_err:
+	genlmsg_cancel(msg, hdr);
+	return err;
+}
+
+static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct vdpa_device *vdev;
+	struct sk_buff *msg;
+	const char *devname;
+	struct device *dev;
+	int err;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	mutex_lock(&vdpa_dev_mutex);
+	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		err = -ENODEV;
+		goto dev_err;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	err = vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_seq,
+				   0, info->extack);
+	if (!err)
+		err = genlmsg_reply(msg, info);
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	mutex_unlock(&vdpa_dev_mutex);
+	if (err)
+		nlmsg_free(msg);
+	return err;
+}
+
+static int vdpa_dev_config_dump(struct device *dev, void *data)
+{
+	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
+	struct vdpa_dev_dump_info *info = data;
+	int err;
+
+	if (!vdev->mdev)
+		return 0;
+	if (info->idx < info->start_idx) {
+		info->idx++;
+		return 0;
+	}
+	err = vdpa_dev_config_fill(vdev, info->msg, NETLINK_CB(info->cb->skb).portid,
+				   info->cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				   info->cb->extack);
+	if (err)
+		return err;
+
+	info->idx++;
+	return 0;
+}
+
+static int
+vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct vdpa_dev_dump_info info;
+
+	info.msg = msg;
+	info.cb = cb;
+	info.start_idx = cb->args[0];
+	info.idx = 0;
+
+	mutex_lock(&vdpa_dev_mutex);
+	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
+	mutex_unlock(&vdpa_dev_mutex);
+	cb->args[0] = info.idx;
+	return msg->len;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
@@ -674,6 +880,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_CONFIG_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = vdpa_nl_cmd_dev_config_get_doit,
+		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 993d99519452..bf104f9f461a 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -42,6 +42,7 @@ struct vdpa_mgmt_dev;
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
  * @config: the configuration ops for this device.
+ * @cf_mutex: Protects get and set access to features and configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
  * @nvqs: maximum number of supported virtqueues
@@ -52,6 +53,7 @@ struct vdpa_device {
 	struct device dev;
 	struct device *dma_dev;
 	const struct vdpa_config_ops *config;
+	struct mutex cf_mutex; /* Protects get/set config and features */
 	unsigned int index;
 	bool features_valid;
 	int nvqs;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 66a41e4ec163..5c31ecc3b956 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -17,6 +17,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_NEW,
 	VDPA_CMD_DEV_DEL,
 	VDPA_CMD_DEV_GET,		/* can dump */
+	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 };
 
 enum vdpa_attr {
@@ -33,6 +34,16 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
 	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
 
+	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
+	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
+	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,	/* u8 */
+	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,	/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,	/* u32 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
