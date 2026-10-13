Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911F47CA9D
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923586; cv=pass; b=XmNqtsqfBeuxZ5zKNTtvm++eBayA6xqLFUTwQ4/W3wHnb6hwCKhpGGKNi1i0frVDG66cLQHPboxGFMX0XE8by5kOl5du+BmJ+7D869fb+SX1Hj+1xKJDrV9KXjxnjQcqJtvj3gJylBRqzdYbq5D0oj3X+aYBWpWbQYheDmXdbDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923586; c=relaxed/simple;
	bh=guoFD20zEk9cIM8OGpiI6ZacaO2x+w0vW/appO61b84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjJarnz14oQhiqc3L04oPtFBlSO9qWN8+0uuHGfrxpTFmyLx3I3k5JjjfvCGdbcSzXpfYdwU5pb+0GtwpvZUFYd8Czt6xcltk9VaGsRssNqikcKTix+acwezrsGfciFRsKt/7tCbYkVciYg7JrBiH6KfIynFp8RVOgBYHRkzBJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDKTMDDW; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDKTMDDW"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-676858d42f8so2738212d50.2
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923584; cv=none;
        d=google.com; s=arc-20260327;
        b=lVybFVt6dUgrg2hgEl53ODBrxghTuWeu9Gd12M89gyHgrTAnwnpAuPHox0cT8sIc5E
         GalMScLJG2FFQZbFUlFlgZbDLZ/ydxsgwmJ73fQGycFNX6azYYzCGQmSOTh+M07X0ANP
         AArtF11xZddHvtLLjr33OArGfJ1JOWSEjk8IrYnEFkl7gzgUy5TjidR9QoALHD7i0rtZ
         cZ1JPxsB9p8k92agihXDCG4IDb6qptd0Lif+o11lYxMYshkjcUWrYd+EgnWhEOh829bv
         CqI907N4ryvynBoQtPd2NLT9sA19VFCNJuoWA9nFtXGdZeE1oa67ALpObA/sQ+msXm+B
         BL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        fh=vi7VST77W7VyoFBVElzGxeNo5IK009nmbDpC2rzhNE0=;
        b=T/CsBw64+JOvwG+uAYNzoF1jQky2+/mxgVbZWgkXiaQOxYy5oCKWavy1J4urJ6Cwrf
         7RLheTxCXxUQPq9Kv4j5eP15dE0JQJUAoHVXb5F+G8DDyGg64wHIbc6YfesOBJbSg5n2
         rWdf09YRzEz8s/IDBMNQiuV/JC/cwdNmB4cWs8EoaZaCBQmjShEtWYJVzJvX6R5Y3B53
         K4xfNN/hjpgTtCmNFewjW7HWOuoVCREWbsfGt4MIvMVCU2s09SiKamHhFZY3emOoeaj0
         tIFaxpKIuPvvXi7vApe99V92C5NXwwLbRUDhJ6k5fypbPxZanOtZHa9nob4OhCnOuVNr
         W6ww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923584; x=1792528384; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        b=EDKTMDDWScJfoGCavscKFVjrvU7zWgggkAA/tKZR4lzbctQ2WwpfZrDcD7u3K72gUu
         +wgkZiskh9YAKTTnMmnch8to3MhKEFsF+1DYRIIvgy5lU5O6mvn5y3xaoHpeUj3EKl85
         EbOCKm36ycLnabjCtuUrrhKMbsMqEvhorniBRKbjTzgMoeAoFXdcjDH63V9P4u0nNhS2
         DXel9xFgwWYXhZ4SeGTFwK/sUTxN66dtdtXjQDB9GuyVS7VEsN8WyeEpNlWOpUINuidT
         dJYtd9doDD9dBzVvBb68RoJHAsXHk5tTg9xUSIv0/pjDJ81+6ZUwJe0d7ythG1PfvbEH
         R/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923584; x=1792528384;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fjZWNfknzV1F6JAInAE8o3x3W3fwqE841SsbudO4cc8=;
        b=pkKXTPU93mzBbNxpeTrrjIL9kMjUdwPuYjm1X8wLtN/6PU2xuWVtYVc/J3QVo0fBio
         YCexdcQU3Kyu1pLkK1QhHUXw4NdkteNGuW5fm4YHbB+OQBW+RF6EZsvVebHuaOSTiylE
         z9ngWi+EwlF8yr7HeKGLdIvohzbt2Lgtl9D6Vv/JrmpShnqM8pRfwQUQq1e/we+yQpBm
         nRpVgOli1kqesPNL1DrGpThXTqcNye4vJM/qNj/p/s2ylbgqKgNTJyzC7LjlVI0KBnAA
         qExuslePxAfUUPaslLGnIVspMtRjdqRho6t1Pe2bSZTxoi9/0yV8mJwA7RUFDc8nLNN1
         t30w==
