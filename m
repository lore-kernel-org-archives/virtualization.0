Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164413C9A7
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124945; cv=none; b=sUl6Q/YBzM/FHZmkCKX7vhGhn5WYi5IOHdP+7WIX5Ix3TBIVIagBiwDCOeID8dqJ0AwPEnR5LKrzv6chiaz3epoNqiH0VvbMEZH5WgXwDuQctWF3+l9b8W7iFrXRyZzLXDOzjEbLEeOh/qk2Vh5ICQ+/P/gk2qZr31pDeNOxfoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124945; c=relaxed/simple;
	bh=b8tfgGRYqkN8DKL8q4Edtcrn6TmKgJxIxw5dMIhDV7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7lInxCV2EQrJbCeKb21gYSQvJ1koYDM40aVRGELKaSJTyF4r/bs9qHcmLLYXCRt4Q/WyMSiGwGYQv5Sn7BAr6x7bkYnxdetUgTh0KNaPneVguX6wLkWUniWa7164KANY/WrXBQHwCG98oNZxv3yAEBsyw1HUhwTRr395/ZRIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjOjbLHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjOjbLHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xErcL+R8N1xSDYox8sGoZ1o63+IUEg4qneZE5D63Sh4=;
	b=PjOjbLHckeTpHElRqCljcMKI7HpR3TaOaZLil4OMfkYJ6efj2sqsppuniQD/fWgIfPeZBx
	mQ1Al8pJlNl0Z3kgI5YmTBmb0vbw9y+sVfUiINHHn7Mn+ew1l4DGxFan3aM5DVr4vO/IE/
	brGHfdbNO25ajMIeF6CMiTLiVOJgc3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664--FMw4dxMMHKewxms5ebjiQ-1; Fri, 26 Apr 2024 05:47:34 -0400
X-MC-Unique: -FMw4dxMMHKewxms5ebjiQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349a31b3232so284199f8f.2
        for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 02:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124853; x=1714729653;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvK49tB2YT+3zxNRXHcpvr+esiLKijY/ZDrQ76/LVaA=;
        b=kc+wn7Syf1kKDnNvVm9aHZGyao3Ki1v3iI0anOxlTIFZRvyVvuX/LoPVmfZmP7CJ3f
         AUxTSbpEpY0/W30sN3+yTZMuMuGbdjQhqFAdWuY8moezPSraCMl7Fv1uY9S6KMhQ9d8Z
         9ScS1zQ20Senor3xDRiDJG0BJ9Vu5ZzP6WAspEXlLPuLrEzeiPhwz/PXi89v8EkU5vc1
         tvtyc1SlZtXgI0RByH+YsQE2YLvQOVFiNg/Cz05dy9xUcnxQJ1b/yxy/LZEahKqQs/Uz
         upDMEgxyPsK+Rq9hn2j7dR/o4WPxRIaxPEqltFiZZWYoNmTgB26k9uvF3B4UhEGKM8PA
         bUuw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdRfGjIqZz0to/LYNJ6kCERCQ6vdwVFqiIL2S6Y4ybd4ozmxUcurkdSBrC8DM9YHtETTgHTPXgmQuURlJCdg5gvV1TsydaB9u5QRJp/g=
X-Gm-Message-State: AOJu0YwNkZrs9sFPD958dF7W2n8pEgDO2Zs59EVnER2B8z/nJffyDV8C
	bB3qNCCN1LZ5CBTSvanmw8A9r31BcHy4yppQySD6GZ1wXdbcub8FyYYlftC8KdJcYDwXx3FUsBj
	ZdzSGRQkGgpj84v5NPz/rerP1enR6YosdUGD5Q6mYOmlN/cVufa/5qwSu/DlejGrB
X-Received: by 2002:a5d:6ad0:0:b0:34a:546:a963 with SMTP id u16-20020a5d6ad0000000b0034a0546a963mr1406555wrw.4.1714124853556;
        Fri, 26 Apr 2024 02:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVUY+zhEVPSJOFluqbKjKwhtdMRgRRlDPWu98HVbxmbn+isAdtQGA+bDh4aQOpVDj5HVfjaQ==
X-Received: by 2002:a5d:6ad0:0:b0:34a:546:a963 with SMTP id u16-20020a5d6ad0000000b0034a0546a963mr1406543wrw.4.1714124853093;
        Fri, 26 Apr 2024 02:47:33 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034a44c615ddsm20008350wri.88.2024.04.26.02.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:47:31 -0700 (PDT)
Message-ID: <65aa390533d0529bc2e9ce4e459af1f5a4a04fde.camel@redhat.com>
Subject: Re: [PATCH net-next v5 5/6] virtio_net: Add a lock for per queue RX
 coalesce
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, jiri@nvidia.com
Date: Fri, 26 Apr 2024 11:47:30 +0200
In-Reply-To: <20240423035746.699466-6-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
	 <20240423035746.699466-6-danielj@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-04-23 at 06:57 +0300, Daniel Jurgens wrote:
> Once the RTNL locking around the control buffer is removed there can be
> contention on the per queue RX interrupt coalescing data. Use a mutex
> per queue. A mutex is required because virtnet_send_command can sleep.
>=20
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 53 +++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index af9048ddc3c1..033e1d6ea31b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -184,6 +184,9 @@ struct receive_queue {
>  =09/* Is dynamic interrupt moderation enabled? */
>  =09bool dim_enabled;
> =20
> +=09/* Used to protect dim_enabled and inter_coal */
> +=09struct mutex dim_lock;
> +
>  =09/* Dynamic Interrupt Moderation */
>  =09struct dim dim;
> =20
> @@ -2218,6 +2221,10 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>  =09/* Out of packets? */
>  =09if (received < budget) {
>  =09=09napi_complete =3D virtqueue_napi_complete(napi, rq->vq, received);
> +=09=09/* Intentionally not taking dim_lock here. This could result
> +=09=09 * in a net_dim call with dim now disabled. But virtnet_rx_dim_wor=
k
> +=09=09 * will take the lock not update settings if dim is now disabled.

Minor nit: the above comment looks confusing/mangled to me ?!?

=09=09   will take the lock and will not update settings...

Thanks,

Paolo

