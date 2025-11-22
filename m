Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360582E03E4
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763796351; cv=none; b=nP7xfVijsXHdCNUaP5Uih0AuoLMJGJnWbzINo52nAC4GLAmYGj9JD61eeTppy2a2GseOuMgpPMe2LW2JZNVN1muLfnBZfMI1TdAeOmwry35oVzbw5fIYjNUzwLFQssAyAPBhPJJdeyRwPdGADoa0Of2LygeqBp/OZcXg2MpCe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763796351; c=relaxed/simple;
	bh=JIS6SCLgbf+oOuOkDo/dHaEAqLI3/Ie51gDdGsv7FCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7HiqTOjxMN4sTgBkivTvPZPBZGoER2aMQE+H1NPP6444Cxl0weVSpciJD61KqjcV/HPnIoKlFP3SGIGPSilY+reSpbwFXzV5A+S+OcUPtO1fTTQ5cX7fNmDZBLFZ0Aj5K+1IBJIX/+hA7DECQzyl1JwaSLRPbhiilP3iaCWYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/rNJhq6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/rNJhq6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6c385c0so21615361cf.3
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 23:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763796348; x=1764401148; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBwVylaCDYZawWaYOaVSH7r235GJ5pL280n6ediNWBA=;
        b=f/rNJhq6DjE9eeK0DuTrJpZJTX2Z8A+DOeDHy1U6J3oxmPzSwzRbSwwojvMqoQ0csr
         nb8m+xd4T3T8JZhZbKeDcsH6KMoHNQs3TEXZRypJPy/RQiqyVTQj8WXfGgyWNNmeipH+
         VzCKXTjg0L8mYZtRU+heIB+wMqx6Ik/sB7AF+StjAWm4as2mdwEdS5tXJ5lzxa2WXElV
         Zf+TWcCwdPVA7mDrCty54yzPFzaxbSgpgMW2CH/bACNBQuc/5lmOW//QX1SumK+HHTNk
         PWDyAqk+++nH1HwCq2mmZDJTAZinSOIFxUE4SX5VjxxxPmCOJ/w2ghTasySm5UYOLdAI
         BLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763796348; x=1764401148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBwVylaCDYZawWaYOaVSH7r235GJ5pL280n6ediNWBA=;
        b=I4OefyBwhknd+JC/qh0QErUtuZtJSG9SZkYw9yHpxXqCuxfj3fc2SlBnD5Gd1PvEnc
         LsaVa7iVRyLsOQLBao+34q9yUJWBTOJLsnkhRtUxNIiK/YQrHb1nRxqM4c4ZNUKkjBko
         3J/Y1VYe+1ycDzTDjqsWzYg1gnM1NHZkyITGUBh08sxl2RQo9eihwjkII63LFoh/LeG/
         93Cnfnjwy2ljJkT4QDVVPy55wve60WzNNUQn/UpqC9spaWoQxCE7wA6CO3Tvrvit5mtp
         tOrm1m004XYV9+AKfkjumW/19t0iO8MZ/kNGUEpAJ8QsKwx8JV1qWlBnMqjzjEpcvRJL
         EghA==
X-Forwarded-Encrypted: i=1; AJvYcCUuevQpLvZNmy/7wZst7XULCJ0pyBsIuLWhgKBizQtzdt9Vv2ZsQWVO8QboIukBDYhOpFPafusMg0ep0Q0qbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1rtAM1UljjA4A2qHeDkHKmd0bef+tncyPJBe0SOWvxDNZcO7c
	OS2nwAqINyqRjTnEENe1ErndfU4hbzFFF94ZyQbsZOEtCticn0rd+Zm2VQ3lvgVJq1gBnF7IFmZ
	n5/BE9AaeHX2rZuc7w0HPeIV/idZ30lk=
X-Gm-Gg: ASbGncsBiJC4c9cjjfRL/QHfvkigZ3vw1uKMBSmQGtZq7r6GqTr9aPeUZ8+WJieZgwm
	M1Ump6vsW2tTcbCVwqCcPwcrsebSmkg6Zr/s0U4li5oBNrUYQGu2mZDGy5Olj2kfnv4XmG4yS7n
	EKhaAuyJPEoIC3VXc1XgyoTTmdKusiguuxaWb9AhhZDfHW3SscrUiUo6Ji5hgxv+xVzIRAlF4sX
	P0LTZH5U2hMHcdp4MlAxBxZagfvXwJdfKWG/dczS+dIC6bQMral1SQ1aXUOXclsGgqOI6k=
X-Google-Smtp-Source: AGHT+IE9V/QbSlM+tFjYlGuMiqhVjgd2vxC0t40Xg/Gl8NLqAZlhJSgGugagYhyt41bdzYZDASTkKfW3q1PwTWY5MjU=
X-Received: by 2002:ac8:580a:0:b0:4ed:b1fe:f885 with SMTP id
 d75a77b69052e-4ee58848f99mr81632341cf.19.1763796347971; Fri, 21 Nov 2025
 23:25:47 -0800 (PST)
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
Date: Sat, 22 Nov 2025 15:25:11 +0800
X-Gm-Features: AWmQ_bm3jSl3t5CGtWT-qk2xFeLKlRyvhhYg4MhhBIRyX0iMMBB8sT9lfrjP88A
Message-ID: <CANubcdWaegO8k=_fkNFSvnp2bUYMmPehSFnenCCjVw2sz_1jqg@mail.gmail.com>
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

From what I understand, it wants to pass the bi_status to the very last bio
because end_io is only called for that final one. This allows the
end_io function
to know the overall status of the entire I/O chain.

> Also, multiple completions can race setting bi_status, so shouldn't we
> at least have a WRITE_ONCE() here and in the other places that set
> bi_status?
>

Great, that means I could add two more patches to this series: one to
remove __bio_chain_endio() and another to use WRITE_ONCE()?

This gives me the feeling of becoming rich overnight, since I'm making so
many patch contributions this time! :)

Thanks,
shida

> Thanks,
> Andreas
>
