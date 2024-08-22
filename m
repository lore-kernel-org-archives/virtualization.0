Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD9558BB
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323584; cv=none; b=nu4xMcUB+Z0VhDIAshgdqPgEitgN48W0+tIYrOyRYlzh0kUEjSii3eWCkSTp3wQz+grxAmEWRYeGZEP8bd8n0tmjwdTBu4UJxNcQAD+RmTfzKrkzjB9pGMYzUctylH4xRBOiLmZkMpST8dVgjwPzh3HR8Fd6MJyqLgod2y35rKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323584; c=relaxed/simple;
	bh=/6BK+2p1fZtQM6cSQijdD6WAYiKnHSOcmYchx2mVVAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxA7OpdZW9d3qoG9YHj73wB4v2+0GSbY9v8DEUaq4UdBFuX+tF0s8ip4fnJOFUPSQOn98vN8Gxo7TFbWlgocJyjVPoLecb/1hnIT2a8gWTRLQD5SIg/GO7dsY8GntG1G/GgJ8FvbN/lHgnvlEHdPHu1nfo6RMeSiNtIO4ECKgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=btc70C0r; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="btc70C0r"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so994717a12.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724323581; x=1724928381; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUBeSUtvTMdoH+WvRgjDYc/Ro9Sq4X3Z+e+u9RLg8vQ=;
        b=btc70C0r67xJ5Kd4u/Wq1TFjYMnqHHqTJkPvaIRUPT6My6pEKB0qJ+lpA57f23ecI6
         cKbwqOcTC7ZyTB2sSXCrlRlZSWTQQy3pATKnII6y94XfjUFB4t1JeenwGVmilyuQdUYd
         +hptufHvVAzarPN9MAdRuK/6AYnF5WZRbaTaEXpkIuCUaXo3CWm+zbS9mSur0lYkW2J4
         qIqmWP60PneO6axLEnz08Zo+HXJ014sDmgOusbTUVGB23Q99ktgl9bBuzgisquJmeNHT
         h8MqbMhRYpDM18r884jz2s0ODovUuHn0mC7skz2oUK12vRmXXPseyBBTfu8okySkg3FN
         y+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323581; x=1724928381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUBeSUtvTMdoH+WvRgjDYc/Ro9Sq4X3Z+e+u9RLg8vQ=;
        b=JlmvSb9YRZxnnLpH4fGfX2aq/o8b6lMm07OD1rnXxgqXYVXSY1gwy1kgOyVpxW0f0N
         23SSgs+acjrEAEvEI4h/RYUiloBieH5r5gHw7c8nF66/OT2pVIALcDx4yVaxRlhxpnzR
         J8mc38fWbeFJTOCIIQMOnHYeybN8oxzf0XG+JVPpNceKnY3iVxaMl1hszQ2AESJhfM4P
         mn7/+77OVAXCNToNss2fVXf8nVLbyAuRewm+B05CEjUUFVbm1ki2jHcPt3/UYv67bwf1
         YTBSLl07ZEyra1vCIAfBv4S9tVrSGv9R7LM+hzu/eg9oRC3Ij5OU7UV8yOmty4Q/VEKM
         qDLg==
X-Forwarded-Encrypted: i=1; AJvYcCXyC7Io7yigf/iDJK9OsdqJvAWQXW0UgJJZE7cOg5IwjBpnpu0BLJvAKyCIXrXfmhd8atu2TW/pyA3kh3yG1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS5mX2BXduqRy3L8CLQ4atTct5WeGKqcnCpk2dDLmCDvoAy7vQ
	0NCBQt6mOLRyX4AcdLK3KzhFlkLgynBu+PE3RBnJvTxFyoir92GIHvAkXeE32ig=
X-Google-Smtp-Source: AGHT+IE9Ciz79yXNudjsXT91IhEVjD5RtNWWb1mllRMh8ehzFA1RiIM9zIWnD4OSJxrn0l81jOMeag==
X-Received: by 2002:a17:907:da0:b0:a77:eb34:3b4d with SMTP id a640c23a62f3a-a866f13575fmr391332066b.13.1724323580618;
        Thu, 22 Aug 2024 03:46:20 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436374sm101266066b.111.2024.08.22.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:46:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:46:19 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christoph Lameter <cl@linux.com>, hailong.liu@oppo.com,
	Christoph Hellwig <hch@infradead.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Uladzislau Rezki <urezki@gmail.com>, v-songbaohua@oppo.com,
	Vlastimil Babka <vbabka@suse.cz>, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZscW-3o89VoKq5a-@tiehlicka>
References: <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
 <ZscF4SQzxKv9evmR@tiehlicka>
 <CAHk-=wh-pXKU_+EPMLgdaK62s8Zp3zhcCBtYLDR=LUQqWAUHNw@mail.gmail.com>
 <ZscMFIf2H-SlCcsS@tiehlicka>
 <CAHk-=wiJ6BerHAcvVCkm6gH5X8V-ktkxajXv0VZMW5HtvWsJgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJ6BerHAcvVCkm6gH5X8V-ktkxajXv0VZMW5HtvWsJgg@mail.gmail.com>

On Thu 22-08-24 18:30:12, Linus Torvalds wrote:
> [ Sorry, on mobile right now, so HTML crud ]
> 
> On Thu, Aug 22, 2024, 17:59 Michal Hocko <mhocko@suse.com> wrote:
> 
> >
> > > And make it clear that it will return NULL if somebody misuses it.
> >
> > What do you expect users do with the return value then?
> >
> 
> NOT. YOUR. PROBLEM.
> 
> It's the problem of the caller.

They have already told you they (believe) have no way to handle the failure.
So if they learn they can get NULL they will either BUG_ON, put a loop
around that or just close eyes and hope for the best. I argue that
neither of that is a good option because it leads to a poor and buggy
code.

Look Linus, I believe we are getting into a circle and I do not have
much more to offer into this discussion. I do agree with you that we
should define boundaries of GFP_NOFAIL more explicitly. Documentation we
have is not an effective way. I strongly disagree that WARN_ONCE and
just return NULL and close eyes is a good programming nor it encourages
a good programming on the caller side. I have offered to explicitly oops
in those cases inside the allocator (while not holding any internal
allocator locks) as a sreasonable compromise. I even believe that this
is a useful tool in other contexts as well. I haven't heard your opinion
on that so far. If I had time to work on that myself I would give it a
try.

-- 
Michal Hocko
SUSE Labs
