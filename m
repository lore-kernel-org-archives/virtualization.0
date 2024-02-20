Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A441DFCF
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Feb 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391496; cv=fail; b=GT2x5toeNdCw1HuuXg1kdMmFKqI/k7VRmzqWodQmzKDkY1lRTPRVySmGWkHbJQuWzLbrsyjhtYJxPszGQOb4lBnfzHLD6XEqpxXBOtZfkz4MBlOxI8N2Q38gwmX9w1gGrN2j9IclmF2cUs1UR1XicDfHi7bXgQZjBwKDW+6MvkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391496; c=relaxed/simple;
	bh=o31hsVk6dmlv4AR2nuzx+DFCKXXeDwYX8S+rkwko6A0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftDwCQOz3Q+bmlnMjydB2sJ7xzkoqVbUuzRi2l7PrecFIKilYYAPy3KXsRCvQZi9kzCYqbUMwYS9FCYwGGm33YGxvX/30nn8XEh0n9GHhX5FV+mv8XWcLgmM0N30Y//irz5OUshhva3QMKXDMEhMEMkYtLnxrNOTMKqnBaG+L48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zVRw05m0; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zVRw05m0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCDEF407BA
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Feb 2024 01:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tR47DxW5z9U
	for <virtualization@lists.linux-foundation.org>;
	Tue, 20 Feb 2024 01:11:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2415::600; helo=nam11-dm6-obe.outbound.protection.outlook.com; envelope-from=shannon.nelson@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E369B407B9
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E369B407B9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zVRw05m0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2415::600])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E369B407B9
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Feb 2024 01:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO0oXJ7/r6SEwOJrZNFwqJwrQzOwP3k5RyBvtmXPU1PUBuiSbMZFqaJn1DBEwFOwtDPkVcL46/b9e69uP0YAymVI3exqWjfzCzRXF3DNpoyJDZdZ7Ec1/BEtXrno3KdPwYEA4Hl9EuYE5seTZoii0zXF0aerQKcER0YWSAFfNXv94dgqZDRYM9fCIcEKtYWvxI2L4uNKcKJpgcp3jo6RYh8W2woebxoe8dk+alxHiiFsvvSzGZqOA1QxEwGr85jySqc3LkaO6R/cLR5LyTNy1bTTGnPMXiJzDLlInhRzrX6jKZ+qrY6ZAqxnTHYrnt+cMGrs4uX2cQPgGJ0nPIgckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIXm4k9bgV1Q6kEbqdfEc1SM4NU53vN5vRQJzh5zpU4=;
 b=nJcPH81a9Y0T8um5Lv3Oury+Dxfc2xRmVVlJKWX4BV7LFGR3zw0CeFP9StgRogWnKnUQsPFJ81C7b+7JImS+u/fCPPj/zmRFbTadRjtc1X3SgBU3fI/K1tr4hdX3wyoi/AUtYyKFFIPmaKe7gPU1PQOL3uE107ut1PDG9lS4sV90QOkhKYkgKqmYA8kD9nrsXih8tkkvOeYHCW09DceTB+DXV9bHUofvPwapA59ydwVPh2jWF3xwvfZ/K/Oimzm+0nY3/X7td1THKlOvpyPEbuuRmEk06SgdEMPxvidw1IeozB5JpEN0b+fXpfAhNmCbQ/Ff3ThKBT6UEBp/mW6OMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIXm4k9bgV1Q6kEbqdfEc1SM4NU53vN5vRQJzh5zpU4=;
 b=zVRw05m0aMFb5bRX+D3IInQujg63uoZyvETa2/NnGDoaaYzeSBNtIM7p7zyfa0az1XyZZsWz49q8jZtfRGtZn9E5YIuez3cr4GcM24Yj6pWVouCSxw4OhZkfllRbvIKA0IJ6Etp1ZdEuogG3G9VuyjChCZJdofbFpgub2D6Ml4M=
Received: from CY5PR17CA0011.namprd17.prod.outlook.com (2603:10b6:930:17::8)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 01:11:27 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::46) by CY5PR17CA0011.outlook.office365.com
 (2603:10b6:930:17::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 01:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 20 Feb 2024 01:11:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 19:11:24 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux-foundation.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH] vdpa/pds: fixes for VF vdpa flr-aer handling
