Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A842690D1
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977046; cv=none; b=lJFhDIOQ5Gw+tJ/aV22WWWNXe+pG/ELspTtrdluTi1FqjpJeVHTNCQaZk1gyZPBMbgTyqsIHnxy1U3fIN92xYrCtQPrAwWSypStfTrhpZmvPyE9Io3xsn9kVaFOrOF5XaH4XRGElzrXnOMES2jpasMtkdO295CWo5fLV65PZnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977046; c=relaxed/simple;
	bh=q8CggmDtPqjoKatzN9cmV7rMGBsJUMVlA1VHmEyJLpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCMebJDeKPW0zdIhsa97ULg6n5hhClQ/l/AgBiW9tSZKWxKo6HNsHTOUYaDVyXZ5ujquG6cRsgZlnrj1d18tHk7JX/hpEzRicPsWRjTevJ/y/1z33TX94pyWlgtu/nGiz9fgVwsvTSac0SmGNcBtJoLHg2zsbsxga81/TSBqK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNu0TqGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNu0TqGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766977043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeUpiAunVEWdA7rpWmyfKsCIf9QyNTsBMy3xWSGdlCE=;
	b=QNu0TqGdGFae6egsXEzsRA7Z840B1PhLy2NyQ4ZqWynNrV6iy5ZJb1WO8pTlUH324uaHFX
	7WRe8Wtwf2oF2C7/mfKP+47hlNkEr7FyQxYPsCMEyDAr3DZuxp2Z739nsdW2PkuTS1L9VS
	a2OIS7dJ/su94Su/FuFRp47Ey97SU7A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-RT8vR5RXOI-zVFq1JWP18w-1; Sun, 28 Dec 2025 21:57:22 -0500
X-MC-Unique: RT8vR5RXOI-zVFq1JWP18w-1
X-Mimecast-MFC-AGG-ID: RT8vR5RXOI-zVFq1JWP18w_1766977041
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c213419f5so8230885a91.2
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 18:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766977041; x=1767581841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SeUpiAunVEWdA7rpWmyfKsCIf9QyNTsBMy3xWSGdlCE=;
        b=iAw+axRXZxvz8OHVRsg7MdRekP4TggYGkYCsOSPaQ4oIebJQQia9LMlzs16MAicgGE
         ToyXbltYjFunAhOA7NlJfUr/vfzdohweA3/JAWZmeTrjojter49MWtZ2FHXvWAuG5itU
         lEBnkHEXl7jSDdU8xWsEQNVICPgQcVEyCRU7y10ZLRJWknuTCuzLuwKRWiL2e+QJEYjV
         d5oRfMMCXYZonDoNmIEqWv7wLdahBZKSIzfTQ/A8APMSPuZKcMg+N5yesNfoAGSViVOr
         CyIyNxO3zjoLhVZNlIAtx58qtSOc8qWx84Exl6+IAqgKnrT0zE1tq/fPARLhKKBZ39nw
         ilBg==
X-Forwarded-Encrypted: i=1; AJvYcCVCzB/BlMikUA1ZgxOdZGEkEV9vOvaX8+keAQLKH2m7BvXF9qzLeNRUAAfiZy7wSETv6VsUUvi5KKnPWau0cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQK0ODIUX34V1VZqCptZRZEelz7kcIU5DumfuNo3EFxRQYvovZ
	CTgTt08jSxbTDzYUWVugo8vwuITgbSr2suc0x+pfHENNZ1Bg6L2JK70w+K9aBpTPBWTAbyMH1Wz
	b3MZDLzhC6MQSlvvwpsPDQLHg8Q229gRHj2J0ee1jMaNmMQPy9ldeOSk/DEJ7mjLqMzxhpea0he
	vpuXwyv6EPrNjxPXIu38yVxtSNj3XlmomzxgYwm+zp9TU=
X-Gm-Gg: AY/fxX57W/wPkwU2divbBje3WlPovOXYqYmR0b0k+Ed8HC8ftRS4h5F2DTFnO4a1uNQ
	Mh8ummFvuOdhIGZkTr5D6ih1dWz/lt9uoPpwGMi0ZZofB7YJnns2m18vf0E+I9tke/nM/5Wl1IY
	ACTUhK7ox+k70h0PUwiETMg/GrrfQFO4vXc7XHMesD+z94uMj7kHxsq5PiLjhepXt2b/E=
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-34e921af98amr26506158a91.20.1766977041130;
        Sun, 28 Dec 2025 18:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuFAQz5dl9OQ+OpMMXHah5Q6sBaKFfxj69JA6+1zJKrKUTujcPZF1v21aCgnbYDU1uoDCbceCpOFXb6k6AIFc=
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-34e921af98amr26506133a91.20.1766977040697; Sun, 28 Dec 2025
 18:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org> <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251226022727-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 10:57:09 +0800
X-Gm-Features: AQt7F2pWXGO_bQQYrt8LO7PYTQ5B-41fYUS9oX18KEq5NxP7LasitQAJREo0FmA
Message-ID: <CACGkMEuTfKQCHqJFgtG1-HBn--fdGSKdPqF_=p078WbiGN=J=w@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: VSRFlQCxcWeKGCkfbQpmPGJq1JhROSZZq1aTHXc3SE4_1766977041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 3:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> > On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > > On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > > >
> > > > > > Hi Jason,
> > > > > >
> > > > > > I'm wondering why we even need this refill work. Why not simply=
 let NAPI retry
> > > > > > the refill on its next run if the refill fails? That would seem=
 much simpler.
> > > > > > This refill work complicates maintenance and often introduces a=
 lot of
> > > > > > concurrency issues and races.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > > >
> > > > > And if GFP_ATOMIC failed, aggressively retrying might not be a gr=
eat idea.
> > > >
> > > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > > mlx5e_napi_poll() did:
> > > >
> > > > busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> > > >                                 mlx5e_post_rx_mpwqes,
> > > >                                 mlx5e_post_rx_wqes,
> > > >
> > > > ...
> > > >
> > > > if (busy) {
> > > >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> > > >                 work_done =3D budget;
> > > >                 goto out;
> > > > ...
> > >
> > >
> > > is busy a GFP_ATOMIC allocation failure?
> >
> > Yes, and I think the logic here is to fallback to ksoftirqd if the
> > allocation fails too much.
> >
> > Thanks
>
>
> True. I just don't know if this works better or worse than the
> current design, but it is certainly simpler and we never actually
> worried about the performance of the current one.
>
>
> So you know, let's roll with this approach.
>
> I do however ask that some testing is done on the patch forcing these OOM
> situations just to see if we are missing something obvious.
>
>
> the beauty is the patch can be very small:
> 1. patch 1 do not schedule refill ever, just retrigger napi
> 2. remove all the now dead code
>
> this way patch 1 will be small and backportable to stable.

I fully agree here.

Thanks

