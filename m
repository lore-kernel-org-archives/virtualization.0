Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBDDC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 19:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA62F401B6;
	Mon,  7 Mar 2022 19:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuMC7Iatkx8T; Mon,  7 Mar 2022 19:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 545CA401BA;
	Mon,  7 Mar 2022 19:18:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12418C001D;
	Mon,  7 Mar 2022 19:18:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECA4DC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C76DC82AC8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsUwX45PPw4K
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:18:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59C3882AA9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 19:18:00 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id q20so7486395wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dbqVSaoeE145ys9uRLEZZR3pFJY2Pmc5WG68rQTUDjk=;
 b=k5NesdgsXTht6dMH9Zs1gYWtYMsdq2oaoUryBtRQ299vTq+wKnD4nno1egKbIrBVvt
 u37JkSvL43u/gPcfLHEvrdES3On3K8okyZKtK5x2IaGkdK0XOr7WB7zQ9Zcbj6CmcmdK
 9Q6QJ9Hpjk2XNo/+94qYcfJQzracg57M/trJW6e8B5gjvzvUh4ypNZwjQtF4ZxhHttPH
 RY9eQVjhbBd/2+kGoSzknYgZXbhAs5GglyD9L3X75TZDWmEoUhXsoTT0NkLyTmW4h/na
 S9CvMWfORnMzpWyVUpT8XabV69cJNTthtxd3VRYBNCWPUjkEEJsNFDT0CozCWgfN8F7p
 NcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dbqVSaoeE145ys9uRLEZZR3pFJY2Pmc5WG68rQTUDjk=;
 b=6Ufx+Z7z08sg/dvtRia93hwvOg4hFK8RNn706RuC4RUD4bAuf2OKHg3acMzpOG3iUs
 Cjh9sAuIfdiRkZQhfBvO3IVIzxLHxa/G8G4ZDPSsMxkPbeOUUT4OUBGshwL8n32NJbsl
 pusM8eaOI18AICvxgv70r8hT/pozahr4yEyx1MnWYqsoXKy4niCgg72SWbU3jlO1UkET
 xqI6SNkCciIX20sxNJvWmacLOpc1f5G5RkWgpwVwZoyB7iyOZtqhITitc4M6Obu0px31
 vzWSz4rVXNC6oCftSTYhlxlNkbn/qzqlt0AxOYs2O+6cujH09NY+yNdeHPwRKFTA6/uc
 G2ow==
X-Gm-Message-State: AOAM533i/vHOzjw6eVZU8Igyhg5z7GOWguESBpx4WrBl4Fi6igtakFej
 ub9+W7KHQrfspgQjX7a8tdHIog==
X-Google-Smtp-Source: ABdhPJzlJiMYAf08xQYWLIojU4uURtjWC9ZBAz30RgCGZ9HLvlLDJ9lUmbZ5j3Q/JntOftXy/SgAdQ==
X-Received: by 2002:a05:600c:4615:b0:386:9f67:8c63 with SMTP id
 m21-20020a05600c461500b003869f678c63mr381658wmo.12.1646680678579; 
 Mon, 07 Mar 2022 11:17:58 -0800 (PST)
Received: from joneslee.c.googlers.com.com
 (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b003899d50f01csm200741wms.6.2022.03.07.11.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 11:17:58 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/1] vhost: Protect the virtqueue from being cleared whilst
 still in use
Date: Mon,  7 Mar 2022 19:17:57 +0000
Message-Id: <20220307191757.3177139-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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
to vhost_get_vq_desc().  All we have to do here is take the same lock
during virtqueue clean-up and we mitigate the reported issues.

Also WARN() as a precautionary measure.  The purpose of this is to
capture possible future race conditions which may pop up over time.

Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/vhost/vhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe28..ef7e371e3e649 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
+		/* No workers should run here by design. However, races have
+		 * previously occurred where drivers have been unable to flush
+		 * all work properly prior to clean-up.  Without a successful
+		 * flush the guest will malfunction, but avoiding host memory
+		 * corruption in those cases does seem preferable.
+		 */
+		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
+
+		mutex_lock(&dev->vqs[i]->mutex);
 		if (dev->vqs[i]->error_ctx)
 			eventfd_ctx_put(dev->vqs[i]->error_ctx);
 		if (dev->vqs[i]->kick)
@@ -700,6 +709,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		if (dev->vqs[i]->call_ctx.ctx)
 			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
 		vhost_vq_reset(dev, dev->vqs[i]);
+		mutex_unlock(&dev->vqs[i]->mutex);
 	}
 	vhost_dev_free_iovecs(dev);
 	if (dev->log_ctx)
-- 
2.35.1.616.g0bdcbb4464-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
