Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28ABC61DA4
	for <virtualization@archiver.kernel.org>; Sun,  5 Mar 2023 13:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2ECEA40489;
	Sun,  5 Mar 2023 13:53:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ECEA40489
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l0EpUe9g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0Ru54ORMtiO; Sun,  5 Mar 2023 13:53:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EEF140482;
	Sun,  5 Mar 2023 13:53:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EEF140482
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47509C0071;
	Sun,  5 Mar 2023 13:53:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9235C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 13:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 945EF4056A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 13:53:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 945EF4056A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=l0EpUe9g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1WKe9W9T1vhB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 13:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 061CB40338
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 061CB40338
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 13:53:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3042EB80A89;
 Sun,  5 Mar 2023 13:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FEC4339E;
 Sun,  5 Mar 2023 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678024406;
 bh=cghi09Wbzn7gRbEilv55hS/JW49IJkg0VYRCod5bCys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l0EpUe9g45auH0H1UZNMQk27XknjtohHphKLP8DXt4M0koLJ5r26nQbjN2WvK5VK/
 3NPJlhLsCGKfJBOArBJHywr8VkqoiqHHZfDjjsc7PbSKMH/LxBnh2mppI3TxC6xLc8
 UFqC0lmRR+nwpYMmmkWn8W77GZk4I2R1SQiDHHxMZl2vPSmSN287Fvx9eeElm7dEjG
 HMrBUMF2vMlIql7AtLbiTzhJ88Aph++C00hn8zvwCAIQNcTGcPLFZUt/utu9SIkP7P
 VF6fuvC12Qpx1H/5LIwlIm25VfWq2/fDVdTrcRkrgkcZ+K2brSjpaAFEbi812bLI1+
 SY/SKogzuBUQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/15] s390/virtio: sort out physical vs virtual
 pointers usage
Date: Sun,  5 Mar 2023 08:52:56 -0500
Message-Id: <20230305135306.1793564-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305135306.1793564-1-sashal@kernel.org>
References: <20230305135306.1793564-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
 farman@linux.ibm.com, Nico Boehr <nrb@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, gor@linux.ibm.com, hca@linux.ibm.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, kvm@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
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

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 5fc5b94a273655128159186c87662105db8afeb5 ]

This does not fix a real bug, since virtual addresses
are currently indentical to physical ones.

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/virtio/virtio_ccw.c | 46 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index a10dbe632ef9b..954fc31b4bc74 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -363,7 +363,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		thinint_area->isc = VIRTIO_AIRQ_ISC;
 		ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
 		ccw->count = sizeof(*thinint_area);
-		ccw->cda = (__u32)(unsigned long) thinint_area;
+		ccw->cda = (__u32)virt_to_phys(thinint_area);
 	} else {
 		/* payload is the address of the indicators */
 		indicatorp = ccw_device_dma_zalloc(vcdev->cdev,
@@ -373,7 +373,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		*indicatorp = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->count = sizeof(indicators(vcdev));
-		ccw->cda = (__u32)(unsigned long) indicatorp;
+		ccw->cda = (__u32)virt_to_phys(indicatorp);
 	}
 	/* Deregister indicators from host. */
 	*indicators(vcdev) = 0;
@@ -417,7 +417,7 @@ static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
 	ccw->cmd_code = CCW_CMD_READ_VQ_CONF;
 	ccw->flags = 0;
 	ccw->count = sizeof(struct vq_config_block);
-	ccw->cda = (__u32)(unsigned long)(&vcdev->dma_area->config_block);
+	ccw->cda = (__u32)virt_to_phys(&vcdev->dma_area->config_block);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
 	if (ret)
 		return ret;
@@ -454,7 +454,7 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 	}
 	ccw->cmd_code = CCW_CMD_SET_VQ;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(unsigned long)(info->info_block);
+	ccw->cda = (__u32)virt_to_phys(info->info_block);
 	ret = ccw_io_helper(vcdev, ccw,
 			    VIRTIO_CCW_DOING_SET_VQ | index);
 	/*
@@ -556,7 +556,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	}
 	ccw->cmd_code = CCW_CMD_SET_VQ;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(unsigned long)(info->info_block);
+	ccw->cda = (__u32)virt_to_phys(info->info_block);
 	err = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_VQ | i);
 	if (err) {
 		dev_warn(&vcdev->cdev->dev, "SET_VQ failed\n");
@@ -590,6 +590,7 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 {
 	int ret;
 	struct virtio_thinint_area *thinint_area = NULL;
+	unsigned long indicator_addr;
 	struct airq_info *info;
 
 	thinint_area = ccw_device_dma_zalloc(vcdev->cdev,
@@ -599,21 +600,22 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 		goto out;
 	}
 	/* Try to get an indicator. */