X-Forwarded-Encrypted: i=1; AKwUvBzWhICDg46D6635M+ciJoa+5h4i7TRULr2L0PXzVJF6TpQGET61FvjrSQ13TVOoWhZaBM9BusqFfMtL+AAlCw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK3cht2MWiqPy79yfQaA4ZRCk2c0SwF+B9L8njGhqZZYxTemqmH
	PfCkiB75PIixcnXyXbs9r8BBuubg742qsQa8vumuyZkI0YauJotVr8pKficSEnmVhMmsEyVbob5
	tUh3mEU4BoJfpyDEgp8Fk7f932i3GBwk=
X-Gm-Gg: AYBFou1fvQCU7jxeUncYDnETYMiLW1NSiUh+B0aDZ6IJ7EfUwB6Uz9ITXiaC36tznta
	17iontuHdr+BQN15ADOfABTR3flHSbEYr6X7gwpegCJCgustQHyXmIRMTuzD1ExoqXY/E75WXnT
	GWSq9klD07CoGJjw6DCYcs/8/JEQHTywQ5jbcExyGglgg87KyiMzcc/dqY7bA+RCcdCxCdcJnfO
	+Sl/B3sG5ulQL3Xw6gNl50Fw3IM4PQFJlCECMT9uNd3iUkOnryyLrQAhWi/6sSJNmoCNIooA0TM
	a1012+iXLjZ3It5tHYDmDAVnQlgw8R969LZ4TcnWbl/iK1ueOurdzdLvJF4tTAcbzT3/EYRWQ36
	rbnkQatJ8Aww/aauX5gcrEzJqgD7AR+j9Lt31ZomH
X-Received: by 2002:a05:690e:168b:b0:675:b778:a423 with SMTP id
 956f58d0204a3-679362bf517mr4886393d50.142.1791923584078; Tue, 13 Oct 2026
 13:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org> <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013143335-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:32:26 -0600
X-Gm-Features: AclHuK_AY3efVdSO1MP2W2AAhlxVTMjkmeXG8cBqCPBuysQoPjuKaPNm0xvEtb8
Message-ID: <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"

> > > > +
> > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > +                                            inner_proto))
> > > > +             return 0;
> > > > +
> > > > +     if (skb_is_gso(skb))
> > > > +             return -EINVAL;
> >
> > This is a risk the commit message will have to call out.
>
> I tried with this:
>
>         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
>         > > > assumes knowledge of the protocol. We could segment ignoring the
>         > > > checksum then do whatever csum_start and csum_offset say, but that
>         > > > seems like an overkill for something that should happen.
>
> I guess I can add a more detailed explanation about what the risk is?

Let's just explicitly mention the consequence: non-standard GSO
packets that previous would be sent may now fail.

>
> > I don't see a simple way around it. We discussed segmenting here too,
> > but that requires intrusive changes to all callers too.
> > Alternatively,
> >
> > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > This also does not add overhead, because it would be called later
> > anyway.
> >
> > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > drop when set. Messy, but so is the situation we're dealing with.
>
> Tack this on top or do you feel it's needed straight away.

Not urgent. Can even wait until a report appears. But worth taking a
look sooner if either of us gets around to it.
