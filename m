Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4F53E07
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="mIaOJOf4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bb968c02baso1666766b6e.0
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703613676; x=1704218476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoARjY6dq1LfQwY8KQWRcArsxSYoaW5I2Zkew951zeU=;
        b=mIaOJOf4e6IGVX/FsOw5AoeiK3rxDsHnfs5JNbx5nJzR1MSNCo5I9DKVb6m/sOHAKn
         WgjT4g4WL22ZujFTDyeTaJaehtWtOs/SSVyJ11XebeBeQEHIiH4Z5pcHTwnf1ph3bR2y
         HwJeWyJ6xvVwv75mZ0koTnvwKpm7iks1AuRGiD18hTEVfhg1bDLJYtZoDkCUrXxhT8xw
         makU7rLfWHusnztmp7ywnanM+hCR2NyRP4ToYytQizoWTJ5fcVe3s3L6nsSu8uK2pY8v
         F2humLCdlEZlG1ncbDQw27aIViYxkUDVCCk9K3F4MzoLPA/UE5nMEBgSIrm4nPYLumR/
         U91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703613676; x=1704218476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoARjY6dq1LfQwY8KQWRcArsxSYoaW5I2Zkew951zeU=;
        b=bdjZCCspJTpi+O48LYC5ajQJYu6AUSescM8M+96ih9RsZd+aO/ZBzWVzZTswtu8i8M
         +svmk1RLJSGePVeMGfdUVJ7W+qtQn239bFqUS10kRM4//u6i4zdbQxSxket2Z39ZY3+A
         F7/bBg0LI27facC3F0Zw39usOvRajvSzk3H66nEyh8V3aYnBEkBkWtCha6FrD0jGAke9
         01KC6gClDQBuswhtH/CJp9X/t0GGIk7ZKpo3FxlDtb38FXpNgU0E3SrJIMmME3/pD5TA
         KGfC4eOIKqCNzj0Rv9I2wJX2ST4SVKccx9wHw2u7//E7IfjNvG+g5okIVmk8WD0N6x3R
         zUhA==
X-Gm-Message-State: AOJu0YxGoG4pXavhWiLPj9nOCNlx/YOZJWUfIm4oh2ypkK3wy2KB6wJT
	AHLUZk1q9cTot/k17fp7DXuPLodqXSM9Tg==
X-Google-Smtp-Source: AGHT+IEDX9QG4TbSdych5DWmivLSsBVR3FKH0cNi7175BlRLj7lg6pFY3ao5xnxtu65uFqGf1XGdnw==
X-Received: by 2002:a05:6358:919b:b0:174:b771:e282 with SMTP id j27-20020a056358919b00b00174b771e282mr4678407rwa.20.1703613676388;
        Tue, 26 Dec 2023 10:01:16 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b006d842c1eb6fsm4575030pfi.210.2023.12.26.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 10:01:16 -0800 (PST)
Date: Tue, 26 Dec 2023 10:01:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_net: Fix =?UTF-8?B?IuKAmCVk4oCZ?= directive
 writing between 1 and 11 bytes into a region of size 10" warnings
Message-ID: <20231226100113.4ea54838@hermes.local>
In-Reply-To: <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
References: <20231226114507.2447118-1-yanjun.zhu@intel.com>
	<b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Dec 2023 19:53:58 +0800
Zhu Yanjun <yanjun.zhu@linux.dev> wrote:

> The warnings are as below:
>=20
> "
>=20
> drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> drivers/net/virtio_net.c:4551:48: warning: =E2=80=98%d=E2=80=99 directive=
 writing=20
> between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=3D]
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~
> In function =E2=80=98virtnet_find_vqs=E2=80=99,
>  =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98init_vqs=E2=80=99 at drivers/ne=
t/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4551:41: note: directive argument in the range=20
> [-2147483643, 65534]
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> drivers/net/virtio_net.c:4551:17: note: =E2=80=98sprintf=E2=80=99 output =
between 8 and=20
> 18 bytes into a destination of size 16
>  =C2=A04551 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->rq[i].name, "input.%d", i);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> drivers/net/virtio_net.c:4552:49: warning: =E2=80=98%d=E2=80=99 directive=
 writing=20
> between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=3D]
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^~
> In function =E2=80=98virtnet_find_vqs=E2=80=99,
>  =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98init_vqs=E2=80=99 at drivers/ne=
t/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4552:41: note: directive argument in the range=20
> [-2147483643, 65534]
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> drivers/net/virtio_net.c:4552:17: note: =E2=80=98sprintf=E2=80=99 output =
between 9 and=20
> 19 bytes into a destination of size 16
>  =C2=A04552 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(vi->sq[i].name, "output.%d", i=
);
>=20
> "
>=20
> Please review.
>=20
> Best Regards,
>=20
> Zhu Yanjun
>=20
> =E5=9C=A8 2023/12/26 19:45, Zhu Yanjun =E5=86=99=E9=81=93:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >
> > Fix a warning when building virtio_net driver.
> >
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> >   drivers/net/virtio_net.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 49625638ad43..cf57eddf768a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> >   {
> >   	vq_callback_t **callbacks;
> >   	struct virtqueue **vqs;
> > -	int ret =3D -ENOMEM;
> > -	int i, total_vqs;
> >   	const char **names;
> > +	int ret =3D -ENOMEM;
> > +	int total_vqs;
> >   	bool *ctx;
> > +	u16 i;
> >  =20
> >   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> >   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed =
by =20
>=20

If you change the variable type to u16, then the format string should no
longer use %d. Instead should be %u

