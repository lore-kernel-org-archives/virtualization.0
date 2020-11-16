Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC41C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:17:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B7222B9
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZFubFPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B7222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 393B28714E;
	Mon, 16 Nov 2020 16:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YS362qgL0hMI; Mon, 16 Nov 2020 16:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 987DA87052;
	Mon, 16 Nov 2020 16:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84BCEC0800;
	Mon, 16 Nov 2020 16:17:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60BFCC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4B9B32050C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dnkfDPQX5CjQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 80EFD20447
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605543424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qiy7dPJkCedncPHfKBWxJXduYz70r7PiHicBol/8nJM=;
 b=WZFubFPekZzUGU9ohbLAC0OBXfYL1CAv8IIY2KAj8cksLL6ra4l5FSD2UXUWfim4ViFDIV
 NylBtwMosh3Uojle/AF8SXXZehciGs44510quboY3QaEUQwGivEJwXQ9VBVUxJjfSrCNPC
 enqLO49AQ48mBkOUaovkgNXUHS5vHxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-8l_JSKdHMz-YnAKe83Dk9A-1; Mon, 16 Nov 2020 11:17:00 -0500
X-MC-Unique: 8l_JSKdHMz-YnAKe83Dk9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C151868425;
 Mon, 16 Nov 2020 16:16:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E97255C5B0;
 Mon, 16 Nov 2020 16:16:54 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com
Subject: [PATCH] vringh: fix vringh_iov_push_*() documentation
Date: Mon, 16 Nov 2020 17:16:53 +0100
Message-Id: <20201116161653.102904-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

vringh_iov_push_*() functions don't have 'dst' parameter, but have
the 'src' parameter.

Replace 'dst' description with 'src' description.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 8bd8b403f087..b7403ba8e7f7 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -730,7 +730,7 @@ EXPORT_SYMBOL(vringh_iov_pull_user);
 /**
  * vringh_iov_push_user - copy bytes into vring_iov.
  * @wiov: the wiov as passed to vringh_getdesc_user() (updated as we consume)
- * @dst: the place to copy.
+ * @src: the place to copy from.
  * @len: the maximum length to copy.
  *
  * Returns the bytes copied <= len or a negative errno.
@@ -976,7 +976,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
 /**
  * vringh_iov_push_kern - copy bytes into vring_iov.
  * @wiov: the wiov as passed to vringh_getdesc_kern() (updated as we consume)
- * @dst: the place to copy.
+ * @src: the place to copy from.
  * @len: the maximum length to copy.
  *
  * Returns the bytes copied <= len or a negative errno.
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL(vringh_iov_pull_iotlb);
  * vringh_iov_push_iotlb - copy bytes into vring_iov.
  * @vrh: the vring.
  * @wiov: the wiov as passed to vringh_getdesc_iotlb() (updated as we consume)
- * @dst: the place to copy.
+ * @src: the place to copy from.
  * @len: the maximum length to copy.
  *
  * Returns the bytes copied <= len or a negative errno.
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
