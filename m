Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518FBC54EBE
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 06:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7F1F40232;
	Wed, 11 Jan 2023 06:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7F1F40232
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JnM9I9pg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JR02l1sSORq4; Wed, 11 Jan 2023 06:28:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72C5A40AA9;
	Wed, 11 Jan 2023 06:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72C5A40AA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5029CC0032;
	Wed, 11 Jan 2023 06:28:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD81C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D07E380DC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D07E380DC0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JnM9I9pg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWcuqnMYhsMn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3315E80C67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3315E80C67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673418514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+4wcK32yTG8RIPffsWit0AM8U7mssDeI6INzJz2GeQ=;
 b=JnM9I9pgJVzW+jG3yMgt8Gi21WUsINU0uZb9nhc3o8sS78kxwP/OcyZ65q16XtITK994fa
 S+QmvdzO4I4j+B4uAmQIW7WawyvmYgxJbc7BVs6fsAmT2ByKdqamnztpuj9cxKPUaF6bSn
 DMVSZuzGY83HhUtYzFBqhDaKgpa3DP8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-_n38zNkSN4y1z_p4rB0FMQ-1; Wed, 11 Jan 2023 01:28:31 -0500
X-MC-Unique: _n38zNkSN4y1z_p4rB0FMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B89D2A59557;
 Wed, 11 Jan 2023 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com
 [10.72.13.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E61B4078903;
 Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 4/5] vdpa: set dma mask for vDPA device
Date: Wed, 11 Jan 2023 14:28:08 +0800
Message-Id: <20230111062809.25020-5-jasowang@redhat.com>
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

Setting DMA mask for vDPA device in case that there are virtqueue that
is not backed by DMA so the vDPA device could be advertised as the DMA
device that is used by DMA API for software emulated virtqueues.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1365cc..6821b2850bbb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -39,6 +39,11 @@ static int vdpa_dev_probe(struct device *d)
 	u32 max_num, min_num = 1;
 	int ret = 0;
 
+	d->dma_mask = &d->coherent_dma_mask;
+	ret = dma_set_mask_and_coherent(d, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	max_num = ops->get_vq_num_max(vdev);
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdev);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
