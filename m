Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DCC12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E4B61181
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E4B61181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA1DF6077C;
	Mon, 19 Jul 2021 07:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XACYY-ln0bvw; Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4604660632;
	Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E574C001A;
	Mon, 19 Jul 2021 07:52:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6B1EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4E344024C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3BNlbvnDfrW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E14C540247
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 07:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+TkAr0K7sXXH6EDd6jvyUFdzkX4Ti46lfXborMKFVhqEPNy9+O2bC6qIFLm0pWkput0VD9Ebrqevet9vy5BEkJyR8c3baceB6nr+uzWdhqNAh+w9r53g3lCILpPJYNKFPvuk0bUcuDM2C0ZX9aFBxoPE33isZQYE6+wf6IodZqSToD/cvPbA4GjS4GFstrj+8pyYHpC/7g6/MtbDNZ8xmPf9e/7X3IzcJJQH08RFKYLR7PaDDdcd1h2gslCs72Bk4mqCXsl81yUjyoBt7bNzlNf0I1N27DahvBaTDw/n1m8ah7/UKB5a99xAy5czqCIykI44TS1KQe46RCQnZHJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRrb9LCMb7ftbjVxuYJgf1xDPy4Zz0SL4O1JSBaud8M=;
 b=OHUoyP3zGwlS8o39lbIN8Y/mbPhR4V1LeBY0W2tK1HYEuk5Rxu6y+eOx148Ds72YqDkSyf5x4MyoV2CzqPmqiiPjF29Cp/KYIdZ9EkHTbLbR9zBztkacb9yQAoxjmyqQF53SPz49EN2vRIfGO952VbdblyPnxvIFX9ZFyVvRav8O7rZ5O50zmFEEb+V1s8OXDqAvImdsohhS4qJfO0qyQuptHQk4wdnjYEgjJC0RD4/11DGk4awdA+vYzAxR5Us3lHN0cG05PmoIcEBjkvNW34AjhTog7cu2jeJSMZmUL9Kl1FZb5FWizKDERBgS27PH/Evpwaukq7xxIeVepVk3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRrb9LCMb7ftbjVxuYJgf1xDPy4Zz0SL4O1JSBaud8M=;
 b=Tj9BKiRFHodOJ76hbYMcDrYncc7JvwKvEBoOL0RmZxwyooqkZqCZpUMdpB3i7jr5+xat5idhXxHLrznQKoFKt03nQiAhOyRBMgnQGFyjyOHIKvBFQ7p/+K1iy6CcmJMG/A2t6YiMDVuedeQV72cVtWHuQaTzY7TGpMdyGfGNTS0AWlPguHyuB880jpXyT6Oa394Quz3OypNnrE8G/16DpPf/u+rBoSY/64fngjgBDo7UmIoAMlaNLV8HXIYuwbTbL+9/LjDwXfvqC2nzI0uD5gbnBDYdA92mttuEY1fC9rfHyKR1JRfYKzQ4CCJZiOPc2hWwBuEF9SGKw/U3kFphJQ==
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 07:52:39 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ec) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.15 via Frontend
 Transport; Mon, 19 Jul 2021 07:52:39 +0000
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
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:52:39 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 07:52:36 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 3/4] virtio: Protect vqs list access
Date: Mon, 19 Jul 2021 10:52:17 +0300
Message-ID: <20210719075218.1485812-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719075218.1485812-1-parav@nvidia.com>
References: <20210719075218.1485812-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c98cee37-8ca0-4a34-f37b-08d94a8a2e98
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4000E573701FE8A4CC215063DCE19@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjGLd4ugYUUtndow/Aqj4UojEWGcv2xqWvLhLQp8Ub+8sYqiTlrBdGd41xS/4BMW/SLQdALiJG+IIWnn3Yj9Y7bb6GiiPQdWZP6XWNE+uVdyyVX82UCDyTQtWdDdcNe7fAHlQEE4aH4LYRkrvMKspKGAgnSy+aI+2QN31oP6aq4aicvvxCTJ7Pl9vrl2Fc8oriC02rRc3s2/rPMa3P6ZQXj/iIdZDZ/ERPuaSy9RR62OXXDuF4eIrmbSZiJ9nboRv7IIxJWC/XzvT/exDARCBLw15vrzl3Ng/uVzIYxNRLuC/DU6KknNEEMBEFxO1ERpIcK5dqFDxJHefYZs2toCBD2Gt4GnxQoL3wXKXCke1udHAsP6i+KrKwJcnDd5/k9cY+OOrnaSrjp8kBS86m8J+xSnIiwDHBuXVrhQc2XzsHS92EntViWPnHabbahL0oF9vPTrErJEsXl9rJuyt9aRipZLQevmg2ySYHx+bgVq7Gxl2jr+CGH/XXxjzcrUt2Y+7ipAa1ulowtGRd6JDee0RiCA9bSc4Z38S8gPkVNL0NUW9WGDa+a/WtaAgu9EhCZ78IN48U1hZcFJYnJrggBYqIN4kPmUKJD6ymRF33JAOXH0u4KwNW5ATTW85JsO3kPXFunWAueSIG5DiQjbWApDGJxKdfF8oKF7KkWXiaxmwq57jPvZsTVCKwFALTTkb6fTPADZlrQcHAy1sltLjm4WqQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(186003)(8936002)(86362001)(36860700001)(4326008)(83380400001)(6666004)(26005)(356005)(2906002)(107886003)(36756003)(426003)(5660300002)(70206006)(82310400003)(2616005)(8676002)(110136005)(316002)(36906005)(1076003)(7636003)(70586007)(508600001)(336012)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:52:39.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98cee37-8ca0-4a34-f37b-08d94a8a2e98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
changelog:
v0->v1:
 - use spinlock instead of rwlock
---
 drivers/virtio/virtio.c      | 1 +
 drivers/virtio/virtio_ring.c | 8 ++++++++
 include/linux/virtio.h       | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..49984d2cba24 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -355,6 +355,7 @@ int register_virtio_device(struct virtio_device *dev)
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
 	INIT_LIST_HEAD(&dev->vqs);
+	spin_lock_init(&dev->vqs_list_lock);
 
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d5934c2e5a89..c2aaa0eff6df 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1755,7 +1755,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
 
+	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
 err_desc_extra:
@@ -2229,7 +2231,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	memset(vq->split.desc_state, 0, vring.num *
 			sizeof(struct vring_desc_state_split));
 
+	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
 err_extra:
@@ -2291,7 +2295,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	spin_lock(&vq->vq.vdev->vqs_list_lock);
 	list_del(&_vq->list);
+	spin_unlock(&vq->vq.vdev->vqs_list_lock);
 
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
@@ -2386,12 +2392,14 @@ void virtio_break_device(struct virtio_device *dev)
 {
 	struct virtqueue *_vq;
 
+	spin_lock(&dev->vqs_list_lock);
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
 
 		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
 		WRITE_ONCE(vq->broken, true);
 	}
+	spin_unlock(&dev->vqs_list_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..e6cda4137e7b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,6 +115,7 @@ struct virtio_device {
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
 	struct list_head vqs;
+	spinlock_t vqs_list_lock; /* Protects VQs list access */
 	u64 features;
 	void *priv;
 };
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
