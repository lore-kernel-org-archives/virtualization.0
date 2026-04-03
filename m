Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8618346E56
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184975; cv=none; b=hamsh69TLVP+8OpeQ0r6Cd6IJnSJS25/YPCM0a1eNeoAxTRIhMPETRmkxykimHwZoBA5/28NOgzNODG418dAe/LdWw6oQRROXbPWOiaqP3+wkcFPQFNdI8zBdYvMMJtft5Mv2ghMndmQGEK40ZZw+Yd7qSYAzg6cpdFPOVrCrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184975; c=relaxed/simple;
	bh=WJWM3H7BWpZbw7t7TKh1F9c78u007jDgEKro115lobE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siRDVcdZzls2gVzpR+a4KsZzyQuVpzz/J3olJVwRS+07cy5hnpKMg8zNMtyGcnUK40xHWrkcESYRuQFeGM5fe7OzKWqvw9ReUZtyM0Iy3q7U+sFheKliU36VEgFmoPP0FWE2ocpl8UlvgoGOZ+RX8poQeyk8JKg1vPyVPJvPiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBOsDS0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBOsDS0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775184972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ct9BjRcF6xVikdlDWaFjg5IvYqZS8Pf50JivLvNtOE=;
	b=iBOsDS0Xx0eNym542EviXGqVrkR6Y4enZ429XPF1BbJswAJ+2nywm6EVL8unh0uYN0EQys
	Cww+vNcrPU5SJYn+D5/qcHU0bLD2b2lpoeeU/+M10ikMiUAYPzfZbMExU8d4dgKn5pJSKU
	2RBUukg2R1htN2GO6O1Revy0BhUwMVs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-1a-9KqeKMPmW_VFFJd34jQ-1; Thu, 02 Apr 2026 22:56:11 -0400
X-MC-Unique: 1a-9KqeKMPmW_VFFJd34jQ-1
X-Mimecast-MFC-AGG-ID: 1a-9KqeKMPmW_VFFJd34jQ_1775184971
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b6ccf298so945201a12.0
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 19:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184970; x=1775789770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Ct9BjRcF6xVikdlDWaFjg5IvYqZS8Pf50JivLvNtOE=;
        b=FM+hwI24HGVjmB4JZFJAvaNqcPRCIp1sUYawGsLiBf8e+WeM1HpulCfpAPmVVGLXUY
         mG2R81hTExxTyoK1C/lyaFxcxQ33mmKca7cR4PM6RZbOp/yYW+JGMiID9zvlN2srZPcQ
         afLYXxyzR/JHpMLksASvX69omRpT9lLspHzKpIZNIfTixhQF8ndiJv/a0k226AQG52X0
         lZz7+oPvGTMfEITB67bUOOiihkfIIRCM/Sr+SejBqzDJTAABz0YoJrCYF7D6Fdg3xEbm
         I3HMkDMtKjZFQCSBwYCYjnmmfDQQmXNmegry9v2oBnBIgE26+6Q/yTtimmAejz+WpM71
         Fd2A==
X-Forwarded-Encrypted: i=1; AJvYcCWCbznwz78GBUw+lpv2A+Pi94sIM3G2TkV0r0qrOPuiFUvBtiFwckZckUPsR5xWKmabnNr1lYNwUXER7RWTew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwFtkkEVWInie2ils/xIpgC+rLfubaQcGI5eosuAQdMJUCRA8q
	3LMvW7h1SRqEbZSax4TbPpnbrmwhZOK5xhI4SyrQYDRzGWrfEeEtwpYVZ0Ifc89+laSEmvZX2ns
	FYzrL4UxPKQ6dEx6sVTFb6gs1JQfDJpqJvmvIl7s8Fcfe9njUeh6xYV88lp7At4J0WRxxEm50Jm
	i+TSjtr5AoQVPgyr/kr5muLyErhHq7vRqumHuWbOlNzUQ=
X-Gm-Gg: ATEYQzyKiFL2oECgxPzTw7+JwFglOUaXBBasGexBCwdKRfUYNnLOM7q8LWUrGT9foKF
	2Ua5qfFOlLBGySIy19E6WU5f1pAypVTib4jQYN5rVfvWvkS3B3eqMOtwmmCiQ9mxjFpUCNX620W
	15lLhsLLiTz7hQelVhSsSn4xdGw5V6q4we1u7y3oWtZQB6I7SI2bGg7vPq/yjla24rwvWLIw7Y1
	9FzLjw=
X-Received: by 2002:a05:6a20:9389:b0:39b:e9e1:699f with SMTP id adf61e73a8af0-39f2eda70ebmr1344392637.12.1775184970425;
        Thu, 02 Apr 2026 19:56:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:9389:b0:39b:e9e1:699f with SMTP id
 adf61e73a8af0-39f2eda70ebmr1344364637.12.1775184969851; Thu, 02 Apr 2026
 19:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260331102626.108962-1-lange_tang@163.com> <20260331102626.108962-3-lange_tang@163.com>
