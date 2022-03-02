Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA1C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 07:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CFB560BD5;
	Wed,  2 Mar 2022 07:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cbYt6CXTivqV; Wed,  2 Mar 2022 07:54:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D874060AC0;
	Wed,  2 Mar 2022 07:54:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF220C0012;
	Wed,  2 Mar 2022 07:54:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72573C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 07:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50C2740136
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 07:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HSmkpgKyFTR1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 07:54:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC96C40474
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 07:54:28 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 m42-20020a05600c3b2a00b00382ab337e14so1493154wms.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 23:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c6ICxqVOSDwYzpmIgcIPvPKtPkRYYwDZ/CKEoQLZ0fM=;
 b=NLNs1JvRIKsLEPITfEpZjQaSA9a9V1Ue2S2zsgYeosZEvHK82+MU7cO3poSVeWiINz
 RcXv1iu4ahiLT/HU9X5BxwYq69RLB7MIaPwxl/7Jp3dTzJpsJ9SocZ6U2FlmPrY7RzOT
 dwi6GJAHOyB6XrRA7JGIBGWCrVv1BuzTruyWN4iCqDfmmaGIJpqb2BXlIyDuNhfrQ8cu
 yhPguc027tZ0SYDzTZC6aiP6j+tf9y3a7gYPFKo6Hf9x8uMOqQyrqqpXVmZzmiO0PsUx
 +NTeyRbXEsVufHRGrLBe64pcia/ospSlkb38q+7rjlmozPgLAwTE4CI4EZZcL5nSQ7sx
 0Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c6ICxqVOSDwYzpmIgcIPvPKtPkRYYwDZ/CKEoQLZ0fM=;
 b=1d6TolLnyEmBdTIb601YjrpUwBez4A8tblzY00YF5jll5RgT4YkmlCE9q1Mmkn/dGv
 mS3HfjnRMlF1LyVfbkGU1vwiF8RuodWbA5bp+m3icWHOZO5vwGpgZKuK6ezEGPdtbr5+
 LcNmmzHf5+LcfF43ar4Abz9uCZDlbw51hhEtAJ2mhl/PBCiaLIfjziWhQ8AazDvLASPt
 0rpkyNquyj45+UHNiUC61axQKuxDAmcBYuGv2FFRO2Wz2JPcAzJouTX0zZADEzYmErDc
 2HgbNfn7O8mIhWyEZzvN0hsq9A5R4m3/1UTzqCnh+poTiI13xX5+d8s1mV0WoHB0wsdc
 3dbw==
X-Gm-Message-State: AOAM532Ro0uERi3dFtadrQnnGfWlNUrf70xt2uxohFB2vypS0ePyxzKL
 +t0FalMU03IPKOsnVFXJWcPXQA==
X-Google-Smtp-Source: ABdhPJzeg9BJNdGu68uugP5ZRd/ZsHrKT5Kky4Ce44uKg6fonCFHYVnL94JIefllJ03DLHGf6n3diA==
X-Received: by 2002:a7b:c091:0:b0:381:8179:a7b with SMTP id
 r17-20020a7bc091000000b0038181790a7bmr6341366wmh.195.1646207666772; 
 Tue, 01 Mar 2022 23:54:26 -0800 (PST)
Received: from joneslee.c.googlers.com.com
 (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a7bc84e000000b0038100c9a593sm6906498wml.45.2022.03.01.23.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 23:54:26 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/1] vhost: Protect the virtqueue from being cleared whilst
 still in use
Date: Wed,  2 Mar 2022 07:54:21 +0000
Message-Id: <20220302075421.2131221-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

vhost_vsock_handle_tx_kick() already holds the mutex during its call
to vhost_get_vq_desc().  All we have to do is take the same lock
during virtqueue clean-up and we mitigate the reported issues.

Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe28..bbaff6a5e21b8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
+		mutex_lock(&dev->vqs[i]->mutex);
 		if (dev->vqs[i]->error_ctx)
 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
 		if (dev->vqs[i]->kick)
@@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		if (dev->vqs[i]->call_ctx.ctx)
 			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
 		vhost_vq_reset(dev, dev->vqs[i]);
+		mutex_unlock(&dev->vqs[i]->mutex);
 	}
 	vhost_dev_free_iovecs(dev);
 	if (dev->log_ctx)
-- 
2.35.1.574.g5d30c73bfb-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
