Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A1C433E6
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091F164DF5
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091F164DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACA1343096;
	Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJphqcyCfGT5; Wed, 24 Feb 2021 06:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59D0543087;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F972C0013;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC62C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEEA143077
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EjM9i5A2f7FV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1205B414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:02 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6035efd60000>; Tue, 23 Feb 2021 22:19:02 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 24 Feb 2021 06:19:01 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next 3/9] vdpa: Enable user to set mac and mtu of vdpa
 device
Date: Wed, 24 Feb 2021 08:18:38 +0200
Message-ID: <20210224061844.137776-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614147542; bh=DuD3Bd7CzSL2aRSZX83dOLOcz+3lmdoc4NkjKsE+XjY=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=UjNOc8zE8j+RCfAdgeeQuPyPDjz9sRsIt7nUpbV3wAWnryIOEYy6fTNvzt4xCEW/K
 5M7mHs3pV7lL41A3791hTIkowqqUULZIAROvKvcU/0xkk/Nu8QGN/j8Eu4Gy/LgSnB
 ZMAyyxgMMrPJNkEF6A/HX7YZV4QMMIwVQw/l/CBjdD6yRAG3HDkKxlmceu/zsVK5zV
 v83/VJVNL7oOwC1bzofjcjGmA7H/nF47wRb0ygRUnjMvayD9EkeFr/pLGFCpYdUib4
 bSiEBm0sH8q6DBcUThJbL/SCCbJLZxRS9Ajhutj6qxeh/jxb5Dcmdwt2CHs/X50Off
 K2YqKzHsPMFaA==
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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
 drivers/vdpa/vdpa.c       | 89 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      | 16 +++++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index cebbba500638..ae4656dcea16 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -778,10 +778,93 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
 	return msg->len;
 }
 
+static void build_dev_net_config_attrs(struct genl_info *info,
+				       struct vdpa_dev_config_set_attr *attrs)
+{
+	struct nlattr **nl_attrs = info->attrs;
+	const u8 *macaddr;
+
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+		memcpy(attrs->cfg.mac, macaddr, sizeof(attrs->cfg.mac));
+		attrs->mask.mac_valid = true;
+	}
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
+		attrs->cfg.mtu =
+			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
+		attrs->mask.mtu_valid = true;
+	}
+}
+
+static int
+vdpa_dev_net_config_set(struct vdpa_device *vdev,
+			const struct vdpa_dev_config_set_attr *attrs)
+{
+	struct vdpa_mgmt_dev *mdev = vdev->mdev;
+
+	if (!mdev->ops->dev_config_set)
+		return -EOPNOTSUPP;
+	return mdev->ops->dev_config_set(mdev, vdev, attrs);
+}
+
+static int vdpa_dev_config_set(struct vdpa_device *vdev, struct genl_info *info)
+{
+	struct vdpa_dev_config_set_attr attrs = {};
+	int err = -EOPNOTSUPP;
+	u32 device_id;
+
+	if (!vdev->mdev)
+		return -EOPNOTSUPP;
+
+	device_id = vdev->config->get_device_id(vdev);
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		build_dev_net_config_attrs(info, &attrs);
+		err = vdpa_dev_net_config_set(vdev, &attrs);
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
+	err = vdpa_dev_config_set(vdev, info);
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_RANGE(NLA_U16, 68, 65535),
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
@@ -815,6 +898,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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
index 4ab5494503a8..c43a9e86c0ee 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/virtio_net.h>
 
 /**
  * vDPA callback definition.
@@ -343,6 +344,14 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 	ops->get_config(vdev, offset, buf, len);
 }
 
+struct vdpa_dev_config_set_attr {
+	struct virtio_net_config cfg;
+	struct {
+		u8 mac_valid : 1;
+		u8 mtu_valid : 1;
+	} mask;
+};
+
 /**
  * vdpa_mgmtdev_ops - vdpa device ops
  * @dev_add:	Add a vdpa device using alloc and register
@@ -356,10 +365,17 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
  *		@dev: vdpa device to remove
  *		Driver need to remove the specified device by calling
  *		_vdpa_unregister_device().
+ * @dev_config_set: Setup one or more fields of the device configuration layout
+ *		    @mdev: management device of the vdpa device
+ *		    @dev: vdpa device whose config fields to setup/modify
+ *		    @attrs: attributes to updated
  */
 struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*dev_config_set)(struct vdpa_mgmt_dev *mdev,
+			      struct vdpa_device *dev,
+			      const struct vdpa_dev_config_set_attr *attrs);
 };
 
 struct vdpa_mgmt_dev {
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
