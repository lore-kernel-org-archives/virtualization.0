Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0F15572C
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319206; cv=none; b=cBDwC4uq2Wh0CJbBmufpl5BYVEusnb3969tCQFn9qbyPDDT5/9HTEcve2a2Htqdxa1z2Cn0MAe7A3KaqcHaNNypWi+l0hhhFHNQI6Lr6sdIg8/6xPOhxE7/LXHIHF6eA13+aHUpqySxenZubIyUtG5AUvo60Eqtys7FGWCDiS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319206; c=relaxed/simple;
	bh=uteO3xspMfhO2KmRiWimA8pnUAdnjGp69KEZMIZmy44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcRz2FP9Gt7t0+rGM41ZTCNbiOx/Mjynh3sX6h7H6B74hDMFkcRT6H/6qoc9EbrWvByGOZMcd9F47XwsBDz1mURc6vyKBS06zBWcRpTcYRn98R+MjNvW22EHlRvEHQkZn1dN0KovsBUth209bXH/lGlM4e0X0jvgh+PVQNKqx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cNVY6ony; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cNVY6ony"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so91247566b.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724319203; x=1724924003; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtpOHRbTf2cL1AHUBxa7KAcuYN0LHvUciD3+K4T1tMM=;
        b=cNVY6onyCwOqY08TJuVWi4sjFhgCeXgGTZ7bns7wCqaFEYsO+YDJ0g8jiR8/PlrDSh
         ZkK6bemUeDJ4FItoikdV60iSAt8hwy+l2UyJnplX/4t1GWX4K8j/46J3ZIt7QrWZ7QR3
         GJC2yyAPAnd43yMGPSRo1vd6BVPBqSn2I7lRWQwFWNafiO4+cfvxZ+0Iowj9LaoA+/ir
         +0sUDzho023DEQ5By2e9x3xQ97wwKOFkk7e+MnXV3GFD82pfxljskdUHkfjwbZazZtbT
         d8XU4afP6pBQPLz235HnmKskHOqF/PErnsS73mKsYKlxoM4gTJNl/5Ndt10JLLUieOP5
         eU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319203; x=1724924003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtpOHRbTf2cL1AHUBxa7KAcuYN0LHvUciD3+K4T1tMM=;
        b=KvudOGvfRCtuWriv5K15eVi6HnDkkFyIuFmeCRyAr7ZT9hd3/KWnkZlnFpGvIyVdV0
         SiwiE7EM5ryN5mlNCMulFCPtbTNpR2MghnEbLmVFynBoqgpQL1vPFLBeZ0T/hGyFJrsy
         gwwHWvQNP88XkELRscAc95lIEmiyC5hYuxcl9/g7Y79HSvS78r0z2700peBPUJaJNjLZ
         iszfFoWndykHG53zj4UOtVDYHgrXRSaX7PN+Y7tgPIcbr2gzjBQ9PMaAPTELcrI7iHv+
         diCJ8uHrVo7EBYGQjVcxORC0y/qB3Jpzbe6VlJeBrctHJjA5CXcXvRfqZe3MBCQ51UaT
         VX8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbsZR9ypBtht+8i8t2kfS1Mo75QlUwNYfoh59nW9DQI1klTot4ukd+kLM5KLdCZ1Ddv9Y+2Qo91BRPz0geug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzklqpFpFKqK00uUZ8dDPF2zvsTrngrhgYkMQmH1elyRrf4FM6u
	OvPjezis5ylMVd0hQ9st1qfKOfLrorpXQFMTs45ZEVQfiSr+rrs9uKRlrOTGhbc=
X-Google-Smtp-Source: AGHT+IGYiLDhYoQ/9N0KZs1sCSGFDOIiE0Js1DYKhz/qTr/auLcTrLYgfMfybD6M2Ouq1lkQ3/1eaA==
X-Received: by 2002:a17:907:3d89:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a866f8f0692mr318504066b.42.1724319202777;
        Thu, 22 Aug 2024 02:33:22 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4378f3sm92315366b.132.2024.08.22.02.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:33:22 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:33:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZscF4SQzxKv9evmR@tiehlicka>
References: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>

On Thu 22-08-24 17:18:29, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 17:11, Michal Hocko <mhocko@suse.com> wrote:
> >
> > Let's put whishful thinking aside. Unless somebody manages to go over
> > all existing NOFAIL users and fix them then we should better focus on
> > providing a reasonable clearly documented and enforced semantic.
> 
> I do like changing the naming to make it clear that it's not some kind
> of general MM guarantee for any random allocation.
> 
> So that's why I liked the NOFAIL_SMALL_ALLOC just to make people who
> use it aware that no, they aren't getting a "get out of jail free"
> card.

Small means different things to different people. Also that small has a
completely different meaning for the page allocator and for kvmalloc. I
really do not like to carve any ambiguity like that into the flag that
is supposed to be used for both.

Quite honestly I am not even sure we have actual GFP_NOFAIL users of the
page allocator outside of the MM (e.g. to implement SLUB internal
allocations). git grep just takes too much time to process because the
underlying allocator is not always immediately visible.

Limiting NOFAIL semantic to SLUB and {kv}malloc allocators would make
some sense then as it could enforce reasonable use more easily I guess.
-- 
Michal Hocko
SUSE Labs
