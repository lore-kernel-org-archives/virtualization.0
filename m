Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCC158A3C
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823927; cv=none; b=InHwo3ZThFG+TJXzxIR5KrYDuQkpMJ855u5XWBt1cDfHG0KMWUhIn2nnnAJ+dfrdAMfY3SGLBR2pfR7TUzsDaWjkJPndihdcKv5O+UlOsLnjw0Edjood61l/B+js9DdW9uQ0ibEs8Lj8GzaltJ+dVk2OoC7hxDH2AlaS0wB9ZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823927; c=relaxed/simple;
	bh=/5hk83xN7BB37yqUNfky2pT8M3U7i0vWTerPqJxiZ/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnI2hlazZkIx3mWA2z6wmBRXVkiWezD8sVRa9J0J3c3Dgob4aJHvM6nwgD+k7Z1wPR+sbFX2pP23AqxLXh9NfzmzrYPtIk98GGMvUtE1ourq7VdCdCR7t4LIYCSJ+JZXtu4+DaK5+6HbqOMGcdettBjBp2DbrIthpXZ6Vg45yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5VP9z3k; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5VP9z3k"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01afa11cso5456566e87.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721823923; x=1722428723; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrFqaYpj4eLT6IX1V9Vf1afrsx1mFigmF9d2Uyaa6S4=;
        b=S5VP9z3kZ7Oog2RDOB9di2+tIWf6JYTvPKNv1NHVgnPQcdzZZGq9Lax8aS42rSkM1X
         pVESHwrPHT2FP4zqVrhl80u32y22TGuWRZZ0/kbzcYojxlkNKrms2gllTwi4D5tzbDV0
         4y7bSfLVNORubASjzzGEu/oxR/YY0Vfru1z+Ih1/cPgdU9NiTwbKTdrYqxrbh8tsKdre
         Og9NBz8958D7/1RSJVdcvfKmGKEt6ZQoArjkwY2M8Q4f0/sq757eVqwmGr8JeJAUB1gd
         K2OrapsDuOVN5Xp0rCNKmEAzuRX81yxNUtXA5L1WwcYFQTGfhsO3eHdbZPjnFaxfbLwo
         u1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823923; x=1722428723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrFqaYpj4eLT6IX1V9Vf1afrsx1mFigmF9d2Uyaa6S4=;
        b=rFaZw8cAMmYfAEGqzUo6LpQ7/xfqR5ZmxPaJ7kS1H53lw3yNhPhWrEMkATzcdd2QnZ
         PHX58r5AuqwYJAILGPS2lqc7S//+WI/SurmWNBgw+xtLmXJVzT73fnMYYXT4F9Zl30bf
         kbuX7dtcdYQ9X+sXyrhvF0ihsINO0uANuyonUcUaDQxeMVdzsPX+2zKqBGnJvNYanqrp
         2weJAuzwG04h+50Bg6XdMsFoQBHFnK4Kd7VbnCedA1m/sE091xe8nMP/J7UBC1sTaiVr
         ZU62HUtSz8GnDkhgIN3whIs0SLT8XSsGSSeE31cMICRKbLilRjk7PudkgqkclGal9Ygj
         29Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW2t6Np3TdMhOXly/AkixFPAaKJFljei0nylGpt5Ic8iDKgpkvhViG9G75DO+vtHcO9yOIcluhY1e1MWjqzW4DbKo5hjEpHOd4c0r2bRyk=
X-Gm-Message-State: AOJu0YwiPdPIy6fqFmb2DaUE1dOVmqNC6k5zRDvH91WKKV0nAGEZs8LT
	1+BdRVHU8lIGhC3s0soqPYgcUbtaaFeIljTCytuLWJPmRecRFCRCjGA6V+4Mz+s=
X-Google-Smtp-Source: AGHT+IFGCKRyUaP9yJn7FT3Fvxh81APKwaw0rHEz3bEaldlitBrro27WNG7/CNseiQHDNU7rH0tQdA==
X-Received: by 2002:a05:6512:3c96:b0:52c:d967:79c6 with SMTP id 2adb3069b0e04-52fceff676fmr1426664e87.20.1721823923278;
        Wed, 24 Jul 2024 05:25:23 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9450ba13sm180883366b.92.2024.07.24.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:25:23 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:25:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqDyskrpsc0w_NqL@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>

On Wed 24-07-24 11:53:49, Vlastimil Babka wrote:
> On 7/24/24 10:55 AM, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> > 
> > GFP_NOFAIL includes the meaning of block and direct reclamation, which
> > is essential for a true no-fail allocation. We are gradually starting
> > to enforce this block semantics to prevent the potential misuse of
> > __GFP_NOFAIL in atomic contexts in the future.
> > 
> > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> > and __GFP_NOFAIL are used together.
> > 
> > [RFC]: This patch seems quite large; I don't mind splitting it into
> > multiple patches for different subsystems after patches 1 ~ 4 have
> > been applied.
> > 
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > 
> > diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> > index fa01818c1972..29eaf8b84b52 100644
> > --- a/arch/powerpc/sysdev/xive/common.c
> > +++ b/arch/powerpc/sysdev/xive/common.c
> > @@ -1146,7 +1146,7 @@ static int __init xive_init_ipis(void)
> >  	if (!ipi_domain)
> >  		goto out_free_fwnode;
> >  
> > -	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | __GFP_NOFAIL);
> > +	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | GFP_NOFAIL);
> 
> This (and others) doesn't look great. Normally there's just one GFP_MAIN
> that combines several commonly used together flags internally, with possibly
> some | __GFP_EXTRA addition for less common modifications. Now you're
> combining two GFP_MAIN's and that's just confusing.

I am not sure we can expect too much consistency from our gfp flags.
This is unfortunate but something that is really hard to fix. Combining
GFP_$FOO | GFP_$BAR is not unprecedented. A quick grep shows that
GFP_KERNEL | GFP_DMA* is quite used.

So while not great, if we want to enforce sleepable NOFAIL allocations
then this seems like something that is acceptable. Adding yet another
set of GFP_$FOO_NOFAIL seems like too many flags that are likely seldom
used and make the whole thing overblown.

-- 
Michal Hocko
SUSE Labs
