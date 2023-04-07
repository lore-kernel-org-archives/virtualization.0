Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C4C6FD1D
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 13:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5716E41E2E;
	Fri,  7 Apr 2023 13:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5716E41E2E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYEIuVD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cttv9RsGUEhz; Fri,  7 Apr 2023 13:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9BD0141E24;
	Fri,  7 Apr 2023 13:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BD0141E24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74903C0036;
	Fri,  7 Apr 2023 13:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F562C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E061F42030
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E061F42030
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYEIuVD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mjKSMywEYr1i
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACEAD41FEF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACEAD41FEF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680874642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpRSctN0jCeuhjjA6kJE7wGPHdDwELgwrk4O7O5qFoQ=;
 b=hYEIuVD9wS7JpsRAhya585k1Zq7XYZqS0pPSy/dqrnCQPcmSf9t2qnThWqEaa+eO3TSP/L
 TPwOQ4/NsYHsrpNegGM5kpNYtRm6BNPo/QNK+cMXuuSnLab3jbckL4LZYVr2vNn7NJb1P/
 LJLm0QLvgV59oQXXkuQbATilT18X2i8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-iJh3W_TBNdeOVqLQpUGyyg-1; Fri, 07 Apr 2023 09:37:21 -0400
X-MC-Unique: iJh3W_TBNdeOVqLQpUGyyg-1
Received: by mail-qt1-f197.google.com with SMTP id
 r22-20020ac85c96000000b003e638022bc9so16842535qta.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 06:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680874640; x=1683466640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpRSctN0jCeuhjjA6kJE7wGPHdDwELgwrk4O7O5qFoQ=;
 b=DNL10ntQxxXkEQxmXATP9N+mMh2p4vFxiOwf5jssBTz566h6Ckl2iAPBeloP1iGGlN
 jv2dB6fQ4b+RSXPdFWNx6AGuvRyGOSpMKp2DCEJnQQ5EyiO+J9hPcNkBsLnU/+6h3Q5v
 hgzQJcS+bo/KvR/p0ivyeFJC5JO/WHWeLqx3r01qi7yvf3QA4BPsvSxqNXdTUadxaktH
 DHvuGXbnObaSlZqW0iyQxJRud3qNFvyyyKseJJaPVWb4xVXx1gwk2P0GwHs9Z9MQX0j0
 d3TD/vE5zoW1LdI3sSCH5dwCDkBMFEYY5hbguJ/Q/mq9ryhiyhCvtyw58FxbcM92wPut
 zgrw==
X-Gm-Message-State: AAQBX9cGBg3U9rfhtyG3dfuKu1xilhGjwRWlJDidud9rIEvqquuYUS+V
 /qoI5Z7gIUpBJMDr4rdfcI5YkYc17BNTwJWpXJYR+1+qa1ShuGLdfMm//B25pTe1YW4FjZhG37K
 hSCzOeKoUl/AzmGHWZgtllbfjZu+vvJkSPqJ/zEPQgDwFqFiaup30tPsDsw3MqMqeYLVRA7uhpz
 Vc4oo5S/9mBQ+ed1nYOPfFFDC5bg==
X-Received: by 2002:a05:6214:c2f:b0:5a4:548e:4ed6 with SMTP id
 a15-20020a0562140c2f00b005a4548e4ed6mr4329631qvd.40.1680874640569; 
 Fri, 07 Apr 2023 06:37:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXs4iAie/qz64HuzAtlTPD297dbypTAD80jqfK809WSZrnMp+K5iTEUwMbyItqqdh9DaB+VA==
X-Received: by 2002:a05:6214:c2f:b0:5a4:548e:4ed6 with SMTP id
 a15-20020a0562140c2f00b005a4548e4ed6mr4329582qvd.40.1680874640146; 
 Fri, 07 Apr 2023 06:37:20 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
 by smtp.gmail.com with ESMTPSA id
 x85-20020a376358000000b0074a28c33df7sm1300194qkb.84.2023.04.07.06.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Apr 2023 06:37:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vdpa_sim_blk: support shared backend
Date: Fri,  7 Apr 2023 15:36:58 +0200
Message-Id: <20230407133658.66339-3-sgarzare@redhat.com>
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

