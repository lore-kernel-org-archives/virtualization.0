Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86328F4
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583094; cv=none; b=AOFYOMpOwT3YbOpkoV5ReZ4LM96HQKKG2XvVAQguGjp0CRI+uGpAiQ/dhhyROEvAgqFuqStf+tHsUzfLlME/OMcih7NuXrEqXDfa12Uk4bda/3G/sB+kBNYCPgBxsPO7PbX92aXz3gJcgh2wMyU181IIvHhy2yw1BvaO6MMAnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583094; c=relaxed/simple;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwvMDo2KpBpnSqYbxhF2BhEhUqg5b1sf7aj72SCJavWESeTRmDpwwQOOaI7M3U4T+puKgc2zVlIPeCgmbdu6lDpiBBSKB5MnsyEAifRBor/kmkO8qkGlsf/8mY7jOEEJxTifgfeJX1yDLlQ8XlRapwnZQ2Ao/26rIvz98KNfC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+GWs0Jk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+GWs0Jk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720583091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
	b=Q+GWs0JkqDYVK1wuRZ9ybCdu1LJ/Jiyjb5qPKGN38X00p//93iP4hVYbMck+kIoG19XD6m
	GTflD9tSTiCZmIc3dXCS/d+ouMJVXmUEpJDdVFTOD23i3pLCAOf7IrajWpdgTLn6DD3UAn
	s2r6P1e/hC2Hp48+tC5xOlC8Qmy4dK8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-jYowS6kQMFiqnpdqBu4xFw-1; Tue, 09 Jul 2024 23:44:50 -0400
X-MC-Unique: jYowS6kQMFiqnpdqBu4xFw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70af57e0df0so3668351b3a.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 20:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583089; x=1721187889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i62hVybCBvOjhHF8NST7W42rhOG39vIkacaC6aT/xoA=;
        b=I9Qkjq6z/E9/RcbZbClXRzA/FkmBkKeztKXjjYkcSKdUqIjI8iLbOnbSWM0qTXr62d
         kI5BFNbgRVroslNF5c9BeQjcBrCz6xcEs++koiBuZeqRnGRgq8EgQqGaol9GSGcvaRV6
         2srWtO7FMl8sIolBNT7RQGVZA1PQmGFzLG0IL6rzaTamEsZkJ3UbTWCGgSEk6wF7KNV7
         cUgQ7fgd2Q0iKBXUMom2C6F8GdH1Ea14pEUACfc5G/SQbRsHpvcxwohnsWKuuNs2aC+d
         nv4dq31xTRR0pBTp3viKLdOo6f5jP1ZSy8w0OE5DGpGbhDBza6GMSZY1+7uchW7pnDKB
         0BZg==
X-Forwarded-Encrypted: i=1; AJvYcCXpnFobvk/Tjma/sb2/Obd9B5NPoQw4153YuldAHIyf/oFLsatE0Nzgx/RDSPygM+AwTfeYi5mPp4g7rMjGax+vVhv4G22eQ2FEdSD5K9k=
X-Gm-Message-State: AOJu0YwE7Du0dMtWq5bXpXuphujptSPpv0WuZEOBoLra2GMbTSDkWuZp
	v6F34OBSaI4LPFVE1zenvRX9CmLsaRJWa9oMav2e2nF6d+8PmHw9kFj7bEiPk1mTv9+OwqsbN+z
	QXA2y4M150+8M4+QjhiegpbfQyyLQu4UglUNqYuIFG0FEx/MwEy44iSrl/PZO1Erw1YuY5AsDSt
	VSLkmiujtioImwKFU0W+hPLsKU77TW7GuAEPLXpYE=
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id d2e1a72fcca58-70b4363223cmr5525289b3a.34.1720583089385;
        Tue, 09 Jul 2024 20:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6DK5RquFuxm9UxpTrrMYhpGVKkxyGGgB00e7KDYNJvf+PSSaHyWY1Zlws4I2c/WC4UdEyl5u0hefWLqdOSq4=
X-Received: by 2002:a05:6a00:1304:b0:70b:141d:4a9a with SMTP id
 d2e1a72fcca58-70b4363223cmr5525274b3a.34.1720583088933; Tue, 09 Jul 2024
 20:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com> <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240708112537.96291-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:44:37 +0800
Message-ID: <CACGkMEtfd7ndOZt4M3j7yNUVYtnu-c9n02He59Cq+1_ML9bEDw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/10] virtio_net: xsk: rx: support fill with
 xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

