Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033D0C77B61
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 13:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 923604202E;
	Fri,  7 Apr 2023 13:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 923604202E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNdBqnkG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bcX0WKv_BCrq; Fri,  7 Apr 2023 13:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F19841EDF;
	Fri,  7 Apr 2023 13:37:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F19841EDF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38616C0036;
	Fri,  7 Apr 2023 13:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 350EEC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DD4741FEF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DD4741FEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DbKyODFdOQgl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B98C41EDF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B98C41EDF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680874635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CvjsPSQL1L1z0z64C2CH04/VWrsTelzBiLbwWcaVEg=;
 b=dNdBqnkGE1YXnOB8vrmbnC9WgVyi+FZDWCgPT21NzgitNmIN+HKYgjnTKo/FsFilN3Ojj2
 YM8k3IMo26tupynvd/cz4VgwzWKlbyn2aJ74MV8PDBNd4taSnpSyJvqq4EXg0wNVcEBAyX
 XlB1SvaUg8+gieEz0oNK2xovLfx6IFA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-IPQuB24OO1-RsHV1iB5fBw-1; Fri, 07 Apr 2023 09:37:13 -0400
X-MC-Unique: IPQuB24OO1-RsHV1iB5fBw-1
Received: by mail-qk1-f197.google.com with SMTP id
 z187-20020a3765c4000000b007468706dfb7so18931520qkb.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 06:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680874633; x=1683466633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CvjsPSQL1L1z0z64C2CH04/VWrsTelzBiLbwWcaVEg=;
 b=8F4ViFu1dNW32GycPoPiXrM0kCbdSbtAb2CtL8M5IXetXioiMBsxLhL4C3+QE2PDHq
 VnwWYJX+MGdM8Gvz6nsPBWTKXV/dnHPTBA2tSSRaXSKptD990Et4oKs++7cNzN87UObw
 CjvnOsgYDygrZdTECh2w1hwUGzgoREspVFL75CWNMSTtqbV+U12lAspXfa3RgL2fYyWA
 w6xHLiXXtJpcwKnH5Eg2LMEf/Y5TA0heKQGkdHfZRhoJVmOq3297S+UzqMEJNPaZtaUo
 DETAe+Z3fMP6BDBPKp1ot8PZGaeM9B4riUosejIejvJqRd5nSNx455wqshw2NweER9hR
 RUpA==
X-Gm-Message-State: AAQBX9faj+wS/Y/kkxFb2zVIjpXPVOYnTydz1G5iPdAuaAAUkMHTZ5bo
 aFcWD6YNxWMxgcSPY7rYViQAHPr/SuMxKGmPcOHgPDRXdUAs148jO7Xdr30Gq3b3AJMi3rqjwa/
 WngNUvgiko2y+WSPRY9qZXSDkfmAzbOTXzQEf3DrUo+lv3jHPMFZpx31/RnPBBLsdYjfycL3TMt
 NYt1zcbhx/4L4GH4ioge/OLe39cQ==
X-Received: by 2002:ac8:5981:0:b0:3e3:7ce1:e746 with SMTP id
 e1-20020ac85981000000b003e37ce1e746mr4388239qte.15.1680874632933; 
 Fri, 07 Apr 2023 06:37:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z17fbTn/0ZgVYtRLhjxq5vHbWbH/sjK8zpzOJzIzXryFW2EI4gtQ4Epm8iHl4T+0kX2ItJrA==
X-Received: by 2002:ac8:5981:0:b0:3e3:7ce1:e746 with SMTP id
 e1-20020ac85981000000b003e37ce1e746mr4388190qte.15.1680874632601; 
 Fri, 07 Apr 2023 06:37:12 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
 by smtp.gmail.com with ESMTPSA id
 j25-20020ac874d9000000b003e394714c07sm1197688qtr.10.2023.04.07.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Apr 2023 06:37:11 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] vdpa_sim: move buffer allocation in the devices
Date: Fri,  7 Apr 2023 15:36:57 +0200
Message-Id: <20230407133658.66339-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407133658.66339-1-sgarzare@redhat.com>
References: <20230407133658.66339-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez=20Martin?= <eperezma@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Currently, the vdpa_sim core does not use the buffer, but only
allocates it.

The buffer is used by devices differently, and some future devices
may not use it. So let's move all its management inside the devices.

Add a new `free` device callback called to clean up the resources
allocated by the device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 +--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  7 ++---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 40 +++++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 28 ++++++++++++++-----
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 3a42887d05d9..bb137e479763 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -39,7 +39,6 @@ struct vdpasim_dev_attr {
 	u64 supported_features;
 	size_t alloc_size;
 	size_t config_size;
-	size_t buffer_size;
 	int nvqs;
 	u32 id;
 	u32 ngroups;
@@ -51,6 +50,7 @@ struct vdpasim_dev_attr {
 	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
 			 struct sk_buff *msg,
 			 struct netlink_ext_ack *extack);
+	void (*free)(struct vdpasim *vdpasim);
 };
 
 /* State of each vdpasim device */
@@ -67,7 +67,6 @@ struct vdpasim {
 	void *config;
 	struct vhost_iotlb *iommu;
 	bool *iommu_pt;
-	void *buffer;
 	u32 status;
 	u32 generation;
 	u64 features;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2c706bb18897..d343af4fa60e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -261,10 +261,6 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
-	vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
-	if (!vdpasim->buffer)
-		goto err_iommu;
-
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
 				 &vdpasim->iommu_lock);
