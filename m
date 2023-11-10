Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC903C698
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T8IHJw0n"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B04D60C0B
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B04D60C0B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T8IHJw0n
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ArvStn_RX1_S
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 22:18:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::617])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 913B160A69
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 913B160A69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeQu0SqDW5DKLKByze1+a6wIUv7J8cpOyylTXsXAtmrmZTChSvPfX+eNsQk9hFkqD1pffLNa9ofgkx+dEwQ7x2+gFQxc1OzjWpQeaAmLqdUWLlu+/r5S9G0inhhqZ3OzTp++KqQ8taaU4qW8DVeRzIutr5+GH7BPkszoYF0gL9JeDpBBU+rOOUeslyE/qk12lJyahuAJGWprUvympjnYTUFwwUt3Ej9uVUXOuq8/wpFbPewpy8Mxfklkocg9ZNNJFwV236k55cxMK/l0gDR7sWCCSXSV9WItJuLyVrDoymHd3rx05KwoYCETq553ZpH1NNGlmTJoIdDaIfezTknzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7vMuUyhsm4nTJ1nS7X5f4Fcnb9VKBQ7c5s7QnQ8b/M=;
 b=E0aGa5lLdG9RqLoT9ExY/oJ3RWP9VLCYMP6dCQh1XHPGSGkxiqBx+p2+IveaUZ9/EH71wHqLhSjF+Y92xpB08oXipsUW2+FX+6KBHMFJfnhxBUIvurNaVN27MEvsKddbMMaQfA1rb3Ey1VwIqX0eesC3yyG1z0CjOQDV0FB3DIxqOLkfO4BiMl0FLjT82YBYqsAE8s9tf+xRsMtbLCmrUX+zvESKDT7xzGD2pfT2N3pZ2svzyyFJfU6kFcJpYjE7mFvk5LDpra3H4oLFnghrmm0Ie9N27cte8LFtpp9//VgLqcLzZ52NPuoZBWarJM+OBVEciS7NMa7QlL3PxJMb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7vMuUyhsm4nTJ1nS7X5f4Fcnb9VKBQ7c5s7QnQ8b/M=;
 b=T8IHJw0nUFPqCPIWGkusxDxg3kh30sAwX3t+Ke/7UKhZJ77YtCXWOs4DWeCAsgxQm2EV+cJL4avBA1tvdjLZyGFcP/Dpq/YmB1hPPjuEMllhLT1ZFRScR3ZC65tgfVFZbDfSMv7VFDZlL6VmEJLmtKb32mHJ9V0/P6ZiC+9gbJ8=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Fri, 10 Nov
 2023 22:18:20 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::75) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 22:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.21 via Frontend Transport; Fri, 10 Nov 2023 22:18:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:18:18 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>
CC: <lkp@intel.com>, <drivers@pensando.io>
Subject: [PATCH virtio 1/3] pds_vdpa: fix up format-truncation complaint
Date: Fri, 10 Nov 2023 14:18:00 -0800
Message-ID: <20231110221802.46841-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231110221802.46841-1-shannon.nelson@amd.com>
References: <20231110221802.46841-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: f7267fac-7150-4692-9899-08dbe23af263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SqSvrjXkYONm+Xn5sPUJdBYn+qVtPU1v3tHQ+zTDActzSMDnEKB2ryvGYL6RHI4I4BxmTwadnssV3yHZHT7uu7ZXK2cr92f4/AJRrorR8U2/pBI1rcQ2kaojse1SVNd2+zG+6M6SNKIZejC0kziAIeASza0DyCIDpo0vtKzOncCEGE+8vKQAveMIWys2c8fg9w240wWgJmxUXAkJ49IV+Y2xr+Qq47YMj3Mc1XosC22cPuhmBkiEGDDHdzBnGeiiknSDO6k3G3fE3YyPLdkgqyq+nmDfUK3V70HMzf56Ze8elQQUf5WkeAHdww57ihIfiSjbaJsTyrUnBre+La/ypc+8KZxLVkP803ZEVYw4hrNMmfpYICUIHqHK+VVHwiQ01lDxvdWvBnt4NHYz07SsBOPF48wNO4AcXvzEC+GM2tzvjF8oSCLfMwyDO9xr+/xVLXFqNOvPD/hlwWuQbkv6Jjlc6rHsjVEgWqR+yxxvJpTw8/nwNJKezll7LCoFeLepQmDABOBRgkyplhtOQh9aAsEP+cpNe2jq7YJaIi6xBZqqgoODxgNBZ9ASAI/x2NzIsuPgw2+LtePiIUu737KG/QnI6lJUcP0AXsn5NAMAHCdqYKEFhslyLbXgRnKlmOiDmclUpAIrmETDt1SbI25ms1uQbEH9spxj0oeoVgSwQ5FfY9wLW5MkW7RCN+K0M5WeQDQdSNln2UF/5NQ5E3ZHsyMuWsoxretEueBZKxGCcBIYq4FRpqhYmj1VnHc287UmdKMNEirxeJO+KjNVOI9NSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(70586007)(41300700001)(4744005)(44832011)(2906002)(40460700003)(356005)(26005)(70206006)(81166007)(82740400003)(86362001)(36860700001)(83380400001)(47076005)(478600001)(1076003)(6666004)(966005)(2616005)(336012)(16526019)(426003)(4326008)(5660300002)(316002)(110136005)(6636002)(8936002)(8676002)(36756003)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:18:20.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7267fac-7150-4692-9899-08dbe23af263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

Our friendly kernel test robot has recently been pointing out
some format-truncation issues.  Here's a fix for one of them.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@intel.com/
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 9b04aad6ec35..c328e694f6e7 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -261,7 +261,7 @@ void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
 	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
 
 	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
-		char name[8];
+		char name[16];
 
 		snprintf(name, sizeof(name), "vq%02d", i);
 		debugfs_create_file(name, 0400, vdpa_aux->dentry,
-- 
2.17.1

