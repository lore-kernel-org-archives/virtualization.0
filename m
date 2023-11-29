Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46514017
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To9jCF2Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75A0481AEF
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75A0481AEF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=To9jCF2Y
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Xb0fnPtGwzl
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 09:47:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16B0881858
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16B0881858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701251235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FUL7xaq2WNQBPHMTY8ZTJkkLmUhL7UnsbnYobOmCzM=;
	b=To9jCF2YVdZT2VzTUwzmXkSyqEeAfRli3XO4OAwjhSk+OcTb9jlvJYxHWTv8uNsbMVMFKa
	P+tEK5Xxb8VIO9/pdfbrN4QR3H4jHLrxG713JX9+Ow5qIgwRD7LmJNxdJwi4FumtWXlZ5W
	/sSzko/SKJngB6rmSUqpstTsQpG7VPY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-BZ_rBoUyOr6oSi4ykiFhOg-1; Wed, 29 Nov 2023 04:47:14 -0500
X-MC-Unique: BZ_rBoUyOr6oSi4ykiFhOg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a01a0032b19so490028366b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 01:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701251233; x=1701856033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FUL7xaq2WNQBPHMTY8ZTJkkLmUhL7UnsbnYobOmCzM=;
        b=Txo2fJP0swoKAUmKfvRpcNny+cV8ZGdAk8oARhdaknXy7/Lkz2GjUTGTZxkK5DhRus
         yQDciAY719doWbsC0Pgx8T5P60hkHd0abhyjG+ORJbCVfWdHoHJAmr/sknmsJ6ScoNTV
         z2TNJgodFL7/k2ity9LHATSGzBM588vE5HE77cETA2c0cB/esOQLnwy55Jod/sdfhnin
         8UZk0ZEuDFYrSSTXzXFDmKbjQrPBMW8KSkzWuOHfISkdhC4yvBb58AFrAEUfdy1VBRuU
         SHzh5DAOyUHOb6vrdtbDMtgztN4rh2k9TkzhriyIgByjI7WdEpZxLC9V16ej10ekRq8f
         hrQw==
X-Gm-Message-State: AOJu0Ywcv/li0BVZr+uNKFyTV/uP51fTRj3WY6lTpQeTnc0V/YPvcnFM
	jJADtqGJbMb2uPdApjElUFeOQIcWtw0IQHMeNwMcDSGyFLSJ0tSN7/S3FnbUfgyVudZgu1X5yE5
	daYDcu9E51PvTX3ALpvG6RGos3BWP6msSL+Lh7GRwlg==
X-Received: by 2002:a17:906:5349:b0:a0a:391d:2dad with SMTP id j9-20020a170906534900b00a0a391d2dadmr13424751ejo.75.1701251233280;
        Wed, 29 Nov 2023 01:47:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcdjDb3B9JI1PiGSAemY+jsGIUrA/1PnJLVzsoGUWFBHqpyAnt/MTb5gBPxFzfJMBSJ9M+Hw==
X-Received: by 2002:a17:906:5349:b0:a0a:391d:2dad with SMTP id j9-20020a170906534900b00a0a391d2dadmr13424728ejo.75.1701251232928;
        Wed, 29 Nov 2023 01:47:12 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906454800b00997d7aa59fasm7810806ejq.14.2023.11.29.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:47:12 -0800 (PST)
Date: Wed, 29 Nov 2023 04:47:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Cc: xuanzhuo@linux.alibaba.com,
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, eperezma@redhat.com,
	jasowang@redhat.com, shannon.nelson@amd.com,
	yuanyaogoog@chromium.org, yuehaibing@huawei.com,
	kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL] virtio: features
Message-ID: <20231129044651-mutt-send-email-mst@kernel.org>
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 29, 2023 at 05:03:50PM +0800, Ning, Hongyu wrote:
> 
> 
> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> > The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
> > 
> >    Linux 6.5 (2023-08-27 14:49:51 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
> > 
> >    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
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
> > Eugenio Pérez (4):
> >        vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
> >        vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
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
> >        virtio_ring: correct the expression of the description of virtqueue_resize()
> >        virtio_ring: separate the logic of reset/enable from virtqueue_resize
> >        virtio_ring: introduce virtqueue_reset()
> >        virtio_ring: introduce dma map api for virtqueue
> >        virtio_ring: introduce dma sync api for virtqueue
> >        virtio_net: merge dma operations when filling mergeable buffers
> 
> Hi,
> above patch (upstream commit 295525e29a5b) seems causing a virtnet related
> Call Trace after WARNING from kernel/dma/debug.c.
> 
> details (log and test setup) tracked in
> https://bugzilla.kernel.org/show_bug.cgi?id=218204
> 
> it's recently noticed in a TDX guest testing since v6.6.0 release cycle and
> can still be reproduced in latest v6.7.0-rc3.
> 
> as local bisects results show, above WARNING and Call Trace is linked with
> this patch, do you mind to take a look?

Does your testing tree include the fixup
5720c43d5216b5dbd9ab25595f7c61e55d36d4fc ?

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
> >   drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
> >   drivers/virtio/virtio_vdpa.c       |  17 +-
> >   include/linux/vdpa.h               |   4 +
> >   include/linux/virtio.h             |  22 ++
> >   include/uapi/linux/vhost_types.h   |   4 +
> >   9 files changed, 625 insertions(+), 90 deletions(-)
> > 

