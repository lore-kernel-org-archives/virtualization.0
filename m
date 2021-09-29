Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25FC433FE
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F4760F4B
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81F4760F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDFB4235F;
	Wed, 29 Sep 2021 15:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kASmCE-U7Otv; Wed, 29 Sep 2021 15:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9F74422AD;
	Wed, 29 Sep 2021 15:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5116BC0023;
	Wed, 29 Sep 2021 15:11:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1122DC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05A5460E75
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_pWlNevbQxu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2633460E7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1632928286;
 x=1664464286; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EFIpbunJhnllJPsXEwPg7K/UgW6ZduAMd7ddna2m6Vo=;
 b=liKDUBXQWNDkS9NVz8bSJ7Ut7txMwsmhj3Is/uxShO6yPcqKUgZXq6jV
 w1e6tWWLEyIEx+F/IRpu6yOhYiLvB++KxwSRd114fQEGzQ1l59Dxp1IKV
 zWG620qezZanM43sl3G/Uz6T5STMc30kOTZXUH/SHJJbkW+X6+vLjezMe
 hnqPMQ1SfwuM1DHsFwex8HfsWbOgg3QfcjswPMcQM3zoo10ZHdnf81hiN
 cDkESW5UTpy8uyrlNXRf3ogRBTW4M0bdclXjC7rIxjcHlY+YEo9jFhdSi
 cFh4Z/antwlMKRB+0SlWyIa6mWSYZp6FgJM8uJwKq8zP4n3PhqXV5M39U g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
Subject: [RFC PATCH 01/10] vhost: scsi: use copy_to_iter()
Date: Wed, 29 Sep 2021 17:11:10 +0200
Message-ID: <20210929151119.14778-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210929151119.14778-1-vincent.whitchurch@axis.com>
References: <20210929151119.14778-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com,
 stefanha@redhat.com, pbonzini@redhat.com
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

Use copy_to_iter() instead of __copy_to_user() when accessing the virtio
buffers as a preparation for supporting kernel-space buffers in vhost.

It also makes the code consistent since the driver is already using
copy_to_iter() in the other places it accesses the queued buffers.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/vhost/scsi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 532e204f2b1b..bcf53685439d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -462,7 +462,7 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 {
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct virtio_scsi_event *event = &evt->event;
-	struct virtio_scsi_event __user *eventp;
+	struct iov_iter iov_iter;
 	unsigned out, in;
 	int head, ret;
 
@@ -499,9 +499,10 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 		vs->vs_events_missed = false;
 	}
 
-	eventp = vq->iov[out].iov_base;
-	ret = __copy_to_user(eventp, event, sizeof(*event));
-	if (!ret)
+	iov_iter_init(&iov_iter, READ, &vq->iov[out], in, sizeof(*event));
+
+	ret = copy_to_iter(event, sizeof(*event), &iov_iter);
+	if (ret == sizeof(*event))
 		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
 	else
 		vq_err(vq, "Faulted on vhost_scsi_send_event\n");
@@ -802,17 +803,18 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_cmd *cmd)
 static void
 vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 			   struct vhost_virtqueue *vq,
-			   int head, unsigned out)
+			   int head, unsigned out, unsigned in)
 {
-	struct virtio_scsi_cmd_resp __user *resp;
 	struct virtio_scsi_cmd_resp rsp;
+	struct iov_iter iov_iter;
 	int ret;
 
+	iov_iter_init(&iov_iter, READ, &vq->iov[out], in, sizeof(rsp));
+
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
-	resp = vq->iov[out].iov_base;
-	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
-	if (!ret)
+	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
+	if (ret == sizeof(rsp))
 		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
 	else
 		pr_err("Faulted on virtio_scsi_cmd_resp\n");
@@ -1124,7 +1126,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
-			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out, vc.in);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
@@ -1347,7 +1349,7 @@ vhost_scsi_ctl_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
-			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out, vc.in);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
