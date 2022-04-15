Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976AFC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 06:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27942610AB;
	Fri, 15 Apr 2022 06:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfKfAQSpE4L5; Fri, 15 Apr 2022 06:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B82561047;
	Fri, 15 Apr 2022 06:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59DC6C002F;
	Fri, 15 Apr 2022 06:45:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC01C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11E2484113
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbLoqT3Qxhm0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54967840F0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:14 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id ll10so6979192pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ldV1uCjsScyMqnX29S2Mnzm56eDt6Wx9wkmuB11hEfM=;
 b=rDb8Gh4XiSJ5bCNnQ/GtnJIzx5ChDSHZ4lV22jBcV+F9GyJoIkOE+UWgey1kEpy0gI
 MTKaFOriP4KbyNke3RHlowF7AzZ8vUNcqA+TwvlHlayovLLg57TbgJXaNYd9fpE64GSZ
 ABXn/A0Tx029H5JDtT1XMYUFDzq0jEaK9jWxYNCherEopNOslLePPx/F+lrjS9pBVK/A
 9dpWjF77ljcGRCaQK7cvGyxJE/KLO5/lQq2+8MwZm4Q9PnjS1vEyAdD7UlP5UuCfx7RW
 f+X1YiQzmVoG1vIaEQcymb5C98hqfNYIoFZUyzS8Jq2XoPr8jS+wGPmsTLuYAXyggK+m
 Ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ldV1uCjsScyMqnX29S2Mnzm56eDt6Wx9wkmuB11hEfM=;
 b=1BluUCQ4m/SfIDdVm4x8KQv9tdsrUmr4Cfs++K9Ci0nfaIhWhM9BvU7APJTTdK44U6
 3Y09bM+tAgEPG4cGbajuIkw8rGNGPtvP3Ix6ACjl4W64qOD6/lT1nV9pSnAVI1jat2Va
 xDhUZU1O3W1wSUNQeYQqKzaz76/umZ60lOYBhcGxTMBW24LlwrE5QsFKugiBBIOJ/Bwn
 mwDIbX6icRHIFv7VQaMWIz0aBX733pn1ZktEgirI4bh3oyp79EPKQFO3Y2UMS2S0iZNQ
 UvxPAASH7vOZ0JdTeSSQShp3FM2V+nUx8yH3lpn//klDzz51I+RLO5ZkqX2oWq+1Z9Sz
 akFA==
X-Gm-Message-State: AOAM533kLBUlKmJACqrkc75XhWNfRjWEp2s3q2XriOA3csZDDugKVBiS
 3C50JlcxcPSWZ2L5hf565AvbE/pHhqiIrw==
X-Google-Smtp-Source: ABdhPJyBEsq9NBxcUGHmvrk5wwfGZRmZAh1nf0tDGbK7Ic0lp5x83dUfzjLylmDxDhgTYThkApUAEw==
X-Received: by 2002:a17:902:9309:b0:156:983d:2193 with SMTP id
 bc9-20020a170902930900b00156983d2193mr49846482plb.158.1650005113570; 
 Thu, 14 Apr 2022 23:45:13 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 23:45:12 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH 0/4] virtio-crypto: Improve performance
Date: Fri, 15 Apr 2022 14:41:32 +0800
Message-Id: <20220415064136.304661-1-pizhenwei@bytedance.com>
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

Hi,

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
 .../virtio/virtio_crypto_akcipher_algs.c      |  92 ++++++------
 drivers/crypto/virtio/virtio_crypto_common.c  |  92 ++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |  25 +++-
 drivers/crypto/virtio/virtio_crypto_core.c    |  37 +----
 .../virtio/virtio_crypto_skcipher_algs.c      | 134 ++++++++----------
 6 files changed, 222 insertions(+), 159 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
