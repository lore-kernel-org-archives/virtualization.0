Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9284CDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 05:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 123CF60F2F;
	Mon, 23 Oct 2023 05:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 123CF60F2F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aTq91aEi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9INOjtuqLMQf; Mon, 23 Oct 2023 05:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6FBF760F2A;
	Mon, 23 Oct 2023 05:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FBF760F2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DEA3C0071;
	Mon, 23 Oct 2023 05:02:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 433E9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 05:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B59241B59
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 05:02:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B59241B59
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aTq91aEi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2FEaQsy8rqH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 05:02:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E02EF41B34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 05:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E02EF41B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698037344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=VYWewINA58ufsweAbU1fUSU48ieD3onMLop08pEtwvU=;
 b=aTq91aEiwLuF5yy5/m/IeypSvj33Qp1ZzYojiTe4mYPN35LCU75+uh46pTA6wxrdBemRfK
 oO8RGe3z9byJNXsLgG0B4isdI/E4OWLJhe6xC3Znm6IvB114HrCuAS7BKK06xli1ciQhCl
 V1XggJWFaZVtqTCZ49Ux24qZKH0nFL4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-9-o1jcjENuCOyfuPDPeyEg-1; Mon, 23 Oct 2023 01:02:16 -0400
X-MC-Unique: 9-o1jcjENuCOyfuPDPeyEg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408508aa81cso20117605e9.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 22:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698037335; x=1698642135;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYWewINA58ufsweAbU1fUSU48ieD3onMLop08pEtwvU=;
 b=P2cP3xhijcuNUvuJ0DHT21ry0Irpqu6V174mfJYY5i87DzUO1tc3Lx88eWoos2nyZD
 +ioMn4seyzngfdeE3dPTsgQS6IMTETwGqaDgi6In5DRT9nYEEZFAfxDHJcaZKzP/8MSz
 NtIR9XvFN0Q1OqtQoU38gsY8VC6UbnyKPU6rjHdzmPb5mcLpQltYe35vLV+YcqU35OyY
 S3+X6gsmMp1vo5gPjaNcEUTr9myZ1ugYFVCSFv4tWEnAHmFmTzGEQ/TNiY/VjAOBjHJ5
 caiPwFOd73VhJugncHV49rm+rero3HUSE4DBYXtP9V59hHnvW2h+ny9Ax5ks8VuhVnEn
 86FQ==
X-Gm-Message-State: AOJu0Yz7heLXx7xG9ZImw03J8+rAL+9dc6GzJ/eq98PEGvlGsVu+nFcx
 aLApwk31L13SNHURHpxy/nD1u7X2XDzLU+pEQkzcFuoBOPFGK8XuSMf/GMk7JO4Y9oMG8tglUFt
 D7okuOqJkPFYtcvvXr3+CN+8DFtFYD91acMZpRzAgWg==
X-Received: by 2002:a05:600c:188a:b0:406:7021:7d8 with SMTP id
 x10-20020a05600c188a00b00406702107d8mr6243003wmp.20.1698037335648; 
 Sun, 22 Oct 2023 22:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEE93zO060dPvm0mbGcpCvz5k2sh+CIGfA4Q3Qp53GzxNdWjPayH2r0nxenrW1QoZUESLwnA==
X-Received: by 2002:a05:600c:188a:b0:406:7021:7d8 with SMTP id
 x10-20020a05600c188a00b00406702107d8mr6242988wmp.20.1698037335303; 
 Sun, 22 Oct 2023 22:02:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c028100b004077219aed5sm13079549wmk.6.2023.10.22.22.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 22:02:14 -0700 (PDT)
Date: Mon, 23 Oct 2023 01:02:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20231023010207-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liming.wu@jaguarmicro.com, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eric.auger@redhat.com, mheyne@amazon.de,
 catalin.marinas@arm.com, shawn.shao@jaguarmicro.com, zhenyzha@redhat.com,
 pizhenwei@bytedance.com
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

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 061b39fdfe7fd98946e67637213bcbb10a318cca:

  virtio_pci: fix the common cfg map size (2023-10-18 11:30:12 -0400)

----------------------------------------------------------------
virtio: last minute fixes

a collection of small fixes that look like worth having in
this release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dragos Tatulea (2):
      vdpa/mlx5: Fix double release of debugfs entry
      vdpa/mlx5: Fix firmware error on creation of 1k VQs

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Liming Wu (1):
      tools/virtio: Add dma sync api for virtio test

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Shawn.Shao (1):
      vdpa_sim_blk: Fix the potential leak of mgmt_dev

Xuan Zhuo (1):
      virtio_pci: fix the common cfg map size

zhenwei pi (1):
      virtio-crypto: handle config changed by work queue

 drivers/crypto/virtio/virtio_crypto_common.h |  3 ++
 drivers/crypto/virtio/virtio_crypto_core.c   | 14 +++++-
 drivers/vdpa/mlx5/net/debug.c                |  5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c            | 70 ++++++++++++++++++++++------
 drivers/vdpa/mlx5/net/mlx5_vnet.h            | 11 ++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c         |  5 +-
 drivers/vhost/vhost.c                        |  4 +-
 drivers/virtio/virtio_balloon.c              |  6 ++-
 drivers/virtio/virtio_mmio.c                 | 19 ++++++--
 drivers/virtio/virtio_pci_modern_dev.c       |  2 +-
 tools/virtio/linux/dma-mapping.h             | 12 +++++
 11 files changed, 121 insertions(+), 30 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
