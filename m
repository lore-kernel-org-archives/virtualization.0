Return-Path: <SRS0=LX+m=EG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F2C55179
	for <virtualization@archiver.kernel.org>; Sat, 31 Oct 2020 19:59:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B696206E9
	for <virtualization@archiver.kernel.org>; Sat, 31 Oct 2020 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeqpussU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B696206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4604B8605E;
	Sat, 31 Oct 2020 19:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFhWbqyx-yMs; Sat, 31 Oct 2020 19:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23AAC85FCB;
	Sat, 31 Oct 2020 19:59:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2CFEC088B;
	Sat, 31 Oct 2020 19:59:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA44C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 91B372A0D9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mz8GwWEVIRVO
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C0891276D4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604174388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=R4s3Ix2b8SBi7OwErNBrHppcL00yyDMg5NuRWIfw+hI=;
 b=GeqpussUDM+VcaCJjeUNb/fJhphNF7ORkOdq8dbnCAfoJETXrGflAsmuMOaO6W6MzYskKm
 3oQStg9gbqaqU8D6qFVdohVIKEXgKPjbql8QUwmyhx+EOIj0NQ5kceSWL0YZOCFdAwCcDf
 G3g6LDuwooxq6AAo8xcbXoh54pYeeq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-o9Jr2nWHNlW3IP6SFQpQ9Q-1; Sat, 31 Oct 2020 15:59:45 -0400
X-MC-Unique: o9Jr2nWHNlW3IP6SFQpQ9Q-1
Received: by mail-wr1-f69.google.com with SMTP id j15so4336931wrd.16
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 12:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=R4s3Ix2b8SBi7OwErNBrHppcL00yyDMg5NuRWIfw+hI=;
 b=EMqCtKRsWiv67/y1+5Duf5YBuelYvSWfBO/nzshaBxpwA/4nNTEgA40tLdW1Dsd7pD
 kgThPTLINLWsrZeRg7iHdRwzff7Eh8LiOwR87hki6KVmQbKAZ20wvIYRhChVhwF5xii+
 tO/M6mx5czdo5GLJxapJuhg5Oj0Rs/mSnajNuTt8McVLqzYBCegSzg7U1DTsQ5scjAYm
 v2sueTyp4IjXXO0692e67biEQPpG6W9YAQGn6RRiyrlIte7Ri5hlqF1bUCK3EGVYdvn6
 EhQuzwtTCgMfnyeN8Ct6xNnxqbJzCHDAiKphFZcZB5emJf4NAa/mlQoWixTUGFEUeQYI
 BtKA==
X-Gm-Message-State: AOAM5338KGFbJ2c9K8nrflAtXZi4EtLuxjT5KG1BxweXsWkXi2dCAI0V
 pla5uNEbKWT3ObCCnAAI6Ht0b07Li24bGHmJtUqA1k9jWHk5jNmNoFzxmg/OlXCFDT51vxI3n/Q
 mehmouyzbZJ9pig6I06n5JvzDkPmBuIlXmDjVuhSE4A==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9643499wmc.42.1604174384685;
 Sat, 31 Oct 2020 12:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzzGUw3AXT6Lwe9xl9B0O7EZNb0u7o6fc3rE2pgvBpY6HuMlhM8rpvMYHBBuwHN4UT+dgoKQ==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9643483wmc.42.1604174384498;
 Sat, 31 Oct 2020 12:59:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id x18sm16752967wrg.4.2020.10.31.12.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2020 12:59:43 -0700 (PDT)
Date: Sat, 31 Oct 2020 15:59:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,vdpa: fixes
Message-ID: <20201031155940-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elic@nvidia.com,
 jingxiangfeng@huawei.com, lingshan.zhu@intel.com, dan.carpenter@oracle.com
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

The following changes since commit 88a0d60c6445f315fbcfff3db792021bb3a67b28:

  MAINTAINERS: add URL for virtio-mem (2020-10-21 10:48:11 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0c86d774883fa17e7c81b0c8838b88d06c2c911e:

  vdpasim: allow to assign a MAC address (2020-10-30 04:04:35 -0400)

----------------------------------------------------------------
vhost,vdpa: fixes

Fixes all over the place. A new UAPI is borderline: can also be
considered a new feature but also seems to be the only way we could come
up with to fix addressing for userspace - and it seems important to
switch to it now before userspace making assumptions about addressing
ability of devices is set in stone.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (1):
      vhost_vdpa: Return -EFAULT if copy_from_user() fails

Jason Wang (3):
      vdpa: introduce config op to get valid iova range
      vhost: vdpa: report iova range
      vdpa_sim: implement get_iova_range()

Jing Xiangfeng (1):
      vdpa/mlx5: Fix error return in map_direct_mr()

Laurent Vivier (3):
      vdpa_sim: Fix DMA mask
      vdpasim: fix MAC address configuration
      vdpasim: allow to assign a MAC address

Michael S. Tsirkin (1):
      Revert "vhost-vdpa: fix page pinning leakage in error path"

Zhu Lingshan (1):
      vdpa: handle irq bypass register failure case

 drivers/vdpa/mlx5/core/mr.c      |   5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  33 +++++++-
 drivers/vhost/vdpa.c             | 167 ++++++++++++++++++++++-----------------
 include/linux/vdpa.h             |  15 ++++
 include/uapi/linux/vhost.h       |   4 +
 include/uapi/linux/vhost_types.h |   9 +++
 6 files changed, 154 insertions(+), 79 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
