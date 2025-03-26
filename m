Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394F1EBFE6
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997738; cv=none; b=QNn/ucN1XJzhROmvOiBxpdySYkuVFDAPU5yuYGv5sCqvYAXbJOmOHdkcJFD2WH+VlxXAXRDY3GOFmxXJkofo3VDym5OA8J9U0mcGjTyhjIaFDf7Hlgu2TikWsfwf28/iEiJ4EbOa4RHsP8l4O76BjS8l+OL3L7jY/iiIafJ/9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997738; c=relaxed/simple;
	bh=ExKHiY1vfFVJz9ncN9p+ELlmMZ6mdwDNgLovj/LRhmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvj1pjLSZvwdynmGTGuGFD3ysmFKp7Hr6wD9pbpQPgsdfDR+6Pd3pMqTFCsvF95su4sLrmInIRuJRnSuMg/OQyOTNnYvueNbmo35hL4b2Mrgctcx7Fak1kLKyOc3JLQcWOxUTG+rNoXqgJduZORTG2+AH0lzV8NXz5gPrFyppK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O19UkwjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O19UkwjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6A4QtKmG1cSlqlEKr2nCjS1PIqtKpWV2z+HY5iuQ8E=;
	b=O19UkwjZgOYg3CSi8+++JnOeCcGm2JydzpUtLilUIAAoWjxmKO1ENq3quCw8pOGNwpKQIX
	ZO83Y4WynovjzZ1NdxwNDfW1ttPL62NK5sQkCbetLXdn9w54mdAIN79r8RqlDxcwNNCI3j
	LT19mdOSUuhdYyg7s9r69qA4O/kfX/Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-x2r_8jmJNMqpW9UitXiMpQ-1; Wed, 26 Mar 2025 10:02:12 -0400
X-MC-Unique: x2r_8jmJNMqpW9UitXiMpQ-1
X-Mimecast-MFC-AGG-ID: x2r_8jmJNMqpW9UitXiMpQ_1742997731
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so1956426f8f.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997731; x=1743602531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6A4QtKmG1cSlqlEKr2nCjS1PIqtKpWV2z+HY5iuQ8E=;
        b=C9NExuiNdVwd290JgGqNqCHZbxXriXSpBS4no7qMdBp810VzpEti0Fu1leWiykoasS
         n8w4OdgyNgkWt/1bqsv+yJGz0yVjwdEEYxbZcUdHxf0atdeXeL3/0Yeh72q/S8ViVpQ/
         Rm5NMdDmsjVs7HFfcSE/zu+bFJ0ywkxA7x3iQ8oqdJhCLx1DqbCjXX3iUZLRo4XNid7U
         J71QXBi7gyzvXbKpBB7PMRFMq3S6fmnVloJtQ/mrDnAVXKwYwPDgBaNrR1Ay11JQaNRR
         Ow2NvX26kaG/mQjDaZwoj37PLSE81TZ2xURcJGgQ9YulXyc2igKJy/J2uRhVMQZqSl0h
         DipA==
X-Forwarded-Encrypted: i=1; AJvYcCVdLrpaLEP6v9eA9oPS62zDb4KYhmBroag4bPyJsqhi0O+czLT2zmGaleUvleBfEvL99xQhOxuNXsaLbkTuWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzba91ySysm5jLLb94RqOAZnhod4Nhz2DF1vq/P+hyPzDLh7wJv
	hQ8Mwk2EcDwIB82DSC8VRoA0YKROW7IJndC7t3kpSH0rRKYxiUGIcHTPuK8E8A6gYH2JxHp7JaE
	TLUWOfOPEkyZmi38apnCIcfH7YpdA6lrr5/tf2Sg4LahscpK1VLgJdRvvJfD6/ircb3NM4CGlwe
	QvjG3A9iHbpFCtxhe831093dYLBEpnVP2sZU3taLc=
X-Gm-Gg: ASbGnctp6lSBcA5JS6ZPNfV2Y2kJ2TqGnjCsZQcQa/do9EU0Z2yP4uiVOY8X2lMzM6q
	OjbJk/Nr08Wa2MoshRe6Wkhr6cviMdmJExwggwTyN/hEo0n3aMqYwEl0hWj3LmFXK9A7ExFs=
X-Received: by 2002:a05:6000:184e:b0:39a:c6c1:3408 with SMTP id ffacd0b85a97d-39ac6c13529mr6773886f8f.37.1742997730214;
        Wed, 26 Mar 2025 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVqs4eXb7WYajBzH07dwOO7LIznq7DcBXdw3fZ7amxqvEjWOZDPtljFddcq4377XdEC6+XOg2IYsIt0Cbo6MQ=
