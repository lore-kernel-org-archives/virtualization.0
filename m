Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F489C4167B
	for <virtualization@archiver.kernel.org>; Sun, 29 Oct 2023 16:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B2A084F05;
	Sun, 29 Oct 2023 16:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B2A084F05
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z5thlLVT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eib9c134inTl; Sun, 29 Oct 2023 16:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7E5F8503B;
	Sun, 29 Oct 2023 16:01:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7E5F8503B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84EA7C0DD2;
	Sun, 29 Oct 2023 16:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E295CC0039
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA76C4340D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA76C4340D
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Z5thlLVT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLn1y1s-wH1n
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46EC543411
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46EC543411
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeSw4QCN355vpSLP4fHjaReiIPvTvKhhHgckIhELSnFMGNLJ4acvLM4AnGyqi4n5IZlSb8Spwe/1wLp9e5f0k/1VseMROLYcvY5cWfjfU/PQjBw9nwGbptXAMz46xMPHtQMl+8IXAUU+2zAqy42bJ7gXcGjsocPeFn6GMKtfYbdV9CkGACt4Lo5vj0VzLR6fzYDkfC8dbT6Tlxe2r/9p38+aorEbd+ZvG9itaCNGRwqK6aZZCBAZ4loZE1BVrcfuGcswyOxpNviORbfC+L265INK94o3zObg6A/8N87BpKRYckDzYXVzVGrVZU6WPCBQQigPy8MtDiPebLuOel7sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1eFzxJ/LjJHaZZ59rqE75yCcH0bNXHQfZmDKNhUSPI=;
 b=ExyWqaCMo0ZzRQjCCWqMIc3VLskZPjwj1eIBYGCyGJiSxuPWRg37xFkULJAO64TUrxegm5yDfKA0qphE3zCjQrp7YyefPEefop3Ht1LDpWPKAjP1m55Ko/8tJRc3wvuXcDgaKI9j+2PuqZowb7FNtNfH0xXdJl8+tg0NPKJ93ZbFiEzhi0b8vLsy2Q44TXN6kpAAZi7LMLtJmZckzVRX0zODr93NS+70ANUFeg00B/zGNTnhltkpcTmke1WWa4X/IzjzeYgNUR2kcYEOKHpPITglHNEBSc72bZtKI5tWXAATHHiqWbhhY/Y5etqVKrFSHyhV9ejWrfpggYh8khK1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1eFzxJ/LjJHaZZ59rqE75yCcH0bNXHQfZmDKNhUSPI=;
 b=Z5thlLVTKpKx+PMlBomOJIuCRLudaNQqk27gSuUszdUtBk0RD0S9eETRJ1iHFiIi8C90DcrsdFCUM010fOnLpU9sr6G0eLD92tYngZpYul2T/QWzXG6Uhcd/LS5VuKlr2hQijiAVrYPvgUKCA39lCJU497hOdWaxqB1a41ws78dafMQQp8XiXhlQcPHdRj1XHh2u8FFjGWOUcabQt0F4KfkxP8ywwx4G00WUQifu8/fF+Xp0naOE3EEp9bFz7Q4aNtJe7avTlFkvbjqFfbUtrl//mqZAjdOns5duIWVFAdW5Pi/WLzPtLsF9lbjlQcOcMTcsRNFtamlMHdZI8mvR2w==
Received: from BLAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:335::6)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Sun, 29 Oct
 2023 16:00:56 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::ba) by BLAPR05CA0025.outlook.office365.com
 (2603:10b6:208:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14 via Frontend
 Transport; Sun, 29 Oct 2023 16:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Sun, 29 Oct 2023 16:00:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 29 Oct
 2023 09:00:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 29 Oct 2023 09:00:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 29 Oct 2023 09:00:36 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH V2 vfio 7/9] vfio/pci: Expose vfio_pci_core_setup_barmap()
