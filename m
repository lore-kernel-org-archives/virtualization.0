Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CF1CB337
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384005; cv=none; b=CRnAGqAQKpABSSZAjQWKTt7Hppy2gohTVZbP6kxse3JHyV2J391i0f8Dfco8EofWVg0Pii3J2PsK69VdAbIi5RpbQo8H8ThOV8XAMr1qa0QuEbzSvOl9e1kBN0bH8FIzi86mVPAkCvMgVi5zNDKcdisKgQemhmjeMCR5LtS8wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384005; c=relaxed/simple;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H49eOVnwPq3Jq+NttCKZ+JaLzdCk0YCLqXwwTBkZkyvNYVjVicBZhMm109Yt/Rx0HfEuLgptHbl8k2H50z5XdxXIXSNN+j3DqnJ37Eb/B2oYCr+jHHmIsXIS+bCCRHPkmo+31+Rlk+46WRYBOKmXoEEKWhkrhSzfrHIkPpbf9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuChJRyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuChJRyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733384002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
	b=KuChJRyiL7529Dd9mQYgTJ8YdklBt+JdXQn9KpnPpxvkCT2LCuoRILBQgRQcTad9/ulOAc
	aB78C90Uot8JPUsm29rRRWtq+YcJFY5jXn3bM1FS3vT3qRMjqt/7XBDtNSHnuACU0h0mqX
	Rh70PjoSsbUOjX3LTZvxi3iXrEhOq5w=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Rq3Oqx6YMp-YWhq7KG58mg-1; Thu, 05 Dec 2024 02:33:20 -0500
X-MC-Unique: Rq3Oqx6YMp-YWhq7KG58mg-1
X-Mimecast-MFC-AGG-ID: Rq3Oqx6YMp-YWhq7KG58mg
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-85b8c2b6ab1so167057241.3
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384000; x=1733988800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR8Ks9hoX/zY9Z6VgXzgidX0Sq1XGsPeMKuoflaftsY=;
        b=BLPGOmvYTXa+D5EpFtvDRllAB7acpfWMZlHvvL+04vTkX9p3k9FQvez8xm2DXJ4RPT
         c9lowJbjhmFY+ORmCUmQ2KsfT2O4kEV0i9Ohu7wa3qQ51ZVy5CftsYgDcOhIJs3nwYV1
         kuyEiqjAPzhhQ+++KyaYdxXxycqTYMhk0+5+iiCb0BHgnDw5W+cZzNagNb7RxWpkcpz/
         MUXh6Cwoa8bymTXQOIJwPxR6qhsPpe23YFl7tRkqdH8X4MFJZvj1FrDCX06sdgY2vmAU
         6ewpBpoz9NNWmASndCGHh9F+oJObSIoWi6EoigHBHQHNjsqlJsNYUFyqd6kYDgfTc4zZ
         KGUw==
X-Gm-Message-State: AOJu0YxfFedHsPJXnexuYGFf7/AwthqvpxlDsFJP+JYmK2DBGlOaUZr8
	ONtOi7H93XS3/2k5UjyVdhaA1eGwbjOFXTYb5aS56tMnnEwBnKNqwaeJh07YXa/Hi1EeBR293aO
	nVsyhpqalikXaU1uod4IewYR2aJh2F1n2UiMBBymIpDm9U0HByl+1V7nGy5c7X2d3VygiYiSJJc
	8+2k1nwTUvGEsVvePns0CpPTrzXBhqRfwDOEqttm8=
X-Gm-Gg: ASbGnctULuXBx4RntF3C2H335nRai3qi5426fK3YtWWLgw6xPdCJRzLgxsL6hntRiPA
	jfF3UZXtAb1SIDTYbr6T+aoftJoUnNd2n
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id ada2fe7eead31-4af973616d8mr12754226137.17.1733384000440;
        Wed, 04 Dec 2024 23:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELTyIwlkQV/FRs6ijjhpSGbcHEbQmTZ4PYlrb2mZ2b3HG32XEj4FFiezBBQtrrkcWKDD+bF56IdeIGqAxNni4=
X-Received: by 2002:a05:6102:e13:b0:4ad:5c22:8412 with SMTP id
 ada2fe7eead31-4af973616d8mr12754214137.17.1733384000076; Wed, 04 Dec 2024
 23:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-8-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-8-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:33:04 +0800
Message-ID: <CACGkMEtd9-=TD2J-ds_NGnim-EeKYJxLiqJXemMP0JY8EuMeQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue
 is called on bind xsk for tx
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TCr3pY7HuTYmec4zr6ix3ogGDN4VPIxNACQK6eCf4L8_1733384000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
> DQL counters need to be reset when flushing has actually occurred, Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
> to handle this.
>
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

