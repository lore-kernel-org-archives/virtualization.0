Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D434CDE
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425468; cv=none; b=MtJ6hoBk0Fa2c9qqobKlLGeq6AJLWWZe4911U2mWZJI2cN9nKue7HE/9z7kLS00l8MTCqeqaW/BqyIi4jJXd7f7ApYdAiaNcscHWIYo2bm0Cpc9EARttpT0CLVo2rhhHtXemKwcOl7UUeYhDKM5UuxYhcmh0gCyGQBtHm/yEWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425468; c=relaxed/simple;
	bh=DvSvlta9KG1yBtU1D11TJi0at9AXIomAAK69ciOtlXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuWDcxOiiaEM+wQpEQbWZFsJH06/stMdLa6gUxQ9921t5uJqMmQSwqP1X1lhztAFW8reQ/WdWdbB+EuykGmCM1CeK2Sw43EgaQnaJjq8rcz83SYPYQ6Azct3RnawI5qoXaaEWOCSW/Ctw4l8h8y8A7QnXuQk1RyP4tPdx5gHC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TS05A8if; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TS05A8if"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so33148965e9.3
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722425463; x=1723030263; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UBCJFgeTUdNvJzWxqgzbqzKW7GxJNF6lw09ytvxv+Fc=;
        b=TS05A8ifZVlpXSRJK9gnOuliIE7AujdMXRmoLKyMPhIfTNKRvr3xvlJMWuQc9xd1EO
         hzEkCRH/dvnCg6QAqG9HFVt3dba+R5l07EqtT7909Yvp6tpXCrzPlxBMn869OAdSLeu+
         UIoL/aq1Sxc9p+cCwWx/BEWdvnWZND+YGhaVyNcQ/D/DVMRqj1z37Cq5FcxX1IdttTp8
         oE+Z+Kr7ygJYptinNJIl+9GXiDj9vEhQOd3aFHRTBs3vyM2urtqxrp5tsDmDmnv21OfE
         6WdwR/lisFphKh3GDo0A6yNWkIQ5idqdyN/x8VzVPVOc0tmK7Pg9J41DdiiLg7GLVsSI
         jA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425463; x=1723030263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBCJFgeTUdNvJzWxqgzbqzKW7GxJNF6lw09ytvxv+Fc=;
        b=icuvlLoHCmBNs4rmeVVjMR+CY8mFLmNIxRIiYWFrYsYbwUtMd9cSwLfczI76HJr9LD
         0vvJpPnyTDYmXvcIgW8XCYJRGg3FZcWisNEHML2RQCccb5qOtDHrkyzYGhV/NBoBZ4MN
         I8uWrYySShNCH1nrawGjgJIoHyE7JgoRTHpyl7SSAuOrcUeaellyEq6d2YVEF6hMrxVU
         VQBCPqsF8O8+q9GvvSBHOprqRWlU5T2HUOlz34Con1j102LTS+uEfOvIMMi1MaxRxTXX
         OwV4toxVV2cbgXV4Tf9RZdpcdkAV5SEfW9VMmv/9jeTLiV+ijuuVBGxdEUftQD7os2s1
         3MbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL1A11ZPknyYQ5iTScaQYbZ92dRL89nVEG7x6DL3Muc0JlNcZSSt9yAjWiRcjSYYCsaNx3igJJdade+72VLw3P05UgscfegjK7jH8xI7g=
X-Gm-Message-State: AOJu0YzxTJcmmseS/+11OU1PJOxulWaK24ddob1901PnNlssUcj2Hqhb
	7vScdk9cx8o6+RZpe2FW1mcGcbfK5ShAkMLq/Yvogb1L1mu/yxehLX1DdwArIQg=
X-Google-Smtp-Source: AGHT+IHLboSEXgMqcN0I7NYGtzc0ZydEJ9mpuueEUQiRZIu5xSUHLIfmpOCHl7eQFU6uhiYGogiWXQ==
X-Received: by 2002:a05:600c:1da8:b0:426:6ead:5709 with SMTP id 5b1f17b1804b1-42811d8893fmr112316335e9.9.1722425462898;
        Wed, 31 Jul 2024 04:31:02 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e515fsm16851308f8f.45.2024.07.31.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:31:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:31:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev,
	Kees Cook <kees@kernel.org>, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v2 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
Message-ID: <Zqogdaq1yLowIb2u@tiehlicka>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-5-21cnbao@gmail.com>
 <19981556-cecd-4f58-8b3b-bc3bb85a6ac4@suse.cz>
 <CAGsJ_4xnRCMAQLPb5XAYPL3NHA7K4firyWL_yseT+-a8Kz5OZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xnRCMAQLPb5XAYPL3NHA7K4firyWL_yseT+-a8Kz5OZw@mail.gmail.com>

On Wed 31-07-24 19:08:44, Barry Song wrote:
> On Wed, Jul 31, 2024 at 6:55 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 7/31/24 2:01 AM, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc. This kind
> > > of non-blockable __GFP_NOFAIL is not supported and is pointless. If
> > > we attempt and still fail to allocate memory for these users, we have
> > > two choices:
> > >
> > >     1. We could busy-loop and hope that some other direct reclamation or
> > >     kswapd rescues the current process. However, this is unreliable
> > >     and could ultimately lead to hard or soft lockups, which might not
> > >     be well supported by some architectures.
> > >
> > >     2. We could use BUG_ON to trigger a reliable system crash, avoiding
> > >     exposing NULL dereference.
> > >
> > > This patch chooses the second option because the first is unreliable. Even
> > > if the process incorrectly using __GFP_NOFAIL is sometimes rescued, the
> > > long latency might be unacceptable, especially considering that misusing
> > > GFP_ATOMIC and __GFP_NOFAIL is likely to occur in atomic contexts with
> > > strict timing requirements.
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > > Cc: Christoph Lameter <cl@linux.com>
> > > Cc: Pekka Enberg <penberg@kernel.org>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  mm/page_alloc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index cc179c3e68df..ed1bd8f595bd 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4439,11 +4439,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > >        */
> > >       if (gfp_mask & __GFP_NOFAIL) {
> > >               /*
> > > -              * All existing users of the __GFP_NOFAIL are blockable, so warn
> > > -              * of any new users that actually require GFP_NOWAIT
> > > +              * All existing users of the __GFP_NOFAIL are blockable
> > > +              * otherwise we introduce a busy loop with inside the page
> > > +              * allocator from non-sleepable contexts
> > >                */
> > > -             if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > > -                     goto fail;
> > > +             BUG_ON(!can_direct_reclaim);
> >
> > We might get more useful output if here we did just "if
> > (!can_direct_reclaim) goto fail; and let warn_alloc() print it, and then
> > there would be a BUG_ON(gfp_mask & __GFP_NOFAIL)?
> > Additionally we could mask out __GFP_NOWARN from gfp_mask before the goto,
> > as a __GFP_NOWARN would suppress the output in a non-recoverable situation
> > so it would be wrong.
> 
> If we use BUG_ON, it seems like we don't need to do anything else, as the BUG_ON
> report gives developers all the information they need.

It will not give warn_alloc - aka state of the page allocator at the
time of failure. Is this really necessary? I don't know because it is
"shouldn't ever happen" rather than "how come this allocation has
failed" case.

So IMHO a simple BUG_ON should be sufficient to scream out loud that
impossible has happened and need fixing.
-- 
Michal Hocko
SUSE Labs
