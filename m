Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D02DEA7A
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146020; cv=fail; b=XFW/9WFEmz8n3yrnzPP0hlh2TGHX0BGoNgnq4m0OXjfFwFawLcXXJ5Nem63KZ+Ly5mbHas+Sp40PxlR7n3l5oZ6bWbhLUZXn9L6XPMubww869IPJC4GdjJWba0NMOxtX2F7RdBXBD5hXuEhlkpUDOakD6572EWwBJYntt3QXfq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146020; c=relaxed/simple;
	bh=Bu+N3ypH2MFZM+aBdZkPzE4HKuiKtz9JnUSGOu1WubM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flzrWwCmb1wghqf3mhsfyesDbYKzn9owpTvi1PdOTkRYpUI1HOO3FLbAghKRxW///KEFVSTtk45gAkoPe3jTgkN0Eaa5o5O61tu/e0DJSOMZr9pZiNf4SaDZPq6ewFrLweawQIfzFamnQES6BOsdy8LLDxaoQnmFVTzABAYLGto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8uVTad3; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8uVTad3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFXDV3MwyT2F+EeoPd0GEcKv2ZH41uGXmTOgHXXYpDQz/Ib+c9DTZIBwJ5X4bnKHbuelhFL7Bxk/XrJbrjT6PvS10afdbdtppc1htB+N5N6eHvC8+a5tmMBBEm3uoSHzy3/tzOML3qQGK5iSVApcCqGe5ApHY5BWR+QB09mfPws7e3/Y9UGYw3RlhYk0OIL+bGpIOKrxhsmCwmKsEsW0iD6nUlT+zbF3FD726rVcuL1ZIe3byGqDWZqQAghKIediwdm7MMTBJ5vqy5mJkW9DpWxm1jHgakZf9oeh1JOhrJrnRStyatCUFTd9+1W12Debej8pj/EzbMou2+IvyezrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8rue0QF9O6k8/JwqWkDFpD7uAhuk3AbB3nthXrG0W8=;
 b=oUvtLHqo3zD8MeYAFaKuTVkWlSy4CLH8FZUCFLGFsaodHBREK1jLZJnfAA3R73VTU9I+12i4Xe1ogAGgeJ3f7QYFX7zMSmxYxWdDw03vn5e8Sm8uuhFcC+a4epCQG4UFrA1VeCC4dJT8lkqZaH2DN+usSQ1ktoqVVZDH2N7b65bjJ84jYaSPBUcWIjzjN/QloP6ZmMKG0i0IdUxIGVGCxBuGYpMEqhy2pyGDjEiMrSfqUAt2MLSYtbE1yw+I/KTKzjFVbEIO45fI73a2GMRk7dI6ZxF1Pb8wiMvAyMgQ1eAJ8+dXaLUWLm/jVt/WBZzmrfQVszxdrTFp2f6uMifuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8rue0QF9O6k8/JwqWkDFpD7uAhuk3AbB3nthXrG0W8=;
 b=s8uVTad3u9sfU+TWd3RDL2a6u6GzexhaLFgJQJ84w7FgqKRH7zR2+e13pg5i53CrRI6KPnzbo169EPYia3EcjL4MvZkhPb/FNmNcRxtbdE5Ci1XX8s/NZXHJbaKqksahh7r+UIVCr0ICtGTvrD0WArILeYlsoicm8vHtAjmm0pc=
