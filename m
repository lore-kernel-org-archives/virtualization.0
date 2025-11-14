Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7092DE719
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146019; cv=fail; b=XaYFlVTRXSv66Ag17Kjyrje7X83JoEJbGvtmJHDiBygsJzybjS5S+awFN2Ce2hPqytJy7alZqFUpCF+LfWtIyl+Ief5srLUnkUJZ4TBrdgS0STWuVDKad2gZHph/UAXDw3z0Z4BFiMMvnWA2UzRBPlfcbI7Kp9O7UQ4z7gjQofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146019; c=relaxed/simple;
	bh=P8eOpKjPN8VVAs7wU4wur9jUUBY+In4gy9jWEIHuuBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/a8d72n6R1Nj+3zu/+l/z/FQxkgtmtd7oVScE2bdLdp2xPJnRsSoVMWlYOKKnxwHGf2NsyhzcEwDNI9K8Y/N/KwLpl/pMznA77npfRYdsOgYewSnn9mkwap9fALA+T3+2HORbW1M5p3GmM7jII+DDVgKZFSl9Tkpa4VOCV+4dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A9Nc7aME; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A9Nc7aME"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwW5hNqihngJUvjx0rwmVhMDDhs1x4Hzrl2e6kl3pkBCX+Fp0Mx0QRwkr5/K81M0TG55oF6dVU0eBBT/aZRVJm1/ukKqbK4mVxRESxgcUp2CgEpznRJfCZIe5P/JyIZb9QmECzClmtmCrEKYGVt5uIKlZ00GCYLlR5TOqgKhHHXLqUEq0Re/GFuECp2u1OZC6PFP15R/HC85OGw1Ofraq00Gd2h0HZAZmYGfcZ8KsLZ7/vj3jqzrVT0vl88kPbWucXGRy7vidvgKlIvMgN6PG3d0cvn1uYXzv3yhearchC7LRYpvNtRXW2hjsS5RqoKtLw2KBIO+8ep+jDnu+L2y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW6HVILFRpTkwz+uNQDlHYb7DYqFMai3fdS4KNDdSvc=;
 b=R7xOX+Nzy3rJ9/QhN95VfZDfXNbAeE8KggdJhtMNX19FrYjGXg41rABcFshtVomGIpJ8D75x0pMngt9c+Cy7o4jUcqlQ/ZQbsAYnzda8qzFv+kZ/YOunUbrUDlwAGdOeRW7kAlWGt+vnNCOhhac+M6m28Tr7/M1G+SUkK7pgOfegFLB3CX4KP8XtAJywJnfTodh+q0uOzHWVf2PVXDOoiCMKdnS5DJfEPCEard/ZdqtATJxvy7GpqdncGRsVa2mM23IItM0k3ry2L1Lcbc6mItxUqWDH4CtSUkd59GBqLkpXfcdbRrjAdn9QdiVdHVfzapshDWNeq5sM2pHO4KPZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW6HVILFRpTkwz+uNQDlHYb7DYqFMai3fdS4KNDdSvc=;
 b=A9Nc7aMEFl/8FP9+P5A4D/0Vu38UGycu0FrmIsiEHcmYZgtVGr21SjjZfoN8C+jz9LE4Hib032GJXh3UnzQP73RIOOIeu1O9/sFw9nC1nZ2MN6AnmSP5FeW4RSrypwPVlah1HoWjcnxK1YTIoiCdE5GzmWt+X7NQk2BEaO45Iog=
