Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB54CC433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEF164DA1
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEF164DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 152DA867E0;
	Tue, 16 Feb 2021 09:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbQc6jYnTcrC; Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F6548670A;
	Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 955A4C0893;
	Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE174C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACD186F4E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRHhJk6VI4Yo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:13 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id C4BF66F4FD; Tue, 16 Feb 2021 09:45:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 590A46F4C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sL2HoPks3VzKpFvhRVHLVH8gFjTz1o9yXUZfovhuAAk=;
 b=Y5zJA/6rDQWhr4BXisMLPd2jpjD2IYFITtKPh3d51nVZzSWeJycfafMpeizyCovM9pDI/B
 /s93Zei59MjO23IEwLGMT6v/bLxtKMcQl0oDHupi+PQ/ljsFZo0amgf0eNJV9K4W3C0xZ6
 LCUTFmVHEkwKNLYKk/+/nLrFQ4pJpNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-lntx5zuyNCyODqqUmRpAag-1; Tue, 16 Feb 2021 04:45:09 -0500
X-MC-Unique: lntx5zuyNCyODqqUmRpAag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4367E801989;
 Tue, 16 Feb 2021 09:45:08 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBCD45D9C0;
 Tue, 16 Feb 2021 09:45:06 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 02/10] vdpa: check vdpa_get_config() parameters and return
 bytes read
Date: Tue, 16 Feb 2021 10:44:46 +0100
Message-Id: <20210216094454.82106-3-sgarzare@redhat.com>
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

Now we have the 'get_config_size()' callback available, so we can
check that 'offset' and 'len' parameters are valid.

When these exceed boundaries, we limit the reading to the available
configuration space in the device, and we return the amount of bytes
read.

We also move vdpa_get_config() implementation in drivers/vdpa/vdpa.c,
since the function are growing.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h | 16 ++--------------
 drivers/vdpa/vdpa.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index fddf42b17573..8a679c98f8b1 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -332,20 +332,8 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
         return ops->set_features(vdev, features);
 }
 
-
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
-				   void *buf, unsigned int len)
-{
-        const struct vdpa_config_ops *ops = vdev->config;
-
-	/*
-	 * Config accesses aren't supposed to trigger before features are set.
-	 * If it does happen we assume a legacy guest.
-	 */
-	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0);
-	ops->get_config(vdev, offset, buf, len);
-}
+int vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+		    void *buf, unsigned int len);
 
 /**
  * vdpa_mgmtdev_ops - vdpa device ops
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 3d997b389345..9ed6c779c63c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -51,6 +51,41 @@ static struct bus_type vdpa_bus = {
 	.remove = vdpa_dev_remove,
 };
 
+static int vdpa_config_size_wrap(struct vdpa_device *vdev, unsigned int offset,
+				 unsigned int len)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+	unsigned int config_size = ops->get_config_size(vdev);
+
+	if (offset > config_size || len > config_size)
+		return -1;
+
+	return min(len, config_size - offset);
+}
+
+int vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+		    void *buf, unsigned int len)
+{
+	const struct vdpa_config_ops *ops = vdev->config;
+	int bytes_get;
+
+	bytes_get = vdpa_config_size_wrap(vdev, offset, len);
+	if (bytes_get <= 0)
+		return bytes_get;
+
+	/*
+	 * Config accesses aren't supposed to trigger before features are set.
+	 * If it does happen we assume a legacy guest.
+	 */
+	if (!vdev->features_valid)
+		vdpa_set_features(vdev, 0);
+
+	ops->get_config(vdev, offset, buf, bytes_get);
+
+	return bytes_get;
+}
+EXPORT_SYMBOL_GPL(vdpa_get_config);
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
