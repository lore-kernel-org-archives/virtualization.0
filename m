Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EDFC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 09:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EDEB4098F;
	Mon, 10 Apr 2023 09:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EDEB4098F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HMJ/bsd9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToneDzdjuHbW; Mon, 10 Apr 2023 09:59:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CEA7408BD;
	Mon, 10 Apr 2023 09:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CEA7408BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDF1EC0037;
	Mon, 10 Apr 2023 09:59:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E939C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 355044098F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 355044098F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k2GMSzTjZ1ea
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EC94408BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EC94408BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681120753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=uJvOa7LFM2bOkuHwfjLxa7GJKZjAwokz30/dDQKsN38=;
 b=HMJ/bsd9xt2kEDW+V5N5cC1hvrZzbU7GHJYsVAu4IknAXTN4QLvmDn+LSZrvV30ZakY0fP
 SRQk/Dt83t9su1DFopA2tRaWxBswS/nCkPJJBTaI6jtpJopjDnpMKl2LRjNIRDxpaMGaVD
 DLMaHxShFVv21c0fL0cZixCduNcU4Bg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-drqEnYJUMXqF7XA5na1SGA-1; Mon, 10 Apr 2023 05:59:11 -0400
X-MC-Unique: drqEnYJUMXqF7XA5na1SGA-1
Received: by mail-wm1-f70.google.com with SMTP id
 l18-20020a05600c1d1200b003ef7b61e2fdso14926376wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 02:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681120750;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJvOa7LFM2bOkuHwfjLxa7GJKZjAwokz30/dDQKsN38=;
 b=tmY1WOT7MQBQDm70A8/6lUkp6fDuOZQBjQr3JJW+bBLoeaTQfIwV2owRE5W7XMPhhb
 1699BNa7ZT2bxCGUwt7d8fyW4SLLKh0M1ud0gSxAfw67li9RGqEUU+0YnSmzNuwkG3zo
 9PK4nuGUVQaj+dMFABr0fUwXWmq9u2YaTHspzjTijtN1lx3cIo4Ggh43tG+voQ9PoN47
 RHCyav9XNc7Let3U6lchhVYqmVJfK+8sg2Swsp67wRLguxIiEjk8ash2XOsXPTryYvV1
 Orj/jIwluTtySbs3ik7POT+fPt3kVoSOpDLQFtpPn4FNWgpIFPEcrwk5IzbzIKSqk3VX
 DEng==
X-Gm-Message-State: AAQBX9d8VvqOBBYaE76hq/R6vddrcQjFP1LjKULMoe05Oe/337v2kFvY
 lWF7hvDWqBlKLDhMMb9sEBkj5n02dE+n40XZimFBpKXaqWVxF2WOXeU0eqTUYXoQ93N0FypA/uI
 IyGmuiWCxGJnaq7qFZc3mrb9lr9F9TRt8B8DB5kJrMw==
X-Received: by 2002:a05:600c:2943:b0:3ef:7584:9896 with SMTP id
 n3-20020a05600c294300b003ef75849896mr6959668wmd.26.1681120750451; 
 Mon, 10 Apr 2023 02:59:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z30LdFNxP5ZQi1zfpPyj3+VkS0rk+HJ/ivJkKnkBzKZggmXuWGnhpVaBiJ6bt8dTXMSJpqug==
X-Received: by 2002:a05:600c:2943:b0:3ef:7584:9896 with SMTP id
 n3-20020a05600c294300b003ef75849896mr6959648wmd.26.1681120750180; 
 Mon, 10 Apr 2023 02:59:10 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c4fcb00b003ebff290a52sm16987302wmq.28.2023.04.10.02.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 02:59:09 -0700 (PDT)
Date: Mon, 10 Apr 2023 05:59:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20230410055906-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, dmitry.fomichev@wdc.com,
 netdev@vger.kernel.org, zwisler@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 zwisler@chromium.org, elic@nvidia.com
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

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9da667e50c7e62266f3c2f8ad57b32fca40716b1:

  vdpa_sim_net: complete the initialization before register the device (2023-04-04 14:22:12 -0400)

----------------------------------------------------------------
virtio: last minute fixes

Some last minute fixes - most of them for regressions.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dmitry Fomichev (2):
      virtio-blk: fix to match virtio spec
      virtio-blk: fix ZBD probe in kernels without ZBD support

Eli Cohen (1):
      vdpa/mlx5: Add and remove debugfs in setup/teardown driver

Mike Christie (2):
      vhost-scsi: Fix vhost_scsi struct use after free
      vhost-scsi: Fix crash during LUN unmapping

Ross Zwisler (1):
      tools/virtio: fix typo in README instructions

Stefano Garzarella (1):
      vdpa_sim_net: complete the initialization before register the device

 drivers/block/virtio_blk.c           | 269 ++++++++++++++++++++++-------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   8 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  13 +-
 drivers/vhost/scsi.c                 |  39 +----
 include/uapi/linux/virtio_blk.h      |  18 +--
 tools/virtio/virtio-trace/README     |   2 +-
 6 files changed, 205 insertions(+), 144 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
