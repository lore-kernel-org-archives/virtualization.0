Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835A1B1418
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424138; cv=none; b=ej6Qh7yESKrDpKS6KN3t8trsmDY4w+7/WdQH3NtDlNJRrfYxECN7R8nNbhZlc3DqPLmo4WgJEOrCedTq2bH2j+iruSKYxCmA8ef9uLw3Za5D/if94eaXLN02VnfQe4ug5qdF8TA6gDK606ocPpo/pS1uGhcPm7Ab9x36Pj/bwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424138; c=relaxed/simple;
	bh=9UnkDg0dQtmSlXbVGPJQ3oHjAYouQcrzCA1DiDVeR50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrOKEhkG+GKMw/Ck0KNx9gEYFz3ZVEHhNSHAra0wOIqUdVQLlv2Huwk9iHbO2YX1CoQNGL1haddx/aIu1ChOmYQK94Q3jwLeu5KrvqtYuhTbNE4P1YVFu0YCHJGiRINL30EuX50fkf5ZMujCOY/Kx9GMkNidSp611FUtQHtmtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX5fEZUJ; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX5fEZUJ"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-821b8d887b8so1519737241.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722424135; x=1723028935; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zk+cYfQy3/R+fSl4ijqOgCFd7jf0+0jsTHIqgoyTv8=;
        b=hX5fEZUJLwOHrI05Y4USE49DQjwY9XrUAatoj+Z0YenhmaJ7e2YJKKoGdsKlOtuO+c
         31bygDHODoiEVDIhLtpOcOqI27VYBkKdZPnTFtj6fc+Qu3NNX8cgudJ6UjKSZbuQfIj4
         BB8RQqjFfHAjE1W3+oQAhBe29NfwevJfp8qizAbmy0aIH4+yvPwusuEH6GYLcr2VG45U
         SLhFqi9FujF+zUku3Zw72ya0i/flrk8JdB2dXYjqi2m5DW28URc4ajoOZ/SXOCwtAmo/
         jhlF+UVaHLKQEUfv+I0O5sRXg45BvFzJN/a8Dti7C509ETgLFX+Rmr/tPPBaAwlaI1lR
         yYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424135; x=1723028935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zk+cYfQy3/R+fSl4ijqOgCFd7jf0+0jsTHIqgoyTv8=;
        b=AZF17MsTi5A0gaUzrx34evyiP1epSxYfqOjsLu8bjio3AvHr6WMJ6raW0jRaa8Wvxd
         vA2wJBhGOsYon2hrkhKWcE8jCIH6vVyrU22oeXUFXLGGZIh9sdm5l2suCfeX2VolRumV
         aFBMcFMQt7wUKTRMjZ/2t3k9aakTcysd3a03QPL0c6faD5Nn2W8EamCJOorcIJ9hXsAj
         A7mD+NTgIONVgRHg/f9zPsM/EZ0C98BhFnxnSCT5WE2teshmS3Tyy5s03zHV5xHreuuI
         zRixpyGWJr87fuHmJPXvanus4FkhhjOEA6S8wKqsOuno+L73tJoIfFeZ7QFqUoRj2H0D
         sx1A==
X-Forwarded-Encrypted: i=1; AJvYcCWZAY75oKel3Q80WAQHFP7CZblsuPQkDAq6XwJmGFaHXQ0YDFr3ErWNuhUkLHLv8/PPzjUp+lsqtlLiISomk5F3L/+6Wjo2mJ+NGBuSqHc=
X-Gm-Message-State: AOJu0YxNgPmm3bFm2CIEmE4gptg90XdkSgqbfqqcaKNM29HEuneiQbMa
	wsVhb9qvBtNHu2w28CYynJMVdnSes5FOkuPWHwNeXWqrz2jZOIX07ng841D5AZq6n+8ckwkRm+m
	RZH8ieiiqIQVp8CHUEiy8YNpQAWcUax8AZg4=
X-Google-Smtp-Source: AGHT+IFx//wnEVQXnfiGegpRRqukUM3xN1R0pbdxyTIOXbkqjXkzWbl45gqbN6xoDEdxHdqqxxslJLvapfxTJK9qfp0=
X-Received: by 2002:a05:6122:210f:b0:4eb:39c9:c935 with SMTP id
 71dfb90a1353d-4f6e6989ff8mr10127941e0c.14.1722424135422; Wed, 31 Jul 2024
 04:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-5-21cnbao@gmail.com>
 <19981556-cecd-4f58-8b3b-bc3bb85a6ac4@suse.cz>
In-Reply-To: <19981556-cecd-4f58-8b3b-bc3bb85a6ac4@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 19:08:44 +0800
Message-ID: <CAGsJ_4xnRCMAQLPb5XAYPL3NHA7K4firyWL_yseT+-a8Kz5OZw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	Kees Cook <kees@kernel.org>, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:55=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/31/24 2:01 AM, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When users allocate memory with the __GFP_NOFAIL flag, they might
> > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc. This kind
> > of non-blockable __GFP_NOFAIL is not supported and is pointless. If
> > we attempt and still fail to allocate memory for these users, we have
> > two choices:
> >
> >     1. We could busy-loop and hope that some other direct reclamation o=
r
> >     kswapd rescues the current process. However, this is unreliable
> >     and could ultimately lead to hard or soft lockups, which might not
> >     be well supported by some architectures.
> >
> >     2. We could use BUG_ON to trigger a reliable system crash, avoiding
> >     exposing NULL dereference.
> >
> > This patch chooses the second option because the first is unreliable. E=
ven
> > if the process incorrectly using __GFP_NOFAIL is sometimes rescued, the
> > long latency might be unacceptable, especially considering that misusin=
g
> > GFP_ATOMIC and __GFP_NOFAIL is likely to occur in atomic contexts with
> > strict timing requirements.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/page_alloc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cc179c3e68df..ed1bd8f595bd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4439,11 +4439,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned=
 int order,
> >        */
> >       if (gfp_mask & __GFP_NOFAIL) {
> >               /*
> > -              * All existing users of the __GFP_NOFAIL are blockable, =
so warn
> > -              * of any new users that actually require GFP_NOWAIT
> > +              * All existing users of the __GFP_NOFAIL are blockable
> > +              * otherwise we introduce a busy loop with inside the pag=
e
> > +              * allocator from non-sleepable contexts
> >                */
> > -             if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > -                     goto fail;
> > +             BUG_ON(!can_direct_reclaim);
>
> We might get more useful output if here we did just "if
> (!can_direct_reclaim) goto fail; and let warn_alloc() print it, and then
> there would be a BUG_ON(gfp_mask & __GFP_NOFAIL)?
> Additionally we could mask out __GFP_NOWARN from gfp_mask before the goto=
,
> as a __GFP_NOWARN would suppress the output in a non-recoverable situatio=
n
> so it would be wrong.

If we use BUG_ON, it seems like we don't need to do anything else, as the B=
UG_ON
report gives developers all the information they need. If we go with
approach 1=E2=80=94doing
a busy loop until rescued or a lockup occurs=E2=80=94I agree it might be
better to add more
warnings.

>
> >
> >               /*
> >                * PF_MEMALLOC request from this context is rather bizarr=
e
> > @@ -4474,7 +4474,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
> >               cond_resched();
> >               goto retry;
> >       }
> > -fail:
> > +
> >       warn_alloc(gfp_mask, ac->nodemask,
> >                       "page allocation failure: order:%u", order);
> >  got_pg:
>
