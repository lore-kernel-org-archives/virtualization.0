Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74544C4727E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:25:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0146D2388A
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnBJLEdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146D2388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B078E2DF03;
	Thu, 24 Sep 2020 03:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMcHjbO-ouNn; Thu, 24 Sep 2020 03:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D0C932DE25;
	Thu, 24 Sep 2020 03:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA436C0889;
	Thu, 24 Sep 2020 03:25:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF62C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A79092DE2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1OOUrylw9Ysk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id CF5BA2DE25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0f6y23j1rs6f2A5XlpC2214Hgw54YVYejH44+4fkrGA=;
 b=YnBJLEdhr7EEL5FaXKwPJZOAzHsWyt+1US1MKj50n2an0mf7PIOKzrBLUjNbcp3P8dN4dK
 k6bcik27ypAceqfcjg/LYtcaUa6MAKNiP+Gcn4RfN7Bl+i1SDsOYAkqppn6ABYb9JghPuC
 1+uiEAuMg3zWVF3iqzTHe1taZy7TCgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-9aoU-TjvMwKAW-cu8oHKZw-1; Wed, 23 Sep 2020 23:24:58 -0400
X-MC-Unique: 9aoU-TjvMwKAW-cu8oHKZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A119A1891E94;
 Thu, 24 Sep 2020 03:24:55 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC7273782;
 Thu, 24 Sep 2020 03:24:46 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 17/24] vhost-vdpa: introduce uAPI to set group ASID
Date: Thu, 24 Sep 2020 11:21:18 +0800
Message-Id: <20200924032125.18619-18-jasowang@redhat.com>
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

Follows the vDPA support for associating ASID to a specific virtqueue
group. This patch adds a uAPI to support setting them from userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c       | 8 ++++++++
 include/uapi/linux/vhost.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a234d3783e16..978cf97dc03a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -441,6 +441,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		else if (copy_to_user(argp, &s, sizeof s))
 			return -EFAULT;
 		return 0;
+	case VHOST_VDPA_SET_GROUP_ASID:
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num >= vdpa->ngroups)
+			return -EINVAL;
+		if (!ops->set_group_asid)
+			return -ENOTSUPP;
+		return ops->set_group_asid(vdpa, idx, s.num);
 	case VHOST_GET_VRING_BASE:
 		r = ops->get_vq_state(v->vdpa, idx, &vq_state);
 		if (r)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index d1c4b5561fee..f3de9e45c518 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -151,4 +151,8 @@
 /* Get the group for a virtqueue: read index, write group in num */
 #define VHOST_VDPA_GET_VRING_GROUP	_IOWR(VHOST_VIRTIO, 0x79,	\
 					      struct vhost_vring_state)
+/* Set the ASID for a virtqueue group. */
+#define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7A, \
+					     struct vhost_vring_state)
+
 #endif
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
