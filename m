Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B785C77B7C
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 21:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2E70409F1;
	Tue, 25 Apr 2023 21:26:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2E70409F1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C96wYint
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2EEeBsw2hHT3; Tue, 25 Apr 2023 21:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AF9840195;
	Tue, 25 Apr 2023 21:26:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AF9840195
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 345A5C0037;
	Tue, 25 Apr 2023 21:26:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8810C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7E234091F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7E234091F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ts7QnUP8CR11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAE5540195
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAE5540195
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJMKNggoPoPlCeXOfznWxJEJeQIPXP2s4M2KJ3RmgDo1yJdq1vwrsuweq5byOGuc+iATouh8PkjP+mmy1ksYmTWNnkqRVJdlfMnZPBm9bvhU32Z0OCgM6wyWzdR0UN5ghX6TKyclxpGhxc1bd8zedZaIRlagydTB1c3RHCfgp/m/oTfx+Zp2YcjVG4CkGhUsYC7V42Xqyr33gufhTWQvFO2167XeuXHYzUqIKagWbzdDSJ219sdQHHh1Cg32f0Lb2/WfJ2r0c3yaLHafuwoht3H6QcCbAaIgL+yfB4ywDAkCWMxLthx9UH0YOuj6HuE82Fb9/J5fSGeVdKGHrECu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzOeibijAYMHBctMJZOAW07kd4c9TXIUK6PWuZ69Q7c=;
 b=Y9dPA1tE2HMXtAiVvPX0ogCNANGKZkiCksEwvZCebOeGo2Iw2/VQT2jPtIFX/jD27A9LIerHWkRHSr5WnAL68f91WA9R17h8jOQ5ZymnYLTT+ERNYGazojJgwHjPObdVzyfrW3A+PX4S764mnwfd/zkRMNKwZnD5m8e/X6LaofwYIHo0m4mOKuiUxpZV1mP3FTmTTNocu58JiApDzUvYWRE/itGuApJAVYbgNcPTGgFVzIgMbiGZtWlEm+9mVQnb66uQs9wUzbYxd4fCSaMQeVjC468M1rG5uYLn9EjsTZgNSIkBfjR/4MzI96kS7DFtnb8PJxYHyAIYv99aKtQgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzOeibijAYMHBctMJZOAW07kd4c9TXIUK6PWuZ69Q7c=;
 b=C96wYintkMf3QPo7jLlatwqcJZJ2R1nWp+1HhS1sjhtkQXeOxbZ4w0BKjs8lmsqw/+wIY0yUKBsVzsuyGTBN/BT6CU+ApPaVnSClOIRW0gTFC99bJkn+Grc06wd0DnzGR2dVwOxb0p//5+Ful2ClLAQZ2Sy2T6qNVupJjT8qO1g=
Received: from DM6PR06CA0028.namprd06.prod.outlook.com (2603:10b6:5:120::41)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 21:26:20 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::c) by DM6PR06CA0028.outlook.office365.com
 (2603:10b6:5:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 21:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 21:26:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 16:26:19 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 virtio 03/10] pds_vdpa: move enum from common to adminq
 header
Date: Tue, 25 Apr 2023 14:25:55 -0700
Message-ID: <20230425212602.1157-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425212602.1157-1-shannon.nelson@amd.com>
References: <20230425212602.1157-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: df72699f-d1cf-4234-092a-08db45d3b68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wlq0lAcWbyGCtfWRPeOEPsyCxcLzj/QOza7g92wyHbDZyQfcslWhdMvmcZDwTYahJDxGS+oSikJxjjFexVkziu+ELvr8JhL4ufJppjL4hmXjhwLn5uwVEL7J7VQZAgfP3Hk61Tvn033KhxA8ZieoeLiAtjhhSqlv1hmFG8dDBgXC0gsBOeIMBc0iN+FuNpnnnWEYz8OpnuHuNGZPX66cqIfvBooGuf3RADf3oNL7HHmytVfAnoLWqPNBvR9EwYToVtJEH91gOwx4Ndw0yuYvIWQ9OJ9wlZDeMda+6fz1oj2tHeSfjxiqkE2qThZ9IHUbaP6wDIVTVVyrf5oO5CnV3Ue0AUtfeRET51TQyou9NPmdJcuiXCFMGHqqqIfIocXubx2BX7Ygbq6bWEH35+r9zelf0CCUIvk1Tx9hiFYGc/xbXD5LqCWKy9Hgk4fpLUIFySWFymY/7i97F/j9NjuiJYhDucpe6hWhCUIlsMAzifgEzly2oPdpW/EkIrMk8hF49IBSUZ4QLW/jNdvnVkfUUncS0XubNlcEmrORWoRMtjEpWiBAjQNZrs2ZsEbVTLxWdTiz7LMYA8bgR1FAu/9Nxz2nyDMSQFOgAW2URfXJ9VVTtjTnKZk7Y22p7W5WIA5r/9AgFjgvcLa4OJC9MdBi5hsxnKEele03y0rMu84UqjGX50ASn4vF3k7nSOAPB9X1NYeyIFXbLCAAPixJIpn3zUFftGviNcG8bQQdi6wpVXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(16526019)(186003)(70586007)(4326008)(82740400003)(70206006)(2906002)(356005)(316002)(81166007)(41300700001)(5660300002)(40460700003)(8936002)(8676002)(44832011)(36756003)(6666004)(82310400005)(110136005)(86362001)(40480700001)(478600001)(26005)(1076003)(2616005)(36860700001)(336012)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 21:26:20.5453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df72699f-d1cf-4234-092a-08db45d3b68e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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

