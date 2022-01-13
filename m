Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 14:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0B7D401B0;
	Thu, 13 Jan 2022 14:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06A_tUlWnRhG; Thu, 13 Jan 2022 14:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 692BE401A3;
	Thu, 13 Jan 2022 14:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30627C002F;
	Thu, 13 Jan 2022 14:12:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55290C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 14:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EAC140158
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 14:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViT-UBPD8dn9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 14:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FC7E40022
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642083117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xCYpNTbO554QGVwnOrW/uIVMk9yK3DSR4H4rxcM8uH8=;
 b=JoIAj2eEpUDvlCpJXrUA40MeQEj60vTHcbGC1UlHvjWUKhC2NDk0OrIkc+RbISMEZMpl9Y
 +NIJazr8J4HdER1Kshg90fjGJd6qksb4etfDeoCnzRuvg33LAulonU1ANXBz1DS0eGAprE
 h4duDwY2Tqm9y2qTP+kwmDChK56aR88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-fm-pjm88NTydB7XZ6ad7Jw-1; Thu, 13 Jan 2022 09:11:56 -0500
X-MC-Unique: fm-pjm88NTydB7XZ6ad7Jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 504A581EE64;
 Thu, 13 Jan 2022 14:11:55 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.64.242.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA7F92B5A5;
 Thu, 13 Jan 2022 14:11:37 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost: remove avail_event arg from vhost_update_avail_event()
Date: Thu, 13 Jan 2022 15:11:34 +0100
Message-Id: <20220113141134.186773-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

In vhost_update_avail_event() we never used the `avail_event` argument,
since its introduction in commit 2723feaa8ec6 ("vhost: set log when
updating used flags or avail event").

Let's remove it to clean up the code.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..ee171e663a18 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1981,7 +1981,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 	return 0;
 }
 
-static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
+static int vhost_update_avail_event(struct vhost_virtqueue *vq)
 {
 	if (vhost_put_avail_event(vq))
 		return -EFAULT;
@@ -2527,7 +2527,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 			return false;
 		}
 	} else {
-		r = vhost_update_avail_event(vq, vq->avail_idx);
+		r = vhost_update_avail_event(vq);
 		if (r) {
 			vq_err(vq, "Failed to update avail event index at %p: %d\n",
 			       vhost_avail_event(vq), r);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
