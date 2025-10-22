Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678F2D190C
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104530; cv=none; b=DjQtgPqwlDj/fZc/+BU4t9ifg98TnVYRx3MePfIxaVGs/UVB6NPMBtfTDFyLrqgxIUly9Jp/DlSTXfEYPAz6cZPMDPfEw5PUvXzJkRvi4MQIxdgWTJiB/fg+2OBA17p0D2m1rj7Umk1AnETMCimk5PYr3Jo7zKGzbJFqfLELC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104530; c=relaxed/simple;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ID4CeSJhWmLOpYTfNnYEiQ4No16P7pAQfMV1eglNv2bFcnDZwkluJC4x9kqwZ9BA+bGkFKsUK3An3mOZir0Mwd6BHplg8mPqCMgZKyoFedDEfQtAGyaU8fbfAOp9tdBs4AVcE7FSt9J8g4qY/3+qySjoefplzLE/+v7tYiT7oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNB9+QYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNB9+QYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	b=HNB9+QYwU/hlwidmnzylFJwkl3Hbs8qwdnHmEbjOoKJ8jm//jgjEmuZ950FdD0S0EGnrIo
	ikwOO6M2180DUg0r/7k01YNIfO3FKCSKXPyDoDZB+wbusqrGSRPSeoO0ef1Z0mvWXxEEjP
	IGLwYzq4DxYHVb5ukQOeBXLut/+3c9I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-SSdDEQCwPBGwkURILmiYYQ-1; Tue, 21 Oct 2025 23:42:06 -0400
X-MC-Unique: SSdDEQCwPBGwkURILmiYYQ-1
X-Mimecast-MFC-AGG-ID: SSdDEQCwPBGwkURILmiYYQ_1761104525
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so5232673a91.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 20:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104525; x=1761709325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
        b=N7MZRn5tF+2tVs3hqYe9k0pCsNGQ4HhaoIkLIfr/R6DsCIASSXVCZDgMEBFKZ2QmO9
         +uq3Cfm9ABlrspyMAzkbJrwlCC0DjVUgyjS3gGMkUj7mTstOCRkhHMm7QupeDeHHNg2u
         47v8hFCrLlSEkJUEwxzWBs/3DyU+ISd0yVIiaKDL4JovRJJ7XtYB4w/sEu1bznCNs6Tg
         eWjrJ9KWfPEno30qUMESKGlqj6X8Qrfl8GeCXjrNtT9WH2H7gvVPOghkkTqWX5uAYdza
         sm47NcYYs98eNy4uGmOAMQE33qggbKvNJe3y+HvW04Ir45P+2OVGWmwb3/1zfq1arBd1
         7BoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj6NYXnxeWrGrvXMtwwDsMjF1Kyiv4VhAidIJtvszWiM8uohryfGpWYsukvFNnHzCJ9hZzDKJqhO+rGBgWyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAcHCKq+6s8tSgAtZj8rlQIJloEI2t1GsIbe1GtHtVdQkqjfUv
	yUfiilH9eC6fTIEK+2iZyyT5DZtFSYY8sk7GiiDBK90p9ol7h8GSuAK38J59uakHI1Wbe/67916
	8IMCi4d1T9JWQTC8SMrspE44NzwxlL+Qz0vr8+nzlOO1ovKEORuNkPOSWLoHXlEs6rMQhl+wobL
	X9u0S3g65CNJhwZh60rNoMB4MJL7LePcsSc0LyuPp6hPU=
X-Gm-Gg: ASbGncvteoZZHc/kRooI2+Cwzs503bBURg51PklkzMb+KhX2QZEXI18xtmm5quDQdX7
	GfHroab44Va6ZenK8bY2dIEMvzsfO5kA906oGFjDCHIPuZkenz8VBpERaY1rDLMfIU6acX0r1j9
	TEyZuxH9cDOUTsOeUm3qZr99V3NWl/6I94W/QU7uW1j96mIghAz3ZZ
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-33bcf8628ebmr27742372a91.4.1761104525156;
        Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfFJjBBe9gj2JxeQntVU5I+I/K52WZIsvD7m3axHWRDtjxyFzVKU1vVPQFwjwwB3wSt/W9MIela5+BXvbcA7U=
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-33bcf8628ebmr27742351a91.4.1761104524805; Tue, 21 Oct 2025
 20:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251021040155.47707-1-jasowang@redhat.com> <20251021042820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 11:41:50 +0800
X-Gm-Features: AS18NWAAJdWZmZZaokLYDDF4FQaIYsA-DM4Fq2y-aLHj75kmJUbkmf7MCRS75P0
Message-ID: <CACGkMEtUjP2UN4s2ZRF8UGV6Bb3-6oPkU50oJ0ek8qfYwxjv1w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RbogddIHvq6oA8KGnk9NYVGN5BS7T7vRxmnRnygesZM_1761104525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> > When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> > initialize the tunnel metadata but forget to zero unused rxhash
> > fields. This may leak information to another side. Fixing this by
> > zeroing the unused hash fields.
> >
> > Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO =
tunneling")x

I just spotted this has an unnecessary trailing 'x'. Will post V2.

> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks

