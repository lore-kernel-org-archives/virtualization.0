Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD8C77B75
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 02:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EBB3400EC;
	Tue, 16 May 2023 02:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EBB3400EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X2QC3BYs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NctM7dySMn3E; Tue, 16 May 2023 02:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD51A40A8A;
	Tue, 16 May 2023 02:55:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD51A40A8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85502C0037;
	Tue, 16 May 2023 02:55:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECD72C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC7DC40546
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC7DC40546
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N90AyXfwvI2C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DDAF400EC
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DDAF400EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 02:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNYFu6YCbU7V7dVz+0KWexrQCWiSus7hRn7N0RlkTV3ZSdfBtpuW88td3HNjgaRuxmDlW2Xuy4AeH9LE76G+zV0qKAtr8yZTThHIDXtXX2WKW2v2cQbLtC68FogrZ/np76LDgkjJM5OTviaLfQnfK67fHm0rpr293UPxo13XhnM2uc909X0hfjvqrfqNSedH+17zfCeuskAFe1ySaPzs2opvPXSF3CUcW5lZui9iOyW2E0AjbTSaz5c+N7Ev70BC/UKuDF0nMrH4P1uJ/ntOVL9Bc+8T0CpIsBf+NN+zRy8rqQ/UMlBrnNEes8yJqGdziLowHmetneTuACZN/7nO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDIXo4UNsCDm56zbBLhiWWii7G2lJjFG3pskVzCWRQQ=;
 b=LXtemATJKKTqj32+r70iQEzvyLAwEnoxJt0YLVDWMPAg/VON2O8Ge7V1gm98pS6KmlYGhFzmU8Hc3JJN41fQkTS4xOZ77F84KJC7CeJUUUJTSDBj6csY5hw1mLpkdIraTAMUw51lNAAHxlENBBiT0efthZ1zbfRBBKhVm0kG6aQc4nt4vFnci3tBrHqKo0/DR+bAS5LbjIuexBkjEBd6ZuSw8NdAS6/3vKuyLqzKsKaaDA0nvgYbg55r/xkF4UhNJp2jiK3/ens+7+rfG6i+F3yFVpLDZ/WCQuO0CLNML5wvGsqoFZmMKWuo20jrg1Fd2aPJVB7kGIWy9OC1dynRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDIXo4UNsCDm56zbBLhiWWii7G2lJjFG3pskVzCWRQQ=;
 b=X2QC3BYstywMulkMT2PWGovU4YbYk08AAzkAiebFFslms5Ez+bEc3/scsCMtZ7KLJT2qnMcaKsE0XDzItLppU6RuwNNQ2OWdwRj6vurG9os91sPeR0xM5gZt4RI5ZKu0ZTxv22PxnqVmkUxVKRgxgsAcngGkcqRTI/eCQM4vdoc=
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:55:44 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::48) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 02:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 02:55:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 21:55:42 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 virtio 01/11] virtio: allow caller to override device id in
 vp_modern
