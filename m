Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CE1DED77
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356851; cv=none; b=cNTtvC2Eo0WxRsYNjwzQ5o3P4qTV+6PNnNxlo5yg6Bp20yS2WSfL3HRrDBw52259RxtroG4AAWfGL/lkirnfaH7/87keZ7T+Dg6NrXleOWDurUhtibV8Gt8Jj2Lm1i8y3evLNevUc0liZLf21Nyn/tPmz+kEqoAdq9ZWeC70uiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356851; c=relaxed/simple;
	bh=NAyF1Kiygz0APuCAkMYWNlNHKj8WBxkvrzQISfhN9JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCWejAbu8OT8aRhXVAHgdFWpgDuUxExheQw3CGdOyIzg47vyEwdRX8cnBNl9sJ3GolHxuoFf/yE08LXLSIY2Hgc7s7PMa9Vq1YsUf6HXDkr4wmJUOqwdwELp7tM05h4J1fZzQTehZOaSKoMuV4v5c5IXp79zVE+p/8VJNMiD/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyNFFMzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyNFFMzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGuGKFukG47QLzMFWbqvRM07HodOOgpxJ0UT4x5/DCA=;
	b=SyNFFMzfjNxdQMZIV4X/MZOQ0TvLA02YsDRqXKp5wzkkig2+GK374lSIIHsdtD39Eu1TGp
	F3x8Pv/ZgGp/xpAXEutLo1nt283soXDqlaMnTXZI7zaWA7yHHtgkWz2wnDwot3qi51NlB3
	8x4ZNgKtuRZmbKN5B3uvIER4WG5x97Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-31PYrvIwMYiaPmNtC9eQCg-1; Tue, 01 Jul 2025 04:00:47 -0400
X-MC-Unique: 31PYrvIwMYiaPmNtC9eQCg-1
X-Mimecast-MFC-AGG-ID: 31PYrvIwMYiaPmNtC9eQCg_1751356846
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so2309845a91.0
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 01:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356846; x=1751961646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGuGKFukG47QLzMFWbqvRM07HodOOgpxJ0UT4x5/DCA=;
        b=MjYttgm6CkAwHmi7yJDJcgZz8+ObkT2zyIrXAomyY0/HKu6Mzo0z6+kzHJtks6WjNJ
         qha+wQdWATgeUL+3NpOEELWk5CmgFtHXW++7aSey9SAKjkQ9KRe7kVBH46U//dXyxXvd
         scAy/2bZjFufLiTE9umFyd1wyLHr1IJrQkxFDXDR67/CYBDCd6K9JZsV75P3A0QExO/D
         pYQFySgNi+Fvf8nhVToi0L5z3p79eCoCv20Lh+ziDXSFJiGU5y4btCUNonn/qEe5xzR0
         wr1tJnpMYMgMsPR8WoM0vC+B0aEJz8gJTPNWU+gxz5UNF83EHrIUAmgfCd6aR7n7TbLu
         C0gA==
X-Forwarded-Encrypted: i=1; AJvYcCUhHlU1JStxQ4iUQj8oVVmhdZBWIRcYl5+kKz6qE8Fco2QMJyFYe0eESRWRj70iG78BLzb7SqaTsuyH3ghCTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwR+d7lwLHUJRyrjQb+M2Z+7JtbLU3VQUeCgj8xedV0ta3sw3K
	/1GDdD6qVoWUFT6Gc16a5mHGsjzX857RtjtxMn/ZVNUifPwe9RHXh8IqlTVS9t2tzmRFMRXRXEt
	32/xitDwhVCfU8GLqEi/CplaFFWv3mUHFJ2obLZtmXnMJFnOVK0CtEjr1ZwgIZ+G8cS2jzlYlDB
	UGrnzL5h15wnAcPKPHCU8X3HAV0UC89J0so/GsmfGrCkA=
X-Gm-Gg: ASbGnctJBZDkDVKqOSqrDkkhCbW7r6qfpzC+dTQ3Wl0QQ2WJoh93UvUyRC1OyYOYlfX
	BXf+Y8Qmzkdo/jJeZtOYscyqXmj7h8cnLbTtqHcHGV0a8XwL4AP5zBv/xu9AtQIFiteAQb1aM4j
	y7
