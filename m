Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD14EB64DD
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 16:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 238CE405D0;
	Tue,  4 Jul 2023 16:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 238CE405D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQD7+wgt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NuonZbo-vdu; Tue,  4 Jul 2023 16:41:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBE134045C;
	Tue,  4 Jul 2023 16:41:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBE134045C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5BC5C0071;
	Tue,  4 Jul 2023 16:41:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC5CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 110154176A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 110154176A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQD7+wgt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lIsetJGBcaKW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:41:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3039C40941
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3039C40941
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688488863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3fmV53fwhiWk7sQEChyplGv7CVi08pMxUVWbzUrLYY=;
 b=SQD7+wgtnB08hvcp5lUn9+VuXakI+kxin56HYjkAD/jbUUB9ReSu/SL6egDQa5+ADC/aGi
 0Z5rhilu43C5TSTqvayTpwB/xMfrW3oVkDLWiVQEKx2hoSaAqC+Nrl0hsR3ucBFGhENH7A
 5XGtFL2XpGYC3vr7mLx/4mZP702ReV4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-eJ42uQqnNNqHjT5-jlVUrw-1; Tue, 04 Jul 2023 12:40:59 -0400
X-MC-Unique: eJ42uQqnNNqHjT5-jlVUrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B6FE38008B2;
 Tue,  4 Jul 2023 16:40:59 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0A1E492B02;
 Tue,  4 Jul 2023 16:40:56 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
 david.marchand@redhat.com, lulu@redhat.com
Subject: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Date: Tue,  4 Jul 2023 18:40:45 +0200
Message-ID: <20230704164045.39119-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230704164045.39119-1-maxime.coquelin@redhat.com>
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>
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

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's disable control virtqueue and features that depend on
it.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1271c9796517..04367a53802b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_fixup(struct vduse_dev_config *config)
+{
+	if (config->device_id == VIRTIO_ID_NET) {
+		/*
+		 * Temporarily disable control virtqueue and features that
+		 * depend on it while CVQ is being made more robust for VDUSE.
+		 */
+		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
+				(1ULL << VIRTIO_NET_F_CTRL_RX) |
+				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
+				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
+				(1ULL << VIRTIO_NET_F_MQ) |
+				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
+				(1ULL << VIRTIO_NET_F_RSS) |
+				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
+				(1ULL << VIRTIO_NET_F_NOTF_COAL));
+	}
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_fixup(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
