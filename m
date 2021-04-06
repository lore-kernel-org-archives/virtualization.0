Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241EAC433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE1961041
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE1961041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 838714055E;
	Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j_aFzZD2Ow6x; Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAC0340564;
	Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6ABEC000C;
	Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57863C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F84A40562
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7DtG1sin3no
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::600])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 238C640559
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npaIQ8F3oOqHrE0rFsbmaLdTQpPWcHpEakXA+mlGEJfeNTZ5+B7VH4oOvBuFYBaVOvDUAequPloUNsN/F5vO+ZGI+EWXLHjM1Vmxn3EqdRwIV+GJv/S9DFxDtOUpf9K2IBpKN52nsU2y5Vt8WBPvjcXa2Zx4KwZsjDqxIZQU1VUz9u14RYzFFoyOFie20gohOMVTVVoXgoq8vKRXBvwxIObPX3plRsF1P9K1dKdbd90bRgjMulWb8Cn2m1R3/EKMmOb5cNz7k7qxIfYfGs+5INOt5LyvH+7tPS6c9QKw4Q1NJpuUT3HEtVTxGmLvZ3f7nOyJwD/PmTlUDSsT+sjBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmO6kEBNjrDGgHsYNdxz6RDLs/zDsXRb2HSs8LqmYXk=;
 b=KPxOpjGrTE4FaDN0J7YBv9evj+2xUancUaq4TUAbds3htzjSm/aOj3GSL8EABUvPsxiAu72g6B292mD4MOYBQNp2gR2d7fWeBrJpqub6M3p3kEzeisTL9134w9f7dV7PHj/jTHkRR9hj84Fqm0AkZcS7YniTkEk7xnl5hwnaUVg4G8etiWuMIwvT/k7geRaQH/yPI7vlNDRsKJ4VM0Tsz0mrnAxLlhZGV+BadgV4qfB4LfSS/9mhpRIapf74BMIEB+YagfotC+28CfL+rV8Z20rGxVNM5SST5bIkPsTFq5FYzavGGu36hz2kGaMvgMnv4MCplU84WT2qfRALFkUQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmO6kEBNjrDGgHsYNdxz6RDLs/zDsXRb2HSs8LqmYXk=;
 b=YEEJ1lZ2B2TBtkjE8t28wsQLWhwa0X219LmJejgByayWVxZWx9dc7VvXGuHQOpY25J8/pKN1HL6+1fvmP/xjN7mi3ftjfaMTsBcRkbq+Ch3MTmuuG5HFKBpzh5c/fvOJ6am8yBwlcIvDHu9YRLzfQ+6K9Ekpg1/sSq9Ojdi7ip9ijYcjzsDKcSVYL5gBqHVUw7a3Mf7dWPcbbeT1I2S/QrcIba/DQGwju5fvU0JGfcGeaazf+a8x3lf9kkntFbpjyXeAUYRSb21HMCMOjiNxXeHWn414pbykb+9vlbU6V32c4WltqUhvA6yT8NOV3+n789IB8ddoADg6OvEp3WGJGg==
Received: from MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21)
 by BN8PR12MB3569.namprd12.prod.outlook.com (2603:10b6:408:49::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 17:05:17 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::89) by MWHPR19CA0059.outlook.office365.com
 (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:17 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 04/14] vdpa: Introduce query of device config
 layout
