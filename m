Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD62C636CE
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00D6610FB
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00D6610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0AEA402CE;
	Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvNA7W0aZEPK; Mon, 19 Jul 2021 10:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAED5402EF;
	Mon, 19 Jul 2021 10:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2DE0C002A;
	Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8260CC0010
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71EA54012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPbfNKctUchy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0031400C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdAfCkELPq6KiBtTqwv3bba0XRaj9UP+ZSTjcbh+LVy1OBOm+GLQ4M6mBmyY5sI71A+bXbDaAbUM+7t3f3+L92PMcuKI7jveRAjm25PpN5gF0hMuVTafXp1qbsJygAfoV8pCFHRuT7tiYAGtMu7eGGfRo/HC0NWKcs8ZaPY39JE6KBCcgNulUCv/GyfYVzHfFxXclBf7rDreK2zMIxPkqM24kA8ORTAGTKDFYbpPctVI01tTWhAm7seIz6pQSRlS7Yv71OYBFSkRo+u3LmNTSqyI7uA08VzP1SdwtA7Ru5ne1TcXSjo60TDyjJW4d13KoDcV1/PRHXHQJ0ogrVOndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPLg6HV1FDjY6d0jnN3qhdMWR0Ny0/qx0PiF7upXIw=;
 b=UjskiqEtK70HKU2HXwz7gbR/wy12CxLsBLv5xEZDoFjdECBgvupD46l/Aq1nvu5vnzmgDv4ixgkVV6zHbbNneCC0LJndZ4AZTdCq3brNxGhQY5GaIy/U90kesokZO3TyRSPGQw/wCTlYxfDG3QjKDPrAjCZDq61ZkrvE8pgPDsOmW7Og6jkyja15r7U2OmBiZbBDiubt8HkWm/Jf4ml01bIETcyCScM6iLARoh/QowajAUgtTKVPLU77Jp9ODj9NTS/D7Fao+4wkO9dNtLOOwqzofYFcC07sIHu27ENM9RmG2WWNak24KDNz/LOp8W6043hBI8mN9SCrE3iONDmXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPLg6HV1FDjY6d0jnN3qhdMWR0Ny0/qx0PiF7upXIw=;
 b=oA5Q45A1ealwh3c4cmgs5KLSAxqIJgdmoh+aHve6vpNnp/+aoV68t5k6bd7IFwHBsOIcL7fvvO0s6pEkK8QR1eExbI/vVVsC448mhHd931swaGhVJtYTCBExStGjgp4e6/12bb67xqbKAufK3ChKeUm/Cz9ALx4y4pW8tYaK2y7r9sFbBUcT4a6ulaCnct/d3HlTt1fumxG+Hca/3cUxW/fQsf7hqoBIv+fC1xzS9Zpv8rb9yZFnGL3RDEpCoaquEcuWxwU7YLsjS4H0IW1n5g+BwkBQruwwwpP4+IwqXjoVWVi9RXdMD64Hrs+3WJRnE6KSAWnyCqNgoo1fKhssMQ==
Received: from DM6PR11CA0034.namprd11.prod.outlook.com (2603:10b6:5:190::47)
 by CY4PR12MB1431.namprd12.prod.outlook.com (2603:10b6:903:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Mon, 19 Jul
 2021 10:38:57 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::bf) by DM6PR11CA0034.outlook.office365.com
 (2603:10b6:5:190::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 10:38:57 +0000
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
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:38:57 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 10:38:56 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 3/4] virtio: Protect vqs list access
Date: Mon, 19 Jul 2021 13:38:40 +0300
Message-ID: <20210719103841.1488049-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719103841.1488049-1-parav@nvidia.com>
References: <20210719103841.1488049-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ef9ce9-3f39-4cc6-622a-08d94aa169f7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1431:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1431FD38D1A0B195A515C6F5DCE19@CY4PR12MB1431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWMbsjJbovQ/R4Q+hRDaN/JYKdZ5XX447RTUzHBoSeSt5xHtBNIrqKclH3bGIKWJRDqWSAwPDxoa90HwZnE5kuTyqDOXbNxaS4k80c5h6P9EUhHeVdmWCpooGqzpnRweeQFyOjZ/fHHMzN/AWtkI0YNh/KoxluU/uINWqpZDvDSSRQwIBmUAYVGmpCCwCNXBTrWdNLfQu5cXEjOE3UjS+4AIWQ0qscWruEQ7xB3SFyxGiz7xZdkXM5OAkqgUv7/Y/JIZGnVMqRyaCxNdQCqumi/py5ngUD+6iDfUj9t6Rq7Y63Kc5AvAfPYBJgBmsFVeKeV7hAtMCGyopX903rXfUtbx4eTBH43sT4u2prIJl8CNiHeAVU5NXBD3mTjW8aDUQXzImhobxRD8lNT3QSpr6UlQNNv2YN+cw9WFlyswK5/doSAYH/TulxAP3r3XL3A7MIBlYhYPsTdbV8MygD4CUkrPbwhsGJM416myqllstj/7+XI62QuyfnG/U1G05/PtXGMBpLFKMO3oyfTmRrlGxZ4lDLmOppOb0Gxicfq6mkmYB3747vcWl9h4GVKsv/gZZhpnB+EPHsOFhoEXH9y/0fd3t+6itYzgPkIyCFgLgnO0MZ0wxQt7plVBY3/5qFeCQEvUIiyapOWuW3NzimH32lhTCJClPbLXYinXR/01/Nq5vqfQaY86N0QWfyINDL2t59Lq/ppQ7um/SNiIfR2h7g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(36860700001)(6666004)(70206006)(8936002)(316002)(110136005)(2906002)(26005)(83380400001)(107886003)(186003)(16526019)(36756003)(47076005)(82310400003)(336012)(70586007)(478600001)(7636003)(86362001)(4326008)(356005)(8676002)(5660300002)(82740400003)(1076003)(426003)(36906005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:38:57.6466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef9ce9-3f39-4cc6-622a-08d94aa169f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1431
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
v1->v2:
 - use the hole in current struct to place vqs_list_lock to have natural packing
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
index b1894e0323fa..41edbc01ffa4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -110,6 +110,7 @@ struct virtio_device {
 	bool config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
+	spinlock_t vqs_list_lock; /* Protects VQs list access */
 	struct device dev;
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
