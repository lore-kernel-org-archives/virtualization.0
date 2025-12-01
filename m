Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22373303A2D
	for <virtualization@lists.linux.dev>; Mon,  1 Dec 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585094; cv=none; b=MP2OCbF0Y7H9fBoprsUmDITtweOIZ1ihagh+aZIz7IgwEWgPv+jGSO3nti/r8y/KskfLA+xCUZyfeakmnHPD23Sv7Fh4W47BoouK3cOxQFUo61lGpAtcFNgUcfAyTir55jWcXmC2ti2w/QiAd0749XVy/GbxdBbROOMFxdCQ6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585094; c=relaxed/simple;
	bh=oAKELPmBA2BqrK0o9QFtBWPRSKg+tCcCo1sXueOdRDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eooNaMUb2A3/zP/JToKAEHi+VVjyZEFeEY/alHeqmGO+yGI2u53xSnTwdShaMOYAw3jJOTv78WL/olrhuH1VRTfGnsdYUQiP1DPLN5YmtDsCDMrYkadG+sq4+uNIStkbHkFO6GHG/Rus3UqYipq7KyjkH3CnwyTzsbqiIM1aObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvYBMu0b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvYBMu0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764585092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
	b=SvYBMu0b3KPBFUduPqezPPqs0AOZeQgiXYbYf+YdIFzIUhhENHcLx1EiJCCAlLmIUrxjTp
	7j+c15HkVVNHGWLQg2mrNNbcBQ5h4JcnCIuk58U/rnZU25C5vD+ZBsXz58DsVeXA8b8aws
	C9zO5OY2tV9S2XQqAHejI/kQBCEialY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-BCnQSCGdNfGVeBYYozrthA-1; Mon, 01 Dec 2025 05:31:28 -0500
X-MC-Unique: BCnQSCGdNfGVeBYYozrthA-1
X-Mimecast-MFC-AGG-ID: BCnQSCGdNfGVeBYYozrthA_1764585088
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-787e84cec10so49461317b3.3
        for <virtualization@lists.linux.dev>; Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764585088; x=1765189888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
        b=hA695kGuKPRONyVmk80C7/3CGXbYjWCXkcAYTfKxXFJNsrML1btp1uNgBpT59DnQOI
         YewnKng6Pr8tR+YbJLdh3Ke9dxheh8WCwx2m5NvY6oSyq9lPuRmlp9Q3iymDPQqCiRUG
         MFeONbpgYcKwoNSEscmAT5oGErAfuIftYZwCgUeiYfZER8sm2SeIT9BYvuIDS1KMhCQV
         TqdR00RHWwSgeCXjWDLQUsrlIvgwrgYG4uDUyhijnkRLH6UDOIFGwn+wUfwdh1pYDbL0
         TK54i+Lqq8gKJQGyWSj6w23MZlyxWvwQoc1zw9rntPRdCX+fR1ZGQdwq037YCeA2iC5s
         amZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Lt99ssAPE1P5o7p9viaF0bWQgDw/1AmuKFNiQm2fPg6j4vqZtKgjNPLBpF1BH52AqqYIf6CGNngGXOirhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypij/7ZxxJfBOkat3/6cM03D7jT7DE29ot7Ecgmwce5auvDUlJ
	CSpgwnOvsWXL4jdf3fd5O7yMBXVHY2u86cL5bkwo4fWbHr4aEXffA+SkyM/mmGu5g7J5Af0E0a/
	8PBK99TrOtw27AaQg7OJJHGAtIzNk85Y0KgJIlTrT610r64JRHMFLIWsgzUNmL4Ga1rHz2FrHk3
	VxSOGug8330ZutMt5tzf6hIdPYIAZZhWScsrTIszAFaUs=
X-Gm-Gg: ASbGncsrzbVxhoEj6sNKbqacbAfJYDPAwggREtAebyy0V7cQB8ouMa8M0YmYZhU0L20
	QZLGF1Zf1LXLjbb8yGOlU1i/QW2CmnXL6wMcjwmSQXnXq5o3JxQbNmAXSlmVEdYJ+dH2Axc9qmt
	CDlqW+vJk1i916ueIdpPvw2HRUN+5NHfxdBFljUIT1PTGMSnFC6nS6J5v2JrM1Y0m4
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id 00721157ae682-78ab6f19dbemr204012277b3.45.1764585088406;
        Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5zzmMokroNvK6hxRqePUK2sUy1kyOakdwZXoQ77gSpCZtxQfALMHCo45aGmJsVIK/6txSFE4cjS1pCWEh08=
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id
 00721157ae682-78ab6f19dbemr204012007b3.45.1764585088053; Mon, 01 Dec 2025
 02:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
In-Reply-To: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 1 Dec 2025 11:31:17 +0100
X-Gm-Features: AWmQ_bnf2BodBLtXxgPiuMZc2dFAC9eikQedB20yLRtD3dfyefefH-ZDvfFzYn8
Message-ID: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5eHV-IrxP9GRJdzersQ-Dmo3TjMJsPOierBAazeKkHo_1764585088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.c=
om> wrote:
> zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Replace duplicate bio chaining logic with the common
> > bio_chain_and_submit helper function.
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  fs/gfs2/lops.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > index 9c8c305a75c..0073fd7c454 100644
> > --- a/fs/gfs2/lops.c
> > +++ b/fs/gfs2/lops.c
> > @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev,=
 unsigned int nr_iovecs)
> >         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_N=
OIO);
> >         bio_clone_blkg_association(new, prev);
> >         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> > -       bio_chain(new, prev);
> > -       submit_bio(prev);
> > +       bio_chain_and_submit(prev, new);
>
> This one should also be dropped because the 'prev' and 'new' are in
> the wrong order.

Ouch. Thanks for pointing this out.

> Thanks,
> Shida
>
> >         return new;
> >  }
> >
> > --
> > 2.34.1
> >
>

Andreas

