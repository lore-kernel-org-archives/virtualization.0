Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03A6EE57DF
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 18:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30574416B0;
	Mon, 11 Sep 2023 18:08:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30574416B0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y6HCRWor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qL_sNmM6OU8I; Mon, 11 Sep 2023 18:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74E74416D6;
	Mon, 11 Sep 2023 18:08:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74E74416D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D521C0071;
	Mon, 11 Sep 2023 18:08:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B998C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 18:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3B1B81551
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 18:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3B1B81551
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Y6HCRWor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lm_LDSQULRTn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 18:08:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F9E813E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 18:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4F9E813E6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnwfws7lpPWCliH38N9pYvgxhwGvridMbxaxuidFU3TNxd3J+CtGRP6BNi36CRet9wcbNittZRO6KxHKsHxhMI0GkVQrQbWShygkkP+qRfJy1UFAJ7RlllJfRiS3ljGsurbhyhXSGPT4tTP5OiE1Z8VpD8kH1W23m1nquqAGXAIIYaP66faONQ3nSgHPgZOCBzKrCcs5qCs7WYGtnJpaS1OOyyqaD1fDeTjpyXxYkB8pb5gGD04Y6Hc938NwhqWEEkLU3m2Qpk68UH8dBFBEMFB8ocylQL9tK4qxeHgE2Wqh+AQHQJmyESBu1ypB1p4PNU/JlOXiGcNf/0pvPm/ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYADXVh8AoDrBaOSCw4BG1YtLJ4KlKykx/FaHOrKAOk=;
 b=dKEuy/LkyOppsROduW4/Fifa9k5NXbLLbcrDBLbw04UH1NVX0DzUbzirxJbuBcwytz3MlnQXKmOG63nTLOnVW+ss2UK1OR922Lqs8mlyjwiQy+qSe5bjB7530R8qZqLoRc88HcEPyWcN3JtCvXlTjv7WH+8bO4tRyAXVynD+aLGiF9cvKBmSgx8pqf34paxKOypkDG+DeQYQmGX6GkmVJHKWOntzVOR7DKBqj50CpVvMhbkmtkUYEugQQRF6Yqy7LaxTJt9WYmWZqH3H39Zi1g9h+Z3iFU1al3lCMVrPCEdMxzyjps+UD9qDF3LMrbP5Qvwr++I1k89CI2z4VQvXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYADXVh8AoDrBaOSCw4BG1YtLJ4KlKykx/FaHOrKAOk=;
 b=Y6HCRWor6C6HD2wX6xz+W7SZxnCEKsLRAjKr3RlCuvyEDORmA6wW9/BmIsG9nK+3BD8FjPAGFW0NptKDEtBSoyTR/GZEKqmHSZHJIbTSAJChurNVw2nVqvtNa63/Fo/QFSnPvnANV7tkaX8PvGNZREa8K6jDIZwirEHWvtFaEho=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 18:08:42 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::97) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 18:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 18:08:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 13:08:40 -0500
To: <dsahern@kernel.org>
Subject: [PATCH iproute2] vdpa: consume device_features parameter
Date: Mon, 11 Sep 2023 11:08:15 -0700
Message-ID: <20230911180815.820-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 5532a399-ccb8-45e1-6476-08dbb2f22214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYuBiOCTIV3/xmFo44X9mBmnBV2FTII6Skx+tQni4IXqvj9+g84UwhCi0JXX/89a1X4EXmSjgPakbThrH8O2HwnATM+G+gQOQm2zx3d6eeDRAMAH7DbCl9+/pU44+v1Xu6fJq7NtJvbIy7wbtgnPNFZETSQmACbm4SLT3nOFNfJDWGLf1/Z3jnw6jSEPcmxPr40SMLEYVUOIaAVU7+58EuHuIHrYKclxfMp3COS5BhPslmwzq1XMiFg8I7RZjNpIjNEmdFzsY/jk9nPv2ajeEklY/W+lh7d3GlNnXsqNPXqIiRIy5bq4oLTpWktyFF9YAVCiwHSJxiT1fWt8eEGtOzdvgc7/G/UOCkOTDycedRu80/ZOisvj1xxiDWzEZr5WpbnSSmn+Jvj2JDscKmwIdkwLvWmSJ4ieASqZz1PymQ6t5v9D5b4hCbyGGDsCtB2IIhrPE8hxSZgFkn92wWXFt40LNf7kbDPyBPgr76Qj57FhnzdTwe7bA7zvQGu1lMJ9QS9j7ej00bLNXjcQdx/jsTHh0T01jW7lUH1XtdGR/5nZtXzxD/rbI+nkmvMgi74oGpOOptUwdo9bA3vltfRzLG/K9mUy4hhI9E8NFYeSCHegHwHVLhh5juJZH50vGVZCmAIvN8whneu+cPtXwS9+LnjyZynJ0h8q8zm3yLtxLWnOdEphtsfE6KLQCeM6qttoPFY2d3/oj3onCpGuhmX/huwBgDy7JUfHTYqho/7Ak9lbJLRSzhYdC73Z7TYB/LDSLd3wKyksTxIeIJahtg+J7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(8676002)(54906003)(41300700001)(44832011)(8936002)(70206006)(316002)(6916009)(70586007)(40460700003)(81166007)(47076005)(478600001)(36756003)(40480700001)(2616005)(6666004)(86362001)(4744005)(16526019)(336012)(26005)(426003)(1076003)(2906002)(82740400003)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 18:08:42.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5532a399-ccb8-45e1-6476-08dbb2f22214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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

Consume the parameter to device_features when parsing command line
options.  Otherwise the parameter may be used again as an option name.

 # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
 Unknown option "0xdeadbeef"

Fixes: a4442ce58ebb ("vdpa: allow provisioning device features")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 vdpa/vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 8bbe452c..6e4a9c11 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -353,6 +353,8 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 						&opts->device_features);
 			if (err)
 				return err;
+
+			NEXT_ARG_FWD();
 			o_found |= VDPA_OPT_VDEV_FEATURES;
 		} else {
 			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
