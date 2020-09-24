Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AAC4727D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:22:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6735223600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqNhDPH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6735223600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 13FB32DE24;
	Thu, 24 Sep 2020 03:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TODzLivLmOtr; Thu, 24 Sep 2020 03:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5739B22D24;
	Thu, 24 Sep 2020 03:22:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35516C0889;
	Thu, 24 Sep 2020 03:22:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8193C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B3EDB86AC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFmZP6KrsZMq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1D67786AC4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=257+bopw92IH4lZUaMeS+qFgZVg0lxCZVzMn3r9TfiQ=;
 b=gqNhDPH4tIvd4kTMKmXbt1jr4BvXgitYEXddJh4CwJF3va21MPo4uvFAxC+G8v8/fDcIsj
 X9xkO8grgC/Hill+4kt6IHwwnjNv7bghSPqeMvBoArSMd1NGXa+pUDRlM4vNJAvfBumZRd
 /jLKINxXESlUSiQ13S82gbImV0oVUC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-jfZrj1e2NzeZh3mlnXquqg-1; Wed, 23 Sep 2020 23:22:14 -0400
X-MC-Unique: jfZrj1e2NzeZh3mlnXquqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CEBB186DD32;
 Thu, 24 Sep 2020 03:22:12 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A837055768;
 Thu, 24 Sep 2020 03:22:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 03/24] vhost: move the backend feature bits to
 vhost_types.h
Date: Thu, 24 Sep 2020 11:21:04 +0800
Message-Id: <20200924032125.18619-4-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

We should store feature bits in vhost_types.h as what has been done
for e.g VHOST_F_LOG_ALL.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/uapi/linux/vhost.h       | 5 -----
 include/uapi/linux/vhost_types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 75232185324a..c26452782882 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -89,11 +89,6 @@
 
 /* Set or get vhost backend capability */
 
-/* Use message type V2 */
-#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
-/* IOTLB can accept batching hints */
-#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
-
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9a269a88a6ff..532571571b4b 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -144,4 +144,9 @@ struct vhost_vdpa_config {
 /* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
 #define VHOST_NET_F_VIRTIO_NET_HDR 27
 
+/* Use message type V2 */
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+/* IOTLB can accept batching hints */
+#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
+
 #endif
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
