Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A03A1DE
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000952; cv=none; b=mj6CnFZn5+xbYDMVG0LtOsh5WxZ7+SRUi22AWdbVhiNySoPDz9ZjE4hP54S+AnG6IfnpW3YgXDz/ICCepzwPBUgi4DP89T7V/HPc/uiTKpGNJFKSZEAp2+SC0Xoc2UkDyU6E8+EI7ct5ty9C53EAWb70Ei1xUOjyLxtf3vgpFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000952; c=relaxed/simple;
	bh=/XNaH2GsOU/WDny4Wlc5IeXExDMJDiR5r+yWcuxVMGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKI7rsy4i4XwF+Wc2v6k9m4CHeiMBz5Y0TEIkUCoNDxW3P9ZRS9G0zhJatvgD3mY2xZCle6kgoSv+M+Kcc3gKYyumxLxVbIMiLj8vfcGldF2XgxW+myQ0Y7f1KPuxGHRLb57n6UX8nb0ROhUZuOLUekUoDFm7AYT5ZvugnXIe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz093ayf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz093ayf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711000949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vuicHnylxzGQDV+/ztVXw13jQ4DoAJlRs6KRNLC5Rs=;
	b=Zz093ayfUUlwx88jSHSWf3vvzzcKyjuN5ZF49+fyB9mrla5A0mQuSn4hW+LfKN5N0z12vF
	wS+J/aUb2BWEZA+8ZiyV9p1Iu+nYV8T+4VxPpyw1oZO5s2VgWXMgOall8qrYSOB+PqOgOl
	V4Jaxm64Bc2uKM+vjN799sfp63PPYJw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-GcCFdIjWO_mQHscwEcCrVg-1; Thu, 21 Mar 2024 02:02:26 -0400
X-MC-Unique: GcCFdIjWO_mQHscwEcCrVg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29df3d9c644so511650a91.1
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 23:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000946; x=1711605746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vuicHnylxzGQDV+/ztVXw13jQ4DoAJlRs6KRNLC5Rs=;
        b=JQr9sDVlEgoVNETNdOCsabLccdHD/qlVyKWyVzyTkE4CS9JTORUS5prIpPjedaM2R9
         auwi4RHYSzuBCV052TE6iILqYO31RmPhXIgRWBvqxCNeMGKNpetsK36qxOgJrTJ7Rwc9
         b3xGJpt/fjFcGF2iUOSjedde2Xdi8ZmaIkuViGK5pSIzpqHOrEVFSGpc+x/c5+AoOWfL
         4cY8LmzhmrKw4HOjznOIku+7gN6SIR3jTG7dO3+pznVUFINjo/WmGi18gsLk0DmqKiP7
         D8Errpo8n4PMqk16EDbotxHfeQ7Uv8JChIrdbhDaQbyOmrNB01lW27Cnl4MTVuRpG43S
         K4nw==
X-Gm-Message-State: AOJu0YwkCnlrMHiJlEVHseAqsHvPhEO+x4YylBpwMlcZk659yD+WKkqP
	BO+28Tgo/g5j/eTTbfFnAEI81bQIV5HbGA6LGgvvPX+plPwIsWxrSffykWEDCf6jC+TnGTe276K
	Yk0Mx3J/ARC8EaOWyQxuAfbmtiGH2InPWaa4ZahsglxIENPF3QTAHc3Sx1khInsGAU8RCBEdegN
	8YjXbOd97WxA8drWBCkGNlYf29zaLisaqOOERiqnM=
X-Received: by 2002:a17:90a:c205:b0:2a0:1f2:e3ca with SMTP id e5-20020a17090ac20500b002a001f2e3camr3552639pjt.36.1711000945861;
        Wed, 20 Mar 2024 23:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHeLVf5h4LzIZIfZKxP80v82NuonNGoI4t71vA7UUS8pYlEZwb9YyuJi9GDa0d3KhkDallWmzSZ2z5u2omwAU=
X-Received: by 2002:a17:90a:c205:b0:2a0:1f2:e3ca with SMTP id
 e5-20020a17090ac20500b002a001f2e3camr3552621pjt.36.1711000945573; Wed, 20 Mar
 2024 23:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 14:02:14 +0800
Message-ID: <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped
 support disable
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
> Now, the API virtqueue_set_dma_premapped just support to
> enable premapped mode.
>
> If we allow enabling the premapped dynamically, we should
> make this API to support disable the premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
>  include/linux/virtio.h       |  2 +-
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 34f4b2c0c31e..3bf69cae4965 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>  /**
>   * virtqueue_set_dma_premapped - set the vring premapped mode
>   * @_vq: the struct virtqueue we're talking about.
> + * @premapped: enable/disable the premapped mode.
>   *
>   * Enable the premapped mode of the vq.
>   *
> @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * 0: success.
>   * -EINVAL: vring does not use the dma api, so we can not enable premapp=
ed mode.
>   */
> -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)

I think we need to document the requirement for calling this.

Looking at the code, it seems it requires to stop the datapath and
detach all the used buffers?

Thanks

