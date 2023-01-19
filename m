Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F595C00A5A
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0182941956;
	Thu, 19 Jan 2023 06:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0182941956
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7lfGLth
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2emOdDk2ujD; Thu, 19 Jan 2023 06:15:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F31941969;
	Thu, 19 Jan 2023 06:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F31941969
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D9AC0032;
	Thu, 19 Jan 2023 06:15:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1A08C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A69D4193E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A69D4193E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUXyGXHV8vYP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD9084196B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD9084196B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674108947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DINlqTBfPPkQSaUFJZpbcOWI3MVsDFM2A5IzYzWW+XQ=;
 b=R7lfGLth/MwkskECuNHwyEFCfpCQfTi2oESodGPXuiWJwX/BWjMjgTymw+RSuQ4RjK6PNt
 RhMSID28lA369BzP8Z/B1zxmnG0ILzN8h+cc5AAUwtd6+Y4Av7yV5COBwY1M/6T/Bupqq2
 1ojKRGJSWOGozH7Yku9H6dOdqeuyXn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-FZ9LurrSPMSHkxASg_7zXw-1; Thu, 19 Jan 2023 01:15:33 -0500
X-MC-Unique: FZ9LurrSPMSHkxASg_7zXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B3C88A010C;
 Thu, 19 Jan 2023 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4D901121315;
 Thu, 19 Jan 2023 06:15:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 0/5] virtio_ring: per virtqueue DMA device
Date: Thu, 19 Jan 2023 14:15:20 +0800
Message-Id: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: gdawar@amd.com, elic@nvidia.com, virtualization@lists.linux-foundation.org,
 tanuj.kamde@amd.com, linux-kernel@vger.kernel.org
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

Hi All:

In some cases, the virtqueue could be backed by different devices. One
example is that in the case of vDPA some parent may emualte virtqueue
via vringh. In this case, it would be wrong if we stick with the
physical DMA device for software emulated device, since there's no
easy way for vringh to know about the hardware IOMMU mappings.

So this series tries to introduce per virtqueue DMA device, then
software virtqueues can utilize the transport specific method to
assign appropirate DMA device.

This fixes the crash of mlx5_vdpa + virtio_vdpa when platform IOMMU is
enabled but not in the passthrough mode. The reason for the crash is
that the virito_ring tries to map the control virtqueue into platform
IOMMU but the vringh assumes a direct mapping (PA as IOVA). This is
fixed by advetise the vDPA device that doesnt do DMA (without a DMA
ops). So DMA API can go with the direct mapping then the vringh will
be happy since mlx5_vdpa assuems a direct/identical mapping by
default.

Please review.

Changes since V1:
- make mlx5_get_vq_dma_dev() static

Jason Wang (5):
  virtio_ring: per virtqueue dma device
  vdpa: introduce get_vq_dma_device()
  virtio-vdpa: support per vq dma device
  vdpa: set dma mask for vDPA device
  vdpa: mlx5: support per virtqueue dma device

 drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +++
 drivers/vdpa/vdpa.c               |   5 ++
 drivers/virtio/virtio_ring.c      | 133 +++++++++++++++++++++---------
 drivers/virtio/virtio_vdpa.c      |  13 ++-
 include/linux/vdpa.h              |   6 ++
 include/linux/virtio_ring.h       |  16 ++++
 6 files changed, 141 insertions(+), 43 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
