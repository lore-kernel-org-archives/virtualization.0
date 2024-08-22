Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923515F41F
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317882; cv=none; b=hymmSCCy1/B5ahL3dg4lOB2OX4n5TpdvlKYoYxY+JuPAtcYXL/fS/Ls9zy2HESZHur2SSYxSS9z7QHrtUns7q1yfUmUpmg2KyE0CehlGm8HspXbuR3aLecjjiRCiMytF7W1qFV3s/cISglKyCSa4sLQsF58SrLGCkodG1cOsTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317882; c=relaxed/simple;
	bh=bxBMfIvwdmUGJ+pyu5T/D00WB6sDIOZuKdE3qpsJimc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyF0/J5HNMrf/HKhvl7PUxPXeazK8K0qwJlbpgmwn9bpFcDgqrJCP1Zem02Dn5pDtKWSS6i46JtFpwqs1IyN/ZjDBzqbnu2083xmq95MyNkYPINSn9ls1/C+lYrzE7YcnIY9a/sWjpUrtqnLt11AQzOO31ptvlPVzoH0wFiJP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TTB+z0pO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TTB+z0pO"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8696e9bd24so22896266b.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724317879; x=1724922679; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZcVgOYl6gZrJKPQ2QEIwaOBVHmZVmxnqm/62ZXsEVQ=;
        b=TTB+z0pO189sILGMeygMqFEhNYV8oTB/weCTIKN0WJfwt0Sv9qHVXIc3/qyYVDj9yk
         Dg9289gwz/JJD6VzWV1QMHYKjkatNMl/5519x4fUloYZQDEeuzU0q8731Py9xkL/7vvE
         l5lPe5cGomHE17socHvVkJ1gpRJQElNrHR3slj0GZQ0buvdnoKlpxbHoGvWqtL3mLq4A
         Pz1CTv0RdCUYE0sgMxkxM3jjh0kU/1LnuE8KW9ctqSye+RqMjyUWPZrNgGUyj29oCazI
         FhuJPhXeeXnB3b5ev4cFmkglv5KEPeloJ9UtQCBB6HYpdgn2awi4fyuntHIW+29jNhjq
         gyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317879; x=1724922679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZcVgOYl6gZrJKPQ2QEIwaOBVHmZVmxnqm/62ZXsEVQ=;
        b=pRd6DPO3HWyk8iHBaD2X9mhDk064Id9SfTx5rIo8OV2CVYVGpv0iovmduoWr8AgZuu
         VQY4bPhq8J8Ub/qlivVclafLKQn9/UIwhTKPaNmaN5gYSvC+CwrSG6LNJZwGkoUWFyd8
         c3F7S+UhO31wlzP547O/GfW7NEzwVJdcABKa/6HCBXTvJpF3e5T5qHvZb+zMdbmSDBTS
         oohOX/S44mR8WHklOXpVifek1FY+PF2dzIRmlap8TnaT2c1UeJMyKaO7+gQhXNuGgB2o
         ET/ThGtGTYfi71WGXfReSGS8YYBMT2WIQ3n/ioMlRl8SacSKWdLC0HpaWBtiOnzsG/z4
         gjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWIliS0cF+nWIB4F6AB6VarzlfbXK0KJ4JEjs+6/LR+pC6GJKESI4zF2Cq8BHH46vI1brspjHfiT8VQ0WEDzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbUFetbdfVQEn5hv1GNHmfhv29ZO9qj0roFo0F81+cZ8ETPRPo
	rrhej/G7f5bCh7lu9mrgkI2hYA0JDW1ioy8p3k2EdgGEhFS+AT4CITE3faiz4tg=
X-Google-Smtp-Source: AGHT+IElpU86MA2dpTZSeUpiFFoaR8KAM7OcPhWJVoNF/ZYT8HlFRfKBxbWUdNXbxLRNqNsggYNm0Q==
X-Received: by 2002:a17:907:7252:b0:a86:43c0:7d2 with SMTP id a640c23a62f3a-a866ee6476cmr448496766b.0.1724317878718;
        Thu, 22 Aug 2024 02:11:18 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47c512sm88847366b.150.2024.08.22.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:11:18 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:11:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZscAtVskxgONe3gT@tiehlicka>
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>

On Thu 22-08-24 10:39:09, David Hildenbrand wrote:
[...]
> But then the question is: does it really make sense to differentiate
> difference between an NOFAIL allocation under memory pressure of MAX_ORDER
> compared to MAX_ORDER+1 (Linus also touched on that)? It could well take
> minutes/hours/days to satisfy a very large NOFAIL allocation. So callers
> should be prepared to run into effective lockups ... :/

As pointed out in other subthread. We shouldn't really pretend we
support NOFAIL for order > 0, or at least anything > A_SMALL_ORDER and
encourage kvmalloc for those users.

A nofail order 2 allocation can kill most of the userspace on terribly
fragmented system that is kernel allocation heavy.

> NOFAIL shouldn't exist, or at least not used to that degree.

Let's put whishful thinking aside. Unless somebody manages to go over
all existing NOFAIL users and fix them then we should better focus on
providing a reasonable clearly documented and enforced semantic.
-- 
Michal Hocko
SUSE Labs
