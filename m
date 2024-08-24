Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B3EEC0
	for <virtualization@lists.linux.dev>; Sat, 24 Aug 2024 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465221; cv=none; b=ebImFX0SbFPE+kAr5bobRjliy4Hm39q0OlONMiMmTVZ4F2YdasFkrmktJKJWSxXYWJk+ZLbK3gkvAgfGeFt8qlr5xz4VIMhPPJumy6Db4jO65RMWfgtAwfVjTkR3wjRUqsc8SSLsi2S4uXw7r7E8rQEaqs0mBelUfOYaZIgUW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465221; c=relaxed/simple;
	bh=L1a/fLuZOGUu5Zj1RuXcZgKqEmzDqs688WLUixmKdkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD82W9bYt7tvGd407Wggsk35iTtbHo7xDA0bcZarm9thg5tPiLsmhLEs5+GMORwxPK39EnaUrIkyYQ1UlDCzzc30veEp19H/29QDOwXNJD9OmwBvpi3rh7PhUmijJytrMZc+evQhJCR/tFZcynCOxIYwEcpBPqlySiuVAsyjg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+B4XpGH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+B4XpGH"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a5074ebb9aso156304885a.1
        for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724465218; x=1725070018; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38U3TamQgtOMpIheDUaSqju5cn7JqVNPQVT6ndofX00=;
        b=P+B4XpGHUiwHhcReWm22LcWsM4iZsmLERM7hwBcMfknxsZ79nCnqo2iO/QdRUwLuWM
         6TbtIl/a/3H0yFuBBL6EFTf8J9EFOPy2akO69+YdDQ1JsLjh+qMHCBuOeDHNYLB3ye3T
         cHUTIsOF6bndfbsmBnoV2T8tn1OnjagV4gXTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465218; x=1725070018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38U3TamQgtOMpIheDUaSqju5cn7JqVNPQVT6ndofX00=;
        b=ExU2aIkCCbt04Nc5Q18QPmEZoHDyjRZa6s6Gh6bZ7SZQzPNAwA+414aKSCzlsgAlCl
         0EdiMSpeE/qvnpp2pfJ+XjIBYLTb9PqT8LGPhChVsSuEJe0TLmEPmA8ICMeX0ZtepGlr
         DGMKZgQLNkJCxun60EfOkg4/Blsl3fzqUH2XealIxu1Ux1RRcBPXrNjhKE1bYqSvHkRv
         uqMPgk8ZMV6RbUS/vUPcNQWDR3HhOjPyfhUq7nHzv5hy8M4o/8nKQRBBxnISxgD4rLG/
         uoS2YmmPvgmHbEoKDRxz85yAazrXGtlmD16la9Qkz0N4BZ1bIqvg4vdD9RtUnZ7+gdIj
         N9Nw==
X-Gm-Message-State: AOJu0Yw2QWebPe5omshXz5nQiasJdsoTktg/aWNphG9mhYRgEzQhF0Le
	HcwfYH8kX6rQY0LPHBTqrZxARdDm7kYK4LDFYx1irvxHMfxo+RjekbWWRLr7kHbNt093+qAR29r
	E1kaq9mmGbTdIL8gnTIARHgZDLeCsDVjYykyb
X-Google-Smtp-Source: AGHT+IFuyHAil0u7ZWb4xCIHUwmhAwZMPgDdoKeyRsz9kcT37qgzsuYEH1oVBYR6znpm0ntncsND145bSWsjf+QJzJM=
X-Received: by 2002:a05:6214:5a04:b0:6bf:979a:34c8 with SMTP id
 6a1803df08f44-6c16dc9635dmr48532596d6.33.1724465218039; Fri, 23 Aug 2024
 19:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240815004617.2325269-1-philipchen@chromium.org>
In-Reply-To: <20240815004617.2325269-1-philipchen@chromium.org>
From: Philip Chen <philipchen@chromium.org>
Date: Fri, 23 Aug 2024 19:06:47 -0700
Message-ID: <CA+cxXhneUKWr+VGOjmOtWERA53WGcubjWBuFbVBBuJhNhSoBcQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Add freeze/restore callbacks
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

Can anyone let me know if this patch makes sense?
Any comment/feedback is appreciated.
Thanks in advance!

On Wed, Aug 14, 2024 at 5:46=E2=80=AFPM Philip Chen <philipchen@chromium.or=
g> wrote:
>
> Add basic freeze/restore PM callbacks to support hibernation (S4):
> - On freeze, delete vq and quiesce the device to prepare for
>   snapshotting.
> - On restore, re-init vq and mark DRIVER_OK.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>  drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index c9b97aeabf85..2396d19ce549 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_device =
*vdev)
>         virtio_reset_device(vdev);
>  }
>
> +static int virtio_pmem_freeze(struct virtio_device *vdev)
> +{
> +       vdev->config->del_vqs(vdev);
> +       virtio_reset_device(vdev);
> +
> +       return 0;
> +}
> +
> +static int virtio_pmem_restore(struct virtio_device *vdev)
> +{
> +       int ret;
> +
> +       ret =3D init_vq(vdev->priv);
> +       if (ret) {
> +               dev_err(&vdev->dev, "failed to initialize virtio pmem's v=
q\n");
> +               return ret;
> +       }
> +       virtio_device_ready(vdev);
> +
> +       return 0;
> +}
> +
>  static unsigned int features[] =3D {
>         VIRTIO_PMEM_F_SHMEM_REGION,
>  };
> @@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver =3D {
>         .validate               =3D virtio_pmem_validate,
>         .probe                  =3D virtio_pmem_probe,
>         .remove                 =3D virtio_pmem_remove,
> +       .freeze                 =3D virtio_pmem_freeze,
> +       .restore                =3D virtio_pmem_restore,
>  };
>
>  module_virtio_driver(virtio_pmem_driver);
> --
> 2.46.0.76.ge559c4bf1a-goog
>
