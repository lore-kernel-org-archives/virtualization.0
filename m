Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5F145355
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990491; cv=pass; b=lkgNGgdyIKoDLm7ZhZPXDPsTHGYlscA26XSk8utJa7QWSJ/Z3rzvekUnsIIXqFM8jdRo/7792vDtuNUMuGkcMuoHCNw0OJYfOwlN1Q+BrQSklkUfUezDh6PSZMqQMGg3uY0vMlPwAfFsvizuiuTIc9VmdQRxv0KCmsZ1XDqzPXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990491; c=relaxed/simple;
	bh=MnAAO4w1VfmrD02ylbi+VLyroPBD+EN8jrV6PBVFQ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow0ZWQaNucBDICyj0kbI2meOu1wCS0vrtvEIG92bT+NnJWCE7wHY+/4GbBwjlj7QT6aVzndN1XTwtsyHw9EY5ZbUcjJRMQJLE+9X+8vSlMwwa3dvBW1AoQGgDBKZA5AvJRk9Qc13YcEDPqpgUgLcmgRbdxrHl5ILDEabMlABFs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIIp2Twl; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIIp2Twl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb1932b62so40431581cf.2
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990489; cv=none;
        d=google.com; s=arc-20240605;
        b=NaMhKUu1aLy2riGMAY+MibT//M/3VPo7P2TobWX3AroPRrEm+2BNSQgQQp3PwRuPv5
         ypjLSsu3oMP8cjmffpEx8WJPKx7IoVJ7h8jdqW/E908l/nzJ3FyEM9mf/SWsT6aFvbVB
         3J2PbtLUHEFiq0oR+cNGsVhd5zjiC3bEvuR82KFeKJguVEhP//XsPUdAIDkWz4hQYP9O
         n21AZJwvkGTC6GLnTOGFfGzj5iAY1vAfMBY0zOCKR/Lgtk5Bc2cxhuiQQGlNoO7uhq8g
         pjVYosJ6+u77KRkxqrCXt7fJvEESXRqzSIVLVbUypZ68bNMkOxikbVY4IWBh55d9ZzQt
         f60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        fh=y3WLd6Tnh3q4DQptPKqhljpT5QMQj6aHyGbugb7ezmg=;
        b=Xheyg0DXxtfeTvi/Wv3UCM09u67l4nr0cfnnIJAuM0tERSwPBr/UZKDgD1lVx0ILKc
         epfT5mST7kNPVAB7BGqZb5jqG6Nr7Q+bC3fSvntUT9nBdQEGbeSPz6Xpnwlt/XXH4fJu
         ZgSY10nM4dNy8h7POX0ZqdTrVivG6G15aOVkoC5Zv0zuNYlnA+51xsOLnV8VrodePxsj
         TdxmatXnGBlA3bcoVMnszp/eO2wNaDLmY0GUJy/ZijI42TX6MpzTVrujYsO3RlOvLx3n
         zoz2e2RPRTTu33POupgkdNCwLvJCVOcwlb8nLD7aQo0tb/llR5EGTZdqdcPpsU+JBXau
         auUA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777990489; x=1778595289; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=aIIp2TwlwePqAeHl+BuTgdfg7NhaAtTLMjxAt+OlUzPdK/GP5pTI7h9/+fWJwVR0P/
         1V2WyPLHl9Iy3tL16U60u62crjDDsYrp7xWBX01kiZUYQvBt8gNoM4tTjkVR+MTt+Lcy
         rNSF1HIyxSgiiB3yIkMRUC+SfhwbVFguYTh/ASfO0lBv1EzM1uf4se1As7nfpc25yo0Q
         E2u9resO/Tf7ETZCcMW1Alg/FsbUgn7V1jh+VlFkmhl0h4M9Vknv0on/nieibk5dGWd+
         paQSJTfNGLriKBzAV3A61gIJEXITWliKgqLgmutvZhrQwMT5RS4ytIj8XGR9wfPwwH0n
         DJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990489; x=1778595289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUYAYav/BIYvObp7yQw4M/QPkHnKb2/syh6Sp2vU04w=;
        b=Mle6AoC0rkZ0/F0O1EwcnR7uEoiQeLxRlg/yR1l3FYd20Zsa/PYFcU4dVfZ4h4CXsU
         6Y0MHefYbW6Gq1/kzD4wWZvsBgxaSsLRmvgy0tQtZ0LA92rqxGAAXTfSB7UunePMt9aY
         ax/Y1eH1JnfIJKAqyjFchxJxBtbejfQd3OlqCVbnHPgfnOO52kzU2SiSsdKw4dZfbFU6
         bw4RmndRdqiAdY+91HWO/zLe+WWKdHLk0rZL20LNK/4b+U/rvbyKJGsCuJa/61qzhHdJ
         /GckP3rw/aItQMfFmqNRU3ifP17vhnrN0FCLJEzzKN4lcPzHIXV/PTQ6btOEauKmPIt+
         l2sw==