Received: from BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 18:46:53 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::81) by BY5PR16CA0032.outlook.office365.com
 (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 18:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 18:46:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 10:46:50 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 14 Nov 2025 10:46:49 -0800
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from config space
Date: Fri, 14 Nov 2025 10:46:40 -0800
Message-ID: <20251114184640.3020427-3-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0caa43-305b-4e5e-a9cb-08de23ae2c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHWnUTvW465Tkl++uI+/iaZBazFMAbpOGlC/apsd3wVGkBc/hJWH8m8KJ7Gp?=
 =?us-ascii?Q?KMypURLMNMhkuLExW66eQBs1XhxcFi8RK46DtyfCPcG+MN9DNdw81qHdH/oW?=
 =?us-ascii?Q?lgh6P/YEwrfDZrJKo4/DO4V+i8PiIoH2seYp42Od/N7PPJUESyX95ANkpsCt?=
 =?us-ascii?Q?i6iQptG+tQ3zxfJjwXlS+PHfxJxfIvLeXlsB8yBTyfVylqWOhnMkJyMXDnDf?=
 =?us-ascii?Q?2Hfqq6vprcuRr08nDIki8TRHCPlMmO2db7iluFr7u03y5tn4Fp0jQ97Kz6si?=
 =?us-ascii?Q?+AmYF9YS8wsAFK6XYOnO0on1nzhXjFX5agYhoB089+I+LN3L/IqhWnrkTNgp?=
 =?us-ascii?Q?mIvfgPtqzxmMh3WnJ3Pbp3Jw515oly7FAYkQ+ZI5W32kaBjYHLLnAW/5xVwb?=
 =?us-ascii?Q?/MHOqjuxgnmhqFVTmJ15nBtFgJC5z4nM29va5mBmPqq63iXsIkLuXOqfff43?=
 =?us-ascii?Q?LNN8Q1u5tdSTuEO50VGHwEkXbGrA1NIOREZ4nJitRHykoYPxfRqX1aD76e2d?=
 =?us-ascii?Q?M0p8nmUOqFOMvVnjFBofpaeXdDPGZcjvvrViwW300Pzi6NCbBNvNtxtba/S2?=
 =?us-ascii?Q?O2RM870I/LdhbAhS5pz8QL0KA6r5ilRLa3xvjezpNwA1PrFA6Bd5ADwtBYZE?=
 =?us-ascii?Q?VdpmHWZCvcfJXM19LE8HLJ75i/DEtNnrO5j2idNUWDyYBMf9YM9WZQPgzU6b?=
 =?us-ascii?Q?2gBgcT0a9xMVAo6d4ul1qyGy+rrsmJ4gsS1Rwe0ZFCFEPKI2kmgrkxqwkfD2?=
 =?us-ascii?Q?lMjPF0z1+Ls638ifY7gfnZImdLTdZU+W21LQqllPBKuFxf6g30Y6lgI4Dbx6?=
 =?us-ascii?Q?/TOAFY2W9BMTMLunHJ4g/AMdwnD7m653W14Q7GBFozxKjlkMb9MP6aALDuTT?=
 =?us-ascii?Q?cs2Lmux2Ksn76H8c23Zv0PVjfdvWLdeCmSNmdjsA94HZlqB0yGZwUhQ+JRhV?=
 =?us-ascii?Q?fpQXRi1mIL6js6X2Pcj8rm1RBaXswnDtVYroYgNBZCEvxVxL/ZW79ZxNIkzq?=
 =?us-ascii?Q?9DLeYznetUzr+MHgyFXtnOG3JfUgMF3GF5EgOX7kA1uTKFRsqfBDuO3Gsj3y?=
 =?us-ascii?Q?hmuWvQhuel5QWJixo4w7LY2mZafHszfBkSXoJZX7+MQJekiRWZ95qId3uPAe?=
 =?us-ascii?Q?lgH7uOR2nmO+41x58lVQw80TRGiFZjQ/WS+YYxw7hkUqi9jETW1agiOVu0nX?=
 =?us-ascii?Q?OE1hdhVplE8Wet3mWyqcZvOq1NMVjbSflQ+YEY6v9GUiNxP94Su8qhSrF0xj?=
 =?us-ascii?Q?OBRCQJbMrVIO27a4YYaIPHpdm8GGBcONP9SyTsvXiui8G7kesUPkw5LkUbH6?=
 =?us-ascii?Q?8hmbA/W4MAhRWVm4O/pjlcoz5iESnJKwrZWxvOUBpWxigXi9ATv65Tptllif?=
 =?us-ascii?Q?rWGcXSSXYlWHF6fhn2pkLeBfxHC5xcfkg1hFLw2guw6KiAJOlZdBtxYFizPv?=
 =?us-ascii?Q?mgh6ZfO77ZHpTMrf6/m3F6QpDzuwMRxmfI7cLJF4FPbvtbi+VjFoSugNdUpZ?=
 =?us-ascii?Q?SMh3dkXFeTeXa79rUa3hCuHPvZ2IEo6wcz7SEDVXBRpoYhKQQ8ieJSkxhbU7?=
 =?us-ascii?Q?z+k/+U3NHAcezDKPV2k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:46:50.7203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0caa43-305b-4e5e-a9cb-08de23ae2c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

From: Xiang Xiao <xiaoxiang781216@gmail.com>

512 bytes isn't always suitable for all case, let firmware
maker decide the best value from resource table.
enable by VIRTIO_RPMSG_F_BUFSZ feature bit.

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
 include/linux/virtio_rpmsg.h     | 24 +++++++++++
 2 files changed, 74 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/virtio_rpmsg.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index cc26dfcc3e29..03dd5535880a 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
+#include <linux/virtio_rpmsg.h>
 #include <linux/virtio_config.h>
 #include <linux/wait.h>
 
@@ -39,7 +40,8 @@
  * @sbufs:	kernel address of tx buffers
  * @num_rbufs:	total number of buffers for rx
  * @num_sbufs:	total number of buffers for tx
- * @buf_size:	size of one rx or tx buffer
+ * @rbuf_size:	size of one rx buffer
+ * @sbuf_size:	size of one tx buffer
  * @last_sbuf:	index of last tx buffer used
  * @bufs_dma:	dma base addr of the buffers
  * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
@@ -60,7 +62,8 @@ struct virtproc_info {
 	void *rbufs, *sbufs;
 	unsigned int num_rbufs;
 	unsigned int num_sbufs;
-	unsigned int buf_size;
+	unsigned int rbuf_size;
+	unsigned int sbuf_size;
 	int last_sbuf;
 	dma_addr_t bufs_dma;
 	struct mutex tx_lock;
@@ -70,9 +73,6 @@ struct virtproc_info {
 	atomic_t sleepers;
 };
 
-/* The feature bitmap for virtio rpmsg */
-#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
-
 /**
  * struct rpmsg_hdr - common header for all rpmsg messages
  * @src: source address
@@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
  * processor.
  */
 #define MAX_RPMSG_NUM_BUFS	(256)
-#define MAX_RPMSG_BUF_SIZE	(512)
+#define DEFAULT_RPMSG_BUF_SIZE	(512)
 
 /*
  * Local addresses are dynamically allocated on-demand.
@@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
 
 	/* either pick the next unused tx buffer */
 	if (vrp->last_sbuf < vrp->num_sbufs)
-		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
+		ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
 	/* or recycle a used one */
 	else
 		ret = virtqueue_get_buf(vrp->svq, &len);
@@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 	 * messaging), or to improve the buffer allocator, to support
 	 * variable-length buffer sizes.
 	 */
-	if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
+	if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
 		dev_err(dev, "message is too big (%d)\n", len);
 		return -EMSGSIZE;
 	}
