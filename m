Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CABE71064
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 12:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDFFB40A1F;
	Thu, 21 Sep 2023 12:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDFFB40A1F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ay5bBY/X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUQPFaJaD0zv; Thu, 21 Sep 2023 12:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40883409BD;
	Thu, 21 Sep 2023 12:41:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40883409BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACAAC0071;
	Thu, 21 Sep 2023 12:41:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5D2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B01A60FF8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B01A60FF8
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ay5bBY/X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FkjMMDidQeG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0299361000
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0299361000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc/S+Ixx7nz3e0e7nefBpI7X3UVxXHN5NV3rEf9zhC3+PfryDrdgZSxhOGFcXU/2G+Lp64RbCNMMsJdevvtbsUrkaZFrDFIUgSdvbMEIZPsaFm079C8yCqeZffAWodSd2xf2TIRePJx3AKFS0LiFZHOon+KCXAYMcoDJwuUoC/x+gVVrn+aLwM/Us236DvywjPiiCs7WpIU79K44QxKGHd6VtDl0wzDQIS89V+BKACncllMIUM7YKy1zFZRwDHhvlI/mp32fiH5WoibSkKZ2W+UgHPkVMj3ErtIJblS6YMAsBZau8Jp8B+PQhap70HWEBJQOrtUlZaRIWVxhd/v/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC/Q/vB60/w2vwe0f3rUOMWf2K9QuBGjKjXbMP01yqA=;
 b=XfhJ/9h2hiV6uYIyFSmYr539X3xVRvdUyB7KNCo1N9FfLeILJq6+hx+JyIyrylY78Wnjh1VL6BhGzYmAdPgfPCPec7C0HnX79kEKqfp24RRA5pmUi01bBczdMU0KN5WYBeYG4MAS7/RzjhZh54mYo2oP1XaCxoZ9BWfV5dUWQgw6CexQ0EobjwdRtoUdU9Xr0BK7vQZYYIrsG2I5/SPm+IHHYm5i/tm1LXLeiGiQ/w8IQ1XYoVm0mhs9GYViY+ukXFXzyQqsJnb384cZsYgv6i+sZ6xKSPMuf+vQJafuN1hmctRto8aJog2ZqYeZUWu4Jli5hTw3WnpfNzfoYLzKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC/Q/vB60/w2vwe0f3rUOMWf2K9QuBGjKjXbMP01yqA=;
 b=ay5bBY/XYoMm5m4v3qVCwYfoFzYlQrHZsXc9k8UZLppM5oD8gI+U2qzi9jK8IWqtVA3u2ssRXfk5o8UyNsa5o/I3qm6wconP/MLTQWbvqF+OWtOHinSBPBUWYsJVT8oltSy73zh15s0OUh+Td/fUmQLZch6kQlr04STWFZ/YTaWJzIdW1UPmpgNyBO/KjNH1V4s8mWFMt53fZqeD/zJV1wFgUv3K7fRgohbA+S39nVHSeSIKzmF57CVds7y3pkTx97GTY+zB1mtKWr7bZ8pGyvllWoZZP88wQ+OND1o2O9ze4E0d9YVY9Xmd02Xth9hD2R+xZ7F5x5vH5GTpEBv0sw==
Received: from CH0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:610:e6::27)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 12:41:51 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::e) by CH0PR03CA0292.outlook.office365.com
 (2603:10b6:610:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 12:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 12:41:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Sep
 2023 05:41:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Sep
 2023 05:41:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 21 Sep
 2023 05:41:35 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH vfio 04/11] virtio: Expose the synchronous command helper
 function
