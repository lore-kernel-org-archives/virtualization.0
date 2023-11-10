Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCA3C6BF
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V2J+ToTR"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D38A42851
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D38A42851
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V2J+ToTR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vl-MkBzFOdB
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 22:18:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::610])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C43284284D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 22:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C43284284D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRYc5riP1JJRFMyfBWpkN8gwbfm7nh7o92tvkWW7fcCD04WyoFh1Ggjl4uNRvA/gsnQE4VKMfnAq3AM/FdbMgIqnDjJ39grgS3YpeUXIFhQogSWbDjlDEaWiqJNPWq0TeVEo/QmWKXUGUHjJ3CZTuI30/qYIZL8XDHS9faI9mDgiXguzKtqVfgRLao0stiO+xH1DaJoR80Ffh6WYNbi+9kvctKLpb1KrQAweTcCjMqt7XWg2WXBb9szkVG3qLt7KqZV1GrZdV6ixW0hJy4VcbCTNrmqi7txzMbEkK1HD2gbKj4YniG09HP6lhX6FqN+UcJOJTTF6vQrCOwC8NafmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK1Lh/+MaB4xCiLg6Vj2v6CeGe6bwCBv3dvOleIjXHU=;
 b=U6Ivsev+GKC8Glg9L7tskThkoS8hZg6J2UuJTCHE+QGWP1VXxkzz4Ki4eDYOrBfyL24IebhjuYfMFsJcV0X7xO9Idt1hGmZCu6LBsIoLpL+4MChqtX8M/oC6xeHLtXZhqehKFRBcFk0/8Hc/9W/V6PUh1ZjdI+rntDP0+tSNEgNOgtpldiAdec6a7irQMr/xwG0RRryElXmT6lUiyBMaUUMeqO3GQz9+n5EkM6ahGwQP5QCi27SLIXkD8/jPfxI5CRpQyP+liOPQizEJsMYb3e6uyyMDgfcIfV8UZVLofpLfK/pC2vXjKanbjXvMvIwmt0c3TANjlk0VxtoBZ7eUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK1Lh/+MaB4xCiLg6Vj2v6CeGe6bwCBv3dvOleIjXHU=;
 b=V2J+ToTRUHGEFxdSS8aGHHM22XhFBJ9bXAaL5iKGUNoXckVNLlfAc6xJuCFpOCa4EeEUvnwFo2G06G9m9Soz6j+8sc8+03u1kMDKodXnwTYhfrNDe+xPpMh5N5x4GSvSAaBfeE7Rv4tNknkRI8ubW5P3Ansai5PqQXkvo6bvqHU=
Received: from SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 22:18:23 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::49) by SJ0PR03CA0156.outlook.office365.com
 (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 22:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.21 via Frontend Transport; Fri, 10 Nov 2023 22:18:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:18:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>
CC: <lkp@intel.com>, <drivers@pensando.io>
Subject: [PATCH virtio 3/3] pds_vdpa: set features order
Date: Fri, 10 Nov 2023 14:18:02 -0800
Message-ID: <20231110221802.46841-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dc46e8-4278-4bae-e933-08dbe23af3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rqmGeve/w7rficKX0nF3xByFusTjVyrrOUUritCsSyuyZPBGJk8mBWYAXUNTBjJvv7dlWMEFFoQsmbxlinElnvzfWaWl2id13FfMvNzhsjXgWIfnmOsXSSl6mD2d1ATbtUW3Xmpjuj1hDM3+j76tfQvK1zN3yKk6On2cU3W9d/g9fOuEkyjlmsYc7wQu3Drj7WGlwGagmgatNpZuA67UhG5ogPfLjtjXILLAh/1vgPoBsODNo8TubjOCXQuOcfT+KPVj5qjRH9Zb5m0AXs2Zbl6+Ia1bLLH6HKg63ouZxkA9PLKzij/AWcHA9JFp59oE1a4mII9iKkvug8Y2FMn4eNi2k0o1ZL+7Dd3roZuA5Wr4WLiLT+AwSU00z3pwm1mK32wwSEdfJFvIzmXqqQRskpdtXqdFhxC0Wn4blbO3o0ovLN2BkFI/8K7k9qLUAqfEV+bYK41Z+a3v0LZztrSTEkbeuqpCW+aUq/ERW/DHb1mIUbBKBnshLdIyma8ukP4HSdD5AL2vK+9SfPPcX1ZEeuXUDaoKYsQlJoI1l7MIIIzF675IE03XbHCpAdQEt9gkeWv/xB2FFw1oAAZbEP4j10qMCBRgy/oA4DxI9xTJBCJMVFmhL0DSy3anefPnmuJ5gaDyWkThTMs63EnYYL/uyncx71PBkRn4ib965A8emLNM03qFdpg9+I19pFJtEgZBp88yyM8Ll/SeaCOlF27FzxzJVGZ+d7G7hrqORJ1QeCUCgyqdVHlB6yFtxXt+O5fmVSlK9YfvLh0WnKat9Am1Wg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(40480700001)(2616005)(6666004)(478600001)(36860700001)(36756003)(70206006)(356005)(81166007)(86362001)(82740400003)(16526019)(44832011)(83380400001)(54906003)(110136005)(47076005)(41300700001)(4744005)(426003)(26005)(2906002)(336012)(70586007)(8936002)(6636002)(1076003)(316002)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:18:22.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dc46e8-4278-4bae-e933-08dbe23af3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

Fix up the order that the device and negotiated features
are checked to get a more reliable difference when things
get changed.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 9fc89c82d1f0..25c0fe5ec3d5 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
-	pdsv->negotiated_features = nego_features;
-
 	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
+	pdsv->negotiated_features = nego_features;
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
-- 
2.17.1

