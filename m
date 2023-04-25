Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E40C7EE21
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 21:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ACD6418F0;
	Tue, 25 Apr 2023 21:26:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ACD6418F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J7XJkwDX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Z4NxFeeG1Eo; Tue, 25 Apr 2023 21:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18CF141862;
	Tue, 25 Apr 2023 21:26:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18CF141862
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD3CC008C;
	Tue, 25 Apr 2023 21:26:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C29BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5652D418AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5652D418AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UNeyB_S9Qfic
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 360AF417BE
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 360AF417BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLFObvA8kC/3iGXNPRbKcipwuanZVnS9MxfHJ+BuvTzrlInAykjHyJJ7SCqiURXjBjGMp0TDBFv9fM6wQQSTd3JBlo9cuJBOLDrWrRtsJO6fynxSI8elzLVBCvYD6icXWR7sHDpiNw1az6wLDCPJfddaXEcjN2P3EhTXaAhbPjqkAeXn7ctCgLzG0didLqNjJe52Fy9I/cAzTTOB8K3SgXa1BBrzEBv7BV+PHywlmnK0iZx5okjArYc8wYH5Obkvjv+u+XSjVDAZqLddv+4R4HKVrbntcXM/0qVDCVtw9Kj0AOoI4B58GWBZllSq/3S44YrcGVzD9HZV8m7hXW1T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmuXS7KEPYAbdJs8mafOcT/FUJr8S5yde8ZUjOZjYD8=;
 b=nyQb7KYo2MzLqsQe27PFScVswMNzQ6MWEbds+g0tbH4g3tfyZssHqLDU9DJKTwHz6abAvmdm/Tvl5BZ5m0Ku0Syp9nv/UfpsvhYyrGQMQ0FUsKZ+QY5XMYXAV3bfrgtpDWncMqNtMg3BGYg3hqROMBT5bKXIXuJPyfzu8fIJyq7jGH2NmAX9U+c3oOa4NWZ36WUg24ac2BnlpBDF06nyDeoU2X/nDkRXAOvRsuk0fBBl6A63l2IkK97FNzUpNG8aTHw9U3G/kIF7U44ADVyoDDF3d8SHVCVDpfW0oLPxQqQDKfNTc/fWLGH6TFqN4l5BXmZi8QxdtwxXGQ95M9zHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmuXS7KEPYAbdJs8mafOcT/FUJr8S5yde8ZUjOZjYD8=;
 b=J7XJkwDXnR8X9oWMXdcZ2ov+U4LsL1KF34pxBJV7pwfd3KmPDZV3+4eFRXjHhVDwD9NiaGqswbyX426zPcKVR/hRaXp1SAe8PoqGnCaMHJuADZMvMm7wFCfTmFXzaFj80tpfjUi8fIDlO8igcHtsiJlzkcVytb5Ytxr0ULgXP3A=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Tue, 25 Apr 2023 21:26:27 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::70) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 21:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 21:26:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 16:26:26 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 virtio 10/10] pds_vdpa: pds_vdps.rst and Kconfig
Date: Tue, 25 Apr 2023 14:26:02 -0700
Message-ID: <20230425212602.1157-11-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425212602.1157-1-shannon.nelson@amd.com>
References: <20230425212602.1157-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a92ab5c-04f5-45ae-882c-08db45d3ba6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4dNz4T7DCOn2n/92Ug0+VCJOsSuqu8/B7St+CrihCpOANUVc+YB3hAwYhyNdLj3WAs9N/OmPFmZdZ+f0rhGY9VNrF6etrzQsTwP25X1WO36DEZleDP4021AnH74jBXEdBEKJVtdxkEKUAq9jDMJcB+LcjTZ5Kt7/DUhveenWD5/1iayIIeeoN6tYrh1PQHF0DBRPr95vTKfRcaEKc73Wi/ctnOqNLu3SJ08G5PRDjwIjMvF569zLxLrB2XV502KuR+q4p5idAlZeAhEv1GQxJS6EDC425b7FKHLpB2gsvkhk/F7CF2DIJNjKEM+zxIWxkuXtwMTsYnn6x+jjGAHy5Ned+Qla8tpAoQhmKFL9N2RC7VDa//XAPz9WGC224ak97qqDJcrvtas4y7JhDZGLmCgyNFG4fvbdDoXpJC05yal5CmwNyirsqJJsD+afDxp7Hm04RHw4Ok+1ogQudOfSzsLmcKI/RykZzRkASYkQW4M9vv6TZuXHSi45ZMSwB47NmjgjIRDXxtVT2B8jawoC/5C/jiDHIzR6couQb4o3u+ezUnBdp2ZhZSS/F1HuL7ybBxWZt65PFUNK+1L5L8AwYDKvYrjfhfV//Tq+i3nIPlaHC94xnQHAN8rRMoEfrMtt9LLWJe0nJAwLp4y+BlFuy3J0bBCfQu366uvcTCJDdOUkpRGZnIuvHrvBsy8NRgqe1RMcrduDX9Wuum/7hCuPvOznflBJxRZc2S97lXdW6UNFyGSO3HfIsZ5BUZDp9TpmMHDsnjnasxGSdEt0zjx9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(26005)(40480700001)(426003)(336012)(2616005)(36756003)(83380400001)(36860700001)(43170500006)(47076005)(82740400003)(186003)(16526019)(40460700003)(356005)(81166007)(70206006)(86362001)(70586007)(478600001)(8676002)(8936002)(44832011)(110136005)(5660300002)(66899021)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 21:26:27.0276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a92ab5c-04f5-45ae-882c-08db45d3ba6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
Cc: drivers@pensando.io
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

