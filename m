Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493933C08B
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2cduUeuQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A981683829
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A981683829
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2cduUeuQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeFZF41f4eWa
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 22:18:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE390829BB
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE390829BB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0+eQ+5yLfw8zWaYC+yk7VlnC84UrqTf6vnOPZXTBkukpFQuYRkRg44cP1MEt+K6JWjjBnSUtqPQFyziRMQQxDMBU9PUzWjdJTLwOtps6gSbSsmb3VpBVNKvkASnC9eZGw0XvR/8CWZqPYRJXnborCM9/O04JkrnNAsTnh5C0GMw4JcbvTT1szfTmcoxX5KIhYLiTAb3NFvy7fHo0KQl4VaeMYDEixu3B9VRlVdpAu15yEmZcSyBnspykdl+Av+3ruKL46E6BEaEcOcnsQXCrXb/ZPifPy+CkX/es4TmayIFkn18mtPbiMu1SihsWg0DEIFrbpbtUcFoDfVOJtn0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwWQaicKI/LagF1h0UOKHfiUQWlsLJF7DKDdhr2UlYk=;
 b=F/CCk6D5lsHMRygRwcC1SRFgSMm1LMhsmc6XsqHx0f/uEoB7u4FNmmmnRH/4p9pZp03HaqXbSZs/99Wu4scSnyTXq7kj9ww1HstlMs+YxZSKfuFCwcxwrDmxH/UozQ+Nb5f/xcaohCZE5cMfTX04M2oYV6jjMn/UM7UspdDtNRJfAb94pvjb9MpaakgPvBH4I72/BPUunp1G+Hvaet9xbry6Wi5EJNLPje7VTNHNdukFaTyd6uzfz88+UC9mXhROrtDeIPaEITN7Rs4XSK/06HJsLEyCKTBbV5/qH8DWWU2txar2upGOFMKteZFF3Be5EC+4PCHFqBlFT66SdAlqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwWQaicKI/LagF1h0UOKHfiUQWlsLJF7DKDdhr2UlYk=;
 b=2cduUeuQD0tQwb0Vr6zWYP/OktQummNbDJDM+VPh9szAdoNWQ/iOMK4wydzWeM80tgqc/i7HuvpcVY8suFweEqTbC5BTcsY1wDZWknAXBr7IOV0R3VaAy96B7yAEO2x058vvOQ4tkiBNCoK3NiIcZQxc9KlRRBWBUkrDuUGcPD4=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 22:18:20 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::4f) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6977.21 via Frontend Transport; Fri, 10 Nov 2023 22:18:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:18:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>
CC: <lkp@intel.com>, <drivers@pensando.io>
Subject: [PATCH virtio 0/3] pds_vdpa: updates
Date: Fri, 10 Nov 2023 14:17:59 -0800
Message-ID: <20231110221802.46841-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: c11c138f-36db-4f12-c585-08dbe23af1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K2o3XSszs52ax2DeW3iybuBHKwMPltqnorbrcJrBWPvdDD/fXqX/7QpKLQvGK3PmLatQBv9K0Ibfu/C0WkifotNuDA/qKLyQpKYTbqlHMQMkojc9vCJG1HV/EYEyCc28tlc8ZNcgat1qjqdWR8UXCP24rk7Wv4BNy1k4b7a8cKMI7Bsd5gx3lNWcypQCr2+EDsDiTZ/VxxRX3l5zSt6jeoonxQoGaMNe8IpwNR9hQpMTWjBnhUJW6u6Sib2hYVSEdnWXI58DTqpH/p44FWvXKsMhLFp2OOAbp4cyEpvjlyQfbbLCMdLYne6PMOdVWURQdzA/zfOOOnGxDAXqrj0KKvQ9ejXH1LGQGWD4+huTivDwIZwBneuXM8vXMhEWP9hvnaa0ipr4xcEoQNQTBvF4MOFqpBTskC/7P3XJLHi2YNLqLI2shGx5Kj43WqLVNwCc6C6+zylvEsZPApda9hjAptP8eIpgmTbXYyxXdmy99VaouP9AR6T7KgsASigX2m8DMxkhsGrlE0lf3lY4OaAXGJiZvK+DL6Qj3s2rdr63GVL+rAH7m66yrWCHXA8rl73IISQV3DUkUCyKTGqeytKx7s11Asi8tu8pt6bWhI5+cA+XOQPNe/6QgvCM7gTGqABxuS6HXipK/Cp/AxPI8yyjkWaFsKbuCo9J7/zt6UVB4P4F9WnJRsOemOEBhb7hCvQW0jeXLuLCW34Yo+YJhaJUP5w+UR/5zxXhqEhw+PVsBQYcjwyNBSuzZ8Uqn7KRYmSngNivy/gtYeVjHt6SQu/LjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(16526019)(40460700003)(36756003)(44832011)(4326008)(47076005)(336012)(478600001)(5660300002)(2906002)(83380400001)(8936002)(8676002)(36860700001)(2616005)(54906003)(6636002)(70206006)(26005)(4744005)(70586007)(316002)(426003)(110136005)(40480700001)(1076003)(6666004)(86362001)(82740400003)(81166007)(41300700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:18:19.5026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11c138f-36db-4f12-c585-08dbe23af1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

The first patch cleans up a kernel test robot complaint.  The
others are for a couple of things seen in further testing.

Shannon Nelson (3):
  pds_vdpa: fix up format-truncation complaint
  pds_vdpa: clear config callback when status goes to 0
  pds_vdpa: set features order

 drivers/vdpa/pds/debugfs.c  | 2 +-
 drivers/vdpa/pds/vdpa_dev.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

