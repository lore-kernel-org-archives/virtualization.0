Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DD13D537
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713273; cv=none; b=T7USVjpn9MwMwWa4xIDAu2D+8GW0IYeyVymim51Htby0RlOPnXCLD8JWg1UgvLEeEbastsXojcSc/bPlTEAZkJA72G3WU51ydhxEIWraoRRrC7By9lHqVoJn/dUCeBPd1fdAUm8BHYfKuZb89MUAYOrNjgM36vWMjkN7rBh0XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713273; c=relaxed/simple;
	bh=cAQ8+qM16l7GyTaYbjnbEjvXVwilTUhFDaBQgG7U800=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edv9Ji6Xch1yyAqRFm9DskgttdXw1tbwLqR9VrYZECOdy3zHmYKhKejQy7BwEKep4PsGfjHLNeVudXWV14Dns5lDreryCuXUndD3ZdQyZtQV04bgXLc6+kfmCf6AX2wTjTUn6KU+ti9zmAB4mlYEziA+/YFAPDqHUokx9uAdiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAWnj9GO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAWnj9GO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9A26400A6
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6IvayD50Kxl for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 05:41:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C7C6B40042
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7C6B40042
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MAWnj9GO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7C6B40042
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721713269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBVhMi8j8tkf4NJc2ePQoKDV+1xaoPFqwO84E+bM5sU=;
	b=MAWnj9GO53Zg6mzrZS9Gvg13qWDbTn3EwskKYSUBHIZ/cwAoa4kpIhI8sIydwI0TsP9Jdf
	s5aa6NrHLMHswG9EBCi6qW2hptRioZL/RwdmD7S8jn4EQI48I8f7kLHj72PyiruZQ4U5d6
	x6xzA0VPZ8AlBagkbPO/yyHdkYMk+rs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Qg7zyoATOPizt5_9l0Y6rQ-1; Tue,
 23 Jul 2024 01:41:03 -0400
X-MC-Unique: Qg7zyoATOPizt5_9l0Y6rQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 572441955D5D;
	Tue, 23 Jul 2024 05:41:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86FDB1955F40;
	Tue, 23 Jul 2024 05:40:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
Date: Tue, 23 Jul 2024 13:39:20 +0800
Message-ID: <20240723054047.1059994-2-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-1-lulu@redhat.com>
References: <20240723054047.1059994-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new UAPI to support the mac address from vdpa tool
Function vdpa_nl_cmd_dev_attr_set_doit() will get the
new MAC address from the vdpa tool and then set it to the device.

The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**

Here is example:
root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "82:4d:e9:5d:d7:e6",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55

root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  9 +++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 94 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8d391947eb8d..07d61ee62839 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	return err;
 }
 
+static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
+					struct genl_info *info)
+{
+	struct vdpa_dev_set_config set_config = {};
+	const u8 *macaddr;
+	struct vdpa_mgmt_dev *mdev = vdev->mdev;
+	struct nlattr **nl_attrs = info->attrs;
+	int err = -EINVAL;
+
+	if (!vdev->mdev)
+		return -EINVAL;
+
+	down_write(&vdev->cf_lock);
+	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
+	    nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+
+		if (is_valid_ether_addr(macaddr)) {
+			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
+			if (mdev->ops->dev_set_attr) {
+				err = mdev->ops->dev_set_attr(mdev, vdev,
+							      &set_config);
+			} else {
+				NL_SET_ERR_MSG_FMT_MOD(info->extack,
+						       "device not supported");
+			}
+		} else {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "Invalid MAC address");
+		}
+	}
+	up_write(&vdev->cf_lock);
+	return err;
+}
+static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	const char *name;
+	int err = 0;
+	struct device *dev;
+	struct vdpa_device *vdev;
+	u64 classes;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+
+	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+
+	down_write(&vdpa_dev_lock);
+	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		err = -ENODEV;
+		goto dev_err;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		NL_SET_ERR_MSG_MOD(
+			info->extack,
+			"Fail to find the specified management device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
+	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
+		err = vdpa_dev_net_device_attr_set(vdev, info);
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
+				       name);
+	}
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	up_write(&vdpa_dev_lock);
+	return err;
+}
+
 static int vdpa_dev_config_dump(struct device *dev, void *data)
 {
 	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
@@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_ATTR_SET,
+		.doit = vdpa_nl_cmd_dev_attr_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7977ca03ac7a..3511156c10db 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
  *	     @dev: vdpa device to remove
  *	     Driver need to remove the specified device by calling
  *	     _vdpa_unregister_device().
+  * @dev_set_attr: change a vdpa device's attr after it was create
+ *	     @mdev: parent device to use for device
+ *	     @dev: vdpa device structure
+ *	     @config:Attributes to be set for the device.
+ *	     The driver needs to check the mask of the structure and then set
+ *	     the related information to the vdpa device. The driver must return 0
+ *	     if set successfully.
  */
 struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
 		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+			    const struct vdpa_dev_set_config *config);
 };
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 842bf1201ac4..71edf2c70cc3 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_ATTR_SET,
 };
 
 enum vdpa_attr {
-- 
2.45.0

