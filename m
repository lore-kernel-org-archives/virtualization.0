Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408218871D
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780971; cv=none; b=pidXMoCCUKz2fujymcCDjjFeKWgYijYNxj6CUuJ17f53VK/ycHM3D5a+GkPQzIOxyCVS2d5HF+qidl4qeKZn45NVDF/kQvkaPazZ0It9rPlVF7XN2uPiExj50IYSoVSjJOkipulJXiD3Ta/ZQIGbc4WaCfdKirdfkBL8Sd2i0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780971; c=relaxed/simple;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndUEZ4lCqmnsx4G5Y68m7APXNdEEFshDLcZ9skajY/0vGbThSKqV2PkEDeOlbCX/ZzgvZ6OeN1qCM1em7sgjH0GKONTATwLzPPV7YDT5oAwj7JyeiZVejOJej1DEv/aj+L5fYIRusGrTtIez1Gr9MKrUTJ4BLe1Aec8vttrPZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2N9/dQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2N9/dQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
	b=W2N9/dQER+kFyE9hKKAfKPmjUg7IbWFYwO+7e5fyYX/OiUgaTi2foynEUofUwFm2JvfZbk
	DEVte+aeSqO6ZNsm3bBokFtSdVKicSfN3PnHbXC13BFEAhyvhBh1uRwCPDcGXWg/8iudjq
	0KHu34ScMlfmuwgC62UgrfaBDOQqwr0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-ML3iItgPN4ieU_yZPTIobw-1; Mon, 04 Nov 2024 23:29:27 -0500
X-MC-Unique: ML3iItgPN4ieU_yZPTIobw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e5af7e33aeso5181737a91.2
        for <virtualization@lists.linux.dev>; Mon, 04 Nov 2024 20:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780966; x=1731385766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAFfMzzyrbRop/8uBKQSzdTM6VeUXaTo5Y0XtX+mIeY=;
        b=WoMX6QnTbW/qKT+DvhVygw99gMz++luUUxWIQS0I4c+NYzi89OndIoryibQd17rrv7
         dUoPhjUueammprsxWYUUvjrWT/Z9FMlb+bi4hDyQpyk/deOW8Pd56N0BCW/GxC53vE79
         MWK0NLvscSPnOuFAYpGElIAKJRmRF53mv69CB0Kvp81b9TsMpycSzhWBP6nLzwYNqTAt
         3Vu/zzfNDC3tXWCTWBzyCZ/QS9sToSd/NQ4fe6588d9aJ/I4hefBlrrEPkpp7o7wT/FQ
         zj49icFBEmgThWJJn8oJSzHv16rMSrCoh9gRJ5H1d5yBgM+r0HS2msZnIBSJ9HlZULzi
         f0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU+MZa5aklIW9+7pzFNmOn975zFohLbUq0Fpw65RVSpiaHXh7sR2xWRngiePz+6VHtzbYwd1XAkDGUPU1B3bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyimX4g4T9c3C//GMBMZXuesl7FajYvYLMJvC8PMyZ6KrgMRj0Q
	IzO7iSvYIj33fuaEp8yqyhluieU+gDSvVM8Atc+8zZ0d54TPT035s6fhFOc+KfaP4HYqUS/Ppfc
	8LujNzd7zAk0SS35bGIlg2BAoan+PtFVOxi3YXsZt8bbYfgfDYwigABvwHDJdo5jGGCtUUa4Axg
	FrmEafOa4GkDOxvx0wglxBbORZx5l5giB/VLwqgF0=
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e93c1a6cddmr26138141a91.23.1730780966377;
        Mon, 04 Nov 2024 20:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlfBcjEUwY0jgicXD/Etg/7eX+icEijhUmPf3OjO6dPGL41QsO7QKLssoh6xABfMz8aXhIphYCx3Xy3KfX3CY=
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e93c1a6cddmr26138115a91.23.1730780965914; Mon, 04 Nov 2024
 20:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:29:14 +0800
Message-ID: <CACGkMEvh=tFAp2gXmtCgaTGn9ZTL2z6oiA47TNysqkro3etZgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/13] virtio_ring: remove API virtqueue_set_dma_premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, this API is useless. remove it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

