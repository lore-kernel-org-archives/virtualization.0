Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6C1C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 15:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0625415F3;
	Thu,  3 Mar 2022 15:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgF9cRcVYMlZ; Thu,  3 Mar 2022 15:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 840C8408B4;
	Thu,  3 Mar 2022 15:19:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C6EC0012;
	Thu,  3 Mar 2022 15:19:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7841AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 15:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 581CE81A99
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 15:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-Owxf3fFlGm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 15:19:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCAAE8134E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 15:19:38 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 m42-20020a05600c3b2a00b00382ab337e14so4335077wms.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 07:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dOoO/JtORNxVZOuIC5thYYXw8aLAykNtaVPyMe7nNAo=;
 b=QPFImnuoqUI4E0pV+jHg3jjHVeJweVwJ3r4BpMu0rntbk9Vr5VjHIk8AmXRhgQEdGJ
 yJvj3ApG6YJgPydyTJQj3NGBBxjmEHO7voiSA7deudhWIr6rkicUEbS6xjLUIVFuUQCn
 RwLJji6fTL7jBleSg1Uo0GjpHv6bYKZvBdA5eLPW4coURfm7jzZ4I0520scjS8fm0OfB
 x2mZEwInNPY2fSiTDooito+65x7TzEAfbxxtnO7lVzK8svl+p+7Cwaia0mIF0id7Xwnq
 0xyUg+FxI5e/ENMgxNnEacX79exFYXFEDu8f1yyL08qCE0AAk2ITEdzFp64quU+WenX8
 +Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dOoO/JtORNxVZOuIC5thYYXw8aLAykNtaVPyMe7nNAo=;
 b=GSH6ugZXM4PTK2ourcewHHo/sEZCQiDy+Rs5BTD69+2Ky29Oeo99uEUEvkFw96gboe
 jTbpI/+KuI+WcDTcviSUTa4DrJydc5jC5vHlUIrk7UpjatI3dMS+gcJIVS7rhgguBJ7Z
 VUeocriwJzdPOHebyGYd8AyPrqDDQQ3ZR9NNv2rbbZN/ONeKRrcvHEOxrsv9EjQWOH4S
 SvvLaUA06SkN05Jn6NxDmX3QWN1H5nqUC77O9XIc7BHL7AE4Xg5T77LoTi9s/YXkgosa
 Gmq3gxCMbzFoyiDlmvpi5qPsdHdS0sfhba9ynit4BxuztDLGyIl33D4KmmThO1Neu6/n
 HI+w==
X-Gm-Message-State: AOAM533R8+SzY7BbSmUcvW7f2oCuYK0owbpLBQmvWeXKNl6iA2IS6m5l
 L2+7yZ8rNyRSviyX4ozGLgni3w==
X-Google-Smtp-Source: ABdhPJwBQE32p1eCLLGgpO7z7Um4TrNO2cXOhEvLouHcngoQPm+YylJZz5schSV+hxeHcTutefuExw==
X-Received: by 2002:a7b:c30e:0:b0:37f:a63d:3d1f with SMTP id
 k14-20020a7bc30e000000b0037fa63d3d1fmr4077819wmj.178.1646320773221; 
 Thu, 03 Mar 2022 07:19:33 -0800 (PST)
Received: from joneslee.c.googlers.com.com
 (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a05600c190c00b00380ead5bc65sm2987517wmq.29.2022.03.03.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 07:19:32 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held whilst
 clean-up in progress
Date: Thu,  3 Mar 2022 15:19:29 +0000
Message-Id: <20220303151929.2505822-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

All workers/users should be halted before any clean-up should take place.

Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bbaff6a5e21b8..d935d2506963f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
+		/* Ideally all workers should be stopped prior to clean-up */
+		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
+
 		mutex_lock(&dev->vqs[i]->mutex);
 		if (dev->vqs[i]->error_ctx)
 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
-- 
2.35.1.574.g5d30c73bfb-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
