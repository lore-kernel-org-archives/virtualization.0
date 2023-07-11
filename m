Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB1FEB64DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 04:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB43761072;
	Tue, 11 Jul 2023 04:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB43761072
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jzp9V0Iw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbxkGUpGZ03k; Tue, 11 Jul 2023 04:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20FD961064;
	Tue, 11 Jul 2023 04:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20FD961064
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F29F4C0072;
	Tue, 11 Jul 2023 04:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4357FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E3AA81985
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E3AA81985
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jzp9V0Iw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M15dMqG4rTAZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2D8081F65
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2D8081F65
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvHt5oyUx3GWKlZMOn95MaM9F6WuQd7ZMkjcwS2E8obca++dh8VMaVHd6Qtp3F7ZkDuyiBKy5/oj3Goswc0KlvB+cJquO9zVGDB/P5GZPltjEhU8u8nh/oRMMpD/ApJDy/J5Znv1imMkNQV2HR8C11Ebvm7QRaFx0v8RmnTY8KOo3Ym0zc1whEYQGKv8t6sREaFRMAVWNkfAvBOQI0hz5aQq9VUyL4C641uIyjOgED1YjF9OBxVwOaRduGY+mnLwDZNoo5dqg5Gwe8hClT1DzwV1gdigk7fwxEaFLqJ0lF72QezuBTn0wJQ4xgVkZTLGw5pa7kh8OwOTzt7z/p6iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KfeQ0mClrYFoBmUsMjH58geAMUegCcUmIhAiM8H/bw=;
 b=Bm0PEcXO6EsisQDQXpW/38wFq/0chvOetsN7+ZUZeQunWqso2WY3leEmr10WwrxAus1cpHmljedSiQIMWPH195ovaIgQhdEjLHAunsyoZhe3wJ6o81MnnmWYL157bpBejSONOVfgNjoM0+KYgV8MTov6B8jJGGb/AOwNgDyeRVyfpZVUjRLrO5QIRFJe+tzJ32Qp+kLCIyELCGecOpEJtpEyye5lpXEIRNWxPOlT/zf0IadxJyatm3KWJrhpiwDyQg+04JyY8XlAIV6ia1RWH/qXSObq127UmmTvcFEiLV8/NJCVLWO97MdSSEMvC6nwWbgzlF0OZrS/QEsrj/1bbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KfeQ0mClrYFoBmUsMjH58geAMUegCcUmIhAiM8H/bw=;
 b=jzp9V0IwqNgG9zprr3V9V84h2JHkPqtvSRI1rWVAU5RbjvSCZ0OFhWL1Sm67Q0PBzKqVTEp9YAdm0NTKTy7GMKL6CkTbLKbAGQedGrOuVkUPjrpawxp1wbtESQfYklwThzrYK7iXm84/P6Y4Vch4/pBD/+RFs/3lGtYgJ98tjrI=
Received: from BN9PR03CA0755.namprd03.prod.outlook.com (2603:10b6:408:13a::10)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 04:25:04 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::78) by BN9PR03CA0755.outlook.office365.com
 (2603:10b6:408:13a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 04:25:04 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:25:03 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 virtio 4/5] pds_vdpa: alloc irq vectors on DRIVER_OK
