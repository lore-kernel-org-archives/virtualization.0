Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F932AD2C
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766712705; cv=none; b=NO23fFb6yJyiBcjAFe4tArl9Iq+uL+rqT7nvA12Xx/RXkWksfPZN0r8ctTS/nSb9wuJwbrn/DhYiaKKVtCC2fDv/pKuJSi/yeNpfnwWgL8RWh/AADsCs88lQLCZvf2/1DeVNrTBO5F1wBofIYZj2/q/CNQYd6pdsmZK8PXXqMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766712705; c=relaxed/simple;
	bh=EEJ0crxTC9rZ7Z/JWyJ1blAZ+MavApQb1iFxiRM/QeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkfSbHSmktX93WUemqgx+55UMHRBbHpvUz++gpQUrOp0dtFKd/NpPH8G3BVj6AGf2XdEpHQU+GtPVBiTo/6hPTWvVtIDGwgkVjg+N/Z0kBZScb/qyYFMFBC1Mpj7820o5l1Wd6Xu1YLgcj4O8dFl2Oa+fjmfTXpjQyq3pN2RWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yni7qfB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yni7qfB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766712701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
	b=Yni7qfB7m9OA3MXAhQYUDHf1O0/ax45Bd0cmOZpqoqrFYQbUIoV6l89HcPjwldAjU2qO4u
	Rf4qIiCb/nBa7QxEqBdz07AVdfyLBMtjKKK/Fi2jbBom5HqmvvZR40i1ndsb7vJS3QGdSq
	v2uE11ZBH3vyQ7mathg9Z86ZiNvdMWg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-3M957bbSMBy1m6IXuqDOgg-1; Thu, 25 Dec 2025 20:31:39 -0500
X-MC-Unique: 3M957bbSMBy1m6IXuqDOgg-1
X-Mimecast-MFC-AGG-ID: 3M957bbSMBy1m6IXuqDOgg_1766712698
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so14647668a91.3
        for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 17:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766712698; x=1767317498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
        b=n4YjxdPl6/WKNSvSMnAh+0/ND+RJipZ7gsyToRAzIqQqOLyUg5m0ovxBViBNzROt5y
         afrXdWKlJn++yFr+qOCbBNaGiF8Q44ZVAc2x+tFF7ChA/TRXpO4rcIgslTvxw7yig5NG
         w5uFPqW8HSAqImlM7ZtUMnXBOcJLosuqZC6GQR8eI6+Ph5cHVhXuIfeTwvP1/dsyS0XE
         ff4SMvbHNN8xRCX0ZAHUfWBiU/E1i+CNf7PdHrZUMW744lgDlR6dK93cNdMUeN/biZ9S
         NWPeMmzkPOae49gqxrkR5fwRrrKwiKCtAW7Hhy9i1yqUIXufKsWM200UGLnYYt+pjUQ/
         VjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwHrfjlRT+Qg8fmIlQ9NJQ4moN6ApuStGJMZQTeAFbPUO1RrPlsOU8XhU54Knj+Nzfjqo10RcB0DRS/aI0iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaYiRYkVp3rqeazzRdQoutDcQBtm3fM4DvZ8d4IQ8Ms+fmHF2J
	aTx0CfC4fQLhOS4vTTCpYlONrkzIlihHGP0o+EBrExyhv6nwsBmvNKjmwy7ooOp6z3bOn5tovQ/
	RW3K3dJL0z/Z94s/qrcDUpvYtkH93bTNj9oB62V4cXhY/ei3iDPaI06xHCy8l54gH3OL//tautI
	t0iGzf6eNrJceg+z6LeqZORRmb0dHOgd2eRyBNq7BChQw=
X-Gm-Gg: AY/fxX5UXBppZFHcLWEZv+1o5sDToyUjbHrRxo+h1b3zVzmW/M7iO4olCRL649VIUcI
	neLkzXRxrMG4JlV4agxkLngYhHPZOQRFWTLvU9nYcus+zy1R3ZPlRBd13izEMGaBhg+UCZImZ/l
	bnLSKgR/hHVf4BJN5wSLrjkfxDgECDnCQKbt1k8kQ4LkgSfScOnz7YlQsOQMcdZeEnX5Ss
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34e921448b2mr19061585a91.12.1766712698336;
        Thu, 25 Dec 2025 17:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDLUNXaA4vnS159ahikBffjf95vdU5q9+k7UAJ9SZruAaAPrDNmu7aJdwlO54UokDbplRgWPYJOEMbtGxl40=
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-34e921448b2mr19061568a91.12.1766712697950; Thu, 25 Dec 2025
 17:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com> <20251225112729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251225112729-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 09:31:26 +0800
X-Gm-Features: AQt7F2qcDC83KcLofPp3_PLoz1EWH_p2ikDpQkczGnwan7bSlzvlAkicGkB6Jgs
Message-ID: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bui Quang Minh <minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cs4SN5d8taPm8ElRURkImMHkoHToiQEAYALAM3s-g6M_1766712698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > I'm wondering why we even need this refill work. Why not simply let=
 NAPI retry
> > > > the refill on its next run if the refill fails? That would seem muc=
h simpler.
> > > > This refill work complicates maintenance and often introduces a lot=
 of
> > > > concurrency issues and races.
> > > >
> > > > Thanks.
> > >
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > >
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great =
idea.
> >
> > Btw, I see some drivers are doing things as Xuan said. E.g
> > mlx5e_napi_poll() did:
> >
> > busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> >                                 mlx5e_post_rx_mpwqes,
> >                                 mlx5e_post_rx_wqes,
> >
> > ...
> >
> > if (busy) {
> >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> >                 work_done =3D budget;
> >                 goto out;
> > ...
>
>
> is busy a GFP_ATOMIC allocation failure?

Yes, and I think the logic here is to fallback to ksoftirqd if the
allocation fails too much.

Thanks

>
> > >
> > > Not saying refill work is a great hack, but that is the reason for it=
.
> > > --
> > > MST
> > >
> >
> > Thanks
>

