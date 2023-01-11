Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18BBC54EBE
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 06:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 801EB81F34;
	Wed, 11 Jan 2023 06:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 801EB81F34
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CCCaurg4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KuTSMtkMqtnj; Wed, 11 Jan 2023 06:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1501A82009;
	Wed, 11 Jan 2023 06:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1501A82009
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E551BC0032;
	Wed, 11 Jan 2023 06:28:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C38BAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F8B860A99
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F8B860A99
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CCCaurg4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gg_TGadAnYed
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDBB8605B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDBB8605B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673418506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbAm8flGGw3yRsNW/jjO4z0Hil6iXxWlmJZ59AWjhnY=;
 b=CCCaurg4imm+I899n1HlN9+wpCz+1q4rUJrYlMfWb/QwIVmZFlyJTYvZHh9D3s9ZAmk74t
 aaFrozWQJsi+aTt2cOmxLm/pCvlJDQlcNEtBkalrYlFoeBEmMBszwTf+KMa8E02vlXgpHl
 h+GgH+01ppNiTRkzVb9ny+tGFUh2uZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-MDkulyrMMU-BWvdrLZyqjw-1; Wed, 11 Jan 2023 01:28:22 -0500
X-MC-Unique: MDkulyrMMU-BWvdrLZyqjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60FF6811E6E;
 Wed, 11 Jan 2023 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com
 [10.72.13.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 648AA4078903;
 Wed, 11 Jan 2023 06:28:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/5] vdpa: introduce get_vq_dma_device()
Date: Wed, 11 Jan 2023 14:28:06 +0800
Message-Id: <20230111062809.25020-3-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: gdawar@amd.com, elic@nvidia.com, linux-kernel@vger.kernel.org,
 tanuj.kamde@amd.com, virtualization@lists.linux-foundation.org
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

This patch introduces a new method to query the dma device that is use
for a specific virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..3ec13aee35f5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -282,6 +282,11 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @get_vq_dma_dev:		Get the dma device for a specific
+ *				virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns pointer to structure device or error (NULL)
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -341,6 +346,7 @@ struct vdpa_config_ops {
 			 u64 iova, u64 size);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
+	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
