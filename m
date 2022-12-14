Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BEBC4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 16:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0F0D81E9B;
	Wed, 14 Dec 2022 16:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0F0D81E9B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+qT101C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1L_Qhnz94Uqy; Wed, 14 Dec 2022 16:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B61A81EF2;
	Wed, 14 Dec 2022 16:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B61A81EF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 251F7C0033;
	Wed, 14 Dec 2022 16:30:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77FDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6060181E9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6060181E9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xs1Y6frR7G6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60E3E80C52
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60E3E80C52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671035431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MvzKkMsF15Ii2v8T6zm7fsybd7ToFL1MzDuE6XhV9TM=;
 b=V+qT101Cch3PYQ3AfepLCnAGvWi20veldxUwzMFigTJNLsR4iE9OJaWByy8PFZxd4lNjdt
 lFUDZ5cSR5hip/uNoxNkRXPe9s4BS9Ix/Eio6h/AdXSOHJ7Bl2mfrjOH0nRphALRw7CGHy
 +lkuMm1FGdlVCYW+5PjtOnWr0noh/yw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-vflC0dhxMhCtT1GqpAvvVw-1; Wed, 14 Dec 2022 11:30:30 -0500
X-MC-Unique: vflC0dhxMhCtT1GqpAvvVw-1
Received: by mail-wm1-f70.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so7420246wme.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvzKkMsF15Ii2v8T6zm7fsybd7ToFL1MzDuE6XhV9TM=;
 b=B6r5bMZVJo7pzmfFJXaQvy3p0kHv1dl/9P8bwwX+9xSOFIeWLn0gJvAqfEP2D+I3bz
 Z9C3mPIl1EsD/iEO79+/6YuVUIPeLcAq7vscob20MU8gtw8ffMRXqmkZcT9s3wEe+Muu
 5iO37/1nJmI7RflEkroh9lPk4iqBPXpw1eWuAc4/XLA2CBeOaSuIteE8cVHpU4vmHbbK
 YzkWe4OEKWsAVf65LsAcgdVOR5exY3Ri46nxQVX0EeFOxiKBinNFIsbCz0kYaeqkZXHg
 l0xGFL1QtHA+7D+aq1NlkK8GD1ZclamcvhFDj0m4vCMN01kGBe1kogum8qaSuJHC/deZ
 J7WA==
X-Gm-Message-State: ANoB5pnNVfaQs5ZV4ZUor1DxUuwmFAZsOTWcCMQUZmLOt3mbf1WBo/1Q
 FzEcdSyry3Pyh/3oHtiYxlzGdn5zvUZpx08xJYn2xiBObJjzAp7/dECNkLhSdUUYjnAu4BoWDaJ
 TB43YbJmt/QvTm02Q2dY8/Mi1yPkV/yXx2DPCy80us0sbOb5ax3PgAVtzvUK7hOvh0TiAfd5vJy
 MTnxWC1ugHdegmqYqj/w==
X-Received: by 2002:a5d:470a:0:b0:242:d4f:96c with SMTP id
 y10-20020a5d470a000000b002420d4f096cmr15025779wrq.0.1671035428474; 
 Wed, 14 Dec 2022 08:30:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4GfaS136t9dUD0TzONcVTtwml5/pPsXD/CEUDFgE57pufF23Sy+4PdxYOWCLOsS1OfTnwS5w==
X-Received: by 2002:a5d:470a:0:b0:242:d4f:96c with SMTP id
 y10-20020a5d470a000000b002420d4f096cmr15025759wrq.0.1671035428229; 
 Wed, 14 Dec 2022 08:30:28 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 e17-20020adffd11000000b002422816aa25sm3791759wrr.108.2022.12.14.08.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 08:30:27 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/6] vdpa_sim: add support for user VA
Date: Wed, 14 Dec 2022 17:30:19 +0100
Message-Id: <20221214163025.103075-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

This series adds support for the use of user virtual addresses in the
vDPA simulator devices.

The main reason for this change is to lift the pinning of all guest memory.
Especially with virtio devices implemented in software.

The next step would be to generalize the code in vdpa-sim to allow the
implementation of in-kernel software devices. Similar to vhost, but using vDPA
so we can reuse the same software stack (e.g. in QEMU) for both HW and SW
devices.

For example, we have never merged vhost-blk, and lately there has been interest.
So it would be nice to do it directly with vDPA to reuse the same code in the
VMM for both HW and SW vDPA block devices.

The main problem (addressed by this series) was due to the pinning of all
guest memory, which thus prevented the overcommit of guest memory.

There are still some TODOs to be fixed, but I would like to have your feedback
on this RFC.

Thanks,
Stefano

Note: this series is based on Linux v6.1 + couple of fixes (that I needed to
run libblkio tests) already posted but not yet merged.

Tree available here: https://gitlab.com/sgarzarella/linux/-/tree/vdpa-sim-use-va

Stefano Garzarella (6):
  vdpa: add bind_mm callback
  vhost-vdpa: use bind_mm device callback
  vringh: support VA with iotlb
  vdpa_sim: make devices agnostic for work management
  vdpa_sim: use kthread worker
  vdpa_sim: add support for user VA

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   7 +-
 include/linux/vdpa.h                 |   8 +
 include/linux/vringh.h               |   5 +-
 drivers/vdpa/mlx5/core/resources.c   |   3 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 132 +++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   6 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   6 +-
 drivers/vhost/vdpa.c                 |  22 +++
 drivers/vhost/vringh.c               | 250 +++++++++++++++++++++------
 10 files changed, 370 insertions(+), 71 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
