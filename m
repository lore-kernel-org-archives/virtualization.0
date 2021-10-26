Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32ACC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750E06109D
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 750E06109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BBF0404F4;
	Tue, 26 Oct 2021 17:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3Q4vtBigerx; Tue, 26 Oct 2021 17:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB2CA402AA;
	Tue, 26 Oct 2021 17:55:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A68AC0019;
	Tue, 26 Oct 2021 17:55:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEE96C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEAB560A44
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RHGPeC9YjcDd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B47A608C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLCyTDmf2ratXVOqBulin75JcWr+bwIG7wtCH1T9ba1Rt6uaglOZr9InsyN5rpBz/puVYbIYgqANtLFckLlPW0qwW1RU74KHFIT3hiJlvfmImxayiG9eIxeU+HnBlj1OSmK8ke7GH9DQ1nPX7r8Vt+YZBKDOAxYQpXJHxNE/V4QEmmDArYJpBwX0mUUl2r63c46sRAsIHv1zmy6m3jRqybw0OLbX+DPidjBw9Y0LdFjzq4dqiGD4AK5Z3c1V/4nmh9BY+3O8sqarw/5F4vGSdXwgYdNji5ON24EE8/P9r6ajulJ0u8qrYh7j/rW9AZIPfjpdm1w8YGxjqEW4ubrcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTgiR2CQkjbFJjChFV5du06YVinJIAqvAINC6ivNMFo=;
 b=YixM20NQPG/YXyMSpBAP4Yux/5DcaUNdtu7jsfGalbrxDXrpPYpGX/hrXmznSVoEE3L5tIaJ3y9Zt/TeqBORdGChb4V7edbbslXAlUtFIsiek2/meU5vy7urpbqqhNACyhIjQc0QBlXtonerOI5qt2XeZJddApTV9LRb9Bv9oXoDtuv5u3ty69O7BlGK8mFNt66XYMun+qnfPoA2xmkQqjGj46Zz03oio+eIFIqlO8BjUO8K1pDxZkXPzRAHRixfW7iC9qe0WlOkiaHShyr4uogU3gtknSnd7Awbsb8Mzs11ExxgTJYQdi3IwVcJO3qKKpwT9o10qXvVTpCU0IBxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTgiR2CQkjbFJjChFV5du06YVinJIAqvAINC6ivNMFo=;
 b=CNA0XeVGYdejaIzgcZTJm3+ayoMEoWwyy+DDQSpOnftmrZ3lbK+ja+kyp2ImnEho4PGV101zpN3fPh9epGgABkSZjd6Aj0IInqvXKMl0yVeW9d8KTraETMcjoZfT8C48uK8VRdDKb9Zb3Knr0uGofb8uZIvpkpJtljAoNTyPgnWfZrUieHPJWPRQsWASSbUpibFBrowrjdLUVCM/n7ijOyTZfWcjIFUv0wXO+2ODPR/PxWeInqxfXYcoht+7EesMlD5DSwf+FV7Jkh47/1bmttBEFSwqzNevptM4HQRb66tHPrX8fM5LnIcaoVsjqWIUZcrtmhxQZ7XIwVZ/AU1v8w==
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by DM6PR12MB3724.namprd12.prod.outlook.com (2603:10b6:5:1c9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 17:55:53 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c3) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 17:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:55:53 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:44 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 2/8] vdpa: Introduce query of device config
 layout
