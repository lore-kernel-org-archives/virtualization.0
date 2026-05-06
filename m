Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409D494A01
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081937; cv=pass; b=dU+fo8jq3K8p4hRRDh9huF8Qk4S6DRBwfet2wSOQIQ7KioMjhEqiCWB6vP9MLX8D6+Vm54S28F6ppqbT6+PYxEbKyTWOzZ9YbY5jubo9NvJbYOC6qFPkt13ZLK8XmmDOoyrd1mR0JUiGCJfsW1544/FfS3pUjfjN1nDmekFr6xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081937; c=relaxed/simple;
	bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK2rEV0YCv68VuYb/BvAjp2IW86acqRLjvUFV+qIzTfFeFiCeMNeYgznMtUb1/6ijSUlvva0peJia63sNUcmf/jvcO7Pb89o19pO3Qlw6cYOeNP57kxOFBebIR1rYi211furWxMbG8A8agEj2jRdpAm7UpA3eugeZkDkt0BH46c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfDbSrFv; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfDbSrFv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb18c55beso65220331cf.2
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 08:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778081933; cv=none;
        d=google.com; s=arc-20240605;
        b=K/rrSbPRgMh7Uq5BhfHCGf0ng4/I/Tc5fulmGhbtSx9Nr1Rfk6qHhEP0LU02OO1h04
         Mluxtr5Ci2BulwhVHE7AXkYv4xp75BuYiakXo02SDclSICpURwJcGxkghEEChOEPSDcJ
         NnzEylTclmfaAucT4DTEtCihIzxAZPDrL4fA/WhPikwM6ARInNJBeVTf7MOF/GppP+X5
         5zmwCWF60jySNUNRajL6Wmqr9wVGfp2fZnaCBoUxMhtknXubEPH+F2YDxhr7pnzpmq1H
         nmswWQTNusKrronOlMAlZyqgcEmfVd6HEGYGqBPfikYFMHKkTJXnL/rJZ6TroTUCq0ep
         MeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        fh=kDoZOp3mTeF7bpQOlqvpPKP5edhCdqnTiBKtZK9l/Fo=;
        b=XJtRyv3OutNj1/lL9jwqF8lpw3/f1tgU34udqcatDza3dNAS7CR6shPJPL1LU6yjGr
         ekKNAA0cPkInwO5ueikyZ4uAGLJ7dD8IUgUY0SH4CYJviQDA803ClTQcP3CWkqS7zIOd
         YZRdf0iWKixNHUyxr4SnKbMtPTINsO1iU9yHtSp/YzD3goCmlPRK/uBfIhsCcf43xLxm
         xY9apRuf0jLXZU7gM1xrAPmfSZPVnq+3+L9cVteYHcgCQQThzVQBUz8kXOgv/nVc0x+R
         l8p+PXCzidp3oEMEgRRrR3uLbQIuD1A9TrHcQo8lEkmKaLFwKbCkDBWS6RyhhMeQZGhA
         BaXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778081933; x=1778686733; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=BfDbSrFvFQQ3T/c9OuZWKyU5FmQc1OPBAU3oPH/SXVlqZWGwErQSvDrVfnA5c7YO1e
         px3oo5xMMLiKHhOOc8fM++83zdhPoECBSQPfQiEcrYiNUgNJy7xS43CT8aoRG3l1M4/E
         ytD7olmG5alVznjHQifpd8ebS+O8tvJTbm2eI/1oqECQfhwGpAQyGUMzd5annkb7qDqZ
         VYqlWBQnVe/NcAQtydwBEOLXHD8d7LBbD1ICEj7tRl8knk5n/INwfMgjVAHbfQtqFuZV
         NyCLoraZtWsFCLBllxuCfBR0c2rY5uMY6z/YtbRyR+krTd0i7Fqzt0/GZGi3+Hni5sWS
         1wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081933; x=1778686733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dj8Od94gXs2mTNR9n3Oo5435WG5jBWGZOlSkFoLcNBM=;
        b=U44ZFSI6U9TNZlzh+OeG3Xd0CX6K0JkBijf76wt3N/czgY9lvSZl01wUJRvGkdOYrJ
         dVK0qoTZzbiIzrtPoR8HPal0mVV0qRXcFXnTOCmJiIvuSqKeB8XPD2lQ/Aba0ORVQhMq
         91RBNF+ig6WDy2dCQZteeQNusO3dvM8g1huGL8jaovu5srskWVUprssjRmzq0UTjydFF
         paPPOXvyxmZV2BJxxRtUT+JsfhqmlplLcanXzVX0XnDhJQS/dXiR5zUpHQf5Tvbi2G2T
         Yr/jEvA+VXBw4kI+/OBwBUSRhjNlCJi3sOJiYAZ3izCWNNQgbrsQczrUwbwslClssEpZ
         IOCg==
X-Forwarded-Encrypted: i=1; AFNElJ9kHofo39EVZpRNp48QeATgis8jKSOj/za5d7bQYX/pDmShm0kJuhnUVx4G6J5EjYRaNGxza8lzhaC523LQwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/Blc3lXiM0uhcrAv5wnTdEkDwrNH4iZo+0paehVzucragoqQn
	nMtzEVSA5fLiovPiZ5zWGQwXxC+LMP9LYaGyOZdmgHxYBWu8tRcs5ShGaE3kyu+LpESUwiLmNWV
	zWvi1vO87a7OEe7SLikJk8h76KgwkqUD/OCS6S5Ka
X-Gm-Gg: AeBDieuXsydHBRPrh6RvRHTccOV0dUOeUVV6oB/MyIEkAmcNjGLYScfWo9vQfSsNGeY
	nz9+GUKtoh8i6nPIjnqAm8ZK3Y4zIkpxshenJdVkiseXu50ksXyDPoIJSZgvg2yyNm8Q+qzWepl
	dHO+uHoc/e8OlvLIIF3x3rfet6737EVJ3oywQqOu779R9SRcSv233HyApNut5Xok/Jd+/gpgDcn
	9npm7ubwxxO3adg0E+j3WieCRjRqaDphL/gnQwCR7SQuvC/RQ5ZtQVl6+hzKs6ZGezKVYI8fiI2
	sTIaKW9YHTkmgKkYu/X2acZJ76+3knt+UJBDkEVOocFvjk99nwFgR6TjDj+4JJDzHnuMCqnnZ0K
	kh4gTrKLSYKpJgdWuzHoC1zOu/vwWCHLzOlr/qXE=
X-Received: by 2002:a05:622a:48c:b0:50d:e298:8f1c with SMTP id
 d75a77b69052e-51461fce4d5mr53275791cf.32.1778081930259; Wed, 06 May 2026
 08:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com> <20260506111507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260506111507-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 08:38:39 -0700
X-Gm-Features: AVHnY4JGcss5DSvVQJ4HSN2zeUaBN69s0ioWUQVWnh7DFq6P70Z49QIoeMVTrAA
Message-ID: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 8:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
>
> We can if we copy.

You mean, ignore VIRTIO_VSOCK_SEQ_EOM?
