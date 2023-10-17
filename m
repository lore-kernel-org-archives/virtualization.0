Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB14CDB483
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 13:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C831C416F2;
	Tue, 17 Oct 2023 13:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C831C416F2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D/XTlSNd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTn8Wip1eNzI; Tue, 17 Oct 2023 13:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D59E641719;
	Tue, 17 Oct 2023 13:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D59E641719
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA3F9C0072;
	Tue, 17 Oct 2023 13:43:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE620C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA65040A78
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:43:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA65040A78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4todn0622hfh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:43:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DDAF416D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:43:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DDAF416D6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK6UEODU6iKJvNmHY+9uFeEIru0mP37xj6bh5neNX1zYyXWjYJuQc8vVDBdiIdG9Tvm7ZxrOYWDFL6+XSGma3XlYqirr1Hij8OLiG+p5nVkqJo9HPURxubdXjpS7fu44Rhr3all7S2pFJMFTtz6EH9f2R0nTGX5EkwYk0/bOWkwBe+NJSRiFa/R8KJ8AJ3V1yHJ/vGrqHfRtcaU8/zZRKssuZKhvBGSPjbv7d3wlfYo07wFYXkUKDxNh1osfXeHdykmJbghkU19IuQrkSAMbtw8fFbBGB2kdTy86+cJG/PtOeUJmChzLrcwoEfKbgzzRmN0vo5nyCor6b+L/nGaW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ueIy9hp+yuSDFUn+Cwq4VZ9wxfooOvfEfsfqTWEOdw=;
 b=V7He+MqMZMsPS3onkDXAv1wH2grmEuN7UfHrTtTIjxekEjVZ7mpFirEWKRI4GiiXsUxy9lFJ843COtGCLZzJP8EMdnY99L0QHzH0jo8OWiCsld4JcU4QU7Z2loPUa0hK06P++27TtJijDeMnASEg49+7zFcg0jDxVAbE5L0g4oqofNZR3kgKuxiYEdYM0D++mF/+6dHJ+UapziU5nDckPRda6zKUZ+mXXzoDSaEQSu8FB7tc6hsL4XbuUcChzhFiU5Wn3ChXI1PsK98uyEUGItWtlcCo0JX4tRPKKWR305Phff8JZvWLYxEJx0xRwBuOpEkuwf/MsfmAEw7/dgVWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ueIy9hp+yuSDFUn+Cwq4VZ9wxfooOvfEfsfqTWEOdw=;
 b=D/XTlSNdfHFS+2aitWUPZaXmyHo1gnJRL2joTRwMS6OEBzLmtwk3fmEmBh46sqPHKVobWmqFKSOjO1Qfyw0sjhznEUW7W3YOKA0IOxDeW0VxsDbOUp88UTKE4Q59Egv2lXPuWvWWebhaa1gkhTCdrl2fZesAKtVzTDPv8WBWzYnCXYhd7e3PXseGsn9vLxUsfO7NCLh6IoF//dt6k6mbdcIWGfzvBac59TDeZufXhgIFvjooypJi+4uPgb1uH0Lz3UnAp/JQkshzy4WqkKLeIICjR1s9YKtydsvapKHpY4/WV9UtscvK68S6MNxJwC5m7SdOZM60ZVic+LcsCPbXcA==
Received: from SA0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:806:130::13)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 13:43:32 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::fb) by SA0PR13CA0008.outlook.office365.com
 (2603:10b6:806:130::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 13:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 13:43:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 06:43:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 06:43:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport;
 Tue, 17 Oct 2023 06:43:10 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH V1 vfio 8/9] vfio/pci: Expose vfio_pci_iowrite/read##size()