Date: Mon, 19 Feb 2024 17:10:50 -0800
Message-ID: <20240220011050.30913-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3b8972-169d-482f-efbd-08dc31b0dca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z+8OIoqlD/utXLt8xAVCa82Seus/8RskrwWlMdH5tyxXAOOyPpKr/bO9MkDkQ5e3WOrY5k9CjrphO2k0MKbEeZST3o5OA1VrB8HZ+SEkL9o0yH2unhKeq2l4MnLxFdEli886WulSd3M9BYBFNejZ//GZnTF86oaCl6ReEn8gUgvsOIzU++9iRNiKkVmCN458kgjWYRxETt6Skuc/uuwBvYMMho6MOCK9+pTlnA1UoVHf0QkgDT+3ona7PHmocJxd2QGcMxpWM+any8Q91T3VkS2wt6E/lb8nOql5+ptiPOE2dL8IwitGMuogDFDg3g6cGKsbgxEd6eF39lF492FbZGYv9YQjthA/WD9Tao8XOrJVbhUzS4CiteaP6gutqOUdunpX6jGzYXmmOFach2DbZp4pFJyxAfLAHiwWO/+rO/ddz17fRhv3gXowuhHHD0hGPpYVIxTLRlOIFP0R18lKtqTAzIs4aGnIOWVQ1e1Q4AsbFF1EXsxx/lTcUN+XwAvIHNy3Pvv0t0P2YOFdP6OstBcSFTuWWEH4iIgKgDAMqgiQ/0fPbTtRapSgpUALxcSAuHLZcaHGiGJ0fhzTA3oMCWA7M2T+RJAQcOhmTSsvNAMvbheJTcewtsxyyR9jCQfoHqBxrEldTf0ZuVF7x2ZLCtY7RvSo14soLH490ARZ+cU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:11:26.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3b8972-169d-482f-efbd-08dc31b0dca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

This addresses a couple of things found while testing the FLR and AER
handling with the VFs.
 - release irqs before calling vp_modern_remove()
 - make sure we have a valid struct pointer before using it to release irqs
 - make sure the FW is alive before trying to add a new device

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/aux_drv.c  |  2 +-
 drivers/vdpa/pds/vdpa_dev.c | 20 +++++++++++++++++---
 drivers/vdpa/pds/vdpa_dev.h |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/pds/aux_drv.c b/drivers/vdpa/pds/aux_drv.c
index 186e9ee22eb1..f57330cf9024 100644
--- a/drivers/vdpa/pds/aux_drv.c
+++ b/drivers/vdpa/pds/aux_drv.c
@@ -93,8 +93,8 @@ static void pds_vdpa_remove(struct auxiliary_device *aux_dev)
 	struct device *dev = &aux_dev->dev;
 
 	vdpa_mgmtdev_unregister(&vdpa_aux->vdpa_mdev);
+	pds_vdpa_release_irqs(vdpa_aux->pdsv);
 	vp_modern_remove(&vdpa_aux->vd_mdev);
-	pci_free_irq_vectors(vdpa_aux->padev->vf_pdev);
 
 	pds_vdpa_debugfs_del_vdpadev(vdpa_aux);
 	kfree(vdpa_aux);
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 25c0fe5ec3d5..301d95e08596 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -426,12 +426,18 @@ static int pds_vdpa_request_irqs(struct pds_vdpa_device *pdsv)
 	return err;
 }
 
-static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
+void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
 {
-	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
-	struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
+	struct pds_vdpa_aux *vdpa_aux;
+	struct pci_dev *pdev;
 	int qid;
 
+	if (!pdsv)
+		return;
+
+	pdev = pdsv->vdpa_aux->padev->vf_pdev;
+	vdpa_aux = pdsv->vdpa_aux;
+
 	if (!vdpa_aux->nintrs)
 		return;
 
@@ -612,6 +618,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	struct device *dma_dev;
 	struct pci_dev *pdev;
 	struct device *dev;
+	u8 status;
 	int err;
 	int i;
 
@@ -638,6 +645,13 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dma_dev = &pdev->dev;
 	pdsv->vdpa_dev.dma_dev = dma_dev;
 
+	status = pds_vdpa_get_status(&pdsv->vdpa_dev);
+	if (status == 0xff) {
+		dev_err(dev, "Broken PCI - status %#x\n", status);
+		err = -ENXIO;
+		goto err_unmap;
+	}
+
 	pdsv->supported_features = mgmt->supported_features;
 
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
index d984ba24a7da..84bdb45871ff 100644
--- a/drivers/vdpa/pds/vdpa_dev.h
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -46,5 +46,6 @@ struct pds_vdpa_device {
 
 #define PDS_VDPA_PACKED_INVERT_IDX	0x8000
 
+void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv);
 int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
 #endif /* _VDPA_DEV_H_ */
-- 
2.17.1

