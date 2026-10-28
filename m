Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202008;
	b=uwyM2AyL3pVEB3mN8AjQvlkQED6e9yOV+D/l/6M99Coha6Iyvn9/h+L6cv8aB/j8uHDp
	 R0XF/kiL+R6EZcOE5NtH5P2fy54RzTg5+FdTctePFxWIYGuq+zVJ9yD7ZMSvreI3fXzTR
	 EWldkvzXzxPnHdd5e5ZveihF/4HfXM/ZJBk6s9miMiOAY/9Uq+1CpNKNVzlqI0TTyhRXr
	 eD2q9rHQ697o5JqbhD1ypsx3Agvje3q8BBCnFaKU/5UQlLCWUUhNMeF3TKiikl+32XXB8
	 LSxMEVyyO1SoKTzMLcKdyo7ajNp+fTjVVR9ingXLuol71vXZhmxKDjLt3M8R9ja1JJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0L3UJe+6XjER+KzlgRD/7xotzxSyGvuQzLO/yjOCn+Q=;
	b=ZPkuXKtZCmuxY5P75Ay9m6Uz8TOPb6vX5/aCMAsVDY+/Gu08jF4aAgRQd61mHjzkw+Yk
	 YBe+L9HcrunEeAY1Gl7EVm+QYMUAq4Je0fKyqxbmfcPwTeF8WIbZYNiOUzU2md/1+Dcsf
	 3h1+ocYpnWpaGm+VkOpjgTEmkWr4sIJ4ehIfnZUrv70t+KNAfoKL3RttqKq+XlLotb7px
	 fLFdPkGzRVUiWggzkayuH+fG9r+CMtS1jSKvgymT4Pemh8PK9eXdCCmoUdLKlGUHrm1Zv
	 v3pdF1ATWfBk6ZKkBN2uuRYGIVAFiVgYstJTlke3fcUzK9Lek18HTYhNzb1CKVbP2IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B+Uj2jxJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4C606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA4C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B+Uj2jxJ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso172427966b.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 08:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202006; cv=none;
        d=google.com; s=arc-20260327;
        b=K9SoW851ND0v8xTwLs/6iuOZb8KTurJgYk1vVko3T/fiQL0rbosGQkda2y8ZW7cI8+
         X3DU1+przbeis/jhXjDHBAJu2FbEkrKj4RPJ2LiImgwQJZTssIJ/kGkxKVK74dPkAYor
         YCM2mfpGzBto5smnGtJo5L7w7aU9cYxyva5WH04IxF/d5c6GB6AAFp3wLIMGC8NDB8F6
         +Ai87runIphahe/ZH64WNBkAft/Y9DsDjm42+Pi5jw248lCQ6tRitEXae9SJffuUXXIa
         1M8vNMuaiPFqwSt5d4q0RNz3aIYysKVwPTEc7qijeDlCBlVsrZG66NSkflDPB7e+5l9X
         mEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0L3UJe+6XjER+KzlgRD/7xotzxSyGvuQzLO/yjOCn+Q=;
        fh=upq7kful+4FyfBYA5U1Zg2v0Injs0tFegr01qIRG1o0=;
        b=OV4KSfDycMDqcRmYfO7X2iT7AD6onhW4VBirC1Okuo5I8rwLHWdPfJOptmB2yG7X+W
         EKxgCllzhuiv5iHGWnlndJ3qabnwBY24gcbIQBFz6M93qZyD2uqXBEpI1kwadWzQqwY0
         z3/l/a/JvSrgni8Eq1dBCSiABW3kqWHY58hoIDXwRlLaPfk6RLqFv5K5fKuMkOaofp96
         zm3Kofkro/YVhRr4XwSL8Vsq7vHFnEzSf77yg6jCQ0Xrr7TRKrxTal2/n6dS7Wvrilcz
         TBH+Gj1UfGkFHqVrFJmHravGeoOYKgE+y8EWRfzPu9PiZ4NpN2342Y1wVFYJ+4kebjt5
         ABBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793202006; x=1793806806; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0L3UJe+6XjER+KzlgRD/7xotzxSyGvuQzLO/yjOCn+Q=;
        b=B+Uj2jxJSJ8CknYYFVI0jCysTuf3YExrOhBc+gN4vatjrQDJqil9Mq7z41jeqSPSlD
         9ha20TMB160wRmDuP1V12/jKxr8aV8B9sHL95eoikwOdhZ4h4YjGwFXD1S7S2nz/7Nys
         3JVaPkPGn8WZvjq1vqz1gDcSjihMfzqabRjNmO4qo0D8C13n4qIy+s96SGTIDmZtkvDr
         NiAsjyKkKLweOxDFNCDoMG95XxU5Vam+ZVacRKMEd04Zfrc6ofsD31wUB4ZLzWEMO60T
         VTNb3z1+5TW8Va7QF0MVo0Jwlmg+hRv/kW0d399K8ubZdJbmNpcx6IaQiOTySL9GUhRU
         HwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202006; x=1793806806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L3UJe+6XjER+KzlgRD/7xotzxSyGvuQzLO/yjOCn+Q=;
        b=R9DKjbl6To0b35CbNGbczlhTVJnHRve5cu2+H9vMGLqGpi6sgBrrJnKtd1cZvVL0+U
         gUwgJgiQ1GZCceJDlRCzrM46dCf5iBqXis60+t+vtbC8C1zrthUpo4JDSsBgC0lwKKfl
         cQkSEwt0xZrfKNJBTaDnR6KH1guuhnGv0kz0Y74j89HZJdM3YVpq1jY6udTUP2xN5pMv
         e1qeM9WHpY+wdVoUxjmwr5MPvzS8WFOzwIKDvf5BSdiHibn8D/207YMC8kvTyi70TmH9
         19dtVEvqh+LBedfzvZW5kf8oX3LcAw+tdfcNONEk31K4sbaCeZfyi5etSjP4cmhVDibJ
         NZNA==
