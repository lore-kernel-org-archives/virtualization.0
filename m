Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185D6A005
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972736; cv=fail; b=BVDRKhhF/Bhe9pdSyC2Y3ccYoQT90a2tLSpymsbXUsVJaIjLAiG0wXXsn9I3bGoJZwHsx93c1Nz1NqsOSv8pw2CzKe3eutkb7azSXutY8Dk7ZtqOwHS53yJqdG6OYN6fzJv/OUlwwRvjZJUSz/rp6yIf4OMg0aFpugZyoCiEXyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972736; c=relaxed/simple;
	bh=Y5+VgvhH3gLsibJkZUwVD2erRVvXkX6iaHgBzR0aH+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KY9BF6kJa7yGm62ws5jy4BKBObzYQgmkE/yGo1YnmHmwcnav5p5+eGVHgzDY1ac9J+8Ze4ELA2j3y8V9TaStFArgOfVfGp09pUI/OWzwDHOnQZqBJrL+50guERa9ikFke7ERaqfJMOt+cZOqJ3dGPygQHfuVf/3p3Xu1/rzafNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEpH8lNv; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEpH8lNv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPXOjrnfsKxiIWCuFJCwIU64GIzYE6hArC1DDEmtQHjGSikfdFsWPjGj23S/KY0HdJMs5msHaVFGa3S2941zOh/izRJ34hlBpE1XRSYTKOmtaLHvbEQr4Xk6IGKkpX1CEIRb6i4W2mGdecoeXfQ0nSE33uwV8GzS1+MkhutPEfcR/Esv1M03krO/mBhqiEFq+A1GIm8a1XiqRxyRjJzH7J0qShoI6uwxWmcRTqu8ms5i2gTiqn4zaahYZM2Fhy7jFdDi6w5M2vIVeBy8tdcNSTLlcRM0gC3P/QQj32kkrhVlF6pe3Ps46YmR1v6N2gbxZFFE26f4iCz/XjvXwZ49XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGwpcXBSMYSm0Byu1Tn66zG7GbSn7Sf3mBu+rMcHoFA=;
 b=FyJd623fwGQ8lUUUx6qhMTETyBrtjm/LfEMxZMhVQLvQXnR/uaL77G9ww4upyIaT38VytU1ebgJmornR69V+xzSIGp5DgpfB9Gyb8SchNO6AFXwQfuuN5uCgHs9VSv/ENSmd8IsmGw/hHVZewW3eDLF+33rLHqDBqiekFUfALLMJBR/nWM3eMiHiv01bjT5XvzBolyXXGgj+VqD/7HOxazu3nZtR3siW+Nmdd24Va0FNXfzvm+9CUabR1YKhZT2cWooKTdaOLRFVC3n328VHnmmU6YxO28GkQ+cw1MT0UsXb5AfHFnnVdpVSraTwZMYhDIdgcnyVqDb6JnfVCIFeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGwpcXBSMYSm0Byu1Tn66zG7GbSn7Sf3mBu+rMcHoFA=;
 b=OEpH8lNvr/KjCsXsto4xC3bWO4Wp7znntHouFoJUAqFLT7GVehXmm2o3NOg+H7WI3UEhFCUB0IrQ7ve6ep0nCUBb85q3FCHDkjWNYeqgHTMwX9NrbDv6suwKNcQms4y6UWf9YcaVo9JtN80TKLSZGwuZKOQaYA098/gxQnHBDe+aSWUzAQiyxDx683AR33XGqE7PGVlPNJ5BJBivAWkCse+8F9Pb0Jxv2M5KIwNpIqC3Kvgkg2RRKd+fZQthZJ2QUYTKDVMlGtuWSc5LEMXD+41VnA+AAg9iDxvSnZr1Nt8y2dHvJVY68z65Y/1fYJWJKnruJKir15l2unoSCF49pA==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 19:05:28 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::c3) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Fri, 17 May 2024 19:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 19:05:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 May
 2024 12:05:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 12:05:18 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 12:05:15 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.com>,
	<mgurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>
