Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5F2C21EA
	for <virtualization@lists.linux.dev>; Sun,  7 Dec 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765101873; cv=none; b=CTlrOVfmAMkfTSRhrXSKyvISWfunWs2GlJ873FRyiZIqxUOSsGkn3Vsg9vFaCiw3bveGivihz9enWwEXEpPqUUf/omkyFaUnTnl/55mwlHS70eR8ormAaWzuSQOdBinHwNLrAk0cFRoTaDGdDrBowRdCbtMoVzvCybzi7xjNV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765101873; c=relaxed/simple;
	bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P30c5ix1i/f7eGErD3EuTrlfaIT+p6jmqYOzFicAyKpLooHbNvrk4lyMSPkt2baG9KDtiNw9JH0MacAMzlsqjR3HQzGLz5a+8Q0YN0qQ71isbJLTzJOxpQot1Epx/D27GA6o0Adz6CDclKnJOEkDCe1EVJ9sKMzPFEiJnL+ndz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S49MsaeF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S49MsaeF"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee328b8e38so33637901cf.0
        for <virtualization@lists.linux.dev>; Sun, 07 Dec 2025 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765101870; x=1765706670; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=S49MsaeFdEPAFtEpevNWYJDBtH9mEM8+LNqS+FHLmZtODALy4nY5A+THgHZfsTmEnV
         4/lQxMMu2QNceC//DIxv561zSQQbU2FtWw8micw48SqH8cvqAwY08WzuVDneKOnPmEuO
         VIhmQMTsiOpZFzUuw+0rJOAtbw9bEvkRze6HlKyxc1vnnl08wHSVMRsA5yifuOWvHzlv
         SfiOpNS9ZD59iqDVVgvOQGGBA+ahd/XQaixyMeJbkdqLh1JamJxOjEtBAD5CrshAfZdP
         EHDeNeWIGNbEBrCjeFBn+M2KYYxa76CVy4eCegGUu2KGCCt2Jnqz7RPi8TrZLdf9mdna
         sA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765101870; x=1765706670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=BmiLThrZ322Tb06Y6kVXHAO6PQgU/abPf1yiyXcXf5/l+jCQ17wjBMyDLEYSRmtjGb
         sqRAIQbG+bKgYT8ded8brwjfEfu1qL74/3HEIgG1QGSqr9rDijKSuX4O9aHc0JrKS6fm
         cU+3vjIJzgRz+U9amOfYxaagqh+i8WhG2GE2VhAo8BQ5LKX38LQgkXlVj2sHLwiV+QEX
         5/w6LQGWuue0a2SXriH8t0T6G4nlu9RTlCMxenMVJ//lK/9d9XqFftvRZ/X4XlcQu82h
         zyTJsg0MUnDYOfQbS8ljhUT80en/ewm88RCfGpAXd2eZ+2gjRpqYpKBts4FKtplMQ5Ls
         c09g==
X-Forwarded-Encrypted: i=1; AJvYcCX4QBclM+ZVL+daUeGe4vJFFSmNLxELRMJZpLv+Ka9WEc4OSH9rDrAAd1Dyq1fTEyQ+IpB9FS3uKF6lRrh2Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1ADC+1kRoPhTF+BwJHv09pLd1t12aFS2sjolhvzeA2vKTHFHP
	gqyc+8kQ4XDrIx0gDOUiJs1a//wmUvEus2SD5UKOMS6AID0f7k52IgV14gpr3HQimCvgXp6F6mZ
	XrCboJvaDjtgd8wjqx+CteAQip/zcXyU=
X-Gm-Gg: ASbGncvb6Fdi9wo8H0w4wtoKx77PQ9Nt/KnWdnG/bsxxOj5bXVPv+wJtlkCxGnr3bzR
	vTol/Ph4lZrA7v+z9BkFIjvYnt9HwjwdPXJtJpdhlLRJjLW3DibTyReNEJa20PU787ZeHDWvcCo
	ADcLThyqdK2ntqmyd6/E0gIWVA83plnrNtEBSRVAEU1pyZIUhLsWDVALolxfrv5Pf0R/O52oGIo
	j0Ebqlh5ZOnnyATQC7uzGYVA9bv2pzT7+i5qdJQ1wC1cVyODnQomJZ+fwVElqrlyAY7EU8=
X-Google-Smtp-Source: AGHT+IFyS19gciaAgZhRx4HvH1R1sNPMXGO05IWdCy0tyufd5AG5DROw9tSZhuIt2ZeFQYvOMOepLj8Zf3YwFI1IGTs=
X-Received: by 2002:a05:622a:1249:b0:4ed:aeaa:ec4d with SMTP id
 d75a77b69052e-4f03ff48c23mr65405971cf.77.1765101869874; Sun, 07 Dec 2025
 02:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
 <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com> <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
In-Reply-To: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sun, 7 Dec 2025 18:03:53 +0800
X-Gm-Features: AQt7F2r1YNFWGA2Q9VwdNr_tG5KYi4lqES_2HjNJQ6tE7fdz6CI5_Dt06IQV2e4
Message-ID: <CANubcdVAitTW_aBqwxC=TV77rg_iie0uX54_qEtMCjgdN+zeig@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>, sashal@kernel.org
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=94 16:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.=
com> wrote:
> > Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=
=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd=
@gmail.com> wrote:
> > > > > This one should also be dropped because the 'prev' and 'new' are =
in
> > > > > the wrong order.
> > > >
> > > > Ouch. Thanks for pointing this out.
> > >
> > > Linus has merged the fix for this bug now, so this patch can be
> > > updated / re-added.
> > >
> >
> > Thank you for the update. I'm not clear on what specifically has been
> > merged or how to verify it.
> > Could you please clarify which fix was merged,
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8a157e0a0aa5
> "gfs2: Fix use of bio_chain"
>
>

Thank you for the detailed clarification. Here is a polite and
professional rephrasing of your message:

---

[WARNING]
Hello,

I may not have expressed myself clearly, and you might have
misunderstood my point.

In the original code, the real end I/O handler (`gfs2_end_log_read`)
was placed at the end of the chained bio list, while the newer
`bio_chain_endio` was placed earlier. With `bio_chain(new, prev)`,
the chain looked like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`bio_chain_endio =E2=86=92 bio_chain_endio =E2=86=92 gfs2_end_log_read`

This ensured the actual handler (`gfs2_end_log_read`) was triggered
at the end of the chain.

However, after the fix changed the order to `bio_chain(prev, new)`,
the chain now looks like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`gfs2_end_log_read =E2=86=92 bio_chain_endio =E2=86=92 bio_chain_endio`

This seems to place `gfs2_end_log_read` at the beginning rather
than the end, potentially preventing it from being executed as intended.

I hope I misunderstand the gfs2 code logic, and your fix may still be
correct. However, given how quickly the change was made and ported
back, I wanted to highlight this concern in case the original behavior
was intentional.

Thank you for your attention to this matter.

Best regards,
Shida




> > and if I should now resubmit the cleanup patches?
> >
> > Thanks,
> > Shida
> >
> > > Thanks,
> > > Andreas
> > >
> >
>
