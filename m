Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2506E56D
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845636; cv=none; b=SxrOG9y/dV7ec/cdFnfxC46UXePNdgdExneAH4AMkoDVWF1BYY9sOvVOTJCUrpF2SPm093B1kE2y1ZmaQ3ExS1WRIC1HHe5y+rrvfXurEJkKH4EbVRpTtWezaIIKjGUo0e9EXVQBI0lS16b+RJpaYXSh5MaF+y+h6iqU5WGrDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845636; c=relaxed/simple;
	bh=yywLgNglR82SZeTNxRY2W1FxvYj9w68/tGjB7mFm51k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt+aK5UWcXsC/e0A5i3HnWQw30iA2uaHf5ZXcOUV8omyyJ5WmsNZEbSk1e+Nu3pvW4g4ZKQjSCtTuz672mUfeHoKmErA94sIKMbQRVLqHAEJAyzyHkZxbuwevV8dRgNC3YvxHgSC67FHtYTbrNTJWBHteMHa47gcTG9TQ6kj0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/SK+v2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/SK+v2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706845633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qZOxV5vnml7MfqH8S3ZhkUVVvTueAoPXfqzUQlf7NM=;
	b=J/SK+v2tWk0JjK0tUp2bipI3itEK7dRkZRW57qFOpV2NYmwu6ZXDQfCbkrH8kRcihUYTy/
	9tIdwWv8IUturyfZu4oIUkWNfYolQDLulNWGrz23vWWN6l/PY3PzAPxjQS1XiLk5pKzJrt
	EBFdVE0Co0T/Q4AzudJB0HPFBatutPY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-AZZDZY9pPsmsxzDHLCoseA-1; Thu, 01 Feb 2024 22:47:12 -0500
X-MC-Unique: AZZDZY9pPsmsxzDHLCoseA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so1985556a12.2
        for <virtualization@lists.linux.dev>; Thu, 01 Feb 2024 19:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706845631; x=1707450431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qZOxV5vnml7MfqH8S3ZhkUVVvTueAoPXfqzUQlf7NM=;
        b=Zvkfa+qez0ToI3qhhsuwhsnTx78KSsz+f6FSXYDTc7XwzocVujrcgjUDZHk1sg9Jm3
         NylwKfesjnHNYpfdsT+972pmkngC6s8F3c3PBp0xAvHaTlEO3sQTBITkFLq2XwRuVloH
         3mTQ+GqhSVqzes2EPDMBRBKRxGE3h/irho0/rzmA/a4e4xoLAbVSW/HMJPu1hSJGFSTl
         AUECCwbxd/irhZU15UnPD0AAODqpczYItDUT60xiDCR4xfm0OhqZYTUnnjV4aZ9QHnG4
         TvrHWlbl7cyXAQKL1zvjUdLDit/E9POpDRm1QGaNnwC54hTxrY+shcl5WG9Cx7BlYaQt
         kCHA==
X-Gm-Message-State: AOJu0YwAAd81/dsMlCtawSGEazNIdnM2V7BAjk7aUrq1zrLpyTUww6/+
	2qAhdT6pmlT1u6HahEf+OoU/Nx/RCGRHef2fNMXEjqELxDRG6UtgTh9wEaS+AOdXe5KZjagpBYq
	EvIdDKLQqqQR1dYhsKfbfLNNCiqsAG6Sw8+mBHOwuWysg3wWukxDJacwil11je14G+SVjfeES4+
	yZWzFRJBOQBxkPxdf4RS4kg7LuXL2xYH5j+a4bmdJoGIp8ahI=
X-Received: by 2002:a05:6a21:2d85:b0:19c:aaee:bb1b with SMTP id ty5-20020a056a212d8500b0019caaeebb1bmr965682pzb.7.1706845630966;
        Thu, 01 Feb 2024 19:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZNkP3S/R39vWx3DnICk68k9t1P0vCNLe18HRF3gdVdRjWlkvmrQC5KIY9I7O+bNneeiu1E1u7h3Y6CZHHdyc=
X-Received: by 2002:a05:6a21:2d85:b0:19c:aaee:bb1b with SMTP id
 ty5-20020a056a212d8500b0019caaeebb1bmr965674pzb.7.1706845630696; Thu, 01 Feb
 2024 19:47:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 11:46:59 +0800
Message-ID: <CACGkMEsMm2QoWUa=JMnFha4ufd1w8Vs1=MtvNeYKm2B4oPgupw@mail.gmail.com>
Subject: Re: [PATCH] virtio: packed: fix unmap leak for indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> When use_dma_api and premapped are true, then the do_unmap is false.
>
> Because the do_unmap is false, vring_unmap_extra_packed is not called by
> detach_buf_packed.
>
>  if (unlikely(vq->do_unmap)) {
>                curr =3D id;
>                for (i =3D 0; i < state->num; i++) {
>                        vring_unmap_extra_packed(vq,
>                                                 &vq->packed.desc_extra[cu=
rr]);
>                        curr =3D vq->packed.desc_extra[curr].next;
>                }
>   }
>
> So the indirect desc table is not unmapped. This causes the unmap leak.
>
> On the other side, the dma addr and the flags is not updated. That
> will be used by vring_unmap_extra_packed.
>
> For safety in this patch, the flags of desc without indirect flag is
> also updated.
>
> This bug does not occur, because no driver use the premapped with
> indirect.
>
> Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9ec7..097258a10819 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1340,14 +1340,15 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vq->do_unmap) {
> +       if (vq->use_dma_api) {
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;
> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1484,9 +1485,10 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>                         if (unlikely(vq->do_unmap)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1615,13 +1617,11 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->do_unmap)) {

I think we can simply change this to check vq->use_dma_api, then we
don't need to move the flags assignment to extra above?

Thanks

> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> -               }
> +       curr =3D id;
> +       for (i =3D 0; i < state->num; i++) {
> +               vring_unmap_extra_packed(vq,
> +                                        &vq->packed.desc_extra[curr]);
> +               curr =3D vq->packed.desc_extra[curr].next;
>         }
>
>         if (vq->indirect) {
> --
> 2.32.0.3.g01195cf9f
>

