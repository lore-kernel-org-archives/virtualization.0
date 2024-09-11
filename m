Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EE3BBC5
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026413; cv=none; b=bUqvX+iyMu6ndGdP+MMQmX61mOqLcAJDfUEtvJWemHvZ/kS1XqEXjTcGRkW2BXsvqWbhbXLTUbbBivwCPW8wBprij4Jt+QmQ5Cn6ex+3J5PgpDvv1+4vYoK/ra+N6cSs4sj+gUJQ2ZUv62MUlLFPG4338SimSprHbTTF6riZVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026413; c=relaxed/simple;
	bh=wFhKcLxyN1ykNiZvxwjOMXoiE6l+99pEcKDjgw165jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzvAvEbULVZ8YGJ71MMEJnhVlLmxmi6GGBegIqldMixs5KleAXYHJ/GNeaKHOLY+pJcembk+NWXCA/YducUogmJnvDLA2CO+TIZ9/3VMD4cE59i51oQuQ+a9MVBj4+GwrrQ9aWIZGpvg9ktKTnftCcTiK4nH4aGgpwXMyLME6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+/DRh12; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+/DRh12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
	b=J+/DRh12KP7425RhpYPwVKMu4/wDFDKcyjRuumrJOZCRo+nzww7DdF36DZUYda0shUw1Jt
	532Ok1Rg+lm7873tTtm09QaExv2Pk0obKEZG4IGvBxfNvG/31Dof3OoKwevTCaNbTXHnL1
	jMJoZfnSFWxoxQrYXcIBaubEqJpPsAg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-CCclOY_XP9e-br4JjAOHPA-1; Tue, 10 Sep 2024 23:46:47 -0400
X-MC-Unique: CCclOY_XP9e-br4JjAOHPA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8a1a63f3dso6375460a91.2
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 20:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026406; x=1726631206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1L3Rw9FQGILLm4dgDngRRTfcF5g+8GVlGOUuhGIUJk=;
        b=Q+RBKCG8Wj2FetLX4jKmzcfT2AtEr2L9gHywnef69nLrSP/gGz5znQ/DZSBr7Fu63P
         qY93fFspbto/yxCjp9n9Pc/eFaPNh3QxSFv5uplj8qtzL0NuPhEYdd79C5ugR9Ycrp8H
         lcHrXDhvYmFsJ9DBGS+SOyO8N/RZNT57gtJEGAubJO9A8A2o5tGJXCBagqZTKxSn+E38
         LZu+kyq6kD/c8P+/PqcNULu1EnTqHKCeE2p/kGxZ7VwArCGbfr1S+L0hbVZAc3k7c+7s
         3f/60khMr/BRRZEQRcj/mOF/u5artc0H+y3HptLTPeEeFP4QtuW9iRw4m7mC6yZ/Z17B
         44eg==
X-Forwarded-Encrypted: i=1; AJvYcCUunKCyFS4XSKvg0aWLIi+WVSNLHw4icSip9sGB0aOw0iUse9Ub2LRnWUOvSiL8TZY+muYsfo9T3IGD16Vdzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywona9S+3wk+6/GuKGzwabvvBiLJG6hOpswL8W9JvviGvjllJfv
	HPrJwYx1FZtS+BHd7J4cSuqr4JL1qn0Dqx4scqq7v0sW2eXiH0m4HNKi9Kgj2SPtLK7daH9C1aJ
	7wFGICqrFlGLH1RadySSE617wGdT0w4OZOax3FdhLSlkD2ulvEbaYFvD4MYInBTy1oOLC99BAvl
	NfnFvTU4/1xkXVBRMvXQPcEfWUSTBV+9EKLxjTrPJmReQo5JY/Bg==
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id 98e67ed59e1d1-2dad4efdfa9mr16150963a91.7.1726026406201;
        Tue, 10 Sep 2024 20:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCJEXli9KWBQMuW7cPrQvykkXNDs1S+lxJ6nyJ9QJcR1HThFRnYJ3qTpH47dKeRKcUVxzNps+IZHyuAdt/B4=
X-Received: by 2002:a17:90a:77ca:b0:2d8:8ead:f013 with SMTP id
 98e67ed59e1d1-2dad4efdfa9mr16150940a91.7.1726026405725; Tue, 10 Sep 2024
 20:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:46:30 +0800
Message-ID: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> 1. this commit hardens dma unmap for indirect

I think we need to explain why we need such hardening. For example
indirect use stream mapping which is read-only from the device. So it
looks to me like it doesn't require hardening by itself.

> 2. the subsequent commit uses the struct extra to record whether the
>    buffers need to be unmapped or not.

It's better to explain why such a decision could not be implied with
the existing metadata.

>  So we need a struct extra for
>    every desc, whatever it is indirect or not.

If this is the real reason, we need to tweak the title.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 122 ++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 228e9fbcba3f..582d2c05498a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,16 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>
> +struct vring_desc_extra {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +       u16 flags;                      /* Descriptor flags. */
> +       u16 next;                       /* The next desc state in a list.=
 */
> +};
> +
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +       struct vring_desc_extra *indir; /* Indirect descriptor, if any. *=
/

Btw, it might be worth explaining that this will be allocated with an
indirect descriptor table so we won't stress more to the memory
allocator.

Thanks

