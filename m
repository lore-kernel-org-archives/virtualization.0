Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61222C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3126121F
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3126121F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC8566075E;
	Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJNp3eYTnQpP; Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42523605D5;
	Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A366C0010;
	Wed, 21 Jul 2021 14:27:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD47C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D79482FF9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hp3rPhb_8KRg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C54482C4D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuIXa0iSKUygoNP5/jCd54IiJCP2A9IvdHb7u9sikLV+PKjcFeeAbJ9QNvVqda1ki+wHsTJ/qnYKDEBL856onVLChmuL8f+RG7ZuoUiy8+zewKYXAxk0SDkQcI1GZSS5x0usAsnC0C0JAT8dSxN50H/TNhhVXiLCtQ4bvdBTa80dq5hM1R/3G4N1Fnu0Z0HzIRE+vEbB6GX9dFi9Vt2rtHQDTsylVkSF6pmtH5TTtDrC9JR6Dqp1CYFZZFcQAe2m0uEna0szTnMjefnXLdpvaacjDOpVxDK/cBzsW7sQ7Sy5C8XV7gC6RLMy8PW+4hPtLK55CM9d9ILHqDgcceFpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+mI6vAhk5Aev+QAPfnfK+IxssZN2klYMm8KtwrNzyM=;
 b=nVs4l+FtghbZgygmSDgeE4rnOOCLeCp7ht7q/ijLBb7T1B8+xma2MM5Qxoq8m5ItQBD/2boawA7BJdqza4UvaX/YtmuVznEqkFqN6bpQ653prumASB5FCAqEi5Re2qaDtp+UKoEXRgSrp/Qhqjf6oSVtD9JnUYaUUubY9O7Gorg6tFcv5Qm63XyMqCf9+MEYWrWteZMXy2qcreA1zC+QkZMr25F+GVFe1yYW+gE3J7fkyTL3LOGsel+XGuXiGweDp7wgWKy5VBwRmEEbCnvzFzXKK3GFKxpebSfXXDTO4FD77o2N5y8Bhh4B9eCi4vDAW9urx1cdHz3iZmjgRwuVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+mI6vAhk5Aev+QAPfnfK+IxssZN2klYMm8KtwrNzyM=;
 b=l4hWv9b4i0DGAz/6NycVjTNi7UAjzS6MJpp6RlhxN16/wUlWuR9Z9VG0ENqmVwFkJ7gKa4O+ZDxVgSwjLZ/0TnHr8XiItsDsP4YOqwwFrzQsT/tPkd4HXWGoPD/Unhnil4drLPNCgCrhQ+RzTRHmbyOwHwFxE3PkjZk+w9zq2G9yPpJJDy90HW+8iBWCiHZILHOO0Hx2fUXxiBdT1AUAzbScifHBD0/gROVLaOSrjvPFmQbtWh/J1oM2f/OnMSc3o8q+8JzB0lFBtQhKL7p4REjTl3o6TFTarq+CIhEcwq/EeP2Z4VkWxzoxfE4CjqcXuXwUU9f64LLDPu6yhUEFKQ==
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 14:27:19 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::3) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
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
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 14:27:18 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 21 Jul 2021 14:27:17 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 0/4] virtio short improvements
Date: Wed, 21 Jul 2021 17:26:44 +0300
Message-ID: <20210721142648.1525924-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47cc289d-8bd2-4a72-6ff4-08d94c53a544
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5546A20C093A7CB1AE157DB2DCE39@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs8VWfrMjRtWzriEpORHozASqS+0OiHCIQiFZdSc3bmRefv1tRzpZ78KydPS2gd5XK1fbozKcyt6QYRwuwA0vAleRv2NfmGDiHvYMN13996TpNCEm4zymDC1Y4oFp5uj+UT1uTzMXTZIE1wnelygwyOJBt9eg/W8CqpMtjrFmegY7sS+YkpuclsGS2D5rhT6wxu28jcTE/NyNmSyGF74KeI3nBoeFIpj6ADRATg4bAUEVcnSpSuG1oPvJMiDzYJrUCdEGZpI2QBtOKv2NhTF5g2MsCxsLIlwYTLl7OxG0DpbvnUCUDZtoJ5pK1UkQn6NnuB+/fYUzFzsf/14zY4ZtGHGipRQjc0brtPN0N/URnCz/JhLzIJVqdM8Z0i/RdH81Jfbp8yBDjXOVgORKUqPIC7cwezPYDXf2J5nMRwzDoTd8W8k70Ybmw19wEzyE33FAyQuwt9Mux0Fud+LEysEz0xAgP0yQcyHk+kF3Dqxq6prdy2SPWIurFsqJYiPRo9FjGVykp1lB59VasRl7t0IdteqKoS+fQ4CnGl8/SkdyvczdO9iDgPWgS4tWL6MCU+D5dm7QaW3s+rW+Wjvrsor3aaaRzuljFkvkcdX7vxE7xnS/iurA7Bu1m3DRfG5ktc4hRvjKK9J/hU9B0NknF0xnk1sA2DFFedAGTZSIYisx7jPri4MDVQQpFZAzeiCewzreiH/E6QBf15lW2HjoveQaQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(478600001)(1076003)(110136005)(36860700001)(4326008)(70206006)(5660300002)(316002)(82740400003)(86362001)(2616005)(336012)(82310400003)(6666004)(426003)(36756003)(70586007)(26005)(8936002)(16526019)(107886003)(36906005)(356005)(7636003)(83380400001)(2906002)(47076005)(8676002)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:27:18.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cc289d-8bd2-4a72-6ff4-08d94c53a544
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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

Hi,

This series contains small improvements for virtio pci driver.
The main idea is to support surprise removal of virtio pci device when
the driver is already loaded. Future patches will further improve other
areas of hotplug.

Patches 1 to 3 prepare the code to handle surprise removal by marking
the device as broken in patch-4.

Patch summary:
patch-1: ensures that compiler optimization doesn't occur on vq->broken
         flag
patch-2: maintains the mirror sequence on VQ delete and VQ create
patch-3: protects vqs list for simultaneous access from reader and a writer
patch-4: handles surprise removal of virtio pci device which avoids
         call trace and system lockup

---
changelog:
v2->v3:
 - updated commit message to mention that patch-1 is theoretical fix
v1->v2:
 - updated commit log for WRITE_ONCE usage
 - improved vqs protection patch-3 for using natural structure alignment
v0->v1:
 - fixed below comments from Michael
 - fixed typo in patch4 in comment
 - using WRITE_ONCE instead of smp_store_release()
 - using spinlock instead of rwlock
 - improved comment in patch
 - removed fixes tag in patch-1


Parav Pandit (4):
  virtio: Improve vq->broken access to avoid any compiler optimization
  virtio: Keep vring_del_virtqueue() mirror of VQ create
  virtio: Protect vqs list access
  virtio_pci: Support surprise removal of virtio pci device

 drivers/virtio/virtio.c            |  1 +
 drivers/virtio/virtio_pci_common.c |  7 +++++++
 drivers/virtio/virtio_ring.c       | 17 ++++++++++++++---
 include/linux/virtio.h             |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
