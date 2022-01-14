Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B001C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 09:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0219D60F3A;
	Fri, 14 Jan 2022 09:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlQ_mOlSvFcw; Fri, 14 Jan 2022 09:05:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8349B60F34;
	Fri, 14 Jan 2022 09:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5885FC0030;
	Fri, 14 Jan 2022 09:05:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D47F8C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACDF4415D0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJIUwcmvUtVA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6AD0415CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642151127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QSqhd5EHQVjGBS9+fRjPxVdCzG4rtUKAbc2JLGcS0M8=;
 b=JGZrQ10R45v+cHu2GU+N32xDRfKfLh7C1fahIzV9RF4vN0qk+HW8x13LdxEIeYXmHy/qEx
 L2XEcz5+pwM1w6AL1RYT4fB3bdh/neD6/mqMDTnFRAdSdv36MlOyNpwu83dA3icBcl6b79
 qE5dgTvts+0dpQfUv275s0xuwmyakq4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-oaVqqE9dOzecQ9dWVvKo7A-1; Fri, 14 Jan 2022 04:05:21 -0500
X-MC-Unique: oaVqqE9dOzecQ9dWVvKo7A-1
Received: by mail-pj1-f71.google.com with SMTP id
 a22-20020a17090abe1600b001b39929b5fdso8709288pjs.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 01:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSqhd5EHQVjGBS9+fRjPxVdCzG4rtUKAbc2JLGcS0M8=;
 b=IwHu9k9BT3bk1bXH7pR1I4cwBL/U8C6IcERsfkU4pXYgeSd8kiFyc+7sOtcRKUifhP
 v3Mn7A1KXlOXo4C+fnQAX6zWf8ac+PqOCXC1Uy+bTQbJbeME7Fzite6tmESUFiiobvM2
 hsFkJIy41NVFKtwHbmW1Q2f9bzP+gSnguqfv93MZlbK8nZCyM/yF/0+ThRzAeJB2got9
 md7nu5PrUmSnZZi1ZhOAGEwFVKEWzGtupCe7zu4nDLSu6X1XHGUeI6BYs5iigxqK5WNE
 m0pAkO/VH4JR2qWjy8xyXtdvkZCCZXF9tObpdS3MIiCqs1851kCTYTfwjb3zTMS6Ir9f
 RlnQ==
X-Gm-Message-State: AOAM533sAX484/4KDYZ315Zd2LpJlQDHHb8peVdV7XMWeIKxFzVDMeH0
 FrKgG8SnafCZu5DbnlLFrf5Hy2/zHoi7fy0gcNB5ISUXNywsld3y8ToRB3L93vgdTMUuSLtrBxd
 LnylJ/2TSbtvbRm0lkUDIxgUfVNUoiyGeFldbS+lCoQg8LDwqZjDr1lTWTUXlgFES+54OD2Sy2Y
 yEMpzUCqkgpZZ4J0vAyw==
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id
 k3-20020a170902760300b00148daa7ed7emr8569182pll.150.1642151120017; 
 Fri, 14 Jan 2022 01:05:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW79PSPSMG4VhQolpshd54Loc7rye/TOYMJd/7+9JvMi8g1YuVwpqwFGtXO0bt0SuSVXZouw==
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id
 k3-20020a170902760300b00148daa7ed7emr8569146pll.150.1642151119627; 
 Fri, 14 Jan 2022 01:05:19 -0800 (PST)
Received: from steredhat.redhat.com
 (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id c6sm5217474pfv.62.2022.01.14.01.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 01:05:18 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Date: Fri, 14 Jan 2022 10:05:08 +0100
Message-Id: <20220114090508.36416-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com
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

In vhost_enable_notify() we enable the notifications and we read
the avail index to check if new buffers have become available in
the meantime.

We are not caching the avail index, so when the device will call
vhost_get_vq_desc(), it will find the old value in the cache and
it will read the avail index again.

It would be better to refresh the cache every time we read avail
index, so let's change vhost_enable_notify() caching the value in
`avail_idx` and compare it with `last_avail_idx` to check if there
are new buffers available.

Anyway, we don't expect a significant performance boost because
the above path is not very common, indeed vhost_enable_notify()
is often called with unlikely(), expecting that avail index has
not been updated.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- improved the commit description [MST, Jason]
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..07363dff559e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
-	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
+	return vq->avail_idx != vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