Date: Thu, 21 Sep 2023 15:40:33 +0300
Message-ID: <20230921124040.145386-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230921124040.145386-1-yishaih@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d8b5ff-4d91-4838-4f2a-08dbbaa02121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szFZp33zsuDI+boqjF+ECppqyNHdca38KKRWFdUIzWIKOyFwHpgE42qhezgep4xhSBRvtr9oCK0BX05Q/ajXQqQHxnfdfO7WcsQhKckfkfwlKR7kYx+dIjeoDrR2upr8X2DZt92H7/ch35LMDblUxg7pUrxSU4aLhXZROHAavXnXmblep2DGg3S2SgkjswNjtOeXKEip5KD7MqJEavDAFn+Sb6sWuWcFShEAQ/+63JCIAZNfivLSpLOfxt9Bmi2tAk1DLzXc8Y5kdW7S3IbYfAPHqD5pEdd8orwCabD0v3oBAmufOF6In6X4nFfR94K+/VWoG/AgFlXZbe2nNdLS4X35mq/TJWYkyHhQxymqzi6NRRAzgyJGbTSBEujHFaRFTr0GSRU5D6vqOLnW8M25krWBkZp+Wfdt9F3yznY4wBI8zeyZlZFy1sJarYZQbMH/XbxNsB9nfkOMY3tcfX9l7sstRp3DbXQbI0gcJ1SV3Owc712byQWtbj7jBjXaesUmsj6nSvYoK6sCpIvOTt/m+btqdyK9SqYrrDAzhf+ERsFqTxi9gBldlHQZeAqS6RTFzdIlOkVz4y868o3RmL9nCWfkfJfG3usfgj/gJVtYPAg+6rw5RXoArv4AOjlxzODkRKBXnKkkB7/+VNt4hbQtjS7e/kE5NqqOHJ4KYndj+5DwVNgVA4zBlgxDBkuUWe5wpVh51d2Wr64pfRbWn0H5fjhJuBwwXTRe2zHMujMdhSqVok0J00+Y0KUl6nqLBWiqTB2SiSzipvSn9ykvGrQJ2A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(107886003)(316002)(54906003)(40480700001)(6636002)(70206006)(70586007)(7696005)(336012)(2616005)(7636003)(356005)(1076003)(426003)(26005)(36756003)(478600001)(47076005)(40460700003)(110136005)(5660300002)(2906002)(82740400003)(8936002)(4326008)(8676002)(36860700001)(86362001)(41300700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 12:41:51.4859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d8b5ff-4d91-4838-4f2a-08dbbaa02121
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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
From: Yishai Hadas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Feng Liu <feliu@nvidia.com>

Synchronous command helper function is exposed at virtio layer,
so that ctrl virtqueue and admin virtqueues can reuse this helper
function to send synchronous commands.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/net/virtio_net.c     | 21 ++++++---------------
 drivers/virtio/virtio_ring.c | 27 +++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 +++++++
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe7f314d65c9..65c210b0fb9e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2451,7 +2451,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	unsigned int out_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2472,23 +2472,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	sgs[out_num] = &stat;
 
 	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
-	if (ret < 0) {
-		dev_warn(&vi->vdev->dev,
-			 "Failed to add sgs for command vq: %d\n.", ret);
+	ret = virtqueue_exec_cmd(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
+	if (ret) {
+		dev_err(&vi->vdev->dev,
+			"Failed to exec command vq(%s,%d): %d\n",
+			vi->cvq->name, vi->cvq->index, ret);
 		return false;
 	}
 
-	if (unlikely(!virtqueue_kick(vi->cvq)))
-		return vi->ctrl->status == VIRTIO_NET_OK;
-
-	/* Spin for a response, the kick causes an ioport write, trapping
-	 * into the hypervisor, so the request should be handled immediately.
-	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
-		cpu_relax();
-
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d8f3299c10..253905c0b008 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3251,4 +3251,31 @@ void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
 
+int virtqueue_exec_cmd(struct virtqueue *vq,
+		       struct scatterlist **sgs,
+		       unsigned int out_num,
+		       unsigned int in_num,
+		       void *data,
+		       gfp_t gfp)
+{
+	int ret, len;
+
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, gfp);
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(!virtqueue_kick(vq)))
+		return -EIO;
+
+	/* Spin for a response, the kick causes an ioport write, trapping
+	 * into the hypervisor, so the request should be handled immediately.
+	 */
+	while (!virtqueue_get_buf(vq, &len) &&
+	       !virtqueue_is_broken(vq))
+		cpu_relax();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_exec_cmd);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4cc614a38376..9d39706bed10 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -103,6 +103,13 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 int virtqueue_reset(struct virtqueue *vq,
 		    void (*recycle)(struct virtqueue *vq, void *buf));
 
+int virtqueue_exec_cmd(struct virtqueue *vq,
+		       struct scatterlist **sgs,
+		       unsigned int out_num,
+		       unsigned int in_num,
+		       void *data,
+		       gfp_t gfp);
+
 /**
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
