Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7984FC433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954B60EBC
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3954B60EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB090608D9;
	Tue, 26 Oct 2021 04:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wOHSxwcQDefB; Tue, 26 Oct 2021 04:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01708608BB;
	Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88808C0023;
	Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6E7CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4A8780F75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fnvATkA3egzH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7522980F74
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzqwaobD2a84GJEgZY1tbbA1UUzq4Y1cWmPb3c86j3z27CyydnQo9C80ezbExiO6DRElhCc5JXzsxoz+gqm7fZO8q2Mcrgq5wKLuU9LPoCmO8/BC8G1h7XrN4AHfSIUhDVU/SAWBk830GqBgsTkFZ+i9ECwGjkiQgyA56Ao8n5pZqEzFbhO/X0nh5n2igCkNWts5EAh/eDyMgKR0HdZiGQqybGo4KRWgZ2dO3idiGcKgrPrslwKPMtz4wT/2bfYnvKorRQiO01S2FNNCjKjpULTGz6DHaWPSvp8j7tTsJJbVt32iCwY5b55EMosRkfgoxFVOLc3DBirGYV04VRuM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTgiR2CQkjbFJjChFV5du06YVinJIAqvAINC6ivNMFo=;
 b=QVrq/e5STvEFac66rBDliUTNj4zqyfL9R+zCxFXQwc5UfQfK6op4IsSKEfNn1pjdtWtDG7AF8ebkqFRFGYrmWB59W8eMQojs+KtoJECjfEi8FgAJoPLcdOTZvKJoaOXsCoTIBYPxtS7xz0wskLhmw630l+++RXaC2iYqhpRtVIO0y/P6pgC31sDzhbI4Gpt3luDbIaIb9A/11ryKz0iX1Em1MBYUTwnv3A1m6NNcJsGvxMJqng1+yjWomEkW3P7Rl0qcrxHiyrxa/TUXuXISQdVwqI60e7Hg0Nhhu3/yiWEGJY3ALqqIONNS98qH6FnwXS464xLf5iJqBZSVduHJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTgiR2CQkjbFJjChFV5du06YVinJIAqvAINC6ivNMFo=;
 b=irL3bWNHRtEvnara/z82Ki1XjpA6mN5c3lt1J0lMHC6UvtOYI8n7owcaqZT/HlHHe52wbnCcFY5HHthMhrt2hJbGbrIvoLgA+HmJB4eK9CL06ubv/My+ogwHMzCUSy+fYVCQ59GD5sqMQY9dWdhYOk5HUAg++IpoVPQyWO5cDTwO3WB+5pxmuz3vnzvpnYnUpcl3UZ0CjaX+ctf7mIXB9dX/eT4HZmdNfwk+21ZHSJcxBl1ejAw4QvWMaqdNmWwYlJ4gJR/FWOgEggSO0nYi03MWv0kjn0w+xygGCNSVAKi2+bIjxyGMnd8vXsInqTXXAWbmXRKCICaPXVbLfr3xsA==
Received: from MWHPR2201CA0054.namprd22.prod.outlook.com
 (2603:10b6:301:16::28) by CY4PR1201MB0008.namprd12.prod.outlook.com
 (2603:10b6:903:d5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:03:00 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::f9) by MWHPR2201CA0054.outlook.office365.com
 (2603:10b6:301:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:02:58 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:02:57 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 2/8] vdpa: Introduce query of device config
 layout
Date: Tue, 26 Oct 2021 07:02:37 +0300
Message-ID: <20211026040243.79005-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92603219-25d5-4625-1b32-08d998357fb0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0008:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00087B39B88B784C886BB454DC849@CY4PR1201MB0008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sp5sK0rrR/sDbJhh69qa3o4hfiOFogP7Ss9ud6rFaOUfLyYHX/4l7eHVVLMJVUeLa0iMjuBLm8UHO7DIufgoQ9HKaNa3+Kcck7h3ds91Tkh1GgknFDKd7QCvidkTeGLvIl7oR4y5KI02DCAi+xDyD7dqppQ4bJEwJb4ieVya+fx0eANHa4sTGYY5uaiVhG9ESjmMrFgkDXMUdm4d3B7E6EZN22ZKIROTBBt+LUbva/hwnkAU9IYb2BazjSVNAZB/jrsKfWQfzbDTnRLckt/i5V3M3bx1X4alZPLcDEvx1kOS73/2JPsqbni5xjYojPTGmQwsGdvZI7qdykFnGcav7sVKd6RLW8gvyaIHVH7AUv36CA39BC5R7EIQ25PsQr1mr1UTpW0730wX+dWlq8D+e1H0+bI8YtdJ9Oh6MAogX3t4G+B+KS+eF7H9dCPjiweV99gsXh0wilFVDjH0TeHIq/vwG6FD6mFHFujGTHf2aSHkMPE5w7ggd4qPTA5uS3OHWAxRQ6+fbmYEe+G2F+dfV9UqIlSiSewDztoM2X63Q0jjEN04+N2QeqUWeKz+EPFtbAdOKmfeprlg7Y5mtKvcqplSiZ8ksIxHwy1eNz/W9F/6BwSJ+gAbb1yr47/lvkRh7uliN+6mrNN7f97lpDpLFmboiuTInOssxxEKqlzJPAOWPNK11dLb7I+L2vj9hqjhkBDk5VMAbgaF6N0yrrGsg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(2616005)(356005)(426003)(54906003)(82310400003)(16526019)(186003)(47076005)(7636003)(26005)(36860700001)(86362001)(316002)(4326008)(107886003)(2906002)(8936002)(6916009)(8676002)(36756003)(508600001)(6666004)(70586007)(336012)(5660300002)(1076003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:02:58.9663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92603219-25d5-4625-1b32-08d998357fb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
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
