Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDCAC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB9523370
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB9523370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB20486735;
	Wed, 16 Dec 2020 06:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkiSI-9PwK9c; Wed, 16 Dec 2020 06:49:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6317A865AB;
	Wed, 16 Dec 2020 06:49:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE1DC0893;
	Wed, 16 Dec 2020 06:49:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAC3C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A26F86735
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JI1hwFYll4N5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 456E9865AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJzPHH5JPi1UiRGkNHp91R5FaQjKQU30q1zC8IFdmyE=;
 b=ZotAs/6O5Cux5FOJSdhYtUq6pHYaQ6fktT7k6dX9cuP2PCXJdhqGKmM8DiDbYyoAwwIHtm
 XAPFEiGKqFFtxHD8hWJFNXpuVwByMTnKogK1FikkBF7Joakb4QRSF8jzwrTOGJhhqzFsI1
 4OrhHm27AffbZErZhkdmWu2s/r/XIq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248--8dEB7jeNNyX4sPdLcYrxQ-1; Wed, 16 Dec 2020 01:49:32 -0500
X-MC-Unique: -8dEB7jeNNyX4sPdLcYrxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E9C180A096;
 Wed, 16 Dec 2020 06:49:31 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4C8710013C1;
 Wed, 16 Dec 2020 06:49:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 09/21] vhost_iotlb: split out IOTLB initialization
Date: Wed, 16 Dec 2020 14:48:06 +0800
Message-Id: <20201216064818.48239-10-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patch splits out IOTLB initialization to make sure it could be
reused by external modules.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/iotlb.c       | 23 ++++++++++++++++++-----
 include/linux/vhost_iotlb.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..e842d76c179e 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -98,6 +98,23 @@ void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last)
 }
 EXPORT_SYMBOL_GPL(vhost_iotlb_del_range);
 
+/**
+ * vhost_iotlb_init - initialize a vhost IOTLB
+ * @iotlb: the IOTLB that needs to be initialized
+ * @limit: maximum number of IOTLB entries
+ * @flags: VHOST_IOTLB_FLAG_XXX
+ */
+void vhost_iotlb_init(struct vhost_iotlb *iotlb, unsigned int limit,
+		      unsigned int flags)
+{
+	iotlb->root = RB_ROOT_CACHED;
+	iotlb->limit = limit;
+	iotlb->nmaps = 0;
+	iotlb->flags = flags;
+	INIT_LIST_HEAD(&iotlb->list);
+}
+EXPORT_SYMBOL_GPL(vhost_iotlb_init);
+
 /**
  * vhost_iotlb_alloc - add a new vhost IOTLB
  * @limit: maximum number of IOTLB entries
@@ -112,11 +129,7 @@ struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags)
 	if (!iotlb)
 		return NULL;
 
-	iotlb->root = RB_ROOT_CACHED;
-	iotlb->limit = limit;
-	iotlb->nmaps = 0;
-	iotlb->flags = flags;
-	INIT_LIST_HEAD(&iotlb->list);
+	vhost_iotlb_init(iotlb, limit, flags);
 
 	return iotlb;
 }
diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..c0df193ec3e1 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -33,6 +33,8 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb, u64 start, u64 last,
 			  u64 addr, unsigned int perm);
 void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last);
 
+void vhost_iotlb_init(struct vhost_iotlb *iotlb, unsigned int limit,
+		      unsigned int flags);
 struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags);
 void vhost_iotlb_free(struct vhost_iotlb *iotlb);
 void vhost_iotlb_reset(struct vhost_iotlb *iotlb);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
