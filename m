Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16EC0015E
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 04:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA9D141B66;
	Tue, 11 Jul 2023 04:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA9D141B66
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lU/aPgYg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQPUnFRXqJjU; Tue, 11 Jul 2023 04:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9CF4415CF;
	Tue, 11 Jul 2023 04:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9CF4415CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAF30C007F;
	Tue, 11 Jul 2023 04:25:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3334C0DDE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88FAA81F6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88FAA81F6D
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lU/aPgYg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ak0Vm2NQUpGS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA15D81C0A
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA15D81C0A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 04:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqXnTsivt600zs7iVigM1QLt0CtOWyLqrl6GDkSaJiJf4Z8bN9u4QtoSD6Nu7JSxpP6GKPlTpdA/dgQf/3nUjF/MmaBeIf89PyYSo97P9V+KSb/Y4JJnMsrh5kMrnci+MqRQHj4Qbsj7HQvc6Mbwgvq8SjF/seVtxl0YmEKOlIW1s45VksU6/umUYNu98/16Tgocl8vf0CXJ7reATxWAsQ55eJ2avTtVZWxfl0UtdceOb7tN+6GxOUMmzFDTJAtlzivFBQYUvdrwdJl9fs8PlMHAVMixEIDFcYux0No7pRnvkmfJvs+8T6wKwmC8+u6cIB3k1SHvbc/8L8mluX7IcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc7DwsT5JZsYvOCCaj6MLWMlzR8wchjiILzAIdoyUPc=;
 b=gDNANIDWI3yWLLvrU4UqAPeDgkbqesR+NrBfD2f1LmvcHQRXls0G++06n+J21Z9DaBmJj9ZFnvWxMYllp4jVYbIg/LmMh8qF4NHr+Cj/hkU9YNQ54+11UefQLe+vjCF5pUvcmOezJBB1ramc+M/Ptnyhv5ClUJ1jFk5YgcIPTz4/WNx1/F/7HkATJhel76EHt7NAcbE55JK3diTSEB+DRuJ4nI/GnBLfOuO/LyRxIqRLFtVhLWGVcfYDQ9cW7pS+ZqDWfKQb+yt6nkoX2Yvwq0rAIK07kHgYNlPCJY2VyUzny21oIiiCq95YFghHE3E4rY6LUotgCR2GIMKr8kG1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc7DwsT5JZsYvOCCaj6MLWMlzR8wchjiILzAIdoyUPc=;
 b=lU/aPgYgfjqgAsVPaPOltksRuAuWOz8fL+AUXfVwop9OXmmgAWNcsh7zmX6oXSUVQhE35awiEkGBLvWRNFYV2WB1+vq1jXSsDul5ReYVHJwIeoxcz/xcQV/3NSuBVI9Jj2MhO7oVG5/D+t2F4VQOJ8kCeNRzJix0zHra6MOcnGo=
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 04:25:05 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ae) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Tue, 11 Jul 2023 04:25:05 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:25:04 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 virtio 5/5] pds_vdpa: fix up debugfs feature bit printing
Date: Mon, 10 Jul 2023 21:24:37 -0700
Message-ID: <20230711042437.69381-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711042437.69381-1-shannon.nelson@amd.com>
References: <20230711042437.69381-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6b28b2-7ced-4807-a2c8-08db81c6cd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRiiQ+pu3D/W++Kd9mByNjhfIXFV0kh5uxkCiGftY4Wb6s8L8jOj1x81RoH6mNEBCdiVnCLFNmdzffGOcH3dRQStTZXfM7ykAg/5Wks4H4VmD+rhkihQDXhSw1AHTvaRJgyLaWQ87tOBKOlG5PmBRv451n/Y//tAZxTTWO9V3CF8oVbt/s9DDtFWLwmM3I5UhZtVkp98KN8CxYz70RUX6kANfFkV4tCoTiJccnOX2ZSjtxAtdbEnASEb06Qw6PgCjZ9Ccmz6o33DJ1w/yWw90ZdMK8zbjDtkk6q0GPwvJ85FlpBkIAO+yI+ZAEVVGLij6g1BeMEkDYgiCUJW57EfcARgMEbNMtWvj/TVGLBVI3dMCsrJNv/aHnJSmrkkoHrPUvIKXwaDQxgaknnvk6nE8xPwhCAE+NYZvTKQKSv5Tt52qUof6jz/znsYB27GeYdNBz6l7Q/zxp3FQKppqypc/EFvuNIyd4CWXpjJ8Jqox7RzwoEQ3U4fbYItSCbKfTNmor4WqKR78Pek52y3ZGeUiI5Ii0d24uRijGXJSYJLgOyLZ2XIYWNCpWadY8DE+KKWkBhpNTp9wUvONENmFc3UZwBtMJwaNxVqxu48QHD9Py2QuVq6H7bVZioWh2eq/sVSaUY+bz8JtH8fOpM/lBlIAoRBTu5YHWb+8WJWLgQK9JIiI1b3vENY6zMt1YUqw6qBfDCQx7HbXEYya0wZRckiLZwuhgXoCGCsjGzbT/uCu9h9CxH781078gcP3F2SEuLmJbqVBYeqVrLZfQmexHz00g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(83380400001)(186003)(82310400005)(86362001)(336012)(16526019)(478600001)(110136005)(316002)(41300700001)(70206006)(70586007)(4326008)(40480700001)(26005)(1076003)(6666004)(82740400003)(81166007)(356005)(40460700003)(36756003)(2906002)(5660300002)(8936002)(8676002)(426003)(44832011)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:05.2741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6b28b2-7ced-4807-a2c8-08db81c6cd6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
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

