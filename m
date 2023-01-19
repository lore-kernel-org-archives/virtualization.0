Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75487C46467
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 06:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AD6C610BE;
	Thu, 19 Jan 2023 06:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AD6C610BE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DvgK9VC9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BK1uFHcOxA-z; Thu, 19 Jan 2023 06:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD7EF610CD;
	Thu, 19 Jan 2023 06:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD7EF610CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85E1CC0032;
	Thu, 19 Jan 2023 06:15:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3B69C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C0A0610CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C0A0610CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lICUukRdQSvu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2620610BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2620610BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674108951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SMXVPjE8hhIEfNKKmiT1OISlo/3YeTVVQSZ6tsGfyw=;
 b=DvgK9VC99Pa3Ww179LZYMO2T/ZNU6X+WzcphwEZ7AWift6lEulFOzxEFqm915sM3YLPMFT
 MEi97oZGgcdU1ltEzAjVjeKLDi7LqNchNTRFMGM5kZakxt+/5Qs0K87L8u/fAxkNBQiMa/
 tNw1mgz4VN3E6I75f8y0owq/Z/hbDz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-RCiPZeyiPgOMvVWjSTK2PA-1; Thu, 19 Jan 2023 01:15:50 -0500
X-MC-Unique: RCiPZeyiPgOMvVWjSTK2PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1298811E9C;
 Thu, 19 Jan 2023 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F04E1121315;
 Thu, 19 Jan 2023 06:15:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 4/5] vdpa: set dma mask for vDPA device
Date: Thu, 19 Jan 2023 14:15:24 +0800
Message-Id: <20230119061525.75068-5-jasowang@redhat.com>
In-Reply-To: <20230119061525.75068-1-jasowang@redhat.com>
References: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: gdawar@amd.com, elic@nvidia.com, virtualization@lists.linux-foundation.org,
 tanuj.kamde@amd.com, linux-kernel@vger.kernel.org
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

Reviewed-by: Eli Cohen <elic@nvidia.com>
Tested-by: Eli Cohen <elic@nvidia.com>
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
