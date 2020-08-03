Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC80FC433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC14322C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw0uekAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC14322C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 516108778F;
	Mon,  3 Aug 2020 20:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B89RmmTz6jFT; Mon,  3 Aug 2020 20:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 501598776C;
	Mon,  3 Aug 2020 20:58:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3706CC0050;
	Mon,  3 Aug 2020 20:58:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AEDFC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 752012048D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kZcbQfDp5Kh5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 00B942041B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=T01zlXdVAdfOQiZawGmFzoRF7DScTQR3FGD2nDiB9KQ=;
 b=Iw0uekARJQG6qzcKhXMVsPortb+AMGmGmDL2rymc+rFf5CVDY14Y9FEUthte80MRFZSThC
 aKULrVT9gTmTVHx3eKL/1C75auq5lIH6uipktqyDVkLGivGPkLccXLgN0gK7j+8rW1Rgia
 5oc0A0F6WK6idUlXV8HeDCda2Pg/huE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-D_00_IK7P-mNSuvihecF8A-1; Mon, 03 Aug 2020 16:58:38 -0400
X-MC-Unique: D_00_IK7P-mNSuvihecF8A-1
Received: by mail-qv1-f72.google.com with SMTP id p15so13847773qvv.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=T01zlXdVAdfOQiZawGmFzoRF7DScTQR3FGD2nDiB9KQ=;
 b=q/sRkGaIlu5XH0mWsCRllTnzfsHvFXOILoxcyF2cJ4iuBgQUS84gCj4I6sSijoOCbl
 6IHE5sV2FYulqfqtzW46Di71kxZCVM06+q3evz9lTF7dCa6Husm+/4yHqBGDqWeHN/m7
 5d3QxRHzbgLdPu/BUKR4SxttLJ4fz1PxrKWxp/nEULqVwR+tn7do95usvhSLskiO/f/z
 d0Q4aO6OQy70pmMX5MaaFWEaWMNj3/8Yld66A45Au72zVPU0C0t98CPXpQ1J4dvx+PY9
 57+WX7SoHkY0bMXiHAGfdtXacr0zHoRy4r4KomYY1wqrzWN8J7GiiDEcm5yjGHdNTfDe
 xfSg==
X-Gm-Message-State: AOAM530HBcqWdkL9wxynhKcMnKNO65TrSgkgfgZJbYrkBIE1+POcnLpX
 C65hcc6M6QPwly1iHlakATckfIdYLATCEKiLphHkQcEWXjXtm2PMMBdmcY1cle4y9PU25XJonv5
 SS4Ki6OVcaTmwSrZgv+ZOr3AN6gpq1Wyjzs02P+3FPg==
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr18342395qtv.273.1596488317550; 
 Mon, 03 Aug 2020 13:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvO+j2uYhARxvEky6htFfOz+rIDCcYIBBFGBoTihj8mAdmwv6DmYgMv6QBYcyxVH2Z+pUung==
X-Received: by 2002:ac8:7c97:: with SMTP id y23mr18342383qtv.273.1596488317312; 
 Mon, 03 Aug 2020 13:58:37 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id g4sm21056476qtp.89.2020.08.03.13.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:58:36 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/24] virtio: config space endian-ness cleanup
Message-ID: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Config space endian-ness is currently a mess: fields are
not tagged with the correct endian-ness so it's easy
to make mistakes like instanciating config space in
native endian-ness.

The following patches adding sparse tagging are currently in my tree.
Lightly tested.

As a follow-up, I plan to add new APIs that handle modern config space
in a more efficient way (bypassing the version check).

That is still TBD.

I also start with a version using gcc extensions, then switch
to _Generic. This is helpful for backports to older kernels/older
distros: _Generic patch can just be skipped.

Michael S. Tsirkin (24):
  virtio_balloon: fix sparse warning
  virtio_ring: sparse warning fixup
  virtio: allow __virtioXX, __leXX in config space
  virtio_9p: correct tags for config space fields
  virtio_balloon: correct tags for config space fields
  virtio_blk: correct tags for config space fields
  virtio_console: correct tags for config space fields
  virtio_crypto: correct tags for config space fields
  virtio_fs: correct tags for config space fields
  virtio_gpu: correct tags for config space fields
  virtio_input: correct tags for config space fields
  virtio_iommu: correct tags for config space fields
  virtio_mem: correct tags for config space fields
  virtio_net: correct tags for config space fields
  virtio_pmem: correct tags for config space fields
  virtio_scsi: correct tags for config space fields
  virtio_config: disallow native type fields
  mlxbf-tmfifo: sparse tags for config access
  vdpa: make sure set_features in invoked for legacy
  vhost/vdpa: switch to new helpers
  virtio_vdpa: legacy features handling
  vdpa_sim: fix endian-ness of config space
  virtio_config: cread/write cleanup
  virtio_config: rewrite using _Generic

 drivers/platform/mellanox/mlxbf-tmfifo.c |  13 +-
 drivers/scsi/virtio_scsi.c               |   4 +-
 drivers/vdpa/vdpa.c                      |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  31 ++++-
 drivers/vhost/vdpa.c                     |   8 +-
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_vdpa.c             |   9 +-
 include/linux/vdpa.h                     |  34 +++++
 include/linux/virtio_config.h            | 159 ++++++++++++++---------
 include/linux/virtio_ring.h              |  19 ++-
 include/uapi/linux/virtio_9p.h           |   4 +-
 include/uapi/linux/virtio_balloon.h      |  10 +-
 include/uapi/linux/virtio_blk.h          |  26 ++--
 include/uapi/linux/virtio_console.h      |   8 +-
 include/uapi/linux/virtio_crypto.h       |  26 ++--
 include/uapi/linux/virtio_fs.h           |   2 +-
 include/uapi/linux/virtio_gpu.h          |   8 +-
 include/uapi/linux/virtio_input.h        |  18 +--
 include/uapi/linux/virtio_iommu.h        |  12 +-
 include/uapi/linux/virtio_mem.h          |  14 +-
 include/uapi/linux/virtio_net.h          |   8 +-
 include/uapi/linux/virtio_pmem.h         |   4 +-
 include/uapi/linux/virtio_scsi.h         |  20 +--
 23 files changed, 270 insertions(+), 170 deletions(-)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