Date: Mon, 10 Jul 2023 21:24:36 -0700
Message-ID: <20230711042437.69381-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711042437.69381-1-shannon.nelson@amd.com>
References: <20230711042437.69381-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4927cd47-b51a-4c65-2461-08db81c6ccf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f34f9WTtHl34nX0astK/ME+b1csa2zLmZmGPhwKaO7XYMmgcs8r7n4ugsw7bnGAh1awISvdVe7GwsAxM5BgV0JYutbeGDkthnuODBT08HrmV6ceZZYFWElRsYo6mLoKnMhPN0rzMmwLenOyREShRFHteJJmC1IY0GU9guW83fN61Iekn2YmsPytFNGAQ3OQ7zLkfHEKz+kmZVLh9qvrrljKMKDZHaFyFT6XhPa7zQzK3dhVmrAT0Ulqi7ZrKtmc1q5prsVaSi/8JL4G9Evq+Ic/eqtGVQExBZ/Mr/qOccOh79+yVRedRgIcCc5yAA7+hM65RYqhDI62PsnO2EbxgKo5P1BfPVwAoInMAHJT001fuHsJhten/cfoWBjVbNHYITCN4r+txI1A2fgtyXF8FwAzs0tHUa7SwM+9f6irzlfcn3Y+FDRC8FNrsb1OsbpAwWkdHJQQ5UkhEBHTkEI/dk8wspcvd54lePN8yGMFMDzMznIieJIGJSjfCa8bOmE9erJlXbPJXOCCnV//KIUepBdiiFfRCWQEsLnhwBw9vlVdOQlNatflFV7uO+PwHMnbMUtqoTewDCYgfepd9CCmjqZdMWVq10pBarVbu3bmMeOXdbfiOuAubCkpXa+7CgDKcVQnbubMlTb2P8nF4yhWOyLoSNJLLm7fqfX8Mni0qRYzMszq7YlHAXMW9REzo3CN5GOtrcD7o3TIrawyuyy5JSBfYo+nrjQ9ZuVXowFImN9k+/QFSmef7HTej8IjGvkxXGCTUyfCRsH9kHwaElVxeZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(6666004)(478600001)(110136005)(26005)(1076003)(336012)(16526019)(70586007)(186003)(70206006)(2906002)(82310400005)(41300700001)(4326008)(5660300002)(316002)(44832011)(8936002)(81166007)(8676002)(82740400003)(356005)(40460700003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(426003)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:04.4386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4927cd47-b51a-4c65-2461-08db81c6ccf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
Cc: Allen Hubbe <allen.hubbe@amd.com>, drivers@pensando.io
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Allen Hubbe <allen.hubbe@amd.com>

We were allocating irq vectors at the time the aux dev was probed,
but that is before the PCI VF is assigned to a separate iommu domain
by vhost_vdpa.  Because vhost_vdpa later changes the iommu domain the
interrupts do not work.

Instead, we can allocate the irq vectors later when we see DRIVER_OK and
know that the reassignment of the PCI VF to an iommu domain has already
happened.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 110 ++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 29 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 04a362648b02..52b2449182ad 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -126,11 +126,9 @@ static void pds_vdpa_release_irq(struct pds_vdpa_device *pdsv, int qid)
 static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool ready)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
-	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
 	struct device *dev = &pdsv->vdpa_dev.dev;
 	u64 driver_features;
 	u16 invert_idx = 0;
