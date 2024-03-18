Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FE219E1
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710735931; cv=none; b=Lldi2u24G3BQGH1UEndT4xhrKfC6QLVxjl9neTWYBPg/VTyxQfzHajNtl62J5/msEQKILj2pzsB2OmViPnukyfXN+YbcI+HvUocs7MLu36BMG7VBtD0GbxK38sI4Z8voTWLR6+EkUve58X2sWDJmc89TZKMxlsXpOilF7tdQctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710735931; c=relaxed/simple;
	bh=Y3lvIa7r1T7plzamDCTxHqHFnC1uVRkFx2ZJV66v0tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzE877h6MaCYdT3+D8zxcz4MMKCu8OPSNAggXUuSyigoFoCmKe6s0wqB+WcbfYtL6eYp2DX53WaonOoQzVAc/GfyPqkw5vYIyyMdvA3SZ+ePMfGkbfXE9KReeoz5CQGukpK58qQstgtzHC8R9jSx1RSnzaX0yvAjjOBuBvZtQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9jiFcd0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9jiFcd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710735928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+f2Yy37boxEGzD9uVQM30+V21T1Eg5rpVVY+kgQFH/o=;
	b=g9jiFcd03BhX80RrYstDFJSA2WuP4p3IfRZKA+c5/NFmnM67el+8WNyAvc2yujbxJJzsDo
	Xoi5YmqbP2YGkAClCTtFhzABcAymBe27eJ5HIuJ1dEJzgZujKbymwqDJ3L7hcl6ZKVrS/o
	Sd01AchWdaE8ftCiK4ckstlrbXV8GMY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-eoVpMKIdMFyq-fdEVFIJ-Q-1; Mon, 18 Mar 2024 00:25:27 -0400
X-MC-Unique: eoVpMKIdMFyq-fdEVFIJ-Q-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c236e9056cso4759289b6e.2
        for <virtualization@lists.linux.dev>; Sun, 17 Mar 2024 21:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710735926; x=1711340726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+f2Yy37boxEGzD9uVQM30+V21T1Eg5rpVVY+kgQFH/o=;
        b=mysKM9iIGsr47+3UwMxdiE0WaxkdW+gshos+S1rKdpDYPmjpmwWeWF89rp7hBCB/T6
         GNTEDXn0XO39TgcVNMEWZRo8aOTdqJI/d5sUfGal9Zfqe+H3MuxL8uiVMt3VmEvAwVdy
         gq74LAEijwmp+vaekmGBWVhYvkixj4zvMnn4dCcaPOdNXdfsEr/ghXZHYEB0b4eyMiLz
         Rkzg7gZEMOXNa0hRl6ICv25B0hO9xnY4z5bvHxiQsUNYRkyIh3nf01AaULaFFzJ3OjuY
         KRuXftBS6vDmPQApZI2Z284JcOScblU5y88H1OXUCvAy4HFtj4ZdgfExMzm4shcDUfr1
         0wjA==
X-Forwarded-Encrypted: i=1; AJvYcCVVhQVXNQ5h32p+PMkMVGuQWrOld+ByvCkNSvneKbMMV7hvRGGg8y/SKDyn0mHQHxrTPwsgCjvMUaB4Ts2iVjghZu2lgw3y/KTE3w0x+Vk=
X-Gm-Message-State: AOJu0YwprtV/oajKJgfDArlV8mgNgUnkgXyDiNPhuzrHpTpwW3qrah9L
	NBGp/CiB37vY5aAYlwP6i/6V99Wfz23UvdZuVwIP2CKGXUtYmRq+0XP5aL2zWyAeebW8oIpbRMV
	QY/f9UCG2OV5IgmKPiPaogjLg+slyazfGwgzTAUgj6Z0jGzCT4Hn5v+oW9+6xuBgUrcYtm8cK1u
	RIW6WNf+jW42fW4I3keEakpgWJod9YE1KHcD2uIz4=
X-Received: by 2002:a05:6808:648d:b0:3c3:789c:478f with SMTP id fh13-20020a056808648d00b003c3789c478fmr10568011oib.54.1710735926454;
        Sun, 17 Mar 2024 21:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH3sEKCS6X0hA6utjgd+yWDrc3N2bA097jiTonFQhTDFLPntEgFVDG59o0wwf+9WsZqiOTm+WJJCkq1zWVRkk=
X-Received: by 2002:a05:6808:648d:b0:3c3:789c:478f with SMTP id
 fh13-20020a056808648d00b003c3789c478fmr10568001oib.54.1710735926209; Sun, 17
 Mar 2024 21:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240315102857.1803-1-gavin.liu@jaguarmicro.com>
In-Reply-To: <20240315102857.1803-1-gavin.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 12:25:14 +0800
Message-ID: <CACGkMEv9-bmdsVdkbg+-V6i6yP9WGHkt3J9PpPyeuGx7uc4fAQ@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: Fix return value check vp_vdpa_request_irq
To: "gavin.liu" <gavin.liu@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	angus.chen@jaguarmicro.com, yuxue.liu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:29=E2=80=AFPM gavin.liu <gavin.liu@jaguarmicro.co=
m> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> In the vp_vdpa_set_status function, when setting the device status to
> VIRTIO_CONFIG_S_DRIVER_OK, the vp_vdpa_request_irq function may fail.
> In such cases, the device status should not be set to DRIVER_OK. Add
> exception printing to remind the user.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..c1270b263867 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -213,10 +213,16 @@ static void vp_vdpa_set_status(struct vdpa_device *=
vdpa, u8 status)
>         struct vp_vdpa *vp_vdpa =3D vdpa_to_vp(vdpa);
>         struct virtio_pci_modern_device *mdev =3D vp_vdpa_to_mdev(vp_vdpa=
);
>         u8 s =3D vp_vdpa_get_status(vdpa);
> +       struct pci_dev *pdev =3D mdev->pci_dev;
>
>         if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>             !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -               vp_vdpa_request_irq(vp_vdpa);
> +               if (vp_vdpa_request_irq(vp_vdpa)) {
> +                       WARN_ON(1);
> +                       dev_err(&pdev->dev,
> +                               "vp_vdpa : fail set status is DRIVER_OK\n=
");

I think having one of the WARN_ON or dev_err should be sufficient.

Thanks

> +                       return;
> +               }
>         }
>
>         vp_modern_set_status(mdev, status);
> --
> 2.43.0
>

