Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821C8C07E9B
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7661006
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7661006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B372140295;
	Mon, 19 Jul 2021 10:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nckE_dg4Iync; Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25CC8400C7;
	Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD77C0010;
	Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8982C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A1EB827DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXYgGnuy8Nfr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B29D582444
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmB1tI7+Zz3XVkw1VC26WD0r7iXwmZEuiJJ8vEJcrGHK2b+yH018mvzl0UdJjk0XcEVw741FnaBufU566oEFJwh8N4N0OJiXFlDyiVYP1JXLDII2gRwyYIqVxqbtuqaiPfVvMEP0XHX5gCBZZPgLWITuz2y1+Apg6Jr2kwsRz3PGpKoyqofUjCa8vmmU/eIJBX71a/+vINbGx4L1evb8DARVWNk+RjfK/EJ1Z2pWTLFQf7d2DhEKJnKH2vIw/vO3yTuRS1ursjAkTJQ2FNjVQheJPASHo8PTF8Fr5HLOILzvaTMRTGJgI42UXbmWHeeP4izc1sWdVH4xTIiSj+z6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iQU0H4m+YjEgLPFdteiM4LInev1gPDp3fv+mpHMBp8=;
 b=Q68CGeuFRMaCKvrKRIoBUsDHZJ/yXwGAockdbgGWo4Ral8DSzSqBE2aG6kefTj/o3xzCezfncA44W+zv0C8PSZ/vWwVbA+NHLaGx6lIVk7kAp9UBPASnXyEu02px6Oma1nkZeVIRUhjSJxPADog8jaL9B/rxFSq0osGzPxG2fC5k5gBP18jE8c3Xt4dW73l7u8aY58VjIjj2RzlRaZZWAPMCIxJH+sDeWsKg7GLJ3Nso3jwJqlfhYGhwP92XMBqCb56O7fGaoGk1ROOlK5XskjcD7g2mrnzG1hfyW41CNPioYIn2k8x3PyE3XF2dDGU4aCD3mU49AbsxoQ07W1cCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iQU0H4m+YjEgLPFdteiM4LInev1gPDp3fv+mpHMBp8=;
 b=UdUYIBbIxEaMowKJU0cy5kaRc9+qs/lDu1wKPw/RGgm4RGuFx/PmxRDeo7KgoKrWDgiUyaC0ub8iSrGmzFldtywHCUbHut0xawbpJCFxCJrjBRcvG64ki2G6VTcsnmdmakCUGtOC83rfX5ZxiEkD0nUibGbdNnH5Ok5YWXDkD/QnxmqidjvcCm9YTi9GUknIUy0EAjUXtb9WwHL9VtR37E0PzLFd+97GKXBOPctlD9VC/MquqcXI/LV+v21S2e1P0NMjDVIv4LQsKV0eA8N9ET0wEH4mvX41VzYl/Inm5aYXHHw5QYsGSM7MuvNvls5m3WlNstnrfz04fsJ9lHMdFA==
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 10:38:56 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::5f) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 10:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:38:56 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 10:38:55 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Date: Mon, 19 Jul 2021 13:38:38 +0300
Message-ID: <20210719103841.1488049-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719103841.1488049-1-parav@nvidia.com>
References: <20210719103841.1488049-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abddfe1c-f96c-4b28-1d22-08d94aa16979
X-MS-TrafficTypeDiagnostic: DM6PR12MB4652:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46526BB047E171944FEA1C99DCE19@DM6PR12MB4652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymuOqY157kY7Bn9/tt0w00ttiYDIl2DW74eZ0Va/aMiBiUZZIR8OPAWVWv4s9sgxYb5dZDHnIRGhcnJuTU7LwHDIzPlWIi1WXAeRwL0wDe3+2vtSV8jAB7tZ2dFxkLru/M/B0SJWpjtSVFM4yK5x8aJiCmMUcou3ljSrKWS8KCjfkfzt50LrmTiBTLGS+p7m/Alu7hZ7LD3fi73H10c6xHZMrmcSaq7sCY2XKk09/O6L+yw5gg5goYyvQFV4+5MCZmDaq5AlhQH9XvE9kywZa7MoLJwDOPaj76LUu5nsw+avliJ/M2gdjSnZv2+qIlosMidaEfuSjFLhuhtYlU2Kzo3NvhntghfYXIIPDWbpGjphw6iLS+Skl4QJnJeLxyT0A7FftGKdw5oBTDtbUDEFOEECO+bax3PaVNIkp9r1DngL/BCAtar0R/ZuHVyTpzm3bQi/R0WHL4nkT9UDg39b+H7kERDEUbADA33tylmKLhvHZGjPQdWqXdECF5XHeKlaHFOqQGiIiz4RYZQtSAKfUOZAv/DpFr6j9p+kpfqI97BcWNz5DU2PC90WEQq5p3Mkimnht+8ibhSbguNDQFFX+F3pcRXFbsfMe/ExKUgpywYQhM/IxAkHLEvp1W0pv9wZe7h1Vv59bs2OjMWk1UxVhyiyZH1IpLGXorJ5fYMNK6ul52WNUrJAfr1OIEyxc6YqSV7IL7NobeDHnte1lwKA9w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(6666004)(186003)(16526019)(26005)(110136005)(8936002)(356005)(8676002)(36860700001)(83380400001)(70586007)(70206006)(47076005)(86362001)(7636003)(82310400003)(36756003)(2616005)(1076003)(316002)(336012)(5660300002)(478600001)(2906002)(36906005)(107886003)(82740400003)(4326008)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:38:56.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abddfe1c-f96c-4b28-1d22-08d94aa16979
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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
virtqueue_is_broken() and also force writing it so that such
update is visible to the readers.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
 - updated commit log to describe WRITE_ONCE usages
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