X-Received: by 2002:a17:90b:4986:b0:311:ffe8:20e9 with SMTP id 98e67ed59e1d1-318c923b9famr26832582a91.17.1751356846421;
        Tue, 01 Jul 2025 01:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDhHUGYNn42sSd0Kp/diabs4sdtkn8dsJt/rfUpYgyhc3VEZqFRFi12iMlH9za1bXmcG+ZHS41z3jM+unrD9U=
X-Received: by 2002:a17:90b:4986:b0:311:ffe8:20e9 with SMTP id
 98e67ed59e1d1-318c923b9famr26832495a91.17.1751356845772; Tue, 01 Jul 2025
 01:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701011401.74851-1-jasowang@redhat.com> <20250701030150-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250701030150-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 16:00:31 +0800
X-Gm-Features: Ac12FXw31bwWYPdAycMWoTkuRTh098wIaEmqSiHQdHHO07TFocqKj-gXxLxNZDk
Message-ID: <CACGkMEtr+Rwu+imU1rLtLLQxY50sNzCC8gi8sE4xVhCoDphJwg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Refine virtio mapping API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org, xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtEBLSglq1soQhI1RBcStTWO_SN1qrcGkqGN6yjdzsU_1751356846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 01, 2025 at 09:13:52AM +0800, Jason Wang wrote:
> > Hi all:
> >
> > Virtio used to be coupled with DMA API. This works fine for the device
> > that do real DMA but not the others. For example, VDUSE nees to craft
> > with DMA API in order to let the virtio-vdpa driver to work.
> >
> > This series tries to solve this issue by introducing the mapping API
> > in the virtio core. So transport like vDPA can implement their own
> > mapping logic without the need to hack with DMA API. The mapping API
> > are abstracted with a new map operations in order to be re-used by
> > transprot or device. So device like VDUSE can implement its own
> > mapping loigc.
> >
> > Please review.
> >
> > Thanks
>
> Cost of all this extra indirection? Especially on systems with
> software spectre mitigations/retpoline enabled.

Actually not, it doesn't change how things work for the device that
does DMA already like:

If device has its specific mapping ops
        go for device specific mapping ops
else
        go for DMA API

VDUSE is the only user now, and extra indirection has been used for
VDUSE even without this series (via abusing DMA API). This series
switch from:

virtio core -> DMA API -> VDUSE DMA API -> iova domain ops

to

virtio core -> virtio map ops -> VDUSE map ops -> iova domain ops

Thanks



>
> > Jason Wang (9):
> >   virtio_ring: constify virtqueue pointer for DMA helpers
> >   virtio_ring: switch to use dma_{map|unmap}_page()
> >   virtio: rename dma helpers
> >   virtio: rename dma_dev to map_token
> >   virtio_ring: rename dma_handle to map_handle
> >   virtio: introduce map ops in virtio core
> >   vdpa: rename dma_dev to map_token
> >   vdpa: introduce map ops
> >   vduse: switch to use virtio map API instead of DMA API
> >
> >  drivers/net/virtio_net.c                 |  32 +-
> >  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
> >  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
> >  drivers/vdpa/pds/vdpa_dev.c              |   3 +-
> >  drivers/vdpa/solidrun/snet_main.c        |   4 +-
> >  drivers/vdpa/vdpa.c                      |   5 +-
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
> >  drivers/vdpa/vdpa_user/iova_domain.c     |   8 +-
> >  drivers/vdpa/vdpa_user/iova_domain.h     |   5 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c       |  34 +-
> >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
> >  drivers/vhost/vdpa.c                     |  11 +-
> >  drivers/virtio/virtio_ring.c             | 440 ++++++++++++++---------
> >  drivers/virtio/virtio_vdpa.c             |  15 +-
> >  include/linux/vdpa.h                     |  22 +-
> >  include/linux/virtio.h                   |  36 +-
> >  include/linux/virtio_config.h            |  68 ++++
> >  include/linux/virtio_ring.h              |   6 +-
> >  19 files changed, 476 insertions(+), 238 deletions(-)
> >
> > --
> > 2.34.1
>