X-Received: by 2002:a05:6000:184e:b0:39a:c6c1:3408 with SMTP id
 ffacd0b85a97d-39ac6c13529mr6773793f8f.37.1742997729380; Wed, 26 Mar 2025
 07:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-5-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-5-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:01:30 +0100
X-Gm-Features: AQ5f1JpZuY-R1mOa9Psg6wH6oBtdE7eDiRjlK41MnQiXsLSO1qS2bJZXvZEj_3Q
Message-ID: <CAJaqyWfzRDa5vn0nJiaPdy2=Qoi40jgUQbbAspm25zM7OfUyHg@mail.gmail.com>
Subject: Re: [PATCH 17/19] virtio_ring: move next_avail_idx to vring_virtqueue
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gHMOYl13fv14_RPqXPwHxNSmFkWNBRYURaubGpk8As4_1742997731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This variable is used by packed virtqueue now, moving it to
> vring_virtqueue to make it possible to be reused by split virtqueue
> in-order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bd4faf04862c..a1a8cd931052 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -138,9 +138,6 @@ struct vring_virtqueue_packed {
>         /* Avail used flags. */
>         u16 avail_used_flags;
>
> -       /* Index of the next avail descriptor. */
> -       u16 next_avail_idx;
> -
>         /*
>          * Last written value to driver->flags in
>          * guest byte order.
> @@ -214,6 +211,9 @@ struct vring_virtqueue {
>          */
>         u16 last_used_idx;
>
> +       /* Index of the next avail descriptor. */
> +       u16 next_avail_idx;
> +
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
>
> @@ -448,6 +448,7 @@ static void virtqueue_init(struct vring_virtqueue *vq=
, u32 num)
>         else
>                 vq->last_used_idx =3D 0;
>
> +       vq->next_avail_idx =3D 0;
>         vq->event_triggered =3D false;
>         vq->num_added =3D 0;
>
> @@ -1350,7 +1351,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         u16 head, id;
>         dma_addr_t addr;
>
> -       head =3D vq->packed.next_avail_idx;
> +       head =3D vq->next_avail_idx;
>         desc =3D alloc_indirect_packed(total_sg, gfp);
>         if (!desc)
>                 return -ENOMEM;
> @@ -1431,7 +1432,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                 1 << VRING_PACKED_DESC_F_AVAIL |
>                                 1 << VRING_PACKED_DESC_F_USED;
>         }
> -       vq->packed.next_avail_idx =3D n;
> +       vq->next_avail_idx =3D n;
>         vq->free_head =3D vq->packed.desc_extra[id].next;
>
>         /* Store token and indirect buffer state. */
> @@ -1501,7 +1502,7 @@ static inline int virtqueue_add_packed(struct vring=
_virtqueue *vq,
>                 /* fall back on direct */
>         }
>
> -       head =3D vq->packed.next_avail_idx;
> +       head =3D vq->next_avail_idx;
>         avail_used_flags =3D vq->packed.avail_used_flags;
>
>         WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> @@ -1569,7 +1570,7 @@ static inline int virtqueue_add_packed(struct vring=
_virtqueue *vq,
>         vq->vq.num_free -=3D descs_used;
>
>         /* Update free pointer */
> -       vq->packed.next_avail_idx =3D i;
> +       vq->next_avail_idx =3D i;
>         vq->free_head =3D curr;
>
>         /* Store token. */
> @@ -1633,8 +1634,8 @@ static bool virtqueue_kick_prepare_packed(struct vr=
ing_virtqueue *vq)
>          */
>         virtio_mb(vq->weak_barriers);
>
> -       old =3D vq->packed.next_avail_idx - vq->num_added;
> -       new =3D vq->packed.next_avail_idx;
> +       old =3D vq->next_avail_idx - vq->num_added;
> +       new =3D vq->next_avail_idx;
>         vq->num_added =3D 0;
>
>         snapshot.u32 =3D *(u32 *)vq->packed.vring.device;
> @@ -2083,7 +2084,6 @@ static int vring_alloc_state_extra_packed(struct vr=
ing_virtqueue_packed *vring_p
>  static void virtqueue_vring_init_packed(struct vring_virtqueue_packed *v=
ring_packed,
>                                         bool callback)
>  {
> -       vring_packed->next_avail_idx =3D 0;
>         vring_packed->avail_wrap_counter =3D 1;
>         vring_packed->event_flags_shadow =3D 0;
>         vring_packed->avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL=
;
> @@ -2977,7 +2977,7 @@ u32 vring_notification_data(struct virtqueue *_vq)
>         u16 next;
>
>         if (vq->packed_ring)
> -               next =3D (vq->packed.next_avail_idx &
> +               next =3D (vq->next_avail_idx &
>                                 ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR)))=
 |
>                         vq->packed.avail_wrap_counter <<
>                                 VRING_PACKED_EVENT_F_WRAP_CTR;
> --
> 2.42.0
>