Date: Tue, 17 Oct 2023 16:42:16 +0300
Message-ID: <20231017134217.82497-9-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231017134217.82497-1-yishaih@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: fe720352-7dab-450d-08b4-08dbcf170dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzyYS0fZWDn0wWvaN5pP3ItCxewfXXZDFAcNapxF/GA85eXKWaoOAZsFw3GJgK8KM+uOGrj1n58LKHilVLYnr6D4cfk7TP8iAmDYqvprF7e6v8Tk5RiC9rygUVG7XGPSpqjskBD0mDRhp/Elqleh6G7hlhxtRJkc2Qbmi2WhvB+LbfZP3aIcbuyBvt2D3MoAn+Lyt9q5qGYV9N6lN33xzmayY1LGqgaFPC6HpBblTVE2fyM2KwU4KZcOxjnhCc/r5P19p8PNKE2CtXq5qPn7lnKhfSxG0pqbSEA+e4ZdIAAQtqbvkyCvg3NeW5RAefD/IZm57cdw2br+2ryZt0Xc9Ohw9lf2VF/jXWCAIXKmmt5B4qO7/llsvBWvexNHiyY/w72JSwWVz96n+FgJb6FdTrg33hzK2oEfA9NLr1Zre6qKq6FHcaks4Ii7Dl/BYMNhWnS4usOToJUbT7iKBj5rxDdxQ3i3eFvHFh8MPurXNyzacFgk00gAY1W/xiEoFwas2GDDG9dUh2BCueuWaqRbxdXkPA4EJI3OrDvYSvOjvn++TlWMeeWfqfuS6a/MaQiRb1Ltbpl1WJ6u7jD3jGDThqlExK9fmjJwHKURw0kzuFUzYnUl6VsbN3TN1iZ+XC/PztIMAXu9NIztv5ATmRy4E59TudEoRNCx92zrTvXhHZsqc39RAnaqeCGFCu/HpeFUC79afERdaIBdPhQERaGzrL2PE7Yg4crMDPNZrGZnBT+izGWGZTvt2UTCTcVKEm/PWrVGQIgerlkcEjqJf55Olw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(336012)(40480700001)(40460700003)(82740400003)(36756003)(356005)(47076005)(83380400001)(36860700001)(7636003)(26005)(7696005)(2906002)(54906003)(316002)(6636002)(70206006)(1076003)(426003)(2616005)(70586007)(478600001)(107886003)(110136005)(86362001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:43:32.3643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe720352-7dab-450d-08b4-08dbcf170dc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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
From: Yishai Hadas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Expose vfio_pci_iowrite/read##size() to let it be used by drivers.

This functionality is needed to enable direct access to some physical
BAR of the device with the proper locks/checks in place.

The next patches from this series will use this functionality on a data
path flow when a direct access to the BAR is needed.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 10 ++++++----
 include/linux/vfio_pci_core.h    | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 6f08b3ecbb89..817ec9a89123 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -38,7 +38,7 @@
 #define vfio_iowrite8	iowrite8
 
 #define VFIO_IOWRITE(size) \
-static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
+int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
 			bool test_mem, u##size val, void __iomem *io)	\
 {									\
 	if (test_mem) {							\
@@ -55,7 +55,8 @@ static int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
 		up_read(&vdev->memory_lock);				\
 									\
 	return 0;							\
-}
+}									\
+EXPORT_SYMBOL_GPL(vfio_pci_iowrite##size);
 
 VFIO_IOWRITE(8)
 VFIO_IOWRITE(16)
@@ -65,7 +66,7 @@ VFIO_IOWRITE(64)
 #endif
 
 #define VFIO_IOREAD(size) \
-static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
+int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
 			bool test_mem, u##size *val, void __iomem *io)	\
 {									\
 	if (test_mem) {							\
@@ -82,7 +83,8 @@ static int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
 		up_read(&vdev->memory_lock);				\
 									\
 	return 0;							\
-}
+}									\
+EXPORT_SYMBOL_GPL(vfio_pci_ioread##size);
 
 VFIO_IOREAD(8)
 VFIO_IOREAD(16)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 67ac58e20e1d..22c915317788 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -131,4 +131,23 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 
+#define VFIO_IOWRITE_DECLATION(size) \
+int vfio_pci_iowrite##size(struct vfio_pci_core_device *vdev,		\
+			bool test_mem, u##size val, void __iomem *io);
+
+VFIO_IOWRITE_DECLATION(8)
+VFIO_IOWRITE_DECLATION(16)
+VFIO_IOWRITE_DECLATION(32)
+#ifdef iowrite64
+VFIO_IOWRITE_DECLATION(64)
+#endif
+
+#define VFIO_IOREAD_DECLATION(size) \
+int vfio_pci_ioread##size(struct vfio_pci_core_device *vdev,		\
+			bool test_mem, u##size *val, void __iomem *io);
+
+VFIO_IOREAD_DECLATION(8)
+VFIO_IOREAD_DECLATION(16)
+VFIO_IOREAD_DECLATION(32)
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
