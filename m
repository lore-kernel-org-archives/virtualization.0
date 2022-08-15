Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B5C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 22:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A8CC60BF5;
	Mon, 15 Aug 2022 22:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A8CC60BF5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HuzlL7xv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WUKwBkxuIyfb; Mon, 15 Aug 2022 22:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10DE760AA7;
	Mon, 15 Aug 2022 22:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10DE760AA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C095DC0033;
	Mon, 15 Aug 2022 22:00:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6730C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6F0860BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6F0860BD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahI10EYgDT_A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E44CD60AA7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E44CD60AA7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pPu4b41HwKIyHkmNffFRKvMIGXhZxqL1ITgc3xx1I1w=;
 b=HuzlL7xvWrZcdK2cW9c7PadGZbVdc7EqeBLJVJ5D46wp+UwslHC9cTSHUZSGCulZ3+/YWL
 oWK4QaFlN6AQh3/ci7u4hg//qd1g1HXRAI+e3KabG77clh0y64V2Nz9gX6j+op5aqB0xZF
 JK5aDFhezedrH5jcbqDaMCWhE1kj6N0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-cvJJpDpNPY--mPz5ToUnZA-1; Mon, 15 Aug 2022 18:00:26 -0400
X-MC-Unique: cvJJpDpNPY--mPz5ToUnZA-1
Received: by mail-wm1-f69.google.com with SMTP id
 i83-20020a1c3b56000000b003a534ec2570so171304wma.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=pPu4b41HwKIyHkmNffFRKvMIGXhZxqL1ITgc3xx1I1w=;
 b=xLQ3mfnLhkKey+cShiKE2uku0c8QjNx3tyC8gU/uZ35WS5nsO3QTtdfGUHaxu3z5OI
 h9b6evPq66Bxyqx6H7eH15Hhv74ZyTCkN2WdTP8zF7yGXLFSjikAX0Ee1Hk4ELYfvySf
 7XwlFt8/X3EJLEVd+F8Q99xPsKbT7SueEF/BPrTELpNevXNm8ovkhY7gYv3CUY0uRwfW
 zljowYLzPVUHdfOx8dONsIMO9ul6oEIIhco8qPMrOUcR0Zbv8/oqV2YtMsId70QMVwVP
 Te+LolmjtdD4Tm49k2i2ZfHOzySLffi+WEsCO88rXIZHkaXbRSYHqvlgyGE+Yf/hTR57
 OwSg==
X-Gm-Message-State: ACgBeo3LsW19bHLMj5j/XcX9xiBuwGZk7rL9T3+lv/P020Gb6M9iMJ37
 fof0QMoz2A+/IndhZx7rZ2M4VRv18y8fywDZtIO61yIOhJBmapSj/xpvkg/5yu+PmDusMeLUCI0
 ys5dtNhbh3X3w3iOQ+Il22tiwSwJ5lalYbr5JpZsOEA==
X-Received: by 2002:a05:6000:805:b0:220:748e:82c6 with SMTP id
 bt5-20020a056000080500b00220748e82c6mr9913871wrb.395.1660600825384; 
 Mon, 15 Aug 2022 15:00:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Z3S7UlKgnyuGva/EOPuZ7un81OGKTT1khSSa3kB+Zj8529U4wRbJLuMZFfRZb4ZEBh6IVxg==
X-Received: by 2002:a05:6000:805:b0:220:748e:82c6 with SMTP id
 bt5-20020a056000080500b00220748e82c6mr9913849wrb.395.1660600825186; 
 Mon, 15 Aug 2022 15:00:25 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 q14-20020a05600000ce00b0021ee28ff76esm8271311wrx.38.2022.08.15.15.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 15:00:24 -0700 (PDT)
Date: Mon, 15 Aug 2022 18:00:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] virtio: drop sizing vqs during init
Message-ID: <20220815215938.154999-1-mst@redhat.com>
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

Reporting after I botched up v2 posting. Sorry about the noise.

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


changes from v2
	drop unrelated patches
changes from v1
	revert the ring size api, it's unused now

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
