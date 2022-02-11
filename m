Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2088C433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E469400FB;
	Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KNghI72nezT; Fri, 11 Feb 2022 08:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9722400E6;
	Fri, 11 Feb 2022 08:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 998D9C001A;
	Fri, 11 Feb 2022 08:42:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C93AC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DA00827A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svrgSnV0O8yw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA49F8272D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:38 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id u16so9327802pfg.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 00:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HXaTm9zy9W/Fk6sBxh9XpKvs2j0diA8uf4CSWloZl88=;
 b=ZtNN+pwUXhbiBI06+s9oYlR4i6za0OUa9R7GlHnn+4GqxABwPRVmaRF5ri+9lXYJPK
 HLyHzYTxO7EHc2mOcMvsZ34WU71pUl7982FTqWh4jttvulqlX3xzyAZkgvO0uUDILprP
 xAEntQJvx0jfHHaPZhafWF2DmrIW1fD8NUPWmYXf2OmkE4sLtEpIYXlMbe10kb7OoEwO
 TfeMk3tjDlAzEl5DLz9lInToE36S5+UfjpkLoOYfcrZ/ehwM/HQtuFX/Bjhd6tcbMu0+
 jKhheTqY6O9ApVLimMn///QayiwA08eEZOwVZ9BiryCZw8+abHDQIfbHW70ywoF2EKeC
 a09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HXaTm9zy9W/Fk6sBxh9XpKvs2j0diA8uf4CSWloZl88=;
 b=iDI6J5AkggBzScn/gWrZuUwRksxxzowk33bT4keh9/vZC+Ux4xFD10joolR/lzAmwp
 DgFWjkGSRKUIh3z5qHcSwRZjhgdCpmee8345jQ7572mULuQGC6TTgZl+Ce4YOdDtRdTv
 g3xxhqJDtL8SrWlrav8DpfDDuWj7yL01CdmD3pwOrU1StoG7/jrNQmCHNr7I1CfiiLm5
 da+7dP/Jo1gLkfdjMsLyV8PAsjSU797RSiliJ5qJ9hVnGMXIBrB53STXAkTIwrgOIMju
 dv5buO5dEsCmwInY87vB8ZRBOeShnEJGfHh8LVMyrfJ5VWwVmhPbQmQG9lAz2UUuy5TT
 0OVw==
X-Gm-Message-State: AOAM532WmtpC6DWi+YxuS4Kxii70BvBhQGuOdeBDLs+Bc9GigyXm8/dc
 97kyMJWiNxL2tGKTwJCM35W6Kw==
X-Google-Smtp-Source: ABdhPJzteqwv0pPYrb+FP+UMxU2H2Cxr4mmWBjR561lIMjdAoQSPgdgi2I6VDtwQVm5+Fr4/fkpeZg==
X-Received: by 2002:a63:8543:: with SMTP id u64mr463644pgd.624.1644568957934; 
 Fri, 11 Feb 2022 00:42:37 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id p21sm13368481pfo.97.2022.02.11.00.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 00:42:37 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 0/3] Introduce akcipher service for virtio-crypto
Date: Fri, 11 Feb 2022 16:41:05 +0800
Message-Id: <20220211084108.1254218-1-pizhenwei@bytedance.com>
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

v1 -> v2:
- Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
- Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
   struct virtio_crypto_config directly without size change.
- Add padding in struct virtio_crypto_ecdsa_session_para to keep
   64-bit alignment.
- Remove irrelevant change by code format alignment.

- Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.

- Test with QEMU(patched by the v2 version), works fine.

v1:
- Introduce akcipher service, implement RSA algorithm, and a minor fix.

zhenwei pi (3):
  virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
  virtio-crypto: introduce akcipher service
  virtio-crypto: implement RSA algorithm

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
 include/uapi/linux/virtio_crypto.h            |  82 ++-
 6 files changed, 685 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
