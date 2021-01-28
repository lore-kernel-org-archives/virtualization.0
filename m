Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94BCC433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:44:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765ED60C41
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 14:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765ED60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2946D86AB8;
	Thu, 28 Jan 2021 14:44:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ps6QyZc+68uD; Thu, 28 Jan 2021 14:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23DEA86A3B;
	Thu, 28 Jan 2021 14:44:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D44C1825;
	Thu, 28 Jan 2021 14:44:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0097CC0FA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F048D873E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUPOC-yXO2uS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:44:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 029A4873D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611845041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3g1OmTgyQKpO44PG/KohyJWQoMIoCRfwQDA6iGRUjI=;
 b=LBqt9mtMNu3DkQfyyXtxn1snD5ZYOzvhbCEkhdD4TvBo3oB8S8hdX08oAIP8ShDO/e2CQK
 TqP/ZmImbpVckZn7Gql28t/P40+l518lyym1o+OedFvEZd6ezLLcQDdINeaUlLaj052taN
 VLBMoLW1bY89KxKHiR9TwL+Xd5zTups=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-eVSp1GIAMzW-og4lhkqnbw-1; Thu, 28 Jan 2021 09:42:36 -0500
X-MC-Unique: eVSp1GIAMzW-og4lhkqnbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45580107ACF5;
 Thu, 28 Jan 2021 14:42:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A45D06267D;
 Thu, 28 Jan 2021 14:42:29 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 06/10] vdpa_sim: cleanup kiovs in vdpasim_free()
Date: Thu, 28 Jan 2021 15:41:23 +0100
Message-Id: <20210128144127.113245-7-sgarzare@redhat.com>
In-Reply-To: <20210128144127.113245-1-sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

vringh_getdesc_iotlb() allocates memory to store the kvec, that
is freed with vringh_kiov_cleanup().

vringh_getdesc_iotlb() is able to reuse a kvec previously allocated,
so in order to avoid to allocate the kvec for each request, we are
not calling vringh_kiov_cleanup() when we finished to handle a
request, but we should call it when we free the entire device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 53238989713d..a7aeb5d01c3e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -562,8 +562,15 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
 static void vdpasim_free(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int i;
 
 	cancel_work_sync(&vdpasim->work);
+
+	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
+		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
+		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
+	}
+
 	put_iova_domain(&vdpasim->iova);
 	iova_cache_put();
 	kvfree(vdpasim->buffer);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
