Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59C25B0B5
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913539; cv=none; b=E+rKBlAND4yof3qIz0fV15YW262GtSwYlRfQrfe551TWrnSU6Gr8LWeKM92NDYS3BD7ABhquocpkZLpwKoCBE277d2b28ng+Y89S2/N724PBlLUvJmoSxYrPdq+S9L3dEVVyXl9FjJM8rCSVhSV9PSzy6P/IP2BZYQNf6mh67UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913539; c=relaxed/simple;
	bh=nSzeTxmAKXshLommZd+BjJLNYtGoR4X9OdMr9e0Arqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXvDqEdwbPQtl5XRJFqgy9Icunsr/sk3/rtYvLg5H7g281oL2gFT0ofT5cot1ojvyJbDM5RUxK+BTtvFpj7OW4agQEh5kSOv/iWmlhMOIcC7tldNUwFJTjfurpGZmXRY5ZR5elogTBFA0MXjRwg8tbrXUMEGpa6K3kEHwB83JIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2usGxiW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2usGxiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782913537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IR1dHlwY7NBforvWvGvor6jIT5+PE8OWSsB/c6dBT14=;
	b=R2usGxiW7Lj9MJlq9IF/lyVIyV5de4ccPVZMqtZL8SF0J/igcwYuSDLgUlFyB7thDW4ceX
	N2ky1F8zIp39nwM4hfu+xugj8lc7zvSzNFvA4YNjpLBT2ln6CtgdqfM6IirmuIqP+BOayv
	LUu4eWxr0vn/yVbuX/qd7SwbuWmzL80=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-nxT2XJ69MAGsSB3yOwnu_Q-1; Wed, 01 Jul 2026 09:45:35 -0400
X-MC-Unique: nxT2XJ69MAGsSB3yOwnu_Q-1
X-Mimecast-MFC-AGG-ID: nxT2XJ69MAGsSB3yOwnu_Q_1782913535
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664b6d4bdcfso3048234d50.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 06:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782913535; x=1783518335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR1dHlwY7NBforvWvGvor6jIT5+PE8OWSsB/c6dBT14=;
        b=TXJWxHImV0xVFY1P+4Q4yz+HS6sUZ5vezlk87RsijJLjov8HMOsy8pXkhD2/FegmMo
         0yljQ2iN2cO3ZD5ZztToXkNUGUyzVAvYYa62bvfk0XnHlCXHqAb05OZFj7BbaEWBKYCr
         R839bnbMS0YC9lopFGqVXCHo3Dz9tQk3E9yb5blw6E/9vIB5ut3+OmOADTokoa5a2+oN
         D4p5ctq+dCoPsup2gMSmUD8JuSmMb8WeOos4hlXHKndGHygx84ssli50EnyWY0KEvRj7
         Zr8aRAr31/D+IphfU6XUgSI544eN6AWdTFmtZMYEXVFKt04SOKtqkPVONIn/qu5sFBk9
         VqSg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf0TarUqmIT6/kO6mLlPOWWiTJtlWRb5nXXby9B2e7ARV60ujlONwRT0xoRUkSMIa6dYxogx1eDo3S28CY1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7VvI39Y1EKgsELNT8QtwxIbCFf8CMVcGSpdR2qcEZ1ntyCgAA
	k0DTgaEQ8Kn4HNt9KRdqQ8P0WZY5r6LdTNIxno650jIDGUmXTzjDFVygN46G5/Dg44c9KzwnaSg
	gyL7l+FfZKEeFsWCm6SJDiciGrSRMFaqoeljBguxBEnNKEV3VKBOPC0FFkeX75YC+74LQB8d/b1
	RgabTL6cT6XwWQ4tUeosHntlt7opoaXVl1ukZKHJ82zdU=
X-Gm-Gg: AfdE7cnTDaoUFp1lcQtspPugGANFlfgjR869+x0KJFUTnTEFIQlXtHRxwHC20GNMW6I
	6sIbdPmH0RXbMo32sbnt+aLOd0eJOtCjr4rf+3tpL/MqVlgMieX9dNJvb263hjpoGoE/nL6xTqV
	D6SIq9zRxaHbgtB4pHRRs+bcB1u0hKzaM2Ei5BLBgAgXTv1tUsJgVwJWHNQw+j3/2g9uUgAYklh
	kIf3oK4jEiOaz0dBci2UY8jA6zom9sQ7uFKCvpspl4pBg5z4KUmT/HdegOChPocf2Wm+A==
X-Received: by 2002:a05:690e:14c6:b0:65c:290a:d7ac with SMTP id 956f58d0204a3-66520e00450mr1496173d50.6.1782913535018;
        Wed, 01 Jul 2026 06:45:35 -0700 (PDT)
X-Received: by 2002:a05:690e:14c6:b0:65c:290a:d7ac with SMTP id
 956f58d0204a3-66520e00450mr1496129d50.6.1782913534527; Wed, 01 Jul 2026
 06:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701113608.1972-1-lirongqing@baidu.com>
In-Reply-To: <20260701113608.1972-1-lirongqing@baidu.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 1 Jul 2026 15:44:58 +0200
X-Gm-Features: AVVi8CdjgoJWWI4oKVciaMBT72Be7uKFKxclzfHna9TqnJfOtFZ4kxv4f9-1okM
Message-ID: <CAJaqyWeBmhtP1HFL9Sqv9Wj=zVxfGH0xe_5JsaTJtYCMHhUdHQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: fix wrong list iterated in add_direct_chain
 error path
To: lirongqing <lirongqing@baidu.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Kees Cook <kees@kernel.org>, Rosen Penev <rosenp@gmail.com>, Parav Pandit <parav@mellanox.com>, 
	Eli Cohen <eli@mellanox.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CUsWnVPbqAxLGUGdBhGDnxV5R5CoBWblcxAFDCQLwHM_1782913535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:36=E2=80=AFPM lirongqing <lirongqing@baidu.com> wr=
ote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> In add_direct_chain(), newly allocated direct MR entries are added to
> the local list 'tmp', which is spliced into mr->head only on success.
> On the error path, the cleanup loop was incorrectly iterating over
> mr->head instead of tmp.
>
> Fix by iterating over 'tmp' in the err_alloc cleanup path.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 6d02ccf..1a224f0 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -480,7 +480,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvd=
ev,
>         return 0;
>
>  err_alloc:
> -       list_for_each_entry_safe(dmr, n, &mr->head, list) {
> +       list_for_each_entry_safe(dmr, n, &tmp, list) {
>                 list_del_init(&dmr->list);
>                 unmap_direct_mr(mvdev, dmr);
>                 kfree(dmr);
> --
> 2.9.4
>

