Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74C2E4257
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197243; cv=fail; b=Xckzopw2sUFk5trz5Gb2t5ypPsmICAYCHyAAfOaYB0gqpXrY9Xtq0LyI+4LgVegMiu/cGKYh5J/e88VLwMu5Qgq9Mt5vyid9kVWc25onwA1qKAVdMym0pj2FK0Gz2XucuvSqGjouCcGb9KyxQsReINa61qRSwcPmSW6GcKa3VLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197243; c=relaxed/simple;
	bh=USMfXx7Cx5T3ciUTx0Oxe6IgxgKNfjAeKZ4i8YY+GgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnYpl6wxashrDuALsVpUYs+jdY9o6TUXV+TmSBB0zhGqqGhMS3+GUCVjXAcD6Pl98vYZ25/Z76nKiFiGRyvUDFq5QwqreS1+cztfL3ZjRgWctAbRjAdHEWqzKdBw12Q3xdbhOBGjqtqwRXYiG/VWuduWkDqH6bPInmV97Zs9Njc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFDkvYad; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFDkvYad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZZuevFBbclYIZurKbGrC+nXzu+Y4O189UZz8I2Y2IuC7T1CbPumglKzYSrf2Q91ixtcxcRk5K3c3LlMTEek+gqhtLhoywnUmTjMnL7jCAYXCtucC++dkU00wLHYJPpQIFqaLfLUQ6dD4tVq1Vmo4g236TixslmcCgDSYUsHoN5MPiTHvLGRpEkYyfCgOxdSBvfWTyNxrhfNXRDnDyDxaD99MIsg6PxADGD1jVEvFJpeJcLQys029EbEynK294KZISGBWSDeh1vL2sCiRqV787SnPFcPMsbajpoJ3RI1s+j+nJaV0IjXsu0S//vckPGdfqmfeXxJGkleXijK/sHahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aiU7l1p7UPNfNz+gSmxFM5wxtXft9Y9MlvgRV/2NmA=;
 b=zUybK+Om3ht3742tHYqgLuXp/Of5emMdITrl40bxe15fDwSWXCgxIGKirPAURdsvgHlSj2cv9r+nm6Gc4D8VD1ZFqjYnKa/9fueD10xIoEx5VMNwAM6ES8nX4G0Q60k0awfeLEniBB2N44K185GXORLyM4ErZHBsDLWkp0tVqw//0WoMZjZP7PNxQn5yCG4odzGEdn8pACSfsLalZwUZdj8D61CQjDa1bZg34FghwgIZgSem7PJs/Itnxf9esRvhfNDXjuqyVIJP6c5tkqyGakNU2LmpMy9JG5cr0D/CV7Cgim4Ha6BVrqSdoGoDikkLGZAKoPgItnD0muJh8l/laA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aiU7l1p7UPNfNz+gSmxFM5wxtXft9Y9MlvgRV/2NmA=;
 b=uFDkvYadpTUzKscv5kflS+tRJ5UY6ZXkzIddeD3b31UfMcV6nLlJERwrbdUEsA7vfiCQ0MxkUUrxHEBW8+6hW3PFAzuUZ3isw9S/K7/jVOqIH+RJo0Bw2KSovB9y25q9hrqtFZHou9sVI+vwwqFxbQynqWxxAtl1sRjLLE0VGMvY5em1Gfg1RloneMrojZdqvpr/Uutl5a+rxsKQnrzbznFCN4DUOSmn0nHbuxdgjAwdN7ydGVFTjt5TZvyM4TjZueH/aqgjXKA1GhmTG4FTrAZY5Ck1lCuVJQR/yZaBwOg6xoxU9svNrkaBqegfz7Omvlw908g4vYar2rdwvPy0xQ==
Received: from MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::29)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.35; Tue, 14 Apr 2026 20:07:16 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::6e) by MN0P222CA0022.outlook.office365.com
 (2603:10b6:208:531::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Tue,
 14 Apr 2026 20:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 20:07:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 13:06:50 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 13:06:49 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <yishaih@nvidia.com>,
	<kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 2/4] vfio/virtio: Use guard() for list_lock where applicable
