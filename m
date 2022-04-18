Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46878C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 09:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBB4A81A95;
	Mon, 18 Apr 2022 09:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e5XGl8EHAqNq; Mon, 18 Apr 2022 09:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5596381B52;
	Mon, 18 Apr 2022 09:04:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224CAC002F;
	Mon, 18 Apr 2022 09:04:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7D42C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF56761214
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRnqlKKDjeMT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D7DB60B03
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:30 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id md4so12510293pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zwb8mG+JIzADfsDfu33jNg4PhKLseW5IOVJoEfJh+pU=;
 b=Q51XoRzYcy3Iq4zZECeVxoNnEwswZKxs01rU4rfPh3NYRYFK5llkZQGhFhpG+hYXE6
 7CGeg6r6SHSAUjsXLL42uwwDLyYx+fbpVYGGar9E0ixVUE6JwbV6z13e+KuPwtbm6n9Q
 5+AdJn3h4XNciFzz4QPahKtLkKzWni91j23FntOjP7jX+7ccUdxF0WAROoS6XkhStLVP
 XafEStfMYTX1b4fLoJu85vnIIYxf4S6XjQXLiltE6tlPXwKiuwEZqlElROaU9PdvqlVz
 7O+8coD9+WiZffIuoXsl4SclNoILqlMzNdaNUFawJei16OG3H3NZfEJk1yQRMxQigfK8
 fSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zwb8mG+JIzADfsDfu33jNg4PhKLseW5IOVJoEfJh+pU=;
 b=ci20fvu9SvJcJ2WUVP+D1jrAxBLglBPfQVMi/5E7BOCT2tKqJ4YepGGKeKotKdKr0f
 fQQ+XmcxCQFi3b2qt3E5tDp5mcTli5u3JyZrkIkucqr8EGefBUSHUaeK/QAqdCarEeAS
 hP8uoWOVoOHSSYWrRkbi1tLHseXChadbmXLPRzVofVSaUOFGYqclB6zdMcLjUPx7GQtS
 0y7rYnn2U+yzwejNKnhLZA+0/a7/4lcLecPoXwaD5WZKMGWRoK7XHB1MPV4uzbV/bcUI
 BEWZcoWIHDSwoYYnDBbE/gdoUmysKZL4rdzv/eE7FZGzBVSPXn0z/zI7PVjWKOdYEMwD
 E0oQ==
X-Gm-Message-State: AOAM532D/rjBNhRhNCSvSfSwSLrHLqahSzTBFY8c5MKH8ipZWhQUSf64
 goeoy+84WxWEKk9ij2hzRj4X4w==
X-Google-Smtp-Source: ABdhPJzUzc4cYn2K0PfMzlKo4MeWwU0ulkQ6wJc7kLElOp+ZdHUtAw0JCPmVHhRUWWSy0Xc583iZRA==
X-Received: by 2002:a17:902:e881:b0:159:828:b6dd with SMTP id
 w1-20020a170902e88100b001590828b6ddmr1072674plg.127.1650272669849; 
 Mon, 18 Apr 2022 02:04:29 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Apr 2022 02:04:29 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 0/4] virtio-crypto: Improve performance
Date: Mon, 18 Apr 2022 17:00:47 +0800
Message-Id: <20220418090051.372803-1-pizhenwei@bytedance.com>
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

zhenwei pi (2):
  virtio-crypto: wait ctrl queue instead of busy polling
  virtio-crypto: move helpers into virtio_crypto_common.c

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++-------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  27 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
 6 files changed, 224 insertions(+), 161 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
