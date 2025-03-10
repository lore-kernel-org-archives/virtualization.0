Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796E29A0
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582556; cv=none; b=sANNBfiOr864L4KlDJIpX9/ofN+34oumoluO0c82OBpKCbgkfKp4e19Hx/cu9kEUqZFlJQLOvdOuWWryjJPPZ/+g0x4pt0fXmPa/SCLXXYPUJbisbEE/1Sau4dfretMpjkpC5+2Y3QKQ7l2snlZRqK+MOoIiNWObarGM6iqgkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582556; c=relaxed/simple;
	bh=s8/EMeFEWEYah/ToEcdcQneRc/EsdPCJPwOwk2JfRWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/j9IQ/tWB6nDBdYe2/VgMFT6L9M3g/dn6Hj58K4JKL/rP3iVJB1NR+MbcoWLWLq+zqg+iOgnkthlrN5KbJTtuKZdRBy21Z3SaE21M8/27N8s0xVmrVpoFAJguB0R7b30EVtayi0peUYZyr4FW6o0tYQMG8nZSptzQd3XSNhHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFhw0FPZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFhw0FPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741582552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGNHJW4HHjvj/4hx7d09Bc4jJVzUfVQWIWoaRlJrRIo=;
	b=bFhw0FPZJRp7895r2XsCpumUtAKHqIsw5eKwD2xj0we2J5GQkpm7aDk1bykLTZVBfs+ePf
	z1t72wabJW32fqOkcvarGdURiLLqTd+BOtGO5EQoz9wp6o1D1iX4qkcRj73MwH7p64Fk9C
	bteNc5p2WXi/Tn38E8eG6v4Lz981aOo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-XiHDWMMEOyCJ6tRyNeuK3g-1; Mon, 10 Mar 2025 00:55:51 -0400
X-MC-Unique: XiHDWMMEOyCJ6tRyNeuK3g-1
X-Mimecast-MFC-AGG-ID: XiHDWMMEOyCJ6tRyNeuK3g_1741582550
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso5097792a91.0
        for <virtualization@lists.linux.dev>; Sun, 09 Mar 2025 21:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582550; x=1742187350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGNHJW4HHjvj/4hx7d09Bc4jJVzUfVQWIWoaRlJrRIo=;
        b=TpEnWniL5PHpde0U/SX5YSjMIDxO5AwXmhN+LSMMTTUHdMzaZCiIU2ebVUYvYjMyl7
         iI86E65v3PXSmDZWGJ9Cc/LVfdzLXbMnOLByhq3B/57mGHNx70MJPEtG4Hdbpv8HJbYu
         3mYF4ZigFiku8A0g3p7/CcETSC/vLqNzSazq+TOSOL6vSnDKZcUMRllYB81gmd/r1wBg
         zHW8vIqFXnM9IpWGR/XTv83X/V4gBW+kvcA/c1xptSN+jiImbLYLfRNImR2Hjw8ktTzH
         EnfQX47WEHTkMu6jnmwNTB9DOPmbBqeXQ18sgptPQb4rIG0ZUYPi966+BD0PCrDMvdIo
         J1+w==
X-Forwarded-Encrypted: i=1; AJvYcCVpuIvuYHssu7EgdHbyB7RMp64hTPJNrAJTfXrovFLcP0C7s/5P0Q56xNjBDyzOHVBEnW2pltUzLOjEdheNcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOe83N/4Fwy4cW5pc2aOzuTQNmVAVU4fjg61O8REnMjeI5ASnn
	r/PNLV0wv+wp8WXQ9XHlhnOYid13yUHcBr4RhW855BFoAGYQ7ndWeuEqc+a+oQDg/9X7R3au2JI
	mTYHUZHf2Af8ZSjZ5dxhYdlS/f7OwyljSme/13xEcDYDaPi1E5P0iuOwS9zm+4z33Fhz5grwcxY
	xuLBm+0JNFgjg0TBhPEtg52cAwoa7i13cw1nqSmj8=
X-Gm-Gg: ASbGncsrRjbqSHcN1q9V8G638l5TuKLViQ6TK4yK+AbyaEgH2233SVFtBI9kgvrojzt
	7ORHQuF/fLNK9YkOp9sIl4HjvdoJAvsRr899xjBi7CbUFM/p61mCqPGBXw6XI7Va6wckXSNTR0A
	==
X-Received: by 2002:a17:90b:1dca:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-2ff7ce63264mr18532337a91.4.1741582550418;
        Sun, 09 Mar 2025 21:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Xo0gpzEFD/TRddMKMUNDMbauhJ46adEgdxNBxtmb8EtkPrUSIh1rFd5iEsD5Yp2BE7jzIDOi/82H1hGyNkU=
X-Received: by 2002:a17:90b:1dca:b0:2fc:a3b7:108e with SMTP id
 98e67ed59e1d1-2ff7ce63264mr18532310a91.4.1741582550025; Sun, 09 Mar 2025
 21:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:55:38 +0800
X-Gm-Features: AQ5f1JpXzBv8TIF6oxVj41FiZlnmi8yR2xYeZ4UVuxEvdCcbm3NW-Nyvl6onBwo
Message-ID: <CACGkMEtRFtzb-hbt6N8YJo8nfOOvaPcaw4dLkfs5CWN+ypkLeg@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio - Erase some sensitive memory when it is freed
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mcYJ0Yigh8eUPJdzV1j5fsqD_zMFX0EUGs84Bjl3LQA_1741582550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:08=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> virtcrypto_clear_request() does the same as the code here, but uses
> kfree_sensitive() for one of the free operation.
>
> So, better safe than sorry, use virtcrypto_clear_request() directly to
> save a few lines of code and cleanly free the memory.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I've no idea if this is needed or not, but it looks not consistent to me.
>
> If safe as-is, maybe the kfree_sensitive() in virtcrypto_clear_request()
> should be removed instead.
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/=
virtio/virtio_crypto_core.c
> index d0278eb568b9..0d522049f595 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,10 +480,8 @@ static void virtcrypto_free_unused_reqs(struct virti=
o_crypto *vcrypto)
>
>         for (i =3D 0; i < vcrypto->max_data_queues; i++) {
>                 vq =3D vcrypto->data_vq[i].vq;
> -               while ((vc_req =3D virtqueue_detach_unused_buf(vq)) !=3D =
NULL) {
> -                       kfree(vc_req->req_data);
> -                       kfree(vc_req->sgs);
> -               }
> +               while ((vc_req =3D virtqueue_detach_unused_buf(vq)) !=3D =
NULL)
> +                       virtcrypto_clear_request(vc_req);
>                 cond_resched();
>         }
>  }
> --
> 2.48.1
>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

