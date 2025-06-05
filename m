Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206B18C06
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749084399; cv=none; b=o18IYo6JOOg6SKLosyvLg/f72gh8UvlazTjPC84Qx7oArGzxC8xcF4wfXk7X0Dygm1hqynNAlGKyktbvYUtUcc5yPPjRAOzgam+wzregBbNZnogHLzjysnAmvYBaHxlokrt62ROp93KI+d1vdUP0S4jCd7ob7ca6QFNUiw5rTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749084399; c=relaxed/simple;
	bh=gQ2K28JFSJwrXcviJxZJUo1aNRaVu0m2YAcpDoDihjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTngS2nNxS91VwZw9khKAd7TGWCQXLa7ZQ8klpvLLXfVv1FNhTWAfCNYh7zx8Ejqrl6mgsn2B7dUOLSyj44vZ5lifA/Og1dkoBhhKdwWQUIC3dM5BUGvvSp9MI/O6B1TNnwgTcDBneh9di9wN214VtnpnRZCPiECEsK9S9TLewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhsJaU9/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhsJaU9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749084396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rvoJRZ+941RRB3yT2eqwz3H2iab1etLIqCrT/3n0JQ=;
	b=GhsJaU9/rE/SoJoBJJl9Eb2skRBQm2WkBGZmWRmOwQ9uUKytkuNeUQOfiSJQYUrVaRPGE7
	a5Et05D+W/iaJfuJ29Lin3L7ExD4M4nvBb+6PLQyUbjsYfqET4wMhAUtHq3nNX7j0CnmbV
	/r2vQFxQXDmIrKgj5zes25FkIhKCcnY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-We0Yof3xOaCbR5jSURcKAQ-1; Wed, 04 Jun 2025 20:46:30 -0400
X-MC-Unique: We0Yof3xOaCbR5jSURcKAQ-1
X-Mimecast-MFC-AGG-ID: We0Yof3xOaCbR5jSURcKAQ_1749084388
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742b6705a52so654512b3a.1
        for <virtualization@lists.linux.dev>; Wed, 04 Jun 2025 17:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749084387; x=1749689187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rvoJRZ+941RRB3yT2eqwz3H2iab1etLIqCrT/3n0JQ=;
        b=OVdWdpkGxdcjFL0U60c3y9iGXyguasPVF9i21SIb6A1eE2/oEexyEzBZH76jJFm5B0
         hFTgHlt18IQViD0HZmHuf14vF5BNUrEF+RBoMKw8SfTgEB4Hnyi7mtPllCR5Tmd0zzjI
         M56mlvO/rE1Vy9SjN33OQ4hKGTj9o1PUBhgjOjD6Vu/HOGeHWLzDHRk54CV9gvW0DGrI
         fwhg1PONRXQPyJ/N/wO4qXXMmstzdkWfVxuDUIm6jxCk8PegRIj58RPdiztC40Xu+yz+
         9lnd2eXuG3LHdPDEhG4by8rpUwsa6RIWbQXIUkK9OmOmdZwKH/OgLGrpV4MfZ2sgDsK2
         0I1A==
X-Forwarded-Encrypted: i=1; AJvYcCV78dhE65LudZSgo6fzhoGz34cxnbzqOI3CFEbw5QWvpSl/t8+hrCq14f3c+co5SHYk6H1xEVNdpYNdwcIcGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw9qNr6rvhibTC8CVBed5Q/J5ST9UiZON17ljGg2FUrIZ6+kw2
	x93R61+IEOvO7zRiwOOrB5W6NWHJgSSHwKX+BHrjKfWA9hhqZie1k9Mh1zExQdniT/zghDn0iF8
	rVq89I4FUf0YZBkbzWYEwKW3nqZE5ecbVZ38IGyjK4LXD49aK2WxuFKAHJWEyP4yFNQJ2ot9+Bc
	rfACfc5DuxngXsGRX3PTB/xWYvCj8J63dVQnsVgvkIAhc=
X-Gm-Gg: ASbGnctw1QtdQiqP6hflusg/Hqsg13Si8jrngCc0ZhEfhIkaW7Li9V1zeV0vPHgLFv1
	cuRLoymL0SbP+iiZrR8PSpQosVzIIIRsDswjee3fraF6BF6M3WENQaZg00LZsmXXHVS53
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-7480b41c057mr6620869b3a.13.1749084387546;
        Wed, 04 Jun 2025 17:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWm/kjbk8cd6j93CgnJ1yt93I+3ZM/WhLMOUv1rkUy4RSWdCL17+h6rPArAx08BKWo82wHYZSyXb0/Dn2zN4A=
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id
 d2e1a72fcca58-7480b41c057mr6620834b3a.13.1749084387116; Wed, 04 Jun 2025
 17:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com> <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
In-Reply-To: <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 08:46:16 +0800
X-Gm-Features: AX0GCFvjyMd1H9dniamKbUvfa3PlpuL7i79qr8xhrVJzz6-ckoHw99myc9wjf_U
Message-ID: <CACGkMEvnn52XaidBdD9yGy8Yfpw3vu+QLcd8JoBSNS5ZEtmMqw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7qLq21KTvvQaZM8w9qjZlAjo4CMHuW2xHf8zfQVeclk_1749084388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:17=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 6/4/25 07:37, Jason Wang wrote:
> > On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> In virtio-net, we have not yet supported multi-buffer XDP packet in
> >> zerocopy mode when there is a binding XDP program. However, in that
> >> case, when receiving multi-buffer XDP packet, we skip the XDP program
> >> and return XDP_PASS. As a result, the packet is passed to normal netwo=
rk
> >> stack which is an incorrect behavior. This commit instead returns
> >> XDP_DROP in that case.
> >>
> >> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 11 ++++++++---
> >>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..4c35324d6e5b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merg=
e(struct net_device *dev, struct
> >>          ret =3D XDP_PASS;
> > It would be simpler to just assign XDP_DROP here?
> >
> > Or if you wish to stick to the way, we can simply remove this assignmen=
t.
>
> This XDP_PASS is returned for the case when there is no XDP program
> binding (!prog).

You're right.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> >
> >>          rcu_read_lock();
> >>          prog =3D rcu_dereference(rq->xdp_prog);
> >> -       /* TODO: support multi buffer. */
> >> -       if (prog && num_buf =3D=3D 1)
> >> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, =
stats);
> >> +       if (prog) {
> >> +               /* TODO: support multi buffer. */
> >> +               if (num_buf =3D=3D 1)
> >> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xd=
p_xmit,
> >> +                                                 stats);
> >> +               else
> >> +                       ret =3D XDP_DROP;
> >> +       }
> >>          rcu_read_unlock();
> >>
> >>          switch (ret) {
> >> --
> >> 2.43.0
> >>
> > Thanks
> >
>
>
> Thanks,
> Quang Minh.
>
>

