Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6F17D377
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319688; cv=none; b=t2ypwUMiss8p3kA6ig6r1ulwpypIA19yLMh6N8BuJo4333J3XEr5bvbO74SLOSGG0r2V1Zr8tgDIawgbNae2M8sZMAMHjTwvmuNtEcn5GY9784yU97hp6SLmnkip70dqFZgdYUfZEFS8iZpe/YJ+tv7l2ruj/9pXEeu1Mq1+HSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319688; c=relaxed/simple;
	bh=A/J4Rle8AhBzXJMdx4HWI8Szbi2qxitlGQR33cxaAGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkXK+1RRFsZW6QgUTuB1dEcuN/xw5NY7mbuKXxhVcW2kKMk/CtMWtrM4kE1p/1UymVfPElmwNsEv/desl3MGdQAuJ09d8Wdmq60xVBfqskJhqFhzrn2nKTXbELe7I/gGvMPvcrHO6DuzWKPLkoZ/gNcofxZam89v7yROWJ+hvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eF//NijO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eF//NijO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so860879a12.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724319684; x=1724924484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8SH5AeNo6r9c+QnGllsu0v0n00fvJPRVyLfkrH1Iuk=;
        b=eF//NijOCQAmqFqCr6JOHCkRzOLVkLkBQPwA7dyPJewnDa3YwkpQrbUjiPHI/GrVlW
         MI4fC65ameRVOc+8+g1u/X1twtCZu/ZQ//QH0oPsC6Ho/VWYJ1kEBvuDQO4BduQ8GJ6o
         2po4F1M3CuJ/4z9lBWdaeIwpVEKAbkQ3ln1m6YMCBNXzmith3H8d8xQQHbo8IkFDDlyR
         XLWiU5b4hnuXr3mDHB84ed/i7djaWGkE22o+IT8yvBzUnkg/LTpBUEwmUv9C9Xy08vfW
         aIQa+UzW25fWJY0UcXUPPIwzWcM4IIp0z0Ojm8bjVUywJaejbvPfFiXZsMfEEj2yVh84
         U4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319684; x=1724924484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8SH5AeNo6r9c+QnGllsu0v0n00fvJPRVyLfkrH1Iuk=;
        b=BUrPHVmq1GhgPIF8TudKPQX4W7EldZZ5/w6V2U26CBUHF+WS4QnBQ94A6Z7oLdh6Si
         q3JoKnONDMmKtEQWIEk4VoMvp3Ll3Hz0R4IwJJzdrz234N0yQW0SxnyNDIIRV/R1+Y0o
         b+Xk61aqdNYlIcVgj4nBSbe5fSrbGdnVR6l2FrIRileDOvbkYo8g4ePplGSdd34Sl3qp
         sbpjcHivpswLwnQvxmYkk1mK1ZK3rlHtXrvqOmhH77+1bhjEBrSvXBc91kys0z91k9aa
         Sc4LwvFqc1dY2RzAuFzoB1DbVKWuqy7c/NzdUf3oqXGd6kLYhYJ/JRqtUypxEd+BPOzY
         XpGA==
X-Forwarded-Encrypted: i=1; AJvYcCXiwYprvlRLhGVNZPa3FN/IAWGLZf5gG4i62kx+K0URhyfgEaXcbCL6tSWRNs3yyLoaE4E09wA7Cu29mfFldA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5KRORNpdnHY1vdA9Nn2ak//Yoo4v6va1CJtK1IyEZtQRhtFXF
	YeZgIzYnFTDLcW8262ftoAqVE6+ahY6nevteW2fhhOae2UlbuV1+wTDKFYuMP+s=
X-Google-Smtp-Source: AGHT+IELqOefPJ8psfpJSjnaSaKWJC6Dc+LHxP3cO0ykfHQjKl2FHz2qDjDbsW8KcyOaDVWiYjTLTw==
X-Received: by 2002:a05:6402:4407:b0:5a3:a9f8:cf20 with SMTP id 4fb4d7f45d1cf-5c0792b0d8cmr770050a12.34.1724319684224;
        Thu, 22 Aug 2024 02:41:24 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cbdeasm693091a12.33.2024.08.22.02.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:41:24 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:41:23 +0200
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
Message-ID: <ZscHw1Zkcnx3VWvG@tiehlicka>
References: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>

On Thu 22-08-24 11:27:25, David Hildenbrand wrote:
[...]
> Likely, checkpatch should be updated to warn on any new NOFAIL usage.

What do you expect people to do? I do not see a pattern of nilly-willy
use of the flag (we have less than 200 in the kernel outside of mm,
compare that to 40k GFP_KERNEL allocations). If you warn and the only
answer is shrug and go on then this serves no purpose.

I have learned couple of things. People do not really give a deep
thought on the naming (e.g. GFP_TEMPORARY story). Or a documentation
(e.g. GFP_NOWAIT | GFP_NOFAIL user). They sometimes pay attention to
warnings but WARN_ON_ONCE tells you about a single abuser... I believe
that enforcing a constrains for GFP_NOFAIL by killing the allocation
user context would have a more visible effect than WARN_ON and it would
stop potential silent failure mode at the same time.
-- 
Michal Hocko
SUSE Labs
