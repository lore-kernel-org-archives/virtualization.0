Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A94C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 08:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E08A60D9C;
	Mon, 14 Mar 2022 08:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yz2hqARmsW_C; Mon, 14 Mar 2022 08:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3AD3360D91;
	Mon, 14 Mar 2022 08:43:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188E9C0033;
	Mon, 14 Mar 2022 08:43:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83A4FC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80CAE40248
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMT6MWsYYb1f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:43:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6829E4023C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 08:43:08 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 7-20020a05600c228700b00385fd860f49so9170293wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h8sJyHrz9MSFv6aQ5rNLhY6H2EgY9rxFKZSrrjXt/DA=;
 b=SFQws5dWS5IMGrfAnDPxae+Am8l7I6/hNpKN2OmjbEYBGOqYImlF1vqLR1AWOKjxuz
 Y3SmnYVN3rl4rC4EoSP+NPG+5KWZz++GAzeOoGAbPT/KVHXn4ANsb5wfn5v3kGdtF/ZJ
 64EyjWFnJczi6FbxWHPRo3MnjGRwix9kCikrysBaeN1/ylzG2nUNblB3tW3v/OKTS6xt
 gCceRq2GOmUuCVyDsRt62GwnhO3ZZLyEg6TLLo0DIi2fWEIRL1kSiGcyV/KP1hV5Ur/m
 w9PIORH6GoAPa2fq9IRxdWhZhrnbnpECthh2qm72hq+KeXISV48tviEmpezl7l3KW+gs
 s/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h8sJyHrz9MSFv6aQ5rNLhY6H2EgY9rxFKZSrrjXt/DA=;
 b=6AUbcpVl+tCfU2jfINPvocNMs2QRAWfbCQy2Q2ZuW2MTbtCgWirlxgn5aN7cVjUA0X
 Kli3t/SwpP+1+ZAZIAj25arkX9tCmDVc7qT08Efo+gDYVonAWi7DdcctkXo+pkgSpQvY
 F8gVIDkptxMkZm5Dsz5iSQTJYyRqOtJr/vG5B+fU1Wrn0eWDZPvLVeq4Wp9i5ObZklG5
 4hU1pWLzgaX5NqmLO6gwVuPA4Ka8TRZ3CRJTkaBmeGm+m2/AIb5RF1DnDsypOatCwLbM
 oiIZc9TQfyoRBBjEchlfq0ev835R+SmVhNdLXMYKiZDTBsJu/62VrpFcnvWyQh1cSLn8
 MiEA==
X-Gm-Message-State: AOAM533G0NcuFVYTBAoME0c7mDtgJHAS0asnJ6Ud7QDcMzyZWOINSZLv
 A4xFwV9Rv6SdSOxXLmYVus8D3A==
X-Google-Smtp-Source: ABdhPJzc9uprjBGpnv4mgjX60WyBxgufdLW4uQZcYLKXmRnyMUHGBSCkV5UyRJf8/ADueYqZriWJIQ==
X-Received: by 2002:a05:600c:4249:b0:385:a7bc:b37 with SMTP id
 r9-20020a05600c424900b00385a7bc0b37mr24170451wmm.185.1647247386565; 
 Mon, 14 Mar 2022 01:43:06 -0700 (PDT)
Received: from joneslee.c.googlers.com.com
 (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
 by smtp.gmail.com with ESMTPSA id
 v14-20020adfd18e000000b0020373e5319asm13416678wrc.103.2022.03.14.01.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 01:43:06 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/1] vhost: Protect the virtqueue from being cleared whilst
 still in use
Date: Mon, 14 Mar 2022 08:43:02 +0000
Message-Id: <20220314084302.2933167-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

vhost_vsock_handle_tx_kick() already holds the mutex during its call
to vhost_get_vq_desc().  All we have to do here is take the same lock
during virtqueue clean-up and we mitigate the reported issues.

Also WARN() as a precautionary measure.  The purpose of this is to
capture possible future race conditions which may pop up over time.

Cc: <stable@vger.kernel.org>
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
2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
