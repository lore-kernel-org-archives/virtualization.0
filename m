Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A4C636CA
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B976120C
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B976120C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B89B2826D5;
	Wed, 21 Jul 2021 14:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLEZbYogBvaz; Wed, 21 Jul 2021 14:27:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C4D6801EA;
	Wed, 21 Jul 2021 14:27:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C41C0010;
	Wed, 21 Jul 2021 14:27:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26312C0022
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5FD183126
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LxmjtBKUoYMu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31FCF830C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/h1azLyg/XK+hbvDbIpHEEqEimUd7CGrmGm3MKqj4kP6ylXJVFFfalbdmQB5Nuookv1amt6D9mMM5fopvesmR22aNCVqU3l036Y5RsAdTueA5guoUA++sPaqwOTY8Rf80tJeCfhzfnEw4ExH19391j2r9IsrDP7HdISeT4B2ThTTz8l5xGWo4B6wZSbd8oXAIyBS5IJluW+RDPH0XRa/eopPTt5H5tm7G1LCaQrrQOOOtFjnBvpAdl+Xg6NCfzrz3uRm7Op5WnGghl/86f5LctS/2Uh9ZX2FRSK8gXejvAWraRh2Jh2ulHqXMsbLlOZAI/mWkHFP+Cp7FwTb7CmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPLg6HV1FDjY6d0jnN3qhdMWR0Ny0/qx0PiF7upXIw=;
 b=EeTBu89ycK8U4NopjrKrxsZWhLbt6JkUch51dh6AH2U8Ny+dR5CVms3lHgnT7FEHKCcxbG63MD59Y2o128MqmD9GcokCgmeV4vf9/7p8Nm1b5dLCUZ9VYqQnfD6lr+PQwht6tVkirQ7tmezZQaLCrq9OznlUO0YOWetx4BQUfdIF8/7jloSMLuJRlqoKnGwOqaN4IMqjF4upivo1w8PdNLRgdsd/cHFtGSIIPAXlE3YD4KJy9COLjH9/nK9eb41k8LBs2inDM16nJLNmUbcx5Bdj2Cm0u5UJ09AwzQaDPN6wRXr7M5+B74l0BFX9iJlaU3m+gsoZQJpBNHp313YW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRPLg6HV1FDjY6d0jnN3qhdMWR0Ny0/qx0PiF7upXIw=;
 b=HKaH55QHV5G+v3m4ik15rbF3fPaTHZm8doWg00afFPhMSCcxnSQ4lUAyFQ+3SP6ucvVySr+vgwSy+ed6T83wJrIyHhmpw9xUqEUMBKHQDy+YUtIL8CfX46wamOhbKfMupBtu9H0vYN3B/LJ2zVNa3VHcpQZOf8yKwPxdcXbJuLj6Pb1jv1tLvqecBZhFGj8VhfZIG8Kma9EZD9gye8ySCy8BG8Xj70hNfyxaufs9kTjc93JFhkN5VSAR7X481Bs6pwPQxD7NGj0lQl306G9wj2bADnA8XKy5+JUZTnnfpcW7/hXIxsmcIRoClFSNadwj6ge+42RLdJNGDnmYMbpDGA==
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by CY4PR12MB1541.namprd12.prod.outlook.com (2603:10b6:910:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 14:27:21 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::50) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 21 Jul 2021 14:27:21 +0000
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
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 14:27:20 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 21 Jul 2021 14:27:19 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 3/4] virtio: Protect vqs list access
Date: Wed, 21 Jul 2021 17:26:47 +0300
Message-ID: <20210721142648.1525924-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721142648.1525924-1-parav@nvidia.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87feb28b-ed33-49b1-42a9-08d94c53a692
X-MS-TrafficTypeDiagnostic: CY4PR12MB1541:
X-Microsoft-Antispam-PRVS: <CY4PR12MB154199054C87E0EE336DB70EDCE39@CY4PR12MB1541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bGu8aD9+/CByjyHIDo9cMgRw/epWEAeZGUNOUCPySgdALbMYlWcI4e3thuv0ykp7vQbIzEZp6wDo47DAs2y2ksT1BFHD7hEyj3DPRr5avaTycOu2YXM8bd30lwjJST503ebS8SAMSMiBrfx1OlJplUeBKzWEcga64Lcv4zciGuQgeVqyVz3gJcskSSSbUY9nMQakPH4fKKvER9Pi2tVsUUkk/xTh5ZmkxmlPB28hrra0wyjHnTrahbaUdjLwDYah1YeQp8+TCPiWoJYx1z+AdpPO1BKRr7EpPzVgAMBu4pW2DjrbHDPlnW9+FW28MZL447wWsv39GBtnFMxX9rJ/itauOwdu2fUjsbO83fiGatuv7IZqgDRzZqlUFSAIqXULPA7RZrE2HCZ4OFpFHYF1VhPuvqLi7VagBECzQcN0E9GWELLtn24Ij3pB9zPbBZ+bZtTezRXDNQcsPKdq7LA8zOFjrhl5yx4j5rBPmuBvmmR+Rf0V/78VcZCXk0T4s+kk7WJNv/rOKBe0skDE7fV6FBpuftpziM5rnScOfQnOCDqtgcJop6bLSz32wnWow3fe8yuVFQ7qCEVbziE0rqFFWtH9Tbp/AQnymCd6GmXieXUnGDtcmbyIjSCIc9cArg/gQn7hA0JSL7i4scc56gBbgfT4JFncee+cVd0xPJkMMT6sOxdGAA5Qw1tPy3Ar5Os5f+Lm/3psaKBecR8WHN2lw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(36840700001)(107886003)(8676002)(426003)(6666004)(478600001)(110136005)(36906005)(2906002)(70586007)(8936002)(1076003)(316002)(5660300002)(336012)(36756003)(4326008)(83380400001)(16526019)(186003)(26005)(2616005)(86362001)(356005)(7636003)(70206006)(82310400003)(36860700001)(47076005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:27:20.9166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87feb28b-ed33-49b1-42a9-08d94c53a692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1541
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
