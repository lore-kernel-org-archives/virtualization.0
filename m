Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5F170A16
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315058; cv=none; b=kmfnBhNJAd3KDVr6hPzmBe00EGb0k0pBbUMMkrebdaLDGTpGiY9Maecxso5f4qje7byu7XGCt4/cWaBRr1kKnaZEoV2nHLZ8/sfk9rR3N0mmmLWIUbDaCp/8sXR8jhLtbx26RZdUoJev8isX0NgPiwyfbp2Ng1uZDaALdoU3F38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315058; c=relaxed/simple;
	bh=ayf2iY39WqHx6IW4rUOzbAJ7x/MEKtVBi5L9Z5vmNFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsOTqlAHuxNFT/grwkwWCZzBiD03P5NrVOMrrpSJ/Pb430bauTowVXhg868Uus+dx9RLCs1rFyLUj/aQp/t3i8LY+fSBDis+7dJO26Q1HZvWd5M5G8hJPjCb0VCEv+6q/A8VH7Ov2c+CX2efV694e1ypOq0Mjk5e4oCGYFip8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YrkbUBrP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YrkbUBrP"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so5087931fa.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724315054; x=1724919854; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXgj37TMx8aL1rRaQNhJVUmv3g5neGPq4DUZTSDo83g=;
        b=YrkbUBrPkSIhBzoiwYf1w9qVD+XQXS6MboWYCFffyROy+aVvv0UcmC3DjiJUhRpjjJ
         PmjK3/Kgt6ocnC3SOa64050q16IBRDS76wLYoPCCTsPsGRrNiaqINUvbSzMFUWcof2qd
         Dvn1SVXvaKV006tzoNmh2Nmc1M88D+8NfGGx9dEctHs4QVkDkKoWF2ycicsNe/eonWZz
         7T5jTjxIwzPZ/8IplO1xhvuOp3Gd3w3Ef+/Mf9RdeLHnZYF7wXWgbjD/ABIV6WTo/Iex
         N+Zt7BWPIghVazynth/EMfWFZWYj/lLz9dlgfpDV/BuF+1VlZLqa04GgcbMg+MLwbgnG
         bnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315054; x=1724919854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXgj37TMx8aL1rRaQNhJVUmv3g5neGPq4DUZTSDo83g=;
        b=ovW5TGbIQ0p1kLoAhRrkIcI6/XBw0h0B7Wx6V3kS/ooGg0KSO3P2W68Ch/X0ZFZ3yJ
         sI0ll/clK8Kv7iVJ+zXWE+1PssmMMXfSHWp3W1d2Cztvly1KM8afHhXdRwh+P67e6HcI
         xOOvq5bM0RdVercDXDA8sDfU7V+BwcprwSLb6VX1iRml6OmdhrP2SO9P7E7ZBtv3s5jh
         1Gs2wMRiVUBLIeYL8O0kSZPF03sKL2JE56Wh3gtbBC3ozSvS4E7WWTFxBiAvld/ZaVBZ
         E3nWqygA0xRD5fOBhHlA+QrIwLgY1c8r2Sy0dfekVQcHTExhpmt2ncIEh4HX+MzxVrbh
         /OFg==
X-Forwarded-Encrypted: i=1; AJvYcCVZX16oVRP7tebAudb3yw9mEcNm0HkmFvSVJlU/8+MxU9GaSQU8h7KsK7pO+QNJCm6vRsHaqDyalf6Lltxb/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwktcUieUu+WaeCnZQm79p57g0KAMgEnK5W8nA1Mq3vXU5DlI67
	v72Orxe+dgYV3zBXNOxp1iiS8DjsvrbD3jCP9vBOJqAAzzdZ0+gJOfpBC8YHlCc=
X-Google-Smtp-Source: AGHT+IFB2eEPLaBDM1KUM6aZQy1e8xYD9Bh6pKUfYpZ84sAeHB8dPoSo2HIQ0e9MSM6g1QoeRd5Tpw==
X-Received: by 2002:a2e:bc13:0:b0:2f3:c029:d7e with SMTP id 38308e7fff4ca-2f3f88b843cmr36602701fa.18.1724315053944;
        Thu, 22 Aug 2024 01:24:13 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ead28sm608629a12.56.2024.08.22.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:24:13 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:24:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <Zsb1rM-azd_0gFzg@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>

On Thu 22-08-24 19:57:41, Barry Song wrote:
> Regarding the concern about 'leaving locks
> behind' you have in that subthread,  I believe there's no difference
> when returning NULL, as it could still leave locks behind but offers
> a chance for the calling process to avoid an immediate crash.

Yes, I have mentioned this risk just for completeness. Without having
some sort of unwinding mechanism we are doomed to not be able to handle
this.

The sole difference between just returning NULL and OOPsing rigth away
is that the former is not guaranteed to happen and the caller can cause
an actual harm by derefering non-oopsing addressed close to 0 which
would be a) much harder to find out b) could cause much more damage than
killing the context right away.

Besides that I believe we have many BUG_ON users which would really
prefer to just call the current context instead, they just do not have
means to do that so OOPS_ON could be a safer way to stop bad users and
reduce the number of BUG_ONs as well.

I am just not really sure how to implement that. A stupid and an obvious
way would be to have a dereference from a known (pre-defined) unmapped
area. But this smells like something that should be achievable in a
better way.
-- 
Michal Hocko
SUSE Labs