Date: Tue, 26 Oct 2021 20:55:13 +0300
Message-ID: <20211026175519.87795-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ad2444-00f4-40b6-6d83-08d998a9dabb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3724:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3724999594218F036414C727DC849@DM6PR12MB3724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD+4zoobyZgvRPXTrcR/RMKDBUYHjhRywFQkHmCZZZJ5bPno8QuMkzrZFjnV2aBDmf5zCTOwmO7kUcrlczjwcAvpvaNViVyzMVUT+z20q4gezImuePplDu0KbQyZkmcKLgZmhNxsexARzBcZS9carYGBexkNp2EnqhkWsZjHOyj8CUM2v3FXZR6NqLxL95BA3/FLr87LCp/c/b6hgYcgXPNtWDjbbOjeYo/N35zhGtFf469mA1U4JHpJe0XmWCaL2gkYoi0Xn+LSDOMpOObcrCfZAmIZWVXPMXqsNZqWCCt2Vhzsu1qGoiq6lfPojsnlgKje6GH5xgecWBS8RlZIsH5C+KOjs0tYwxiGJQlbOR812UFBClU+UOMkC1b/Yih9Qn/EECuBBwaCB8jDamxWz/umeAZMMeTYHHO0+RsIE1pl6kZKXw+hNGXvinSiJJG4vXUVlfWWDXhN0gw4R6DyoPgxjHkFSemmLj6L7wsX/NqLU/G6kvKKtm3DDnYguGoFq2Idu4asQknuVm2wEq6z/2UxHhJ9+unhOf6vDnCgUo5yk9PvQoe6ntYgU+Q0BL5lX/DWhHrcL6D5bxyHpYOIURP4bSJnchWS4QoOTrGi1PvBz5fWC3TQm7s1V2/NW7+VWmoobSvO4y/udqtLOVBBCCdNBVCZoG8XtS9fzVgI+tvtFudo2k/TYcj5HwIeUYQql4dRqtKOfS1NRvNjWdwHjA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(508600001)(36906005)(6666004)(7636003)(86362001)(36860700001)(356005)(54906003)(36756003)(70586007)(1076003)(186003)(8936002)(8676002)(70206006)(82310400003)(47076005)(2906002)(107886003)(16526019)(6916009)(26005)(2616005)(83380400001)(426003)(4326008)(5660300002)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:55:53.0330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ad2444-00f4-40b6-6d83-08d998a9dabb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
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

Introduce a command to query a device config layout.

An example query of network vdpa device:

$ vdpa dev add name bar mgmtdev vdpasim_net

$ vdpa dev config show
bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500

$ vdpa dev config show -jp
{
    "config": {
        "bar": {
            "mac": "00:35:09:19:48:05",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500,
        }
    }
}

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
changelog:
v3->v4:
 - removed config space fields reporting which are not used by mlx5
   and sim drivers
---
 drivers/vdpa/vdpa.c       | 176 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   2 +
 include/uapi/linux/vdpa.h |   6 ++
 3 files changed, 184 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d42697699366..973c56fb60b9 100644
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
@@ -66,6 +68,7 @@ static void vdpa_release_dev(struct device *d)
 		ops->free(vdev);
 
 	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	mutex_destroy(&vdev->cf_mutex);
 	kfree(vdev);
 }
 
@@ -127,6 +130,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	if (err)
 		goto err_name;
 
+	mutex_init(&vdev->cf_mutex);
 	device_initialize(&vdev->dev);
 
 	return vdev;
@@ -309,6 +313,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 
+	mutex_lock(&vdev->cf_mutex);
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
 	 * If it does happen we assume a legacy guest.
@@ -316,6 +321,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 	if (!vdev->features_valid)
 		vdpa_set_features(vdev, 0);
 	ops->get_config(vdev, offset, buf, len);
+	mutex_unlock(&vdev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
@@ -329,7 +335,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
 void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
 		     const void *buf, unsigned int length)
 {
+	mutex_lock(&vdev->cf_mutex);
 	vdev->config->set_config(vdev, offset, buf, length);
+	mutex_unlock(&vdev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_set_config);
 
@@ -661,6 +669,168 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
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
+static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
+{
+	struct virtio_net_config config = {};
+	u64 features;
+	u16 val_u16;
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
+	features = vdev->config->get_features(vdev);
+
+	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
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
@@ -692,6 +862,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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
index 267236aab34c..5cc5e501397f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -63,6 +63,7 @@ struct vdpa_mgmt_dev;
  * @dev: underlying device
  * @dma_dev: the actual device that is performing DMA
  * @config: the configuration ops for this device.
+ * @cf_mutex: Protects get and set access to configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
  * @use_va: indicate whether virtual address must be used by this device
@@ -74,6 +75,7 @@ struct vdpa_device {
 	struct device dev;
 	struct device *dma_dev;
 	const struct vdpa_config_ops *config;
+	struct mutex cf_mutex; /* Protects get/set config */
 	unsigned int index;
 	bool features_valid;
 	bool use_va;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index e3b87879514c..a252f06f9dfd 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -17,6 +17,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_NEW,
 	VDPA_CMD_DEV_DEL,
 	VDPA_CMD_DEV_GET,		/* can dump */
+	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 };
 
 enum vdpa_attr {
@@ -34,6 +35,11 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
 	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
 
+	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
+	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
+	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
