Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFEBC433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 10:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 539A8405B0;
	Sun, 24 Apr 2022 10:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pxwSpXZoSrcq; Sun, 24 Apr 2022 10:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F014C40104;
	Sun, 24 Apr 2022 10:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5986C0039;
	Sun, 24 Apr 2022 10:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A14DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A1F0818AC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRzDQLaDq-aA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A52EE81831
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:36 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id g3so10429041pgg.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hgm0iMTcbJlWpJC7de8Vsbhe1vIzSyz1TGNEgDqQz+s=;
 b=ikRtpf8MarBHAoBqvMR+OoxFFlHT4UonYiMPc6JtqDOyLGlKd7Yxjo+Ysp+CehIzUE
 Gbt2nTdm3Q7mqK5pKyBxG/qVQc/ZRKsv/NrGCJQhoDnRj/ppQqaKvnaZFtVxJIK9x7qq
 tZl+vXUNMrpAMC5rV1pALvQzfNAxPxDhLnrVh8OP5qDN409ngYEauF0+fJTexGKTnZE5
 P/KtbNfkp8PJ171jnacykY093Kn8MaAkLSgZur2IQa/YDk/9vqnRrXLaLtTaDqwZ86oP
 n2iYLh9HUI/mOLxpILAybQoiGZ9AJuyMZDI91eVjoFwrIW+AXFfx1vtC31ARhlZRq+cw
 1Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hgm0iMTcbJlWpJC7de8Vsbhe1vIzSyz1TGNEgDqQz+s=;
 b=Hk4nmQobNmoHHaTCUR+VdQcBTD8pkSAcqvIKWld7Daw/V9A7WByBs5xN63twqTHINQ
 43DavX+VnoK9jxABZYIWKElMab6eCzIsChG2pokdRYcnHnA6OKZQg9npzUcUZl4+R1Q/
 oDS37vfjPQRfBTSgPR4mTfI4D3wPX30UBxgIr1B3oBdwgP+zvNYuPznAPkGc0fe4LrwY
 ujAI3+TvQ9n4eiPBbt/lOZZbB7luPeBqFCaX1qU7yg5s7xSkKs7DKbLQy0zDj6+FVXEg
 ugdHICcefrauKUfMr2RtG4VOtls4UzCrCDjK3rOd0ZwemjTziZ+B5bedr405F1vRkr2Z
 emsw==
X-Gm-Message-State: AOAM5336Fpq/BupoEZeYL/Ey8AfTn1qHvsPyvYRUI8CMb3mhbuBJBxVu
 +c/VzRcKIZtGFeD01nDD8dQIL24090rrgQ==
X-Google-Smtp-Source: ABdhPJzIq0JOsGhq12ZVie8DTSsfCThiz74j8+by2Hiziw6U0PFUHueUFgGrCYA3vhcWggPqU6xmoQ==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id
 c16-20020a056a000ad000b0050a51b31e3dmr13758409pfl.18.1650797135837; 
 Sun, 24 Apr 2022 03:45:35 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Apr 2022 03:45:35 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 0/5] virtio-crypto: Improve performance
Date: Sun, 24 Apr 2022 18:41:35 +0800
Message-Id: <20220424104140.44841-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

Hi, Lei
I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
 and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c,
then the xx_core.c supports:
  - probe/remove/irq affinity seting for a virtio device
  - basic virtio related operations

xx_common.c supports:
  - common helpers/functions for algos

Do you have any suggestion about this?

v3 -> v4:
 - Don't create new file virtio_common.c, the new functions are added
   into virtio_crypto_core.c
 - Split the first patch into two parts:
     1, change code style,
     2, use private buffer instead of shared buffer
 - Remove relevant change.
 - Other minor changes.

v2 -> v3:
 - Jason suggested that spliting the first patch into two part:
     1, using private buffer
     2, remove the busy polling
   Rework as Jason's suggestion, this makes the smaller change in
   each one and clear.

v1 -> v2:
 - Use kfree instead of kfree_sensitive for insensitive buffer.
 - Several coding style fix.
 - Use memory from current node, instead of memory close to device
 - Add more message in commit, also explain why removing per-device
   request buffer.
 - Add necessary comment in code to explain why using kzalloc to
   allocate struct virtio_crypto_ctrl_request.

v1:
The main point of this series is to improve the performance for
virtio crypto:
- Use wait mechanism instead of busy polling for ctrl queue, this
  reduces CPU and lock racing, it's possiable to create/destroy session
  parallelly, QPS increases from ~40K/s to ~200K/s.
- Enable retry on crypto engine to improve performance for data queue,
  this allows the larger depth instead of 1.
- Fix dst data length in akcipher service.
- Other style fix.

lei he (2):
  virtio-crypto: adjust dst_len at ops callback
  virtio-crypto: enable retry for virtio-crypto-dev

zhenwei pi (3):
  virtio-crypto: change code style
  virtio-crypto: use private buffer for control request
  virtio-crypto: wait ctrl queue instead of busy polling

 .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
 drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
 4 files changed, 180 insertions(+), 119 deletions(-)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
