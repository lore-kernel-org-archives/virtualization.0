Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9231C636C9
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9704661396
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9704661396
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67307401D3;
	Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIxze0XBmq6t; Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D3518400CF;
	Sat, 17 Jul 2021 07:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4BEAC001A;
	Sat, 17 Jul 2021 07:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5679CC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37757405C8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlaTSG10A4iF
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7308F422A9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAYL3VwEukovzJphW7xZXPskFnUUXVv6B86JEGHCdrYu2ve6fsO79mcD8wPd7EaxAObxS/7y1L1EwdzR7NLY9xN8Qmmqt5PEHRWmzSgAOXZ6ofPCPuTBTAVh8lhI8mGxd0GDk8qZSBxU+uE76E1fGOIMepQX7NG8T8kKaavPSyYx3SANbshhsdDe+KBwGpsf6uPdMyEKVZCcudoKfKDpxuGx1c8nAC7XIh5Or2XvM6crwz8ZUn7A8mlKa7xz3T3JOnL58iNIRQLhR2bM8IIXulWzJvbFHpwoRQlA2k0FOsqg62DtCLCm+LHCfHF6nMyXs4pjVb9jAxup/3wifPkemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6ldX+tyVv+nLELFWVCZ/DclhxYb/gKaH409XfGStrM=;
 b=bLA55QBZth24/HSvaTwX5uabl/QrDAUAvKa7NBdL++gHOyzNY9kYqvKvHjJmuNShtE5DZyLIFxk3Oevk4FmuerHHijQJDMedbwAwDDlXvEGUR9rYjmgHU77Dzl0lz0KtecjJ+VS4m7expqRz4+elTi/fN+hzoI+ntYl7v4v4KO49OeEXg/cHxZikU4IFTdQH9rshODg1K4wdZBeMFxlHp6McwB2kjBzNy5miglm6clrmcH6BrVZuxk5CHJ9Jqfi72nkBIMxob1gWh/LpjFXKahOnDPO7IJfPANGL20wjMLnR+T3GCEUhKN4f847/51gyUU0Ev3tMkhDxR99V8i6TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6ldX+tyVv+nLELFWVCZ/DclhxYb/gKaH409XfGStrM=;
 b=JD+NOyN1mKaWtHEign9BwjO1znkfr0YluhLfB2IOjqyo/T3BCxhUZtlaBt8pj2fnB0CQTnsnmY+XTLOqpqA4noSrfYeKeWYVjfWI792lIRCb9qfSbU7spCO5AOHNH3ngAH4Qae30ja0Gkdbyju+d5NRAMXCt04Oe4u+mWCPbMW2dZy9WWVO2iw/GbJDJ5Wd56ZCtoOVFebpMiy1T3UNOw7rY6nkZSblPG1C7FfMfydOLcbUtWKSV4WQmVYloYSukqNRNsST1gaZOZxQLVoeoRRbmwP6aC3CVNLymyZJdSakt9+a7MOaWo9pQcXZ0eoHr1wL9MBIUYwxEXtj7gv4uoA==
Received: from MWHPR22CA0065.namprd22.prod.outlook.com (2603:10b6:300:12a::27)
 by BYAPR12MB3400.namprd12.prod.outlook.com (2603:10b6:a03:da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Sat, 17 Jul
 2021 07:43:15 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::95) by MWHPR22CA0065.outlook.office365.com
 (2603:10b6:300:12a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Sat, 17 Jul 2021 07:43:15 +0000
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
Subject: [PATCH 3/4] virtio: Protect vqs list access
Date: Sat, 17 Jul 2021 10:42:57 +0300
Message-ID: <20210717074258.1463313-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210717074258.1463313-1-parav@nvidia.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c257ad-892e-4ae5-9cf1-08d948f68924
X-MS-TrafficTypeDiagnostic: BYAPR12MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34003116DDC2E92F51ED739ADC109@BYAPR12MB3400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v5foTeh90h206jep0SKZ1fKzHRPRcBRJ6CpGo89O5U02OHsSajV7alPyGs0AVC8LRY+WGwZD+xjiUF9K/BqkbU9H2NZ5g1Put+nH/GXANFZxQd9os7tbKd4T6koJVBi9+owyuXp0T49LgXqLxTjdoUaQ2iMlp7X1PKKB2pEikjTXG4zl8K/6l/PEFXdXTHtmD/scNl9t48CZ5pmJGeMHwQvbBaIC3+TzEcNB2/0yc9FIHaXAe8XVNhKh6uyOcnJ13PIkHi62HaGQBhH9CPA81adoRnS1R6L2aq0V6bVtw7qqWgNZiKx5x69JLrojMZlla606B+v4edJTiXcK6b3+kV+Vidjy3S2PB89aAXjwBEgZR9iDs8otVirRdyrCpjs+ILbZm8qqee2Ko6TzV18VUoISl6xbnI5vMJKKvSL11V9tM3aWVopS7B9azwvu3AVmFZ9+9NjKkfd+tEeiQOWgwhZzGbR386UrpMAGLvrD+IfKwAbVoD1pNmgAmKTSNXHjUrEcDmxmYutUuJp3MhSbsVUcQoeAVJOh4h0kE0CW12qde+h9C5Pxv1Hkn8z3yn1fX4eqej2nf3V1dU2hXfZHcRi1syQinCJd5xMM8vr/4tRqgsKNcEeKgj29jGcqe3DO7ehxjTdPEvUL5o284/5nEJZrJA3wDPn5cz8ZS1GyUNN63YXurK8rHJJTIfdS55LZoho7Jqe7ow41H1kLMzEgJvzCePSYRDXEefvKFmZGUg=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(70206006)(70586007)(107886003)(186003)(86362001)(36756003)(4326008)(478600001)(2906002)(8936002)(8676002)(5660300002)(16526019)(82310400003)(36860700001)(1076003)(426003)(2616005)(47076005)(26005)(34020700004)(316002)(336012)(356005)(82740400003)(7636003)(36906005)(6666004)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 07:43:14.7379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c257ad-892e-4ae5-9cf1-08d948f68924
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
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

VQs may be accessed to mark the device broken while they are
created/destroyed. Hence protect the access to the vqs list.

Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all virtqueues broken.")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio.c      | 1 +
 drivers/virtio/virtio_ring.c | 8 ++++++++
 include/linux/virtio.h       | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..a0d81e35ec4b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -355,6 +355,7 @@ int register_virtio_device(struct virtio_device *dev)
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
 	INIT_LIST_HEAD(&dev->vqs);
+	rwlock_init(&dev->vqs_list_lock);
 
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d2e1a7a21171..66a91dec39d9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1755,7 +1755,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
 
+	write_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
+	write_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
 err_desc_extra:
@@ -2229,7 +2231,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	memset(vq->split.desc_state, 0, vring.num *
 			sizeof(struct vring_desc_state_split));
 
+	write_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
+	write_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
 err_extra:
@@ -2291,7 +2295,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	write_lock(&vq->vq.vdev->vqs_list_lock);
 	list_del(&_vq->list);
+	write_unlock(&vq->vq.vdev->vqs_list_lock);
 
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
@@ -2386,12 +2392,14 @@ void virtio_break_device(struct virtio_device *dev)
 {
 	struct virtqueue *_vq;
 
+	read_lock(&dev->vqs_list_lock);
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
 		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
 		smp_store_release(&vq->broken, true);
 	}
+	read_unlock(&dev->vqs_list_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..1cf77d480ef3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,6 +115,7 @@ struct virtio_device {
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
 	struct list_head vqs;
+	rwlock_t vqs_list_lock;
 	u64 features;
 	void *priv;
 };
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