X-Forwarded-Encrypted: i=1; AFNElJ8w8CUpM5VQ9vzO2bNwUcv0CFcbHJ7Pcwu+ObEYLcnxlg8SlVJcP1tnYoP91hQS4YDyqv6PORUbmOSi2cYhAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL0IwWjIUrorEieKBUIr6Lyj1aZcQLf4u0/XRTCag7QsmxuBI4
	1cxHveN7RubGF6G15CzRjdbxf8WBKY5H2Pqz7Ywnjngknzr1kWtsjWPc/Y+EU7OtCjCgVUv1EXM
	/fk6gpI4thUQggtV02+2vBDbLkwWqUeMRyIT51r4f
X-Gm-Gg: AeBDieunSpVhKelhxVxdA3dPAvQbgWViSn06Jz4POjlWo99vr2h1XFUuz4M/P0mLBwn
	l3VQW0sp3P/yyYiounsCJWCCtT+HTCJcszbw/V4qbqI556QPnYSxamwXfsQlyVft2UjT7kAo6K6
	ZPJGJAnBXPhnBIOxts5bX9q9CAx1pW34jxrXup2YNBeSRtuT4I0xSVyS5DkZd2DAmHo1+V5+I09
	aJ/6gESm0N3kH73BWeKOM/4BfmPj1C5A+TB6a/rs5hj9u68K5xo+hyGBe+RbpAlomSzz+QYKU+0
	bRUUUmPbm+2oHdcgyNP2z9uOEBvCmyg1a1MRZ91vXGmcObkmldqBNvQUGJZmNf0Sx4u3uzVYjAV
	Y+4YYs7qohtn5EQwJctZ/3sdeU1Iy1TumITc7D7Ns/BCuukHH6g==
X-Received: by 2002:a05:622a:2304:b0:50e:5cc3:6f42 with SMTP id
 d75a77b69052e-5104c033490mr204851261cf.59.1777990488136; Tue, 05 May 2026
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
In-Reply-To: <afn0ZdvZWswBuDMm@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 May 2026 07:14:36 -0700
X-Gm-Features: AVHnY4LCs_m-4d1LFjbzwKLOUUlRczsxD4uzf7jMKren00MMyTffvChvT5hoQlU
Message-ID: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_allo=
c.
> >
> >virtio_transport_recv_enqueue() skips coalescing for packets
> >with VIRTIO_VSOCK_SEQ_EOM.
> >
> >If fed with packets with len =3D=3D 0 and VIRTIO_VSOCK_SEQ_EOM,
> >a very large number of packets can be queued
> >because vvs->rx_bytes stays at 0.
> >
> >Fix this by estimating the skb metadata size:
> >
> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> >
> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account cr=
edit")
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >Cc: Stefano Garzarella <sgarzare@redhat.com>
> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >Cc: Jason Wang <jasowang@redhat.com>
> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> >Cc: kvm@vger.kernel.org
> >Cc: virtualization@lists.linux.dev
> >---
> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae18463=
5fbba4dfee58bd64 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> > {
> >-      if (vvs->buf_used + len > vvs->buf_alloc)
> >+      u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TR=
UESIZE(0);
> >+
> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> >               return false;
>
> I'm not sure about this fix, I mean that maybe this is incomplete.
> In virtio-vsock, there is a credit mechanism between the two peers:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.ht=
ml#x1-4850003
>
> This takes only the payload into account, so it=E2=80=99s true that this =
problem
> exists; however, perhaps we should also inform the other peer of a lower
> credit balance, otherwise the other peer will believe it has much more
> credit than it actually does, send a large payload, and then the packet
> will be discarded and the data lost (there are no retransmissions,
> etc.).

I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
state to account credit")
and find a better fix then?

There is always a discrepancy between skb->len and skb->truesize.
You will not be able to announce a 1MB window, and accept one milliion
skb of 1-byte each.

This kind of contract is broken.
