Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9705DC77B75
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 21:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1623B426A4;
	Fri, 19 May 2023 21:56:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1623B426A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kWpXi6kb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_y6sW2vbPkW; Fri, 19 May 2023 21:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F31E742465;
	Fri, 19 May 2023 21:56:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F31E742465
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C57E0C0036;
	Fri, 19 May 2023 21:56:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5F40C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 466B560D78
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 466B560D78
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kWpXi6kb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GszydmqQGPNm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EAB360D5F
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::609])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EAB360D5F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 21:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjFT+7GTpqB1Hp97KdzFhCgFdb45G6dsQ8FqvpCBLwwc7bqS4u+EGDHCk9Zf62baj6owvhWLfwlr2f+R/iHd1tVCEMHm1HxivNvLVJPFpnbjWkl4vu3STLVhMtbnsmVQb/BmAPh2CzcuCksMk6F2XaVWQ1CUvIuoDQliY5pOe9Y7L8MsIQgxt1JM/bHypioJ51gHrfDZ3+diX7duE3Mmab8o/yX8IIq4oyvOK6jqlopqu/IDsXAezudfdlZsSsKZjsfUuDtZuDTruWub4tx2cQnHda3nFv+FPJ6rH5IKMwe7nRo+2NKWP0MYl/S5UPTnHjcPKgR+hlYGuEaVzgY5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDIXo4UNsCDm56zbBLhiWWii7G2lJjFG3pskVzCWRQQ=;
 b=P6WkOy6wuP9JgkMAkpoSir7r9jEqsViRZxR5M3chrPHS9zLmYp32+XgFtvXEHNf5kQwhXy7Jw3vDwA4qc+S7u0Jq4p/R8C6X+Jw5zg3lEivx0a8yiUBvrHlfa+BrTRWQ2UuG/THQgCxol9V7Goak0hggPy5naio9IMmLw1CBzAterVE9TyYLEkNtLghXO/wpgSgSSUKAwpC1M+uDPsXaeL2IAwqUz+NXgkNBfvsg7aKSQJ7TOajHFw9rulEWxf6fJ3A4l08TdYE6vAn5O6FKFL0KIl+KUK3cA7DUNWPxk63b09CeePGjLcnWiw0Z7GAJUS6FVDtat1ODwG5uEQcDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDIXo4UNsCDm56zbBLhiWWii7G2lJjFG3pskVzCWRQQ=;
 b=kWpXi6kb84tTP4rjd9V1AQMcWoO5RQdQZrglYeR9hlcXMSt+KWC9cEIVFjwb/M4TsKAPmPVUKxt6JERHeawAnSb5GHkHEvMQcygZY4HyM/qysnv6EcN9onC+E5NQkhlNmWsLJGdWISdvs6opFkS6HAFNgCMK2KFgLbsOiFrIHfE=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 21:56:50 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::8d) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 21:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 21:56:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 16:56:49 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v7 virtio 01/11] virtio: allow caller to override device id in
 vp_modern
Date: Fri, 19 May 2023 14:56:22 -0700
Message-ID: <20230519215632.12343-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519215632.12343-1-shannon.nelson@amd.com>
References: <20230519215632.12343-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c562f9-9062-4fc7-ce1f-08db58b3f339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr+ZR1fcPDugQVCxG+hng59980ZlmFcQAlxKr+fku8Avc7UaKWKFV2+SwJ47giF01ipyTaP2l02mzSCwwbqJv5FDsbQYMSNvF3bX4v7ZDS9WjB7MsS4MZbXkBmzp/FennTVf4FVFjopaiM/EDrqVLX11dSQBMs3kKCp6B6ZWjcmWK3Ro/tX/EznQL3dexinurrGgwP3tHinU7oHUfkQrW5GBq8Zqx6w9qwrLr+sxwn+JFCGzgxLGkHStGLwXC7zX6sOL8U1fp57RG2HYL501vgDCZmI9QVsZoEaFHi1vi06m2daCMtUJvbQ7JWrrUex3gKaL0CDgQZjGudbGrCqP3i6J+1dg02QkaahjMo9vD4yUmq+vxg7pS8PHg5nFnjECn4i1+kU+wtbXL/PzCdqKKjEg8QgdEd0JwuhDbx4iyNMUwlZEXQdxBMo2frBLyvt1A2PvGr+iH4dn4LJejjC5AsXLp7bj7aUALV9/BHy4KkVU7Jt89PqQAGK80JZExVpEBf9Vtz+JcaehQol0qv0exhl+MT+tILSjc39isjoh6eYBMR2Uxa5yWOm6xp6TwbCObmpVhZHD2jA0F3FfkyNEe3Fs/hUSBmLTgRsEen4ax3Er3iOAjUmtP1feUAGyGu2alVGfq+8N5uJ8CU2YnhO3q2/+YuhMl4rmnwXEzJ+Xc+DZazki38/x2+k8oaTf+pPwRfnnVEHN4RIea10kqMlsHvLMQOUYBUI9VBcL87Kqds1FRq4erN8rRMdw15cJC4SaTgJ7sPdaYjNqR2mWB11+JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(70586007)(70206006)(478600001)(4326008)(110136005)(54906003)(316002)(86362001)(36756003)(83380400001)(47076005)(426003)(16526019)(26005)(2616005)(336012)(1076003)(186003)(36860700001)(5660300002)(44832011)(8676002)(8936002)(2906002)(6666004)(82310400005)(40480700001)(41300700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:56:50.5474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c562f9-9062-4fc7-ce1f-08db58b3f339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
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