Make clearer in debugfs output the difference between the hw
feature bits, the features supported through the driver, and
the features that have been negotiated.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/debugfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 754ccb7a6666..9b04aad6ec35 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -176,6 +176,7 @@ static int identity_show(struct seq_file *seq, void *v)
 {
 	struct pds_vdpa_aux *vdpa_aux = seq->private;
 	struct vdpa_mgmt_dev *mgmt;
+	u64 hw_features;
 
 	seq_printf(seq, "aux_dev:            %s\n",
 		   dev_name(&vdpa_aux->padev->aux_dev.dev));
@@ -183,8 +184,9 @@ static int identity_show(struct seq_file *seq, void *v)
 	mgmt = &vdpa_aux->vdpa_mdev;
 	seq_printf(seq, "max_vqs:            %d\n", mgmt->max_supported_vqs);
 	seq_printf(seq, "config_attr_mask:   %#llx\n", mgmt->config_attr_mask);
-	seq_printf(seq, "supported_features: %#llx\n", mgmt->supported_features);
-	print_feature_bits_all(seq, mgmt->supported_features);
+	hw_features = le64_to_cpu(vdpa_aux->ident.hw_features);
+	seq_printf(seq, "hw_features:        %#llx\n", hw_features);
+	print_feature_bits_all(seq, hw_features);
 
 	return 0;
 }
@@ -200,7 +202,6 @@ static int config_show(struct seq_file *seq, void *v)
 {
 	struct pds_vdpa_device *pdsv = seq->private;
 	struct virtio_net_config vc;
-	u64 driver_features;
 	u8 status;
 
 	memcpy_fromio(&vc, pdsv->vdpa_aux->vd_mdev.device,
@@ -223,10 +224,8 @@ static int config_show(struct seq_file *seq, void *v)
 	status = vp_modern_get_status(&pdsv->vdpa_aux->vd_mdev);
 	seq_printf(seq, "dev_status:           %#x\n", status);
 	print_status_bits(seq, status);
-
-	driver_features = vp_modern_get_driver_features(&pdsv->vdpa_aux->vd_mdev);
-	seq_printf(seq, "driver_features:      %#llx\n", driver_features);
-	print_feature_bits_all(seq, driver_features);
+	seq_printf(seq, "negotiated_features:  %#llx\n", pdsv->negotiated_features);
+	print_feature_bits_all(seq, pdsv->negotiated_features);
 	seq_printf(seq, "vdpa_index:           %d\n", pdsv->vdpa_index);
 	seq_printf(seq, "num_vqs:              %d\n", pdsv->num_vqs);
 
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
