Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D0C43462
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31627611EE
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31627611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 768D284A83;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YA2XV4NR2Oc9; Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EDF884A71;
	Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66801C0017;
	Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB38C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F5B341460
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8l0zBLTY0Z3n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A06540FAE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvMgZyZxI44EJCXHWJX9bQy5zuCe7wqBHdmBS5QvzKbGgR0nZIuaw0MokADxRarqZECkZMML9Yn3IAo6QEo7IwO0y6bbRRmPrIUTJD4eERa/NfYaOWtRAVjRpTh34BJqDLOzvP6/Rrmyr9szc3btztoIqIAe+Pc9cskpwzGi7AElYrzwkVu6hBGv95yUbYrqSQDIlaY4JlWkErQ7qOBhmMRe2HsoFfd2zGnxB/8tcG5E3NZS0H6ldjuBHDXHVKVknmsRrMfBTOhoFyRZljaxHkG+sWMR8rHM1RbVTohl/LQntxwwHiQq1U08PLB7wZeJ8siVZthrY9ADPUoH9stjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh2JAxs5OmzA3S29qZm0nre01fEwFXe/4TRaJRxhaug=;
 b=ABDD2POCUQel+wcv9Uxis2eaTGsKbyt8/4dB/2iuMAcBKFBEY4D2ae5CM/fwJ1qeZBnTxdx19r/+TUYLCzcbxztQpInJkoJIQccyURS/rjgddtGXTPx+RQaUlMt5oSuj6H9qC5AMaTfwtWAtx/YGccLFCzuloeh84m+d8s8mwmrLQ/q0n2yVveJZbKKcDOJezQPhbcTc6gT8T0R/+YQdGlwESxNLf/JeizqpA+oLl4GjPG5xfSFZmL3MIRHNyopMd+da9wq7pHg4E98bJkjcBfwtd/mpsvSLCZ5cQqGygCAV5ni+kIFUzJtoCUEUMmqBkyNkL6ydR5RwHdPMEKdPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh2JAxs5OmzA3S29qZm0nre01fEwFXe/4TRaJRxhaug=;
 b=rI3oqteviJkpT4EbgvrH5qtxUuH51m0/0u02KFH7F/AHwoZeWOVNc2SuZ/x7y4atyb/TtGAJPG4JvfnMHsN5Qg0yO/DxtR4lGDkbR6SaI9c4PrzLePbe6zgfJfpdITtOuGIWUfGp2CWdbTXddZ53bYu20otIRC8gNyVnCV14hDZ9B63dZNwy4vYb8gn+LC1ONPSroLQXgQx+kPwOWscOHJI33h+uDXtXX0flub9ypBHFGlHqyT9ga3psYFQAKqjwlSTWrRTIXtR2cGckxip2Xlusb4U2recTzOfpvk1TTrqFRkt3G7QqjLRuhc0J6ApOh1J1Q6klK4y+N2FP+WthCQ==
Received: from MWHPR19CA0055.namprd19.prod.outlook.com (2603:10b6:300:94::17)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:23 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::7f) by MWHPR19CA0055.outlook.office365.com
 (2603:10b6:300:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:22 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:20 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 12/14] vdpa/mlx5: should exclude header length
 and fcs from mtu
