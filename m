Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 02:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D9F60E64;
	Wed, 23 Mar 2022 02:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lWVOLXFB1-j; Wed, 23 Mar 2022 02:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A97A660E32;
	Wed, 23 Mar 2022 02:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F480C001A;
	Wed, 23 Mar 2022 02:52:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6541DC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CD6260E50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGA9QGbwA2Ur
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:52:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FF5060E32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:52:53 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id m22so434508pja.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0D/WBKifaDu0QJZs9LIL569qdjw+FHM82ekkuU6fuM=;
 b=KoN+nML2TonJR5xMgMr2gMwkQES9A1FLa7BAlsvaQ9f1w5K4h4DgAyB0dhKwP7wtiG
 HrCJDRQiUP8skWsJMTV+GJZkwIt4iOMdNEwvFBPHsZHzRukCNGcKlfxbmWcQ2qjS+UsN
 IzLXJ65q/j5ijvMs3h+fZX+VBNaPgkKPagKLxCglfYX6TEPjEiCrxGfsMWXg/DOer4cs
 Q1K77VSirNxaSNNvcmonpH5NyriNtv5/A1M35DA2w2rKjth/kpjiNHeycdqEAvVDbbCg
 8FI3Dr6WXU9WPceBfJvv20+zLz7mfPZ5WF7EQNMe9fV7igx6VkBrN8WrNtev+T/69JHp
 ryeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0D/WBKifaDu0QJZs9LIL569qdjw+FHM82ekkuU6fuM=;
 b=XIm2f/n691bhYSW/A+djEY1u74aAKz0LiuaGKZF27/op+qmTaQA1k/Xpm7sUPETbmN
 nwaqwTjr4xOGTaCTaK+cIoQXh2/aUMnuii9MB87DeTFfNkOnc1hEDVOeBAJMQMW7Jxfs
 Nwai1RJHOfwWFwGpLDfDJBdrJvpQD7VQg/joGrjn6UPea82Te1Twol73gjS0dCPmKsmu
 3mbvi106Df8Kq1xa7+0vjHSuGPTJBrSJ3P8tdNibPLA9ftmiA4PXP6qaGOvDBPfYdDgz
 WQlIVrX5rjwsfuKVrl8uWGMm0D5dwt+PmxlQ4ybDrKS5CCwzLQh5Mib9qeySQ1ByR3tC
 3JdA==
X-Gm-Message-State: AOAM530JBwiPqwcyRhQqHglBXIbulmQ+EcAeOj0vyX0Tx8fC0LH3c/Da
 b7yFR6kq3ja8vpLF1ws9nvR9Ag==
X-Google-Smtp-Source: ABdhPJxYBmxv6gXRXs+b+cxGIwP3jmoRCvK74xS07EPSxgN90S1/2mQYEwexyNb2ELj/F4UwKJNm3A==
X-Received: by 2002:a17:902:6845:b0:153:9af1:3134 with SMTP id
 f5-20020a170902684500b001539af13134mr21522767pln.169.1648003973459; 
 Tue, 22 Mar 2022 19:52:53 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a63a602000000b0038062a0bc6fsm18104869pge.67.2022.03.22.19.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 19:52:52 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 0/6] Support akcipher for virtio-crypto
Date: Wed, 23 Mar 2022 10:49:06 +0800
Message-Id: <20220323024912.249789-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: herbert@gondor.apana.org.au, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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
- Introduce akcipher types to qapi
- Add test/benchmark suite for akcipher class
- Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
  - crypto: Introduce akcipher crypto class
  - virtio-crypto: Introduce RSA algorithm

v1 -> v2:
- Update virtio_crypto.h from v2 version of related kernel patch.

v1:
- Support akcipher for virtio-crypto.
- Introduce akcipher class.
- Introduce ASN1 decoder into QEMU.
- Implement RSA backend by nettle/hogweed.

Lei He (3):
  crypto-akcipher: Introduce akcipher types to qapi
  crypto: Implement RSA algorithm by hogweed
  tests/crypto: Add test suite for crypto akcipher

Zhenwei Pi (3):
  virtio-crypto: header update
  crypto: Introduce akcipher crypto class
  virtio-crypto: Introduce RSA algorithm

 backends/cryptodev-builtin.c                  | 319 +++++++-
 backends/cryptodev-vhost-user.c               |  34 +-
 backends/cryptodev.c                          |  32 +-
 crypto/akcipher-nettle.c                      | 523 +++++++++++++
 crypto/akcipher.c                             |  81 ++
 crypto/asn1_decoder.c                         | 185 +++++
 crypto/asn1_decoder.h                         |  42 +
 crypto/meson.build                            |   4 +
 hw/virtio/virtio-crypto.c                     | 326 ++++++--
 include/crypto/akcipher.h                     | 155 ++++
 include/hw/virtio/virtio-crypto.h             |   5 +-
 .../standard-headers/linux/virtio_crypto.h    |  82 +-
 include/sysemu/cryptodev.h                    |  88 ++-
 meson.build                                   |  11 +
 qapi/crypto.json                              |  86 +++
 tests/bench/benchmark-crypto-akcipher.c       | 163 ++++
 tests/bench/meson.build                       |   6 +
 tests/bench/test_akcipher_keys.inc            | 277 +++++++
 tests/unit/meson.build                        |   1 +
 tests/unit/test-crypto-akcipher.c             | 715 ++++++++++++++++++
 20 files changed, 2990 insertions(+), 145 deletions(-)
 create mode 100644 crypto/akcipher-nettle.c
 create mode 100644 crypto/akcipher.c
 create mode 100644 crypto/asn1_decoder.c
 create mode 100644 crypto/asn1_decoder.h
 create mode 100644 include/crypto/akcipher.h
 create mode 100644 tests/bench/benchmark-crypto-akcipher.c
 create mode 100644 tests/bench/test_akcipher_keys.inc
 create mode 100644 tests/unit/test-crypto-akcipher.c

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
