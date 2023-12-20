Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3A8F42
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbe9WYQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIn5APMs5q/H2mkbVIU64Mx79XhFiyV1fy9ppFrUsQ0=;
	b=Qbe9WYQVvKZsvb9ts2k2tf3a5aNhVgfH4JJSnmb3t+ljzR7Y7wE/GG8e0qydiuUTrO2NWz
	pIW2Z7X8GzJeNyZ87xQflhObIAlPuEhmUBjXWZhqPmb3vrPyMmPEjF/7lh1Fn8buqPutlm
	Io8MzpIpvAw3B8HjruIEYmdChb2pRko=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-3FTlRBHgOoaktlktR-lppg-1; Tue, 19 Dec 2023 22:52:58 -0500
X-MC-Unique: 3FTlRBHgOoaktlktR-lppg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cd86813215so3229482a12.0
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 19:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044377; x=1703649177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIn5APMs5q/H2mkbVIU64Mx79XhFiyV1fy9ppFrUsQ0=;
        b=AYdSEz3gOvSKNbORuQzQP6q4/Ju248QeHvP3SJTccw5CNkNXlGFiXZcqgHWW3nT9oJ
         Qol1LBmAXq3sJ0K3Xo60Q7Kaa329TdAzYoXD8yBshWBJQthSvpDQWSnNs7GYgMMHiPnw
         A/EznAo6zshiS4BvxfHf1+TP+WsWyEQszgR/TgGEv2C2VTn9/TuIvPBaSwZzkkTdL4Wm
         PQI0DW+Xt+cta0SRFNuX18sNiXCnk0rOiexM4UNW9nisqWZHCAuCyscDb8DkhtBHm0L8
         1aKJvEeDqSVtP+vPDGyxN+UyE9+1oNgZUAimo3JiFCev4MYdcx5EGsa/Hwxji/dcXqj6
         zeYw==
X-Gm-Message-State: AOJu0Yx4QgK5Zb2un7BM+KQeT2OnirRVczI/LFtbI6lnS/2/pxWb4fZq
	/mjKz+YpyaRxnt93LZD8wkt4Ue1hfVhWW5hLU0U+G3dJ2JGR8ohptHPZRb89HiiI9HR4xsOu37E
	D9mK7dj+ogKXUXWroY5Qxr7UskE/q8sbP1Mqxkw1a/V4Xwf0C13E8mQ==
X-Received: by 2002:a05:6a20:9225:b0:194:cb44:b0b4 with SMTP id i37-20020a056a20922500b00194cb44b0b4mr526128pzf.2.1703044376848;
        Tue, 19 Dec 2023 19:52:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnMr21VcQdQT+Lk5xChXSsBuDnDzHafReZLcU6LBc8taYyagaiLau7y0wRNSCh7k4SnAF95Kz+VAAjOKYBcWA=
X-Received: by 2002:a05:6a20:9225:b0:194:cb44:b0b4 with SMTP id
 i37-20020a056a20922500b00194cb44b0b4mr526122pzf.2.1703044376631; Tue, 19 Dec
 2023 19:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:52:45 +0800
Message-ID: <CACGkMEuE5a29uXXWfy1Ma+ZqSzWKhS1J1b2XHvhyC90wDFP02g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:52=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> This is less verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a7612e0783b3..d0695680b282 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -131,7 +131,7 @@ static void vdpa_release_dev(struct device *d)
>         if (ops->free)
>                 ops->free(vdev);
>
> -       ida_simple_remove(&vdpa_index_ida, vdev->index);
> +       ida_free(&vdpa_index_ida, vdev->index);
>         kfree(vdev->driver_override);
>         kfree(vdev);
>  }
> @@ -205,7 +205,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device=
 *parent,
>         return vdev;
>
>  err_name:
> -       ida_simple_remove(&vdpa_index_ida, vdev->index);
> +       ida_free(&vdpa_index_ida, vdev->index);
>  err_ida:
>         kfree(vdev);
>  err:
> --
> 2.34.1
>

