Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E52C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 09:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8488817A9;
	Tue, 22 Feb 2022 09:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIKJQlJ-mPko; Tue, 22 Feb 2022 09:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D40E812FA;
	Tue, 22 Feb 2022 09:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE28C0021;
	Tue, 22 Feb 2022 09:47:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB121C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D73954019F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HlJPUYI3Fc92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79DB340137
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645523270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1vLjaLOpjM/maPs9UeQipZMtimlrY+ZZDRN/XdiV3h8=;
 b=LdS3lYp5h5MIcoLJE/PEfcaCIBtmlzmv3de/462QDPUMEZ4PCSVlJQ3iERyBk6kq8v77AW
 sMs4EG7sAvQLo+9yrTCkb3EP4+IpFC8PeXXhS/pb/rgpMVnIVP+R/lDz/CbjLfLQAFcA1i
 HDWplgfyTLnwezm4xHy3pCZT1SbSIqc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-cUo8Q-74MNmuMgP1hb7-Ig-1; Tue, 22 Feb 2022 04:47:49 -0500
X-MC-Unique: cUo8Q-74MNmuMgP1hb7-Ig-1
Received: by mail-qv1-f71.google.com with SMTP id
 if3-20020a0562141c4300b0043147d6bacdso9752891qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 01:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1vLjaLOpjM/maPs9UeQipZMtimlrY+ZZDRN/XdiV3h8=;
 b=3T1Km6QN40tpBCrK8FOKnGX2nBHfnmNWzzigN6DpveKf5oEcN0wwKr1xd+jkwAY1Ew
 vjniWF5ZqGpCsu7dvgsRZzZS9b7uohIFbsqiTtwZIidLzuhRklIosMANvZNO2BpMVXZP
 0N7HyH6yk7CeaHoQtj1/2ABVcSVsCX/aRa2Lj5oo7TBnc3W3ULGtmgCRLKz9gY8GIDCY
 ld90ef+uOEYxwXXP2gnmXo5N/j4jHVMxrP1jDjmGS4lINJ7qm3lLiSJz84quB0vfejuP
 0n8EshJYVbt8gSUmH5/H0RmkRYEN1vsbI+bUfQvS4YII4BsVcF3F3P2mnN+ZCOyl1m7a
 aCVg==
X-Gm-Message-State: AOAM5306YEVuj2O1jhaJrZibysDXVIJNMB2GGG8Y+KzucTFu6RIsGFTB
 xGxxkMl77kIdshrBFIW1iPhVh3FKClzmPgFYU3d76xbduZY21PMxNJdeMym1E5fsbKIygUNIkDY
 rmPSYQIxfMkMn32YSVO1McgJV+2pGxSOQVRZ3tqHG4g==
X-Received: by 2002:ac8:5f4c:0:b0:2d9:9327:1355 with SMTP id
 y12-20020ac85f4c000000b002d993271355mr21214797qta.518.1645523268797; 
 Tue, 22 Feb 2022 01:47:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLRApCkpCfkLM6BoxEEMUdWN7hRcfpssUWglONmZj/+bkfEiUyPxNFxljOVxDFiUxHMmgtfQ==
X-Received: by 2002:ac8:5f4c:0:b0:2d9:9327:1355 with SMTP id
 y12-20020ac85f4c000000b002d993271355mr21214790qta.518.1645523268571; 
 Tue, 22 Feb 2022 01:47:48 -0800 (PST)
Received: from step1.redhat.com (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id br35sm27922533qkb.118.2022.02.22.01.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 01:47:47 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] vhost/vsock: don't check owner in vhost_vsock_stop() while
 releasing
Date: Tue, 22 Feb 2022 10:47:42 +0100
Message-Id: <20220222094742.16359-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Anirudh Rayabharam <mail@anirudhrb.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
ownership. It expects current->mm to be valid.

vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
the user has not done close(), so when we are in do_exit(). In this
case current->mm is invalid and we're releasing the device, so we
should clean it anyway.

Let's check the owner only when vhost_vsock_stop() is called
by an ioctl.

When invoked from release we can not fail so we don't check return
code of vhost_vsock_stop(). We need to stop vsock even if it's not
the owner.

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- initialized `ret` in vhost_vsock_stop [Dan]
- added comment about vhost_vsock_stop() calling in the code and an explanation
  in the commit message [MST]

v1: https://lore.kernel.org/virtualization/20220221114916.107045-1-sgarzare@redhat.com
---
 drivers/vhost/vsock.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d6ca1c7ad513..37f0b4274113 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock)
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 {
 	size_t i;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
 
-	ret = vhost_dev_check_owner(&vsock->dev);
-	if (ret)
-		goto err;
+	if (check_owner) {
+		ret = vhost_dev_check_owner(&vsock->dev);
+		if (ret)
+			goto err;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		struct vhost_virtqueue *vq = &vsock->vqs[i];
@@ -753,7 +755,12 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	 * inefficient.  Room for improvement here. */
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
-	vhost_vsock_stop(vsock);
+	/* Don't check the owner, because we are in the release path, so we
+	 * need to stop the vsock device in any case.
+	 * vhost_vsock_stop() can not fail in this case, so we don't need to
+	 * check the return code.
+	 */
+	vhost_vsock_stop(vsock, false);
 	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
 
@@ -868,7 +875,7 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 		if (start)
 			return vhost_vsock_start(vsock);
 		else
-			return vhost_vsock_stop(vsock);
+			return vhost_vsock_stop(vsock, true);
 	case VHOST_GET_FEATURES:
 		features = VHOST_VSOCK_FEATURES;
 		if (copy_to_user(argp, &features, sizeof(features)))
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
