Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCFC43470
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A63B611EE
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63B611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09CA160BA3;
	Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpRyuY9EjZPp; Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35F1D6005E;
	Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D85BC001A;
	Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EBDC0016
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D850A40569
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHNI7mu33aDY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 768164055D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu8+5hoVLmxCX9wavGVJUuYG8SoP0WB/8zAOuY3PRB9cIie1RvlaKk3nYpR94j183je45InUxLRUmeLCa06P9dchYSghpyuRXzpke/maS+KkcLCjqj9VAtzD5gs5Isr0ciroNMDqhruHQpltG4dCxMRYwHxCuaJBBfAsV4fMX+SAVD+HDn5+aMGEvpHEv8O3eW5kXQqlJyIiZlgqRyqXfbCGgieuqXDcZbRQyCxK1/2kHwzPykxGPpOjeEcuG0wjL6t+95R8y/bsZbJiO/6SqmFuwIMeHSh2TqbZbosat/7lc7wdtPlJtd4TetYUlxzW2bx5uxs2FTjszcHycqAzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHzOpwP8GJZaiDSs5yO4VkiIcEN27hWf67qKW2UjBnA=;
 b=d4ESNX3QDKim7THCCZRjqBpdKRuqTEky1NnKIM8xSXQCnLopW2LYQGekKacvdKRg/j1fVLItQoZRLgGeb/SUEEEFDlB9XtWxegmQCe7GLmQ+cRK5njjq+T1Jbg+WfKFo3IfZ4ohFZjzdir+0OzNpZpOO95UqpnmD1g3Oqn0unM5yqhm5HPtMox02PlUK+EB+kWTWCSq76N8wWuxfriIJEYa1AwUeZ+wh2dfyBF5Cqk2PxFMmX2d9aTQT7wSWMqsn3sju7t7dSGd8igzouNKEKUrasjclfB9KTZSBAQzJpl2oy/H/7NLzNHSgsolV1It2BvXe2FSq1B+7Um01Kj1U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHzOpwP8GJZaiDSs5yO4VkiIcEN27hWf67qKW2UjBnA=;
 b=aGgPKq8iVO7EyxHRtKv532ZfQj3W38NSuO4oUCIBbgyrjVmnlA+w50pFLkmnTbmuZFXr3Bn5giWyIdEc1+85B/GGweEQz61e/pGNR5+L4N9g0+lW61wP6kf2nhKGCfgJeAzn6wKGPRSVVFh+ZDmTYB71VerkoduXwJ464QHp4eMabNPHWap1DXiT8kU8UwRbhwYq/VgwTUPi4quI7fogbxx9LN8OhS0x2FORvZLpcdwfKCE8WIKhhpe+SEqEw+61n0zwQwAAtcRypVU8Zq0OL6w8R6r4k1QZ/KmhkA0cQrGLq3k3REVOqjbY2rdiAWUb5zNO32wE2BX7ZEk0FnbnrQ==
Received: from MWHPR19CA0069.namprd19.prod.outlook.com (2603:10b6:300:94::31)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 17:05:23 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::b6) by MWHPR19CA0069.outlook.office365.com
 (2603:10b6:300:94::31) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:23 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 13/14] vdpa/mlx5: Fix suspend/resume index
 restoration
