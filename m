Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35299299A82
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300210; cv=none; b=Qc1edJVhhDABCpncqhbyZNWEGEN9rUPmrhXEU+ClGjTCGPNuu6rlk5ll0C3psVGk+vfRztMhKZEv0tR4qkppUopZr15bTOB32tn0c12WdzN1fyzPd2yZ/5wrPm4+/c3kWvuunUEmpTNPmvkcFZ5hZdtIji90QBiR6fYSwTEfKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300210; c=relaxed/simple;
	bh=PNeIkz45DuQRho1DwPL9oWfBnWeiTTntIhb6ZT/FME0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHVBOwIGpk41MeO/SCsllx0IfPCG5PrWRgfgdQSDeIQPyPnpOXI9na16iWDwzAsYHDCYXCZ70bP9Tep01fhiqSzbnAYDmNQrLcJbDIqCIRdHaArkT89v2cn2djEBFZ1O6jKKtJKJjUTZ/LKG+xCts53BSuZy+cCw0U2OyI5dslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NflQiqkD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NflQiqkD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee0ce50b95so21436741cf.0
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 19:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764300206; x=1764905006; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO8NwmkkI9mg0Fvr/iDdQ4VLLlyo+WunqlauIGsbobw=;
        b=NflQiqkDHqL20Q6cjCb3Nqs79yPoiPfuwAPj+Fu8Kv8wLWTs57dO5u3VQhg4YU9x18
         uVBqz6E/XZOwXvgVnNOpzEB2juehJ7Np/s7uHhIKcQf2UfW2aNWEZmzASt5AeF2/DH5Q
         kgFUbUkNfHGXf1e2kXnO6X2L47XNWYiGmtuys9eh1OxrDVFbeye/R2AFB5jXit1oHFiX
         luGpvstv1b9orCcH6GjE9cif6jzwhWYUCTyhqyMfdF0PeIFS9zSjHfN5tzhjoKz94tPI
         NOrzHScgg5uNimbGuH2xuypf3o6Bz2+yFy8jc+PRFXfI85ZG/TFZIypX9/VGXexakXIR
         pDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764300206; x=1764905006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QO8NwmkkI9mg0Fvr/iDdQ4VLLlyo+WunqlauIGsbobw=;
        b=wmWNFSD15zXwfWPX5MjjdOkOd6VlF3DAeL81ogww/LTdSYFqIFvXEJ5M6wXpwdO//Y
         PfPpZ88j4krEAvzq5wvPC65cEPzYYdmc6NpdTehZg4/ZTAZ4CIeWkpoZXRL+TUBdfuNw
         +t4BCMqqEn6oC49faNR6KnZ0SnDaCpHoXPeqicEc+SNSw/zcxw2wYPnfbZC3nR55LmIL
         fm46Yb4bz2NuuuiKRBd+ih5+xpFwhDFG57Si8xQRbC3LHvdxS+w9bshgqAlqjVA/FGdY
         u17okYOMdBWA6RtkX8YCd+uLDuR3TbRpsldMkng1+qKNVThzcPirjo7DzstEpOE1Wk4I
         Kc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9euiiES/arlP/mtqucKnGhSv3rekE4dsd/cvXhwKX7kJRmx1V7+124AFJ2ZBfyP40AyHKIDthn5yexxfoWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyInjHXbXhiuqFlBoAXF4vir6ZwqG0Kssex3CquMbV9UOqy8lKV
	XlCGGd9I7VdtP3mY7MzxZUwYrgsxLMU9Qczcz3GHXG1nqLBxtfxyoMJhOqIGQFZ9uo2/r7llT+n
	tdtklzg5OZt/VbPbecxBZue3cveHeOXE=
X-Gm-Gg: ASbGncsjm/SnjMpdUZFNXncLK/etIPSHDYk2NtX0D0zkiGfkgAySvbeoEF7b3ZPWLsP
	G94LB2jIpqFLtP3NoOikiqHzqPvq3/bW6gRspKdOWfAaRiueHRp35FFNZ0ONSJLHgkAyUVwLaG6
	Kahp1tnatu9SD2nMSpqBuaK1XjuRvjBfBY/kXKXusoQFEsavFHfHydXcYJOEKOj2Nb1oxLPsxs/
	UM9JDOhvhfT0xitnnnV7YjWUa13F2EL/PXf3pQPDSgXqBHU5L9mmnaQ9urzq271rQ2A8ZA=
X-Google-Smtp-Source: AGHT+IG9mqJdVZgQj3BVyXnihjqxo6smpev5tsviBeKxWgS8ADskcY34A+TMMILps/HKlL0xyNYCt0kJ8fD8XQas0U8=
X-Received: by 2002:ac8:5e4c:0:b0:4ed:a6b0:5c14 with SMTP id
 d75a77b69052e-4ee4b54fd07mr426909921cf.23.1764300205954; Thu, 27 Nov 2025
 19:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
 <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
In-Reply-To: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 11:22:49 +0800
X-Gm-Features: AWmQ_blj83ISfyC32dpt8HHM0xujFYlidvaYOqxvcTwKucopW11tVoED-TPviuI
Message-ID: <CANubcdXzxPuh9wweeW0yjprsQRZuBWmJwnEBcihqtvk6n7b=bQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E5=85=AD 00:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 11:38=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > > ---
> > >  block/bio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/block/bio.c b/block/bio.c
> > > index b3a79285c27..55c2c1a0020 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *=
bio)
> > >
> > >  static void bio_chain_endio(struct bio *bio)
> > >  {
> > > -     bio_endio(__bio_chain_endio(bio));
> > > +     bio_endio(bio);
> >
> > I don't see how this can work.  bio_chain_endio is called literally
> > as the result of calling bio_endio, so you recurse into that.
>
> Hmm, I don't actually see where: bio_endio() only calls
> __bio_chain_endio(), which is fine.
>
> Once bio_chain_endio() only calls bio_endio(), it can probably be
> removed in a follow-up patch.
>
> Also, loosely related, what I find slightly odd is this code in
> __bio_chain_endio():
>
>         if (bio->bi_status && !parent->bi_status)
>                 parent->bi_status =3D bio->bi_status;
>
> I don't think it really matters whether or not parent->bi_status is
> already set here?
>
> Also, multiple completions can race setting bi_status, so shouldn't we
> at least have a WRITE_ONCE() here and in the other places that set
> bi_status?
>

I'm considering whether we need to add a WRITE_ONCE() in version 2
 of this series.

From my understanding, WRITE_ONCE() prevents write merging and
tearing by ensuring the write operation is performed as a single, atomic
access. For instance, it stops the compiler from splitting a 32-bit write
into multiple 8-bit writes that could be interleaved with reads from other
CPUs.

However, since we're dealing with a single-byte (u8/blk_status_t) write,
it's naturally atomic at the hardware level. The CPU won't tear a byte-size=
d
write into separate bit-level operations.

Therefore, we could potentially change it to::

        if (bio->bi_status && !READ_ONCE(parent->bi_status))
                parent->bi_status =3D bio->bi_status;

But as you mentioned, the check might not be critical here. So ultimately,
we can simplify it to:

        if (bio->bi_status)
                parent->bi_status =3D bio->bi_status;

Thanks,
shida

> Thanks,
> Andreas
>
