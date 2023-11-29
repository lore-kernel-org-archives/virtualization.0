Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6114004
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N04WPkSz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A39F40272
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:17:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A39F40272
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N04WPkSz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZG0FoeJoQrny
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 09:17:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 067A04059D
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:17:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 067A04059D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701249423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckwgjfvsxGj0GYdJiZLYltwjMuQpB0mwrwPr8QizCM8=;
	b=N04WPkSzGKRLbebJTu76uaVIx7ebXrq0S1Fjk6rKDSDc81p2bUNFVq8dndf0ct6gAvcCUL
	hbQHEQ77FCwlmv6tww5/NnuKVBGdPCnxgaVgF9avYaEpiLWJ9f6MqORdmzElVwcjjW5yex
	sK3wo8+s39YODl4HorU6uQ8gsHPZpVk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-a_Ko_PMpOH60Af5vyk7YiQ-1; Wed, 29 Nov 2023 04:17:02 -0500
X-MC-Unique: a_Ko_PMpOH60Af5vyk7YiQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bba79548fso1873033e87.2
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 01:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249420; x=1701854220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckwgjfvsxGj0GYdJiZLYltwjMuQpB0mwrwPr8QizCM8=;
        b=CfR1y5hskyzhgfZajdxzNrUmhQRoTQZwxK7r/sM951VLZkuTSujYwJCm2vIckzTdHO
         p/m1APqFQBI2qAZQ6K7thQdc+5aftTrmj8GxXWR7QoBWK8Oji2eIOJVpY2UwH8qpPWDx
         nP61aRTOkN92KAyGmqpnpq9KvcJrmlk+VEborUPjRjp0/IJZMW1TnvaB+eMg9TG8pAgU
         tuN9poxQHquHJrhFKATUcVxSJwTs3EE2zz44cqiKRhTj2oWcioC+biy4IFEYeuwvoyAI
         2JVNZ/m8p6tRPIUjVDdFhzNfNkMh/wqrf/46+nQiDhnJScSg/N7VvU4J4uxkO7VrcY/o
         MTZQ==
X-Gm-Message-State: AOJu0YyN+EvWnbWY9EjS141QF5u444dAwnCN8Vtx/WCXQv1S1t9WsxeZ
	1lQkkMz/eoN+vXrYpvZ57FsHtfxv/sVcDIhSECb91Gqf2sq5o7xXgfKO3eNmElF4l+7SUu8CQSh
	lHIBCHav2ysLPvTG2NM3eBZJP83lZdeeQle4RYuqADLY2aNCsT2i2WdYv7g==
X-Received: by 2002:a19:671d:0:b0:50b:c08d:69ba with SMTP id b29-20020a19671d000000b0050bc08d69bamr2031905lfc.57.1701249420656;
        Wed, 29 Nov 2023 01:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTpWxMFUv78+9eoh3yywfOCrwElPPyEFR923tcDuFlr5hCVrrpOFJIlTizYOyqCHn5EelCUZdWuJlBEl/NG/Y=
X-Received: by 2002:a19:671d:0:b0:50b:c08d:69ba with SMTP id
 b29-20020a19671d000000b0050bc08d69bamr2031882lfc.57.1701249420311; Wed, 29
 Nov 2023 01:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230903181338-mutt-send-email-mst@kernel.org> <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
In-Reply-To: <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Nov 2023 17:16:49 +0800
Message-ID: <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, 
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eperezma@redhat.com, shannon.nelson@amd.com, 
	yuanyaogoog@chromium.org, yuehaibing@huawei.com, 
	kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	alexander.shishkin@linux.intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:05=E2=80=AFPM Ning, Hongyu
<hongyu.ning@linux.intel.com> wrote:
>
>
>
> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> > The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0=
bc2c:
> >
> >    Linux 6.5 (2023-08-27 14:49:51 -0700)
> >
> > are available in the Git repository at:
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/f=
or_linus
> >
> > for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab=
:
> >
> >    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09=
-03 18:10:24 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: features
> >
> > a small pull request this time around, mostly because the
> > vduse network got postponed to next relase so we can be sure
> > we got the security store right.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Eugenio P=C3=A9rez (4):
> >        vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> >        vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feat=
ure
> >        vdpa: add get_backend_features vdpa operation
> >        vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> >
> > Jason Wang (1):
> >        virtio_vdpa: build affinity masks conditionally
> >
> > Xuan Zhuo (12):
> >        virtio_ring: check use_dma_api before unmap desc for indirect
> >        virtio_ring: put mapping error check in vring_map_one_sg
> >        virtio_ring: introduce virtqueue_set_dma_premapped()
> >        virtio_ring: support add premapped buf
> >        virtio_ring: introduce virtqueue_dma_dev()
> >        virtio_ring: skip unmap for premapped
> >        virtio_ring: correct the expression of the description of virtqu=
eue_resize()
> >        virtio_ring: separate the logic of reset/enable from virtqueue_r=
esize
> >        virtio_ring: introduce virtqueue_reset()
> >        virtio_ring: introduce dma map api for virtqueue
> >        virtio_ring: introduce dma sync api for virtqueue
> >        virtio_net: merge dma operations when filling mergeable buffers
>
> Hi,
> above patch (upstream commit 295525e29a5b) seems causing a virtnet
> related Call Trace after WARNING from kernel/dma/debug.c.
>
> details (log and test setup) tracked in
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218204
>
> it's recently noticed in a TDX guest testing since v6.6.0 release cycle
> and can still be reproduced in latest v6.7.0-rc3.
>
> as local bisects results show, above WARNING and Call Trace is linked
> with this patch, do you mind to take a look?

Looks like virtqueue_dma_sync_single_range_for_cpu() use
DMA_BIDIRECTIONAL unconditionally.

We should use dir here.

Mind to try?

Thanks

>
> >
> > Yuan Yao (1):
> >        virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> >
> > Yue Haibing (1):
> >        vdpa/mlx5: Remove unused function declarations
> >
> >   drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
> >   drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
> >   drivers/vhost/vdpa.c               |  15 +-
> >   drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++=
++++-----
> >   drivers/virtio/virtio_vdpa.c       |  17 +-
> >   include/linux/vdpa.h               |   4 +
> >   include/linux/virtio.h             |  22 ++
> >   include/uapi/linux/vhost_types.h   |   4 +
> >   9 files changed, 625 insertions(+), 90 deletions(-)
> >
>

