Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE8C433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE70A61041
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70A61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9351F84A75;
	Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yk5RIRUBpUHc; Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F88A84A69;
	Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A87B6C0017;
	Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 888C0C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 438CA40FB5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rT3LTvyHKsVQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 309F440FA4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCFIZmf5qOHl0dUHSJi/dZYxc7SMGme7nEMKwMhl6KZTnVXGj/yeugQbVBgKKf8wTuBbUcz5eQPcNk9cU8GHou9/ZWNJa/rQ1QIjToFJMcJUGGJb9PcHrvL0MEy+4Bqju+a8SoSRUNnNnHBiNS6eHKbdHLceYiG2EXqIlXk3r4oUYLnIc7l3Q/8CkokNjYIR/PR89N9gG4LJM/wA3vo2x1ZU1rYYUsNH4xw0Yq+lM6j2AryOq/CyeIHw0XLbjQH/sMhMgNGiHhD4M2ucoZ8XyLMfCxRFjn3+ts1EAyvTOQn94YXO9hqnJ6Ht6mJQpLLE1odd8QlB0W3JcwO3+2CNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShwK3Q+khCjXzs1mNZ2E0dJJgXqT7P6zx6Hy8s8YY38=;
 b=hDH3rRo1fRWG2JYK4cBO9hawX7Z72GSLOxfHoyZARxV3i6kYuWSANwOHOLjih471jzgx9u3nqiPqdZveqXORpNXAK4P+2PIggj9U5OQB+Bp8Rp78T092SVI+xEhCgzBmg9Tiz298gZmLnK0yV4s3sV164zewANgXmMj6puJGoMIMYRxU2lvbdglNWtDql6Ak5iJtXSMtyYGtEPENKC7LN1iPCvcZuyQ8s31OTPJtpwUREpBQ4GpeKtFOXPgDVWV4PcvqtISP4HXURjconmoT0GBzD+f3USkjtePQFltzaUlCRK9mF/jGvWiA+H3H2FZ/ygPyLAy8si47ZdUY1IoE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShwK3Q+khCjXzs1mNZ2E0dJJgXqT7P6zx6Hy8s8YY38=;
 b=pk2inO7oJeoBjVJY15IAJjd0IM2nDjgMU2lw5f5ToZ/0USdXUq+SJb3fpnmUyNWmE8eiHHpB3+ihyXQ1965xlKMyIya3+9ERPY/LJWnQ5y+bp9gzxWBc6NlvQ9mpsyj+GbelDiWpBQ/GubsKJdRxvt4qKkNcBtnTTLxbcM6FXJmryoWL5a2SNrmtDJr+l2G639dL+9JmQlsTLixA2eENG515BovansAi71RJHaCjYvMaUL/Y8mGMLuoMXpG1PMKDdhjwARfuP4ZUyCX3DMITSJjSO1Url8G6wATcSaD6B9xSr2PEWsFGNhCqplPv0QSur3HktZHiDEQB8rypI6F1Eg==
Received: from MWHPR19CA0056.namprd19.prod.outlook.com (2603:10b6:300:94::18)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:19 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::2f) by MWHPR19CA0056.outlook.office365.com
 (2603:10b6:300:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:19 +0000
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
 Tue, 6 Apr 2021 17:05:16 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 06/14] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Tue, 6 Apr 2021 20:04:49 +0300
