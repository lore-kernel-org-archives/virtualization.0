Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52457C433FE
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 13:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7BD8418FD;
	Fri,  6 May 2022 13:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q1SLbJsBl2u; Fri,  6 May 2022 13:20:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39530409A1;
	Fri,  6 May 2022 13:20:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B195C0039;
	Fri,  6 May 2022 13:20:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4598EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E4FE40447
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gANm8RZ00rSS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:20:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA77640025
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:20:54 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 l11-20020a17090a49cb00b001d923a9ca99so6861415pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VQA7sO3Gs0+tp7sDV+25Y43XXMTJ/XsoGGLuKCP2Q5c=;
 b=QHX7BY4TwwXgGIri826+34OIoQnZyonU2K5KsCwFi4WtwRftvSjGjx4ptoaBX5dy5m
 EqUGIltWJH7jod06iVUUbfe07wHTN/gRZnt0YC11dr8IoLeuk2Jv6tN7yztcRSBt9rrF
 MR2HdlRMV78qjg2Z3wPMIme7/3AFqLElpIYyDmBCi+Wozg1j8Z+RMdgCCLgfKbSzhOyu
 b33ktXG0LJlFRLt6rVj0FgHig2tSxgw6w1OJmRWt3LHkoGh/XhsHfRf1bwRobMSHUk3e
 3CPwKIg4+c1oYIaE6YiTNhN48/9bvFPqFde/QJChE6/BaMB8MkULCec9tlY+QKXXZoXQ
 P/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VQA7sO3Gs0+tp7sDV+25Y43XXMTJ/XsoGGLuKCP2Q5c=;
 b=nCOMHoXSMdkiq7jU+qxR/gHMS8kR9ifKNBUegCQJM4n+vwny1GlYxX1wiuzDkE7Qym
 Ncw8qVyTKEBveT0xPMQ7zfhz/HW3JNUYyQTMoEoblJlb9MaDmfjkRUfsJKjPm3VPl/aG
 iaSHPdyo2DdtiL9loYu+WJCf2AdYjwVXvK7WUTEgvg32rHXKmd90RG/rrMi1emTNSPb2
 ltSZVjjiEcU3p1w7vp0JPvD/PufBAOtm+IPFjmIPnTgQstBrqCa2u/68WDp5qJeqeU5E
 YUqi+pF/E0j4oKmbc5/C2y7b6K6jLhBA/JwYEvDl/5gF1apm3SeEzYjIDgSXAv71aW5b
 0VpQ==
X-Gm-Message-State: AOAM533WyLW2xfz95l4aGeeW3/TFH0M1BHS+PuYgyF52hSaNWWOmN0Do
 z8s68JG9n6f2kMpxW6YkfY3Z7A==
X-Google-Smtp-Source: ABdhPJwf9r5jic9L4RMxeLZWJ+xLefhk6TerHNfuXcQyEP1lOV6uhftuuhlJRdWizxpFwGezbysJxA==
X-Received: by 2002:a17:903:2091:b0:15c:b49b:664d with SMTP id
 d17-20020a170903209100b0015cb49b664dmr3628597plc.151.1651843254280; 
 Fri, 06 May 2022 06:20:54 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 06:20:53 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v6 0/5] virtio-crypto: Improve performance
Date: Fri,  6 May 2022 21:16:22 +0800
Message-Id: <20220506131627.180784-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au
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

v5 -> v6:
 - Minor fix for crypto_engine_alloc_init_and_set().
 - All the patches have been reviewed by Gonglei, add this in patch.
 Thanks to Gonglei.

v4 -> v5:
 - Fix potentially dereferencing uninitialized variables in
   'virtio-crypto: use private buffer for control request'.
   Thanks to Dan Carpenter!

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

 .../virtio/virtio_crypto_akcipher_algs.c      |  95 ++++++------
 drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
 4 files changed, 182 insertions(+), 129 deletions(-)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