Date: Sun, 29 Oct 2023 17:59:50 +0200
Message-ID: <20231029155952.67686-8-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231029155952.67686-1-yishaih@nvidia.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb84758-70a5-41c5-ada1-08dbd8983c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brC4Fccaet0E0aZa7y/2XpprxbYE7vKUOOEb+SOL9+cmGt2Vh2tKlg1oBF2+gdyBuLTyzdzV/S8MN3dBWesPQeq3mRypVc1ou+tO0TRmDiBdWCRpkbL+oNsoxbYMw0DDUKTWAr+3+c4WN0zD7mJW1L3fXGtQfdJuB4GeOO5HlhkklZc+k+EiLGQ6hWOQaAqy4H6/ydmaJeNvPu2LgysYBUi1YVV9BG0Y+rGmhIXpqUAlB+FE50J2N76Ypl+mfXlXbmfD/MpTEdOvBfgJECUdPC2FJrldPw7st8/38UC5PR4LmD7aJP/Zhf9fUSlx3Df3pKGXXjJymjSPKOjEw26MMAAfh65BwE4d5GsBZbkip2o9bsMQhmyOttpj+4/pTNwld2S9Xi/yJRxXL9PbR8LOKi2ra+GZa8k6Ljo026S8z2VFBDzppqFe2bOUkvCc06mnA4HzI9mePysawVJlpLSXx+n9xT3HLdLCPhR+kSRoSa+RxaH3ADrhFsEq8F2vI7p2r5uM3jmvdzRxmU2RpeaEqMixvXSoVl+yXdroEo6wFEYbpqDl86AaQ/QP6D2/AytIBMZkfYCc3JaQ2iu8LZcRrfQfXpdNBI14QXregAayH7Z6/dwt7W4Rfw2R2bk8hu0UmNgg0P0djfpi7vbonfzZT+HzV2spuBLdvdKjCyZqUJblBe28KWAfTIB9JUNZ3IeArHI9k6ZeAstz/OMQBuQYs0haWUv+4aJFZpm/pOnOXL6JkTjYIyU9G4ch24+aocJRf+hVntBPhJKMVT6MMlQUfg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(36860700001)(6636002)(54906003)(70586007)(70206006)(47076005)(356005)(7636003)(82740400003)(316002)(6666004)(7696005)(478600001)(110136005)(83380400001)(2616005)(336012)(426003)(107886003)(1076003)(26005)(41300700001)(5660300002)(8936002)(8676002)(86362001)(40480700001)(36756003)(4326008)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 16:00:56.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb84758-70a5-41c5-ada1-08dbd8983c7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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

Expose vfio_pci_core_setup_barmap() to be used by drivers.

This will let drivers to mmap a BAR and re-use it from both vfio and the
driver when it's applicable.

This API will be used in the next patches by the vfio/virtio coming
driver.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 25 +++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_rdwr.c | 28 ++--------------------------
 include/linux/vfio_pci_core.h    |  1 +
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..ebea39836dd9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -684,6 +684,31 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
 
+int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	void __iomem *io;
+	int ret;
+
+	if (vdev->barmap[bar])
+		return 0;
+
+	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+	if (ret)
+		return ret;
+
+	io = pci_iomap(pdev, bar, 0);
+	if (!io) {
+		pci_release_selected_regions(pdev, 1 << bar);
+		return -ENOMEM;
+	}
+
+	vdev->barmap[bar] = io;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
+
 void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index e27de61ac9fe..6f08b3ecbb89 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -200,30 +200,6 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 	return done;
 }
 
-static int vfio_pci_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
-{
-	struct pci_dev *pdev = vdev->pdev;
-	int ret;
-	void __iomem *io;
-
-	if (vdev->barmap[bar])
-		return 0;
-
-	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
-	if (ret)
-		return ret;
-
-	io = pci_iomap(pdev, bar, 0);
-	if (!io) {
-		pci_release_selected_regions(pdev, 1 << bar);
-		return -ENOMEM;
-	}
-
-	vdev->barmap[bar] = io;
-
-	return 0;
-}
-
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -262,7 +238,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		}
 		x_end = end;
 	} else {
-		int ret = vfio_pci_setup_barmap(vdev, bar);
+		int ret = vfio_pci_core_setup_barmap(vdev, bar);
 		if (ret) {
 			done = ret;
 			goto out;
@@ -438,7 +414,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 		return -EINVAL;
 #endif
 
-	ret = vfio_pci_setup_barmap(vdev, bar);
+	ret = vfio_pci_core_setup_barmap(vdev, bar);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 562e8754869d..67ac58e20e1d 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
