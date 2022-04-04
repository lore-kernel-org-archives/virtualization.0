Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD4DC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Apr 2022 10:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23555401ED;
	Mon,  4 Apr 2022 10:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5a9j7fG5aqY; Mon,  4 Apr 2022 10:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8556140255;
	Mon,  4 Apr 2022 10:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54E90C001D;
	Mon,  4 Apr 2022 10:31:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05F7C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3792827A8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZVb-vqGedko
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:31:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF73F824DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649068295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZAR73l9+1WOyYLU1N4aBZq/AhW2TiRjp9zjhr1hdpGk=;
 b=PvHUQPBsl7DhbZrokCtS9UwpsJaogg23HPotYB/k2c9KO7xqsEq/XhqlDHW9uZS5H2DMXE
 VX7D3P9JJb+21R1Zd+Ii+eo8eArdhuWqwmfNlabiRKRUMRYAxyEAgyWBjEeg3U4fUf7G3H
 l/L/NVd2PrKYlqp2Te9pu9risDM8yms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-71ER87IePlyj3CYpybBVmg-1; Mon, 04 Apr 2022 06:31:34 -0400
X-MC-Unique: 71ER87IePlyj3CYpybBVmg-1
Received: by mail-wm1-f72.google.com with SMTP id
 x8-20020a7bc768000000b0038e73173886so983768wmk.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 03:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ZAR73l9+1WOyYLU1N4aBZq/AhW2TiRjp9zjhr1hdpGk=;
 b=b5Hfcxn7w/tipYTNFhTnBj2FZZpJYEC34feSSjQD9LElB/aKJDpepzOjvyuFRhiERr
 VttK77c89vwd8hvazk2oTmlW9IrdwQZrJtGj+dh9Z+KedFELw/tzSEnl3WTgf3+g8NwX
 3GBVadJRWA9tJVWwDZA0wRuNJx08Qlk7MoN1ofy1MLekmjQ2gGpaDSAcUJgUJZRPk7hg
 xZOXz5ySvaNQA9SmwNrbBXidWew03voSJW+B2HRxyqdb5vWlC++oDofiXF1frdXR8pEL
 YFSfWqLAr9xtBCnuuVyNrJpG356ZwRf6ssNQb1Xq2xiGjBiOuiEW4HT5k602ZXuqhISB
 YY7Q==
X-Gm-Message-State: AOAM531Rj0fyKKRLppKSapmCTe9SKyvRQakdScvRZWra46qnwruvUC1Y
 vMYmFveeo72O9EVPUqgrsL9n43XDCLzBC6aDLsiQUcwVNIIXra8srodO4QZtRUj6zK1Z5NEF/Za
 aOM8IhWovyzemUQBfP7bwjDSaNyVblpGZUcsbc8ju0A==
X-Received: by 2002:a5d:6944:0:b0:203:e024:7cdd with SMTP id
 r4-20020a5d6944000000b00203e0247cddmr16372271wrw.503.1649068293060; 
 Mon, 04 Apr 2022 03:31:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhH6jXXCNsS0CDc1GvA4tUCvtOnZ01cqJiOcI9JEogzYD5ay3XT2i7n/tCqJgUrwWPwTT6jQ==
X-Received: by 2002:a5d:6944:0:b0:203:e024:7cdd with SMTP id
 r4-20020a5d6944000000b00203e0247cddmr16372254wrw.503.1649068292813; 
 Mon, 04 Apr 2022 03:31:32 -0700 (PDT)
Received: from redhat.com ([2.54.40.213]) by smtp.gmail.com with ESMTPSA id
 p14-20020a05600c1d8e00b0038dbb5ecc8asm9289654wms.2.2022.04.04.03.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 03:31:32 -0700 (PDT)
Date: Mon, 4 Apr 2022 06:31:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: fixes, cleanups
Message-ID: <20220404063128-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

The following changes since commit ad6dc1daaf29f97f23cc810d60ee01c0e83f4c6b:

  vdpa/mlx5: Avoid processing works if workqueue was destroyed (2022-03-28 16:54:30 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1c80cf031e0204fde471558ee40183695773ce13:

  vdpa: mlx5: synchronize driver status with CVQ (2022-03-30 04:18:14 -0400)

----------------------------------------------------------------
virtio: fixes, cleanups

A couple of mlx5 fixes related to cvq
A couple of reverts dropping useless code (code that used it got reverted
earlier)

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (2):
      vdpa: mlx5: prevent cvq work from hogging CPU
      vdpa: mlx5: synchronize driver status with CVQ

Michael S. Tsirkin (2):
      Revert "virtio: use virtio_device_ready() in virtio_device_restore()"
      Revert "virtio_config: introduce a new .enable_cbs method"

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 62 ++++++++++++++++++++++++++-------------
 drivers/virtio/virtio.c           |  5 ++--
 include/linux/virtio_config.h     |  6 ----
 3 files changed, 43 insertions(+), 30 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