Add the documentation and Kconfig entry for pds_vdpa driver.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../device_drivers/ethernet/amd/pds_vdpa.rst  | 85 +++++++++++++++++++
 .../device_drivers/ethernet/index.rst         |  1 +
 MAINTAINERS                                   |  4 +
 drivers/vdpa/Kconfig                          |  8 ++
 4 files changed, 98 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst

diff --git a/Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst b/Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst
new file mode 100644
index 000000000000..587927d3de92
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. note: can be edited and viewed with /usr/bin/formiko-vim
+
+==========================================================
+PCI vDPA driver for the AMD/Pensando(R) DSC adapter family
+==========================================================
+
+AMD/Pensando vDPA VF Device Driver
+
+Copyright(c) 2023 Advanced Micro Devices, Inc
+
+Overview
+========
+
+The ``pds_vdpa`` driver is an auxiliary bus driver that supplies
+a vDPA device for use by the virtio network stack.  It is used with
+the Pensando Virtual Function devices that offer vDPA and virtio queue
+services.  It depends on the ``pds_core`` driver and hardware for the PF
+and VF PCI handling as well as for device configuration services.
+
+Using the device
+================
+
+The ``pds_vdpa`` device is enabled via multiple configuration steps and
+depends on the ``pds_core`` driver to create and enable SR-IOV Virtual
+Function devices.  After the VFs are enabled, we enable the vDPA service
+in the ``pds_core`` device to create the auxiliary devices used by pds_vdpa.
+
+Example steps:
+
+.. code-block:: bash
+
+  #!/bin/bash
+
+  modprobe pds_core
+  modprobe vdpa
+  modprobe pds_vdpa
+
+  PF_BDF=`ls /sys/module/pds_core/drivers/pci\:pds_core/*/sriov_numvfs | awk -F / '{print $7}'`
+
+  # Enable vDPA VF auxiliary device(s) in the PF
+  devlink dev param set pci/$PF_BDF name enable_vnet cmode runtime value true
+
+  # Create a VF for vDPA use
+  echo 1 > /sys/bus/pci/drivers/pds_core/$PF_BDF/sriov_numvfs
+
+  # Find the vDPA services/devices available
+  PDS_VDPA_MGMT=`vdpa mgmtdev show | grep vDPA | head -1 | cut -d: -f1`
+
+  # Create a vDPA device for use in virtio network configurations
+  vdpa dev add name vdpa1 mgmtdev $PDS_VDPA_MGMT mac 00:11:22:33:44:55
+
+  # Set up an ethernet interface on the vdpa device
+  modprobe virtio_vdpa
+
+
+
+Enabling the driver
+===================
+
+The driver is enabled via the standard kernel configuration system,
+using the make command::
+
+  make oldconfig/menuconfig/etc.
+
+The driver is located in the menu structure at:
+
+  -> Device Drivers
+    -> Network device support (NETDEVICES [=y])
+      -> Ethernet driver support
+        -> Pensando devices
+          -> Pensando Ethernet PDS_VDPA Support
+
+Support
+=======
+
+For general Linux networking support, please use the netdev mailing
+list, which is monitored by Pensando personnel::
+
+  netdev@vger.kernel.org
+
+For more specific support needs, please use the Pensando driver support
+email::
+
+  drivers@pensando.io
diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 417ca514a4d0..94ecb67c0885 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -15,6 +15,7 @@ Contents:
    amazon/ena
    altera/altera_tse
    amd/pds_core
+   amd/pds_vdpa
    aquantia/atlantic
    chelsio/cxgb
    cirrus/cs89x0
diff --git a/MAINTAINERS b/MAINTAINERS
index 6ac562e0381e..93210a8ac74f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22148,6 +22148,10 @@ SNET DPU VIRTIO DATA PATH ACCELERATOR
 R:	Alvaro Karsz <alvaro.karsz@solid-run.com>
 F:	drivers/vdpa/solidrun/
 
+PDS DSC VIRTIO DATA PATH ACCELERATOR
+R:	Shannon Nelson <shannon.nelson@amd.com>
+F:	drivers/vdpa/pds/
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index cd6ad92f3f05..2ee1b288691d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -116,4 +116,12 @@ config ALIBABA_ENI_VDPA
 	  This driver includes a HW monitor device that
 	  reads health values from the DPU.
 
+config PDS_VDPA
+	tristate "vDPA driver for AMD/Pensando DSC devices"
+	depends on PDS_CORE
+	help
+	  vDPA network driver for AMD/Pensando's PDS Core devices.
+	  With this driver, the VirtIO dataplane can be
+	  offloaded to an AMD/Pensando DSC device.
+
 endif # VDPA
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
