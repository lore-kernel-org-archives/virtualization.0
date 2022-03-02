Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A376DC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 03:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37FD8827DE;
	Wed,  2 Mar 2022 03:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2W8wkclV_lOK; Wed,  2 Mar 2022 03:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7C15827FA;
	Wed,  2 Mar 2022 03:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABCBFC0012;
	Wed,  2 Mar 2022 03:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 268B5C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03DB7827C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGwoEV37mFw8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81B9E827C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:25 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id d17so783300pfl.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 19:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
 b=6X/CY4lNepwwVJNUDyNOonW19GKWf+tC3IyggXv/pky/jIaRmNZDBA1oKtPdr5LooP
 NGKqfG9ER+nV+6wWmuaG6ySWeo7M5knP7WrIGGd2gx14VY+Iaxk5v9+l8E5qM0DdoUp0
 vfj1L9gkh9aiHq/N7YF85pE3JixdLvTgg3U7I2H2OE1y13flWwd7HQPns9rC0ThP53Yc
 f8wpusgP0LijX6NczuERy/uccnIF3GYvAK2g4bYqfI7ckZYnu3OXNGw07ag8YRp6UJVX
 8V4QZli5H4TukHaZfnaVDOau/z8mzd6q2iEarVdi9tbpMEqHOlT+0VfLWl0pLw8oMqB6
 0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
 b=CLlcaIWRSVC/0R+bmzvGqdxE0R14LXkDIarG8eTt3yVM1EkT6xxTzUD2QmDGnu1cTI
 scZ2CXeu4iLqIVfBHpgI3HxWuDYQpSIz2hke5G5FtyOqzmpdDctWqFXaD61WVCBDc1Ti
 TK9q0p7MN8FxsFfcoNZ4NsWbb4TaT33ZhTsxq9p9biwv/Io939STSYuGD/TdZxQlDlZ5
 H3npwO/WGtvQU8U4SBHrvvwe+TiNGqlbcYGOMM7y0gPTq4hcG5mxRxwjIo/75ftnw52i
 Dzl9oFgq2ywMu0BM4UG7k6d2YXe7Q6WLV//BOzLjGw5splVl+CvYIjQ9PEVis8xrjPKU
 u7hA==
X-Gm-Message-State: AOAM5314hCCTg7Cips4O4ea6jpv3h502fLM55TMf7Rw1NxJNZpvsV1gB
 4cISjCW7lKUHQ1WL+FRf9YxaRA==
X-Google-Smtp-Source: ABdhPJwl5Q2jW1szWOQogqphganVUFqOGKeFGAU8EWWsKPkzsqFsqV0VASjPli3B/Buj3saDZ2lEow==
X-Received: by 2002:a63:eb0c:0:b0:373:334d:c32f with SMTP id
 t12-20020a63eb0c000000b00373334dc32fmr24326767pgh.358.1646192544523; 
 Tue, 01 Mar 2022 19:42:24 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 19:42:23 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 1/4] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date: Wed,  2 Mar 2022 11:39:14 +0800
Message-Id: <20220302033917.1295334-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
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

Base on the lastest virtio crypto spec, define VIRTIO_CRYPTO_NOSPC.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..1166a49084b0 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -408,6 +408,7 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
