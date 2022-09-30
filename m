Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35809C433F5
	for <virtualization@archiver.kernel.org>; Fri, 30 Sep 2022 15:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEB7E8430D;
	Fri, 30 Sep 2022 15:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEB7E8430D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aNA2Nw+o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0EXCm8Vjzv4; Fri, 30 Sep 2022 15:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 416AB84301;
	Fri, 30 Sep 2022 15:59:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 416AB84301
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CA53C0032;
	Fri, 30 Sep 2022 15:59:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91118C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 15:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D6D5611B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 15:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D6D5611B3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aNA2Nw+o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F12vn-Fe4oAc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 15:59:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED78611AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED78611AA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664553579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=s0VdZiYvqssIOHfeT/CymYAuFjYTWH/3Mag29BcynOs=;
 b=aNA2Nw+odSeMwJhvURHsMk2krnNf/xM6GzQfbhT0eNx41TeuYsSPl86SVs3dRv3PXgE4s8
 Kr20FXW9ttv7+FNcJBpwwEgwRhmy2/i0Wnv1N2e80rdYhxu3QhYN36qEeWouvRGLG2+rXj
 TRYP9BgGN+1bPXNMknvPGd0NF5LfzOA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-whGpv2dhNT-MiooIcMxZSw-1; Fri, 30 Sep 2022 11:59:38 -0400
X-MC-Unique: whGpv2dhNT-MiooIcMxZSw-1
Received: by mail-ed1-f72.google.com with SMTP id
 e15-20020a056402190f00b0044f41e776a0so3871501edz.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Sep 2022 08:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=s0VdZiYvqssIOHfeT/CymYAuFjYTWH/3Mag29BcynOs=;
 b=2plrxoIRNmVnU3JIi7/HPwRuoZ4PWAsPrHzJAIuZthDgc0xrH0Ga3JaGdiApU5t7BF
 UQoPEebsJSkdp+Ath9srbRXO82jelD3134ot7Gqowku+POKRxZA5MOzmOCDKhfCDBOfH
 teNAbVh4CzoAf9oYDLwLzMpGCa2gZij4tvmWPH3cPa5JzJgYfmWeAqhfJnYkbHkslSeX
 s3sJwCi5quY+CPcs0A6bUqHaQUMlwqD9D53jjNh1EeE1O7pPUKIM702VbrCs5EYR7H19
 qjRR4gD6JuGobszyBeXxaWh5GgAnuO4QZ4nceD9NcgN+yKl0KxG+mElOyDC+LWPwqnB7
 G2Mw==
X-Gm-Message-State: ACrzQf3GPoWYWnrj/hBHFXqiOFwHHqWR05ZoI5NCnhWz8ZvHuE9ZRTOS
 e5R/QccHyusUTGbBlNNRmfvvpBKC7FzvaxonI8AMbTGVaM64rnw0QeAkBsSoGsb4viQh4aXnP5G
 mrOoZ4U8vj9IPA6ME+yAPLg9Poh77ciDs9VA4/gkA8A==
X-Received: by 2002:a17:907:9714:b0:783:954a:5056 with SMTP id
 jg20-20020a170907971400b00783954a5056mr6907763ejc.318.1664553577054; 
 Fri, 30 Sep 2022 08:59:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7mz4/tv12OGuGnNdRMo9OH788yzGFfKJb5e2fxoM3bB4V0KuNZAwipaE4zg0MStjxYK9tRiA==
X-Received: by 2002:a17:907:9714:b0:783:954a:5056 with SMTP id
 jg20-20020a170907971400b00783954a5056mr6907749ejc.318.1664553576855; 
 Fri, 30 Sep 2022 08:59:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742e:6800:d12a:e12c:77cf:7dd6])
 by smtp.gmail.com with ESMTPSA id
 14-20020a170906328e00b00787a6adab7csm1369697ejw.147.2022.09.30.08.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Sep 2022 08:59:36 -0700 (PDT)
Date: Fri, 30 Sep 2022 11:59:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: fixes
Message-ID: <20220930115933-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, acourbot@chromium.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com, angus.chen@jaguarmicro.com, elic@nvidia.com,
 suwan.kim027@gmail.com, lingshan.zhu@intel.com, helei.sig11@bytedance.com
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

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a43ae8057cc154fd26a3a23c0e8643bef104d995:

  vdpa/mlx5: Fix MQ to support non power of two num queues (2022-09-27 18:32:45 -0400)

----------------------------------------------------------------
virtio: fixes

Some last minute fixes. virtio-blk is the most important one
since it was actually seen in the field, but the rest
of them are small and clearly safe, everything here has
been in next for a while.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Angus Chen (1):
      vdpa/ifcvf: fix the calculation of queuepair

Eli Cohen (1):
      vdpa/mlx5: Fix MQ to support non power of two num queues

Maxime Coquelin (1):
      vduse: prevent uninitialized memory accesses

Suwan Kim (1):
      virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()

Xuan Zhuo (1):
      virtio_test: fixup for vq reset

lei he (1):
      virtio-crypto: fix memory-leak

 drivers/block/virtio_blk.c                          | 11 +++++------
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c |  4 ++++
 drivers/vdpa/ifcvf/ifcvf_base.c                     |  4 ++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c                   | 17 ++++++++++-------
 drivers/vdpa/vdpa_user/vduse_dev.c                  |  9 +++++++--
 tools/virtio/linux/virtio.h                         |  3 +++
 tools/virtio/linux/virtio_config.h                  |  5 +++++
 7 files changed, 36 insertions(+), 17 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