The pds_core_logical_qtype enum and IFNAMSIZ are not needed
in the common PDS header, only needed when working with the
adminq, so move them to the adminq header.

Note: This patch might conflict with pds_vfio patches that are
      in review, depending on which patchset gets pulled first.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/linux/pds/pds_adminq.h | 21 +++++++++++++++++++++
 include/linux/pds/pds_common.h | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 98a60ce87b92..61b0a8634e1a 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -222,6 +222,27 @@ enum pds_core_lif_type {
 	PDS_CORE_LIF_TYPE_DEFAULT = 0,
 };
 
+#define PDS_CORE_IFNAMSIZ		16
+
+/**
+ * enum pds_core_logical_qtype - Logical Queue Types
+ * @PDS_CORE_QTYPE_ADMINQ:    Administrative Queue
+ * @PDS_CORE_QTYPE_NOTIFYQ:   Notify Queue
+ * @PDS_CORE_QTYPE_RXQ:       Receive Queue
+ * @PDS_CORE_QTYPE_TXQ:       Transmit Queue
+ * @PDS_CORE_QTYPE_EQ:        Event Queue
+ * @PDS_CORE_QTYPE_MAX:       Max queue type supported
+ */
+enum pds_core_logical_qtype {
+	PDS_CORE_QTYPE_ADMINQ  = 0,
+	PDS_CORE_QTYPE_NOTIFYQ = 1,
+	PDS_CORE_QTYPE_RXQ     = 2,
+	PDS_CORE_QTYPE_TXQ     = 3,
+	PDS_CORE_QTYPE_EQ      = 4,
+
+	PDS_CORE_QTYPE_MAX     = 16   /* don't change - used in struct size */
+};
+
 /**
  * union pds_core_lif_config - LIF configuration
  * @state:	    LIF state (enum pds_core_lif_state)
diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
index 2a0d1669cfd0..435c8e8161c2 100644
--- a/include/linux/pds/pds_common.h
+++ b/include/linux/pds/pds_common.h
@@ -41,27 +41,6 @@ enum pds_core_vif_types {
 
 #define PDS_VDPA_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
 
-#define PDS_CORE_IFNAMSIZ		16
-
-/**
- * enum pds_core_logical_qtype - Logical Queue Types
- * @PDS_CORE_QTYPE_ADMINQ:    Administrative Queue
- * @PDS_CORE_QTYPE_NOTIFYQ:   Notify Queue
- * @PDS_CORE_QTYPE_RXQ:       Receive Queue
- * @PDS_CORE_QTYPE_TXQ:       Transmit Queue
- * @PDS_CORE_QTYPE_EQ:        Event Queue
- * @PDS_CORE_QTYPE_MAX:       Max queue type supported
- */
-enum pds_core_logical_qtype {
-	PDS_CORE_QTYPE_ADMINQ  = 0,
-	PDS_CORE_QTYPE_NOTIFYQ = 1,
-	PDS_CORE_QTYPE_RXQ     = 2,
-	PDS_CORE_QTYPE_TXQ     = 3,
-	PDS_CORE_QTYPE_EQ      = 4,
-
-	PDS_CORE_QTYPE_MAX     = 16   /* don't change - used in struct size */
-};
-
 int pdsc_register_notify(struct notifier_block *nb);
 void pdsc_unregister_notify(struct notifier_block *nb);
 void *pdsc_get_pf_struct(struct pci_dev *vf_pdev);
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