Message-ID: <20210406170457.98481-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384139b1-5152-4398-4e60-08d8f91e2826
X-MS-TrafficTypeDiagnostic: DM6PR12MB4172:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4172898DB382B3DEFBAA046DDC769@DM6PR12MB4172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5ZTMJt8DhGJDJlqRjhWsjaxncUM+cD1IidkcTuccyp5rPLW0CtRLizYRU/DpPhBegG4i1aY17KKkUi6znuCIcJSJ3z4DaPyypS7xCBXDG33ajVGwwA11r460GHqpbmHAPHV0DCSFBnIxL+6TxIBolEt6Co8AXL+IejwkjiSIZT2J0Qu6CQAcWhKNRUQ3+r44m12a3wLtXSaiOjlDw5myA9EVDkuH324SjeivQVZUQMG3qTQjvin8hidEdBjxPC5+esE9lzbrEcg9eq4Ciqy/I+U9EunU1yuSsLuBMeiqPYhbNW0apcSwH/IS1i1ArRcRJClHoVMTZzYuXV4Sqv7r04shKWwdMt/GsMxEIbL2/Xrl+6aGQIThptb891/F6MSEErH40Rl9zQK7ZE6qKJarJyfOplX/xkUTKYb4Cdjm2MF2cmb7STraYfGg/5HQuyvgjeqiL/FBBNgA1TS8l8D2GKtkodIG9UB1nY3+IRkeJ0x2WWWESjCgLzCAf/qOvrzfJFwauNhC2Eeo94bOC0pHKlRybzDEI6Wg6IXDoNiWN0jxdsl17atrbQK8aSS20C5zJlhXNBQbB7Pciur50yPRrC9jNsLI4T1XpMSfIbbmj+92yPj9016UmLxKCNciA3CEpJPEClyyCuihz+1btknkg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(82740400003)(47076005)(16526019)(82310400003)(478600001)(316002)(8936002)(1076003)(6916009)(6666004)(70206006)(36906005)(186003)(70586007)(36756003)(26005)(83380400001)(54906003)(8676002)(36860700001)(86362001)(336012)(2616005)(426003)(7636003)(2906002)(356005)(4326008)(5660300002)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:18.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384139b1-5152-4398-4e60-08d8f91e2826
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 26 +++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  4 +++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 39 +++++++++++++++++-----------
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 5b6b2f87d40c..5d59e06ab224 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -467,6 +467,28 @@ static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
 		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
 }
 
+static void vdpasim_get_ce_config(struct vdpa_device *vdpa,
+				  struct vdpa_dev_config *config)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (!vdpasim->dev_attr.get_ce_config)
+		return;
+
+	vdpasim->dev_attr.get_ce_config(vdpasim, config);
+}
+
+static int vdpasim_set_ce_config(struct vdpa_device *vdpa,
+				 const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (!vdpasim->dev_attr.set_ce_config)
+		return -EOPNOTSUPP;
+
+	return vdpasim->dev_attr.set_ce_config(vdpasim, config);
+}
+
 static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -568,6 +590,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
+	.get_ce_config		= vdpasim_get_ce_config,
+	.set_ce_config		= vdpasim_set_ce_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.dma_map                = vdpasim_dma_map,
@@ -595,6 +619,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
+	.get_ce_config		= vdpasim_get_ce_config,
+	.set_ce_config		= vdpasim_set_ce_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_map                = vdpasim_set_map,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 6d75444f9948..62a21a4567cf 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -44,6 +44,10 @@ struct vdpasim_dev_attr {
 	work_func_t work_fn;
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
+	void (*get_ce_config)(struct vdpasim *vdpasim,
+			      struct vdpa_dev_config *config);
+	int (*set_ce_config)(struct vdpasim *vdpasim,
+			     const struct vdpa_dev_set_config *config);
 };
 
 /* State of each vdpasim device */
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a1ab6163f7d1..bdc70e9bf3a2 100644
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
@@ -114,7 +108,28 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 
 	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
+static void vdpasim_net_get_ce_config(struct vdpasim *vdpasim,
+				      struct vdpa_dev_config *config)
+{
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	memcpy(config->net.mac, vio_config->mac, ETH_ALEN);
+	config->net.mtu = vdpasim16_to_cpu(vdpasim, vio_config->mtu);
+	config->net.status = VIRTIO_NET_S_LINK_UP;
+}
+
+static int vdpasim_net_set_ce_config(struct vdpasim *vdpasim,
+				     const struct vdpa_dev_set_config *config)
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
@@ -139,6 +154,8 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
 	dev_attr.config_size = sizeof(struct virtio_net_config);
 	dev_attr.get_config = vdpasim_net_get_config;
+	dev_attr.get_ce_config = vdpasim_net_get_ce_config;
+	dev_attr.set_ce_config = vdpasim_net_set_ce_config;
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
@@ -185,14 +202,6 @@ static int __init vdpasim_net_init(void)
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
