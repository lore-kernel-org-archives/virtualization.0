Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACB2C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2E54403AC;
	Mon, 15 Aug 2022 21:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2E54403AC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JBTEZefV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v90j4P_6F0cL; Mon, 15 Aug 2022 21:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9E4D40359;
	Mon, 15 Aug 2022 21:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9E4D40359
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF3CFC0033;
	Mon, 15 Aug 2022 21:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01FBFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA7CD817BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA7CD817BD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JBTEZefV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sHp0WDleQuy5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 198D5817B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 198D5817B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=nE9l+oBuuihtRdwrfLYvB+ZfpLg2bb3PcW4cPmCNwqE=;
 b=JBTEZefVZT4fg9yUqgkaktBP+DA2ZEJtqrrIiwST9QKJneZxAI2b7hJugDqzW8yMW6394w
 SrdNo7ZH5Ejm8t6YCD6tJh4MIuX5o2/fHWGURYMUiptbqjiw6JKhICKmi/8+OLxDDRnZA1
 4BM3qXf0kTu5d8ynvm1hvLi5ymV6J2E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-Hsv09KwKMJS4zqVeMtGy5g-1; Mon, 15 Aug 2022 17:53:21 -0400
X-MC-Unique: Hsv09KwKMJS4zqVeMtGy5g-1
Received: by mail-wm1-f72.google.com with SMTP id
 i132-20020a1c3b8a000000b003a537064611so4048113wma.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=nE9l+oBuuihtRdwrfLYvB+ZfpLg2bb3PcW4cPmCNwqE=;
 b=UZ5wrJyo3qrm18boQdeBk2BLdUTVKZtCqCvZMR/VkUHmmg3xPwA4sj2xMUI6bxNH04
 sh9XtsyUfTu3AFpeOBtBypzg/XmosLBih7Xh/CBqos0Z+TnsnlSYHhnKWtrjsMvkXN75
 q/v5U8uvk0YtOogBt/lfD7HlOh2iKj47fwDdgWZJZzHqPy2LyAwNmlxhx9ABSWncAKRE
 iaD2xls9EWgjD0lT/99FubmP5ulJttUaz1hj9fdH6bRPtj3qoKtC6N+Re2I8XzBADldP
 Yj5oeGCbhtuf11o2YegtHMyvvbYFcPSIWhftzy24w/E8QZYEP0hjE6x1cqo9IAsH4fFR
 xokg==
X-Gm-Message-State: ACgBeo2G4UJ8Q6h0uZPcO+hbdPux+Hutx5v1ZoSO8U/9S7udb7Amb8MF
 mexNwBjyCGOqZwMfzsRFQIf9CB2EQEmU/ft/8uWQ5JcFoLzR9XOdbjQBmPnFIYsTOPOhaBFhsCL
 sarOaiHUA6dWRGybb+RBNsebLbmvHQhOFANqmdekkuA==
X-Received: by 2002:adf:e588:0:b0:21f:ace:dd82 with SMTP id
 l8-20020adfe588000000b0021f0acedd82mr9691336wrm.226.1660600400304; 
 Mon, 15 Aug 2022 14:53:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4hxSDMZpftCBBMFSFs4qXARqcIDfoNeMwyu98fDGaG6R9gCUSZWy72wuRpnU0bbvDp4w56Vw==
X-Received: by 2002:adf:e588:0:b0:21f:ace:dd82 with SMTP id
 l8-20020adfe588000000b0021f0acedd82mr9691323wrm.226.1660600400097; 
 Mon, 15 Aug 2022 14:53:20 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 j27-20020a05600c1c1b00b003a32251c3f9sm11520530wms.5.2022.08.15.14.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:53:19 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:53:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] virtio: drop sizing vqs during init
Message-ID: <20220815215251.154451-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

Supplying size during init does not work for all transports.
In fact for legacy pci doing that causes a memory
corruption which was reported on Google Cloud.

We might get away with changing size to size_hint so it's
safe to ignore and then fixing legacy to ignore the hint.

But the benefit is unclear in any case, so let's revert for now.
Any new version will have to come with
- documentation of performance gains
- performance testing showing existing workflows
  are not harmed materially. especially ones with
  bursty traffic
- report of testing on legacy devices


Huge shout out to Andres Freund for the effort spent reproducing and
debugging!  Thanks to Guenter Roeck for help with testing!

Michael S. Tsirkin (5):
  virtio_net: Revert "virtio_net: set the default max ring size by
    find_vqs()"
  virtio: Revert "virtio: add helper virtio_find_vqs_ctx_size()"
  virtio-mmio: Revert "virtio_mmio: support the arg sizes of find_vqs()"
  virtio_pci: Revert "virtio_pci: support the arg sizes of find_vqs()"
  virtio: Revert "virtio: find_vqs() add arg sizes"

 arch/um/drivers/virtio_uml.c             |  2 +-
 drivers/net/virtio_net.c                 | 42 +++---------------------
 drivers/platform/mellanox/mlxbf-tmfifo.c |  1 -
 drivers/remoteproc/remoteproc_virtio.c   |  1 -
 drivers/s390/virtio/virtio_ccw.c         |  1 -
 drivers/virtio/virtio_mmio.c             |  9 ++---
 drivers/virtio/virtio_pci_common.c       | 20 +++++------
 drivers/virtio/virtio_pci_common.h       |  3 +-
 drivers/virtio/virtio_pci_legacy.c       |  6 +---
 drivers/virtio/virtio_pci_modern.c       | 17 +++-------
 drivers/virtio/virtio_vdpa.c             |  1 -
 include/linux/virtio_config.h            | 26 +++------------
 12 files changed, 28 insertions(+), 101 deletions(-)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
