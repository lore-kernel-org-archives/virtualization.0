Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2134C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAF564D74
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAF564D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC5764328B;
	Thu, 18 Mar 2021 18:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfV1atE-kKJd; Thu, 18 Mar 2021 18:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91A84400A4;
	Thu, 18 Mar 2021 18:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 634BDC000A;
	Thu, 18 Mar 2021 18:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECD7AC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC96560633
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3ciCARWgI8b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:11:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFC3E605AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616091104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WP7PnNSr4BR9a1LVBwXMPx5QETfjMgS7zmkwK2xedWo=;
 b=I8OYBoZwrmUp9CTho80ScBkAyz37tj1zcvOzLTDldquIZev9LYH0IJnS04jg58SK5wHBXR
 +wDbfiRKoUTCqRpRDb1NOFjYw1NBf3VbRrHVlxEtrkNcOSA1pwvPHdCwyUaAFmt88udbyi
 MWhGIqhVIjlieS3b42PBKFnye6pm1/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-1h28Fn4hMIqB526dklOLEw-1; Thu, 18 Mar 2021 14:11:42 -0400
X-MC-Unique: 1h28Fn4hMIqB526dklOLEw-1
Received: by mail-wr1-f70.google.com with SMTP id s10so20489882wre.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 11:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=WP7PnNSr4BR9a1LVBwXMPx5QETfjMgS7zmkwK2xedWo=;
 b=rcSrlmaOApUY2vN8zkiciPuMirac7o92Xg8QVys0ZCSCR2fLCPsnLErYQD891jj+cb
 gPkbrlVbtPU86+ciMgDR2YGKaLV6K6pMMlVwCGZ10VR4HkyBk1rA2Ro/fBwTeImtPNil
 JfDBZ3I9/5BOLDdez1hMKMrzJyllTeZRzE7tPVXQhHK/fNji4zUCCTuqQRkouctGXFxq
 kBecoLbz+yXIeTzFKYJgUmB8j6NbW6tFmchi2P7RmhUmGn3xl+Vjh2tM9bL+3IyyO1J1
 phnfLVhbmBlc2ab7IpJmJXL5tEBaI0wVqiTD8z97GQ00VdLUtnjiOpdMceELIHrMshO3
 or3A==
X-Gm-Message-State: AOAM533dZBN4035Ijvak3ZjEzsWPJDCIpqGG45U0bef58shy0XNhUz5c
 Z1g59q5L0kXBlTSRcpBKehNjbyR6bhlfXlvGGawnVHi4Vh9yw+wJvPmPRVz9dZLcojht8zzrIG+
 O7niI7cLJrL1RSauBSkgs+s/fx8KFCWypK5EivqO2zw==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr510506wru.333.1616091099253; 
 Thu, 18 Mar 2021 11:11:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFTfjChgFyUXnBDg4awB1ZFX0fIcyN9S9XgyGks/aa0h+c9tuWlTuolWTJOqxYehca3p6+ug==
X-Received: by 2002:a5d:6810:: with SMTP id w16mr510479wru.333.1616091099081; 
 Thu, 18 Mar 2021 11:11:39 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id s8sm3686155wrn.97.2021.03.18.11.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 11:11:38 -0700 (PDT)
Date: Thu, 18 Mar 2021 14:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20210318141135-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, tangbin@cmss.chinamobile.com, gdawar.xilinx@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xianting_tian@126.com,
 lingshan.zhu@intel.com
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

The following changes since commit 16c10bede8b3d8594279752bf53153491f3f944f:

  virtio-input: add multi-touch support (2021-02-23 07:52:59 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0bde59c1723a29e294765c96dbe5c7fb639c2f96:

  vhost-vdpa: set v->config_ctx to NULL if eventfd_ctx_fdget() fails (2021-03-14 18:10:07 -0400)

----------------------------------------------------------------
virtio: fixes, cleanups

Some fixes and cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gautam Dawar (1):
      vhost_vdpa: fix the missing irq_bypass_unregister_producer() invocation

Jason Wang (1):
      vdpa: set the virtqueue num during register

Laurent Vivier (1):
      vhost: Fix vhost_vq_reset()

Parav Pandit (1):
      vdpa_sim: Skip typecasting from void*

Stefano Garzarella (2):
      vhost-vdpa: fix use-after-free of v->config_ctx
      vhost-vdpa: set v->config_ctx to NULL if eventfd_ctx_fdget() fails

Tang Bin (1):
      virtio-mmio: Use to_virtio_mmio_device() to simply code

Xianting Tian (1):
      virtio: remove export for virtio_config_{enable, disable}

 drivers/vdpa/ifcvf/ifcvf_main.c      |  5 ++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  4 ++--
 drivers/vdpa/vdpa.c                  | 18 ++++++++++--------
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  5 ++---
 drivers/vhost/vdpa.c                 | 20 +++++++++++---------
 drivers/vhost/vhost.c                |  2 +-
 drivers/virtio/virtio.c              |  6 ++----
 drivers/virtio/virtio_mmio.c         |  3 +--
 include/linux/vdpa.h                 | 10 +++++-----
 include/linux/virtio.h               |  2 --
 11 files changed, 37 insertions(+), 40 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