@@ -714,7 +710,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
 	}
 
-	kvfree(vdpasim->buffer);
+	vdpasim->dev_attr.free(vdpasim);
+
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
 	kfree(vdpasim->iommu);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 568119e1553f..c996e750dc02 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -43,6 +43,16 @@
 #define VDPASIM_BLK_AS_NUM	1
 #define VDPASIM_BLK_GROUP_NUM	1
 
+struct vdpasim_blk {
+	struct vdpasim vdpasim;
+	void *buffer;
+};
+
+static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
+{
+	return container_of(vdpasim, struct vdpasim_blk, vdpasim);
+}
+
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
 static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
@@ -78,6 +88,7 @@ static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 				   struct vdpasim_virtqueue *vq)
 {
+	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
 	size_t pushed = 0, to_pull, to_push;
 	struct virtio_blk_outhdr hdr;
 	bool handled = false;
@@ -144,8 +155,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
-					      vdpasim->buffer + offset,
-					      to_push);
+					      blk->buffer + offset, to_push);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -166,8 +176,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov,
-					      vdpasim->buffer + offset,
-					      to_pull);
+					      blk->buffer + offset, to_pull);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -247,7 +256,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
-			memset(vdpasim->buffer + offset, 0,
+			memset(blk->buffer + offset, 0,
 			       num_sectors << SECTOR_SHIFT);
 		}
 
@@ -353,6 +362,13 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
 
 }
 
+static void vdpasim_blk_free(struct vdpasim *vdpasim)
+{
+	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
+
+	kvfree(blk->buffer);
+}
+
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
 {
 }
@@ -366,6 +382,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim_blk *blk;
 	struct vdpasim *simdev;
 	int ret;
 
@@ -376,16 +393,25 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
 	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
-	dev_attr.alloc_size = sizeof(struct vdpasim);
+	dev_attr.alloc_size = sizeof(struct vdpasim_blk);
 	dev_attr.config_size = sizeof(struct virtio_blk_config);
 	dev_attr.get_config = vdpasim_blk_get_config;
 	dev_attr.work_fn = vdpasim_blk_work;
-	dev_attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
+	dev_attr.free = vdpasim_blk_free;
 
 	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	blk = sim_to_blk(simdev);
+
+	blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+			       GFP_KERNEL);
+	if (!blk->buffer) {
+		ret = -ENOMEM;
+		goto put_dev;
+	}
+
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
 	if (ret)
 		goto put_dev;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 55920502f76b..cfe962911804 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -58,6 +58,7 @@ struct vdpasim_net{
 	struct vdpasim_dataq_stats tx_stats;
 	struct vdpasim_dataq_stats rx_stats;
 	struct vdpasim_cq_stats cq_stats;
+	void *buffer;
 };
 
 static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
@@ -87,14 +88,15 @@ static bool receive_filter(struct vdpasim *vdpasim, size_t len)
 	size_t hdr_len = modern ? sizeof(struct virtio_net_hdr_v1) :
 				  sizeof(struct virtio_net_hdr);
 	struct virtio_net_config *vio_config = vdpasim->config;
+	struct vdpasim_net *net = sim_to_net(vdpasim);
 
 	if (len < ETH_ALEN + hdr_len)
 		return false;
 
-	if (is_broadcast_ether_addr(vdpasim->buffer + hdr_len) ||
-	    is_multicast_ether_addr(vdpasim->buffer + hdr_len))
+	if (is_broadcast_ether_addr(net->buffer + hdr_len) ||
+	    is_multicast_ether_addr(net->buffer + hdr_len))
 		return true;
-	if (!strncmp(vdpasim->buffer + hdr_len, vio_config->mac, ETH_ALEN))
+	if (!strncmp(net->buffer + hdr_len, vio_config->mac, ETH_ALEN))
 		return true;
 
 	return false;
@@ -225,8 +227,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 
 		++tx_pkts;
 		read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
-					     vdpasim->buffer,
-					     PAGE_SIZE);
+					     net->buffer, PAGE_SIZE);
 
 		tx_bytes += read;
 
@@ -245,7 +246,7 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 		}
 
 		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
-					      vdpasim->buffer, read);
+					      net->buffer, read);
 		if (write <= 0) {
 			++rx_errors;
 			break;
@@ -427,6 +428,13 @@ static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
 		vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 }
 
+static void vdpasim_net_free(struct vdpasim *vdpasim)
+{
+	struct vdpasim_net *net = sim_to_net(vdpasim);
+
+	kvfree(net->buffer);
+}
+
 static void vdpasim_net_mgmtdev_release(struct device *dev)
 {
 }
@@ -456,7 +464,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.get_config = vdpasim_net_get_config;
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.get_stats = vdpasim_net_get_stats;
-	dev_attr.buffer_size = PAGE_SIZE;
+	dev_attr.free = vdpasim_net_free;
 
 	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
@@ -470,6 +478,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	u64_stats_init(&net->rx_stats.syncp);
 	u64_stats_init(&net->cq_stats.syncp);
 
+	net->buffer = kvmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!net->buffer) {
+		ret = -ENOMEM;
+		goto reg_err;
+	}
+
 	/*
 	 * Initialization must be completed before this call, since it can
 	 * connect the device to the vDPA bus, so requests can arrive after
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
