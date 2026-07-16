Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DD399D0B
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196116; cv=none; b=o6Q/GajdAlbFoproYZP0VE28Qx1xNzv0t3niBZybyI6fzwIM/M1SqZwdA0LU3Wfplrh2FUGBUjSvDJrTK2/IprRu5nAYE0q4HdH+cwQLpzkFevg04nVoIh2HCqR7By6XPFWzmDaSGwzWcLeWsvRaKTFqGb0VXvcYdNSXm2V5D4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196116; c=relaxed/simple;
	bh=4J+LRl1E31ETdtySJs91tQOjUybYz/e/7NrIdVDeAbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD1a7EoIXblz1GU9VTzRD9TIOMI6u94+0YxV9t85+y5mi1C7umFxmskwuOoZWIx5C4ROpQ9+WnZPH/fXG4RWFVMjax3dHO0z0eadM1Q5PTADrwCzC72Ms3STxIvdegKF1ZctlOd8X6Q4S4ihWGhueHEX7dweG4lIZAj0hdL+TPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtLmSLiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtLmSLiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
	b=AtLmSLiSBfTA3Ojh2HsjnDHOfApmvP7u8zfKbHbWC3wIwtaaKZUbRhW5ubSA0jq0408wJl
	6AV7u1uE8JB5qb0aVeqxi3cEeDLDcQShDZGl/Lvc3gZF+kQbWrabNmytDLsSIE7P3uKPZP
	F56HL5Vxgx0xgFU6DWWqothCf/NlU9U=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-GBMkMx90Nj6x03uwowSk7w-1; Thu, 16 Jul 2026 06:01:52 -0400
X-MC-Unique: GBMkMx90Nj6x03uwowSk7w-1
X-Mimecast-MFC-AGG-ID: GBMkMx90Nj6x03uwowSk7w_1784196112
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e67e87752so37877627b3.2
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196112; x=1784800912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        b=ctAFgzGYGcLlBxp3eMZarjrh7NhGdQZAsAQuY6H2JvYWdmGzbze3J35RfnV5ieIe9S
         m9egBRwF8MgNDAJbAozD8HgSvIpZEpDOfGYimIOyUTAFZp/DT8i+pgMHXNSqD53QVuM3
         wPzxoad37AzZI86RjUTbes2/8H36YdNym26w+54FmG5pXPp+783r7zrWdWLISXtsH+A1
         xwg6N9bvgrbvlK43z8kTyegfj0Q7BEck5xYOOEs2oDE4XC2u0fuFdLVzqSahNh6Ut53X
         ZTEniIgvan7pNfHAO/UCuBRm6JeDvx11g4ZYV8ygT89pb7bRVSz7tV/PdarOV3Kvh6hH
         YDNA==
X-Gm-Message-State: AOJu0YwW1AoDbNceNUFt7I0g7Nf9cwTlUjy3aLYFFeq/dC2I9CBMeTkm
	0Fo2rlxkh5JCfp1OIQSb5QXADpnHgYr2tOF1XcKZ43Kivy0F50xJfMmS4f74+wenX3bc5hqvnKO
	qTguQ4WuQomorIAD/vkXawI+UhchgWKrNl2mTJJ4qcrKgh3IIkATJLEdBQlIoDw+1QHwuWgMfpg
	nTzff1DmCnb7JSH/lJ2pysv9FswLlpVNdIYcSxEBZ1sv8=
X-Gm-Gg: AfdE7cmNJfmsNtu+vd6yiCRE+BYr0/G5HDXW0umW1BnbSCT+5mFMAEs9hDy9Lg6f/u9
	SHyXY+4xxRE9pXmK6elzTm43gcndzFRVGvjLnK0cwo/IORniLX8Ygcy4pn3q4OW2uTv5fdbw5r2
	lZgHpuh30MsdMU5IgAi6Zub2yOTCh3XXtYjcF0VyOjOOOaakueWg6Xjg5VC+jfBqMZCXMdgjpHJ
	qdQqXPrqOG05NGmmi4QSLv2/rGWyh6+G2813FiXoksfpU7eMrHMaj27R5azKxl6YBmRfyeDigi3
	VmtYlIMv1lQSsv0=
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id 00721157ae682-81ec5bab97emr51788207b3.39.1784196111554;
        Thu, 16 Jul 2026 03:01:51 -0700 (PDT)
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id
 00721157ae682-81ec5bab97emr51787967b3.39.1784196111105; Thu, 16 Jul 2026
 03:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716030242.124455-1-xiongwm2026@163.com>
In-Reply-To: <20260716030242.124455-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:01:14 +0200
X-Gm-Features: AUfX_mx1UNEXbgfju8J4YPpG9wOazGi-4uMhtWJ0TvC5HjB07XmtqFhXc3IuHh0
Message-ID: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: propagate set_map error to caller
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LxTO0Uy4ohVOaZYCM7MImCtWpzawi30ZBLsBuIB3SG8_1784196112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> The return value of ops->set_map() is currently ignored when handling
> VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
> the VMM incorrectly believes the operation succeeded and may continue
> with stale or incorrect mappings.
>
> Save and propagate the error from ops->set_map() in BATCH_END.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vdpa.c | 6 +++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..ffbb10a92 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1297,8 +1297,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vho=
st_dev *dev, u32 asid,
>                 v->in_batch =3D true;
>                 break;
>         case VHOST_IOTLB_BATCH_END:
> -               if (v->in_batch && ops->set_map)
> -                       ops->set_map(vdpa, asid, iotlb);
> +               if (v->in_batch && ops->set_map) {
> +                       r =3D ops->set_map(vdpa, asid, iotlb);
> +                       break;
> +               }
>                 v->in_batch =3D false;

Maybe this needs to be discussed, but v->in_batch should be set to
false even in failure case.

>                 break;
>         default:
> --
> 2.39.3
>

