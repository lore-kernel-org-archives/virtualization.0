Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C418C03F
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756810; cv=none; b=ue3QNw1GoEyfy2ZwP3o8dmnJHuVb1p4ealZxu4PY1MXd9jvhlTis31XMNf4N+jri/WZbK4mxX9O/e+Ee+2zghLoZsmNsc09Q/9+QPvj7tXJtbFYRLSkifpxH6xk5BwKFL4aMtRLdo0aGAqVE/+0mE5Cjgdst8ENR3GleTK/p2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756810; c=relaxed/simple;
	bh=u9eeyt0TY8VZJUTPBx+3waaYqQoZvCknm4y0ibpoDwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru223M6gCmTaIQqeCbs4401blWM5LcD1hQ2NnwPw+7FlqG8ADzW1/Y51iYBEc02ftw7ML0u7hGTD0HWkodZb2kz63ZoS6qXul43/zxwcC4TEm3xgvRa0zQraUGd3QMIj0QVjeA+5BmdD7IKRLLhEmRTIKHQ3tWbJeM+zsbmr850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+GRRSgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+GRRSgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr0RBtM4PPEUCRYnReQAehBJpOEIUsyueCfwPvyGiT8=;
	b=K+GRRSgOJbDxxj4IucSGVJxCkbJDONwm0a6SrfwLqkLXEj1TyewthaGxQMiiTXrhSCjm3h
	mEDddM9JZpaRiyVU2+5KtRdu8IfOAXw2+F+vbzNR5sxP1ODw4oXSQtSzhpQUauBVECW9pp
	e8jDDzMfZ7Ec1z7K2CoXFjRPAF3xWfQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-SjVDyuOqNim6yuZ842vPPg-1; Mon, 28 Jul 2025 22:40:05 -0400
X-MC-Unique: SjVDyuOqNim6yuZ842vPPg-1
X-Mimecast-MFC-AGG-ID: SjVDyuOqNim6yuZ842vPPg_1753756804
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31df10dfadso3548568a12.0
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 19:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756804; x=1754361604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr0RBtM4PPEUCRYnReQAehBJpOEIUsyueCfwPvyGiT8=;
        b=eTSDXQ2II44yLLrX2Vxc3RBLbpLO+ruGplyPes3TYJNryxnr1PpyHoPyC4BYeNaHZi
         wLk3R5LRhh9ao2p+0DZKKADjhuBJ/jEU2oTN1/XBZj3yp74LkRVEgOgDXJyAb8sgl3UU
         dcjoxlQq/6zjGv+qVUXUAJ1mP8I1m/IxZ3tZ0oB4OlAYLsIoCzobs3zdZKHZqqH2VET7
         9IZiJ3889Yv3TLmgr2zTBrO82CSygoO8StvmJ2jY0mx/h0YLlrAyfxFy2WJ+vwGjY2TR
         txQd6PMaNoLHE3kILaftVOEBmvjEx5m3lb0qye49V+5eo6iE0LIXOgi6tMcqHMHqwyXE
         n82g==
X-Forwarded-Encrypted: i=1; AJvYcCXOlFwdV1sDfTr7jKqm2z7zYvVK9riCBnhme0zV7KY9y5jV6U6acA/ofSfuDd23OyXYCxGtjPp+DU2CB43kIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrqbsZNFXDmH6vL8+DW85Lqkd1Byjw8/8xsVffGG/Eus/rbTP+
	QQ0a1vwTJJImHlzk2EG/DLQpIsra/YOQpccLH2OsF+oSyhtlNS7gSp3diEqK+9Cp7EPR6cI2c3Z
	Wq+PVaZZ8VHN2CfOYxPbz8enlluOqqbwPzb7m7uPkl0Ros3681IH4bLHTUuKtVNnRoo7cLf/+OD
	lLfGVSp2ZJc+XQU6kFZXze49bLb2iwPqq4Vi3CnOtgry/iqF9at57w+Q==
X-Gm-Gg: ASbGncv2qBkplQsXQ7BwpuPjRuEi/2qDP/ZVa2ZTciumRQxN9puzwie1b1brHP1CBve
	70Kg52ib05EmenjR5Z/oov6hv4l7V2w3jTuJJVC7mls/ihRFFUHwCgWETvt+7UwyP65TPo8ZSjB
	sbtsMtaFEgVB7UtEWaSG8=
X-Received: by 2002:a17:902:e891:b0:23d:ed91:6142 with SMTP id d9443c01a7336-23fb30e873fmr218672725ad.42.1753756803837;
        Mon, 28 Jul 2025 19:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/7E/5hv5l0CnRxhJGw4HL+V+BlBjKku3YaF/ts6+ubdu5Ax0qOzggJ46ozsRaRygBUyeaDIM5MmmXS7Jid2I=
X-Received: by 2002:a17:902:e891:b0:23d:ed91:6142 with SMTP id
 d9443c01a7336-23fb30e873fmr218672455ad.42.1753756803412; Mon, 28 Jul 2025
 19:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718075336.4374-1-jasowang@redhat.com> <CAJaqyWefAVfQtrboc3ms3A4BH5i0mFngoeznPXMVZaF3ULxuLQ@mail.gmail.com>
In-Reply-To: <CAJaqyWefAVfQtrboc3ms3A4BH5i0mFngoeznPXMVZaF3ULxuLQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:39:52 +0800
X-Gm-Features: Ac12FXwWO2WiaAjldG1-S2luBixeBpyqS0UWVMspMyJ87TZLXhe7W3Fn-397h1A
Message-ID: <CACGkMEt8ae2RFuSvWCO-BtngeYgG_9DHXtRe80fCVNu6=8d1Qw@mail.gmail.com>
Subject: Re: [PATCH] vduse: drop depedencies for HAS_DMA and ARCH_HAS_DMA_OPS
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u6C8GXF5F970l2QzVbX3S6dtq1CqTftagLuUgf1uGOg_1753756804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:53=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Jul 18, 2025 at 9:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > After commit c2dbb3fc2a97 ("vduse: switch to use virtio map API
> > instead of DMA API"), vduse doesn't use DMA API. So we can safely drop
> > the depedencies for HAS_DMA and ARCH_HAS_DMA_OPS.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> This should be at the end of the series that makes VDUSE not depend on
> DMA, isn't it? Or am I missing something?

This is a fixup after Michael merges the series. But he spot some
other issue (e.g losing the type safety of dma device), so the series
were dropped from his tree.

I will work on a new version.

>
> Anyway,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!

Thanks

>
> > ---
> >  drivers/vdpa/Kconfig | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > index 559fb9d3271f..857cf288c876 100644
> > --- a/drivers/vdpa/Kconfig
> > +++ b/drivers/vdpa/Kconfig
> > @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
> >
> >  config VDPA_USER
> >         tristate "VDUSE (vDPA Device in Userspace) support"
> > -       depends on EVENTFD && MMU && HAS_DMA
> > -       #
> > -       # This driver incorrectly tries to override the dma_ops.  It sh=
ould
> > -       # never have done that, but for now keep it working on architec=
tures
> > -       # that use dma ops
> > -       #
> > -       depends on ARCH_HAS_DMA_OPS
> > +       depends on EVENTFD && MMU
> >         select VHOST_IOTLB
> >         select IOMMU_IOVA
> >         help
> > --
> > 2.47.3
> >
>

