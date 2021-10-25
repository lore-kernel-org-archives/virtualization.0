Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E6C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767C360F9B
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 767C360F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3562F40394;
	Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3JwZpvVpbeb; Mon, 25 Oct 2021 12:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 952D44038A;
	Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46ECBC0023;
	Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8924C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4C2A40141
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRIaH06kykCK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6C4C40110
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7M85Sz5iuBcNNhLWMhyN64h2UcRXCF+hfBR/dq2zvsoQU7jv5QI/jGQEr+wAjq6b+dXOjbbJUBzkXrkHqAxzE34G2by550lS9ZY/TBKavYmaHg/1Sk9Xyn0ORTh9lf6FUMo3phKbWTYxsKquOYfNvQeHkXRXc4uBXSN6mNKrTE2RfCER3sHhIWPhTHxbOC6GFcL2VXD7X2vdR/a1KJ4weNqQe8v33OZewPLhW5T+zuV9s/ZG83Q1CoosTfkvmikuzVM+w7DzDRjNgUF6IMSTBiWAlgfDwXo+362bms05W68IC8MjgjvxiVBFDsPFNIwo92QxGGxJOis8dSUu/CD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAUqrOs790mbswkKmQ0W6tzkzz+eBjYHO7yL7xgsAeg=;
 b=LrJllOIbK9TeeEde7J88lEG55USD/DV0t2VGeiuBPc5i4YAcPHnNW6CIMVtih1TthzjUuH0wM7ppPXJP0++Y/AXMuc1KjzqYxVZ9ySm9xDgVCyN1YuHUm7ZKLtcfGJr6jNoWPyKNdj9XFgoMR4RXROSOxH18cWnUtURwfjhN1wjXuSe3hzmeLllqB9chRNTE3b4g58GzQwa4pdGKPkD38KCPxkRUaIt62JJYCQT56wSWd1pigApndrj/E7eaFsEMBHIx5Ru9H8huqNnQNhRh+jfsRVtDAOD9lkc6HDkaQ5gpc5Ap/zt4LFE+OrOhfvSMTQVo/uRGBR/O023zCkL4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAUqrOs790mbswkKmQ0W6tzkzz+eBjYHO7yL7xgsAeg=;
 b=uJsLXVCr3b3N4tEO778/tKg/KZoLWQYgKasJo3Kz8shIsqGnLxq+Nei77Uh0iNWaA68PNLkHqGgCDQCwf9KXCk/Fr7Qr3um2RUUlQKyiJ6NMeBHlWhW0snjYUF5BD9T19nWbiznrZIJsdafxIqG/ykZAXoXlapE2RODNnujySKR5Jko351gWeYniirkSmaErabO13lrm7y6Ov/ARUPUj3Di1hZuJbg7ZdO7GVKxjpl9Y9rZHq2kJWiUd6EB3iIskVHQUlerXT+iAodr9GOMP3KLK7KDFvhC7/HqZjDo1dZKkpTPq1ZHz99udfKu5VPiO0kF8XwdblVO7PUXFzH0Zqg==
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BL1PR12MB5288.namprd12.prod.outlook.com
 (2603:10b6:208:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:53:37 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::66) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:36 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:32 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Date: Mon, 25 Oct 2021 15:53:13 +0300
Message-ID: <20211025125316.67664-6-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4bcea0-4d1e-4da0-f353-08d997b675b9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528850468617E0982BE55237DC839@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1At08PDBXioN2qRuFPgG06Jsu4NR3L7tCBwaUC+xt0YU40gntrYWDt0gR9oMFg5fdSLUoiCvEQyPHCDIr7cC23vBh7ZCS0CFFPuoM04N1ig0+sXM2FjLeRoYl9WQyrzmwBjkPFx+xeIdYRtlOaoBRipnYMYXYlvQlUN/kyB4kGQBvlH4xA9N/ByrgqieHKepnD4iYFbunC4BqQ+Vby38OKiDxr222xVWd6nmTuzxTbJbnzptlgyi3rSr/o2VcyMmyPvPzBGGK88wNQbXYWO2Opqfjq8FADwvKLHYCxZA0W8A4hZTb/lqj3EeXVnW5WARDpI7n1t/IxC8w5NFH5UpGaYgZ9zAbq3A/y6XLS2mjb5mgu25WmS5w+KLgyBK+SboogRmNhDYOpLeSPiAJtFuN0Uvg/oVO7LisLjsmNcI1dAsMRkGfoIsjKhvTCHcAJ2EsZZ92LVDf9KEjKFc9a/usQpWHyIbd/4kflYS+SpZYSNZ0rMY8pGmhWYJaZ26EJGqd2cUtxhOTRmF4cMcm2KARrnptJs4vyjCCV1AnQezXv1uNdkDQU9nTb8HnT1Ij52i1GEcU/rjEhUEYA/hXu1TR9V229O4JioP30hZUYaci/0zi7xhDVq9Tu3vGwgwEZE6Zi6Tfior6ohj28WOslN6nzs+M4NK1/0XUjbDiprDmx1bifGFDWQ2XGSDJb+9xa3QmY2E5zk3M/KCn+oPsL2HTw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(6666004)(1076003)(36756003)(107886003)(70586007)(4326008)(8676002)(54906003)(508600001)(47076005)(70206006)(26005)(186003)(36860700001)(86362001)(426003)(2616005)(7636003)(316002)(336012)(8936002)(16526019)(83380400001)(356005)(5660300002)(2906002)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:36.2369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4bcea0-4d1e-4da0-f353-08d997b675b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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

Enable user to set the mac address and mtu so that each vdpa device
can have its own user specified mac address and mtu.

Now that user is enabled to set the mac address, remove the module
parameter for same.

And example of setting mac addr and mtu and view the configuration:
$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net

$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000

$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v4->v5:
 - updated commit log example for add command
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index d681e423e64f..76dd24abc791 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -16,6 +16,7 @@
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <uapi/linux/virtio_net.h>
+#include <uapi/linux/vdpa.h>
 
 #include "vdpa_sim.h"
 
@@ -29,12 +30,6 @@
 
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
@@ -112,9 +107,21 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 {
 	struct virtio_net_config *net_config = config;
 
-	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
+static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
+				     const struct vdpa_dev_set_config *config)
+{
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR))
+		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
+		vio_config->mtu = cpu_to_vdpasim16(vdpasim, config->net.mtu);
+	else
+		/* Setup default MTU to be 1500 */
+		vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 }
 
 static void vdpasim_net_mgmtdev_release(struct device *dev)
@@ -147,6 +154,8 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	vdpasim_net_setup_config(simdev, config);
+
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
 	if (ret)
 		goto reg_err;
@@ -180,20 +189,14 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.device = &vdpasim_net_mgmtdev,
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
+	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
 };
 
 static int __init vdpasim_net_init(void)
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
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