Date: Tue, 6 Apr 2021 20:04:47 +0300
Message-ID: <20210406170457.98481-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bad768c-2265-4a79-51bd-08d8f91e26fc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3569:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3569849C98D35193A2FD7A0EDC769@BN8PR12MB3569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuKe59QaeAh88HMyrizMZc8olxUUaG/DTtwxCPlLB44pFLJLfv0osn/opshUi4VojX/t5ZIp9Tb8CU+u+2mRIiVAzsoj2o/YO2tFn3qgrsRG9E8Kjg2VWZxFdc6Nbt52fstsa8OGlU6QtRaxLi577e6+hJuKKa7ismZVnCjEQ4LnlY+YlxZAIczKNLHlpmQRGjabigJcerUP1AUqaxE9VsNRauxTii2IJLbI8UXYFHUApGaJ2vus1PWkipTxVhugBoR5DJQLc/v7yhI0WUDB7oPh1sp/Y93Y5/HVtW+3r79ueyFuCjn/XKfkKe9mhc9tH912FpWHW7+T7YjuCHCJ8Attv8dBTgj+SsglPJRCQAhiPgkl5gaF4/Gbs+sr7TcofghU7Eh+1rroc6pEUdvzLvTKkPfX3FwqNVsa71kPdNNbj2zQU9KzSbiR6shQubsGm8BYCC7lKYB+rPLZKyzSPkcH3ez7VKWm8GOCiE1nBhNaqjaPxBduyooBMtsVCWpbLBHV6OMF137zeVFhsaEorfFu36SF8jA+BwQmQnon3KPsfgLQX5+BZwmHI+zIHgwpL9H6MSrPaz270PQzS++lNFjeAgZPm5yLSdtB2wQz6P72hteDU1ns18LZPq7TyZ0BXabYo2iELn7UXfeX8QPWvueM8DoDkFwgF+ssefV3YWE=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(82740400003)(7636003)(356005)(5660300002)(70586007)(70206006)(1076003)(6666004)(83380400001)(82310400003)(426003)(2616005)(8936002)(8676002)(36756003)(2906002)(36860700001)(6916009)(86362001)(26005)(107886003)(30864003)(478600001)(4326008)(36906005)(47076005)(54906003)(316002)(16526019)(186003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:17.0301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad768c-2265-4a79-51bd-08d8f91e26fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3569
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
changelog:
v1->v2:
 - read whole net config layout instead of individual fields
 - added error extack for unmanaged vdpa device
 - fixed several endianness issues
 - introduced vdpa device ops for get config which is synchronized
   with other get/set features ops and config ops
---
 drivers/vdpa/vdpa.c       | 234 +++++++++++++++++++++++++++++++++++++-
 include/linux/vdpa.h      |  42 +++++++
 include/uapi/linux/vdpa.h |  11 ++
 3 files changed, 282 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 116e076c72fd..9da8deb8c0f2 100644
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
@@ -269,10 +273,25 @@ EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
  */
 u64 vdpa_get_features(struct vdpa_device *vdev)
 {
-	return vdev->config->get_features(vdev);
+	u64 features;
+
+	mutex_lock(&vdev->cf_mutex);
+	features = vdev->config->get_features(vdev);
+	mutex_unlock(&vdev->cf_mutex);
+	return features;
 }
 EXPORT_SYMBOL_GPL(vdpa_get_features);
 
+static int __vdpa_set_features(struct vdpa_device *vdev, u64 features)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+	int err;
+
+	vdev->features_valid = true;
+	err = ops->set_features(vdev, features);
+	return err;
+}
+
 /**
  * vdpa_set_features - Set vDPA device features
  * @vdev: vdpa device whose features to set
@@ -282,10 +301,12 @@ EXPORT_SYMBOL_GPL(vdpa_get_features);
  */
 int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
-	const struct vdpa_config_ops *ops = vdev->config;
+	int err;
 
-	vdev->features_valid = true;
-	return ops->set_features(vdev, features);
+	mutex_lock(&vdev->cf_mutex);
+	err = __vdpa_set_features(vdev, features);
+	mutex_unlock(&vdev->cf_mutex);
+	return err;
 }
 EXPORT_SYMBOL_GPL(vdpa_set_features);
 
@@ -294,13 +315,15 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 
+	mutex_lock(&vdev->cf_mutex);
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
 	 * If it does happen we assume a legacy guest.
 	 */
 	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0);
+		__vdpa_set_features(vdev, 0);
 	ops->get_config(vdev, offset, buf, len);
+	mutex_unlock(&vdev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
@@ -314,7 +337,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
 void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
 		     void *buf, unsigned int length)
 {
+	mutex_lock(&dev->cf_mutex);
 	dev->config->set_config(dev, offset, buf, length);
+	mutex_unlock(&dev->cf_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_set_config);
 
@@ -664,6 +689,198 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
 	return msg->len;
 }
 
