Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E45F873
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248200; cv=none; b=fujq0usAyeKlPXbFtAMOgJGEOJ/Ro17tjYh2iOe4n7c5ZLHVP1scaYlhxaVWoc7yxV2KBL+NL2N0VC9dpNPN6aT2zwhugHwncif1FrGcTVgS09v72rIIryL/LKs3GSxPUfBpOCD+r7xMek75Vtz4peEhamsAg6PRGAG60D+DNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248200; c=relaxed/simple;
	bh=7/yN4Xz3s3wWXcqmPlE+ir5cWbrqDC9lAZ1nU+KMyZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaxcwRIFuhNIvCctP3XdluWzY7a6j3TP1YTBBxjcYZmBH8V1o0d3YKFRTVJ9T6RKnOpNJEeh/OCv5tLfuBCPeNJCYW5HJmXINRnPUHm3eligW0ucX1Ezk8UYE5dJqHhI7LzHmR99YX1w50/5/bOY+0XgfzNTS/hkCk/v+nZpUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb4XzBee; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb4XzBee"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-492a76c0cfbso520094137.0
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722248198; x=1722852998; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCS5MZ9r7gw+RMGRX5IylR1ridcEpqKYpUMo9Tzh9pg=;
        b=Eb4XzBeeHtMkmGZZ7gb+Y1pJKAAUklHpnI4B/v+1zco9T8w3i0kXCmo1KBDTHyNPrf
         MkJ7v4U9cTB/QKCIli3S3xRg039kiErKstPnoqTC7lnklrOk/qiTTF2CRQUXp/qs6CJ5
         R+HPdOvO56SoqQ9kehh53xdDeBat+nMBE4yHGg392HsUyryk1uQ6MgeBdaDz+fvKCF6m
         D7ku0heDpmkwORqYxrpcoRct5N7ij9R0PknxyseUJYdmdgiFK3+TGWFCwfUItkon89xt
         /WegTUtOAuNszU3NLBwG5Mwt/gB+XHV08Kx5v/MyxJpPLAoN+BFacl3rfV4z+vum2b4H
         RGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248198; x=1722852998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCS5MZ9r7gw+RMGRX5IylR1ridcEpqKYpUMo9Tzh9pg=;
        b=G9iJu7bNoVKyTcNohHBYXxNhxNwEcOaWldsKWlqQf6jWNX1qT2WhCCbeHnDrsC7ZbW
         ZpoDz52LjKSzVwSbas/3JoreCp5+LC7wzbo5Dmp3d12RXsMxa/2B6goFY1kJhGX5r5qE
         jXDWU1+vazA5X3T0U7dvA2PlWZgxz0+MfE/iVm+TD+Pbnw1GZ9RnDkgzWqxmQp8zXVq0
         GM15nkZL5ksRPDasUGFy53WvBO7G4K5acx1ldnQH/CfadsBkSpub5SQ5yxnpQEtL+DiY
         51Z6Supm4RFvxhxXU7zeAgZogVqaJ71AIME/h0R8wx2C3yNPaAO+5VIEVrG2UsiXbnLT
         r5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUrI3L91OJfDeGuiMHR32pa/R+Oo1/lxsP/nSqt7PjtTGNsNTHqAnkcgfp5c3+kuQl4H0r5w4wmTlIzTHlehYvAFkuDmd6rurtUoL/SLrQ=
X-Gm-Message-State: AOJu0YwiW9Z+xiK6OVVZexXD0NlDQHL/fnVk0VX3nF3jr0mfcefPEDL4
	xL3dELxxw2fhTnYn53AzjuBIl1eEJRh45NXYrlMZnK1oQxDf2gLikv3o/RlT4HpUv2E1dP1VVzq
	grZBRB0iNVHILDNJi6AFlWxCBPBc=
