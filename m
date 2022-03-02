Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C790C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 03:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2595D827D2;
	Wed,  2 Mar 2022 03:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIgsR6Ib81nU; Wed,  2 Mar 2022 03:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B86D827C5;
	Wed,  2 Mar 2022 03:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59463C0012;
	Wed,  2 Mar 2022 03:42:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D75EC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7A904157E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vG7mYDax4uJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0116E41578
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:20 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 c16-20020a17090aa61000b001befad2bfaaso168212pjq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 19:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UaKbUMAikoW+2CrT8M+EU3vclV/Hjqlxq8ONhSLeM1E=;
 b=2D4/T939Evpeki/nJ0chs+tQeIyQU/+z6U7Q3rDEcdOMLd5GtBzsn1fHAcLgpJbrb4
 Rx8Ci27MxIkvcUIeZUaLiXekDlZn36VK4l1GnjZWzTlaYRmwyYlO4roWuOpnWZ/TJoZd
 89f8ABoy080TOlgAchfJvRhoi4N1welgpRu801mxdptlmyfEl5c4O+7JG89L8JHb6ytc
 AOJeSBGCB1vOm+XBSh+Gz9GBYa2/7aKJnpDiNQR7T/q0pWqX3vAdsJi0ho9m2bFCOPrL
 t41JeeeAM+/xwt9a3da6oe0cVG0LmGrSUj+M/+4VKPROACsOb+ZJSXecV4F5QEZ1E5nf
 9qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UaKbUMAikoW+2CrT8M+EU3vclV/Hjqlxq8ONhSLeM1E=;
 b=i8qQxf2bg0Ss6KMBGX9MmdFAnvmw6jvTlYSbPSsz75mCxx9fNVqtd+4yhveKD1q3y0
 n0Vlpi1AxiBVJCTN15NvHjgz4QquY6Rrh3sFc/e5kl1FMYl9ORZ5E4+4Z5etAKBuPPjM
 nPTvO8G9i8glFEJP1FGRH1URbkEX7KMgXM25OakhCcOcMLZOlaSPWPKpOzd7eHjZixxU
 OzUpz6AN6W+b4wdb2EI+18X1pFA9qgXZ1XiW5E66oRluMXBzlP7ZNf3Aw2mMlPqafL1D
 GY+gGou1s277Pq9wZROv5AY81Xje04WcvRkJP7+NVewiCNOYNox2s+9QmGhucyxDyuvY
 Eb5Q==
X-Gm-Message-State: AOAM5301hCnqYqAU0IBAkZ8R2ZWc5//DzpYf9ldh7WgHf6LkFqf0/DkB
 W5k2jU7yEavjS60eVzWMUjfocw==
X-Google-Smtp-Source: ABdhPJwgSX9MeLbuWXyzeWaVSztTZEp+pZTmnRRuCS08oSrYYEhSHkPNhNG8Jj3zmd9wQ+Lw+Z5/1g==
X-Received: by 2002:a17:902:8e82:b0:151:6f68:7088 with SMTP id
 bg2-20020a1709028e8200b001516f687088mr11139235plb.11.1646192540121; 
 Tue, 01 Mar 2022 19:42:20 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 19:42:19 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Date: Wed,  2 Mar 2022 11:39:13 +0800
Message-Id: <20220302033917.1295334-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

v2 -> v3:
  Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
    minor changes of function name.
  Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
    buffer if opcode is verify.

v1 -> v2:
  Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
  Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
    struct virtio_crypto_config directly without size change.
  Add padding in struct virtio_crypto_ecdsa_session_para to keep
    64-bit alignment.
  Remove irrelevant change by code format alignment.

  Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.

  Test with QEMU(patched by the v2 version), works fine.

v1:
  Introduce akcipher service, implement RSA algorithm, and a minor fix.

zhenwei pi (4):
  virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
  virtio-crypto: introduce akcipher service
  virtio-crypto: implement RSA algorithm
  virtio-crypto: rename skcipher algs

 drivers/crypto/virtio/Makefile                |   3 +-
 .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
 ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
 include/uapi/linux/virtio_crypto.h            |  82 ++-
 7 files changed, 693 insertions(+), 9 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
 rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
