Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6498FC74A44
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 05:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0841E81F3D;
	Fri, 10 Mar 2023 05:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0841E81F3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=shlFKcEH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4058G8HUPd-j; Fri, 10 Mar 2023 05:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 68EC081FAA;
	Fri, 10 Mar 2023 05:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68EC081FAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A022C0071;
	Fri, 10 Mar 2023 05:34:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 209A1C0090
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C820381EEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C820381EEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJoFGNhEDhp5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE87A81ED8
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE87A81ED8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSAVQ9I60f3er3oAndMHqpUe7OOSfZM5UdJAC1LZ6ZFKT2egDQGihCYZtmraDmnGTGKZbtp0ihWtEL12B/aqDLXRzimUbB0VwF7SZTLfMNDoFs06ONz/uG1J8ZI8+BxFrNbAsb7qi6FVlcNCGLWgGyeoBOrpOh10cSn5Ddqh6qFwxYPOFyO2FRrE5ZKklXNtH610E/7cWowTQKGn122W2exMW9uAsAAQYWkF+ssrs3wFXQH6+IZqTY+WyFNUwlIY4k4rbD2Ipozg1MVUE5Zdmo3HtL4b4SKFenPBMyRzquRrrZDUc4z94gWxg9EXUuSC/z54LZvySP4mQ/2UMhqQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL7cCXQosTB4QsjyINetGOVdCHv0ekVqFYLLmOD48zY=;
 b=QiiKzWRey35lmhNod2fFVn8wEERTVhV35hak97zczL4GQLT9ehkLaUhNx05qMI3/RLEV6zwLDRYgE0MKZKjGxYDRrCcBmBHAlc9o8uOLSV/qYOucskcyxNZZWDEq28ABuSrUGgLobHnHepQHpRCcPhS3y4Bt4102P4QBG84E4WZ9nGOIMWsz9zLLF8S2xH4AgzU3BXkDuQQdZzAiF34mlj2wWWapoNOEoFOds414TqxSDGU6FaPqY/NeYotA0HLntUuMqReiJ7zu9VpQkQCT5IzDH11y7we0NSgqEL//WHDqLKypffxQ4d0KBRMt470uH7gEtMK2dulYOdn064d4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL7cCXQosTB4QsjyINetGOVdCHv0ekVqFYLLmOD48zY=;
 b=shlFKcEHbgRhXGpADo8Mu5lNEfSso/5aRCs4QhWwdyT9rFpsYojq428ZZTaJbMAzjWI84D5aqpLPsNZHbOxzT0TacgoKgJ8C03D3MwL23LjT6z6ni3gFbDPtLh+x73mwXptvjCL7ZfEudvZsox0CrGbrblROw+mTeziN7kyaBwuqpgv3vGq9a3RoNRyvPKYCroOOCQAJEC+XPDFqb8F2OUQXFwzAoY+09Om9XUXYaJxkyTMcMr6quno5qbDMW49Xes/4gIW3zZCPwQjBujlmKzE9eHETEoFgEhmm+Ev8BrtagwKF92vhs1Cs/nsoMZVc7tlDwra2wpdy4W41s+k5bQ==
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 05:34:49 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::4f) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 05:34:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:34:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:34:39 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:34:38 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 32A5YVo4007739;
 Fri, 10 Mar 2023 07:34:35 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 2/3] virtio_ring: Avoid using inline for small functions
Date: Fri, 10 Mar 2023 07:34:27 +0200
Message-ID: <20230310053428.3376-3-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310053428.3376-1-feliu@nvidia.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 786fbfa7-a0ff-43b3-1844-08db21292ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nw1HZosRVdpXqTI443CpEsmvjSWQkr6a7X2jVkEEzbuC4X0oz0XbQkVIW2uPDvaI9WtTQfEMGze0Ee84n2QaHsE45dRmeQTmhbF9oPGJQVlEwq96voX9os54Guh996Rnh/YwjJMB2DclPpDDH9YjGEcdCTWsXHSlODNxyntNLltpdFw9Fdha0Da8eN4taUrO475iua9UHgc0PQAIILQxjOIVWbsIyIi4yZZ0bNMkqttrnhm/btk4y+Wq74H9+T/8m4FkZbsRdsMr1xF756BQ0PaEnQhrBghs4IHmmd5yk9+cm8cPMuwrsnT5uI81B+MH7gCH+cAtSPHnM7aP49NfotfKQ2YTK2YBrQBqMO/bhPj2iOvq9EfprdZXMejGxw+eSZ9+0xHA5BTds6zvHYtRciZ85B73pnmeqwSU+raQJ5rY7riVQuXJUjIog1mLVii/pc1XAvZELNXA1AHHfx4/e6ECGXSGjE3ocjdtaMuTbOvG2RGznYk87tQH4aTdHQj9Za363t8PEz1cMDh6OF2NCjHfKkZ4ESC2dPgXbfgBBio3t4HzK4G/3FNTX+dXzAoOkT60dJf4Rnthg7uUj86ZGKIbz22XRila89yLBXRKr6F4Zu7S2hojQc4rdN2eauNMWSrixSjYLOSEApuBgbq/zfuxL0kDMTFtM0qtlJw+WkB50koiAwM8Zd8Gaqr7AUCfwLTHDlis4SSw86rxDBYzHIkigK5Z0k+dn9czV88UJt0o7p8j8vXk7SekUSwDiPgS3CMfHKAxnlh5mRvDsLGe41x9ahSBnigWeXcJEXAaM/k=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(7636003)(478600001)(47076005)(82740400003)(83380400001)(36756003)(186003)(356005)(316002)(2906002)(2616005)(26005)(1076003)(54906003)(5660300002)(70586007)(70206006)(4326008)(6666004)(6916009)(8676002)(40480700001)(82310400005)(36860700001)(8936002)(966005)(40460700003)(86362001)(41300700001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:34:49.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786fbfa7-a0ff-43b3-1844-08db21292ab2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

According to kernel coding style [1], defining inline functions is not
necessary and beneficial for simple functions. Hence clean up the code
by removing the inline keyword.

It is verified with GCC 12.2.0, the generated code with/without inline
is same. Additionally tested with pktgen and iperf, and verified the
result, the pps test results are the same in the cases of with/without
inline.

Iperf and pps of pktgen for virtio-net didn't change before and after
the change.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 drivers/virtio/virtio_ring.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..a26fab91c59f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -233,8 +233,8 @@ static void vring_free(struct virtqueue *_vq);
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
-					  unsigned int total_sg)
+static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
+				   unsigned int total_sg)
 {
 	/*
 	 * If the host supports indirect descriptor tables, and we have multiple
@@ -349,7 +349,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
  * making all of the arch DMA ops work on the vring device itself
  * is a mess.
  */
-static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
+static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
 	return vq->dma_dev;
 }
@@ -784,7 +784,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 }
 
-static inline bool more_used_split(const struct vring_virtqueue *vq)
+static bool more_used_split(const struct vring_virtqueue *vq)
 {
 	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
@@ -1172,12 +1172,12 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 /*
  * Packed ring specific functions - *_packed().
  */
-static inline bool packed_used_wrap_counter(u16 last_used_idx)
+static bool packed_used_wrap_counter(u16 last_used_idx)
 {
 	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
 
-static inline u16 packed_last_used(u16 last_used_idx)
+static u16 packed_last_used(u16 last_used_idx)
 {
 	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
 }
@@ -1612,7 +1612,7 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static inline bool more_used_packed(const struct vring_virtqueue *vq)
+static bool more_used_packed(const struct vring_virtqueue *vq)
 {
 	u16 last_used;
 	u16 last_used_idx;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
