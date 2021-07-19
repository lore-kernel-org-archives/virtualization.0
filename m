Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF3C636C9
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DAA61165
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DAA61165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 596AE40252;
	Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5rG23HLpzYp; Mon, 19 Jul 2021 07:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2AD140247;
	Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 672A5C0023;
	Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F79FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C5FB403E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXcCcRWUJNSI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2054.outbound.protection.outlook.com [40.107.101.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C1DE403BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9nsaPLdVX3uR+mEF+mSD2A86cymAYmZcBm+yKsENxk7VApy4OuEW8SHDDJOFDlJGHfyDluQHTnKlXxvvSYzkkDPFt3Q3E4gHR9sEtoQDmWspl8k/73T3SnByOgS1WkQyEIrsNBwh/C+o5LnVRJ+4xcfPo9Zcn1vD15CXGDxiJpQvTtUgBCgCXS115KL0Rml2nObbMzjcDKAKGbYcqCyK4+d290ggAbxzDQ5Ct1PqvFgEF0kumY6Nl4Dk94EJJUjr4ekFS7NAGeS3N/Xkl+xWI0KwYn0OUR6qxgg+OhFPJKLCaXeZ1+Vvn4ofiOi1X3b0T2NBhoYh6JjgHP51LIHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfSkFCHwiwnz7HnGsvOY+jml2I+V+HqWh3mbWpu1gvc=;
 b=JXvpvpTAYDfNDBYvr/d7ZbH1JdfxUbSZ0k0ZBlc8dkc65H/gWGUCREn5Zbz+w1Q2yGwqfbFSUUfsc0EPH8Ib5Ag94fDVkiLsifu/ALwa3lnRjE5LkbH/rNVZpS5ATPAOQY8PeXb5T4RuH7VP7BDo9CLnouiLdVGmUwo+NjWjy9MM79yawKxOhKWw3qOEWGvS6IfD2MEibwz9MwFZfY3L4cjqpZfow4VLx9dc+8CIXR1dh+LXy86LwdzT1e0bXbkR3RIuSyDErO/QxkRkDXCac+C56pW5EBK9vPn37zPmeuxXQfgGhU2SdEk23UBygH1ndLUEy10WNWHqJMNVH6v7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfSkFCHwiwnz7HnGsvOY+jml2I+V+HqWh3mbWpu1gvc=;
 b=XL9RWPTCzj5xdjExULAUSZBD1Tg1BtzIZpeKyEMmwooTBlyxO2b7uy9n+qdRDpffGx9x/kpZ65w2esn53xw3hYF/yXDAicIpfGIoRvQI9kyhcb6xgoLNJtrtymYMh3bFKKBwJ1OhitfWhjqlP8RhXXMo/iXJOcJ+jFmQJ7dRljxrNMGKki+pV+xyBrcFUX6EOX+1VZ2q9ZcB934o8rb3O/pWm49at8gEfW2HOGDpuK/l8PGS0ciphUds3MEIOdcT3YsNMlnVfBEpAns86Dpp30wFdvOcOz+gco7Z2ZZ6xNLR5eDwLhs3oowb6TLaBQHmHqdpt1gY1J4/CwO8nSnZ9g==
Received: from DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) by
 BYAPR12MB3509.namprd12.prod.outlook.com (2603:10b6:a03:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Mon, 19 Jul
 2021 07:52:38 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c2) by DM6PR13CA0031.outlook.office365.com
 (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.13 via Frontend
 Transport; Mon, 19 Jul 2021 07:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:52:36 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 07:52:35 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Date: Mon, 19 Jul 2021 10:52:15 +0300
Message-ID: <20210719075218.1485812-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719075218.1485812-1-parav@nvidia.com>
References: <20210719075218.1485812-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a3c31c-a96e-4380-79fd-08d94a8a2cdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3509:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3509A730723AE94B2CC032FBDCE19@BYAPR12MB3509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5Nt1T8qHVY2x7PejwWF5YqmjcFBXEpEbqU28ArDfyLUqtuz+bFfSrChnB0HpQw1OYlrqcQIa9m9QofW5CwS0sXaS3UZ3O+i3pKcZkTJepjgodcux8LF0P1Caf1Ewf7vMd/C6FVR73gB12KLeXLSw3Av8+tbUAXzFzNxMaWliNLXj0nhrLdo1w1YNqMgxp3RCE91R1NYLtlhmsfXKCJwAlDrOSPxicrZHFwHWniNfsdKLN0tNp1xY4Cet2vH1WAuj+wa2gw/kYI7PBLwOidFnrk+yqcwv3XdtjCplN4OhSVRA8XydPrRU+53ZJIAvaoBgt7YcQyQv5EAN5M4iccXz8R7ACvUCtrNbfNHaGHIEtB8BYG5L1uOICZJZCpppfB8XpvKxOFi7Y3fXHt8uNnsjqR1q8PPtV06pk+AyV06yWpIK8l/OKR3nMDT1bUMBW99rbBJelsQzlB9opW978WjDP8O0e+Q4xhUGtyu+MfyzZbmQYwuF89p2UK3g7Ucb/XdHK0VquoJQC9iH2nmODc0FSWT17PuYgn6DxJH7JLoPwFitfRESNrE1zNSUZPF9Dr4e7mx0gTFLKr609m5fRFKPMp5uaFU2s8Sp7XHUckv/FUhl4o3/gfLAcqmuCi0He8wkEIIu6S2J7ew/OZhRhgWywgyFIBYEcW5rsJhnNQu5/qjwRbpeMjZubaOfV2hEIOjxT3M2IngGV/3GxgJWmeh+A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(2906002)(4326008)(82310400003)(478600001)(5660300002)(36906005)(336012)(110136005)(186003)(107886003)(316002)(8676002)(82740400003)(8936002)(70206006)(47076005)(70586007)(86362001)(7636003)(356005)(26005)(16526019)(2616005)(1076003)(36756003)(426003)(6666004)(83380400001)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:52:36.6831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a3c31c-a96e-4380-79fd-08d94a8a2cdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3509
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

Currently vq->broken field is read by virtqueue_is_broken() in busy
loop in one context by virtnet_send_command().

vq->broken is set to true in other process context by
virtio_break_device(). Reader and writer are accessing it without any
synchronization. This may lead to a compiler optimization which may
result to optimize reading vq->broken only once.

Hence, force reading vq->broken on each invocation of
virtqueue_is_broken() and ensure that its update is visible.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
 - removed fixes tag from commit log
 - using WRITE_ONCE() as its enough for smp cache coherency as well as
   undesired compiler optimization
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 89bfe46a8a7f..e179c7c7622c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2373,7 +2373,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->broken;
+	return READ_ONCE(vq->broken);
 }
 EXPORT_SYMBOL_GPL(virtqueue_is_broken);
 
@@ -2387,7 +2387,9 @@ void virtio_break_device(struct virtio_device *dev)
 
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
-		vq->broken = true;
+
+		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
+		WRITE_ONCE(vq->broken, true);
 	}
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
