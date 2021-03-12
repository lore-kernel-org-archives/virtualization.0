Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F154C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:12:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39E364FA9
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39E364FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C1DF414F1;
	Fri, 12 Mar 2021 14:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SHG5ZoCzOjC; Fri, 12 Mar 2021 14:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49D934017B;
	Fri, 12 Mar 2021 14:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BCF7C000A;
	Fri, 12 Mar 2021 14:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 897DCC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7775784570
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com header.b="LRFkbdiZ";
 dkim=pass (1024-bit key) header.d=redhat.com header.b="VuF4/IY8"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uzs_2f5m5XwP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73E168456D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615558162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQYoIfj5WQ3gNxzaMGVHtAJ8toU1d/6LwVnCduC2jYw=;
 b=LRFkbdiZM2Agp62DLBALgezzkAZIvFCe3OWMccp5oNzpOCNqltb445MO/K9xGAfAbIqN1j
 DniVc7N6C5v0GxMRGuxLH2ncov5fZZZ1ms2czgbtv+of3R/Vo5n1VkG/DVrMS1pf2DUzoZ
 6UVkCmr8S+L/xMffbzH9XJ5n8etzoqQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615558365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQYoIfj5WQ3gNxzaMGVHtAJ8toU1d/6LwVnCduC2jYw=;
 b=VuF4/IY8FIovvf85vqqvZutaIMmPhJzL01tEsPwFDKlRxXd9xIX2TY0N17D3jpKpbcmsLd
 RtZM3HMBqODsYFNBViNwjreHej7AzoOgK2LbLsGkPDK3u3j3PRiA/NtUOIYggvmXN70SOM
 HNHqliIki/MlNQSCX9Ej+TXXh7FzQ2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-A4vm1f_pNRqwjRFzk--NuQ-1; Fri, 12 Mar 2021 09:09:20 -0500
X-MC-Unique: A4vm1f_pNRqwjRFzk--NuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D392EC1A0;
 Fri, 12 Mar 2021 14:09:19 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B52F60877;
 Fri, 12 Mar 2021 14:09:14 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: Fix vhost_vq_reset()
Date: Fri, 12 Mar 2021 15:09:13 +0100
Message-Id: <20210312140913.788592-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

vhost_reset_is_le() is vhost_init_is_le(), and in the case of
cross-endian legacy, vhost_init_is_le() depends on vq->user_be.

vq->user_be is set by vhost_disable_cross_endian().

But in vhost_vq_reset(), we have:

    vhost_reset_is_le(vq);
    vhost_disable_cross_endian(vq);

And so user_be is used before being set.

To fix that, reverse the lines order as there is no other dependency
between them.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a262e12c6dc2..5ccb0705beae 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -332,8 +332,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->error_ctx = NULL;
 	vq->kick = NULL;
 	vq->log_ctx = NULL;
-	vhost_reset_is_le(vq);
 	vhost_disable_cross_endian(vq);
+	vhost_reset_is_le(vq);
 	vq->busyloop_timeout = 0;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
