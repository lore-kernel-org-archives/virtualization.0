Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC39C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:23:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D8E64F65
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D8E64F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDAA68722F;
	Thu,  4 Feb 2021 17:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xADcEgorybIa; Thu,  4 Feb 2021 17:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D60B08722C;
	Thu,  4 Feb 2021 17:23:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB169C1DA0;
	Thu,  4 Feb 2021 17:23:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE93FC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A66E85B9D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfosvvdwlQ12
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 07D4086D26
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612459400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6wh1LMLhZTu6Il2A+W8xiD5xAyI/ci9mY9NolndzMM=;
 b=IkJVTg2b9Ba3hVbSIq5yvsmv6tIox2ai5btSOGFXokkjJwbA90+/fjCg3sYqxx7Bi7Lir2
 uZoOla2ohyFK5oicqQvw/8mzhVe0vyio1z0LUJk/9cKVOLDk2tIbTEIZEgkOgaGudbiOkX
 S+raRPF8B2erzEFlEH/4LpsMckViS+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-8SAnTcfHMPiFLLJRk6Pj2A-1; Thu, 04 Feb 2021 12:23:18 -0500
X-MC-Unique: 8SAnTcfHMPiFLLJRk6Pj2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00370801965;
 Thu,  4 Feb 2021 17:23:17 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-213.ams2.redhat.com
 [10.36.113.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F95060937;
 Thu,  4 Feb 2021 17:23:08 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 04/13] vringh: explain more about cleaning riov and wiov
Date: Thu,  4 Feb 2021 18:22:21 +0100
Message-Id: <20210204172230.85853-5-sgarzare@redhat.com>
In-Reply-To: <20210204172230.85853-1-sgarzare@redhat.com>
References: <20210204172230.85853-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

riov and wiov can be reused with subsequent calls of vringh_getdesc_*().

Let's add a paragraph in the documentation of these functions to better
explain when riov and wiov need to be cleaned up.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index bee63d68201a..2a88e087afd8 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -662,7 +662,10 @@ EXPORT_SYMBOL(vringh_init_user);
  * *head will be vrh->vring.num.  You may be able to ignore an invalid
  * descriptor, but there's not much you can do with an invalid ring.
  *
- * Note that you may need to clean up riov and wiov, even on error!
+ * Note that you can reuse riov and wiov with subsequent calls. Content is
+ * overwritten and memory reallocated if more space is needed.
+ * When you don't have to use riov and wiov anymore, you should clean up them
+ * calling vringh_iov_cleanup() to release the memory, even on error!
  */
 int vringh_getdesc_user(struct vringh *vrh,
 			struct vringh_iov *riov,
@@ -932,7 +935,10 @@ EXPORT_SYMBOL(vringh_init_kern);
  * *head will be vrh->vring.num.  You may be able to ignore an invalid
  * descriptor, but there's not much you can do with an invalid ring.
  *
- * Note that you may need to clean up riov and wiov, even on error!
+ * Note that you can reuse riov and wiov with subsequent calls. Content is
+ * overwritten and memory reallocated if more space is needed.
+ * When you don't have to use riov and wiov anymore, you should clean up them
+ * calling vringh_kiov_cleanup() to release the memory, even on error!
  */
 int vringh_getdesc_kern(struct vringh *vrh,
 			struct vringh_kiov *riov,
@@ -1292,7 +1298,10 @@ EXPORT_SYMBOL(vringh_set_iotlb);
  * *head will be vrh->vring.num.  You may be able to ignore an invalid
  * descriptor, but there's not much you can do with an invalid ring.
  *
- * Note that you may need to clean up riov and wiov, even on error!
+ * Note that you can reuse riov and wiov with subsequent calls. Content is
+ * overwritten and memory reallocated if more space is needed.
+ * When you don't have to use riov and wiov anymore, you should clean up them
+ * calling vringh_kiov_cleanup() to release the memory, even on error!
  */
 int vringh_getdesc_iotlb(struct vringh *vrh,
 			 struct vringh_kiov *riov,
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
