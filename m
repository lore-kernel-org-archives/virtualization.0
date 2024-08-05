Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD213CABC
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844152; cv=none; b=CkDdTnypIdJYQA2bdmfEaixX4sj4N3LqBklgBP8mbOQkDHLJN3fQsIhy2mXoufq3agqVbQTkOMKkYdzsZm8xkqdSi/BzLVaGrhYwkXZfQIZNQUZX74NN7xLdEu09bgZoKIfYkMNRkC6LRI9TZoENHQF3mnFyCEUwzETmYdHgMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844152; c=relaxed/simple;
	bh=eWvg3OTo6Ibwbq3fvy/YAjBt81d0d/am0z/U4Ys76oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbPp6I75LPyVxwRn5rObsEVX54d+lxXmJ1lNteZ6BOGi/fRcGbbi+HucYMkPInbp7cZqzsoDmEzu3Ut1y0THmeYxYh6adoIENGr7OamfsAOCoOPfKqfCCldafgAgB0Lk62OyYiilP+qfxjHC5z2yhrSVXzCK+tQCNJShZW21KIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D0RnrgA3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D0RnrgA3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so11712864a12.0
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722844148; x=1723448948; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqtCFJHZfxqjuoiQwN6L9m6lEWWbZo6e4mfJzb21QCo=;
        b=D0RnrgA3Y/iMRj5vYrhfUSjHY9ANhZbOlKvGJOg/WB/yn7nopUzc3HJEihG2L9fs6f
         xq8l0H4O7jPg+hBThYXOpa506r64E918p9nOxsV8EpQSFnXYEqN+W3NKtAAXFhiUG5yV
         o//ubeLpiUSXAShQEhTB7tWVsfaXQoeIQXMaKz9o963PQykUgS+ScW51ySerVvjvoTG0
         VXoZOHOLbljP2GkvbNeba8qAMsSg95WckzM+rlsR0QB3xcl2GbMPI6wnoI0cXpUF/za4
         XJyThiWsziTxXliDuuGaszY5qo7B3Va5YT7wjuPbmUzUHX7kMihf9GJ85YjTOZ3nwehp
         GQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844148; x=1723448948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqtCFJHZfxqjuoiQwN6L9m6lEWWbZo6e4mfJzb21QCo=;
        b=VMACYeQoDL5jq6AtVujvX4YyE2LAcwv4HqQ9zZ9frK6XxldR5QiTaWNlmGEuP3cnI1
         rUu2xYczCuZ6JVTjY7CBSH3MHhPvLBqvtQFZUHundWnXQOn3G2i3gZoCXf5mkHmMZvpI
         aeh8Hy7nJf2ErORF9+7NqS3DPMxx1SeNEq3bxctbNcf+wzNkdp/hO4IiC6fQOl1JWpRx
         PddR0EfDXMJtGzSKfsfzPXBmYyj3Cp8tLK/PhLqWaK7Xsc1RpFzx0RwVUMm+J0Be2I3n
         Al0Lsobe6CeWGAffevZKtHUG8vVY9Oe5MKSTlkiC7+NqMj9gyI9hD/9R0LQ/NSm120cG
         kngg==
X-Forwarded-Encrypted: i=1; AJvYcCWwZgg9FSx/MSfmrOq8Wo7S0q9I6x4H9kIJZfg5xrx+lSY6Bxk+GXdFLAtdsha+7YE3fdWTjmsNNujg6kRq73kn7UyORm9l36bX3QWMKWM=
X-Gm-Message-State: AOJu0YyWDpx2n/Pi4JxBHr8In45gc2zdxbj5U/utb6mPqhfUN25Udibo
	D44NFEXwhinhMFiwiW1fIv3eIGj/nqimjidtwECcIUpdybQ1zWQvK8KhyXvK/Gk=
X-Google-Smtp-Source: AGHT+IFu7JUzbPPWsUCf+S7g+aZkSaH2v5evE4d3+S4cYsPWK0lpIiuHybfx4lO+A8DgucpZYEc4aA==
X-Received: by 2002:a17:907:6d17:b0:a77:de2a:af00 with SMTP id a640c23a62f3a-a7dc5179808mr899865966b.44.1722844147758;
        Mon, 05 Aug 2024 00:49:07 -0700 (PDT)
Received: from localhost (109-81-94-215.rct.o2.cz. [109.81.94.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0e0sm421128866b.67.2024.08.05.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:49:07 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:49:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZrCD8kRTLD67MrRw@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
 <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
 <ZqHtwqyj4seB-eut@tiehlicka>
 <l47ief3pnjdymvciylpnzkiuto7tsth6bc3q2mum3l42queggg@q573yeen4a5s>
 <ZqeCFLykU059gNmN@tiehlicka>
 <3mevqjzu2emxd2f3zkrurnzcal67k4lpkcdqzfs75qhp4uflbn@skz6q5odetdr>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3mevqjzu2emxd2f3zkrurnzcal67k4lpkcdqzfs75qhp4uflbn@skz6q5odetdr>

On Sat 03-08-24 15:15:56, Davidlohr Bueso wrote:
> On Mon, 29 Jul 2024, Michal Hocko wrote:
> > Because it is really hard to figure out what it is supposed to mean.
> > If the caller uses __GFP_NOFAIL then it is (should be) impossible and if
> > NOFAIL is not used then why does it need to check for
> > 	(gfp & ~__GFP_NOFAIL) != GFP_KERNEL?
> 
> Agreed, this is pointless - and cannot recall why it was justified to have
> in the first place.
> 
> But I think we should revert back to the original check then, which is there
> to distinguish failure cases between normal (GFP_KERNEL) and nested (GFP_ATOMIC)
> contexts. Removing the check altogether would change the fallback for regular
> allocations.
> 
> So this would be:
> 
> -       if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
> +       if (tbl == NULL && gfp != GFP_KERNEL) {

If you want to tell between sleeping and atomic allocations then already
mentioned gfpflags_allow_blocking would be more readable IMHO but the
above is much better already.
-- 
Michal Hocko
SUSE Labs
