Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F62C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:46:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0264DC3
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0264DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06C5984947;
	Tue, 16 Feb 2021 09:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0snTmvjaIB8; Tue, 16 Feb 2021 09:46:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87587847F9;
	Tue, 16 Feb 2021 09:46:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67D25C0FA7;
	Tue, 16 Feb 2021 09:46:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93AAEC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 81913865A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 95yiKEEexOOC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C894F8657C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUO68bTCohFMIGXH82qxXbnohw7EihHHCgax44jVeHQ=;
 b=UGTCWAOdCASy7kcYfitLSId9c5N/WMZ4H+jA16u8ifQZD2qlP2aufZWAdL5zXnw3cbzAIS
 YawTeCp98zDardMACJp9SlbDM1CgzBaLPLrM9+Yy9jDOKtL456fBYS+ntjvonPMko3JKig
 JNwn2/Z6F9GI1QLzHkTNc9WdCVinJDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-nkQI-Q60Pt-r3dfjPIQN8w-1; Tue, 16 Feb 2021 04:46:10 -0500
X-MC-Unique: nkQI-Q60Pt-r3dfjPIQN8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76CD7107ACC7;
 Tue, 16 Feb 2021 09:46:09 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED4215C6AB;
 Tue, 16 Feb 2021 09:46:03 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 08/10] vhost/vdpa: allow user space to pass buffers bigger
 than config space
Date: Tue, 16 Feb 2021 10:44:52 +0100
Message-Id: <20210216094454.82106-9-sgarzare@redhat.com>
In-Reply-To: <20210216094454.82106-1-sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

vdpa_get_config() and vdpa_set_config() now are able to read/write
only the bytes available in the device configuration space, also if
the buffer provided is bigger than that.

Let's use this feature to allow the user space application to pass any
buffer. We limit the size of the internal bounce buffer allocated with
the device config size.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index cdd8f24168b2..544f8582a42b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -185,10 +185,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	return 0;
 }
 
-static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
-				      struct vhost_vdpa_config *c)
+static ssize_t vhost_vdpa_config_validate(struct vhost_vdpa *v,
+					  struct vhost_vdpa_config *c)
 {
-	long size = 0;
+	u32 size = 0;
 
 	switch (v->virtio_id) {
 	case VIRTIO_ID_NET:
@@ -199,10 +199,7 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
 	if (c->len == 0)
 		return -EINVAL;
 
-	if (c->len > size - c->off)
-		return -E2BIG;
-
-	return 0;
+	return min(c->len, size);
 }
 
 static long vhost_vdpa_get_config(struct vhost_vdpa *v,
@@ -211,19 +208,23 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	struct vdpa_device *vdpa = v->vdpa;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
+	ssize_t config_size;
 	u8 *buf;
 
 	if (copy_from_user(&config, c, size))
 		return -EFAULT;
-	if (vhost_vdpa_config_validate(v, &config))
-		return -EINVAL;
-	buf = kvzalloc(config.len, GFP_KERNEL);
+
+	config_size = vhost_vdpa_config_validate(v, &config);
+	if (config_size <= 0)
+		return config_size;
+
+	buf = kvzalloc(config_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	vdpa_get_config(vdpa, config.off, buf, config.len);
+	vdpa_get_config(vdpa, config.off, buf, config_size);
 
-	if (copy_to_user(c->buf, buf, config.len)) {
+	if (copy_to_user(c->buf, buf, config_size)) {
 		kvfree(buf);
 		return -EFAULT;
 	}
@@ -238,18 +239,21 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	struct vdpa_device *vdpa = v->vdpa;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
+	ssize_t config_size;
 	u8 *buf;
 
 	if (copy_from_user(&config, c, size))
 		return -EFAULT;
-	if (vhost_vdpa_config_validate(v, &config))
-		return -EINVAL;
 
-	buf = vmemdup_user(c->buf, config.len);
+	config_size = vhost_vdpa_config_validate(v, &config);
+	if (config_size <= 0)
+		return config_size;
+
+	buf = vmemdup_user(c->buf, config_size);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	vdpa_set_config(vdpa, config.off, buf, config.len);
+	vdpa_set_config(vdpa, config.off, buf, config_size);
 
 	kvfree(buf);
 	return 0;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