-	thinint_area->indicator = get_airq_indicator(vqs, nvqs,
-						     &thinint_area->bit_nr,
-						     &vcdev->airq_info);
-	if (!thinint_area->indicator) {
+	indicator_addr = get_airq_indicator(vqs, nvqs,
+					    &thinint_area->bit_nr,
+					    &vcdev->airq_info);
+	if (!indicator_addr) {
 		ret = -ENOSPC;
 		goto out;
 	}
+	thinint_area->indicator = virt_to_phys((void *)indicator_addr);
 	info = vcdev->airq_info;
 	thinint_area->summary_indicator =
-		(unsigned long) get_summary_indicator(info);
+		virt_to_phys(get_summary_indicator(info));
 	thinint_area->isc = VIRTIO_AIRQ_ISC;
 	ccw->cmd_code = CCW_CMD_SET_IND_ADAPTER;
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = sizeof(*thinint_area);
-	ccw->cda = (__u32)(unsigned long)thinint_area;
+	ccw->cda = (__u32)virt_to_phys(thinint_area);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND_ADAPTER);
 	if (ret) {
 		if (ret == -EOPNOTSUPP) {
@@ -686,7 +688,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->flags = 0;
 		ccw->count = sizeof(indicators(vcdev));
-		ccw->cda = (__u32)(unsigned long) indicatorp;
+		ccw->cda = (__u32)virt_to_phys(indicatorp);
 		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
 		if (ret)
 			goto out;
@@ -697,7 +699,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
 	ccw->flags = 0;
 	ccw->count = sizeof(indicators2(vcdev));
-	ccw->cda = (__u32)(unsigned long) indicatorp;
+	ccw->cda = (__u32)virt_to_phys(indicatorp);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
 	if (ret)
 		goto out;
@@ -759,7 +761,7 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	ccw->cmd_code = CCW_CMD_READ_FEAT;
 	ccw->flags = 0;
 	ccw->count = sizeof(*features);
-	ccw->cda = (__u32)(unsigned long)features;
+	ccw->cda = (__u32)virt_to_phys(features);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_FEAT);
 	if (ret) {
 		rc = 0;
@@ -776,7 +778,7 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	ccw->cmd_code = CCW_CMD_READ_FEAT;
 	ccw->flags = 0;
 	ccw->count = sizeof(*features);
-	ccw->cda = (__u32)(unsigned long)features;
+	ccw->cda = (__u32)virt_to_phys(features);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_FEAT);
 	if (ret == 0)
 		rc |= (u64)le32_to_cpu(features->features) << 32;
@@ -829,7 +831,7 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
 	ccw->flags = 0;
 	ccw->count = sizeof(*features);
-	ccw->cda = (__u32)(unsigned long)features;
+	ccw->cda = (__u32)virt_to_phys(features);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
 	if (ret)
 		goto out_free;
@@ -843,7 +845,7 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
 	ccw->flags = 0;
 	ccw->count = sizeof(*features);
-	ccw->cda = (__u32)(unsigned long)features;
+	ccw->cda = (__u32)virt_to_phys(features);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
 
 out_free:
@@ -875,7 +877,7 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 	ccw->cmd_code = CCW_CMD_READ_CONF;
 	ccw->flags = 0;
 	ccw->count = offset + len;
-	ccw->cda = (__u32)(unsigned long)config_area;
+	ccw->cda = (__u32)virt_to_phys(config_area);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_CONFIG);
 	if (ret)
 		goto out_free;
@@ -922,7 +924,7 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 	ccw->cmd_code = CCW_CMD_WRITE_CONF;
 	ccw->flags = 0;
 	ccw->count = offset + len;
-	ccw->cda = (__u32)(unsigned long)config_area;
+	ccw->cda = (__u32)virt_to_phys(config_area);
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_CONFIG);
 
 out_free:
@@ -946,7 +948,7 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 	ccw->cmd_code = CCW_CMD_READ_STATUS;
 	ccw->flags = 0;
 	ccw->count = sizeof(vcdev->dma_area->status);
-	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
+	ccw->cda = (__u32)virt_to_phys(&vcdev->dma_area->status);
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_STATUS);
 /*
  * If the channel program failed (should only happen if the device
@@ -975,7 +977,7 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	ccw->cmd_code = CCW_CMD_WRITE_STATUS;
 	ccw->flags = 0;
 	ccw->count = sizeof(status);
-	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
+	ccw->cda = (__u32)virt_to_phys(&vcdev->dma_area->status);
 	/* We use ssch for setting the status which is a serializing
 	 * instruction that guarantees the memory writes have
 	 * completed before ssch.
@@ -1274,7 +1276,7 @@ static int virtio_ccw_set_transport_rev(struct virtio_ccw_device *vcdev)
 	ccw->cmd_code = CCW_CMD_SET_VIRTIO_REV;
 	ccw->flags = 0;
 	ccw->count = sizeof(*rev);
-	ccw->cda = (__u32)(unsigned long)rev;
+	ccw->cda = (__u32)virt_to_phys(rev);
 
 	vcdev->revision = VIRTIO_CCW_REV_MAX;
 	do {
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
