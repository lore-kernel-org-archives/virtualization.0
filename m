Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8910A1A
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875958; cv=none; b=JVopj7zZVSSEd7MhDPBX5nYPK1Qw5dj7kwlrz/wyIb1OCNpp7IagYWLOpKDOS8Nz7wCDEUchlKC+mL/9pRZrBPYnh3EuxmITPm+SOWvgWl1D/lGP4Al31S/fUoX3sNTIo3QKmKimXEDgmzowV8kvSSmIO2AuMCLto8v8ieJ/Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875958; c=relaxed/simple;
	bh=gwcQ2eDQDyEe+mNpwBlNsxSv1lMLn+Pspw/FQPhKKCk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k5Jzqx0ZE9BV6hTu3+UCPT6tkk9nH7aCpvKycHRtDGIlDJagN8v3HDhcBUOUDcmctBRr0xpeRDJhspFozr4V/FRJO1yF5UJ/fB0/xFbM7XcxYbGjgFsBly2zfp2B75d7HxDKUCUfh+hrCjeoAYd4IRNXEz6LMJl05PS1jk0aDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1AuO8y2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1AuO8y2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d067d5bbso26402285a.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721875955; x=1722480755; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBUiRZivIy2H5zWQlKFTeSB2D5HGesM5Zhywj8P0csU=;
        b=A1AuO8y2ypHS6JF5u77CaaEJjub4I7850QxFg5qqk6UwwRyMSmQhZCbT1sKKGv+MyV
         B2HH/4CdBqK1EKfbBWJ3Yhj5q3cjqq8xZYf9vYR1dXeEObDlCd8QtLEK3ND6OXyNyKo9
         Z2RH/bsoG1t6SSRiJpBu4/+j3CtXHDnO1GzHpJRkh0DVE09iRFm+Wjg2joQLK1ap8any
         q+FT/oqOgrfwyn4ReuQeMZY0bV185fDypp2IPOH73O6nSUn6Uj6ekXta8RixA6JXtc63
         ZN9lA97UVLr43zn2i3J1gIIOY3QQgkOGLyREf/csGwdIYVeTt4EbS64hl8PcB+aRM2fR
         hfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721875955; x=1722480755;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBUiRZivIy2H5zWQlKFTeSB2D5HGesM5Zhywj8P0csU=;
        b=qCJO06pZjhvnZMDmXqaS6c7BP/m1kaIvH6HSlr6/ejn5TDD7L9+5Tlm64oXPB2Z9wU
         9AsUKTVqX/+7JPOoJIsOrye7WjqZoYSCwbGm/GqGJ3fshGrzwj6wmHE2ljCCCwaxOwkY
         GAZcSN32tURdQJmlt1dmZ/oKZ1rXQV+EZtqNFOIdqX5Xqa0YIsrSqKMa8qBzV+MQjFHr
         9/t7pV94VWPjMp8ls/wPWH1BQkOAqJ8K3gtnr6sro8Y3y6VZl3eoW6ONGolxsws93G6O
         lWMd0kKrSAZ98nLHbUv74hRbinTPjuHAn9o9t41NhqLPzUE+9JWSn35gKFymb0xUlQs7
         DHRg==
X-Forwarded-Encrypted: i=1; AJvYcCXiddXhZlYF91JziJCwjYNnbCyqnM2Ql3S7U1umF5AptWru78BN9GhvICd9WrdJTcDYLGS57ytn0ztV16zPyMi+S89InProl+ATabDACxY=
X-Gm-Message-State: AOJu0Yy1pcLk0tU5DK8EctSO+hduQ6hQuA6/dmeLtb9jyKs8hVjHsn3T
	1pWymeTgdBjJfXjkOb6X2JUGs/FR9wqmC0NK/4vhJ2JonRWCxC8Z
X-Google-Smtp-Source: AGHT+IGuImde7YJHP17/nZcN1EhWUNyyzyCAZDedr1Njwnn/3CgIugsY94osKjrca7Lik8w+UBazcg==
X-Received: by 2002:a05:620a:178f:b0:7a1:d948:b939 with SMTP id af79cd13be357-7a1d948b981mr22344585a.14.1721875955305;
        Wed, 24 Jul 2024 19:52:35 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8172229sm2099071cf.47.2024.07.24.19.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:52:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:52:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 arefev@swemel.ru, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <66a1bdf2955b5_85410294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240724074123.614feaa4@kernel.org>
References: <20240723223109.2196886-1-kuba@kernel.org>
 <CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
 <20240724074123.614feaa4@kernel.org>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> On Tue, 23 Jul 2024 23:48:24 -0400 Willem de Bruijn wrote:
> > On Tue, Jul 23, 2024 at 3:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > The commit under fixes added a questionable check to
> > > virtio_net_hdr_to_skb(). I'm guessing the check was supposed
> > > to protect from csum offset being outside of a segment
> > > (especially if len is not multiple of segment size).
> > >
> > > The condition can't be right, tho, as it breaks previously
> > > working sending of GSO frames with only one segment
> > > (i.e. when gso_size <=3D len we silently ignore the GSO
> > > request and send a single non-GSO frame).
> > >
> > > Fix the logic and move it to the GSO part.  =

> > =

> > I missed the previous patch. Should we revert that and create a new
> > fix against the original issue?
> =

> We can, no strong preference.
> =

> > Normally the checksum start + offset should always be in the header,
> > so not even part of gso_size. So needed need not be related to
> > gso_size.
> > =

> > The exception to this is UDP fragmentation offload, I suppose. As
> > there the network and transport headers are part of the UFO payload.
> > =

> > But even for the normal TSO and USO cases we cannot verify in
> > virtio_net_hdr_to_skb that the csum_start + csum_off passed from
> > userspace are really pointing into the transport header.
> > =

> > For SKB_GSO_UDP_L4 I added a minimal check that csum_off must be
> > offsetof(struct udphdr, check). We can arguably tighten these csum_of=
f
> > for all requests, as only UDP and TCP offsets are valid. But no such
> > simple check exists for csum_start. This requires full packet parsing=
,
> > which we don't do until skb_gso_segment.
> > =

> > One option may be to test csum_start in tcp_gso_segment and
> > udp_gso_fragment and fail segmentation when it points not where
> > expected.
> =

> That should work, I think.
> Should we still check the segment boundaries, tho?
> A bit worrying to have packets floating around the stack with clearly
> broken csum offset. At the same time maybe the modulo isn't free..

If we catch all cases during segmentation, then it's safe too.

Since these packets get SKB_GSO_DODGY, no risk of passing bad
packets anywhere else.

We also defer other correctness checks to segmentation already,
because else we end up building a second parsing stage here.

But overall I also prefer checking at the gate. So either way.
 =

> > Btw, do we have a better idea what exact packet triggered this
> > WARN_ON_ONCE in skb_checksum_help? Usually, more interesting than the=

> > skb_dump of the segment that reached the WARN is the skb_dump at the
> > time of virtio_net_hdr_to_skb, along with the vnet_hdr.
> =

> I don't have any extra info, beyond what's in the commit message :(
> Note that the syzbot report says 6.7, too.
> Denis, can you comment? Do you have a repro?

Yes, please share if there is a repro. The original report did credit
syzkaller.

Else I might have to look into building one..


