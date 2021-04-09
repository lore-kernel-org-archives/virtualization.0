Return-Path: <SRS0=E6mM=JG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD3C433ED
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:48:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE596610CC
	for <virtualization@archiver.kernel.org>; Fri,  9 Apr 2021 16:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE596610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77B78402E3;
	Fri,  9 Apr 2021 16:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X1tfRcMJUocd; Fri,  9 Apr 2021 16:48:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16274402C6;
	Fri,  9 Apr 2021 16:48:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE18FC000B;
	Fri,  9 Apr 2021 16:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE0CAC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3FA6402F3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yspWR3qZIvI
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:48:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 693A3402C6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617986902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Chg6IKEuKKojYi7mhUKaMLERMRmxIjzmO/LXSZ+TUHU=;
 b=WE8yyCMnzFRiUCyrXjQmd2y/SFQuk0410KgVwtGc2o4yLRUDXkWPdp/1KlU6ZQaszgf3U1
 utOzKT35fHqb6IG91aMysACGLbVR3/YTePzUez1gCJGcpW7KzASAQw0K/eLrjiumxNGd39
 QMEQcqh4U0AEb6WU8b85bbzYlPMxHGw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-tCjbWKbmMLWDvcR-XgFu8A-1; Fri, 09 Apr 2021 12:48:20 -0400
X-MC-Unique: tCjbWKbmMLWDvcR-XgFu8A-1
Received: by mail-wr1-f69.google.com with SMTP id 75so2535736wrl.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Apr 2021 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Chg6IKEuKKojYi7mhUKaMLERMRmxIjzmO/LXSZ+TUHU=;
 b=BJQS8TTzbeKwlJguP1uewgT0nlvjySdgb68tsNSMItUfHTu8xJJXVXi25xsI0xR+Qt
 gA6TXEI3bAEd8z/hbS1odMuElcNSuKa2A/Srkt9q3HJwkSCPgdoIo9PRWPL7D+i0qNjw
 Q4Au4KD4/087YhSpAv+I6NtSOkiWNCjNLI/5IwYBcY2kk3uGGJdqS3KSQOb43yNeh55L
 Jixo9Vds8SOiQ7yX1/F/8EPMa4ebi9kJOmGQBE4tUGpFVceIO5ms3DiITbuXIVZqli2Y
 m8YS+FDh/KFtKG8w7xUUs1sqzfPT0x9DC+E2gyZZlzL5wz+/eiwyPL8NH3pLfti/N79l
 h/BA==
X-Gm-Message-State: AOAM533ZqHSBAo0rc/0qrF7d1biHzdfnXUgjbqspulWnKLJ1GxeugBNm
 eBnFYu6EaEkqRW+PBZkwulYwmJ4nsbEnhzLI+tTf2h7y38TlCN6VJ5nIWg/CGU9ZyZz72ud6Igx
 gOV3IEyJHC6CmKl3zASF3uQQY2s1ZoNqo2CrZZ5M1FA==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr7681448wme.7.1617986899514;
 Fri, 09 Apr 2021 09:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2SClI5Njn6xjA2MPYxm2kpYJCEchwrX/9+aQChXy3FOe+I3afHnDGXz6jYj0V+5m4e1Tm6w==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr7681431wme.7.1617986899273;
 Fri, 09 Apr 2021 09:48:19 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id o25sm6618101wmh.1.2021.04.09.09.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 09:48:18 -0700 (PDT)
Date: Fri, 9 Apr 2021 12:48:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vdpa/mlx5: last minute fixes
Message-ID: <20210409124816-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 si-wei.liu@oracle.com, elic@nvidia.com
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

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bc04d93ea30a0a8eb2a2648b848cef35d1f6f798:

  vdpa/mlx5: Fix suspend/resume index restoration (2021-04-09 12:08:28 -0400)

----------------------------------------------------------------
vdpa/mlx5: last minute fixes

These all look like something we are better off having
than not ...

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (4):
      vdpa/mlx5: Use the correct dma device when registering memory
      vdpa/mlx5: Retrieve BAR address suitable any function
      vdpa/mlx5: Fix wrong use of bit numbers
      vdpa/mlx5: Fix suspend/resume index restoration

Si-Wei Liu (1):
      vdpa/mlx5: should exclude header length and fcs from mtu

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++++
 drivers/vdpa/mlx5/core/mr.c        |  9 +++++++--
 drivers/vdpa/mlx5/core/resources.c |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 40 +++++++++++++++++++++++---------------
 4 files changed, 37 insertions(+), 19 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
