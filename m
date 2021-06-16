Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F14C49361
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D16613C1
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D16613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F1A8414BE;
	Wed, 16 Jun 2021 19:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KM5yrXJO_UEH; Wed, 16 Jun 2021 19:12:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B948341486;
	Wed, 16 Jun 2021 19:12:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D821DC002A;
	Wed, 16 Jun 2021 19:12:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ABB6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3F16401D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NHtUDR1104yF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7F2C4021B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB12lX8sOzhwSUfTj+Mtp39tuit+3GY988vzrOeA7oPoDzhVUBkOQCZjQwNnnbxYJ6ZWnFHJ7NB6tefnv47VTuv5sB/zp/2N/9uA73outxPpVQoFXMJBSEUOUw+sdmvhgky2j1zfBz9+57Y3FgwnASTWVFxThnOqUgukQC3f7SlBuHtkMnG2ghaJAXoqi97EsLuNPGWURe//nLHemqJCU8+lI/b6sVZMARe7t3w+Ipn8+HQ/LpeAqqRUEQp0Y12ibA6hJ5krVnHtTn3qHR0qUejdQ5MyeMABV3vYXhYIGEjnOYm3p39neUFMCHGK5lsaX/Agj8hatx8djWqdEqiqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHRm3h4QjaNOCy3lE2dGbX2jU6D9Jzg6V6g3yK7w+NU=;
 b=O3q5e1dKcNA1GE+RC+L1mNoa5uYSkYdfjzMl3ePY93iy9XeJZLsUkw8BogGPgXpyydVQxmgpvndvaUdF4MptVXAHIK9MJw9HuiFtNlwXveRWS1pyomzcnXDcd3rxuFveVGyy6X5SGOTuOm5MynlwqjCDxFp3gh65iX4R6S5/zeUUjGz26r6hk9NrezzdLzIZBpNOBnZ3dZ9FlKYkzR9SiXvt3eHLGHIcqOafHfkT8lChomp4vQO6YZTCClHh1/Wkdcw2XYKCOUQTr4B4nxu40um9g9ElSQsmzkWUAjaPPJkz+la+g9JP7hPFA2vxcfRKK7cFl5P3gZ8arcxAu5u4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHRm3h4QjaNOCy3lE2dGbX2jU6D9Jzg6V6g3yK7w+NU=;
 b=GayjaMUGfqFBsSHAjY/VKSjeL5kXjXIS+/Zpiyp7MH2YKqgoGxgbZHnzc9K/RH+cCrYhvtNywGbAIckDiluaKCYLKKhWiULXEIvWdDqOXRFGEsTiW6X4S/kKO5ud8dgK7eVIxtGGG/5rchueA3o0hunfI+P+xfbAsM8q2yqBRkS9b4JojtSmjR1vMOMNYIYibkC4bnYtzJzj4I9+OgCIxUSgc2s8b7doN+HWVA9uU6sqHvrUHAQFGyERuY3vcptZtigRTVSzX2W/kW0TF9dQoVin9OoLPpNbWL3H34UqvUIq5snjo39+UwUzy2UAogCFz9swBHy8lfa0f08nkR9Mmw==
Received: from MWHPR22CA0059.namprd22.prod.outlook.com (2603:10b6:300:12a::21)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 19:12:18 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::1c) by MWHPR22CA0059.outlook.office365.com
 (2603:10b6:300:12a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:18 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 4/6] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Wed, 16 Jun 2021 22:11:53 +0300
