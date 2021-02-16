Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1992C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6214164DA1
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6214164DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45813847E5;
	Tue, 16 Feb 2021 09:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ely6LRfyOM-E; Tue, 16 Feb 2021 09:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C600884947;
	Tue, 16 Feb 2021 09:45:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A114AC1E6F;
	Tue, 16 Feb 2021 09:45:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67C80C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54C9E6F48C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1Og-GW7OQFS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:44 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 909296F508; Tue, 16 Feb 2021 09:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52F0C6F4E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epeDldi/RqZNzvZCpZ/Dw6am7oNc4937HhZPeBnWnoI=;
 b=HhU3+wAuHs1jrS1bBj9JWlcbXnTp/uB6yYqaPnh1tdIIyyIseFezVRirZ5cjNxWk3e71Ry
 3SisRPKdoTe/qS2oOhxvdiw1TOAwfa2TFMfhuAbNGru18D01Zkk0a5xCvP6SWeTorSJ1QU
 GHDl+3hYu/giVtVe9nfE/YfMjCUj4H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-YetAxVWXOEmKjMEu6GCXKw-1; Tue, 16 Feb 2021 04:45:38 -0500
X-MC-Unique: YetAxVWXOEmKjMEu6GCXKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65573100A689;
 Tue, 16 Feb 2021 09:45:37 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 109B216D5E;
 Tue, 16 Feb 2021 09:45:35 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 05/10] vdpa: remove WARN_ON() in the get/set_config
 callbacks
Date: Tue, 16 Feb 2021 10:44:49 +0100
Message-Id: <20210216094454.82106-6-sgarzare@redhat.com>
In-Reply-To: <20210216094454.82106-1-sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

vdpa_get_config() and vdpa_set_config() now check parameters before
calling callbacks, so we can remove these warnings.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Maybe we can skip this patch and leave the WARN_ONs in place.
What do you recommend?
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 3 +--
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index f2a128e56de5..5941ecf934d0 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -222,7 +222,6 @@ void ifcvf_read_net_config(struct ifcvf_hw *hw, u64 offset,
 	u8 old_gen, new_gen, *p;
 	int i;
 
-	WARN_ON(offset + length > sizeof(struct virtio_net_config));
 	do {
 		old_gen = ifc_ioread8(&hw->common_cfg->config_generation);
 		p = dst;
@@ -240,7 +239,7 @@ void ifcvf_write_net_config(struct ifcvf_hw *hw, u64 offset,
 	int i;
 
 	p = src;
-	WARN_ON(offset + length > sizeof(struct virtio_net_config));
+
 	for (i = 0; i < length; i++)
 		ifc_iowrite8(*p++, hw->net_cfg + offset + i);
 }
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 2443271e17d2..e55f88c57461 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -343,7 +343,6 @@ static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	WARN_ON(offset + len > sizeof(struct virtio_net_config));
 	ifcvf_read_net_config(vf, offset, buf, len);
 }
 
@@ -353,7 +352,6 @@ static void ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	WARN_ON(offset + len > sizeof(struct virtio_net_config));
 	ifcvf_write_net_config(vf, offset, buf, len);
 }
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
