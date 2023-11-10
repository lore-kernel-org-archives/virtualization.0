Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF03C698
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mrMSWEw6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2768142851
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2768142851
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mrMSWEw6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYgaRSzmYTTi
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 22:18:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 44D944284D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44D944284D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3pTUTtiuRP0VCwKguak/CQM9bDAXyzwA3tcI2GHldPbw4e9g4N4ZVDWPbhpjC37KBR0fYmXLhRuUeQKRCQoiIR9OqUJnejfTymOnyLwync32eTdNafP6/vWUPbaicOEvEHp3//1tr4+6qZiJ9Ppje/XPpdXr7pCKidJ9FFIckzjVXcAvMMKi7I2XX2zlPvVlMhVd9niRSynrLhTC9IetVVFZuAgTmurmeI6pCQY/ktPk3O/AurbTuEKf6dmkE1oqu/BpIuXDAONCOiNrLssaFNi5sxYFITLIqlyIPlDXdexUdSFXeWMR5xScOqwEoUUKF7dqkLrjE/pzZyWnpeWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIBvvNY7j11am8iTow9txhUXRU38aM6QGWTALBZn4nE=;
 b=eVIicM1JCR7C4GrVOZEzGXe/+9VASJ/A2vUZNOE4b0rJ3rB1AHNqt1J5DHzTHYY7+WKFpKTlNQAxOXxUJ6436i55CDB4n44u+2l39jnqifRyzhpBjXwLa23bWzrVjVcS9M8Z0AtQa1GgjI4woBobFH7hlvrdHRwxKevdUpQA8s703ynB8eMJPXfLurTxfjD1PVKnlsiqNskFGqjO4+XF6JVZd5EPezdc5WQ9BWGOSYTSVQorO54PQrrqO7IkspwiH3ygwZdX+4mEZhKTta7SW4AWwhc4t3ow4DlG+QG0lKi+L24b45BJMeoDyVW0Hf5pxKtoZLmdqeytrrwWFaYghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIBvvNY7j11am8iTow9txhUXRU38aM6QGWTALBZn4nE=;
 b=mrMSWEw6D5i3LnLK4EPnEwyL+QOdoRszkv9vylxBo8Zb+fNqmklyHUOe3qsGbytxLWtR/6BGga8wFNFyE9kAAKESQXxOv9nV2j7AGRuW6rKaUT50CDohgk+To6LUIHd6QWR3PNXF1BlvxmYmamNAz3Tm9zuNrFbWCyQ0WvwsgKA=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 22:18:22 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::6) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 22:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.21 via Frontend Transport; Fri, 10 Nov 2023 22:18:21 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:18:20 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>
CC: <lkp@intel.com>, <drivers@pensando.io>
Subject: [PATCH virtio 2/3] pds_vdpa: clear config callback when status goes to 0
Date: Fri, 10 Nov 2023 14:18:01 -0800
Message-ID: <20231110221802.46841-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bf3284-a074-4baf-52f2-08dbe23af341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OYi3WuauDr6ZtpPl0GYt7vRc8735XxutxpjqR5ERf71oEITC5ItXFv1rPMCdLHWNOp9p97Vg7S7Yqc1uRj9L6ipwgj1m0Iv0eLR1li/+eR9aijMQpBu9rV3OKcaTYkgvbrgRiEUoHzzIvp16225yG3V/Zs9yp5sQNUF4X7nMNB2QttyTeuqk7DTktIMw4p3kuVAZ+ifZfMsM2GEF+MbggjFpfOR6u9gQaT+LDK6WzJzgZyHSb31zOUa5uOXWOjnTB38kM0HZTa1QDNtXz3KJk9tadl5/U16+9bJOHUYUo6Nlg8sCkCUolph89ruIF8vRuP2HuokoYPS2MtDPhKRpvRDjUrL39p6ii/hcGiH5bZ3Y1BqIyIacyT1lEvGU1Vv+ZpACb4QC9g355O3yV/9AjEEUYNx9Kj3JANtAJJ+7OHO1nsI1oNqemiJb8FHY6oMVVD5OXvcCtvFI00fvwTJ53HhUQvazYOmuM9B/fdee1WZXRLqTuGIbQB0akI8mJ3Ow6D3+gOJ7VOLdf8bUx0uRpURgSzFtMVzXL4H0dHtc2645OfP4VT65lat2NZOvtvg321HxknyKHFf+4sHVThl84DB7VhxvsgK7NIVhcjlNKPkSSvwrMd8UcyOc8xUzxLJ2PAhionkWXfIteiX0YWYCWuRWWL06Qyv5e3dzu+zp53xDc0RZc2akMxqlfzy9TR83Z8sggYApMus884nyzxNQG1EpkryomRvLRQOa/UN70SaPPJFOTi7gfI/SA7Qfc2PpcUj67axVJBDpJcCJyIDDqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(47076005)(44832011)(8936002)(8676002)(4326008)(5660300002)(2616005)(478600001)(6666004)(83380400001)(26005)(4744005)(36860700001)(2906002)(1076003)(316002)(16526019)(54906003)(110136005)(70206006)(70586007)(6636002)(426003)(336012)(86362001)(40480700001)(81166007)(41300700001)(356005)(82740400003)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:18:21.7994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bf3284-a074-4baf-52f2-08dbe23af341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

If the client driver is setting status to 0, something is
getting shutdown and possibly removed.  Make sure we clear
the config_cb so that it doesn't end up crashing when
trying to call a bogus callback.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 52b2449182ad..9fc89c82d1f0 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -461,8 +461,10 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	pds_vdpa_cmd_set_status(pdsv, status);
 
-	/* Note: still working with FW on the need for this reset cmd */
 	if (status == 0) {
+		struct vdpa_callback null_cb = { };
+
+		pds_vdpa_set_config_cb(vdpa_dev, &null_cb);
 		pds_vdpa_cmd_reset(pdsv);
 
 		for (i = 0; i < pdsv->num_vqs; i++) {
-- 
2.17.1