Date: Tue, 6 Apr 2021 20:04:55 +0300
Message-ID: <20210406170457.98481-13-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aaa9cca-f308-4dac-e328-08d8f91e2a83
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3643C471E13B9960B96B86EBDC769@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8ot2AD0Qsxk/ou7B/WxhYmZLadRhapEx/e+3Fr9DdyMz+dySbBFwL5FCbKmpDDt23l8Rmay2h4br+tNYVI33323hR+UoVSXqzzIBGrx2z+heHvuCRqxsXoZVyP/Tss69OfDntecM42LoxzgfuZiIv5EFzbNrEXAKdKLjbKl5P4axR9psxAFktnY0fSxkLtqH3XeYeq381Zh4uvO3T89d+/jiRALuL5/eiewbX2MXHmme4RMMvknBviLTg+fhSTsfAdt8E2pYYoekJv72+q0zg6cRfwRzNlXEjih3t/Tb51PDe50l61wj1c6wABJr6scDtFGvFBIGJdTWB57OOjw+Ra7B+idjSuMFyMKQkOfcWuxZ7IXdW7Xmx+VdmWecwa91hIZIkQR2/PqTYdLMbbLYYEAqqLWCgX8Ut5fXvHfmSb2lJh0A/RHATrTDCiqwAj2NLO+A4hlGQlIXDphZAgjoZYqnmgNOrVPCpEjaKOWFlOFRAVahDIvLMcU0gLfthlHu3XsSHt3kTJChHIHcizNDOCWeR4aRBHDGkY83nHaEIHRfVivHA6/iSj2IUUJrCcuPgQ82AZem8mtOt1QnsRPbM0ppfCJoOgEszz5VdCQd7OhTNDGB1IczTO6Zosn72mIDoMAS0zhW9/Kn79CI4kRlMi0qSplsHuR8TRIJ51+h4U=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(82740400003)(47076005)(26005)(83380400001)(356005)(16526019)(316002)(1076003)(6666004)(8936002)(70586007)(54906003)(70206006)(186003)(36906005)(36756003)(36860700001)(86362001)(8676002)(336012)(7636003)(426003)(6916009)(4326008)(82310400003)(478600001)(5660300002)(2906002)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:22.9377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaa9cca-f308-4dac-e328-08d8f91e2a83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, mst@redhat.com
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

When feature VIRTIO_NET_F_MTU is negotiated on mlx5_vdpa,
22 extra bytes worth of MTU length is shown in guest.
This is because the mlx5_query_port_max_mtu API returns
the "hardware" MTU value, which does not just contain the
 Ethernet payload, but includes extra lengths starting
from the Ethernet header up to the FCS altogether.

Fix the MTU so packets won't get dropped silently.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 +++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 42 +++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 08f742fd2409..b6cc53ba980c 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -4,9 +4,13 @@
 #ifndef __MLX5_VDPA_H__
 #define __MLX5_VDPA_H__
 
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/vdpa.h>
 #include <linux/mlx5/driver.h>
 
+#define MLX5V_ETH_HARD_MTU (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
+
 struct mlx5_vdpa_direct_mr {
 	u64 start;
 	u64 end;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c342cc9355e8..56d463d2be85 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1526,17 +1526,8 @@ static u64 mlx_to_vritio_features(u16 dev_features)
 static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	u16 dev_features;
 
-	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
-	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
-	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
-		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
-	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
-				     BIT_ULL(VIRTIO_NET_F_MAC);
-	print_features(mvdev, ndev->mvdev.mlx_features, false);
-	return ndev->mvdev.mlx_features;
+	return mvdev->mlx_features;
 }
 
 static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
@@ -1834,7 +1825,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		clear_virtqueues(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
-		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
 		return;
 	}
@@ -1990,6 +1980,33 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.free = mlx5_vdpa_free,
 };
 
+static void query_virtio_features(struct mlx5_vdpa_net *ndev)
+{
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	u16 dev_features;
+
+	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
+	mvdev->mlx_features = mlx_to_vritio_features(dev_features);
+	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
+		mvdev->mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1) |
+				       BIT_ULL(VIRTIO_NET_F_MAC);
+	mvdev->mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
+	print_features(mvdev, mvdev->mlx_features, false);
+}
+
+static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
+{
+	u16 hw_mtu;
+	int err;
+
+	err = mlx5_query_nic_vport_mtu(mdev, &hw_mtu);
+	if (err)
+		return err;
+
+	*mtu = hw_mtu - MLX5V_ETH_HARD_MTU;
+	return 0;
+}
+
 static int alloc_resources(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_vdpa_net_resources *res = &ndev->res;
@@ -2084,7 +2101,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	init_mvqs(ndev);
 	mutex_init(&ndev->reslock);
 	config = &ndev->config;
-	err = mlx5_query_nic_vport_mtu(mdev, &ndev->mtu);
+	query_virtio_features(ndev);
+	err = query_mtu(mdev, &ndev->mtu);
 	if (err)
 		goto err_mtu;
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
