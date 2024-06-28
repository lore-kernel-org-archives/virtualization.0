Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC218046
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541206; cv=none; b=FutEpHtdd68o0lOfhbscBNkdKYBzrTE/lOpL5HwKhF/yk8uNNpn8r6ZwRBHiCx5dhb0xEIZyQgZ7OUjOIRZC97ATZHkyyipYE2AXyzeVrM9ycag97okjQSAdQcgcJTOW6CZOj5zHvgIgYDPdisrqHUeW0cBNMO2mMRq5j7EXPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541206; c=relaxed/simple;
	bh=IyvcZwLvMH1LDIrvjEGIG+jYOCuuqUJNM1j/g07hCaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+qD6f+oCNqPPpMbPZgaSzg3X9kuD8109jFFUAtKNNAtcJPHHXq7ZhtsyBvsx0ZqHn5kONBiEW/WAbb/y/0QvhFtVh3WHW9OBMzuRZb5PbPBqqMjklA/plwB4HYVIGMGS3CiR413cl1El9lG5h07UPOEukBk5UhcpYLAb61DhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuIeJV96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuIeJV96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z2hr7qByC2mTYMhLQUML7Ce0IuOwnECsuHmZqQa5HI=;
	b=VuIeJV96KiIjFWHJeH86llVoKTPetwUmntKoOAIFLq2CNWTvUapAqP55FEIgj82G+bqv85
	RGDO1V385KiXmI8XNFCRob5asfAgutIyFePveK7yBVWlfBoMOiOiJ78f/8kRaziilUmkcF
	DrMDcHOtNIldbu5tGg+ouJMeRKc4c0I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-BGfaLo0HMx2YifwhOt9s-Q-1; Thu, 27 Jun 2024 22:20:00 -0400
X-MC-Unique: BGfaLo0HMx2YifwhOt9s-Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c716d15884so200815a91.0
        for <virtualization@lists.linux.dev>; Thu, 27 Jun 2024 19:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541199; x=1720145999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z2hr7qByC2mTYMhLQUML7Ce0IuOwnECsuHmZqQa5HI=;
        b=sQrl+wPzn3QuZXI8JsXFfKS4GrO5s0k2ejAIJqOYsUR0AnT6dDJWJpS2GFVfV5z2D9
         m7g9qftdSmyplTKAvNeS5hE0C3x5QuOr59t7RddY7sdDBw7gE1lt6zsSG2Aq6vgK2F9n
         jeXIFphN6Qsj51I/Ckqt8LqHWGhqR0dOy5l7R6tcY4k2mrh6Je5maJGqOYwi6hYrwTia
         eaSl5Q3skCz5Y6JpfP0u13drW3ABCshLVUtnE06N1SgLvCWJsOlr4XpYo623/TCIsg55
         KIL+60j+4d1Tq4E7BTffdcL+puSHgzhpD++hazDq19vX0zAVoh4YK36MMlXwMII9Dbss
         qttQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzknowuvuSUBKSI3B/gHNY2kKifospA6qPqs2lLVQmETgVTFqtusi+0sQoPxh6b9PRhzlzfQCIRJDL5kbd613gGHOIZ9Yuipetxw/sKHQ=
X-Gm-Message-State: AOJu0YwpXKLoi+lZxEFqUN1EGacyz2Zb1qPCmT9sPi4LymJioT3vSZCm
	ZvdvYIk6d9ylN9Kx8xSA+9cFYgvvjTNVIEbmt/xtE69zre2NRPk7F/Fx5kGAnKmJyRlS4SUfh29
	uMC+mvqmIt+NDngGhMFrM6hWaONTSAPVK3Nzg9sVAQA0GI+smhS6j7dQSjuAU027iydi8ZUF1iA
	ZPNW9LLl2Ar/zyHwKeAhAZ+4kqkIBiEYvwsG5wFX8=
X-Received: by 2002:a17:90a:7c4e:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2c90b728a9bmr2003091a91.28.1719541199552;
        Thu, 27 Jun 2024 19:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5/zEyjOCLMk6F/yC+JpyRh5E74hlN6uELe5uVDpgwKaegpyWDK0mLVAiiXRu5uGm1nnyYoqu9TewCz5jroHY=
X-Received: by 2002:a17:90a:7c4e:b0:2c9:b72:7a1f with SMTP id
 98e67ed59e1d1-2c90b728a9bmr2003072a91.28.1719541199123; Thu, 27 Jun 2024
 19:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:47 +0800
Message-ID: <CACGkMEv619mv1mMWEU4W5vh+=TFMfHGj9r=mBZmm81VRxc8UcA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Release the xsk buffer, when the queue is releasing or the queue is
> resizing.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cfa106aa8039..33695b86bd99 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtque=
ue *vq, void *buf)
>
>         rq =3D &vi->rq[i];
>
> +       if (rq->xsk.pool) {
> +               xsk_buff_free((struct xdp_buff *)buf);
> +               return;
> +       }

It seems it needs to be squashed into previous patches?

Thanks


> +
>         if (!vi->big_packets || vi->mergeable_rx_bufs)
>                 virtnet_rq_unmap(rq, buf, 0);
>
> --
> 2.32.0.3.g01195cf9f
>

