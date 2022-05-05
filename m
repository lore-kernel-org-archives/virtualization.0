Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DAC433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 09:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC9F410CB;
	Thu,  5 May 2022 09:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u36WaNrA-p7E; Thu,  5 May 2022 09:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1199F414CA;
	Thu,  5 May 2022 09:28:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9F3CC0032;
	Thu,  5 May 2022 09:28:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C267C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5488441295
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GuMQk2tEI5hn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 218DF408E3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:04 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id iq10so3696317pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6F6fmtEjrSN7+MBeg46/Q6qwb0WfdkL+E9dyellACws=;
 b=sOf3f5whdDiTUgn3OHFpXtRMBGXTZEEPUuM+Zito2LzukzrJA0js+qKWEu1AR+ffPB
 HrrcRDbXA2W0pZnc7YvgqAQ8M7j+f8UQE7PllKnzfi2DCAs79RSnuR257TwY9k5NGT/G
 0YYL4Qi3tZ5DOaMY1iE2/383nu1Cfkd/ZJWPSsDqcih1Sh+grDk4tl+isTcqe3QZzhoY
 lJ+/0xzZwgOBfojAMRAGOpuk6A1Z5a+Gy+/dUfaHpfLL1PD3xJrpw4rtn14L13+0eyoq
 flZWo8ZJsinybkKrTSavz7OQqfHkpeoGSZk2ERRE4NKq2QEjomDWp2zJwO2ytjLHnxOH
 wNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6F6fmtEjrSN7+MBeg46/Q6qwb0WfdkL+E9dyellACws=;
 b=G6FugYKsqw2IVvblbEqV9E+y7gZkB+3GItNHiSLxf6/HIDugVdro0ZPQXbzSrr+Owj
 gAGbpz2Yh/bnBoRfD/6cgnm2mP2XPR6MozmM5JmVLi1JYl2MMIFtlVQOd40Cn4Nuve0p
 1oI/XqGVyZqrVUw5CDRDPZy8tCTMyUHX1XRmErM8BAwuV6zqR8Jcsi8KPDP7q6JFAdNT
 taXjMcqfmMF4G24TtzNbK7ySSnQ763ZrIZj+jUSSfWv8eNKcczsYbaYp1m5jeaE3/goN
 0QamIObZjDPuCrtTCaU53q0OWesFhfCpdCb8exnN8bqRXcDgjk7a0mgG6eI6vlAS0ckq
 Vz1A==
X-Gm-Message-State: AOAM5320LUMv78OXQ5u1EU1FWSv00PSWzv5WO3WvF+OdJkjM/Nv4ADCP
 s3Zc6QsLNyl4XeUhGTeBsgG9Zw==
X-Google-Smtp-Source: ABdhPJxURL31yAiE1Fmma/z4loT9dDh2LA26yErXvoNjLFqD0MP2V7b/jFxmB1xjT+/pEschQwl6Iw==
X-Received: by 2002:a17:90b:3a8b:b0:1dc:4eb4:1f2a with SMTP id
 om11-20020a17090b3a8b00b001dc4eb41f2amr5017601pjb.50.1651742884373; 
 Thu, 05 May 2022 02:28:04 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 02:28:03 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v5 0/5] virtio-crypto: Improve performance
Date: Thu,  5 May 2022 17:24:03 +0800
Message-Id: <20220505092408.53692-1-pizhenwei@bytedance.com>
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
