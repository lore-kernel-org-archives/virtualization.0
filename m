Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC81F1303
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997700; cv=none; b=LE8cmLsppT0loFXUDwC91XTtzoJQRqOb85DkiER4TonIXYK00sxvIyxPvuPvc5aoXv/9sU95t1b8RrJzNJxa28niWv75/e7B9alzZ8TmaSMGDfiIBkFu+EVYSC7oThmx3j8jOI6+M0Ag+IpobMNotVFbxAPrPAC9bpLqoC7vNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997700; c=relaxed/simple;
	bh=OzD2J58SYOwB2yDqTE1mn52U7OmtWFJwIChYYjGgtbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgbntSAO4wkKOGoVmM/7DlHrklYX4JNYp5lWYM6VA7IILV9q4cUH4xnZzEA4Zy3RQmvypW5gJTRhxuSPq3eKfjCl66Jc57xexk3XNZKwuWy33JYDva13+dK2f1LvL33+915E0+iWahClzVjOQMHGw0QOAZiyEzzeTnwFj4jpP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LX4TtcBM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX4TtcBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5ynOER4mzzMilZC5d1UHwb8YZwTVg8BWon4ImvG5J8=;
	b=LX4TtcBMlLwL0mf7igEjLkqXCYX9uHAcoNDcvfWvT7WVGZ3IesSAiZDDoucZEHpDqVuAOB
	dt/RRvHtZDK3iL+Xs9o6xeAHil+nPjKwZdo5x6EBm+xlLLWeSe3qtupQ3o9zQv2x0I2Baq
	lhBDCF//Xav8pGIABnPtQK/Qof0E9po=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-2Ya8tvV4PcmNB8SaLw1gxQ-1; Wed, 26 Mar 2025 10:01:32 -0400
X-MC-Unique: 2Ya8tvV4PcmNB8SaLw1gxQ-1
X-Mimecast-MFC-AGG-ID: 2Ya8tvV4PcmNB8SaLw1gxQ_1742997687
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac27d8ac365so448184866b.2
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 07:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997686; x=1743602486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ynOER4mzzMilZC5d1UHwb8YZwTVg8BWon4ImvG5J8=;
        b=KKs5uOvFaPlq2EBDj7KHEu2FPyGwlMi7tMKh4RcFvNcJNClpJtmGfm7093xjTM9M2R
         IXiJNZZBVW50mvMLKiCTbgnRweJ6RdzpTgMsdomVmFxWkb0bYOg+eIqm7n99/ZonZ8Dy
         5P2Q6T7dWJ4E5CtJNyb9CxpFBvyJl7JCGdzq51XLnVf9eU8/oiDM+tmaZ1KdF6zDIID8
         cn/2c9RjFg5ijZMTM6IxXXCTtBvgvPTPxXTF3AwJyZ7ZCVzFHw2GouGdPKLj8WFr4IsD
         RCqFdEWLb5CVavk/qP2LysaibiYmsNbZ5MbYcyAdWOJX0Rx+LCXMKp2O9JT/mZF7g2w0
         pBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVI+B72TKGC+KAx1Vv6Lx2jJFfCyoK/wEPUbq+jJ8Vst64sDxFPE3IHs7nmeSXXnWcY1gm9pNWtIprJwo3iHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxorOQkKI3ZYuhzhqSYluAtVCl9xxSLvEEDSr+jIRVor59k34GV
	Xm6Gag3oehJr2dx8JTXFXbWJAXe7SxG4RGp6bvekMuupWRuKATTYoRmhBOxzb0vEdEd1HCrVc6N
	7p0gEb9Uv1MbahVq9Uo3meFER58VyPCJMKCX8xGEDK7H8I9UuLWyNTYnoqyk4e81BlEe9bAPS87
	tEUQyg6bY7w9oump3B5uPtC5NGOm6Ms9V9M/HDmI8=
