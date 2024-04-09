Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168360260
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635192; cv=none; b=kytQ6Cj98Gp0zBsl9ds8FCz8izXTl5PHNMeFrXufI14tqhW/vLp0YCEFuCt5LgtrrLKetFbG0lzsg+RofoaoNh6mjQHY8PxGaqa168E1SBW/pOiPEWjUbXef1l7784YTUErWUiPI8FIOlzZC2HSHxqJW56cpD1p0Hw0PvJwx+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635192; c=relaxed/simple;
	bh=5FLP6vOlq11TgvbsYHRDLMLdOdFYzw0JyC9A9ixaDnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiwqu34vMxmszcwxfOm8JYJyJxf0UAXngPN/+tcg9wpi02c422LWUJ8RT0QVDTf9dvHWs2+MoAMq6l6or13apXVyFo+oDWV6xsZK3dZK5aanZrGLPe9Uu8NpuhVJ8paEjrC6euBF1j4MNUgoQ90AxWMYG2j5P6+W1B4hAkfbPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSKv0Den; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSKv0Den"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712635186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESFjxmFELRVs+AuzBBwmEdBOCmT+SzELHtnXjIlCRYE=;
	b=GSKv0DenFpA9OmHtm9c54ForX7NIvBs9EKTyi3lKZiljzcVwzt3CaizXCGjdIyc56Vxnrd
	cPIGeeWsxhk1uNbsNaoTpDI0shixJJbLNvM5ldygpJXQNFEPWV2xXCrm5TRg1btCn864Q8
	lMhXg7PBHp2JxYp8PAi+3MJuQnmzlc4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-APSXvHteO66fy9J8J8q0Ew-1; Mon, 08 Apr 2024 23:59:43 -0400
X-MC-Unique: APSXvHteO66fy9J8J8q0Ew-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2fe3c35a1so3163545a91.0
        for <virtualization@lists.linux.dev>; Mon, 08 Apr 2024 20:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712635180; x=1713239980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESFjxmFELRVs+AuzBBwmEdBOCmT+SzELHtnXjIlCRYE=;
        b=kkbVsH7BWlW5YTtzvHXV7jzjFpeoEuG1B5FCmlrSvUwOnLMywUymSK7fD+lzm/qjHi
         QXhh/MEfDV+6qgjN/sLfulHWAPyec/lFGSMXXhjmalzp0rUykOYYO5Z9wAw4+Zox/2i3
         8KquwITjDR0WMej6PY6b0ISsujE/912UngY5oIgVgwu94B4k/891CvSuEaAuAGgEHlrw
         Jpr1xrwN0iLUD7Nkm0xkQiVOc9VtbcfID0mvDgfVbHu2yd5gPbDgJ27cerjtvul0a3Ne
         Joa0Qk3gAbHrQME500R4Jy2LCuAPYcX0K5TDmKULtAlXZpZizFS1RmR3JA6M2m6H+6VJ
         iZmA==
X-Forwarded-Encrypted: i=1; AJvYcCXlYQTnuWDa22Lex1baMwE2WuneQMt/0mZ9NAmBB4t0oaBY2U1iUr15GSBgXd6HYPsJ18wIaG93HbPvSS/hbWoAYU5Yj9sSs1caWbRmXMQ=
X-Gm-Message-State: AOJu0YxMWMrRXKfOoxEEpZU0nZ3jcyeo4BVbXasKtzUGLZ+i/LTiODSc
	QpoDOx/pdN5UBIN1Q0j3XD4/UPsvmuim2tMthvPclWkhzQ0f5BP7VPShz+cPX+xz1LRaOmG8iS7
	PmU+uO9N+JGmWn64Te1INeqHOrUOCAiHwXnOHOKReNy2eSlQFnWWuEGcpzbe2MRond5wZ+y7IqD
	HIoOUTazuVPO6X1BRjN6PXfomfqMsUfnLY+Lqaa/Y=
X-Received: by 2002:a17:902:dac8:b0:1e2:8c12:aac0 with SMTP id q8-20020a170902dac800b001e28c12aac0mr13713178plx.28.1712635180672;
        Mon, 08 Apr 2024 20:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9tu59WVehtU2mwCb0UaP2HnkqkQT/cJ0414esrTrtY6twmt+l2HIit7o5pyDKqDNa5/emeNwsfHJU5mgffHY=
X-Received: by 2002:a17:902:dac8:b0:1e2:8c12:aac0 with SMTP id
 q8-20020a170902dac800b001e28c12aac0mr13713164plx.28.1712635180313; Mon, 08
 Apr 2024 20:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240408170252.13566-1-ni_liqiang@126.com>
In-Reply-To: <20240408170252.13566-1-ni_liqiang@126.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:59:29 +0800
Message-ID: <CACGkMEub7vekopiQ1jdh_tHyjOXCADZsouJevioLHEBU1VFOEg@mail.gmail.com>
Subject: Re: [PATCH] drivers/virtio: delayed configuration descriptor flags
To: "ni.liqiang" <ni_liqiang@126.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"jin . qi" <jin.qi@zte.com.cn>, "ni . liqiang" <ni.liqiang@zte.com.cn>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:27=E2=80=AFAM ni.liqiang <ni_liqiang@126.com> wrot=
e:
>
> In our testing of the virtio hardware accelerator, we found that
> configuring the flags of the descriptor after addr and len,
> as implemented in DPDK, seems to be more friendly to the hardware.
>
> In our Virtio hardware implementation tests, using the default
> open-source code, the hardware's bulk reads ensure performance
> but correctness is compromised. If we refer to the implementation code
> of DPDK, placing the flags configuration of the descriptor
> after addr and len, virtio backend can function properly based on
> our hardware accelerator.
>
> I am somewhat puzzled by this. From a software process perspective,
> it seems that there should be no difference whether
> the flags configuration of the descriptor is before or after addr and len=
.
> However, this is not the case according to experimental test results.
> We would like to know if such a change in the configuration order
> is reasonable and acceptable?

Harmless but a hint that there's a bug in your hardware?

More below

>
> Thanks.
>
> Signed-off-by: ni.liqiang <ni_liqiang@126.com>
> Reviewed-by: jin.qi <jin.qi@zte.com.cn>
> Tested-by: jin.qi <jin.qi@zte.com.cn>
> Cc: ni.liqiang <ni.liqiang@zte.com.cn>
> ---
>  drivers/virtio/virtio_ring.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..bea2c2fb084e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1472,15 +1472,16 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
>                                     (++c =3D=3D total_sg ? 0 : VRING_DESC=
_F_NEXT) |
>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE=
));
> -                       if (i =3D=3D head)
> -                               head_flags =3D flags;
> -                       else
> -                               desc[i].flags =3D flags;
>
>                         desc[i].addr =3D cpu_to_le64(addr);
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> +                       if (i =3D=3D head)
> +                               head_flags =3D flags;
> +                       else
> +                               desc[i].flags =3D flags;
> +

The head_flags are not updated at this time, so descriptors are not
available, the device should not start to read the chain:

        /*
         * A driver MUST NOT make the first descriptor in the list
         * available before all subsequent descriptors comprising
         * the list are made available.
         */
        virtio_wmb(vq->weak_barriers);
        vq->packed.vring.desc[head].flags =3D head_flags;
        vq->num_added +=3D descs_used;

It looks like your device does speculation reading on the descriptors
that are not available?

Thanks

>                         if (unlikely(vq->use_dma_api)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> --
> 2.34.1
>
>

