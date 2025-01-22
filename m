Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A205191F6C
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526387; cv=none; b=od3/xI82+LnGiuSEcqk6SXlvngNRkL3xgWCcgYML9tEirgbLWeocFoEIPBGr+qSRM1xuKudESUPlo81Shz7zn3+RCJvxJ4F1yPXHbv3wkpuWcXugIk15VY9a01rnI8WrqIoU3m/k9z2VAoX7H9Lgoi+jaAQ6DLYN0gFugT6Zx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526387; c=relaxed/simple;
	bh=HpceXxCPMSZiMuV6NEi/uY3vmwMc8uj1BH0VLDs8Gak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFTW2BX2A3Wo2Zb1oWckoKS77e9/d/1/7ffBOmBxpxsB2ICC+1ZV7lc4bB+9hKnY0rsmbkHRNgNwjo5o6OGmTYZDg1Ko8mtwuJHi/mZ1/Ji47AImF4ZEWEJsg/IavXaPkEaLlTEQT91uqRp7bZ/eWN+dGUm2KGAE2wjiCUB41Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f72PmiKI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f72PmiKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhgLJ485Y6vLoQMLXTnjuRpatShBOLIyxS5mQIk6PNw=;
	b=f72PmiKIwx3OL5Zva7++EgVXVYkH5ndCmp28MiWjkYapheMJNgsYtHWiGxDeeRVjjUb/jP
	1usvTppYO4vp7T0FxCGFzdpisHM0Q4SuvWilRsT1FnPWqqxbvZmfbOcga/XmrURCPxekAy
	X3iuVjrCgVW5wEH2NBSLpz1/NcKAlvI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-pHyNU-_bM0iev5Zphze7RA-1; Wed, 22 Jan 2025 01:13:02 -0500
X-MC-Unique: pHyNU-_bM0iev5Zphze7RA-1
X-Mimecast-MFC-AGG-ID: pHyNU-_bM0iev5Zphze7RA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso12413116a91.3
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 22:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526381; x=1738131181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhgLJ485Y6vLoQMLXTnjuRpatShBOLIyxS5mQIk6PNw=;
        b=MCoSuA/2d+mjcb/yO2gvjkn9BQ+M/D3MNzZ3zNovUrkWdQElrQuUtxcOqf640/GB4y
         OrqQwOHnCkzVcGjYp+dcKhFsNgq6J1VVJwcA53E5Wuv5QAjD2s1Pux3kKugwfsfHTluf
         CRpmfsTB8dA3y8CbN/JCK6RZ79FAM+fN1FrxO3RvR6RbmWakXwUE1qVpXzAtGmg2cpYW
         iDNR+ZPVOg8iEN+pr6mKmhfMpBzSCLUI4UipOMl9DMn2zVFxovH1PAt8EjtRF2hU8xTC
         SpDqqOQn4JQ81mEywXuknNO6i3D2GYHFbwLRvASsIxpP6LRDmCc1qTiPyWDXahHw4dXa
         MLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2XbpVWujCfXXjwkwPy7KWZKIz2Pmkrcmdp3XC4nJKIcSWe2Av/27ERwpj/XxCxKVLf7ei45oeKiknXWE+wg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0XKe6K1z5bQnZOmFjl/L21ns/CR9XOFeKT2Kj/4CYoiGCemlp
	8gbWLgFg2Tau3MmTxIvvx0mJra3lgV/NRxcEjFblstzpbucWrVzyQW0PGna7c8mupeTrwXNlRI6
	s5TrWLwXTe2x24ytmLchzhc9CoomHfbfuIaQveI4ddH0xsQ6R3f2wUEdf2mE9esgP4PvnSBJ2vR
	YmJ60HfNikmyxwhhAaMGsChoEqxHNlOi9rjmmgvAM=
X-Gm-Gg: ASbGncu7oHKYjlMQkkz4N8pHs2tYOjd/zlV5ozFY4n0ykhCyvjDZ+FapoPa5kYu4fg4
	SvPKEZgMnN9YWfit0OBs786CVkROH4hPTIVatLni+77HH8AZrYy0E
X-Received: by 2002:a05:6a00:c92:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-72dafa9ac70mr26362359b3a.15.1737526380547;
        Tue, 21 Jan 2025 22:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqxkNQXj1qQ2FzevSQgWxRwrblUKB9YOBicFYwTenptGz2NShL/5JAi2cM6xxZQlu/BESTppyKXhalwNK8BUI=
X-Received: by 2002:a05:6a00:c92:b0:725:e499:5b8a with SMTP id
 d2e1a72fcca58-72dafa9ac70mr26362245b3a.15.1737526378551; Tue, 21 Jan 2025
 22:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
In-Reply-To: <20250121191047.269844-3-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 14:12:46 +0800
X-Gm-Features: AbW1kvZnr46WR0BN5DEhhgGbxfpOOIQ2_rtXVT9nGyaO7ohwjeZikWno5pKlVeI
Message-ID: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wicMZDhpdRbXam65kMtHQ_EpsYl1dbPSPAIjV_MqFIk_1737526381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Slight refactor to prepare the code for NAPI to queue mapping. No
> functional changes.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  v2:
>    - Previously patch 1 in the v1.
>    - Added Reviewed-by and Tested-by tags to commit message. No
>      functional changes.
>
>  drivers/net/virtio_net.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..cff18c66b54a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
>         virtqueue_napi_schedule(&rq->napi, rvq);
>  }
>
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct=
 *napi)
> +static void virtnet_napi_do_enable(struct virtqueue *vq,
> +                                  struct napi_struct *napi)
>  {
>         napi_enable(napi);

Nit: it might be better to not have this helper to avoid a misuse of
this function directly.

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> @@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *=
vq, struct napi_struct *napi)
>         local_bh_enable();
>  }
>
> +static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct=
 *napi)
> +{
> +       virtnet_napi_do_enable(vq, napi);
> +}
> +
>  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>                                    struct virtqueue *vq,
>                                    struct napi_struct *napi)
> @@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_i=
nfo *vi,
>                 return;
>         }
>
> -       return virtnet_napi_enable(vq, napi);
> +       virtnet_napi_do_enable(vq, napi);
>  }
>
>  static void virtnet_napi_tx_disable(struct napi_struct *napi)
> --
> 2.25.1
>