Date: Tue, 6 Apr 2021 20:04:56 +0300
Message-ID: <20210406170457.98481-14-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f785a253-66c3-423f-bed3-08d8f91e2ad9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211AE56DC23C9AA53C97CC0DC769@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsRSsLIcVfQvux/4ivOeZI3wauldSnFmSpnDDwh8rCRLoSAwN1gZWDNfOzvuJwk9p8ZUX9XYzXcTxlpFGbwnJ7VkOUJVWmQ+ytxleo41uJ1vi2gj2kkffkRNzkwTryWtLQ56Sy4jt2DmMTP4HKbx4Sd9alv1XVaETJEqok/0Cm4WnhtYx3bdzho4FO9KaVelhiGhV8pgFOaBXACvxj8yAvwK2sZSSMCQXiWW1iAJOSxpAPAD1hPpCmE8jjrS+k9iVmy9haCB/5law6qS0yRUCwby9YtWB3sZnbr9mcI4OvhYcbEgu2TkPaMBmCIULgkrneTn86dTJMK+jZTBn7Jv47y9KBKAAr5hvXF78Epn+8ql358A81Wp+Mue4wrVRcy++lIFgpWsXojfZP1kSFD+5b0h8f3KEoDz9uCRl8KLt1RmmLfcET/gI0YSsWFB33/FNOvkKH7qixTe1gA+yOa6n19tqWhKYiI1WO1NLAuXbbTyMp5YA2PnApqB4vROhbDMRuxfqmPNTRYPU+YK5FpYeNxowLgjJLVCflpqwqA21/Wsdq+HUAsW5iiSDwS0kbGyQrx+AvYUibrNz8pWcNZJvWq/Px36Kj0fKXK7gNF7TRp4vbTbHlISlKTid7g2E/KpzKeW2U8UJfZSmFg1/CB1jxYh4/UYvZZnA8oaJYeRaBs=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(1076003)(54906003)(8936002)(86362001)(2906002)(70206006)(6916009)(7636003)(316002)(36906005)(8676002)(5660300002)(83380400001)(4326008)(6666004)(36756003)(15650500001)(356005)(82740400003)(186003)(16526019)(47076005)(336012)(82310400003)(426003)(2616005)(107886003)(26005)(70586007)(478600001)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:23.5114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f785a253-66c3-423f-bed3-08d8f91e2ad9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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

From: Eli Cohen <elic@nvidia.com>

When we suspend the VM, the VDPA interface will be reset. When the VM is
resumed again, clear_virtqueues() will clear the available and used
indices resulting in hardware virqtqueue objects becoming out of sync.
We can avoid this function alltogether since qemu will clear them if
required, e.g. when the VM went through a reboot.

Moreover, since the hw available and used indices should always be
identical on query and should be restored to the same value same value
for virtqueues that complete in order, we set the single value provided
by set_vq_state(). In get_vq_state() we return the value of hardware
used index.

Fixes: b35ccebe3ef7 ("vdpa/mlx5: Restore the hardware used index after change map")
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 56d463d2be85..a6e6d44b9ca5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1170,6 +1170,7 @@ static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
 		return;
 	}
 	mvq->avail_idx = attr.available_index;
+	mvq->used_idx = attr.used_index;
 }
 
 static void suspend_vqs(struct mlx5_vdpa_net *ndev)
@@ -1466,6 +1467,7 @@ static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
 		return -EINVAL;
 	}
 
+	mvq->used_idx = state->avail_index;
 	mvq->avail_idx = state->avail_index;
 	return 0;
 }
@@ -1483,7 +1485,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
 	 * that cares about emulating the index after vq is stopped.
 	 */
 	if (!mvq->initialized) {
-		state->avail_index = mvq->avail_idx;
+		state->avail_index = mvq->used_idx;
 		return 0;
 	}
 
@@ -1492,7 +1494,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
 		mlx5_vdpa_warn(mvdev, "failed to query virtqueue\n");
 		return err;
 	}
-	state->avail_index = attr.available_index;
+	state->avail_index = attr.used_index;
 	return 0;
 }
 
@@ -1572,16 +1574,6 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 	}
 }
 
-static void clear_virtqueues(struct mlx5_vdpa_net *ndev)
-{
-	int i;
-
-	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--) {
-		ndev->vqs[i].avail_idx = 0;
-		ndev->vqs[i].used_idx = 0;
-	}
-}
-
 /* TODO: cross-endian support */
 static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
 {
@@ -1822,7 +1814,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	if (!status) {
 		mlx5_vdpa_info(mvdev, "performing device reset\n");
 		teardown_driver(ndev);
-		clear_virtqueues(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
 		++mvdev->generation;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
