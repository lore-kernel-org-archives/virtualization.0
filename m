Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F020FEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 23:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 55E65403C8;
	Thu,  6 Jul 2023 23:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55E65403C8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NSReKHlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28Aj3NiR22BZ; Thu,  6 Jul 2023 23:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1962400B8;
	Thu,  6 Jul 2023 23:17:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1962400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E23C0072;
	Thu,  6 Jul 2023 23:17:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9412C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DF6B41924
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DF6B41924
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NSReKHlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cXpqu7AuzrSv
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:17:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55412418FB
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::616])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55412418FB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 23:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpo6ykLbcjcm3MZr/TBgYGZp9rzFInHL74JPqAUwnPM+E44z3uyT3qBDDZqNomqq9X1V0LqrOB3UpbTTBzsF8OWob/OIMhtPK3ftqHnad1mvFOwz4lX/5hveviYvyBpwvXxzgjyl+N59WHGatSE24Fd+Jh4sWlj4XzC2NAXqZgo6cbFLvF5NzCeyfH3y4Up+5nsVUPqAtlhG0xtCBmjaR9AdN1WM5i5NnELxIqbfq5Fm39pQ8fVxL8IrM3iPDv3jdZ/1ajWRlzrHtCz7tdCdcIWsAyPYKKIQdGukbeUpy5ON25Z/B3xbc2UzGZQWcOvqmUMKdPxFMuqaHS+8HGbKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2uR+tZYMebNpdyh3FCWJEs8zmJnm06UK/gcEuzaNWU=;
 b=I5kgH6PzUUTccQgHNjwhlae8i2lp1mTBrjNHhMQUfA+zeoeEDk5V8cpHlIPqpLuiwKHL4iP+Y7pNF5H1Iwxfyb4v5YxD1ddZRa8IzO8WkiR+LTsAsZpKp6hi14hSNYiTMYBRoCm4PakvSJUfSnPYSZyblGNkCoZpEZtP+m4DQYhRckXL+u9dcqJ5z+2ubMnlnlTgUYVDA6Hqq9CcL7FgbntghAzHGAbDQsKZihXxlbGQFhaNmv6dwrpqRZGAE0w6swX5/JJAQz8xVlQPVnNa0pywUP1ExrzJ6otUTbaIxeZKGDXH3umnZjI7DRTdYuhg3kMDHUxCNiQ6xnevt3kulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2uR+tZYMebNpdyh3FCWJEs8zmJnm06UK/gcEuzaNWU=;
 b=NSReKHlbX4hPfg3Eys2UqLHXhv3J+RjjxSBPDWPmL2CQxhiSf23b2eBnbKEBttPNxg+vbNlkCh6YhURqjgtkkrKGnMSyfdvfJfocIxRjYKazm0wE8fNFaHGOjujduAYWlNSLKGQksc+t0F2nnQ+Dtn7Am514ovtAbyDz68wvyS4=
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 23:17:52 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9e) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 23:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 23:17:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 18:17:50 -0500
To: <rdunlap@infradead.org>, <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>
Subject: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured debugfs
Date: Thu, 6 Jul 2023 16:17:18 -0700
Message-ID: <20230706231718.54198-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 776f3dd4-f7fe-42ab-5b1e-08db7e7738cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zvf2U5vb6YJG0t2a0j2qWAOzMUS6rsU93U8Esr3lcg91P+DGwOJgGOLjbcnJuZxa5n+StmIc6VYWmCosaY9DMfpQveltVMB33/0wXZwlGvsCiqHVevmsLMX+ZvO8tupBUfc8As+JaZpgQBxF6F0sT5Z6OgV77RikvB5N965GC3tAjLdsjfVGuXeH9wfsAXdill2DgDaqV66uVfXIS7gYlP9Jgn1a6hQF08zPh8WXz6Py1v5CAkEL6VXs1BLhFC8wN4RMeJDfeSUPBLHns8n93eGsRuHhA+fJnN8eETKn9ob8qhAPCPoOxY/5mN4D2U4Hdw7+/tAive0ZYXKxwbpf2BwYiTkfD+AICW0/Q35fg420YRPTamFzPxoG+++RLjK2G1mKRofaDCr0eiTTUNHpCb3zDeVhiMMkRVFgPipth50sq17UPqHmvMSqa3Wexd8RyPeggUsu60tplVEkhD7Hn3fazSp8tKkH6gbD29xvefVpV7zAsqoLwn8gHJQ/QmXzALgvviKvyfHg+VDErXzWm3vs9L0FsI2zclYXce0ZQD0J/9qe2701gwZZLLxMDZrxdAdXTv4T8xwVc2I5R6C6FKgCo7IMK8l3UTO4XsKybzxPfOXH12EPfjyJIcmS3YKiTbL7Et9xJpWvrCEyo49mQpAZbnwVl7Va0J6Z6F5PomEE/zI2fZSobEz4kHdyJ8gsoTI9Vp1+uZDCRlOVL0gtCFFnWJoBtMMA0ZznonWau6y8atnxRAEtrD1N64y3EcLz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(4744005)(5660300002)(44832011)(86362001)(2906002)(82310400005)(40460700003)(40480700001)(16526019)(966005)(47076005)(186003)(336012)(426003)(36860700001)(83380400001)(26005)(1076003)(81166007)(82740400003)(356005)(110136005)(54906003)(70206006)(70586007)(316002)(2616005)(8936002)(6636002)(8676002)(478600001)(6666004)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 23:17:52.0659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776f3dd4-f7fe-42ab-5b1e-08db7e7738cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
Cc: netdev@vger.kernel.org, drivers@pensando.io, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
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

debugfs.h protects itself from an undefined DEBUG_FS, so it is
not necessary to check it in the driver code or the Makefile.
The driver code had been updated for this, but the Makefile had
missed the update.

Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a76f9@infradead.org/
Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
index 2e22418e3ab3..c2d314d4614d 100644
--- a/drivers/vdpa/pds/Makefile
+++ b/drivers/vdpa/pds/Makefile
@@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
 
 pds_vdpa-y := aux_drv.o \
 	      cmds.o \
+	      debugfs.o \
 	      vdpa_dev.o
-
-pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
