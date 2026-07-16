Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03D3BE62B
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196295; cv=none; b=tdoaxcgc4Ht+9dMF2ZneVkniAzjAPFzkkYnfvRns2XlEhrsGGue1hIoCowsUweiu9UKp0/KKNB9gyr47eI2B3GgutWr9y0OiHNfSvbYAa6z1LK9naipyxUasQc/pKDiKgVr8Y8Qc8ZQ77avZTKBVr5d27H3dwgpkrzUcorsgIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196295; c=relaxed/simple;
	bh=BCB33d83n81ftt+P6iijBAgJ18dpo1QXcSXfEldMbso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjHhwJfscyZmlvtG5g5p+k0UX8zcP3tzcgK2VpecAPx+QxC89zFUck4mjXh5Zng5mjfeJaeO24qZriGGEDsIIfdeXzhVt4teE1Em/q2ne+fFGLx7nNcXmLb9ovE6xsMqMZwySke6fM9yiGPtJ2NwurTUok715jkAI1sjz+rpUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEHaN+zJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEHaN+zJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
	b=XEHaN+zJOgzogYfvfV6KCilGkV5fNoXzFqa5mSozY3cq624mYvR21rA9+RWVXMWTwX4IRv
	FmnSlBZSi36sKPiiIxBtBhGDQyawAbmH0UqWlPhcEbkwgQ5UHdp6lN6DGYc/Bkgzzecb+4
	/PzmRkNh3F/ljSoY0Ux21bxZxHjeIq0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Gs5rfa3SNFy6Q_jGqXQenQ-1; Thu, 16 Jul 2026 06:04:51 -0400
X-MC-Unique: Gs5rfa3SNFy6Q_jGqXQenQ-1
X-Mimecast-MFC-AGG-ID: Gs5rfa3SNFy6Q_jGqXQenQ_1784196291
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81df8abfa7eso138441537b3.0
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196291; x=1784801091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQt8yS/PdstDJXEvnchALJjULr9f9l02ImmRKvduirw=;
        b=cR9ZdrClD9neI/G9wzQPmpzEU4HGJRlLVe9/j3I13ZOo1uty9g66/5rPrPS3jSeJV1
         ucmauofDHmVVMaW3P0z0ASlJ/tDR5UECYsu7Iv5EqlidRlcidn+c3jL0wqIVtbmfvV9O
         BSu5Wk3/pTLY/0Wdc1Zpq2m7CNsVC5pITzTOepfAA9Oi5Is3DgPs5Jai82dxxWDhdOUi
         nOfTzBX+DjeENbX1liaUhAZ46L8xr16EWtKd30sap5lqkl8bwgItedHRoIGe4g8GgyOh
         ynSlZTJXG6mPLV36kjKKB07/+5YneBNvzl1XuuYp8zKsIjiXrpo8varE7XRt/bFkYOFd
         kY1w==
X-Gm-Message-State: AOJu0YxDC+/CnhkGY54bCBqa4y6MJ0xmxkCX6S4w8PBgp0zjajn7dVij
	lMUwvuybxALbQljN1tkHnVqtNm86VJnb9ICeyYoN5bQopfdHi0n3p/WP5j6urm5YC2zAJ5HHsA3
	Fh8+jYMlA7btNx0bXLkadW+gonTepKKK7aKBfqvmA0GA4lRWfOfo2oowl22wea4V4m5Y185pf13
	8kXaHNVffqSpFwa9yzALenAlQXBNIDes+V7GOCSHZ8sYI=
X-Gm-Gg: AfdE7ckYhWvESRXRJZ/pfPXVZ5qBBOuH2vDw7igWvnXr/62GV5dCOyuHeWB5Bqqz62F
	X4nj8VD9YSDIeI/0S/utOJGNr/fOJuieXCJv9cNBMrAoQ3GPWdESMZspbENnyHg0zOVijUw2cQj
	phNPB957jBrRGBenMC6q1v7kySxKAQxUl3CSIwnd1LpZFIQe7PdEjFaXJ4TeTwKVYciIbHbkHNa
	KaVe8GGS2Hu/o34WoMjJFTTSAUtS7YVX+cbtRCKnNshS1lhjaJZHWaUzc1XhGbpR6MXVvdmdwGk
	XXHTA7LqsYyUcVI=
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id 00721157ae682-81ecfa37cf0mr48093987b3.42.1784196291290;
        Thu, 16 Jul 2026 03:04:51 -0700 (PDT)
X-Received: by 2002:a05:690c:6a0c:b0:81e:69fe:a594 with SMTP id
 00721157ae682-81ecfa37cf0mr48093747b3.42.1784196290871; Thu, 16 Jul 2026
 03:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716030238.124368-1-xiongwm2026@163.com>
In-Reply-To: <20260716030238.124368-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:04:14 +0200
X-Gm-Features: AUfX_my1PDjF2_brAd_JA5jz3TnFGBqbcce5MlVt-5iITb1GzEuz4iCkoFmeE4U
Message-ID: <CAJaqyWdXReDxp-nbz2ydHrNHegEFjm4eGoKYQGYmmdt5e_gjaQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: reject zero-size unmap
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bXbrRmVPlmLWYRtjHoAAfYED6n_aBKZFdJc2qt0HZxg_1784196291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> Reject unmap requests with size =3D=3D 0 to prevent iova + size - 1
> from underflowing to U64_MAX, which would incorrectly unmap the
> entire IOTLB range.
>
> This fix also covers the error rollback path in vhost_vdpa_va_map:
> when the first VMA lookup fails, map_iova equals iova, resulting
> in a zero-size unmap that would otherwise clear the whole IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vhost/vdpa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..f49bf1cfb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1035,6 +1035,9 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         u32 asid =3D iotlb_to_asid(iotlb);
>
> +       if (!size)
> +               return;
> +
>         vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);
>
>         if (ops->set_map) {
> --
> 2.39.3
>