Date: Tue, 14 Apr 2026 14:06:20 -0600
Message-ID: <20260414200625.3601509-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414200625.3601509-1-alex.williamson@nvidia.com>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4ff3c6-f5cb-4002-d44e-08de9a616b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HZEamY7jTRcdjdDGtm0F7IW7EduF/D5DzdQiTzM4yruR173+4jgxHKHe/dbPcswO++iboub9UqewJ+3RW48HLdK6ZO4DQBXspWfPHdMJZPr1lxVkMbJWogaX+eECZct03ZWa8ulp0BQfBotqoH+drSvAauxYsph5xM/IjxvHdRF8e7sHlduDfQV9Sm007jAXlP1MGMtviNhvKs2rorl4vgGv6+RK/e6o1PlmZb7uYQA8M02GTeWJMMTH305zIRTBVPCmpq1u7+TsoJzdHbrRPirEU7GUbvTycVk2Ko96AFxBXX3kpkqTso3FOO3gLJ48wlpOmVnIoCOm4xHxI1Y4waEKdmkwrYQ7++VUO44rradv4M5nwrMemBx4+HxS5gWJK2OW2TzUzZzlPA8Ow/gpoYT+7KiA2H930AXIPegc2xVLEM5pYxGm4F8T4kwNjwpQnSRyzmpOzfs/hf3IGTtXDzuag6ZRzdNZZ4SgCAy4Q6z4sd3ELAt6jfFGjoJrkpzisGAlW9BOPfk+EuZLZ2Z3osT1zGK1rxjnRhoVzTgqXIYRtRp2Mxt5a2NUTSz7GuGZBCTMSB+GGldnhwsuLO3WfTAJQKTEhx3M7nxK594mAGx33qFpADpuM3HdEAPCg1HNzai9/8zt+pvnvXs01WLDlqm0e3tEhmUipWFdWanYhvcN6fkWHkNVp0+bcjgQ9SJuIm+NEVU2VtQa1MPGckugyeDLeUuopPhTPHUpao1EAbJREih/gpgVj1JhKRnyGzwzv+/RKJOYQFkUA5kRUidnjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eCyEDX7szvJO5oghhMn2tk5KFebFyyVWebg7/HEvaVOQj8eYzTD0Sf4KAlDBwDSpK7Ums9HZ+C/U1lxZJV5eLXOjBhDACwt/g4Vch56ZdiYNvWhP4jnMgiVHGGVVvy7ZUG2lkEHa4SSu0vDglKJstnLsG101rAxXQOzB5y4IQLwexqVQxCbVR1TTQj/ztmBeOKSEuywzMddgVXzaMhzzIZXYYyMQNRIQuPHZa868JxXLhSmoqX+XysKl5hx4KYnAT8XWzHf27NepX2pHyR8o4btE13u47pwCOZ+UCK849JL/BOArNZ9z4zk+2R0Co25rIMWX3j3kDFq6lvvf7bvVEWE9IVH+O9VQR6YP6qXJzyU488ncaLKyXVNfr2Q0SzuyEQciMzJ8rpJVspgRMU14dFwGQ8jxcf2TRt+p/2XI83lfXKEteSHmvgHa1dEbHJyJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:07:13.7565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4ff3c6-f5cb-4002-d44e-08de9a616b81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

Convert list_lock mutex acquisitions to use guard() and scoped_guard()
where the lock scope aligns with the function or block scope.  This
simplifies virtiovf_get_data_buff_from_pos() by replacing goto-based
unwinding with direct returns.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/virtio/migrate.c | 37 +++++++++++++------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 15fcd936528b..058d359c9b5a 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -142,9 +142,8 @@ virtiovf_alloc_data_buffer(struct virtiovf_migration_file *migf, size_t length)
 
 static void virtiovf_put_data_buffer(struct virtiovf_data_buffer *buf)
 {
-	mutex_lock(&buf->migf->list_lock);
+	guard(mutex)(&buf->migf->list_lock);
 	list_add_tail(&buf->buf_elm, &buf->migf->avail_list);
-	mutex_unlock(&buf->migf->list_lock);
 }
 
 static int
@@ -306,32 +305,27 @@ virtiovf_get_data_buff_from_pos(struct virtiovf_migration_file *migf,
 				loff_t pos, bool *end_of_data)
 {
 	struct virtiovf_data_buffer *buf;
-	bool found = false;
 
 	*end_of_data = false;
-	mutex_lock(&migf->list_lock);
+	guard(mutex)(&migf->list_lock);
+
 	if (list_empty(&migf->buf_list)) {
 		*end_of_data = true;
-		goto end;
+		return NULL;
 	}
 
 	buf = list_first_entry(&migf->buf_list, struct virtiovf_data_buffer,
 			       buf_elm);
 	if (pos >= buf->start_pos &&
-	    pos < buf->start_pos + buf->length) {
-		found = true;
-		goto end;
-	}
+	    pos < buf->start_pos + buf->length)
+		return buf;
 
 	/*
 	 * As we use a stream based FD we may expect having the data always
 	 * on first chunk
 	 */
 	migf->state = VIRTIOVF_MIGF_STATE_ERROR;
-
-end:
-	mutex_unlock(&migf->list_lock);
-	return found ? buf : NULL;
+	return NULL;
 }
 
 static ssize_t virtiovf_buf_read(struct virtiovf_data_buffer *vhca_buf,
@@ -370,10 +364,9 @@ static ssize_t virtiovf_buf_read(struct virtiovf_data_buffer *vhca_buf,
 	}
 
 	if (*pos >= vhca_buf->start_pos + vhca_buf->length) {
-		mutex_lock(&vhca_buf->migf->list_lock);
+		guard(mutex)(&vhca_buf->migf->list_lock);
 		list_del_init(&vhca_buf->buf_elm);
 		list_add_tail(&vhca_buf->buf_elm, &vhca_buf->migf->avail_list);
-		mutex_unlock(&vhca_buf->migf->list_lock);
 	}
 
 	return done;
@@ -555,9 +548,10 @@ virtiovf_add_buf_header(struct virtiovf_data_buffer *header_buf,
 	header_buf->length = sizeof(header);
 	header_buf->start_pos = header_buf->migf->max_pos;
 	migf->max_pos += header_buf->length;
-	mutex_lock(&migf->list_lock);
-	list_add_tail(&header_buf->buf_elm, &migf->buf_list);
-	mutex_unlock(&migf->list_lock);
+
+	scoped_guard(mutex, &migf->list_lock)
+		list_add_tail(&header_buf->buf_elm, &migf->buf_list);
+
 	return 0;
 }
 
@@ -622,9 +616,10 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
 
 	buf->start_pos = buf->migf->max_pos;
 	migf->max_pos += buf->length;
-	mutex_lock(&migf->list_lock);
-	list_add_tail(&buf->buf_elm, &migf->buf_list);
-	mutex_unlock(&migf->list_lock);
+
+	scoped_guard(mutex, &migf->list_lock)
+		list_add_tail(&buf->buf_elm, &migf->buf_list);
+
 	return 0;
 
 out_header:
-- 
2.51.0

