Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49767262E
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027221; cv=none; b=qPxqL14IFjX4AIvcPSupjVjtvMrnjU+A8KPDKr+6Z5k/cjHLorbGfuQhp9La+sps6wxZTO85EKTHDfq3LXHTOmFLUjfT5CeOT2KMdsMsu+QOh9X6OrNOqRkdSGZlv92GH3BK9laDdooYCvH9jLnf/5dyWDKSsWGLmEResSULy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027221; c=relaxed/simple;
	bh=JGDYMXxWyUgr8fxmV/l3uxAqk/63cDoyreY+V+dFGy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNzxTWjkQ82qzSJK+tScV2YqwZ5hxIuyREtrucvkifwmdfWiX0LlGE7ojHvzavmb1QVI6d8T/LpZdPIRkQkdrV8Zih/ZKFbkAP/L2AEkGF3yJSs9TIE6w/qpkji0Rg/O5sRpOlfb9Tfv2ZGKIWp2X5UGIdkO0+/NVA6/4KCYVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ox81lGaS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox81lGaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773027218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jvPG8huPcwLPj1eTFThH5Wni96VMkU1ShkA+nh31QY=;
	b=Ox81lGaSoOkESW/0KkZzEKICHtDxaYJNkLnSnYsYIHFt0EBk63NVqUFvzfntazSD3t0kpQ
	MVj1dimDWDwFg3PNYsGFtBwzd5cTU/H1s1A1FzjU10x6K+mlgmAS4TK+OYeMl9INuopatx
	nSwSTHAvjzV6IESQbVMe3cfLm/kTiVk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-c70k3xiLNNyogCPMNfnDLw-1; Sun, 08 Mar 2026 23:33:35 -0400
X-MC-Unique: c70k3xiLNNyogCPMNfnDLw-1
X-Mimecast-MFC-AGG-ID: c70k3xiLNNyogCPMNfnDLw_1773027214
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358f058973fso10918153a91.1
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 20:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773027214; x=1773632014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jvPG8huPcwLPj1eTFThH5Wni96VMkU1ShkA+nh31QY=;
        b=Es22isowZVJUwgE2AgXM7+ayCJxLW3aWwMVZ2El5Lgk46hfZoVL9a3ra4WPTJq1oyX
         hx4vNEqCmrZSPJRy4QbRk+d3KYV76rzKynt+Nb4zfHir3qNAz4+xiwVe57QzAo77FGcH
         FiNrXfP3eP7whCKy2KrqHmShXT2qLC45PtUwlXrdxRqpYUijAPQRSrlqmEXT+IQuTv2k
         jueDQ7eQmdZTSZ9fR09uYK2I7xLRNylcKtG7HYRLan4pj3L4MnLANEHENnqToW2aIUzx
         CvyS/3jDjX4pjlTIRu39eh7FnFRlnWcEqw3N0msGvKwkOKryOhi8AoofmGpUSn51sb3H
         XMnA==
X-Forwarded-Encrypted: i=1; AJvYcCU9gurb53bF3EF9jwtA0BecrexShgWHUE/fCQ4WndUROpWDP6Fm2cSq6igjFcvP3YIXoScGqim+DXu9UOc2dA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY3Rza/rCa09mIAj0STSwNhKEUEK1YSXsg0kdauqwyfjhlzZcP
	otBV6WSCOQFH+i+CXfbJ+C7glCNrUyFGlohQGW8Rqhz0M6DLFLks/5YKVxWql2teIW6CqNxwx2E
	unHJITpLM2FEU1Oy9y4FnAG0svXQpy0Qo//nwRWfJm0Wus21uNiNyb2OVk8iko0DQ4RHhUkEknw
	3oEcHNQWz9oyge/m8b48+edjCdM20wRbkJaWpwvPEsVOk=
