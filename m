Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9DBA28
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996456; cv=none; b=CnkEnoE5iOdEWWzBBKtiTdwbO/+KtLyttkSIIQQYRUDULZJVasNUQM4NWDrrQe20fnA1UL0JE90cYhLBmGBTzvRJd+60CLQHghcGzn4b4TCVWgqa8DmFxy1kaNHd9S6aHiAyvMcb8+dewO2oQbzZKdKWyIkMlUzz/U3/V/iad2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996456; c=relaxed/simple;
	bh=FzlUkh/H3PbaE/6rvjuQ59WfzY/3yeTercRcek9n7MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXys0JBcfdeckqs8Eet3avi0uhcvSZice7WYVIfN5bQ0ZOfzHt6CrzLjqNCKZuqnXbpJh6R0QdbKBqBnVPxoGvJ+191bKODiQe2dV1+vcwNbKz9Nl3DSe5xigQsiMc4/ACg/wWVG+R9pwfze0bXZF7MkVOJcA7aj4DXBo4eU4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9BjiUyF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9BjiUyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710996454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R25xG+GYTZrVm6e0l/eGbmaWKputPFk5P5+kIKivy9A=;
	b=H9BjiUyFOpy9T1Z3koPkUFLg01N/aYQIu/Sb8Exn7HacRlOaaK/CmSMuXfSgM/T9305qFe
	n6h16QniW3xBfENWRFqDUcr6SAZxjRI5w53P8XPXmWS4wKePvv+OLf3quBB4pDxYYijO79
	IB03ZuOW3m8OvcSvJfRp8W7tQ+dn1MU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-yL4E_pH5PTu3MeKMJk5cYA-1; Thu, 21 Mar 2024 00:47:30 -0400
X-MC-Unique: yL4E_pH5PTu3MeKMJk5cYA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so406084a12.0
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 21:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996449; x=1711601249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R25xG+GYTZrVm6e0l/eGbmaWKputPFk5P5+kIKivy9A=;
        b=JEfGoBfWlTcZRoU/68G3MQ9QWdeXCJwO/41rnTyRSj7Gis4g+PT3UpWbhr2MP3a6/A
         6K46WbUeZ5RYM4+rtugu+GtD+gU4G9UuKz0JoMuK9Yf2NpofKWFNFXeJVqyb7ZtGMZGZ
         yicHKX2MmiVc7eYiI/yHzshb2qbIDF8Rel/J69xiz9AKBhQvVNI3s4I2EMnHkkEzLdUF
         1evbMc0FJFIuss0u7PNvxA53LVd/bNpBsxXAfrQMAwwCBCvtNPp+WrRx2UbYLokkHyAP
         Siv9V70BfAnLYRJRAutssMiYlCvk4vh2AJ4rI7QcMHwxvTTJP0RaFzsmoRp46LwlmaVr
         jkJQ==
X-Gm-Message-State: AOJu0Yy0rW1YxMu5GUcpw1BiIBndZoo7uvIgCLZbr5mUaz6w8KpvTJam
	xvf4brWIEqiTBmOTGq0Glq/R3zi7H1IqlV2GD0HphSydlCbR8DMU6lAL7WlL/9xoMlKIifGporj
	VmmAEzIHmz6AikiJSpBRd7dnSY6P3arQOkUkeVD93boGtm3UMx0u/9lmnCuagZXNhYlpySkpV17
	EmBmX3W1sR2qRNaKx1lH/xaZiabaUNYqBOtEQJIyLx/4P/BWfSCg==
X-Received: by 2002:a17:90b:805:b0:29f:ce37:50d8 with SMTP id bk5-20020a17090b080500b0029fce3750d8mr7560809pjb.17.1710996449284;
        Wed, 20 Mar 2024 21:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyDhQJUmAvKGCX0+SMStEIsEjG/lNtxS4uSp3iypJcJ5+avMQtxZkO4K4D+IcRdQ5QWbJwZqi+MUMIMi3IObg=
X-Received: by 2002:a17:90b:805:b0:29f:ce37:50d8 with SMTP id
 bk5-20020a17090b080500b0029fce3750d8mr7560798pjb.17.1710996449003; Wed, 20
 Mar 2024 21:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:47:18 +0800
Message-ID: <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0dfbd17e5a87..22a588bba166 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -72,9 +72,16 @@ struct vring_desc_state_split {
>         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
>  };
>
> +struct vring_packed_desc_indir {
> +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> +       u32 len;                        /* Descriptor Array length. */
> +       u32 num;
> +       struct vring_packed_desc desc[];
> +};
> +
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_packed_desc_indir *indir_desc; /* Indirect descripto=
r, if any. */

Maybe it's better just to have a vring_desc_extra here.

Thanks

