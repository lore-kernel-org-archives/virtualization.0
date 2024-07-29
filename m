Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4E1428FE
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247029; cv=none; b=f6aFhTxc+4HWNAb7sdvvN/pnTYVefVGktRVnFhW2DKDaHUp3CUjOaCxu06ApPNS/1WZMu9UfGENyeUCXXTDZcXaHprXrHXutgn/dAEasj6Epp3GfIciBNHq9w35DQ7lBvJtna+Q4Cfie9edfSXIY89vPn8kzy3z0d5t3hGtss9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247029; c=relaxed/simple;
	bh=A7eWnbfXGTl1KlFHy2G42hxeBgGVyPevrXi2EarTDg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqAK2c7KZioWcXrxIRT5JwC5mrYFb3ekbS9etPmFluvF8J2JD7kunwSa6MPbUk2Lm7X7CYF1kKsDHqJQGVtQuzEK6blbQYt059bQ1pM7Rv9+MKPXWVgOwXBW7QKZrw1ypZkE6QZCiIXvx2KCm0ADmR7QRyN4EJsqrvhqI1vVZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCFpNER1; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCFpNER1"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49297fca3c2so579969137.1
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722247026; x=1722851826; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzU93lQ9FAwpzZ+7J4zdxDrvnFfiQFQdWcvlDlZf8z8=;
        b=dCFpNER1Ygj2jH7CMn/FtSXyQQ7Bwmb3L/PPl0v/SSWXL6kvLkiP1lCm9Qo+V5VgCR
         npNB8XCMRZyhRhqdLT5fu1FFGz3Uby4C6QEj1QqnfGY5RFeGbQoGiJTdFBL4tIDxh/8p
         JZSY2ZBTPhfBh3sUJGAg6l9fQ4nma2dCqdQjaSO5Tdh8XJ4QUK6s2RHcQwIA8vATKhW1
         rHIPQROj8ciTEGoFdhlbKNA8T84e52tTMHZW9oA7QTIRqnfEOqXr9OXeg62KtlK8/zcG
         ekPodLXksUVxDeeVv2VhHQn3APSeYr+aCLrxc9HgCOzbSZQP33e5KZGqbXcM21FbG2qM
         Pu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722247026; x=1722851826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzU93lQ9FAwpzZ+7J4zdxDrvnFfiQFQdWcvlDlZf8z8=;
        b=GnWJAk7FySHe1MgaTa/NUQVAdA6F5qZIEgdL8JH6TVcLsptOeLSbyozZiGu6XxcdU5
         xe7CnWflLcu/xSm/QBRH5EN0t8KAHM7YZAd65VLVVHxfv4aT95VKs2sV4Nr9GGkVFIu0
         PbQ0zRGxOgq8cFXYh573rGgPSwPqGC2K5dgG9T9Jk5TnPvluo6hSfsCU1A74XeNJqMdS
         6j731Hmel+KsVceXs+O+iZURgy7wppXUBbpK3tem1T1QVA5CqqXZISOUqGhdux7bQMuc
         IOhymPhRtPjJpU2haypInoEx2BUu6wT6Y8ZonVJnr/MOWKRHNJd2SllpE0+zhUra00OY
         1m3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+JbmOqjc6AjV3mX32X7/5PKJbtESSjkQ3X2Z/I8CwBxDy7GTVCDLkCctv9apZYaQuCQ/ThMycyZxlqyD6+NCxfHPqnVVtJU/vwx+kqNs=
X-Gm-Message-State: AOJu0YwN1IbVfDS0q8SmTxD70imE4qo0nBZwELpCZTvkcFMP6DHkY1K/
	M/QSPjjHK1equMHF/J5OAupXHQDaQzAE1aDxHaEJWuM0Lri0kNZnok3bdy1EUiBJl2ml6sob7Rp
	3vFrP2plRg5aYBFmk70/F16c6q3c=
X-Google-Smtp-Source: AGHT+IHccuHFy05pU/JKx3gRIyZrGS2DgXoads5elgRjnIOEgRwTZvjj+/SANGJyL3jI7JJ+xzMsaQ0XB+LZ0UsbTH0=
X-Received: by 2002:a05:6102:3048:b0:493:e1ba:123b with SMTP id
 ada2fe7eead31-493faa8c6bbmr7987835137.16.1722247026292; Mon, 29 Jul 2024
 02:57:06 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4w5Ypv7qOmibB6g1zw_hdvG-ijsM=QtM8=YiybUqxdh2A@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 21:56:55 +1200
Message-ID: <CAGsJ_4zqW=P6gPTtzT5_E-5ry2xQSCKfPNpcvbmApregUofVbw@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
To: Christoph Hellwig <hch@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 1:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Jul 25, 2024 at 2:41=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Wed, Jul 24, 2024 at 04:39:11PM +0200, Vlastimil Babka wrote:
> > > On 7/24/24 3:55 PM, Christoph Hellwig wrote:
> > > > On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
> > > >> OK, now it makes more sense ;) I have absolutely no objections to
> > > >> prefering scoped NO{FS,IO} interfaces of course. And that would in=
deed
> > > >> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.
> > > >
> > > > Yes.  My proposal would be:
> > > >
> > > > GFP_NOFAIL without any modifiers it the only valid nofail API.
> > >
> > > Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more limit=
ed one
> > > as defined in patch 4/5).
> >
> > Yes.
> >
> > > > File systems / drivers can combine =D1=96t with the scoped nofs/noi=
o if
> > > > needed.
> > >
> > > Sounds good, how quickly we can convert existing __GFP_NOFAIL users r=
emains
> > > to be seen...
> >
> > I took a quick look at the file system ones and they look pretty easy. =
 I
> > think it would be good to a quick scriped run for everything that does
> > GFP_KERNEL | __GFP_NOFAIL right now, and then spend a little time on
> > the rest.

I assume you mean something as the below?

diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index a4550975c27d..b90ef94b1a09 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -291,10 +291,13 @@ static void __rh_insert(struct dm_region_hash
*rh, struct dm_region *reg)
 static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t re=
gion)
 {
        struct dm_region *reg, *nreg;
+       int orig_flags;

        nreg =3D mempool_alloc(&rh->region_pool, GFP_ATOMIC);
+       orig_flags =3D memalloc_noio_save();
        if (unlikely(!nreg))
-               nreg =3D kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
+               nreg =3D kmalloc(sizeof(*nreg), GFP_NOFAIL);
+       memalloc_noio_restore(orig_flags);

        nreg->state =3D rh->log->type->in_sync(rh->log, region, 1) ?
                      DM_RH_CLEAN : DM_RH_NOSYNC;