X-Gm-Gg: ATEYQzzhAiQ1TNRkzwj/zSJSGC32cx7nmKx7goMgFDtqzEYjtRKv3QespVlCLj+EDzJ
	aZaSplyTyhrCM6A2N0/epYnPpcOy1pCJMc1NRU6UUPivtSk8AQe+PGYi4GSmj1mwrOyN8bwPgy7
	CSue2rv89LSnn7pp/OMcQg+uPuKcdynooqpuUTSmHezCr3enHb5P0c0AFRS1tMkHEPkZdNGfm3O
	EygFqbj
X-Received: by 2002:a17:90b:530c:b0:356:7b41:d355 with SMTP id 98e67ed59e1d1-359be27b7b5mr9599178a91.1.1773027214269;
        Sun, 08 Mar 2026 20:33:34 -0700 (PDT)
X-Received: by 2002:a17:90b:530c:b0:356:7b41:d355 with SMTP id
 98e67ed59e1d1-359be27b7b5mr9599151a91.1.1773027213792; Sun, 08 Mar 2026
 20:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309023353.652650-1-yui.washidu@gmail.com>
In-Reply-To: <20260309023353.652650-1-yui.washidu@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 11:33:20 +0800
X-Gm-Features: AaiRm52MKTXwu3ZVygUlJrhXm5XdzeolO4BO0abBlBvImRa19QU3vVdrSntXt74
Message-ID: <CACGkMEu+fd91yCwmSPNj0fTXw5v3ZON7F4kL_PVUz6TbG-iT4g@mail.gmail.com>
Subject: Re: [PATCH] virtio: add num_vf callback to virtio_bus
To: Yui Washizu <yui.washidu@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jAUWri3m29LBgHnXXJgvIHWrQRvQFPrm38dhnQlyMPM_1773027214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:37=E2=80=AFAM Yui Washizu <yui.washidu@gmail.com>=
 wrote:
>
> Recent QEMU versions added support for virtio SR-IOV emulation,
> allowing virtio devices to expose SR-IOV VFs to the guest.
> However, virtio_bus does not implement the num_vf callback of bus_type,
> causing dev_num_vf() to return 0 for virtio devices even when
> SR-IOV VFs are active.
>
> net/core/rtnetlink.c calls dev_num_vf(dev->dev.parent) to populate
> IFLA_NUM_VF and IFLA_VFINFO_LIST

Patch looks good but,

If I understand correctly, ndo_get_vf_config is needed for
IFLA_VFINFO_LIST but not implemeted in this patch?

> in RTM_GETLINK responses.  For a
> virtio-net device, dev.parent points to the virtio_device, whose bus
> is virtio_bus.  Without num_vf, SR-IOV VF information is silently
> omitted from tools that rely on rtnetlink, such as 'ip link show'.
>
> Add a num_vf callback that delegates to dev_num_vf(dev->parent),
> which in turn reaches the underlying transport (pci_bus_type for
> virtio-pci) where the actual VF count is tracked.  Non-PCI transports
> are unaffected as dev_num_vf() returns 0 when no num_vf callback is
> present.
>
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> ---
>  drivers/virtio/virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 5bdc6b82b30b..299fa83be1d5 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -435,6 +435,14 @@ static void virtio_dev_shutdown(struct device *_d)
>         dev->config->reset(dev);
>  }
>
> +static int virtio_dev_num_vf(struct device *dev)
> +{
> +       struct virtio_device *vdev =3D dev_to_virtio(dev);
> +
> +       return dev_num_vf(vdev->dev.parent);
> +}
> +
> +
>  static const struct bus_type virtio_bus =3D {
>         .name  =3D "virtio",
>         .match =3D virtio_dev_match,
> @@ -444,6 +452,7 @@ static const struct bus_type virtio_bus =3D {
>         .remove =3D virtio_dev_remove,
>         .irq_get_affinity =3D virtio_irq_get_affinity,
>         .shutdown =3D virtio_dev_shutdown,
> +       .num_vf =3D virtio_dev_num_vf,
>  };
>
>  int __register_virtio_driver(struct virtio_driver *driver, struct module=
 *owner)
> --
> 2.47.3
>

Thanks

