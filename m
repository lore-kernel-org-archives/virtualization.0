Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F52C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 10:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEB4A60671;
	Sun, 24 Apr 2022 10:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isOOUB-TJZ1D; Sun, 24 Apr 2022 10:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 449D660E9E;
	Sun, 24 Apr 2022 10:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13924C0039;
	Sun, 24 Apr 2022 10:46:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0B68C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F1EA81C93
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjUTpyy4R34n
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EFD781CDB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:59 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id b12so5995269plg.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
 b=voSfwnuz4TazDsGKnkLUa3eLXrQvuZd0CeBraJuFrBeSJjuo6ZZnyyZ6IVf0DMCxDd
 2jO3l101hWUMVw6fE6Q1scUwdoY55AfZrU59fgoeCmBV8NoDnheH2xHW9oOuLNYc32kS
 /Myz9unOyMQgMJYiLy50IfLa0wWwZPsTpzo+uY0oEcuxNFo+Xee80to77j8yDZ+BPT4y
 djGTubGoqSCw75gGJq5Xax5kSqm3psqt0E8BbnH2vId9AoT513Tt6AWKyFwJ+/iitQWt
 z87pqXiqtAqnUt/3mHP9bu0yoOsQRF02y/h4nYScuC/sgGnvBrK48Z2KddBDQnrw0ALc
 uUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
 b=lI609NWUlViB+iSn60xbZN8wzPJpcJYi40GOBeSpMMBj1XCWS2QsVA8W5luuuS/sI2
 6ar0s4WPGLvCyVqKzgaeuNKsidwcZDo9XNPVQ7CSS+OsadJ5U5ohQi1NEN5lB3WYXLSy
 lnV8B8Ke0rNGZ079kUnWxBw9WCneYzcbVwoysqVGzocFM7uZRIS68lO092ibUA2AjHHT
 JzKQBtfV9Y/imRh6vt1dsziF0rAgj2CWFGtvNOlwAN7+xpBJDxuEcyhPVCqI/XPDq0Oz
 j7VZ/BHGDPxN4EnhnCdN5Y3OYD6LR+yDFfnEYbSLXOTdXC1i3xEm+EI3UGUUhCv2YTtn
 68ng==
X-Gm-Message-State: AOAM5306zz9jxxo+4FPcOxwtAfnlna9OoI2z8xdbAYv/X0+jDcJXRQwQ
 i/awpj7FQ95PQyx6Ws8Pvt9UhA==
X-Google-Smtp-Source: ABdhPJxsLxoBTSXLJ8lKEHWxix35/c4WKDc8Lc+R21OTU1ppRMOI/MHE4yD26NyDYhl3/dU3YYeX9Q==
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr12832804pll.132.1650797158606; 
 Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Apr 2022 03:45:58 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date: Sun, 24 Apr 2022 18:41:40 +0800
Message-Id: <20220424104140.44841-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 davem@davemloft.net, herbert@gondor.apana.org.au
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

From: lei he <helei.sig11@bytedance.com>

Enable retry for virtio-crypto-dev, so that crypto-engine
can process cipher-requests parallelly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 60490ffa3df1..f67e0d4c1b0c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, 1,
+						virtqueue_get_vring_size(vqs[i]));
 		if (!vi->data_vq[i].engine) {
 			ret = -ENOMEM;
 			goto err_engine;
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
