Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27111CAF
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053616; cv=none; b=Kos3vXd9KdtapmBvcL88P3ytZLwXbtjgAG3uHDMiYCz9KjSIBeKPF2afnGtFivtI2uWyqdz4/ohM1H1JOKHWJrtWFClhjcIAwj5A/1QlM1kzAjxAn4e3VQkYsPbjCu9AsCswyNNYjEaV6+8FPldB9KEajbpyHp/4kni2IeNIMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053616; c=relaxed/simple;
	bh=JHk4X3vZ8MFvsUzR7DvpEVGisQVp8HYBRZBRGMOySDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHuHgamgOl8IkWaVyVBBduWKpFk4zIiGyg5uH45RTjchmf5hL3hL+MKd8eSbb6N8uBZ1sznWmuwmEPEKKjTu2B04qNeHxC+C/AHDOkKlPBwqaZ4N7vzDrlyTC5ONWAJBnuD3x3sWwXEvKTBX8B26JkhdV52KyRFQJpirM2lGopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiGQb/5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiGQb/5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741053613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6ne55QwhftFYTm3pAMElTqpEZ/LORaNN0Mq/z5tJ9c=;
	b=GiGQb/5+YbGm9ExIwL54VEldW3Ys9tmLH2tdWxcc+EXKF7lIxr3U6PF6ASTqosC/ztlLfq
	audcAErhXuiCNEP73MNr6X5JRN7UrHAngnUGmchGS/SOPzcdKEUBlO1NITngwxXbMLtJLy
	f/dSdV4EO9mZec+F+6pe5Mme8kyYE1c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-bqVKIghiNB2SELJk5egG-g-1; Mon, 03 Mar 2025 21:00:11 -0500
X-MC-Unique: bqVKIghiNB2SELJk5egG-g-1
X-Mimecast-MFC-AGG-ID: bqVKIghiNB2SELJk5egG-g_1741053611
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e54335bf7fso2051625a12.1
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 18:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741053610; x=1741658410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6ne55QwhftFYTm3pAMElTqpEZ/LORaNN0Mq/z5tJ9c=;
        b=PLDjjBO+SIwD3vi1gwyK6v/rOq6MyAkSjcgfzvO9hXHJbavzvUuH6+zHJjtruZFmJx
         EX+/U+34/OzYhCNdN/03OISuzB33K2i4EXbaSEKdgBdgpNyoZYPKVRt+4VegRuvxzPPn
         siiC9RPUGew6dq+R3nkAXx/MGgfFXUmXSjR6rWcT8b0e1M2KfQqTqDqGj6ERejuPddk1
         BnJdsFDWsrcZLSxBd8awwrW7BXmTtJ/62uu4lZkqNh7B6qLdrNRW/6olLHP1cQEhkX6j
         InSi5hRU9a6AaTWCL0iV0HbQphBGmVLdfthmN5xtNpNVUWbsdteelLr4bJ3tmlak/a/Y
         auLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKy4osP31Tg5DWf2SmKNsrFFyXDEkHFzDBaiR7VzwQncYIHfouFBJgKwlpxNYcsA++lLtl0cOaplXWxdE7Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3la4k6v+KPD2WiucUirQ94bekNSwAveSghi+j657BSPMTF7n+
	2rvFyWPYIZOCqbzR+EvefEtOQeyFqcMlWqgYwKT6+klOx4Nz+hN4m30VTTpIVlscRRVF8PiIMqq
	wdWIS04Iy+rPUTaAID3MeSFqSUDmj1aBDcNni6GecorB/5oFifUKCZiQoLnL60j9rnW4t4GOHsl
	DlaM0CRaDDuGjEnPFV7LhSFSGPUacuo1nHjM7r3v4=
X-Gm-Gg: ASbGncvOzA9wLLp2sFZRIhUOjtgAJt0f8FDJNHHv4mMMq189bq3T1w7Zubn5CUMT4xs
	hT1MFJDZ8OWJwlZKGvG54s2Toew7v9RhWiHPGgZlVYI/xlKtICT5l5yaGOsIpiYIeusZECap4vg
	==
X-Received: by 2002:a05:6402:2714:b0:5e0:922e:527a with SMTP id 4fb4d7f45d1cf-5e4d6908f02mr43147293a12.0.1741053610612;
        Mon, 03 Mar 2025 18:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGotofsTvb2AxtGxiUYRTOJP55UijhwSHRdhPuwJsFglP+Wr3zMaapIUvoTk6CdgEnWdU6MOBQ50VkHbyyuLfo=
X-Received: by 2002:a05:6402:2714:b0:5e0:922e:527a with SMTP id
 4fb4d7f45d1cf-5e4d6908f02mr43147246a12.0.1741053610281; Mon, 03 Mar 2025
 18:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a18fc6cf356bc338c69b3cc44d7be8bd35c6d7d0.1741028854.git.christophe.jaillet@wanadoo.fr>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 4 Mar 2025 09:59:33 +0800
X-Gm-Features: AQ5f1Jqo2O4hK3oJkjenR9LxQveC5GRpuyXs2Lm3CfD0L_mhdi24D2upTktGsNA
Message-ID: <CAPpAL=wW6szqfPm8goUfM=c2cat9-tyuB-UgwRdtx7s23xe81g@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio - Erase some sensitive memory when it is freed
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: my1aLyjfxMVvUeaGNO-OwikMvFd4nYjwD_qZhTpol9w_1741053611
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>

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

