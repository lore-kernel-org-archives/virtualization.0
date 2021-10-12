Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A83C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849446103D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 849446103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5001180F89;
	Tue, 12 Oct 2021 06:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-57EDAqHb_x; Tue, 12 Oct 2021 06:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00C5080E5F;
	Tue, 12 Oct 2021 06:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF87C000F;
	Tue, 12 Oct 2021 06:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 255EBC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1120A402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bC0y2Og5qjnb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27D33402DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+K4kt6jiYyHpuZzO5X/M+fhiiJdrYmcNWNspSWWUPP8=;
 b=I0YEVeOJ8qgKxTLZQMhBFD9A0tmBoSizFTd65hpvwRNowj3Bn7H3QjhlxGdqvc6UKIlkfB
 4h53x3Hv/ZjzanRPvDo69fKpN6sTaBJ+/oSJWX4pUBHBshDObS25kVN8SFKB8a5y3PCiYT
 Nod/SBcKPSksEBz8dlZvcmELlQmoQRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-lX42bIKgOCOkpdi63T3AdQ-1; Tue, 12 Oct 2021 02:53:02 -0400
X-MC-Unique: lX42bIKgOCOkpdi63T3AdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED362824FBB;
 Tue, 12 Oct 2021 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com
 [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4949E5F4EA;
 Tue, 12 Oct 2021 06:52:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Date: Tue, 12 Oct 2021 14:52:16 +0800
Message-Id: <20211012065227.9953-2-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

If an untrusted device neogitates BLK_F_MQ but advertises a zero
num_queues, the driver may end up trying to allocating zero size
buffers where ZERO_SIZE_PTR is returned which may pass the checking
against the NULL. This will lead unexpected results.

Fixing this by using single queue if num_queues is zero.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3bd083b411..9deff01a38cb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
 				   &num_vqs);
-	if (err)
+	/* We need at least one virtqueue */
+	if (err || !num_vqs)
 		num_vqs = 1;
 
 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