The vdpa_sim_blk simulator uses a ramdisk as the backend. To test live
migration, we need two devices that share the backend to have the data
synchronized with each other.

Add a new module parameter to make the buffer shared between all devices.

The shared_buffer_mutex is used just to ensure that each operation is
atomic, but it is up to the user to use the devices knowing that the
underlying ramdisk is shared.

For example, when we do a migration, the VMM (e.g., QEMU) will guarantee
to write to the destination device, only after completing operations with
the source device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 57 ++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c996e750dc02..00d7d72713be 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -46,6 +46,7 @@
 struct vdpasim_blk {
 	struct vdpasim vdpasim;
 	void *buffer;
+	bool shared_backend;
 };
 
 static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
@@ -55,6 +56,26 @@ static struct vdpasim_blk *sim_to_blk(struct vdpasim *vdpasim)
 
 static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
+static bool shared_backend;
+module_param(shared_backend, bool, 0444);
+MODULE_PARM_DESC(shared_backend, "Enable the shared backend between virtio-blk devices");
+
+static void *shared_buffer;
+/* mutex to synchronize shared_buffer access */
+static DEFINE_MUTEX(shared_buffer_mutex);
+
+static void vdpasim_blk_buffer_lock(struct vdpasim_blk *blk)
+{
+	if (blk->shared_backend)
+		mutex_lock(&shared_buffer_mutex);
+}
+
+static void vdpasim_blk_buffer_unlock(struct vdpasim_blk *blk)
+{
+	if (blk->shared_backend)
+		mutex_unlock(&shared_buffer_mutex);
+}
+
 static bool vdpasim_blk_check_range(struct vdpasim *vdpasim, u64 start_sector,
 				    u64 num_sectors, u64 max_sectors)
 {
@@ -154,8 +175,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 			break;
 		}
 
+		vdpasim_blk_buffer_lock(blk);
 		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
 					      blk->buffer + offset, to_push);
+		vdpasim_blk_buffer_unlock(blk);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -175,8 +198,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 			break;
 		}
 
+		vdpasim_blk_buffer_lock(blk);
 		bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov,
 					      blk->buffer + offset, to_pull);
+		vdpasim_blk_buffer_unlock(blk);
 		if (bytes < 0) {
 			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
@@ -256,8 +281,10 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
+			vdpasim_blk_buffer_lock(blk);
 			memset(blk->buffer + offset, 0,
 			       num_sectors << SECTOR_SHIFT);
+			vdpasim_blk_buffer_unlock(blk);
 		}
 
 		break;
@@ -366,7 +393,8 @@ static void vdpasim_blk_free(struct vdpasim *vdpasim)
 {
 	struct vdpasim_blk *blk = sim_to_blk(vdpasim);
 
-	kvfree(blk->buffer);
+	if (!blk->shared_backend)
+		kvfree(blk->buffer);
 }
 
 static void vdpasim_blk_mgmtdev_release(struct device *dev)
@@ -404,12 +432,17 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return PTR_ERR(simdev);
 
 	blk = sim_to_blk(simdev);
-
-	blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
-			       GFP_KERNEL);
-	if (!blk->buffer) {
-		ret = -ENOMEM;
-		goto put_dev;
+	blk->shared_backend = shared_backend;
+
+	if (blk->shared_backend) {
+		blk->buffer = shared_buffer;
+	} else {
+		blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+				       GFP_KERNEL);
+		if (!blk->buffer) {
+			ret = -ENOMEM;
+			goto put_dev;
+		}
 	}
 
 	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
@@ -461,6 +494,15 @@ static int __init vdpasim_blk_init(void)
 	if (ret)
 		goto parent_err;
 
+	if (shared_backend) {
+		shared_buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+					 GFP_KERNEL);
+		if (!shared_buffer) {
+			ret = -ENOMEM;
+			goto parent_err;
+		}
+	}
+
 	return 0;
 
 parent_err:
@@ -470,6 +512,7 @@ static int __init vdpasim_blk_init(void)
 
 static void __exit vdpasim_blk_exit(void)
 {
+	kvfree(shared_buffer);
 	vdpa_mgmtdev_unregister(&mgmt_dev);
 	device_unregister(&vdpasim_blk_mgmtdev);
 }
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
