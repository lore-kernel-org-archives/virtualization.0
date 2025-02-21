Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8A1DA53
	for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100329; cv=none; b=FT7i3cnMElXil75BeIm9o06uJE5mHo4idsswQQKt7qDKyZd2+BeTzU1Hr/6W6wAmGoRXYR4M/lQ758wJaLA4pQ430mY4qdV5VbXunvACfICCBwVY1YnbcW4eGK+0jOlczfgQG9/jO37iI6L0NwSzRLzAB4V7AY43rA+UppIOwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100329; c=relaxed/simple;
	bh=h8JtG26W+tN9sES1ZrmYwA3n0UnbXfgd8hcuR8Dzeu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZJTy91252V4/MhkYxIyRuUUBKwGlxp04+ZT3f8NR+vk+2wodCTKs9gfQWZOgsz3lrCxvvQqDowymJXSqf1kpBFnlt+wvXioHM7f0jHqhTBIisHNhpD9IcIEo9rXz5m++6BRIfX3xZbPpUiGt1BmzQNWwtg7HHAKThK4a5PdEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4FwdP3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4FwdP3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2uP5OmbuFiEulUjSxw5yqkOeT8xFildQfqqZOxiLFk=;
	b=Q4FwdP3YPJZWTMLlDINxlCiOoAOlUIkFgHx10+pGa7Tsx1CKgwVvSRhL5KbaJ4nuMnsMW1
	v5NpGTlk2ouAMa8UkQL3MuYZk4u2pe4YaBrf1FDntrwB3g9lWcu/PAkRKdgunO0ZFIxy19
	qzUNaW3EVnrLI57HFs+cWO4rxvhRGOE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-THRypttQOwW63Qv0zzFZ1A-1; Thu, 20 Feb 2025 20:12:05 -0500
X-MC-Unique: THRypttQOwW63Qv0zzFZ1A-1
X-Mimecast-MFC-AGG-ID: THRypttQOwW63Qv0zzFZ1A_1740100324
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so3318867a91.3
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 17:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100324; x=1740705124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2uP5OmbuFiEulUjSxw5yqkOeT8xFildQfqqZOxiLFk=;
        b=bFl4c7bwscppYANOhIW8KG2FnTTw53olxfq1TQI26Pa5roEA5ubY2nBs8+o0uI73//
         qRgrJlV+sR9TVGR71drREP6vaFm0PFY4UC3gj04c05BMzAEj9WZ9CwbJLhEUs5L0svMM
         41/Flz5wqOOCI6z0jD1a5MY3c+8Dd3CT3oN105FRBUOQq6YdLin4Je8kbP94/dEG61DI
         iaD1fUL07+V4Yhmyhg2SSkKizYx9stejId0eieuT+a6h1H1HIKGx0AkNGtaa44V/7+Qw
         Xgql9eWtoKWCtYuoiJy0xHX7vfPO8T2uMuhYzbqziPNUYLjc+3jGGLy1Z6pDYot48cIk
         RMqA==
X-Forwarded-Encrypted: i=1; AJvYcCXXl4raRegp4saTX2Y+uZ/zg1hyZM0HHqv92K2zJtAseGGX9nw/F9PQZ4VFAwoCOI8aB7ioqM9gZr2ecszeUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywzi+ChEiWizflY8apjTEb+wK4Fkntmm1j1VpoysM0Vhxy1XdyO
	eB+ONBwuXnu3xSWGRDj3IE81Cg1V2PjsxSJko1aFAm0QbRu1k3XDv7UEY2EXfbbLe13v68vqDZU
	lLpTAn/Wsm20K5ahKb3xy3NSiTtsp7rsEiuoMeFJrN9kHbxMC+A7cS9j//unuD198J2udHG/2Qd
	qiQ9MOcdTsy+umaP3GvYRTKBONhpKPrfcWLwLLQqI=