Date: Mon, 15 May 2023 19:55:11 -0700
Message-ID: <20230516025521.43352-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230516025521.43352-1-shannon.nelson@amd.com>
References: <20230516025521.43352-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dce377-c6e9-44bb-74e2-08db55b90ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yE1TTDcazG4Amqw/WLPN/V/Evs+wRkGEWjGCVK5QEvXHgPTyMZ+SY79xi0l/2gWDtdq5skdCYVdbks2tSnA6vhI8CaAZzJd8I86OMINBvitVv+ECREruhEuC0TUAP/a/KL8ispcqMes41400a5rckqSLtTHGK6spKWcLH3I+6ZxF+AX+ETX/aion2jgApPmxfjYytf3F5Pk4ASmcAEM4WgwERlNr7cwiZ+uPpcSzJJTbQXWtMgCpy70aCxVdcnp4Ba/1jbVL380UPefDu1HpMnmmhp6ziC661fGsJa4X/zPg3UFL6sSR97uuFGfnqxeSZ5bCqnGv3UXArNqF3hzQc8dW9W6IU7T1KiMwdVp4SfcZL5QR/Wx2+D0Lac+cKGnxViPn4zoIPB88tsokTn+c70ie9IYC9erkcAT6313djXJfsxcbUZ7Q+51tnyF933dzfHEEV0DZD0tG8m64A9RDB1L5DbCM/FSx0knkIdsDbFnca4vpIPIatgFL/C/jZGKFMiTdg0pkvcBq83CIh85Eoof2t7UbYrDvcz2srbg96XSc1LoEG27WHJOcEReIvufPTAT2ZCf8wD9I3fZp7jJ48kWjXaONwOPrDqHDL2LWfl1lKw26wPdGkUVg3XV+TUnSupZm4wFD+p6QpGxna2+LRw+Gj/7/F8Np172p0LMAmfN6uBVV/WGXMS5hIa6wsH30O5InhGbGsbR/XYbOoMavus3FZXQSLfA4H1Dc8VE79L+sLh+lVni986jmeYyNwp9wxOfHBS4aXNXBFtOL/4ao1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(83380400001)(36860700001)(336012)(47076005)(426003)(4326008)(82740400003)(356005)(36756003)(81166007)(41300700001)(26005)(40480700001)(478600001)(1076003)(316002)(2616005)(70206006)(70586007)(8676002)(8936002)(40460700003)(5660300002)(44832011)(110136005)(86362001)(16526019)(2906002)(54906003)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:55:44.1610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dce377-c6e9-44bb-74e2-08db55b90ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
Cc: simon.horman@corigine.com, drivers@pensando.io
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

To add a bit of vendor flexibility with various virtio based devices,
allow the caller to check for a different device id.  This adds a function
pointer field to struct virtio_pci_modern_device to specify an override
device id check.  If defined by the driver, this function will be called
to check that the PCI device is the vendor's expected device, and will
return the found device id to be stored in mdev->id.device.  This allows
vendors with alternative vendor device ids to use this library on their
own device BAR.

Note: A lot of the diff in this is simply indenting the existing code
into an else block.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 30 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 869cb46bef96..9b2d6614de67 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -218,21 +218,29 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	int err, common, isr, notify, device;
 	u32 notify_length;
 	u32 notify_offset;
+	int devid;
 
 	check_offsets();
 
-	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
-	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
-		return -ENODEV;
-
-	if (pci_dev->device < 0x1040) {
-		/* Transitional devices: use the PCI subsystem device id as
-		 * virtio device id, same as legacy driver always did.
-		 */
-		mdev->id.device = pci_dev->subsystem_device;
+	if (mdev->device_id_check) {
+		devid = mdev->device_id_check(pci_dev);
+		if (devid < 0)
+			return devid;
+		mdev->id.device = devid;
 	} else {
-		/* Modern devices: simply use PCI device id, but start from 0x1040. */
-		mdev->id.device = pci_dev->device - 0x1040;
+		/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
+		if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
+			return -ENODEV;
+
+		if (pci_dev->device < 0x1040) {
+			/* Transitional devices: use the PCI subsystem device id as
+			 * virtio device id, same as legacy driver always did.
+			 */
+			mdev->id.device = pci_dev->subsystem_device;
+		} else {
+			/* Modern devices: simply use PCI device id, but start from 0x1040. */
+			mdev->id.device = pci_dev->device - 0x1040;
+		}
 	}
 	mdev->id.vendor = pci_dev->subsystem_vendor;
 
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index c4eeb79b0139..e7b1db1dd0bb 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -38,6 +38,9 @@ struct virtio_pci_modern_device {
 	int modern_bars;
 
 	struct virtio_device_id id;
+
+	/* optional check for vendor virtio device, returns dev_id or -ERRNO */
+	int (*device_id_check)(struct pci_dev *pdev);
 };
 
 /*
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
