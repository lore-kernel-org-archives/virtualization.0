Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03924428
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872089; cv=none; b=YA5mN2yAFQW0xHB+Omm09DbU0yt+KSZll57XuHJ2lsaSolZ+hZttftQ30IDlFQB65Eyk7uN6USTSppt6bfRWiPOCdiMlqbT/lJaOWl4jNNWOhOZCMIzzqumRTQ3563jLv2G8yImLeT6uUnfI7Ieb3jAXIIIbROIFieQgE6XXi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872089; c=relaxed/simple;
	bh=B8xp3+J6xrbP/tZsnqybxDghfPgRpEyQmdf9V68w96g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etbNGoctvpi4Ja8Hg3p1Lw/pU8rDp2LwlI5tVerKJJSaPzq7Rz1bpy3RGT+0EoOq8lXD+/sf2TmQGHnv6rAEV+58G/AnJ0Vd+YmEBTmJ+qqoPq2/cEnPdmwreSd5aZGwDJawh23XkoqqTrv+fLrc7AN/Lte7WePmng6oJnr/gCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Waechwc7; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waechwc7"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-83120879efcso115367241.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 18:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721872086; x=1722476886; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TISFjCqvandFb9l351oDaL6jIFz+5C7OojJnJeVMoXE=;
        b=Waechwc78VI387R7ObLdM4NwenZd8T+92/cCuAG8iqgGeBBgTRWUjo5GLvCYyfJdNR
         9Z2oI/sLqM+DM6LM0AEiaR0Csq8EtgYQgPEW4GTrLWYl/hsLyfhB7vB4Aad1JCvjfCEu
         vuD7cJLK1pOPFdt3i8Fo/J6q99/F6z5/C0rBXVVtkaPxCN1jvDfjX0eXYSjys2PJpV3u
         IgqaIe7wL0+U8xSgjMkpHOlOxT2V/ysI8fww/BsAFTYlr3JJmOrN7sEmsbzH05UQsi2Y
         0FJdZ5auBG+otGM4Ed0dMZqMGUo2bfNzIMG0kaJDOEwnCbgBt+koK/jmQGpZhMFheSTQ
         498g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721872086; x=1722476886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TISFjCqvandFb9l351oDaL6jIFz+5C7OojJnJeVMoXE=;
        b=BbLftRj8vzHxCvGyLDfcFIZEkEjG1F9Aq17fG0I0Z0NlxoV3e/Dnj9EbiUeUZoE6Ev
         AUFmgy9mjsqPj41kO7TIm5rRfRmrqOop1f9uzKguxtd4i3kPJINas3QFpfVw2CrtgJFS
         O+3PQRSPXZubPsB7VTdf7kpDb3mpzj+sPlrXXKAxNQOcqQNX8gC2OWFTNUgKo0ruZYGB
         j03PfoxKq883ZhDp1g2B0nD+t+fmA5qNhHE4SyljvDAy0Lc+SugXXS7yFwHmkvipLs1G
         pVJGsBEFaIzBDD/WzMqisFhUyE1yotDqXKmeURJx7/kbfpX37oeHJqduiZ3VDjqbZGGq
         n1wA==
X-Forwarded-Encrypted: i=1; AJvYcCW5NeGjOqZuRasrIJGoWulHvM4X1GQY9Yq0p49ktpVt45mGczCNK0W1vAjsZQ46D/mZ29wduBFcBN6LdW/RAwPDN/MPwOYMxDc1euJlJdM=
X-Gm-Message-State: AOJu0YxKP7e+XYsbogY3MMX+CjhLDML5b2xBwsCMh0bsZreWF2gGH90V
	7FbPXEvyRUuO7A02F9RZrkkbrfGSXKEUa/ctuTPkS0XvoSk8v7VrnZlcX3DmvhDrPFQBgTZt1i6
	7E608BWP2QWEB/Pq9lY29UDrfK+8=
X-Google-Smtp-Source: AGHT+IGnt0v7dMKqRjnb6iJ80FuPWryyNCKzTEWXwsAqV0zENb8OwCcXTOgpXmDrXJOFxglPQy21A45C0sscYDe+Qck=
X-Received: by 2002:a05:6102:160f:b0:48f:96a8:fa33 with SMTP id
 ada2fe7eead31-493d63d3448mr1688152137.11.1721872085752; Wed, 24 Jul 2024
 18:48:05 -0700 (PDT)
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
 <ZqESn11SG7fU4cG-@infradead.org>
In-Reply-To: <ZqESn11SG7fU4cG-@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 13:47:54 +1200
Message-ID: <CAGsJ_4w5Ypv7qOmibB6g1zw_hdvG-ijsM=QtM8=YiybUqxdh2A@mail.gmail.com>
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

On Thu, Jul 25, 2024 at 2:41=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Jul 24, 2024 at 04:39:11PM +0200, Vlastimil Babka wrote:
> > On 7/24/24 3:55 PM, Christoph Hellwig wrote:
> > > On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
> > >> OK, now it makes more sense ;) I have absolutely no objections to
> > >> prefering scoped NO{FS,IO} interfaces of course. And that would inde=
ed
> > >> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.
> > >
> > > Yes.  My proposal would be:
> > >
> > > GFP_NOFAIL without any modifiers it the only valid nofail API.
> >
> > Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more limited=
 one
> > as defined in patch 4/5).
>
> Yes.
>
> > > File systems / drivers can combine =D1=96t with the scoped nofs/noio =
if
> > > needed.
> >
> > Sounds good, how quickly we can convert existing __GFP_NOFAIL users rem=
ains
> > to be seen...
>
> I took a quick look at the file system ones and they look pretty easy.  I
> think it would be good to a quick scriped run for everything that does
> GFP_KERNEL | __GFP_NOFAIL right now, and then spend a little time on
> the rest.

I am not quite sure I have understood you, could you please provide a
concrete example,
for example, for the below case?

drivers/md/dm-region-hash.c:            nreg =3D kmalloc(sizeof(*nreg),
GFP_NOIO | __GFP_NOFAIL);

how are you going to drop the __GFP_IO | __GFP_FS bits while
GFP_NOFAIL =3D GFP_KERNEL | __GFP_NOFAIL?

And for those cases in which we don't even know GFP_NOIO/GFP_NOFS
is there since gfp is a variable?

gfp |=3D __GFP_NOFAIL ?
