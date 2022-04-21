Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21385C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 10:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 981DC4161A;
	Thu, 21 Apr 2022 10:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePWfbDPv7zii; Thu, 21 Apr 2022 10:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 072F84190A;
	Thu, 21 Apr 2022 10:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96DC7C0033;
	Thu, 21 Apr 2022 10:43:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4950DC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 317E060F9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2moOtw5pDO5V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:43:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EDFF60D6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:43:57 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 s14-20020a17090a880e00b001caaf6d3dd1so7396237pjn.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cbdLvfr3QXslFSKGfbNp8gy/VAj6R0oFm+lWnNgRZEE=;
 b=HkoS371DN3rSB2jIADCgXmgk6xKOztuAL+Iu5gpqJFF2mbsXhPnm/k9b7V+fq5NN2m
 rnVamyYbSirwFxS5yxa5JBJJjkE5J3dlUjgd3s8k2tifbygIVEvv8wsyA4+q06vhXj0b
 ySimouWTBoDI/FRZ0ZsdRgZn616Njg7h/xUkgKAcLhn870Fvp6Rx0cbN7A9+v4fDuuLG
 34gZbAsJsZ4xC//ClZvVEC0UF7H4A4DSE/T+aqUbLc/re/RBg599R3J/k/klpupT8Bis
 rHwwfCVEghc5OYAS2sLZAd294Y/yvPL4O2yARwX7qa7nixxGNTWQw2flHmnCadRiuEpV
 Islw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cbdLvfr3QXslFSKGfbNp8gy/VAj6R0oFm+lWnNgRZEE=;
 b=boQQ2zqbfKYFxNij1pE3qBMFEtpQWhP4DPSc4sZH7vd8dDq0oLm8AMZuYymgGv0o1L
 L7LrfyqZKDaR3CrIOP7CiRHb7ZhuJBsjPtcDMJjjBWDKgjDOT5EqW8ekfWEO49IcFIEy
 40IwlGQ8TpIa9YCVQEZcUmA52kmflHSVsteTjuIjkLXP3/M36s+vZmuDcr7rMpod0NDB
 j95zXTNx95euPB+Hg/wseCWI8Pp6WEZMzD8lbHjyoUBGo5YqAf8SHQsfmLTTIWvEDDj6
 0G+7iAaDI319nIytEMmzaPwGH8GZcZiZmyXgYUG/aMNVV/84Z46pKLBGAWQOistz59q5
 7T/Q==
X-Gm-Message-State: AOAM530d/Q87JyE47QJnoDEvzZBZUCgvvMTtojqBPm7bkqo8jRRl1hvQ
 QcxXMP/VVXzsOwvYIktQIAdouA==
X-Google-Smtp-Source: ABdhPJyk6fg01yydytqJRg18e+hOfoK++WdR9/ootTsiE1OipZUW/zqvsPTAzh4cpVm/wPk2PQXe4w==
X-Received: by 2002:a17:902:e886:b0:158:cefc:c041 with SMTP id
 w6-20020a170902e88600b00158cefcc041mr25472986plg.51.1650537836593; 
 Thu, 21 Apr 2022 03:43:56 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
 by smtp.gmail.com with ESMTPSA id
 w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 03:43:55 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 0/5] virtio-crypto: Improve performance
Date: Thu, 21 Apr 2022 18:40:11 +0800
Message-Id: <20220421104016.453458-1-pizhenwei@bytedance.com>
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
  virtio-crypto: use private buffer for control request
  virtio-crypto: wait ctrl queue instead of busy polling
  virtio-crypto: move helpers into virtio_crypto_common.c

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++-------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  29 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
 6 files changed, 226 insertions(+), 161 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
