Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C921C433E6
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:46:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3610364DA1
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3610364DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 038DF867C9;
	Tue, 16 Feb 2021 09:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tV-IQKUYvCyB; Tue, 16 Feb 2021 09:46:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D0D1867A3;
	Tue, 16 Feb 2021 09:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5FA9C1DA9;
	Tue, 16 Feb 2021 09:46:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49C9BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2E2B78670A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3j2MfkSz-uu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5888F86741
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqmUyCUnnwzMfzlfbC6vrvnV937tFThxMW/Rg8TVcvM=;
 b=Cz1gE34Ubg6zUA2ODCgpI4qgUdgWoCqE5N2yl5637S6YRDXKHaaDyqffyhpgjTZa8bRtKf
 dDxxRj1yI0eYVMcHF9hqQLuHrlQ04bKMa/1x1fZi4NE+xNl8nhE7yMXInrFqy3WiwlQfRT
 5dxE9Zn619WxsnwxTHYVAOVhhOVGfeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-EoGMOIL1PqOL3nSI57bJzQ-1; Tue, 16 Feb 2021 04:46:14 -0500
X-MC-Unique: EoGMOIL1PqOL3nSI57bJzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDC2B18A08BD;
 Tue, 16 Feb 2021 09:46:12 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81BDA63747;
 Tue, 16 Feb 2021 09:46:11 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read and
 written to user space
Date: Tue, 16 Feb 2021 10:44:54 +0100
Message-Id: <20210216094454.82106-11-sgarzare@redhat.com>
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

vdpa_get_config() and vdpa_set_config() now return the amount
of bytes read and written, so let's return them to the user space.

We also modify vhost_vdpa_config_validate() to return 0 (bytes read
or written) instead of an error, when the buffer length is 0.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 21eea2be5afa..b754c53171a7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -191,9 +191,6 @@ static ssize_t vhost_vdpa_config_validate(struct vhost_vdpa *v,
 	struct vdpa_device *vdpa = v->vdpa;
 	u32 size = vdpa->config->get_config_size(vdpa);
 
-	if (c->len == 0)
-		return -EINVAL;
-
 	return min(c->len, size);
 }
 
@@ -204,6 +201,7 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	ssize_t config_size;
+	long ret;
 	u8 *buf;
 
 	if (copy_from_user(&config, c, size))
@@ -217,15 +215,18 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	if (!buf)
 		return -ENOMEM;
 
-	vdpa_get_config(vdpa, config.off, buf, config_size);
-
-	if (copy_to_user(c->buf, buf, config_size)) {
-		kvfree(buf);
-		return -EFAULT;
+	ret = vdpa_get_config(vdpa, config.off, buf, config_size);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto out;
 	}
 
+	if (copy_to_user(c->buf, buf, config_size))
+		ret = -EFAULT;
+
+out:
 	kvfree(buf);
-	return 0;
+	return ret;
 }
 
 static long vhost_vdpa_set_config(struct vhost_vdpa *v,
@@ -235,6 +236,7 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	ssize_t config_size;
+	long ret;
 	u8 *buf;
 
 	if (copy_from_user(&config, c, size))
@@ -248,10 +250,12 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	vdpa_set_config(vdpa, config.off, buf, config_size);
+	ret = vdpa_set_config(vdpa, config.off, buf, config_size);
+	if (ret < 0)
+		ret = -EFAULT;
 
 	kvfree(buf);
-	return 0;
+	return ret;
 }
 
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
