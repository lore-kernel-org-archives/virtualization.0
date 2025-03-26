Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E21A8407
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992341; cv=none; b=ldNy2AQ0S1USef0nZhxb3PiJxHeqrt1NI9lihYBJ6795T/0kCK9pgvRl4k+CUCpnubVI/Nmu5ArD3DQlWakYb0PAZtvcyk18W9FSE/jovviQN11yCPJimNGT3attZuxrLDsumo+A1JPSb4/g2/+Pe5XyoxxJCEAJIu6xfXVYCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992341; c=relaxed/simple;
	bh=2TTqg+lX1dQhtProIvhVeWwU3LN5GCVx00xGdLNnELE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA58xmoCBOTxDZQW48g+y9x1jOqcCxOLRLE9luycNKD+RYgXx61uczElaKrj6qDh/PMFXHmoPV/9bgJejBai6XgNIVpiQz4y2bBLHBPkAUD6TkB6yovieuX3u6BsTuP+ZYZW04lpqAdvsP7AYw+wxq1eym2GOtF6KCr6Jo3Kux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSoCDXij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSoCDXij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcA5Ry4ZMsWvxEDjHDWkPrYz/bbKoxfDEYy7G5GMTY=;
	b=HSoCDXijxwA/P1r8BTkM2w0nLUHol4YRYN61tlXUFvkUFsgKkW+aIwfHb0zFTjtRemlgjR
	jfWZEC3aZxWEYP1QkM50Cghm+vNlBIWZzDb36iOFfWZ9yErFjXAJ2nmEkDUjpbnF+fnyyh
	ld9Hnuhbm6aXlzOx6U3qVGdeofeKiLE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-7PIZmLs0OJWEk1covjjyhw-1; Wed, 26 Mar 2025 08:32:16 -0400
X-MC-Unique: 7PIZmLs0OJWEk1covjjyhw-1
X-Mimecast-MFC-AGG-ID: 7PIZmLs0OJWEk1covjjyhw_1742992336
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso7082609a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992335; x=1743597135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwcA5Ry4ZMsWvxEDjHDWkPrYz/bbKoxfDEYy7G5GMTY=;
        b=ZoT3C3luULJz4T7ekbYiiy4q3pdYDB5mHbuxyjm2aVcEQi7Ymjkzyg1YlHN7EGsgQc
         8Tv8jdwZxih/M/64muEidhFEgRF4pPAQHKFq/MNh+hiSoazpYqK9xDCb3Agsjtm+lmA/
         ZjbJx9uor6r77MjH7dGOu4rw/Z9uZ8S5SElcsVaVWo9C1dnETQf/zk2B6P5CLPTTBww2
         ubjBHL0M9pZQSrcgm73lrbcc80oof+tGMEFBenOX/1w9YNZpBVYaa6SsXV9mBI52B5Jx
         W5xBmiwFlF+YAOQMqx87do+1cb/DGL9mf8OJNI48IXD21u+hv/BxixUDoxHHTVsjkqrd
         ctyg==
X-Forwarded-Encrypted: i=1; AJvYcCV51dKOhEIslzsFIc8gCcZ53xfLgULlI9LAjLdFlDkLyZRXORTGZMZvjjHOvK9i4oTYjyK7h3iF9Fg3o/fhrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8rncr6iGvq8bS+gW4Q3oJ4LAkB7Qkua4a9Y2OSqVJdtKXWV50
	G+DCSSdURXCqefUoRU7zT1GXuzZwV5qXh7DZ1UsOru4xTenk9txe/3tHXtluqoMJEwY6+gMSvyX
	TSHXBZUg7fHI59vPNmGPo0msvba/gdY/I3KoJowE4ZJAnbN0q276b16/7dzrGA4yLjFg87jM7sK
	W43o6QARBCUDY2TC6rBzc2NK5x8dmJrmpDltz4Ku0=
X-Gm-Gg: ASbGncsmyRDuVjoq5JrAFVDTrsovUGG0segfca+U44jQhm6WZAki9rjn9ZxUf1Q/wVO
	PcuJMQoZImcyxFxSxwT5Vv+BcNYwGRMRiBbrIaw95IyyB5V7kKR8xkOpGA98JOnicf1gB6aQ=
X-Received: by 2002:a17:90b:3bc7:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-3030fee95d3mr32689246a91.27.1742992335538;
        Wed, 26 Mar 2025 05:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsjbfru13QMabqyG6unsNqqtxh9L2u1VKTgXAP4lw2AyiaiL/J+8/3kJMAZafGRPNuOL2P5TkzAlcPjkHOW8=
X-Received: by 2002:a17:90b:3bc7:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-3030fee95d3mr32689193a91.27.1742992334967; Wed, 26 Mar 2025
 05:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-13-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-13-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:31:38 +0100
X-Gm-Features: AQ5f1Jr4PDWFekYrqp6Q4ssDNwRggMV_WQEba50a3Ao5vNGZTJ4WtphM4KqyAic
Message-ID: <CAJaqyWerWJpLgpaMtaAYfBPW4UUWqLO7ja9C7-U7Y5YukLN1Tg@mail.gmail.com>
Subject: Re: [PATCH 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UPB7vzryVu2zfTTITNj0xMZ7MdvRwqdCqG-_3zs1XYM_1742992336
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> spec.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 19aa24d62d20..a2884eae14d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -801,7 +801,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>  }
>
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -                                unsigned int last_used_idx)
> +                                u16 last_used_idx)
>  {
>         return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,

So this cast to u16 is not needed anymore, isn't it?

>                         vq->split.vring.used->idx);
> --
> 2.42.0
>

