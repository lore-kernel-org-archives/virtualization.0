Return-Path: <SRS0=tWAs=GS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03DCC433E0
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 00:35:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4464B23AA7
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 00:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4464B23AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E270186850;
	Fri, 15 Jan 2021 00:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJudaduDbDSU; Fri, 15 Jan 2021 00:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C59886980;
	Fri, 15 Jan 2021 00:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF86AC0893;
	Fri, 15 Jan 2021 00:35:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E67C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 00:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EEC3A87368
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 00:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GO92-DBrqUZ2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 00:35:22 +0000 (UTC)
X-Greylist: delayed 00:08:39 by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 287CA87248
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 00:35:22 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 09218A1372;
 Fri, 15 Jan 2021 01:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=srmailgate02; bh=vjQz/FTdcUA4ikts1emzODkjkcrbE4dUUeRlg
 xezK8s=; b=qW2W7tpA30Q0V4IIuz28HwNuJ/Ixfi/osS5uVNjrsQX3QtIenqFor
 o5ZPjJVKypOQFbZEU8O+C2sne911M4vQ5odKwrH3YxV6r8XF3m3Ht2IJfJ8wegqS
 0lmKcrTApoySlxWOu1KRWuFdaJ/nk1rJEPQGdXx+EKqMF9tv4d3Ri7Y0mqgv8PQs
 aGyrQGx9zXMfwREtBUdzElhoxQiPLrg8YXYESz8J8EqO8OdSo8mki9J+XMnPcdt7
 KAUvZ80eZ+6Dd/rkdIRlkiajLBXj90AowVuHCP/f9KjDva9aGEycaoBSu+4GmqgB
 +F774G3+DvXRU+UDSorxhle2JqZhMmyQQ==
From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
Subject: [PATCH RESEND v3] virtio-input: add multi-touch support
Date: Fri, 15 Jan 2021 02:26:23 +0200
Message-ID: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 Mathias Crombez <mathias.crombez@faurecia.com>
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

From: Mathias Crombez <mathias.crombez@faurecia.com>

Without multi-touch slots allocated, ABS_MT_SLOT events will be lost by
input_handle_abs_event.

Implementation is based on uinput_create_device.

Signed-off-by: Mathias Crombez <mathias.crombez@faurecia.com>
Co-developed-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
---
v2: fix patch corrupted by corporate email server
v3: use number of slots from the host

Resend since to feedback.

 drivers/virtio/virtio_input.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f1f6208edcf5..f643536807dd 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -7,6 +7,7 @@
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
+#include <linux/input/mt.h>
 
 struct virtio_input {
 	struct virtio_device       *vdev;
@@ -204,7 +205,7 @@ static int virtinput_probe(struct virtio_device *vdev)
 	struct virtio_input *vi;
 	unsigned long flags;
 	size_t size;
-	int abs, err;
+	int abs, err, nslots;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		return -ENODEV;
@@ -289,6 +290,13 @@ static int virtinput_probe(struct virtio_device *vdev)
 				continue;
 			virtinput_cfg_abs(vi, abs);
 		}
+
+		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
+			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
+			err = input_mt_init_slots(vi->idev, nslots, 0);
+			if (err)
+				goto err_mt_init_slots;
+		}
 	}
 
 	virtio_device_ready(vdev);
@@ -304,6 +312,7 @@ static int virtinput_probe(struct virtio_device *vdev)
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
+err_mt_init_slots:
 	input_free_device(vi->idev);
 err_input_alloc:
 	vdev->config->del_vqs(vdev);
-- 
2.20.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
