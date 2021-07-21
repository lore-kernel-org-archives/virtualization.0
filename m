Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F8C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF37611C1
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF37611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2EE580034;
	Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9z7loO7029l; Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EC368308D;
	Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 736FBC0010;
	Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 112C6C0010
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7F2B404F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LTBXHAZWyxAM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE3C140238
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQEho5ao01zL5dkCG1muifuNbESoXWyBZxYZALDC5V7Tyo2C95mAAN33mnCQktx0YqPWblz7iYq9Y0zwTOxK2iuylg8BvaM3V8EDzXxUvXKxmjic9w+gp//szPxsl58bxQA7Ek8lC8vzBoPXe5jH/0/UnbsCeyt83qQ41Z9sNSyHoZ/BZiAflwmykv9qspLRROGYiercFajJ0eABOe9cdQhfCyhRnMN6olgOwhujsVVrXcg2a33/LcgC9qMF5CS6EE3eclHo+U0+g1HFuJ+9Ceb/+usL2aXwcNDkNy08ut2MDAhBRsXvxzbGGN3w6PThNZmCxYvKMHgFo6K3KC6drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU1llM+sJOdwKbxRUOxH+pM95DybvnrUlWHB6H7C5Mg=;
 b=Jv7gv1gudDj/9jlDxANCTMQYSqx72Iobk9Yomc1/XF+oXOa+ruIQ0YhnUNK4m5V0FdswwTaXNVNRt71c5+/1fGIpK5p/YS5p4VIZOB0APR+nbMd27x9TDb+iEtdtr31z1TK5wTFl1eDLL8XSKfRLl2f1w67cjFtDnK90Y025AQa6X7Dkx0nky8UuvhUquZjoLWm+JT169OAHyCj+3MwVJgJvtQHk0/LEETWYXk5v/0/wd3RYHQtycadVQWVyQBvt1WQhWWgu5JV+wZWwnilao6erFcMSebrXWGeNISWPG9bAXtdlWoD3nyggN2zEFXyaJ5emxWyT3Dh1hvyL86HW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU1llM+sJOdwKbxRUOxH+pM95DybvnrUlWHB6H7C5Mg=;
 b=WpPCF3wFxtZsI1NhTc4pWAQczcYW32wxtjCVQCbTc9VKeXu6bxfoBOLzY3sPZlzDR7yrb13aY7gBi2fXzLvxZP+ij4LEtzx7He3lBDBCnSgd1a9ECK9p+eRHnvEFaH+/0HMdEwhqj663SsA3eCeQ1qqSpl4EKhpn/faWcY62XCEzaHq5AISqHj/nUufC2NIcevUNLrGtK9t+ROO9bIR31Pteus81ejwKAypXm5f47Pdk3x7vnv3td0xkyO2IQB6olYblQ99HIVXW8PUndkogWf2QoRvuDLxrbYiX9Y1ULSy/FjMpaZMy0jG8PWaQQeVLzZQh3IpRNI7sC0fHI6EqWA==
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by MWHPR12MB1565.namprd12.prod.outlook.com (2603:10b6:301:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 14:27:19 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d2) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Wed, 21 Jul 2021 14:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 14:27:19 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 21 Jul 2021 14:27:18 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Date: Wed, 21 Jul 2021 17:26:45 +0300
Message-ID: <20210721142648.1525924-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721142648.1525924-1-parav@nvidia.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8abb0c9-04b7-46b0-ec2d-08d94c53a5d5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1565:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15656CDD3EBC2B831CA3EC44DCE39@MWHPR12MB1565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PVr+wAbv6sKDh5ocd258uYG9+3F1Y6mOFVjwJhWSxU0j0d9fgmFkeaTHYp9yMuywTIBU+SRRoUnyC+TeKMQ+yQ4If3TgNZRce1C7ewTfsTvyQEZgtmrjQabOcXauWN1GZ9c3G4ykj/Wd/yAlVzLikzZzhFFBc7RF2gV2oqPpp6rX2qn335cCrPZERLvgF7Bz1Heiacy+vMV+6GJJ9LJ5yEOaDljFlRuQZK+pu3MHRWtxHAw+Sjm40sD6bh0IyOe+raGBbPdu/MdCbCoZGNT42ECtPe/31+O/YPnfmqNkxC63aKa5oxCOUfrCxFnKoeYfi4hqt8frRvjB59XauSjOz2tnZXRshznwou93aUQjjEJSHQwvYQ9RO03gJE7DrAm2lCtQh5nYEgnX9VKpaQIEdC+swAXkrEb9H6ruxiRpCmJl3B5G+8RL2I9dAzFW1VQgf2QhfCl6wLtHGIvBHIc3BZkTYeSj9fyqtcnIOLJBo3WAv+fXfkn1DrUKLoaLTJsyiDwlLHj5LIfoTdLphbw9lt+UenPaPkQ+r1vae1layVLu8iiks8xSGaqTtOXBPuwuJakzsMyNVwG0dlRcxWylozI4jFJciSfDA2xOv+b0pGaZ+IQaJnrKPkzAIO2Ze9gRJRXl2vO0eSgg/6bV3FKOF/3nUO+1yNtuG1ZIc8BTyO8lBInZUGAUD2rG2p9z5rh6C5JTh7Hvu/pB7rnYmS34w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(83380400001)(47076005)(7636003)(316002)(356005)(6666004)(86362001)(508600001)(36860700001)(36906005)(5660300002)(36756003)(336012)(426003)(110136005)(8676002)(16526019)(8936002)(2906002)(70206006)(107886003)(70586007)(4326008)(1076003)(186003)(26005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:27:19.6883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8abb0c9-04b7-46b0-ec2d-08d94c53a5d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1565
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

It is a theoretical fix that isn't yet encountered in the field.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
 - updated commit log
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
