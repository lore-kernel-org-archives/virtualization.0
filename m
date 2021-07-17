Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3FC636CD
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E42613BB
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E42613BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C00424AE;
	Sat, 17 Jul 2021 07:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQdaqYmcCjzW; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BAAE424B0;
	Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47E01C0027;
	Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA3E8C0026
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9FCF83A87
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Swy0tdFv9Qpy
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFE5E83A7F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buCw2sV5vf231ZSBsbfsCzSV9MCD5C7YXwJWtRuhezcItYqLAK7Ouk/mXjyW/RilsbZGisbbbgdbBXBWILtNRWWtm7r+A7HFJPlRUGsko+nb6uQzl4HPFIBSbQrw3zISKL7cf5pylgOWBKyB3IGA16w2NC7nhzbRja3IUCsaceS7SJqOEfM9/1vxq66xJBXMDRc2V//0dGfbk9LaoCDuT2T19YQI6bkO/ag+CC4L/Au4hUrRqo1nfVTUHCPXk1UnhWhvSXSzAK2dSb7sloI8OTPDQSi2Xt1NljywumCW+PGx8pQj57qkYL4Q6ZYBRJ14DCKUsw4i2kBPKd+u6viO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0hiyBF3W2iKhac/GyZ+goqN7iX3hFR6lLqUAvG/WzM=;
 b=MfIj/KGI/PauqBhFVvco6p8+JwKEu7/+Nv/nj3dZoj5eOP7O7hDjIgMEqJRZcvbltY3ZtkBPO6siJpjvoL5hpjguL+ZwvLQRc/S4sXa0V5t4BXIsQ8DrO9MAzv8JItFgicWb2IqN3ehcftBYRhE1WlRd4dcrYluFz5PvTRlxyTX9cSKsHHMaoBQW/B6yByAe7Dp9jlo93yObkQfc7dHEPYAJEMEb7UBGnpu3Zywo+TIaz64U9fiCifmhaRR/claVP8tL73F1Q9THpfbomAGrLRpyjJXSvkZfaZlS+4Xd64PnRQdeHz0elGDqCruSholOMAKNzP+V0ZOPa/OaZG6zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0hiyBF3W2iKhac/GyZ+goqN7iX3hFR6lLqUAvG/WzM=;
 b=gLbGMejQ+9Zxjg1Vn6dphosI9lM7m5Sg0FTQ6ODVXLhQ4VcUdRmkTrhZxkerDGiJMZya+ripSN3lHko3q5g81n3s+ZzG3SviviYFU6EX8mFQOiD1QqOz/jx00IpmpkYfKRJkcsB46+yOsIVCkGZHiPPpKJij+6D42/0rh742hrK+a0tFxvoCl/UbQ56dH6bH3RorA2uMFsS8MYa7u53ExsPkiztRCb7zDiqWMcduclesL868IvhLonW6w8YQCfCFtB8njAVDZ+PZ7gWVPAPo3qmdYu1qDIDMViZICXZtz/b25XPhC5Ub23jGoVDRQqSTql5hUMQAxb97/djlWU94/w==
Received: from MWHPR22CA0054.namprd22.prod.outlook.com (2603:10b6:300:12a::16)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 17 Jul
 2021 07:43:14 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::d7) by MWHPR22CA0054.outlook.office365.com
 (2603:10b6:300:12a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Sat, 17 Jul 2021 07:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 07:43:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 17 Jul 2021 07:43:13 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/4] virtio: Keep vring_del_virtqueue() mirror of VQ create
Date: Sat, 17 Jul 2021 10:42:56 +0300
Message-ID: <20210717074258.1463313-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210717074258.1463313-1-parav@nvidia.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3002ecb9-7b5b-4f26-f712-08d948f688b6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5321:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5321EAE1D8406116E069454DDC109@BN9PR12MB5321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpxsCz49oeZPcGATpe90sUtAF5AwgEfs2tkP5WTHzK3wedRKUIL8A6HVXQbR1Ggg3WYgeQibTIbBA5Iwv94F6DWojZ8g5zjAOxzZGCsUof8yvg6HcRO4cuVh+GJvcMGaRtLejG08/kpQguKuyy+FvJlv8v5gZ5/AJGsR0NXEgi0v0tlhzgN4+cs/GHHlk7feDyaLv70t+5/xq4kO59bhR1kqNsK44Fdg346l5Mwllw2ejdTPP2D6v5p6Uc82r173wX1+p6f0wp9y2c84+F8AFeDJCQgWxP9MnVeo/hApDSpRiHYty70k6m9JA+zq/IkrKWwvHgSYUO3o/vHE7Vwgn+2IMp/LLe69juuX3RudwaPY64V2NELrS/zTppw6/6lwjRy7Xj4u4I8VNahfNPRddVoIrTewNEU7SJptl+YT/zwPJSfurj9z+zcGBcz8N2KRPelbNGck23D3Z1F5WDw8ZZh3eWEqZo3hT0uAKpG7jsS4NmvvO8w8geH4/y2ZOT3cPgMVt79LRAX/mzLzaTkCIr9ft1WXLNwJ2dbR8P8+YAahhrMpnOr6Yx78ygiDgoYF+SwgzcbBEHIpYlh4wvy8fXa9RPip7Ehr9I3IJpDaKdNlmM/w4SfVxM6nrQeqVIw2psyDUaiFQiGioDtuFdaxh4t9qw+oe1oT0Pm/VPl5Sy4QqJNV3pb2/0CZyr1bh3Pzd45jxK+LJPeDKYoy1GWFyEF3PlTV1bPcsuxQSfKph04=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(83380400001)(8676002)(7636003)(2616005)(6666004)(1076003)(107886003)(36756003)(186003)(16526019)(426003)(356005)(82310400003)(4326008)(34020700004)(110136005)(4744005)(36860700001)(70586007)(336012)(86362001)(70206006)(26005)(2906002)(47076005)(508600001)(316002)(5660300002)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 07:43:14.1393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3002ecb9-7b5b-4f26-f712-08d948f688b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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

Keep the vring_del_virtqueue() mirror of the create routines.
i.e. to delete list entry first as it is added last during the create
routine.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7f379fe7d78d..d2e1a7a21171 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2291,6 +2291,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	list_del(&_vq->list);
+
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2321,7 +2323,6 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 	}
-	list_del(&_vq->list);
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
