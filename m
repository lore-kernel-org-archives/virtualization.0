Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56411C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 17:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC40E4016A;
	Thu, 25 Nov 2021 17:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zw1Kpue2yexU; Thu, 25 Nov 2021 17:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5181F400A4;
	Thu, 25 Nov 2021 17:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A0F0C0012;
	Thu, 25 Nov 2021 17:44:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F18E8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 17:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFE236070F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 17:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c5_9SH1ieHkj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 17:44:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06ABD605E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637862293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
 b=LGOR/aRJGcINTJtnI3WCI/stW2mGLxtDtzduwy+Wu14uREu8LHB7hjx94QfxW41ge7DYTf
 fVx2S845KmNd2A+BxuPBGsTn7xvNSkxnqVJpYztFt69wLSanuUj2OmBDYAYJfquHH2l+E2
 4CvRfm2VjCMARsvkshLWqE3j0fQejvk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-qaxGFY21OtW9TIkl7HYipg-1; Thu, 25 Nov 2021 12:44:52 -0500
X-MC-Unique: qaxGFY21OtW9TIkl7HYipg-1
Received: by mail-ed1-f72.google.com with SMTP id
 v9-20020a50d849000000b003dcb31eabaaso6012486edj.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 09:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
 b=xwzd+ZgYOmqhEckWU5lJ7cM1JKeEWM5tjn9/hXf535as3c8heOtEVRX5POSOhXPVB/
 IMh6p/e+6cNra1hFvl4g/gDXYZ9O8VjZmOeNnL+eJ5Xj4wX97yObnbXHyi3xSXYw4K4/
 crlee4Zu4hq0mLAAYwpovEFEW34kzmwOOsoBpI00EFJ3/89dxQbr08oKCcPBnQ88CPi3
 kp9psmvOjitn25tzpwJ49nQdFHEXukTxr3pjHsOCtVIXJ08We3pUmsocxr4/K99drW/N
 Kks4ssaPEkWl0U6zakLLyXwI/Lwi4rVTWQS96ntsAaNyl1n65MbwqIkBiVe7wA7BNh7C
 zysA==
X-Gm-Message-State: AOAM531k/+hJQnRGBDuMnqQKcnGNWOE072HFL3hctuWcsW7F8Qx9kCNp
 IpOwAV9pM+PAhw8Xo8VkBLDupPNHL7ZEBHPmTPkmNbOqUKydiB9Z/8ciCb1fhvh1CAHaa3s8aEG
 XvYpxz0j+ByPmThjQ+bOfXf/Zap6qo+UFjlJHAZ0yaA==
X-Received: by 2002:a05:6402:26c5:: with SMTP id
 x5mr41644306edd.198.1637862291202; 
 Thu, 25 Nov 2021 09:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpwEn3VYvVMPaGoZd0qGJp74+cDdsbX2UWjVLjI4yEEPSqkH08d/TIHMG/MWFEShL7tUlQ4g==
X-Received: by 2002:a05:6402:26c5:: with SMTP id
 x5mr41644274edd.198.1637862291043; 
 Thu, 25 Nov 2021 09:44:51 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
 by smtp.gmail.com with ESMTPSA id og14sm1925383ejc.107.2021.11.25.09.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 09:44:50 -0800 (PST)
Date: Thu, 25 Nov 2021 12:44:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125174200.133230-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 virtualization@lists.linux-foundation.org
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

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.

The cost here is a single skb wasted on an unused bt device - which
seems modest.

NB: with this fix in place driver still suffers from a race condition if
an interrupt triggers while device is being reset. Work on a fix for
that issue is in progress.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: completely untested, in particular the device isn't supported in QEMU.
Please do not queue directly - please help review and test and ack,
and I will queue this together with reset fixes.
Thanks!


 drivers/bluetooth/virtio_bt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 24a9258962fa..aea33ba9522c 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 
 static int virtbt_open(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
 
+static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
+{
 	if (virtbt_add_inbuf(vbt) < 0)
 		return -EIO;
 
@@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_close(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
+
+static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
+{
 	int i;
 
 	cancel_work_sync(&vbt->rx);
@@ -351,8 +358,14 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	if (virtbt_open_vdev(vbt))
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -365,6 +378,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	vdev->config->reset(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