+static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
+				       struct sk_buff *msg, u64 features,
+				       const struct vdpa_dev_config *config)
+{
+	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
+		return 0;
+
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
+			config->net.max_virtqueue_pairs))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int vdpa_dev_net_rss_config_fill(struct vdpa_device *vdev,
+					struct sk_buff *msg, u64 features,
+					const struct vdpa_dev_config *config)
+{
+	if ((features & (1ULL << VIRTIO_NET_F_RSS)) == 0)
+		return 0;
+
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,
+		       config->net.rss_max_key_size))
+		return -EMSGSIZE;
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,
+			config->net.rss_max_key_size))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,
+			config->net.supported_hash_types))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
+{
+	struct vdpa_dev_config config = {};
+	u64 features;
+	int err;
+
+	mutex_lock(&vdev->cf_mutex);
+	vdev->config->get_ce_config(vdev, &config);
+	mutex_unlock(&vdev->cf_mutex);
+
+	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.net.mac),
+		    config.net.mac))
+		return -EMSGSIZE;
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, config.net.status))
+		return -EMSGSIZE;
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, config.net.mtu))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, config.net.speed))
+		return -EMSGSIZE;
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, config.net.duplex))
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
+	if (!vdev->config->get_ce_config) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Configuration layout query is unsupported");
+		return -EOPNOTSUPP;
+	}
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
@@ -695,6 +912,13 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_CONFIG_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = vdpa_nl_cmd_dev_config_get_doit,
+		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 62e68ccc4c96..dcbbecb5dea8 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <linux/if_ether.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -47,6 +48,7 @@ struct vdpa_mgmt_dev;
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
+ * @cf_mutex: Protects get and set access to features and configuration layout.
  */
 struct vdpa_device {
 	struct device dev;
@@ -56,6 +58,7 @@ struct vdpa_device {
 	bool features_valid;
 	int nvqs;
 	struct vdpa_mgmt_dev *mdev;
+	struct mutex cf_mutex; /* Protects get/set config and features */
 };
 
 /**
@@ -68,6 +71,39 @@ struct vdpa_iova_range {
 	u64 last;
 };
 
+/**
+ * struct vdpa_net_dev_config - vDPA net device config to get/set via
+ *                              management device.
+ * @mac: mac address of the vdpa device
+ * @status: indicates VIRTIO_NET_F_STATUS and VIRTIO_NET_S_*
+ * @max_virtqueue_pairs: Maximum number of each of transmit and receive queues.
+ *			 see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
+ *			 Legal values are between 1 and 0x8000.
+ * @speed: In units of 1Mb. All values 0 to INT_MAX are legal.
+ * @mtu: Default maximum transmit unit advice.
+ * @duplex: 0x00 - half duplex
+ *	    0x01 - full duplex
+ * @rss_max_key_size: Maximum size of RSS key.
+ * @supported_hash_types: Bitmask of supported VIRTIO_NET_RSS_HASH_ types
+ * @rss_max_indirection_table_length: Maximum number of indirection table
+ *				      entries.
+ */
+struct vdpa_net_dev_config {
+	u8 mac[ETH_ALEN];
+	u16 status;
+	u16 max_virtqueue_pairs;
+	u32 speed;
+	u16 mtu;
+	u8 duplex;
+	u8 rss_max_key_size;
+	u32 supported_hash_types;
+	u16 rss_max_indirection_table_length;
+};
+
+struct vdpa_dev_config {
+	struct vdpa_net_dev_config net;
+};
+
 /**
  * struct vdpa_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -164,6 +200,10 @@ struct vdpa_iova_range {
  *				@buf: buffer used to write from
  *				@len: the length to write to
  *				configuration space
+ * @get_ce_config:		Read device specific configuration in
+ *				cpu endianness.
+ *				@vdev: vdpa device
+ *				@config: pointer to config buffer used to read to
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
@@ -235,6 +275,8 @@ struct vdpa_config_ops {
 			   void *buf, unsigned int len);
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
+	void (*get_ce_config)(struct vdpa_device *vdev,
+			      struct vdpa_dev_config *config);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
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
