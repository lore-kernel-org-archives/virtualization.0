Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077B1CD15
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766535723; cv=none; b=ZQL1OEzCb9+5tlpQofd/Cg1Ktwln5MBOaP8Hq0jZVJQH8ug1I6jBMc9nlsygBX5g6PgF+61tOjz5H4l0RuUmfvwzVAednDYWtuuisfi4QqiFXaANxii51UZhXYns9xXObnPDkzDmy63haiBpvLNrMFSOangigXXbmoevGiFcp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766535723; c=relaxed/simple;
	bh=pANHgPD44QhScSfZkCsDU8dheo3uSJOHr8A6P2S65hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAT+TGsuUqRoWjYrnRCOscN2RZZKOF+H+BifhHnWxPfK5riC8KWtGLNzG3p9uDP+X2SGPU9leI+VsBsXJO5ATQWjZhXErN7/NUyj6BVL0/XYb8sTDmtYcY21Qx+097uT2l8YBKQV7tUTWnq+YSUpFEIISzhypjpWMR7dOl8vNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dj6PdhD4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj6PdhD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766535719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pANHgPD44QhScSfZkCsDU8dheo3uSJOHr8A6P2S65hI=;
	b=dj6PdhD4+wyZ5xk5rCWeEah36uLQpsGtGuuNOHvhTcHGIq6VCKSCuyQpp8e6LIJI0Qw0ud
	84J/nn498wUtTKwxN7WFtgBs/sGABrKJSb9LFp/Rc8m2Fya6WXRYi0aUE1l3qHpskDwyDR
	wjgC1L08Sql6XHcE7lbMSOM8EFS/oIY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qMKLZRDGPbmtMw2S_NwN0Q-1; Tue, 23 Dec 2025 19:21:58 -0500
X-MC-Unique: qMKLZRDGPbmtMw2S_NwN0Q-1
X-Mimecast-MFC-AGG-ID: qMKLZRDGPbmtMw2S_NwN0Q_1766535717
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ac814f308so12324675a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766535717; x=1767140517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pANHgPD44QhScSfZkCsDU8dheo3uSJOHr8A6P2S65hI=;
        b=AGoQ0XY4KFVVROUBP8YfTYIZyELd5QuyYG+B8c+AE/+H1yY56wJb2il2eCBzHGfOOz
         fq1hHgEIp7Yk3Qcu5c15P+HhpLhwEIfMd+BgQNs1EaHRjYt7ppfUvDAQj7b7NDDfTLZM
         AYhvez+1bbsOouaUtvnuVlnoWMuM7NxYKwP46aEAT7Xc7r7Vw6cYvN8Qkb8ATMnhJiYj
         PES7Hq+UJEpKLB/p77c7N6FXLIRWc7AvsMBTZ8VWIsoujgAZocrUgS9FTCuXxheLtd0s
         +ZTfC+dog9AOPVA2Da5K/oPZ6X5f4Fm+dE282EpN7lC4W9OEDEO3PLyxyFgH3lYTo4jk
         Qyrw==
X-Forwarded-Encrypted: i=1; AJvYcCWeYM2Grjz9lx7UlaFTh+gtTfMZeYi1UOu8CziFHU82RY+LTm+xcKEXk1ZunDS/wsG98a6g3tNZbaJ3OKbXkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzReJKmhmIz1o6k86lh8H1O2lzMoHbsNALuDHCd3L3fuh4Jtg9d
	yJ8+7Ffs6/8FDdGLOio58/dwA4BXcp7BwBINXRb595fP1qMQLyDH0caXeb5IsyHxGumko6r1X1P
	3wAh1HYnyhoTpUhHAN5do0A4sl2tXAXGFu0ZDQK2El/ySO3U5uqZVifDo3VFhTg8y34kg8hk3bu
	Dab5nD2VjKy6PMMCcNv+eMkaKy+Xn6tI2NUwQh48cCHjFmeXEsKlwr+g==
X-Gm-Gg: AY/fxX5zvI/AAyWXe7UZ0PVYN1V8JWAywvU1lZPn80odXL3B8gqYjaTY/+Y0+r1Idlc
	VAVHCaEuWaUFSI6c+5HXMGN2eB861EyNVfIEw9HT0js4I0PRu96vcAY4o1PxsBsO3b0vN0ZeYVX
	iEqGxpBPJS59oNp0idYfXeea+iSnskqLt3PuKuYnDE0EBkfx9Lsp+2DVj2lnykH9NGmgzP
X-Received: by 2002:a17:90b:2e4a:b0:34a:a65e:e6ad with SMTP id 98e67ed59e1d1-34e92123159mr12804268a91.1.1766535717415;
        Tue, 23 Dec 2025 16:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7zKlkCb3AdoKyR0tDQvWsn+r2tAZrpRsa6bAp1deHYrVBbZ4/MfGunok1vvpPoX08eMz4kB3Zk5769aDf8jA=
X-Received: by 2002:a17:90b:2e4a:b0:34a:a65e:e6ad with SMTP id
 98e67ed59e1d1-34e92123159mr12804257a91.1.1766535717018; Tue, 23 Dec 2025
 16:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125070838.70736-1-jasowang@redhat.com> <CACGkMEtjvycsK0JJ0G89SRr3FTHgaMTU9nRZNqqv7=yxiTqgAw@mail.gmail.com>
 <20251222202855-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251222202855-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:21:43 +0800
X-Gm-Features: AQt7F2qRtg-nbKXpWWXr_vVfEcAUUZJWXp2rz917HKythA7Cd9BJCkmzKFiyw1M
Message-ID: <CACGkMEtQ6WCbTa1wKduARwwp0k+EL4uyx1sSMUR2UAEE7cceFA@mail.gmail.com>
Subject: Re: [PATCH V9 00/19] virtio_ring in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hVxzRWSRyEtWA3cmhODLKEm93LHOLmIHKYFEHBW8lJs_1766535717
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Dec 23, 2025 at 09:18:47AM +0800, Jason Wang wrote:
> > On Tue, Nov 25, 2025 at 3:08=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > Hello all:
> > >
> > > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > > virtio_ring. This is done by introducing virtqueue ops so we can
> > > implement separate helpers for different virtqueue layout/features
> > > then the in-order were implemented on top.
> > >
> > > Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM gues=
t
> > > vhost-net/testpmd on the host.
> > >
> > > Changes since V8:
> > >
> > > - Rebase to vhost.git linux-next branch
> > > - Fix issue when indirect descriptor is disabled
> > > - use UINT_MAX instead of vq->num to indicate no batching is pending
> > > - Tweak the comments for used_entry
> > > - Various coding style tweaks and typo fixes
> > > - Try to use in_order varianet in in_order ops
> >
> > Michael, any chance to make this for this merge window?
> >
> > Thanks
>
> want to fix last minor comments?

Yes, I will post a new version.

Thanks

>