Message-ID: <20210616191155.102303-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 815a6de7-2ed9-48b0-1a14-08d930faa901
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:
X-Microsoft-Antispam-PRVS: <CH2PR12MB551412CA0B85713595AB77EEDC0F9@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3PRQh/XEP7E0xBq79a7odGQNfLCwpwf/wp89dMfKgYf9vQIlDDNyO8cIP/QIYUN+pnZrn0eUFQAaFSR01ovNl2DtaS4GNXF7XzqgsY/nHaj8grE2zEys4hB0SKo78y+mRl0GRCUrfLx5sacYYBn609UoYVFnFSkX1wZXKVS5yMaMYSY5Qv+UV9jgD7EBIW6G1wHdaiW6OFwdDn2h5LEe4kC8e/wCnxa02rLOL4mKIXURYwVGEP+whPuqkGuQNXpgeAVwnNAxrcssf7JrJUkWo/cNm1Xj4wz2Q46AzLNEOl+iAczsVZzN7rp1nL5iK3rPVRYo0st9RvqxD4ttLoE960ajcSyuZ8E7M6djW70081B2k/a+I+ooE8U2JSl5fQ+LQvHMXjymyhR2EOQ9MBIxVzTpD/RUWhIrO6BOKO38Z1mHIuWJTmQkUzh8IXlgNgvzvxktYMtRmsy5EQ6KhZSRwFYdPI0AumPHTQuJ/XBYYXFnLeIlTmCYE2NhiQYLEi6UDGRcMsKS7yzYtf9GcP7CBBjLqi2LMj3v/QbdaV3HoU8r4RzKc941G0r5Rpv8QsEnjvxi7sUPpIfsq/u7kc8RNMX6QlxKKEwsUzfyz1Xgbofm4lKwaW9rlJa2KmjXlvejnRvjtR826qqc+HwfhgC/cDsFPigW9S1RxmOt963LfY=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(6916009)(82310400003)(2616005)(6666004)(16526019)(186003)(2906002)(8676002)(86362001)(336012)(5660300002)(1076003)(26005)(8936002)(7636003)(83380400001)(36860700001)(54906003)(356005)(316002)(36906005)(4326008)(36756003)(47076005)(426003)(82740400003)(70206006)(70586007)(107886003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:18.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a6de7-2ed9-48b0-1a14-08d930faa901
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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

Enable user to set the mac address and mtu so that each vdpa device
can have its own user specified mac address and mtu.
This is done by implementing the management device's configuration
layout fields setting callback routine.

Now that user is enabled to set the mac address, remove the module
parameter for same.

And example of setting mac addr and mtu:
$ vdpa mgmtdev show

$ vdpa dev add name bar mgmtdev vdpasim_net
$ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v1->v2:
 - using updated interface and callbacks for get/set config
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 13 +++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  2 ++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 34 +++++++++++++++-------------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 98f793bc9376..e57cd1ff47e3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -497,6 +497,17 @@ static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
 		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
 }
 
+static int vdpasim_setup_config(struct vdpa_device *vdpa,
+				const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (!vdpasim->dev_attr.setup_config)
+		return -EOPNOTSUPP;
+
+	return vdpasim->dev_attr.setup_config(vdpasim, config);
+}
+
 static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -608,6 +619,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
+	.setup_config		= vdpasim_setup_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.dma_map                = vdpasim_dma_map,
@@ -636,6 +648,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
+	.setup_config		= vdpasim_setup_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_map                = vdpasim_set_map,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index cd58e888bcf3..395894635010 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -45,6 +45,8 @@ struct vdpasim_dev_attr {
 	work_func_t work_fn;
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
+	int (*setup_config)(struct vdpasim *vdpasim,
+			    const struct vdpa_dev_set_config *config);
 };
 
 /* State of each vdpasim device */
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a1ab6163f7d1..5fcee88a89c5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -29,12 +29,6 @@
 
 #define VDPASIM_NET_VQ_NUM	2
 
-static char *macaddr;
-module_param(macaddr, charp, 0);
-MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
-
-static u8 macaddr_buf[ETH_ALEN];
-
 static void vdpasim_net_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
@@ -112,9 +106,19 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 {
 	struct virtio_net_config *net_config = config;
 
-	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
+static int vdpasim_net_setup_config(struct vdpasim *vdpasim,
+				    const struct vdpa_dev_set_config *config)
+{
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	if (config->net_mask.mac_valid)
+		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
+	if (config->net_mask.mtu_valid)
+		vio_config->mtu = cpu_to_vdpasim16(vdpasim, config->net.mtu);
+	return 0;
 }
 
 static void vdpasim_net_mgmtdev_release(struct device *dev)
@@ -128,6 +132,7 @@ static struct device vdpasim_net_mgmtdev = {
 
 static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 {
+	struct virtio_net_config *vio_config;
 	struct vdpasim_dev_attr dev_attr = {};
 	struct vdpasim *simdev;
 	int ret;
@@ -139,6 +144,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
 	dev_attr.config_size = sizeof(struct virtio_net_config);
 	dev_attr.get_config = vdpasim_net_get_config;
+	dev_attr.setup_config = vdpasim_net_setup_config;
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
@@ -146,6 +152,10 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	vio_config = simdev->config;
+	/* Setup default MTU to be 1500 */
+	vio_config->mtu = cpu_to_le16(1500);
+
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
 	if (ret)
 		goto reg_err;
@@ -185,14 +195,6 @@ static int __init vdpasim_net_init(void)
 {
 	int ret;
 
-	if (macaddr) {
-		mac_pton(macaddr, macaddr_buf);
-		if (!is_valid_ether_addr(macaddr_buf))
-			return -EADDRNOTAVAIL;
-	} else {
-		eth_random_addr(macaddr_buf);
-	}
-
 	ret = device_register(&vdpasim_net_mgmtdev);
 	if (ret)
 		return ret;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