In-Reply-To: <20260331102626.108962-3-lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Apr 2026 10:55:58 +0800
X-Gm-Features: AQROBzCYnC_4bwyal4kZm0Pse9C--BujPJySTs4Y2I69DUBVl7ZTuK0Kip8bXHU
Message-ID: <CACGkMEv_VmzD-JthmP300Y4ChtqBhdf4bd3tHYBd3EbxzU1XTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_ring: return IRQ_HANDLED for stale interrupts
 when cb disabled
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, edumazet@google.com, 
	tanglongjun@kylinos.cn, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kiswPCoOAXBVS-lqjTkdTWMwA9nUaseu_FEG5Lvvgns_1775184971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:27=E2=80=AFPM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> In the vring_interrupt, if the used ring is empty, IRQ_NONE is returned.
> However,Sometimes, such as with busy-polling, buffers might be consumed
> from the used ring before an stale interrupt notification arrives. it
> leading to return IRQ_NONE.
>
> The kernel's spurious-IRQ detector counts consecutive IRQ_NONE returns
> and will permanently disable the interrupt line if 99,900 out of 100,000
> interrupts go unhandled.
>
> Add is_cb_disabled() to virtqueue_ops and, when more_used() is false but
> cb are suppressed, return IRQ_HANDLED instead of IRQ_NONE so the spurious
> counter does not accumulate.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 335692d41617..52df932fc4a2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -185,6 +185,7 @@ struct virtqueue_ops {
>                      unsigned int last_used_idx);
>         void *(*detach_unused_buf)(struct vring_virtqueue *vq);
>         bool (*more_used)(const struct vring_virtqueue *vq);
> +       bool (*is_cb_disabled)(const struct vring_virtqueue *vq);
>         int (*resize)(struct vring_virtqueue *vq, u32 num);
>         void (*reset)(struct vring_virtqueue *vq);
>  };
> @@ -1063,6 +1064,12 @@ static void virtqueue_disable_cb_split(struct vrin=
g_virtqueue *vq)
>         }
>  }
>
> +static bool is_cb_disabled_split(const struct vring_virtqueue *vq)
> +{
> +       return !!(data_race(vq->split.avail_flags_shadow) &
> +                 VRING_AVAIL_F_NO_INTERRUPT);
> +}
> +
>  static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtq=
ueue *vq)
>  {
>         u16 last_used_idx;
> @@ -2227,6 +2234,12 @@ static void virtqueue_disable_cb_packed(struct vri=
ng_virtqueue *vq)
>         }
>  }
>
> +static bool is_cb_disabled_packed(const struct vring_virtqueue *vq)
> +{
> +       return data_race(vq->packed.event_flags_shadow) =3D=3D
> +              VRING_PACKED_EVENT_FLAG_DISABLE;
> +}
> +
>  static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virt=
queue *vq)
>  {
>         START_USE(vq);
> @@ -2644,6 +2657,7 @@ static const struct virtqueue_ops split_ops =3D {
>         .poll =3D virtqueue_poll_split,
>         .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
>         .more_used =3D more_used_split,
> +       .is_cb_disabled =3D is_cb_disabled_split,
>         .resize =3D virtqueue_resize_split,
>         .reset =3D virtqueue_reset_split,
>  };
> @@ -2658,6 +2672,7 @@ static const struct virtqueue_ops packed_ops =3D {
>         .poll =3D virtqueue_poll_packed,
>         .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
>         .more_used =3D more_used_packed,
> +       .is_cb_disabled =3D is_cb_disabled_packed,
>         .resize =3D virtqueue_resize_packed,
>         .reset =3D virtqueue_reset_packed,
>  };
> @@ -2672,6 +2687,7 @@ static const struct virtqueue_ops split_in_order_op=
s =3D {
>         .poll =3D virtqueue_poll_split,
>         .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
>         .more_used =3D more_used_split_in_order,
> +       .is_cb_disabled =3D is_cb_disabled_split,
>         .resize =3D virtqueue_resize_split,
>         .reset =3D virtqueue_reset_split,
>  };
> @@ -2686,6 +2702,7 @@ static const struct virtqueue_ops packed_in_order_o=
ps =3D {
>         .poll =3D virtqueue_poll_packed,
>         .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
>         .more_used =3D more_used_packed_in_order,
> +       .is_cb_disabled =3D is_cb_disabled_packed,
>         .resize =3D virtqueue_resize_packed,
>         .reset =3D virtqueue_reset_packed,
>  };
> @@ -3231,6 +3248,18 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!more_used(vq)) {
> +               /*
> +                * Stale interrupt: the device posted this notification
> +                * before it observed the callback suppression;
> +                * When more_used returns empty, IRQ_HANDLED should be
> +                * returned for stale interrupts.
> +                */
> +               if (VIRTQUEUE_CALL(vq, is_cb_disabled)) {
> +                       if (vq->event)
> +                               data_race(vq->event_triggered =3D true);

Why event idx is special here?

Btw, looking at the comment of virtqueue_disable_cb_split:

                /*
                 * If device triggered an event already it won't
trigger one again:
                 * no need to disable.
                 */
        if (vq->event_triggered)
                        return;

It makes sense only for event index.

Thanks

> +                       pr_debug("virtqueue stale interrupt (callbacks di=
sabled) for %p\n", vq);
> +                       return IRQ_HANDLED;
> +               }
>                 pr_debug("virtqueue interrupt with no work for %p\n", vq)=
;
>                 return IRQ_NONE;
>         }
> --
> 2.43.0
>