Subject: [PATCH 2/2] virtio-fs: improved request latencies when Virtio queue is full
Date: Fri, 17 May 2024 21:04:35 +0200
Message-ID: <20240517190435.152096-3-pgootzen@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517190435.152096-1-pgootzen@nvidia.com>
References: <20240517190435.152096-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa7d541-46e7-45a8-511b-08dc76a4507e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qtw3fcT9nkrzuYrGuAcnHC0RxCr4wDw8ImUuGy+EI/rrnhCIveB85L3tHBZ4?=
 =?us-ascii?Q?LOgfNM2C6VCi+2whQCBXWxXC0SKSTlWa/uA6WmFixYMVjgJZ4uMZJQ6oaKbo?=
 =?us-ascii?Q?wghA4FwmSbKMGMKGSndnqdIE9H8TaQx6/+NwRo6kY+LO7DRd0+vJZlsv/SkZ?=
 =?us-ascii?Q?TkgYd/rPk5CTwDDvDQQJ4rX6YNKm2TnGvY42n/3qRaq9RMIxsrnghsa9MPg1?=
 =?us-ascii?Q?3YMHz4snUpy+76Fkw1j1oPDKCdAcH8yLNrMySpimG8yrFe3BJpL6cgYDWhVR?=
 =?us-ascii?Q?063d4oorjDL03jrJM28D08HXagAiKHG/AEd6nKnmA2/C8XntYbX/QDTxwyBp?=
 =?us-ascii?Q?zRBoA7C66OSDsX5AvKZmlJURY+iDXGkjpoYa1MbHn54nwD9wya6nnr/5hfB9?=
 =?us-ascii?Q?1+lqEhpvot+eSNDkX8gpt4cdSPLe2xiYcpHdStPHRr2GE7u/DDMGniZWVoUm?=
 =?us-ascii?Q?DAMXopjcKjkMcTvo88zvq2EgbeMMgf6TOSr3+9LGCtI2qIKBfLb6gFgu2av3?=
 =?us-ascii?Q?V+W60QWFhE/oUDHThpnd1l3d+5uqm1cUHMLxM/b7scOEUVD4tAsKw8dsSn48?=
 =?us-ascii?Q?5He6VJ4fefQ8/NxRXhTfCaY6dPFJ3FkWg7wDrOb0eaqzgu4Ux75FmpEc+CFp?=
 =?us-ascii?Q?DH99fwgYFc95jlYoEP9XIL9gQ28wP9i8jp9rkK9jZj9xgKdxKtGPi6kWMCjc?=
 =?us-ascii?Q?QHTBgsUC/4+VN1M5UxgYFKhUJ0xLNYdAdDeoodpEcFQo8ghmSW6wzevfZ76j?=
 =?us-ascii?Q?ZxZ8QaaeCwrOTxugMauTzQLBuHLpQnOlo6qt9pHqNpzP7c60diCAnNlrFbD4?=
 =?us-ascii?Q?d096sVT0Klr1XfL2NyeN8CDiotW+9xMDU//jqf2fBWLLnws4EQZNFYF7atnl?=
 =?us-ascii?Q?7DTAy6Mzr05DK/PJhHaOSzJYQpCiy49U9M9eI3oqXehnS4UQF0muk56CgEot?=
 =?us-ascii?Q?5wgprCVvmgnphP9823OinZSNZYQevSI4Z3K+zt3Jcy1jjr5jpJA7Lyl2DXFx?=
 =?us-ascii?Q?AG7NvaRLh9HJwSR96azg7u/W6M2XSa/c0ZDtU+GsWldsTDxtMCf9EMDJgNLh?=
 =?us-ascii?Q?jRMjcH3XJhAMmYFxuY8jHHkT2oiATjkftkXAyyeZGes+IUgVOwGUJfZ4+C2Q?=
 =?us-ascii?Q?S+m6h4xUaQldcDCXGTdyLLC5iOihYkb6JYX8rs8QYkSsLHNf28olr+hIpT2X?=
 =?us-ascii?Q?nkJfpKZhtLq4OhcCGWNEosqvJCrmeHONE31vdoxZzg7y1sV4azeN0tHCOux/?=
 =?us-ascii?Q?uHlliHzwf9TxESzdpiQ+Tbzd1mr05z1m4reg4FaLYp93fhHL0m+xOvSkNs1B?=
 =?us-ascii?Q?MfTNr8XYtBAylyxu4ZJ7yCczJb1mtD8dSrpCJK0LPosasDbOAjbVBDt+OOwD?=
 =?us-ascii?Q?IMeL0AI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:05:27.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa7d541-46e7-45a8-511b-08dc76a4507e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920