X-Forwarded-Encrypted: i=1; AKwUvBx81atZgN8PhzyQ0PYb9F7UUPuWDCPLBorTiBMiP7X0OrdWLCB15NaKrCZ8rrrUeTViA71lx1IQcn2XhEHLKQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKVB8wZrlTJX6dcAEY1BKP3oJY6gU9wIrcc1KcjlCsgL6d1geOt
	Q+rmH6fGi0Z2wPtBaCP5gUdHQckAocpoOrnsHTy/j6nc6Rd1MAkIShWd+NxV8j9cy7c5/TM1v18
	w23ODWUpgBbZNabvS7XNMVMP9x05I/l/q32WCp3Jf
X-Gm-Gg: AYBFou13DSZCCz71rxczzJMCOsx2ZQywmp/ul9W10csErh0HN/f64hz5OdlYXpPNIKe
	+xyQQ7SDepuZh3CypwRbeQOfzkfKEKroADVUprix6ujED8nFvZnFHh+6pI/CrHZLUyF73JUy5T7
	rY9s3wpSQapFErXzNA9RsNXhObL2zvSc/iWxPPBuyuXI2+hiAz0yugKcKmYBkJP1Qsp+DPcukK1
	AmxiHSUvE1OOd+GbSM8hyrYEiDNDHhShfjJkjwoVhnunIIbsfkKDJXUgbSuYBcUMKVfTlqaiU9V
	+tZZJ6WqmYjEyWCRMS6xRVmtYZwnQZyx1m8MkDMsessAXe0s2H7uhwL3dGRZISd5Lt82cHUdi0g
	V/gDz7fBfAeKmBHj77bcUO3Ir5d2TbPR3NqazlVaJ9HBhjL962GawrKj1GW68b5ihmw==
X-Received: by 2002:a17:906:9f86:b0:c41:960c:8c62 with SMTP id
 a640c23a62f3a-c49bdfecbf3mr243566066b.30.1793202005586; Wed, 28 Oct 2026
 08:40:05 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <20261027025616.1632690-11-kevinloughlin@google.com> <20261027052057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261027052057-mutt-send-email-mst@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 08:39:50 -0700
X-Gm-Features: AclHuK_MLzRdQo76ylDi6PC5wwAQyJcXzBectQ_iPw892kOlvxApU7OSZmy7jAE
Message-ID: <CAGdbjmJjBp4WPqkWs0KNLpH2ve+Q+y26yOg1PO4TJHwKfu1uZw@mail.gmail.com>
Subject: Re: [PATCH 10/13] virtio_balloon: add higher-order page inflation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, virtualization@lists.linux.dev, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidharth Telang <sidtelang@google.com>, 
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Jacky Li <jackyli@google.com>, 
	Steve Rutherford <srutherford@google.com>, David Skidmore <davidskidmore@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 02:56:13AM +0000, Kevin Loughlin wrote:
> > In confidential computing guests requiring page state transitions,
> > unaccepted memory tracking operates at the EFI unaccepted memory unit
> > granularity (typically 2MB / order 9 on x86). Inflating the balloon
> > with 4KB pages would prevent unaccepting the backing 2MB unit.
> >
> > Inflate balloon pages at unaccepted_memory_order() when
> > virtballoon_cc_needs_state_transition() is true, while retaining
> > order-0 allocations for non-CoCo guests and CoCo guests that do not
> > use unaccepted memory transitions. When a higher-order balloon page
> > spans more 4KB balloon PFNs than VIRTIO_BALLOON_ARRAY_PFNS_MAX (256),
> > transmit its PFNs to the host in VIRTIO_BALLOON_ARRAY_PFNS_MAX chunks.
> >
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
>
> I'm not too happy that this rides on the legacy PFN thing
> which is after all limited to 44 bit addresses.
>
> And given it is passing around 2MB chunks, then one 16 byte descriptor
> covering all of 2MB would actually be more efficient than 512 4-byte
> PFNs.

Agreed. I debated initially doing this in a single descriptor but was
trying to avoid also needing VMM changes.

Regardless, after reading yours and David's comments, I honestly think
it's better to just drop the legacy inflate/deflate and only include
the free page reporting functionality if we end up adding some form of
CoCo ballooning support. Beyond being inefficient-at-best here and
potentially making fragmentation worse as you noted in another
comment, the legacy inflate/deflate path is the biggest source of
bloat in the mm/ side of changes for this series.

> > ---
> >  drivers/virtio/virtio_balloon.c | 87 ++++++++++++++++++++++++++-------
> >  include/linux/balloon.h         |  1 +
> >  mm/balloon.c                    | 67 +++++++++++++++++++------
> >  3 files changed, 121 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 11f74848fdc4..d162c162b496 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -182,6 +182,13 @@ static void balloon_ack(struct virtqueue *vq)
> >       wake_up(&vb->acked);
> >  }
> >
> > +static inline bool virtballoon_cc_needs_state_transition(void)
> > +{
> > +     return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> > +            cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > +            has_unaccepted_memory();
> > +}
> > +
> >  static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
> >  {
> >       struct scatterlist sg;
>
>
> Put all this, and preferred order, etc etc in kernel core somewhere,
> and expose some sensible APIs that devices can use.

Good call, will do.
