Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FB3A8723
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380294; cv=none; b=t7waz0He59ucekNp4bjU2SMXq8uEBU24NDBdhWUwzV4T1zCW3DD/yRwFwdjEM/fEJpffFnB3uW/Uk+t4eJsq4hLy0x3VY+iSnhoqOESu9gJqFAkXsHFXAac3zvwqFH55+TlZv4MhZRjXZ1u3fMCuKiO4t84LBv64aaeEEQdVvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380294; c=relaxed/simple;
	bh=b2Chk3KE5vRUlzHTKUuKLrrOdxDtQednmI0BKOlwl7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgwOT2Xz+T+bk4isMMT1+MBaIsv+nlCrijg4Yeif8mVSw/RYJeYYOZRYgzULYcGFmp/AV4xnKP81QgmVJZmRavQVdEwr4TaicHJBQ8HZPH9aOvq7QLoNc7RPx3+ZCu4TZ2a8oMx3kNaDKg2fX8K3uSBpQT5ciqlzLChcIOIxdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Euwir9wi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Euwir9wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780380292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iPiMkEyNVXBImOZyWjM4JFSfbnj/LQgbUYrr43Fg8Q=;
	b=Euwir9winG1QcT6LWT4/Du9WkLKmA6kRkqZP5rgJI3fT+7ChgE9KMAm6p2ylXCm7HrJHtb
	9L8fKvlXik9L3eVoTt9Dn9KlDHtpo2yBzcImfURIpcxeBs+F3nu7nrXp/vY2MtB2wFMb28
	kaDCSiNU4dKqvDZBbH+sfDmCVc6GXdM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-nN8Hh3ryPrGMsE_rcJd1yw-1; Tue, 02 Jun 2026 02:04:50 -0400
X-MC-Unique: nN8Hh3ryPrGMsE_rcJd1yw-1
X-Mimecast-MFC-AGG-ID: nN8Hh3ryPrGMsE_rcJd1yw_1780380290
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7dbb5e586c1so108686337b3.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 23:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780380290; x=1780985090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9iPiMkEyNVXBImOZyWjM4JFSfbnj/LQgbUYrr43Fg8Q=;
        b=Gv29uBoKse/sEUztxdhJo2Cf4ueyqMYPq2t5Ro8EG/JMZlRABh4j1AGxNYvUqJgDqI
         u4zIpZhsci7Z59Li5n8oOCBpsUpOOigQ2tTcr9DNMyTl0R0YOg8+5fyHIsIfEiDycsd0
         s8Ns/0c3C6unIbghUw3u+q4OETjWzCmPfbDnx+ssjiicRKFhJWxbHh4OklHeMwpV4Tfw
         /1Ua8BJw9hXVWcBpR545mlV6ZL7E1b/+vPk+aNGYBVsF0IOYTOR8ikydc99AI7tzJmt+
         AhmEHjE7Y4iXB/sJAGmNoY8aqyWM66jH7weQ6l6ZVd3qmBwCpKC8MJVV4oZa/Vy7MZyP
         oT4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+bFG2kiVwBRUZgNuEkmZtbhT5BEmsPY3MEStvGzs32t4+4KK2m+LBek0egrz053q2HDOLUOkqGclTwxKn5dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylWmQrRHc86FVraaiioq6uVZztgltfDm8SGUJPIhJLtyb9WZof
	jf/b3nWpKMrF7eAIh6jhzXG5PNbk5tblv8Vlcp9mVn3kKyyJ3P0JA8shNXtFfOM+m5Bdx7dfquQ
	Huvpao9MtVQ1w01Y+AdDIt8vyL50hnWVh3646/hX92ZVh612OpSKYzMhiNqpWaEKBVzCtZurq+s
	Zq6b6wn6J12zVA09M+DWQ/gy8QxDieVkjtJZ8TzlrRzLk=
X-Gm-Gg: Acq92OGGJL6z33EmpBF5N7dk96sqk/5S9u9UKpWeRtFlNOgF1EeOX1GBYPUEaJJj/3e
	EgfVUA9mR0MGunxwgMBkNQXjdqHwK07YLzBPGhIuMFSjKBliroBrqtMAjn/USAYSlmVG/b5FKXp
	k5B+WNpC4IHVU+UUCFHvOg/NmG2qBYO2XZXIQXO0KVW9DHbaf163wky/qmUt5UZWIoigUWLQ3lV
	6DMEXdLhS1Alx58Pg==
X-Received: by 2002:a05:690e:4087:b0:660:7f6e:509e with SMTP id 956f58d0204a3-6607f6e6fc9mr6997608d50.31.1780380290074;
        Mon, 01 Jun 2026 23:04:50 -0700 (PDT)
X-Received: by 2002:a05:690e:4087:b0:660:7f6e:509e with SMTP id
 956f58d0204a3-6607f6e6fc9mr6997593d50.31.1780380289633; Mon, 01 Jun 2026
 23:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260602043123.10207-1-yangjiale133@163.com>
In-Reply-To: <20260602043123.10207-1-yangjiale133@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 2 Jun 2026 08:04:13 +0200
X-Gm-Features: AVHnY4IcXg0UrcTC59d5L7Yblyer5llUu0BZmRKhb2vOXqasvjr4DO7J-mfKd_U
Message-ID: <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
To: yangjiale <yangjiale133@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aADO0q8GIZsjKpJdv3wAR0X4GSORoNwle9kbGwNYDFI_1780380290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:34=E2=80=AFAM yangjiale <yangjiale133@163.com> wro=
te:
>
> When a descriptor list spans across cache lines,
> updating the flag first can lead to a scenario where the device side
> perceives the flag as valid, yet the corresponding address and length
> fields remain unupdated=E2=80=94resulting in invalid values.
> Therefore, the flag field must be updated last.
>
> Signed-off-by: yangjiale <yangjiale133@163.com>
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fbca7ce1c6bf..036b4f90d30f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vrin=
g_virtqueue *vq,
>                                              &addr, &len, premapped, attr=
))
>                                 goto unmap_release;
>
> +                       desc[i].addr =3D cpu_to_le64(addr);
> +                       desc[i].len =3D cpu_to_le32(len);
> +                       desc[i].id =3D cpu_to_le16(id);
> +
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
>                                     (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE=
));
> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vrin=
g_virtqueue *vq,
>                         else
>                                 desc[i].flags =3D flags;
>
> -                       desc[i].addr =3D cpu_to_le64(addr);
> -                       desc[i].len =3D cpu_to_le32(len);
> -                       desc[i].id =3D cpu_to_le16(id);
> -
>                         if (unlikely(vq->use_map_api)) {
>                                 vq->packed.desc_extra[curr].addr =3D prem=
apped ?
>                                         DMA_MAPPING_ERROR : addr;

These flags are updated before the flags of the head descriptor at the
end of the function, at "vq->packed.vring.desc[head].flags =3D
head_flags", so the device should not see these. Because of that, the
relative order between the rest of the fields of the same descriptor
or other descriptors' fields, except for the head descriptor's flags,
should not matter. There is a write memory barrier just before
updating the head's flags.

Also, I don't get why the cache line matters here. Can you expand? Am
I missing something?

