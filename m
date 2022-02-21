Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9184C433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 11:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61BE64049A;
	Mon, 21 Feb 2022 11:49:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lcgUgUb8APro; Mon, 21 Feb 2022 11:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3C364067F;
	Mon, 21 Feb 2022 11:49:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DED0C001A;
	Mon, 21 Feb 2022 11:49:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C97EFC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B476860E35
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCHXYxnBsNKX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BD4160DE5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645444161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=12CjzIfm9u48VcTin9bYn/mbYSt9Byr6lQhm+jL2Tdg=;
 b=Cjy025vwft07fWAvug7AjxDgvwYQ7uAVaIzfMuIwtmB41dEdZmaRKO9zxwVtzoAr7FmdVE
 CapQEblofGCFtzSVlWziC38kwc0jAxH+CgW/zk6MvsaK9Xzh/zp/6LXA6HXldio+mO74VA
 WwEj6wGU/2sMVllqYFw1Q+FqazeZDQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-u4LG_Qh6OGeLSV56Yeh4TQ-1; Mon, 21 Feb 2022 06:49:20 -0500
X-MC-Unique: u4LG_Qh6OGeLSV56Yeh4TQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 k3-20020adfb343000000b001e463e6af20so7261823wrd.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=12CjzIfm9u48VcTin9bYn/mbYSt9Byr6lQhm+jL2Tdg=;
 b=PSBoxtJnbxWAxE4TFh8MwjC2yI0EU7Cud7r6ljusHoI0DdYD0GjT0uvN9eqwPAkNEe
 lTGvyc8Ukw1LvAMj7s1nWdfpnD7ILVPPYknf79nSnqS1WWQviKsStuJbyt8xIjEIp+W2
 ZdlK87mooeGbyfMZSvb+D2lo8peW/JJlwizUDmVDLl65vurBw2vFh01wZPgczJbAIX8x
 dV4jCENAH7qQgotniug+Y0QMlLRIRYoDDtbz09lBg3SELOYHuITtF+9ZrmbbFFGuXVOe
 I2rr+pm1uZV+/cN2+co7IuRQCh3iUa9S4geuOSLyNsuM9fTAw/i6yecit3YvDcLxYOL8
 Dsuw==
X-Gm-Message-State: AOAM531jqsRjJOgrcYbv1hwyet1zBNyYurvzgK8J0N+r+C0PQMpC7ECq
 FUFspM5AigIJBl1+Yq4WPdpV5JJysDssZcnx/XURSIuOd3BvGkhqGbhEpS1AP/aOl/kAe87mats
 KizgVrQmrvs2xBFwwFwYf6mPv4hE8bwsagqJQxzM8Yw==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id
 c4-20020a7bc844000000b0037bb9867726mr17401388wml.160.1645444158956; 
 Mon, 21 Feb 2022 03:49:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz80NBK4xySdNK92dBVDo686zdoILiLjZ8DrwJxbn6DUuDBzdF93Cfrshx7zCott46Y92HTgQ==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id
 c4-20020a7bc844000000b0037bb9867726mr17401363wml.160.1645444158689; 
 Mon, 21 Feb 2022 03:49:18 -0800 (PST)
Received: from step1.redhat.com (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c338600b0037c322d1425sm7141176wmp.8.2022.02.21.03.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 03:49:17 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop() while
 releasing
Date: Mon, 21 Feb 2022 12:49:16 +0100
Message-Id: <20220221114916.107045-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>
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

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d6ca1c7ad513..f00d2dfd72b7 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock)
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 {
 	size_t i;
 	int ret;
 
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
@@ -753,7 +755,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	 * inefficient.  Room for improvement here. */
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
-	vhost_vsock_stop(vsock);
+	vhost_vsock_stop(vsock, false);
 	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
 
@@ -868,7 +870,7 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
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
