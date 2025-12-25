Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E023EA8B
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648027; cv=none; b=R4mqAXfn3iUIPC9Q54gatTwKsF1XR159VMzJLyTOdqYE5RGlL14+iEobVcbu8xvPwvzYbtoby9VgD8KksBK6i19+EEuSJJtf8DF3v3DzWGEyIbecmW/MD1bx7AuwHTWrnr3r0vaCxO3QkOIyhPlBoUt/gwJA7kfDJ19hTE+AmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648027; c=relaxed/simple;
	bh=+iyjwmBV87ktkSqNEIqB4ESqTnXUiOMV88fHerMRrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBHcNG1lQFdaFaDyTQLeQAyWzhtE3ajHzf6MJTcWs/FOwuJehEU0piHBrYCBOG/z1scFuMFAxsgKkK0gSEvQmA7/m+pU1EU6iFBjXIXklwX28u8vxiH/EszySbEJhotHbnAMrLgYkhf7emBibJZZ0gtMbrJmqW6KBFaM0Xsb1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BO+z8FEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BO+z8FEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766648023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
	b=BO+z8FECmSxoFXDkUpbMhNC9cB4gzTrRjv3LRKrr/jFWFLFhE1zdcO5xXWVWZOI9+W3bpf
	VX/JTGE+iC+fxGd2P48l9DuZj+KmgrWWBywz9swek4OfbQXTuT0ftgg4nt+D1jriVHdsfT
	9ZN8fzdEolV2fI+GTDYpOHqwOdV238c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-0fwafe_eNdeaGqWyQxVCTQ-1; Thu, 25 Dec 2025 02:33:42 -0500
X-MC-Unique: 0fwafe_eNdeaGqWyQxVCTQ-1
X-Mimecast-MFC-AGG-ID: 0fwafe_eNdeaGqWyQxVCTQ_1766648021
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c64cd48a8so14353439a91.0
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 23:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648021; x=1767252821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0m7nvOOvh/L5z00dJTlH990Zltybvr44yIpTdc8ZCI=;
        b=Q94zAhI1zMEXA2cktcwWIVJQdIIhI7IbeNKa9ENuJTDkN7xvvLzQkc3LrfeaIJZjwo
         m83x0aF2AGp++FcZWCdM4QE6aDg23rXy91zg1EGXItGEbZrk0EqnTWkeeZdEjq8C6+L+
         Ws4iDapFg3R7qZOfPlTsuPqila7m++QUvQf+rkNOl6rW2wlyLdAMz8doq8i4E72BR5Pt
         8le8lpOzpvw2Q/T6vp8q8Anf3562a0iZ8KOExiM1gFu4Nl7fuXIaXySCJPF9rRFOv7pH
         WTrdzYUe9DufmvFWfOfpgj/GU+0pdpjUTlORQoMNZI+clDsBIWZL5SDiG8nZTYR8QJN6
         it1A==
X-Forwarded-Encrypted: i=1; AJvYcCXpj+T1K1DyQqtSTS4pQwIANBLhvGm4yA+nxj/LkDw9SRgjv7sn3SAExGenZNfMxm2zGDaOmpRGnsbl/Y0B3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YweY52f2jun5fjXdSwAr7rwhR7z9JSj55szzuFw2/aqcFAwfhcv
	PiIwRRCBcZMmN+PVxOC0wgRrLNCCWFBELcp1qsj2uk4t7n95+4CT7q/L5Kco4OSNk+WHHxinWLk
	xkhhzjERJSCCKHzVu08ZoWo4T2Q5MWVEWrL/Grr7tyadw38Q1w4w7sMhKN5WDx2cDbelAvhxJ4e
	ZnEMBPPfuJq9I1DoVg1O8B0S8Ar2lEzc+d2dpYyZ9meEA=
X-Gm-Gg: AY/fxX5ylFitdBvzL+wQaNW0rQxqQqBiS7RxoS//nRVZjz3kiiislcUMSt61KSVJ8+x
	t78E5nfzXdqOuKHE9Ic9P2tbR2auSajT6JWZyl49Nlj4jSpQoU54kgI4SRwbS9mX6aETAdBBsCc
	MTNXTuuLc7wQzPvIa8RncxckjFZoyCAWznkqcppL02o45IUJnvIzCHssgf9tpCffdbiSM=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id 98e67ed59e1d1-34e921d0d76mr15800476a91.28.1766648021158;
        Wed, 24 Dec 2025 23:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcyl5vR43OkL/hDfKBDmGKAR37cMOZ8Ka1DFFBdJlFQKrUA0x40DEd0hamphs8/qa8tc2gRbIfcXUfzzGSd0U=
X-Received: by 2002:a17:90b:5804:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-34e921d0d76mr15800458a91.28.1766648020802; Wed, 24 Dec 2025
 23:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251223204555-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 15:33:29 +0800
X-Gm-Features: AQt7F2oZsDAy5UzUdBbuKS6sbUPRqmYTSaTWpVnvwoETb7rBpSLDuU-0lomm-PA
Message-ID: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: mKmCEViAsGhMHsfSYcE0OajpwEiWCrwFG1hTnUKeMmE_1766648021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> >
> > Hi Jason,
> >
> > I'm wondering why we even need this refill work. Why not simply let NAP=
I retry
> > the refill on its next run if the refill fails? That would seem much si=
mpler.
> > This refill work complicates maintenance and often introduces a lot of
> > concurrency issues and races.
> >
> > Thanks.
>
> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>
> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea=
.

Btw, I see some drivers are doing things as Xuan said. E.g
mlx5e_napi_poll() did:

busy |=3D INDIRECT_CALL_2(rq->post_wqes,
                                mlx5e_post_rx_mpwqes,
                                mlx5e_post_rx_wqes,

...

if (busy) {
         if (likely(mlx5e_channel_no_affinity_change(c))) {
                work_done =3D budget;
                goto out;
...

>
> Not saying refill work is a great hack, but that is the reason for it.
> --
> MST
>

Thanks