-	int irq;
 	int err;
 
 	dev_dbg(dev, "%s: qid %d ready %d => %d\n",
@@ -143,19 +141,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		invert_idx = PDS_VDPA_PACKED_INVERT_IDX;
 
 	if (ready) {
-		irq = pci_irq_vector(pdev, qid);
-		snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].irq_name),
-			 "vdpa-%s-%d", dev_name(dev), qid);
-
-		err = request_irq(irq, pds_vdpa_isr, 0,
-				  pdsv->vqs[qid].irq_name, &pdsv->vqs[qid]);
-		if (err) {
-			dev_err(dev, "%s: no irq for qid %d: %pe\n",
-				__func__, qid, ERR_PTR(err));
-			return;
-		}
-		pdsv->vqs[qid].irq = irq;
-
 		/* Pass vq setup info to DSC using adminq to gather up and
 		 * send all info at once so FW can do its full set up in
 		 * one easy operation
@@ -164,7 +149,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		if (err) {
 			dev_err(dev, "Failed to init vq %d: %pe\n",
 				qid, ERR_PTR(err));
-			pds_vdpa_release_irq(pdsv, qid);
 			ready = false;
 		}
 	} else {
@@ -172,7 +156,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		if (err)
 			dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 				__func__, qid, ERR_PTR(err));
-		pds_vdpa_release_irq(pdsv, qid);
 	}
 
 	pdsv->vqs[qid].ready = ready;
@@ -395,6 +378,72 @@ static u8 pds_vdpa_get_status(struct vdpa_device *vdpa_dev)
 	return vp_modern_get_status(&pdsv->vdpa_aux->vd_mdev);
 }
 
+static int pds_vdpa_request_irqs(struct pds_vdpa_device *pdsv)
+{
+	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
+	struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
+	struct device *dev = &pdsv->vdpa_dev.dev;
+	int max_vq, nintrs, qid, err;
+
+	max_vq = vdpa_aux->vdpa_mdev.max_supported_vqs;
+
+	nintrs = pci_alloc_irq_vectors(pdev, max_vq, max_vq, PCI_IRQ_MSIX);
+	if (nintrs < 0) {
+		dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
+			max_vq, ERR_PTR(nintrs));
+		return nintrs;
+	}
+
+	for (qid = 0; qid < pdsv->num_vqs; ++qid) {
+		int irq = pci_irq_vector(pdev, qid);
+
+		snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].irq_name),
+			 "vdpa-%s-%d", dev_name(dev), qid);
+
+		err = request_irq(irq, pds_vdpa_isr, 0,
+				  pdsv->vqs[qid].irq_name,
+				  &pdsv->vqs[qid]);
+		if (err) {
+			dev_err(dev, "%s: no irq for qid %d: %pe\n",
+				__func__, qid, ERR_PTR(err));
+			goto err_release;
+		}
+
+		pdsv->vqs[qid].irq = irq;
+	}
+
+	vdpa_aux->nintrs = nintrs;
+
+	return 0;
+
+err_release:
+	while (qid--)
+		pds_vdpa_release_irq(pdsv, qid);
+
+	pci_free_irq_vectors(pdev);
+
+	vdpa_aux->nintrs = 0;
+
+	return err;
+}
+
+static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
+{
+	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
+	struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
+	int qid;
+
+	if (!vdpa_aux->nintrs)
+		return;
+
+	for (qid = 0; qid < pdsv->num_vqs; qid++)
+		pds_vdpa_release_irq(pdsv, qid);
+
+	pci_free_irq_vectors(pdev);
+
+	vdpa_aux->nintrs = 0;
+}
+
 static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
@@ -405,6 +454,11 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	old_status = pds_vdpa_get_status(vdpa_dev);
 	dev_dbg(dev, "%s: old %#x new %#x\n", __func__, old_status, status);
 
+	if (status & ~old_status & VIRTIO_CONFIG_S_DRIVER_OK) {
+		if (pds_vdpa_request_irqs(pdsv))
+			status = old_status | VIRTIO_CONFIG_S_FAILED;
+	}
+
 	pds_vdpa_cmd_set_status(pdsv, status);
 
 	/* Note: still working with FW on the need for this reset cmd */
@@ -426,6 +480,9 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 							i, &pdsv->vqs[i].notify_pa);
 		}
 	}
+
+	if (old_status & ~status & VIRTIO_CONFIG_S_DRIVER_OK)
+		pds_vdpa_release_irqs(pdsv);
 }
 
 static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qid,
@@ -460,13 +517,17 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 			if (err)
 				dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 					__func__, i, ERR_PTR(err));
-			pds_vdpa_release_irq(pdsv, i);
-			pds_vdpa_init_vqs_entry(pdsv, i, pdsv->vqs[i].notify);
 		}
 	}
 
 	pds_vdpa_set_status(vdpa_dev, 0);
 
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+		/* Reset the vq info */
+		for (i = 0; i < pdsv->num_vqs && !err; i++)
+			pds_vdpa_init_vqs_entry(pdsv, i, pdsv->vqs[i].notify);
+	}
+
 	return 0;
 }
 
@@ -764,7 +825,7 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
 
 	max_vqs = min_t(u16, dev_intrs, max_vqs);
 	mgmt->max_supported_vqs = min_t(u16, PDS_VDPA_MAX_QUEUES, max_vqs);
-	vdpa_aux->nintrs = mgmt->max_supported_vqs;
+	vdpa_aux->nintrs = 0;
 
 	mgmt->ops = &pds_vdpa_mgmt_dev_ops;
 	mgmt->id_table = pds_vdpa_id_table;
@@ -778,14 +839,5 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
 
-	err = pci_alloc_irq_vectors(pdev, vdpa_aux->nintrs, vdpa_aux->nintrs,
-				    PCI_IRQ_MSIX);
-	if (err < 0) {
-		dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
-			vdpa_aux->nintrs, ERR_PTR(err));
-		return err;
-	}
-	vdpa_aux->nintrs = err;
-
 	return 0;
 }
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
