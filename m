Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BAD28373
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059557; cv=none; b=NbFoLvbtMvfyP//HvZde5ZgfPNGaDFBT+yWsd6LK6AIFAFGEzdLBEi2ui27HJvepk6B3KxBd52CM8vWHWvnQzC21I7mr+2b7Rp3yBmVjT1p7bSIV7IDUCdicKBoYxzrPPK3s4ivCSv9ToIhDiy+A+euKhUHq1Mg9gpHMTlTcCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059557; c=relaxed/simple;
	bh=QLGW9AawKts67r76CKMYfT5fw5bAenseYDlkziryj5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfjB7AUmNH1l7hfzkfAso8cSKsuR+DhbSISEP+3mlLVhKkTT3yGQ6VO7Gd9ad3H7plqT5oSE/7WwiNkpY9XP/m7C8WRgfca5JU51fyOasL+/f9qeG8zzMW2wLw1goNsP2QebPJJffwy0agQmoB6qmBVP4aRLV9n6IcBvhaqEQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa4HSqsd; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa4HSqsd"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4503ccbc218so43800731cf.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724059555; x=1724664355; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjR5pvDEpewPhW0X2X4sJsK88Su+PeH05ej1TNllwx0=;
        b=Qa4HSqsdRh4lgtCZVIG0zDhHokwMG+XzphNaBwF8D7Un8FOTpzm2hajwcbmzgT2pA9
         9+xePw0Dw4N4d9rPyowEFOj8T1hls6sfag8WcVlnxqfn4jUCQt80ckO0+8AyrTfVJL+r
         jYLY308kv/A8sbWavAXW6+XkqrTeLHVHoGIAG80Fugvd+/m2wetvO7wjdDJyzJf0Ibz5
         ECXvofwRz2jxhx3+kDXSNSDyTsHFw+YXFf9FEyuf+y+LIFzW2WbUR3D1q6/6JcgaBgPV
         8NkVVU2SqBjn4t3skoE+QVIiZkNSntByZfUzv8vsdv2LaTvjhLNXhOB9G2YS+4mnKH0P
         f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059555; x=1724664355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjR5pvDEpewPhW0X2X4sJsK88Su+PeH05ej1TNllwx0=;
        b=Uu9UPzU05KJb9UodSuKIsJbO0lk2odjnErHBHHzVXi7W2aqAH+yZkZP7FzklaxDfp7
         drv3p1cjKbAFAXJtOazyzsgb6aCmzgZn6Q8cKxQj3Ejo/HJtLn/Yn+GDPFiEEEnGGBsf
         aPWiVaAaXx7jAo/bsBvAU6XbKBKo10lKoqz5eGIScqI+8x+oXaaUrwRSY4zKMyueBShY
         4WYCWLInTfQ0DZkFx1P1J85Iw97HFoe6VNMBdM0MnymT6ynAEjCc38YGpt6TAXcvUnZ9
         dy1D9vc+0ww6VyU21lfJvVoMev9d4+bZnPFxVSc0TyKllMAhFevTNoxC9bPmFiZqdvFy
         cLVA==
X-Forwarded-Encrypted: i=1; AJvYcCUzRzBy1LeUqZQxo/Xu8qnk6v5L4OC3oSAb8QHH2jjOt22SgcVNbK55U2N5MBcRW6OJ/5It8BxGgCzNwsnrDDxNWvm2or5XcaAau/v/z3Y=
X-Gm-Message-State: AOJu0YwJB4pbv/T571V6Cs6E9fp2hrQ0CVYedshaGdlwQavUp/28KapQ
	uWNwPAZpkxan04ayNAECXFqt+RuoNjwA8vCiFJ1WeZEl3ZTOcVoc89CKNxpxfllRqvrh0U6M32B
	oy7RFYq4YTxAQUwnh/uGl9VNYAQk=
X-Google-Smtp-Source: AGHT+IHPX+AJBoChDZNdzQo1/ybCnjZBukhX7o88gEryvgpmzCLvhwLFJKnkwMrSIRJ0gr1ssNKoTOMaLGzCjtkY7VE=
X-Received: by 2002:a05:6214:2026:b0:6b5:d90d:ea4f with SMTP id
 6a1803df08f44-6bf6ddd2a8dmr275047936d6.15.1724059554759; Mon, 19 Aug 2024
 02:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com> <ZsL5LSK8R3B1HsR1@tiehlicka>
In-Reply-To: <ZsL5LSK8R3B1HsR1@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Aug 2024 17:25:18 +0800
Message-ID: <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind =
of
> > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > > attempt and still fail to allocate memory for these users, we have tw=
o
> > > choices:
> > >
> > >     1. We could busy-loop and hope that some other direct reclamation=
 or
> > >     kswapd rescues the current process. However, this is unreliable
> > >     and could ultimately lead to hard or soft lockups,
> >
> > That can occur even if we set both __GFP_NOFAIL and
> > __GFP_DIRECT_RECLAIM, right?
>
> No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a long
> time to satisfy the allocation but it will reclaim to get the memory, it
> will sleep if necessary and it will will trigger OOM killer if there is
> no other option. __GFP_DIRECT_RECLAIM is a completely different story
> than without it which means _no_sleeping_ is allowed and therefore only
> a busy loop waiting for the allocation to proceed is allowed.

That could be a livelock.
From the user's perspective, there's no noticeable difference between
a livelock, soft lockup, or hard lockup.

>
> > So, I don't believe the issue is related
> > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > design of __GFP_NOFAIL itself.
>
> Care to elaborate?

I've read the documentation explaining why the busy loop is embedded
within the page allocation process instead of letting users implement
it based on their needs. However, the complexity and numerous issues
suggest that this design might be fundamentally flawed.

--
Regards
Yafang