Received: from BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 18:46:50 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0::4) by BY5PR16CA0026.outlook.office365.com
 (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 18:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 18:46:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 14 Nov
 2025 10:46:49 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Nov
 2025 12:46:49 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 14 Nov 2025 10:46:48 -0800
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [RFC PATCH 1/2] rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
Date: Fri, 14 Nov 2025 10:46:39 -0800
Message-ID: <20251114184640.3020427-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114184640.3020427-1-tanmay.shah@amd.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: db94d41b-df22-4c21-28a2-08de23ae2bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e259arkn6iJPrVbMOQ3mp5bvO8t3553OTTyA7n2yv7mH+Slb/T6WJAtQwKuj?=
 =?us-ascii?Q?6y/bDlitDjLQt7qH2Dn54Kk883osGfLmyTzO1e6n+pfOonVMA6i1B/TK4mzh?=
 =?us-ascii?Q?pZkqOr7T7mmZULrU89wI/cyncz1w94OCeAkGZrXGIz+lOuwmFx2VqDhgNx8w?=
 =?us-ascii?Q?OHKr/gG2aO8A8wS1sJ+/p5dNnr8FHJn2Yw53NbDLIJjE66xG9gelEEcZDum+?=
 =?us-ascii?Q?GYSBrWWZHlgMR1EGomyXhZrGpYwSNNVIz37Bzc0Dv+A5oP+SZwJSaytFhrcz?=
 =?us-ascii?Q?OXkvzYNru+NsdJscDkujzYz+Jj/K0zmxPIOLm5GYU1IZgtpYWBct+bRbTpni?=
 =?us-ascii?Q?g7YTIjLqzOSKyocmFslIYPqVq6o1fiBxZvUi50leU6ObqS0TKhMkYZNFkVfU?=
 =?us-ascii?Q?R+VruwnvoAbt79VXJ4EQOYJ5V1h/9YKvXgxFyDBFZtZ5JfmjttOdYoDs9o9F?=
 =?us-ascii?Q?xJneXeZ/KMef79ZhyN9Y6ujQZeJtz7R/ZfLQ57sD5Kwx/9/t8NSqeHeu+7xd?=
 =?us-ascii?Q?g/1LeBomUbg7WxWEDeOkLmk4rV4z2FXf/m/QA90scu3aOxBRYY9UoJKtSP9N?=
 =?us-ascii?Q?HY4FiGYtNsux6c9yVh9FrU6sNexaEWum1kaDzlyoc00+tJAt3Isy1sbCikxq?=
 =?us-ascii?Q?uFtIGs7VaEnqSGnrxxHq0uURwnaf57UdHC7zH7/TuFXVF0sYIAa6IpsBsQ9x?=
 =?us-ascii?Q?67xZfITQoYSDqecVQP6xyBNNsigA2SCsEtfm1cbk7tMoq3aQA0b7w8gQipvc?=
 =?us-ascii?Q?F3uEj9cTH64zu1rJhzjaLk1HC4SDYWyffwsmKD2O7L0ka1H5nn9dfu4j9Mot?=
 =?us-ascii?Q?q5TcwTkCphAIx4IAS92jFrnfTxbcKKoW+zbAop1duzcwMjXWfH6ND2l3xkiV?=
 =?us-ascii?Q?aFuJBU0nBNKA8/qk76yxGNmvLmHXcYSAHPUfy5Tu+G2yHgGHRNjIShBskgej?=
 =?us-ascii?Q?6NLcjhypnv8N0Q/l2kh1bgbCBTNDcq7Zk17Hl/5OTFVtKn76YRSWJkK7/zQi?=
 =?us-ascii?Q?KtdqtQgrbPpcETo3UjLcmVkzsxt2UfOiwAPn8fp/CTIVGlKX3jT/A8HAPG/c?=
 =?us-ascii?Q?JX9/+WNL0R8sFFDvAgHVqCaeCmXpmgk8yGbAKkOLA+d9Mo8E2yWpYR8HAn/p?=
 =?us-ascii?Q?HAB+mi39vWfHAJkxzxKWBxlq9i5h8POLEe8IuybuJblsdGt9jPvbeXdKY3On?=
 =?us-ascii?Q?7igxkLD4op7ea89I7TebMlz8wkuJVocU3zGhRcBDWf10cO0UP+8Xpqskw8M6?=
 =?us-ascii?Q?7zal4QKB5/suqBuBeKv9OFUqPx11Xp3TYdDGsZ6nkK8CvIQc+qvtq3+rMg93?=
 =?us-ascii?Q?vQxKBlCjAqqdW36dGA56jXyLw759XCAkRRpzTvQZoJwtCHZh2D/GnrVLN0L0?=
 =?us-ascii?Q?lr4LrlIjkRTftBmJJMsAJzsxZlxwfgVxMo13F7C03cAOHzLc19CBItimOC6v?=
 =?us-ascii?Q?hbswSHj9r1UyVHvQ+hsq6R3hXffQ0Oj3JBMXogG76qjuSmRhrPyFUctZ7AHw?=
 =?us-ascii?Q?8Q1C6au/HG1j64D++35q6yX69vkqR9Y+JHQEBd7jbwuk2FG9Qv4SgHTMm/vY?=
 =?us-ascii?Q?XxPgW6qzY0Mq1a6boWY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:46:49.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db94d41b-df22-4c21-28a2-08de23ae2bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

From: Xiang Xiao <xiaoxiang781216@gmail.com>

it's useful if the communication throughput is different from each side

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 484890b4a6a7..cc26dfcc3e29 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -37,8 +37,9 @@
  * @svq:	tx virtqueue
  * @rbufs:	kernel address of rx buffers
  * @sbufs:	kernel address of tx buffers
- * @num_bufs:	total number of buffers for rx and tx
- * @buf_size:   size of one rx or tx buffer
+ * @num_rbufs:	total number of buffers for rx
+ * @num_sbufs:	total number of buffers for tx
+ * @buf_size:	size of one rx or tx buffer
  * @last_sbuf:	index of last tx buffer used
  * @bufs_dma:	dma base addr of the buffers
  * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
@@ -57,7 +58,8 @@ struct virtproc_info {
 	struct virtio_device *vdev;
 	struct virtqueue *rvq, *svq;
 	void *rbufs, *sbufs;
-	unsigned int num_bufs;
+	unsigned int num_rbufs;
+	unsigned int num_sbufs;
 	unsigned int buf_size;
 	int last_sbuf;
 	dma_addr_t bufs_dma;
@@ -112,7 +114,7 @@ struct virtio_rpmsg_channel {
 /*
  * We're allocating buffers of 512 bytes each for communications. The
  * number of buffers will be computed from the number of buffers supported
- * by the vring, upto a maximum of 512 buffers (256 in each direction).
+ * by the vring, up to a maximum of 256 in each direction.
  *
  * Each buffer will have 16 bytes for the msg header and 496 bytes for
  * the payload.
@@ -127,7 +129,7 @@ struct virtio_rpmsg_channel {
  * can change this without changing anything in the firmware of the remote
  * processor.
  */
-#define MAX_RPMSG_NUM_BUFS	(512)
+#define MAX_RPMSG_NUM_BUFS	(256)
 #define MAX_RPMSG_BUF_SIZE	(512)
 
 /*
@@ -439,11 +441,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
 	/* support multiple concurrent senders */
 	mutex_lock(&vrp->tx_lock);
 
-	/*
-	 * either pick the next unused tx buffer
-	 * (half of our buffers are used for sending messages)
-	 */
-	if (vrp->last_sbuf < vrp->num_bufs / 2)
+	/* either pick the next unused tx buffer */
+	if (vrp->last_sbuf < vrp->num_sbufs)
 		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
 	/* or recycle a used one */
 	else
@@ -878,19 +877,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	vrp->rvq = vqs[0];
 	vrp->svq = vqs[1];
 
-	/* we expect symmetric tx/rx vrings */
-	WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
-		virtqueue_get_vring_size(vrp->svq));
-
 	/* we need less buffers if vrings are small */
-	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
-		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
+	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
+		vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
+	else
+		vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
+
+	if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
+		vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
 	else
-		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
+		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
 
 	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
 
-	total_buf_space = vrp->num_bufs * vrp->buf_size;
+	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
 
 	/* allocate coherent memory for the buffers */
 	bufs_va = dma_alloc_coherent(vdev->dev.parent,
@@ -904,14 +904,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
 		bufs_va, &vrp->bufs_dma);
 
-	/* half of the buffers is dedicated for RX */
+	/* first part of the buffers is dedicated for RX */
 	vrp->rbufs = bufs_va;
 
-	/* and half is dedicated for TX */
-	vrp->sbufs = bufs_va + total_buf_space / 2;
+	/* and second part is dedicated for TX */
+	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
 
 	/* set up the receive buffers */
-	for (i = 0; i < vrp->num_bufs / 2; i++) {
+	for (i = 0; i < vrp->num_rbufs; i++) {
 		struct scatterlist sg;
 		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
 
@@ -1001,7 +1001,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
 static void rpmsg_remove(struct virtio_device *vdev)
 {
 	struct virtproc_info *vrp = vdev->priv;
-	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
+	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
+	size_t total_buf_space = num_bufs * vrp->buf_size;
 	int ret;
 
 	virtio_reset_device(vdev);
-- 
2.34.1