Currently, when the Virtio queue is full, a work item is scheduled
to execute in 1ms that retries adding the request to the queue.
This is a large amount of time on the scale on which a
virtio-fs device can operate. When using a DPU this is around
30-40us baseline without going to a remote server (4k, QD=1).

This patch changes the retrying behavior to immediately filling the
Virtio queue up again when a completion has been received. 

This reduces the 99.9th percentile latencies in our tests by
60x and slightly increases the overall throughput, when using a
workload IO depth 2x the size of the Virtio queue and a
DPU-powered virtio-fs device (NVIDIA BlueField DPU).

Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Yoray Zack <yorayz@nvidia.com>
---
 fs/fuse/virtio_fs.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 55126df202d6..fdeb7e34ec01 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -51,7 +51,7 @@ struct virtio_fs_vq {
 	struct work_struct done_work;
 	struct list_head queued_reqs;
 	struct list_head end_reqs;	/* End these requests */
-	struct delayed_work dispatch_work;
+	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
 	long in_flight;
@@ -233,7 +233,7 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
 	}
 
 	flush_work(&fsvq->done_work);
-	flush_delayed_work(&fsvq->dispatch_work);
+	flush_work(&fsvq->dispatch_work);
 }
 
 static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
@@ -408,6 +408,10 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 			dec_in_flight_req(fsvq);
 		}
 	} while (!virtqueue_enable_cb(vq));
+
+	if (!list_empty(&fsvq->queued_reqs))
+		schedule_work(&fsvq->dispatch_work);
+
 	spin_unlock(&fsvq->lock);
 }
 
@@ -415,7 +419,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
-						 dispatch_work.work);
+						 dispatch_work);
 	int ret;
 
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
@@ -450,8 +454,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
-				schedule_delayed_work(&fsvq->dispatch_work,
-						      msecs_to_jiffies(1));
 				spin_unlock(&fsvq->lock);
 				return;
 			}
@@ -498,8 +500,6 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
-			schedule_delayed_work(&fsvq->dispatch_work,
-					      msecs_to_jiffies(1));
 			if (!in_flight)
 				inc_in_flight_req(fsvq);
 			/* Queue is full */
@@ -531,7 +531,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 {
 	struct virtio_fs_forget *forget;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
-						 dispatch_work.work);
+						 dispatch_work);
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
 	while (1) {
 		spin_lock(&fsvq->lock);
@@ -709,6 +709,12 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 			virtio_fs_request_complete(req, fsvq);
 		}
 	}
+
+	/* Try to push previously queued requests, as the queue might no longer be full */
+	spin_lock(&fsvq->lock);
+	if (!list_empty(&fsvq->queued_reqs))
+		schedule_work(&fsvq->dispatch_work);
+	spin_unlock(&fsvq->lock);
 }
 
 static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *fs)
@@ -770,12 +776,12 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
 
 	if (vq_type == VQ_REQUEST) {
 		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
-		INIT_DELAYED_WORK(&fsvq->dispatch_work,
-				  virtio_fs_request_dispatch_work);
+		INIT_WORK(&fsvq->dispatch_work,
+				virtio_fs_request_dispatch_work);
 	} else {
 		INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
-		INIT_DELAYED_WORK(&fsvq->dispatch_work,
-				  virtio_fs_hiprio_dispatch_work);
+		INIT_WORK(&fsvq->dispatch_work,
+				virtio_fs_hiprio_dispatch_work);
 	}
 }
 
@@ -1376,8 +1382,6 @@ __releases(fiq->lock)
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
 			inc_in_flight_req(fsvq);
-			schedule_delayed_work(&fsvq->dispatch_work,
-						msecs_to_jiffies(1));
 			spin_unlock(&fsvq->lock);
 			return;
 		}
@@ -1387,7 +1391,7 @@ __releases(fiq->lock)
 		/* Can't end request in submission context. Use a worker */
 		spin_lock(&fsvq->lock);
 		list_add_tail(&req->list, &fsvq->end_reqs);
-		schedule_delayed_work(&fsvq->dispatch_work, 0);
+		schedule_work(&fsvq->dispatch_work);
 		spin_unlock(&fsvq->lock);
 		return;
 	}
-- 
2.34.1

