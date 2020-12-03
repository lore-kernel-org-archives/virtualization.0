Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BDC4361A
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:06:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DFD207AE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DFD207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A72FE86F89;
	Thu,  3 Dec 2020 17:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U8r71iAw6JRq; Thu,  3 Dec 2020 17:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45DFA86F9C;
	Thu,  3 Dec 2020 17:06:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11770C163C;
	Thu,  3 Dec 2020 17:06:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68569C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 46DCA2048A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRds7zbTr6Sn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4D2BB20477
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607015157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwRJrUBTPsHO6CS9p2N6npskY2prbgJKju6rYBszPUY=;
 b=EUb8N45XJvuaIDuqap4abQi9dNt0i+l6K1giDMkC4NWPzSoiJ8s1dkH9InPmMrAlumpVMM
 YClKWdwpaFY+Z6gTfswhZHSO9eqXk0qDvo2DvvNGzwfimv0hla4usnDhAfd22LBeApCKxZ
 3COi6wRxC8Yjv98XN3lV3f9M28QDGyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-AenLv00DOHOZc5Kke33WtA-1; Thu, 03 Dec 2020 12:05:55 -0500
X-MC-Unique: AenLv00DOHOZc5Kke33WtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137711922043;
 Thu,  3 Dec 2020 17:05:54 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com
 [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ED8160C15;
 Thu,  3 Dec 2020 17:05:44 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 04/19] vhost/iotlb: add VHOST_IOTLB_UNLIMITED macro
Date: Thu,  3 Dec 2020 18:04:56 +0100
Message-Id: <20201203170511.216407-5-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

It's possible to allocate an unlimited IOTLB calling
vhost_iotlb_alloc() with 'limit' = 0.

Add a new macro (VHOST_IOTLB_UNLIMITED) for this case and document
it in the vhost_iotlb_alloc() documentation block.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vhost_iotlb.h | 2 ++
 drivers/vhost/iotlb.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..47019f97f795 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -4,6 +4,8 @@
 
 #include <linux/interval_tree_generic.h>
 
+#define VHOST_IOTLB_UNLIMITED 0
+
 struct vhost_iotlb_map {
 	struct rb_node rb;
 	struct list_head link;
diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..80fdde78ee5a 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -100,7 +100,8 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_del_range);
 
 /**
  * vhost_iotlb_alloc - add a new vhost IOTLB
- * @limit: maximum number of IOTLB entries
+ * @limit: maximum number of IOTLB entries (use VHOST_IOTLB_UNLIMITED for an
+ *         unlimited IOTLB)
  * @flags: VHOST_IOTLB_FLAG_XXX
  *
  * Returns an error is memory allocation fails
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