X-Gm-Gg: ASbGncugrdF499Qxh1Rzq07lI/nPdRUDM5V/+yb74HWmA4oh0lDPrLUaPXwmTzQdGW9
	EJIm1R1vb81dGAF1EGB/ho+MnA+n1oOMHK9CfkE29naiIhiAw/4tgZ/BFXn7ZrXXTk2rejQ0=
X-Received: by 2002:a17:907:7e5e:b0:ac4:5f1:a129 with SMTP id a640c23a62f3a-ac405f1a286mr1833708566b.15.1742997686332;
        Wed, 26 Mar 2025 07:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZWMfF0qvpznduI2fyVWwvyCi88++3cklgjOFWP+86MHvJ8ZbEJ5hy7FQdtX0Z8LvVrmee6EcMcbESp39/80=
X-Received: by 2002:a17:907:7e5e:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac405f1a286mr1833701966b.15.1742997685769; Wed, 26 Mar 2025
 07:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-4-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-4-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:00:48 +0100
X-Gm-Features: AQ5f1JofivsiKPGTGocKmP1oEUGTJ8yrW1FHIDHFG3jB8_FllpLx33EoChopQ5A
Message-ID: <CAJaqyWeuPSQZJip-z3_g-HEP0jVP7JH6gskpi-uPJOPQkR+Yug@mail.gmail.com>
Subject: Re: [PATCH 16/19] virtio_ring: factor out core logic for updating last_used_idx
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F9t-HuwVR0BwTQ8IQfmrw69QnH9zuJef4RO2VTeK8J8_1742997687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out the core logic for updating last_used_idx to be reused by
> the packed in order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 43 +++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fe3e6f3d0f96..bd4faf04862c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1749,6 +1749,30 @@ static bool more_used_packed(const struct vring_vi=
rtqueue *vq)
>         return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>
> +static void update_last_used_idx_packed(struct vring_virtqueue *vq,
> +                                       u16 id, u16 last_used,
> +                                       u16 used_wrap_counter)
> +{
> +       last_used +=3D vq->packed.desc_state[id].num;
> +       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> +               last_used -=3D vq->packed.vring.num;
> +               used_wrap_counter ^=3D 1;
> +       }
> +
> +       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> +       WRITE_ONCE(vq->last_used_idx, last_used);
> +
> +       /*
> +        * If we expect an interrupt for the next entry, tell host
> +        * by writing event index and flush out the write before
> +        * the read in the next get_buf call.
> +        */
> +       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> +               virtio_store_mb(vq->weak_barriers,
> +                               &vq->packed.vring.driver->off_wrap,
> +                               cpu_to_le16(vq->last_used_idx));
> +}
> +
>  static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>                                           unsigned int *len,
>                                           void **ctx)
> @@ -1792,24 +1816,7 @@ static void *virtqueue_get_buf_ctx_packed(struct v=
ring_virtqueue *vq,
>         ret =3D vq->packed.desc_state[id].data;
>         detach_buf_packed(vq, id, ctx);
>
> -       last_used +=3D vq->packed.desc_state[id].num;
> -       if (unlikely(last_used >=3D vq->packed.vring.num)) {
> -               last_used -=3D vq->packed.vring.num;
> -               used_wrap_counter ^=3D 1;
> -       }
> -
> -       last_used =3D (last_used | (used_wrap_counter << VRING_PACKED_EVE=
NT_F_WRAP_CTR));
> -       WRITE_ONCE(vq->last_used_idx, last_used);
> -
> -       /*
> -        * If we expect an interrupt for the next entry, tell host
> -        * by writing event index and flush out the write before
> -        * the read in the next get_buf call.
> -        */
> -       if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_=
DESC)
> -               virtio_store_mb(vq->weak_barriers,
> -                               &vq->packed.vring.driver->off_wrap,
> -                               cpu_to_le16(vq->last_used_idx));
> +       update_last_used_idx_packed(vq, id, last_used, used_wrap_counter)=
;
>
>         LAST_ADD_TIME_INVALID(vq);
>
> --
> 2.42.0
>