X-Google-Smtp-Source: AGHT+IF3wvNZe/9pf1Jf7y57v3ZTKTnPux2CX/AUvAurW3DozhKpEMRZkQbAJ+R5o9gAelP5N8894vkHGHuPzM772AA=
X-Received: by 2002:a05:6102:2ac2:b0:493:cb14:ba15 with SMTP id
 ada2fe7eead31-493fa1c9195mr8813445137.16.1722248198265; Mon, 29 Jul 2024
 03:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz> <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka> <ZqEAUbtkIMCwVpgB@infradead.org>
 <ZqECPiU-3fJozzpB@tiehlicka> <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org> <ZqEGAh6R7yoR5L1n@tiehlicka>
 <ZqEHuaUGuuUaL_AY@infradead.org> <5b9fa06a-bcef-447c-899b-fe3fb10315bf@suse.cz>
 <ZqESn11SG7fU4cG-@infradead.org> <CAGsJ_4w5Ypv7qOmibB6g1zw_hdvG-ijsM=QtM8=YiybUqxdh2A@mail.gmail.com>
 <CAGsJ_4zqW=P6gPTtzT5_E-5ry2xQSCKfPNpcvbmApregUofVbw@mail.gmail.com> <c7296bf6-e730-4a75-bf16-825a2dedb3bc@suse.cz>
In-Reply-To: <c7296bf6-e730-4a75-bf16-825a2dedb3bc@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 22:16:27 +1200
Message-ID: <CAGsJ_4zZ=gEiL8R0cCUDfTYoyZcREMVPA+GHfAnU6fWQzp7y=A@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/29/24 11:56 AM, Barry Song wrote:
> > On Thu, Jul 25, 2024 at 1:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Thu, Jul 25, 2024 at 2:41=E2=80=AFAM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> >> >
> >> > On Wed, Jul 24, 2024 at 04:39:11PM +0200, Vlastimil Babka wrote:
> >> > > On 7/24/24 3:55 PM, Christoph Hellwig wrote:
> >> > > > On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
> >> > > >> OK, now it makes more sense ;) I have absolutely no objections =
to
> >> > > >> prefering scoped NO{FS,IO} interfaces of course. And that would=
 indeed
> >> > > >> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives=
.
> >> > > >
> >> > > > Yes.  My proposal would be:
> >> > > >
> >> > > > GFP_NOFAIL without any modifiers it the only valid nofail API.
> >> > >
> >> > > Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more li=
mited one
> >> > > as defined in patch 4/5).
> >> >
> >> > Yes.
> >> >
> >> > > > File systems / drivers can combine =D1=96t with the scoped nofs/=
noio if
> >> > > > needed.
> >> > >
> >> > > Sounds good, how quickly we can convert existing __GFP_NOFAIL user=
s remains
> >> > > to be seen...
> >> >
> >> > I took a quick look at the file system ones and they look pretty eas=
y.  I
> >> > think it would be good to a quick scriped run for everything that do=
es
> >> > GFP_KERNEL | __GFP_NOFAIL right now, and then spend a little time on
> >> > the rest.
> >
> > I assume you mean something as the below?
>
> This would work but looks too much like a workaround to fit with the new
> rules without actually fulfiling the purpose of the scopes. I.e. it's
> possible this allocation is in fact part of a larger NOIO scope that shou=
ld
> be marked accordingly, and not just wrap this single kmalloc.

Absolutely agreed, but the scope needs to be determined on a case-by-case
basis ? The module guys are probably the better people to set the appropria=
te
scope?  It is difficult to assess this solely from the mm perspective.

>
> > diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> > index a4550975c27d..b90ef94b1a09 100644
> > --- a/drivers/md/dm-region-hash.c
> > +++ b/drivers/md/dm-region-hash.c
> > @@ -291,10 +291,13 @@ static void __rh_insert(struct dm_region_hash
> > *rh, struct dm_region *reg)
> >  static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_=
t region)
> >  {
> >         struct dm_region *reg, *nreg;
> > +       int orig_flags;
> >
> >         nreg =3D mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> > +       orig_flags =3D memalloc_noio_save();
> >         if (unlikely(!nreg))
> > -               nreg =3D kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL=
);
> > +               nreg =3D kmalloc(sizeof(*nreg), GFP_NOFAIL);
> > +       memalloc_noio_restore(orig_flags);
> >
> >         nreg->state =3D rh->log->type->in_sync(rh->log, region, 1) ?
> >                       DM_RH_CLEAN : DM_RH_NOSYNC;
>

Thanks
Barry