X-Gm-Gg: ASbGncv1SAT7p7knAiqy78aDwWXrNHJ9pJVodhF04CHQV+EnmZoDEGaT7wQGIH2hHbQ
	nZ1jQ9aZ5JVHAsprl79/2MxiO4IZic2BYyhmWmkd2I46vL9OS42yphAXp6A4MAbw=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fce789e6acmr2105441a91.5.1740100324198;
        Thu, 20 Feb 2025 17:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER+iSiuMQxunbjUmcStknwXYKOZqYWuiH5hTUxEg7WTxwgtt+csCQnXrUZ6sQ++5Rorm/la/GU9ouQSpBNGEU=
X-Received: by 2002:a17:90b:5292:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fce789e6acmr2105379a91.5.1740100323470; Thu, 20 Feb 2025
 17:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
In-Reply-To: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:11:51 +0800
X-Gm-Features: AWEUYZn7Xt5dPTAQ_1hit6NTeptFL4Ci46JoPA4BIky8CLGqgwWNZBKnelGziLY
Message-ID: <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: break and reset virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AtShKLU6OIhMOZZ882MVM0yyYDmYIaw61D48kG0S4EA_1740100324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
>
>         Invalid read at addr 0x102877002, size 2, region '(null)', reason=
: rejected
>         Invalid write at addr 0x102877A44, size 2, region '(null)', reaso=
n: rejected
>         ...
>
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.
>
> The issue is that virtio-console continues to write to the MMIO even afte=
r
> underlying virtio-pci device is reset.

Some of my questions were not answered so I need to post them again.

Do we need to fix vitio-console?

Note that we've already break the device in virtio_pci_remove():

static void virtio_pci_remove(struct pci_dev *pci_dev)
{
  struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
        struct device *dev =3D get_device(&vp_dev->vdev.dev);

        /*
         * Device is marked broken on surprise removal so that virtio upper
         * layers can abort any ongoing operation.
         */
        if (!pci_device_is_present(pci_dev))
                virtio_break_device(&vp_dev->vdev);

...

>
> Additionally, Eric noticed that IOMMUs are reset before devices, if
> devices are not reset on shutdown they continue to poke at guest memory
> and get errors from the IOMMU. Some devices get wedged then.
>
> The problem can be solved by breaking all virtio devices on virtio
> bus shutdown, then resetting them.
>
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c1cc1157b380..e5b29520d3b2 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
>         of_node_put(dev->dev.of_node);
>  }
>
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +       struct virtio_device *dev =3D dev_to_virtio(_d);
> +       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> +
> +       /*
> +        * Stop accesses to or from the device.
> +        * We only need to do it if there's a driver - no accesses otherw=
ise.
> +        */
> +       if (!drv)
> +               return;
> +
> +       /*
> +        * Some devices get wedged if you kick them after they are
> +        * reset. Mark all vqs as broken to make sure we don't.
> +        */
> +       virtio_break_device(dev);
> +       /*
> +        * The below virtio_synchronize_cbs() guarantees that any interru=
pt
> +        * for this line arriving after virtio_synchronize_vqs() has comp=
leted
> +        * is guaranteed to see vq->broken as true.
> +        */
> +       virtio_synchronize_cbs(dev);

This looks like a partial re-introduction of the hardening work, but
the ccw part is still in-completed e.g the synchronization requires a
read_lock() and depends on CONFIG_VIRTIO_HARDEN_NOTIFICATION (which is
marked as broken now).

Should it better to

1) fix the virtio-console
2) simply rest in shutdown
3) wait for the hardening work to be done in the future?

Thanks

> +       /*
> +        * As IOMMUs are reset on shutdown, this will block device access=
 to memory.
> +        * Some devices get wedged if this happens, so reset to make sure=
 it does not.
> +        */
> +       dev->config->reset(dev);
> +}
> +
>  static const struct bus_type virtio_bus =3D {
>         .name  =3D "virtio",
>         .match =3D virtio_dev_match,
> @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus =3D {
>         .uevent =3D virtio_uevent,
>         .probe =3D virtio_dev_probe,
>         .remove =3D virtio_dev_remove,
> +       .shutdown =3D virtio_dev_shutdown,
>  };
>
>  int __register_virtio_driver(struct virtio_driver *driver, struct module=
 *owner)
> --
> MST
>

