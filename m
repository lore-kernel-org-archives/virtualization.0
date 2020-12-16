Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF3C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F3223370
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F3223370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E1B2286A7F;
	Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqlS2LJJfUcv; Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64CE786992;
	Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8EEC1834;
	Wed, 16 Dec 2020 06:50:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65166C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 497E186992
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTmgWCEKjWBd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B5F1B868A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud1BRTlDN9Yar1phOrzbLXk+yM0y16WYExtxoPN9XtA=;
 b=DdCGpMc8T8OG3uyHEoBAxgoFSkP4VyHsUzALINTUwOGLMQMDBg7Ucl1JyUQzyK3ixjE0bX
 +x48W9wPfJoSmpgUT9UWWY5WlzLDZD5X8HMay6oEd0FDpvGNet5Hi+c3hyuo5xnJzzraWx
 DvZo+Se3KFLFD68Je8zG+65chOTr3Dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-zsuXpva3MTSPUUUTGUChBg-1; Wed, 16 Dec 2020 01:50:19 -0500
X-MC-Unique: zsuXpva3MTSPUUUTGUChBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EC2800D55;
 Wed, 16 Dec 2020 06:50:18 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E613610016FF;
 Wed, 16 Dec 2020 06:50:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 15/21] vhost-vdpa: introduce uAPI to set group ASID
Date: Wed, 16 Dec 2020 14:48:12 +0800
Message-Id: <20201216064818.48239-16-jasowang@redhat.com>
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

Follows the vDPA support for associating ASID to a specific virtqueue
group. This patch adds a uAPI to support setting them from userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c       | 8 ++++++++
 include/uapi/linux/vhost.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e7023abda12c..cd7c9a401a61 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -450,6 +450,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		else if (copy_to_user(argp, &s, sizeof s))
 			return -EFAULT;
 		return 0;
+	case VHOST_VDPA_SET_GROUP_ASID:
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num >= vdpa->nas)
+			return -EINVAL;
+		if (!ops->set_group_asid)
+			return -ENOTSUPP;
+		return ops->set_group_asid(vdpa, idx, s.num);
 	case VHOST_GET_VRING_BASE:
 		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
 		if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 99de06476fdc..5e083490f1aa 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -158,4 +158,11 @@
  */
 #define VHOST_VDPA_GET_VRING_GROUP	_IOWR(VHOST_VIRTIO, 0x7B,	\
 					      struct vhost_vring_state)
+/* Set the ASID for a virtqueue group. The group index is stored in
+ * the index field of vhost_vring_state, the ASID associated with this
+ * group is stored at num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7C, \
+					     struct vhost_vring_state)
+
 #endif
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