@@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
 	struct rpmsg_device *rpdev = ept->rpdev;
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
-	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
+	return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
 }
 
 static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
@@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 	 * We currently use fixed-sized buffers, so trivially sanitize
 	 * the reported payload length.
 	 */
-	if (len > vrp->buf_size ||
+	if (len > vrp->rbuf_size ||
 	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
 		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
 		return -EINVAL;
@@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 		dev_warn_ratelimited(dev, "msg received with no recipient\n");
 
 	/* publish the real size of the buffer */
-	rpmsg_sg_init(&sg, msg, vrp->buf_size);
+	rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
 
 	/* add the buffer back to the remote processor's virtqueue */
 	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
@@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	else
 		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
 
-	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
+	/*
+	 * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
+	 * size from virtio device config space from the resource table.
+	 * If the feature is not supported, then assign default buf size.
+	 */
+	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
+		/* note: virtio_rpmsg_config is defined from remote view */
+		virtio_cread(vdev, struct virtio_rpmsg_config,
+			     txbuf_size, &vrp->rbuf_size);
+		virtio_cread(vdev, struct virtio_rpmsg_config,
+			     rxbuf_size, &vrp->sbuf_size);
+
+		/* The buffers must hold rpmsg header atleast */
+		if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
+		    vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
+			dev_err(&vdev->dev,
+				"vdev config: rx buf sz = %d, tx buf sz = %d\n",
+				vrp->rbuf_size, vrp->sbuf_size);
+			err = -EINVAL;
+			goto vqs_del;
+		}
+
+		dev_dbg(&vdev->dev,
+			"vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
+			vrp->rbuf_size, vrp->sbuf_size);
+	} else {
+		vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
+		vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
+	}
 
-	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
+	total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
+			  (vrp->num_sbufs * vrp->sbuf_size);
+	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
 
 	/* allocate coherent memory for the buffers */
 	bufs_va = dma_alloc_coherent(vdev->dev.parent,
@@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	vrp->rbufs = bufs_va;
 
 	/* and second part is dedicated for TX */
-	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
+	vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
 
 	/* set up the receive buffers */
 	for (i = 0; i < vrp->num_rbufs; i++) {
 		struct scatterlist sg;
-		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
+		void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
 
-		rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
+		rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
 
 		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
 					  GFP_KERNEL);
@@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
 static void rpmsg_remove(struct virtio_device *vdev)
 {
 	struct virtproc_info *vrp = vdev->priv;
-	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
-	size_t total_buf_space = num_bufs * vrp->buf_size;
+	size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
+				 (vrp->num_sbufs * vrp->sbuf_size);
 	int ret;
 
 	virtio_reset_device(vdev);
@@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vrp->vdev);
 
+	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
 	dma_free_coherent(vdev->dev.parent, total_buf_space,
 			  vrp->rbufs, vrp->bufs_dma);
 
@@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_RPMSG_F_NS,
+	VIRTIO_RPMSG_F_BUFSZ,
 };
 
 static struct virtio_driver virtio_ipc_driver = {
diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
new file mode 100644
index 000000000000..6406bc505383
--- /dev/null
+++ b/include/linux/virtio_rpmsg.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) Pinecone Inc. 2019
+ * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
+ */
+
+#ifndef _LINUX_VIRTIO_RPMSG_H
+#define _LINUX_VIRTIO_RPMSG_H
+
+#include <linux/types.h>
+
+/* The feature bitmap for virtio rpmsg */
+#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+#define VIRTIO_RPMSG_F_BUFSZ	2 /* RP get buffer size from config space */
+
+struct virtio_rpmsg_config {
+	/* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
+	__u32 txbuf_size;
+	__u32 rxbuf_size;
+	__u32 reserved[14]; /* Reserve for the future use */
+	/* Put the customize config here */
+} __attribute__((packed));
+
+#endif /* _LINUX_VIRTIO_RPMSG_H */
-- 
2.34.1

