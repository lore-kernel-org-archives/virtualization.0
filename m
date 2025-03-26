Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E232189919
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997595; cv=none; b=Dw0fjX4vy7liO5bQfSvClJXbBONEHz746XSVMmZzT8aFhy1CyDWT4v9Tj660l3jGN8H7VB5SGT43UMxRMlUpe/qpFRenHyL6QkrO7v+nFd7xGX0QBpCkqS97iv3uepHRtENO7UtB3AYdezaUJBHgLn/qukyfLf0r2UXqV3D0kCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997595; c=relaxed/simple;
	bh=naBbMN+Z/QrCKhz1hprq5AA2OwjE/1RWZqyCZLewyKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U09+fgu9LJ2LxsffZqJNnoj/LT6GE2VAEiBSvwtdLD7KAtXG5//ni8h0Y0JBWja1iRPOGI0SiW8owXcvtQSqOGJts+QObouv6SdQR07IHUNwWsTtjDyrFobo9jMUd8ESAa3RFokYW8yuyhKYtY+Vm+66XadlQKQflR3UZ+ydyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0DEDfxa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0DEDfxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac9lR/a3T+g4DECgHB+aeJUFPmg8S1RQjX/Rd9g8lZQ=;
	b=i0DEDfxaYi1h1MZHoc+Oxvbu3LIxmqFKTPvRh6ERaTK74+qYoB8fJkcaig+FwwaBH0u7tV
	qUSXbW1XakLnS9k1aTPC6couv8uLK2LLnGtAFdrdnRSAwEXaUAAViqWIROBBu8aAGYGgzF
	Kdz0WOVD1n9V5KIgjMupMqf5g2559ZA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-3BpiS1bwMNeVfx4pP-s5IA-1; Wed, 26 Mar 2025 09:59:51 -0400
X-MC-Unique: 3BpiS1bwMNeVfx4pP-s5IA-1
X-Mimecast-MFC-AGG-ID: 3BpiS1bwMNeVfx4pP-s5IA_1742997590
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e623fe6aa2so7094887a12.2
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 06:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997590; x=1743602390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac9lR/a3T+g4DECgHB+aeJUFPmg8S1RQjX/Rd9g8lZQ=;
        b=gln3nPMjElpcFSo84KurQYqnL9AiiCzDenYbWlKdPi1adyu0NE8xVq0m3IqNNDdiF2
         tPo2L8FGeIaG8gePfcZHdMwMitKYnh9TUhUzMeMcP7Hz7LCkq5sedB5uDpnJm4nymoaw
         aurEO3Rg25DnDtZEwZSmjWPvihUgTC0xtJ7nX1bNJJf0tL1G8mGAsjRaKcO5LhV3uIpz
         r5+YPl8+A8Ny4s9wsiRYKpC7Ou67cYk2Gxq7GOzMJ0XBnO116nVWDK086sLu5ltG0LEh
         7FXLcuz1cenEwcBlEPPYm9GXRNsbEylqPE9g1VO7gDeUwt6ZBr8boFvji0QNklXmS1W7
         2VuA==
X-Forwarded-Encrypted: i=1; AJvYcCWshPW/OTn+6eerup1hYEQISbr3dxTgSIXq3GIDYT+/UYSWdgWz2zMlOKVlh9fauVGltqJN4PsF7TNTvXwu9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXGXO10wmkTbV1dsUGYpDFEwH1NXS4A8iTvFJZBEGeieRGtPYM
	LNHyYbmar8xgTrcoRJTMltLdS5K6qZgSMcKZXyRQiUpKW1QJ+xNbb2RU67KJmMCjQtPygt14jAb
	nveqSGtesUoB8lh014x2yBeP02bMylQyt2ZB3+GzRY3fs2pBYkOZT6TbdsnjEBLJHlFtPPAblik
	OsX41S5sb0YI9qaMVBt2nZ/ShdRVa3rRkKTzhdABI=
X-Gm-Gg: ASbGncuIl0OvYUk7OFxJQf/8SZaiiJfSQexaXFRYzVoLz77S2oNSDodSk0+L79e1+ax
	iKPUtM3IqEyxNc8hRD9FbJehNIpG04LGs9YVFbkI0/m0m8c7avgCVjOR9Cs6R2YXSnYdMnSU=
X-Received: by 2002:a05:6402:26c5:b0:5eb:9673:183f with SMTP id 4fb4d7f45d1cf-5ebcd5079bamr18661041a12.20.1742997589708;
        Wed, 26 Mar 2025 06:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOQ6NUckS+xXBnunIYqJLGGk/ys0rYj6s3e6MMC3qIrPaq6ehNhf5XM99eBkVg8YzGPe9eVNrniA8BKLnkbsA=
X-Received: by 2002:a05:6402:26c5:b0:5eb:9673:183f with SMTP id
 4fb4d7f45d1cf-5ebcd5079bamr18661021a12.20.1742997589325; Wed, 26 Mar 2025
 06:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-3-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 14:59:11 +0100
X-Gm-Features: AQ5f1Jp6GIhtHCW2n8iLMhVMu4dYdPe7ajIlwNK2G4GZTDXvWLYRK_4k0enRSL0
Message-ID: <CAJaqyWewrOB3bQnL4=2FF-jhK8FhS_eU9TVKRZ0AG-ZY674ffQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] virtio_ring: factor out core logic of buffer detaching
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fKZKmJ-9ZHmjmuwLZrG6Yvk3VhM9ALidye5UetYdkpw_1742997590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out core logic of buffer detaching and leave the id population
> to the caller so in order can just call the core logic.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 31aa4a935c27..fe3e6f3d0f96 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vr=
ing_virtqueue *vq)
>         return needs_kick;
>  }
>
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -                             unsigned int id, void **ctx)
> +static void __detach_buf_packed(struct vring_virtqueue *vq,
> +                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
> @@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         /* Clear data ptr. */
>         state->data =3D NULL;
>
> -       vq->packed.desc_extra[state->last].next =3D vq->free_head;
> -       vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
>         if (unlikely(vq->use_dma_api)) {
> @@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtque=
ue *vq,
>         }
>  }
>
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +                             unsigned int id, void **ctx)
> +{
> +       struct vring_desc_state_packed *state =3D &vq->packed.desc_state[=
id];
> +
> +       vq->packed.desc_extra[state->last].next =3D vq->free_head;
> +       vq->free_head =3D id;
> +
> +       return __detach_buf_packed(vq, id, ctx);
> +}
> +
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>                                        u16 idx, bool used_wrap_counter)
>  {
> --
> 2.42.0
>

