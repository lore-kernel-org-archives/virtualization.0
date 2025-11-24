Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC21F1513
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949682; cv=none; b=I/kYnJVkgvAFj8rmnrdvt7gNsEwejOvGBS4IaOwnAeu3xtWUlfD2hWXVKQ0I7OrCccQuEN/MZRlcpRO0/Cpd9CLCCBStvv5EzsmtFYa2327XJ3J2r9pU/TlRdZ5zXsdd8adJDQipugcQpXKk3ey/tfuGyIhWetMdwTOm7Pvhotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949682; c=relaxed/simple;
	bh=+3kr6H4DmPEksHjU6g1IKbfBmlyqFl0Wz9vrA013Ppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOm1qzyDFC01ymITN3LxGL17QAUbXBQW2I8Oft5ThsPg7M+MewU//BnII3PS5UfTLTB3uXeyCks6aqXFVz1yRV3wSBLpefNHrS2kEg8j7GrPcnqn9r8eiHpr/iIZ13WVVQcoKAoyCmD0WIGHJjloTb10S+n3Zcu2FtfQY6RJq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4gTmPPB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4gTmPPB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2d32b9777so517011685a.2
        for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763949679; x=1764554479; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rihsM/MbquITk52HblBTEqieTE9a8UregXTIhN3Xc4g=;
        b=M4gTmPPBwZEnPtqmaF3v+PXABiwWCW3NRcSNBLCe5bkDH76jy6UBKWmlTRmzSmD370
         WKTB6MwrQy4Ic9YI1EkcMRSJ1Pl7gxdHryTX7hasVCBP0sN21CkzuNS8nEPwiVSVk4sS
         Xz4ZMA3LJwAHy85NfK+r2mmqkBgWjSBfeGHBQOc+JkEqEbjzkhkeSoESO62np6zjHEB6
         g1g7zsWNBKi6JAJ4OVOoXxyD0rCJ2ZtGF5qafPDXNfzb7sT+6X/LcG6mZTRBKZR4si7f
         QuRQy1ZDGCBhcPpBPbV8+HCtX1OflG1P2QEqlUVWS7j37tm1zoSxE4jN7dPxmHbaL64w
         dbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763949679; x=1764554479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rihsM/MbquITk52HblBTEqieTE9a8UregXTIhN3Xc4g=;
        b=XcYm7l8m+B1MCAyo1EdGeZMjgUofibpHKr+mnOIt/fstht2Tir4gehuQ43v65C7PED
         T44wh5JXFR2qp5vCSebrsoG3Ykkb+mbJ6xF8mG8aMT2IwoZnpnaGJle3ds1VTzMKUrPg
         3STwivvs7HnjB+4I4WJLrB8KE2Nlp4FXnwuHNsx0EnUHWJ+L+Be/jufUGxw6Qrrn4kgW
         baV8u8ySeMYsLdtoFQ+QEI3acZc1ANejGTVGgPTLxwiKInQUl3LsymZKWWW+hI2pWbKQ
         m9HxGu6SY0aiDxTo4x4TKN3Vtej22gHhc8lNWzM2i/weTw1N5kv7bC6Ifl2DXKt1fjy2
         B6uw==
X-Forwarded-Encrypted: i=1; AJvYcCU/p5ouoGKU4hY5JJZZQ0HUJDqmPyZgsk4267+VECNoaW2LcJGVAwPp6KewyX9FW10nKcgdzejSHs9KuGtkgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf1PCMKSFUdIKiozhApPcOnFEqELjJ9a43I1KDrV6ZYdagMGwe
	nmmIXOkmYhSTeraAg9TzcBbTWrG75ukoa/PYgfaI2uEMnAfuCFIDiCrHcMMf2MEnb9J9ydOIr6M
	wj0YMIyD/bQ85Hdbuz0NxydsachA32/s=
X-Gm-Gg: ASbGnctBqaCj2cs40RFGpgSIw+YzQK639Lp+8MuTGuxbNpao/642RIw2GYPlpzyWnLx
	JrR4+LDNaZzeCqy6xh+1w2YW1tJWaQd/NjPzWBFX2xUroNW8IuciEziM/Pdih/2euo3V82wZkrt
	QAKLUSUtOfys4+T62BJquUUQpMuR0nkV4POPT2B1DFHU1R5TgDgjOYM+sIPl+jEb/MWYtY/FyjL
	Astg8SgvLoFx90BtId/coNPlvfe+9btyF6OtjIuzhwNTEdM4mE+VE91UL99AvB7ruY+/Fg=
X-Google-Smtp-Source: AGHT+IFK0j8LOMDrS9m/1v8ASo3ky7d0+WiDpTykg8BeSrWtC+6aSCAuT2UVyteglGE8TJ8JAm0pjMBxqVbt9nw2ETI=
X-Received: by 2002:a05:620a:4415:b0:85b:8a42:eff9 with SMTP id
 af79cd13be357-8b33d4a706fmr1352114785a.53.1763949678764; Sun, 23 Nov 2025
 18:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
 <aSMQyCJrqbIromUd@fedora> <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
In-Reply-To: <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 24 Nov 2025 10:00:42 +0800
X-Gm-Features: AWmQ_blmSEmZQDursBh3YUhqjicM04mA6N_YKxn2rH4yPFBEnFOKPn_NEARJprU
Message-ID: <CANubcdUG_3VwagV-cSfhp4+95Dj_e-wkxegzCdmuNieWqrehug@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=B8=80 09:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8823=E6=97=
=A5=E5=91=A8=E6=97=A5 21:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> > > On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > > > static void bio_chain_endio(struct bio *bio)
> > > > > {
> > > > >         bio_endio(__bio_chain_endio(bio));
> > > > > }
> > > >
> > > > bio_chain_endio() never gets called really, which can be thought as=
 `flag`,
> > >
> > > That's probably where this stops being relevant for the problem
> > > reported by Stephen Zhang.
> > >
> > > > and it should have been defined as `WARN_ON_ONCE(1);` for not confu=
sing people.
> > >
> > > But shouldn't bio_chain_endio() still be fixed to do the right thing
> > > if called directly, or alternatively, just BUG()? Warning and still
> > > doing the wrong thing seems a bit bizarre.
> >
> > IMO calling ->bi_end_io() directly shouldn't be encouraged.
> >
> > The only in-tree direct call user could be bcache, so is this reported
> > issue triggered on bcache?
> >

I need to confirm the details later. However, let's assume our analysis pro=
vides
a theoretical model that explains all the observed phenomena without any
inconsistencies. Furthermore, we have a real-world problem that exhibits al=
l
these same phenomena exactly.

In such a scenario, the chances that our analysis is incorrect are very low=
.

Even if bcache is not part of the running configuration, our later invetiga=
tion
will revolve around that analysis.

Therefore, what I want to explore further is: does this analysis can
really hold up
and perfectly explain everything without inconsistencies, assuming we can
introduce as much complex runtime configuration as possible?

Thanks,
Shida

> > If bcache can't call bio_endio(), I think it is fine to fix
> > bio_chain_endio().
> >
> > >
> > > I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> > > erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> > > are at least confusing.
> >
> > All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involv=
ed
> > in erofs code base.
> >
>
> Okay, will add that.
>
> Thanks,
> Shida
>
> >
> > Thanks,
> > Ming
> >
