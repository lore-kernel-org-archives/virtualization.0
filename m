Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30269C636CD
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85D761164
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85D761164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0C5B60779;
	Mon, 19 Jul 2021 07:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pcl0iTuKkMZN; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C9BD60789;
	Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00F62C0023;
	Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A96A4C0026
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5507403E2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYwwEKRha854
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17FE8403E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niotu9QfR2F+bvmRXzIQK0ON5FZYfiutd+bbNRIPgKXLNIy1ybnwIlGlJBlek7XwHDQsuoJsB1y6Mpophde+ccwYu/lltYbc6F47xTw/VAL0Y+RaHMizxg4tSjRRbhxDJgM9RPVrFDI+jIosaqGWHfurECMO4pGvkO2F9u75AWegdDRGQc8xIpg7d6TGvDXzLH3JKDjh25PQ3t7w29jaZzp0zJRQAjV4Mm2sV3Tsee6AJGaJ2a7Ej3Ts+R9LFpYbTfQpQm+ySc7PTST2W70hQwCEj+2cfSwVaivxdY8Mb6JMTMIprZEzwXTbvFvmuexC0C1IH3VissbJGUg7lwZdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=IrGy+C5ODw6bfwArJB2jjRnOZ66pfz5mPogJEgqGMhQZdiULyVBZ+MpaULDa/s32AE6jCsmuV9rjwXnzNOhCjW7K2uCcwQbzoReUK1ru5/ysWjdz5hU0WiBEmqdzuUegUdSe/oz7KsaGy+1pqzHjh6a4go6fdijkpjjmBQNNsiVEexyO8CXXnaEu7bNGZc/63qjv6WNoxCg4tLu0VO7w/eqiZXbV+SLiz5Te55NtsEVthqK79p/KLKVFpUA3cL1R4LltapQGSlAwKPAhH1azHXGXyyGi7PXEKfMkKRY85e9p0X6TwXpqzULxbC00PpPIoxp5BLaTdUtNke1bFuUSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=RbyH1Ib/tjmio356BwfqG/gFk8REPihdPitjvgqC3iv+0u3Ya9fvePuUBDne5DacG1pzVk/+qkty0wTJKyzxEudU0AHm6cRSRn0KIHzobBcvfaYcS1eVv+Yxf0VpTpbynSGKVOgmOLjAYl45ROX9eYvu4OTcVzE6NmuyFouQE8iZnOBUO3gpf8TuzM6FtiJbb9fGJSCa+n2+c92vEhEkwYxq/ertY5JrPk6gXBnk9iIIw6DCHGQqaEl9FP2XFhA++qPRk4JoQSODf7GxgxLD4RdjiHde9/ktyQTcqrTzhdO3fpJOBmsDbZSMU6Ayr/DEVwC7YnUpDUpDkaGSCQm5Eg==
Received: from DM6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:5:bc::16) by
 BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 07:52:39 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::8d) by DM6PR13CA0003.outlook.office365.com
 (2603:10b6:5:bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.14 via Frontend
 Transport; Mon, 19 Jul 2021 07:52:38 +0000
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
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:52:38 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 07:52:35 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 2/4] virtio: Keep vring_del_virtqueue() mirror of VQ create
Date: Mon, 19 Jul 2021 10:52:16 +0300
Message-ID: <20210719075218.1485812-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719075218.1485812-1-parav@nvidia.com>
References: <20210719075218.1485812-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d3c98d-d840-48f6-2289-08d94a8a2e24
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2914863A1FDEDB65BD985BCFDCE19@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1Nc6d2TenOxsvTGQM5m9wu1y6WmwWAORGqoXFTAVkqzA3MpTifBZFKtVwW7QL0+imJcnlwLh+UIJhLRPSS/xlVR91bm+GbKqMxmx16IfrVD02fxRJru1HdqIMl84lGhMQ5ULCT8YGfVaz0cIdcyzc6UaHq+FSrFa0Ay++dW06cNvCM0q0c+pOeyREouKV0YdoabTzPLaNYI+7sBIqlaz/fsz/CWW6kMBGrVINdOnrC7K5tPLTvGF4REN9PWU0l1suG1/GAEcXjWCVXomVjhmEAlu+dQI5fK+tmqXOja2ajmYRD1pWf7xyoBcj+IKysf1xL1MLJYbJNFYdzMiamT34GNwHZH5kh51Vi7zaI/qutN6j1YiaiifPTRTzw7Y4aHoQDBYEbvsGxVJFgUKcHuhUqi5QBeCwf0m4e+mXKjT2hm+IEc6dFndqSnyl8qk4WkWeWl+Femf8oziac4UI6+bVLs2nGcsKWVTUyF+lnxqBPOTVrcjAAufBc6HGxkdq9VindSj9RfzmzGKKyM6pd6OG9qvjERraWXO3Zy5M2PGgeMYI+LEPF4BIeqGi2fA5MeDvpP8/GTnzcmt6dWI9w6JMdSbIj3WhNhtUmH2seOH8bSPlzF9bt0osEhwhgQL2QYatIdADanTk+CTzGhxPxeQt3nNSgFLlb4jA7IPWNJganhkBmWbb6CDEy7n460b0EIIs3AHPf/6Igw0MEvNP4G2Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(356005)(83380400001)(8936002)(2616005)(36756003)(5660300002)(426003)(7636003)(336012)(47076005)(8676002)(36860700001)(6666004)(86362001)(82310400003)(82740400003)(26005)(110136005)(186003)(478600001)(4326008)(70206006)(70586007)(4744005)(316002)(1076003)(36906005)(107886003)(2906002)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:52:38.8648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d3c98d-d840-48f6-2289-08d94a8a2e24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
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
index e179c7c7622c..d5934c2e5a89 100644
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
