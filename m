Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964DC64DCF
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964DC64DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50D0F8495A;
	Tue, 16 Feb 2021 09:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ay382LWZi9wM; Tue, 16 Feb 2021 09:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E247884837;
	Tue, 16 Feb 2021 09:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC54EC0893;
	Tue, 16 Feb 2021 09:45:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FDAC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 456EC84917
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTBp1CFSIBRO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 72CF184947
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgJXmECmOauhfYDJPw4bn7OxQRQZ97Yc1PJaarzr/ps=;
 b=hoDqqolm4UfyS3nv8CooXswFswMsOF159g5b0hlFHIVXAiJE1vaf3Q+Tv8JxGhJ0dQAtiv
 6sDMdUGFEKKyM/yXoiJIbYpibTksZxyyIDnv1N/PAb02J+RKhrw449PyiPGDwlcDW7+8RV
 DlGtuEryGZen25NdIZFbyFbw5A82OuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-VmUvdcoDMjK1N8CpeqbGyA-1; Tue, 16 Feb 2021 04:45:11 -0500
X-MC-Unique: VmUvdcoDMjK1N8CpeqbGyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF698100AA21;
 Tue, 16 Feb 2021 09:45:09 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2F35D9C0;
 Tue, 16 Feb 2021 09:45:08 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 03/10] vdpa: add vdpa_set_config() helper
Date: Tue, 16 Feb 2021 10:44:47 +0100
Message-Id: <20210216094454.82106-4-sgarzare@redhat.com>
In-Reply-To: <20210216094454.82106-1-sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

Let's add a function similar to vpda_get_config() to check the
'offset' and 'len' parameters, call the set_config() device callback,
and return the amount of bytes written.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h |  2 ++
 drivers/vdpa/vdpa.c  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8a679c98f8b1..562fcd14f4b5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -334,6 +334,8 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 
 int vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 		    void *buf, unsigned int len);
+int vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
+		    const void *buf, unsigned int len);
 
 /**
  * vdpa_mgmtdev_ops - vdpa device ops
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9ed6c779c63c..825afc690a7e 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -86,6 +86,22 @@ int vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
+int vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
+		    const void *buf, unsigned int len)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+	int bytes_set;
+
+	bytes_set = vdpa_config_size_wrap(vdev, offset, len);
+	if (bytes_set <= 0)
+		return bytes_set;
+
+	ops->set_config(vdev, offset, buf, bytes_set);
+
+	return bytes_set;
+}
+EXPORT_SYMBOL_GPL(vdpa_set_config);
+
 static void vdpa_release_dev(struct device *d)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(d);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
