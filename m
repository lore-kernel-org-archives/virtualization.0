Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894ADC64E7A
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:27:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4A321D7F
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE52mT4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4A321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8B8962E112;
	Thu, 26 Nov 2020 09:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dc6dy4adJ+E4; Thu, 26 Nov 2020 09:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18E2D2E1F4;
	Thu, 26 Nov 2020 09:26:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020E4C0891;
	Thu, 26 Nov 2020 09:26:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF45FC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A878F2E1F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2WUn1JJtsMo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AF3752E1F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606382812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JtJSGoa5TRfuuBNc87icAYiWh/b5eXjv2GjseWaFBo=;
 b=ZE52mT4niP+AYNOBpQVYXGypkIah81IGZkb4ZqvawyewvgQ0Z9OZ5qF4xXhaPYKCRyhMri
 eItBVoiim3FFExOZdPBDaB4hFirCfpQXWnccxW95t1IvuMr46JVUdS1hVufmMzgQNycG/N
 GCARZTHPDaZp5raQ1nkC6YWi42rd+0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-b-2MMO6uNYWeFOwxk8YKnQ-1; Thu, 26 Nov 2020 04:26:48 -0500
X-MC-Unique: b-2MMO6uNYWeFOwxk8YKnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26628185E48E;
 Thu, 26 Nov 2020 09:26:47 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4180F19C71;
 Thu, 26 Nov 2020 09:26:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 13/14] virtio_vdpa: don't warn when fail to disable vq
Date: Thu, 26 Nov 2020 17:26:03 +0800
Message-Id: <20201126092604.208033-14-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

There's no guarantee that the device can disable a specific virtqueue
through set_vq_ready(). One example is the modern virtio-pci
device. So this patch removes the warning.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 4a9ddb44b2a7..e28acf482e0c 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -225,9 +225,8 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vd_dev->lock, flags);
 
-	/* Select and deactivate the queue */
+	/* Select and deactivate the queue (best effort) */
 	ops->set_vq_ready(vdpa, index, 0);
-	WARN_ON(ops->get_vq_ready(vdpa, index));
 
 	vring_del_virtqueue(vq);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
