Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB9C433EF
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 02:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D38A60EA3;
	Fri, 21 Jan 2022 02:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLaULSCEhBM4; Fri, 21 Jan 2022 02:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A525C60EA0;
	Fri, 21 Jan 2022 02:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0FAC0039;
	Fri, 21 Jan 2022 02:25:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5B27C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F31D04056B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sJCbU-nZSRWI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A92CC4014B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:51 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id y27so3417583pfa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 18:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+voPomDve1qXJhFgNfovxhf7gmY1dDR8B+xopqARLyY=;
 b=UubX+tZcZPf+xRM5IS1zf6cFWjDLExzHpy47TQTU53a7DDJ+z7+szHbEi8Kc4JKiDr
 pESA50tf2tHvryDPWX6YJKPyI7jFU5JKjA2MFeX/wwEI6lePBpX3sErdo1NH0iCyFOoQ
 dfN71+F4z9bRbDFkgK77+tryVmB27rBKasejItYIxbaZD7o1I7mAfX/ikFBe8qZnSrL2
 6Zo4pP2mhtPmQSq59RUSdzu7t2styOWR7kzCmaaZGohDinBGVImKDuXpSgkBM4PCasft
 uD2hEapinzSHdsPmyOM9fVhVoAY6ZfaI4o44AHmm84hKkJbR36NGbCUe0ZqC5xlGo+rV
 Cc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+voPomDve1qXJhFgNfovxhf7gmY1dDR8B+xopqARLyY=;
 b=cD5cepNQAe9YtZjfywokiTxtOM0EErvKvhs3bKEJ9FHvxLJV8OQEEOqzEkAher55sb
 DhwFqk6hvKOZjRRjJBneCROIMfbgdBzhO1nn8EGOMWwxnBVchswGWdOW6uP2o0Rk7zaD
 ZnppZ9z5Wj/W1/A/eX3QwDf+El2vb7uFa8s4mj4ndAx/Ezykq6ogiDNqUd/PoGWsmShx
 US/FKYjL/t1jTRkeFrSQI3EKi+3sTAhd2mVu980Gbc4UmPuCVj8mAnLHCEVTqU/IbCrg
 jhl1/vYg45xL5b6xnTwpd473nZMLs48ZEidsWA0LlsKVUn5QkfM9Zp9fxt9Ra3C59WNN
 imYg==
X-Gm-Message-State: AOAM531ibekJfbftEnSfZ1oAvZmd4f3aOoxbqWBXAhtiFTuJchfl9pWo
 6pvhpwg70tQJTke/UfSaWcZvuQ==
X-Google-Smtp-Source: ABdhPJzuqPIc/uwbrarW7/35mk8lweYkpI1GVvOf8Bo6zdOao4Bfeyph3k+rqVP009DK7ztmfllk8A==
X-Received: by 2002:a63:3fc5:: with SMTP id m188mr1339522pga.307.1642731950857; 
 Thu, 20 Jan 2022 18:25:50 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id h2sm5057577pfv.31.2022.01.20.18.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 18:25:50 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Subject: [PATCH 0/3] Introduce akcipher service for virtio-crypto
Date: Fri, 21 Jan 2022 10:24:35 +0800
Message-Id: <20220121022438.1042547-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
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

Introduce akcipher service, implement RSA algorithm, and a minor fix.

zhenwei pi (3):
  virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
  virtio-crypto: introduce akcipher service
  virtio-crypto: implement RSA algorithm

 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
 include/uapi/linux/virtio_crypto.h            |  98 ++-
 6 files changed, 693 insertions(+), 10 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
