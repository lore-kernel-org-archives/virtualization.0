Return-Path: <SRS0=zhq/=DP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7190BC04EBE
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:31:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D097922227
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayjjUxBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D097922227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34D9C87172;
	Thu,  8 Oct 2020 20:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPEFuTpj8sa7; Thu,  8 Oct 2020 20:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F7CA838BF;
	Thu,  8 Oct 2020 20:31:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D005C07FF;
	Thu,  8 Oct 2020 20:31:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF46AC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D2D598716F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RBBv7Wgw6z02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:31:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 14AD4838BF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602189059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=lgT/Pao2dhRy7r2cOmOSyyn/G9gLMf1e4iWJG7ETJJY=;
 b=ayjjUxBuN2B2tIIrp/xJAD6f0qEvs/yeQEimzQmqC+l6e9cteDpd4tEvDwrwcyxA8M53mJ
 +HuXxJNN/nGXOS1WfbxJPwtEW3q/r92KTu1HKAh7EiOnabHTCuTLXTVpxacyXj81afu1Yl
 g6SziGvdF9a4giFoinwgn6zSucCUxQg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-k04E726LNJGrbR941k_RSw-1; Thu, 08 Oct 2020 16:30:55 -0400
X-MC-Unique: k04E726LNJGrbR941k_RSw-1
Received: by mail-wr1-f72.google.com with SMTP id 47so4311043wrc.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Oct 2020 13:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=lgT/Pao2dhRy7r2cOmOSyyn/G9gLMf1e4iWJG7ETJJY=;
 b=erlHzDz37HgdXhOYEvo7gjot5Fq84A8ufiPHjD77S6NALEmz8HDy9qblvwUFy6QCOw
 fr3lI9Uye211+0lVCuqxEjHi6pqI5ISOx7u6YrEFWVo6h3ySwUr6YVIYxh2r5/cYjoYS
 v8ZBDX14l9av3xaspj6rDNqdF3bDcTKLRJDr7WuN7vSgHW+bJ8RIF3ZIHOeNp68YRSEu
 7jLWev/15nZBm4JT2HoTd+JpMam1cpmF0j7Ygy0rLdXJYaZBdudr7LqVnr/KbbRvJtZm
 3ZOa0vHS0IQKrCRy6aTNHsNDuLIl27bXMfQhlMlAjrQaxbYAt6s8eM2YhlNPX7c6EnRB
 07OQ==
X-Gm-Message-State: AOAM531oIW3ksp7S2SzvkgcSIt/ZUW/Abi+0uZ6gKDzPHxye8B1KJ+fW
 r/qYjVzVazmn+BtPEmsuHLL4iJ7tTJmRvY457ayzt4vRhsBwGFh69nzXuNCHRgYsLG5d5MV5kFh
 0SgasDwu0mkP8o01/zeg75+uRKs9xKcUIDW5NA3EMaA==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr10972362wmj.102.1602189054221; 
 Thu, 08 Oct 2020 13:30:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz39hXz1Of1vVfE+ExLOVbu6aOgDjiquQ4GfgQ/XcsmEw8zvuDHbrPJdW4dVAvGz1TOUqEloQ==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr10972350wmj.102.1602189054015; 
 Thu, 08 Oct 2020 13:30:54 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a81sm9549014wmf.32.2020.10.08.13.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:30:53 -0700 (PDT)
Date: Thu, 8 Oct 2020 16:30:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,vdpa: last minute fixes
Message-ID: <20201008163051-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, si-wei.liu@oracle.com,
 elic@nvidia.com, virtualization@lists.linux-foundation.org,
 michael.christie@oracle.com
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

The following changes since commit a127c5bbb6a8eee851cbdec254424c480b8edd75:

  vhost-vdpa: fix backend feature ioctls (2020-09-24 05:54:36 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to aff90770e54cdb40228f2ab339339e95d0aa0c9a:

  vdpa/mlx5: Fix dependency on MLX5_CORE (2020-10-08 16:02:00 -0400)

----------------------------------------------------------------
vhost,vdpa: last minute fixes

Some last minute fixes. The last two of them haven't been in next but
they do seem kind of obvious, very small and safe, fix bugs reported in
the field, and they are both in a new mlx5 vdpa driver, so it's not like
we can introduce regressions.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Fix dependency on MLX5_CORE

Greg Kurz (3):
      vhost: Don't call access_ok() when using IOTLB
      vhost: Use vhost_get_used_size() in vhost_vring_set_addr()
      vhost: Don't call log_access_ok() when using IOTLB

Mike Christie (1):
      vhost vdpa: fix vhost_vdpa_open error handling

Si-Wei Liu (3):
      vhost-vdpa: fix vhost_vdpa_map() on error condition
      vhost-vdpa: fix page pinning leakage in error path
      vdpa/mlx5: should keep avail_index despite device status

 drivers/vdpa/Kconfig              |   7 +--
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  20 ++++--
 drivers/vhost/vdpa.c              | 127 +++++++++++++++++++++++---------------
 drivers/vhost/vhost.c             |  33 +++++++---
 4 files changed, 117 insertions(+), 70 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
