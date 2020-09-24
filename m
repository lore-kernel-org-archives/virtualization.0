Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81BDC4346E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:24:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6970723600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dY+ZCkYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6970723600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2726E86AD7;
	Thu, 24 Sep 2020 03:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id if9QT2JrhF7Q; Thu, 24 Sep 2020 03:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 930DE86710;
	Thu, 24 Sep 2020 03:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D89CC0889;
	Thu, 24 Sep 2020 03:24:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F208C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 872162DE2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yoyQsvLJNqW6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AC8912DE25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfueecD2nn0g5NX57haltefO9h8rHly/lmEeHDzFMsw=;
 b=dY+ZCkYiepSTJxvesj9t5EzbdlmgRBal4Ig3yxiX2k1ZYHNcdj4ksZ4CWGiyEHIKov5me2
 l6t/8Mh6Jyb8w8sYuleOcy1nLZxiu7u2t8VjaiMUTvic6kGFqGinYWY7YVgLctz4qvYSbD
 MZD+poUAC9kfoUj1cfqh3pBpyq+8+3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-wvmr4WtwMBW74W3C2qdSmg-1; Wed, 23 Sep 2020 23:24:47 -0400
X-MC-Unique: wvmr4WtwMBW74W3C2qdSmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C719106B3A1;
 Thu, 24 Sep 2020 03:24:46 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8578055777;
 Thu, 24 Sep 2020 03:24:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 16/24] vhost-vdpa: uAPI to get virtqueue group id
Date: Thu, 24 Sep 2020 11:21:17 +0800
Message-Id: <20200924032125.18619-17-jasowang@redhat.com>
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

Follows the support for virtqueue group in vDPA. This patches
introduces uAPI to get the virtqueue group ID for a specific virtqueue
in vhost-vdpa.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c       | 8 ++++++++
 include/uapi/linux/vhost.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 4d97a59824a1..a234d3783e16 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -433,6 +433,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			return -EFAULT;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
+	case VHOST_VDPA_GET_VRING_GROUP:
+		s.index = idx;
+		s.num = ops->get_vq_group(vdpa, idx);
+		if (s.num >= vdpa->ngroups)
+			return -EIO;
+		else if (copy_to_user(argp, &s, sizeof s))
+			return -EFAULT;
+		return 0;
 	case VHOST_GET_VRING_BASE:
 		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
 		if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 99bdf50efc50..d1c4b5561fee 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -147,4 +147,8 @@
 
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x79, unsigned int)
+
+/* Get the group for a virtqueue: read index, write group in num */
+#define VHOST_VDPA_GET_VRING_GROUP	_IOWR(VHOST_VIRTIO, 0x79,	\
+					      struct vhost_vring_state)
 #endif
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
