Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957CC432C3
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:35:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B245564F34
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 16:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B245564F34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D1E5430C4;
	Mon, 15 Mar 2021 16:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tlg10Dungvq; Mon, 15 Mar 2021 16:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2989C43105;
	Mon, 15 Mar 2021 16:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13AA8C000B;
	Mon, 15 Mar 2021 16:35:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68A3CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44D9E4312F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59TKxHrMGWSH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 937D74310D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615826143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAqe4QGyCpp3qkhZfpBh66Chsnfm4h8juLPuFY2EjWo=;
 b=OJm9OFMytm6+gkEiWax+4RJuznyv6M12eHd1f17sm2xlcrgydG5A49UkRFEksnlZIN2vFC
 sK94EjjDCRhKRzDvv29nBx1BhtVdJPlczBhC8QkVGan72SWTzBBmb+kkCVCeifR5LKZCHD
 W6bJshc9bUgufJxQ629eZYBXJGC7GFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-4-uIdZmYPZaQEFISoNoU9g-1; Mon, 15 Mar 2021 12:35:41 -0400
X-MC-Unique: 4-uIdZmYPZaQEFISoNoU9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5EF801817;
 Mon, 15 Mar 2021 16:35:40 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F00CA2C169;
 Mon, 15 Mar 2021 16:35:37 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 05/14] vringh: implement vringh_kiov_advance()
Date: Mon, 15 Mar 2021 17:34:41 +0100
Message-Id: <20210315163450.254396-6-sgarzare@redhat.com>
In-Reply-To: <20210315163450.254396-1-sgarzare@redhat.com>
References: <20210315163450.254396-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

In some cases, it may be useful to provide a way to skip a number
of bytes in a vringh_kiov.

Let's implement vringh_kiov_advance() for this purpose, reusing the
code from vringh_iov_xfer().
We replace that code calling the new vringh_kiov_advance().

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vringh.h |  2 ++
 drivers/vhost/vringh.c | 41 +++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 9c077863c8f6..755211ebd195 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -199,6 +199,8 @@ static inline void vringh_kiov_cleanup(struct vringh_kiov *kiov)
 	kiov->iov = NULL;
 }
 
+void vringh_kiov_advance(struct vringh_kiov *kiov, size_t len);
+
 int vringh_getdesc_kern(struct vringh *vrh,
 			struct vringh_kiov *riov,
 			struct vringh_kiov *wiov,
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 2a88e087afd8..4af8fa259d65 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -75,6 +75,34 @@ static inline int __vringh_get_head(const struct vringh *vrh,
 	return head;
 }
 
+/**
+ * vringh_kiov_advance - skip bytes from vring_kiov
+ * @iov: an iov passed to vringh_getdesc_*() (updated as we consume)
+ * @len: the maximum length to advance
+ */
+void vringh_kiov_advance(struct vringh_kiov *iov, size_t len)
+{
+	while (len && iov->i < iov->used) {
+		size_t partlen = min(iov->iov[iov->i].iov_len, len);
+
+		iov->consumed += partlen;
+		iov->iov[iov->i].iov_len -= partlen;
+		iov->iov[iov->i].iov_base += partlen;
+
+		if (!iov->iov[iov->i].iov_len) {
+			/* Fix up old iov element then increment. */
+			iov->iov[iov->i].iov_len = iov->consumed;
+			iov->iov[iov->i].iov_base -= iov->consumed;
+
+			iov->consumed = 0;
+			iov->i++;
+		}
+
+		len -= partlen;
+	}
+}
+EXPORT_SYMBOL(vringh_kiov_advance);
+
 /* Copy some bytes to/from the iovec.  Returns num copied. */
 static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 				      struct vringh_kiov *iov,
@@ -95,19 +123,8 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 		done += partlen;
 		len -= partlen;
 		ptr += partlen;
-		iov->consumed += partlen;
-		iov->iov[iov->i].iov_len -= partlen;
-		iov->iov[iov->i].iov_base += partlen;
 
-		if (!iov->iov[iov->i].iov_len) {
-			/* Fix up old iov element then increment. */
-			iov->iov[iov->i].iov_len = iov->consumed;
-			iov->iov[iov->i].iov_base -= iov->consumed;
-
-			
-			iov->consumed = 0;
-			iov->i++;
-		}
+		vringh_kiov_advance(iov, partlen);
 	}
 	return done;
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
