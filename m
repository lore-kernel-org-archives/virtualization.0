Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0672347FCC
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518101; cv=none; b=ehgPzQXejzpY/lUjRy4JndOyNliGGDeC09NSkcFzag9K8wFcHqfbi56ij3hsVbzOFMVw0J+fXqsoXHC2yA3OaixvgBZNALMNY15sjsaKQd2B53ifCMXtTlMg78k0Y+K/xrYNeTd2de/vPl6NzliYbxihi0XYUEOB2aVoGr3vwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518101; c=relaxed/simple;
	bh=495kOlwnrMTCkuFmO40akfaFo9M+9mcvTROvYleSjDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP/YEgVXqLrkgWc5IrpPypo/x1PelZoL6tDk6a+grtN4INTHW8b/GsBYNh51nGYajKr8CM2HEUCxLwOj8DTZk05eE8M9AeHuV5V6ocOfkeFuDVKsfXTsddn0tzhP+w/HNiZWCWACf/LPDE6XOhVWio35Q+rn7++OFob7hrOjLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbDQZzO/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbDQZzO/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79273a294edso10042257b3.3
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518099; x=1772122899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=LbDQZzO/bPXfhM9SN7ZbaoaV1nmjYTc3sTz0+xOwjGKgA2qneN/is4BxjgtOoIM1If
         C79zRpG9rI2QDHlgGRK5EY6gJqQPRuS26SRNQVRGc59zkq1rpbVsXIoBxohj5+oKcucT
         dTvjtb74fEOHzuqHG716MWU94/GLvWcf6UdVzyoNlHv5spX0imRVLXE3tN9TBxfZncvJ
         DKc4TtwhZZX9tGKvn3rF6CLqM57u1427WTjkX4oly7c5b2U4IF1G+VRDESrr4zmIFz8E
         OxVyba4yQ7Apdk0PL+AHRfx3mKkarvOi55dUQGRbkvMMlWy1IbgxivLop1pWAuRfScTz
         jdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518099; x=1772122899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=BSkL7+8nTaJiv3j0Ds4y94vbQona1B3sLDVngA2D8+BhpyqqUFAOeSa6QkJWFoBbGC
         JfLBd6vNLltjFrC5y/TR+2X5/oqR+TIKKcNkS6h/QxoDEsdB3FxJ4YhL1cyNKV0HDH1Y
         Gl7rJxfRD0KqJ+WzUgzudcKmQZHKpESO0u5mt7G3OELWThrLCznNR8b0e2jbcGY+uALX
         ttbLuRTD9UX8na83m2p5fBHrbP0QzFC4vv9JFJlH+IJqgv1/mqokIhiPtmnXQZzow56Z
         b/B2onzwuWIDBYbp4SNH8TyZFKgzjwkuIlvB3Vwk8QBvpYmnNpS4gKDKXgFfgv8qamys
         k7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJNfba6+DpBYQ7GTtrwv9kAOxf6nyxV22dKJM2R5N4NZWQvM/Io6wFb0cS+58qlDtNl6X77Ehk0bTGqI1PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU4sofmKTXI5OlBXRYQrLvHlnEsd2WwM41gDxNs0IAHEHD5ZpC
	XcJayZW9dkk52Z/UvMb8HrQKRKmxMrKH3XD+XSmnAY/BRwMeqWExf7h2
X-Gm-Gg: AZuq6aJTNMwM/kZ1IU+P57zFNetqDruuBA6vQXARXPEEw/aq//fHJZIfN3SdCxM8bG6
	/NabrBILSM+gQBhBcf4iCQ8r1wWJET5l2fHU2+1DI7YDnsJ/f7f/wu9mtRdfNhxQjq9qdQX92ll
	1a2g9sLT6ktz/tVVFKR/N6AiaoHfBLSGYFqAw+f6taQm/gzhLUmwSNMgbthJpgWB4/qXHhOTBlO
	QvMk6gZErxJLWwAegJ8VpOZ2CUMt8N2yUHXUab9e7YQ4JCIt1aeVtIg7IfG4egIKV25jJCchNbQ
	rpgmYApdBnlDxA6uA4ul3BmcwieEQI3CZ9w/eT/dWCYbbd57Hv5Xg+haToXhfSoaGriRwG8T1Ek
	XBRsddQ1xQDehAVhB8I90SuM6PuBZHTjshBLnAT2HvfxrhaUcj8Bh+6jLUxl1npoTu84KiZViwa
	AfYxchk4f7GyJYyVlYv/LkCsa9IMEprDxMOdSGiv1P2/emt88=
X-Received: by 2002:a05:690e:4091:b0:64a:cff3:8f3c with SMTP id 956f58d0204a3-64c556e0056mr4348350d50.91.1771518098772;
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f651sm7284854d50.5.2026.02.19.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Date: Thu, 19 Feb 2026 08:21:37 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net] vsock: lock down child_ns_mode as write-once
Message-ID: <aZc4kUOikmKKCdhw@devvm11784.nha0.facebook.com>
References: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
 <aZV6HRAIsf_rNRM2@sgarzare-redhat>
 <aZWUmbiH11Eh3Y4v@sgarzare-redhat>
 <aZXlqv5ukWymz/NI@devvm11784.nha0.facebook.com>
 <20260218164119.72368d53@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218164119.72368d53@kernel.org>

On Wed, Feb 18, 2026 at 04:41:19PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Feb 2026 08:15:38 -0800 Bobby Eshleman wrote:
> > > > I'm not sure what the policy is in netdev, but I would prefer to have
> > > > selftest changes in another patch (I think earlier in the series so as
> > > > not to break the bisection), in order to simplify backporting (e.g. in
> > > > CentOS Stream, to keep the backport small, I didn't backport the dozens
> > > > of patches for selftest that we did previously).  
> > 
> > Sounds good! I wasn't sure if breakage so tightly coupled should be in
> > the same patch or not, I'm happy to split it up to ease backporting.
> 
> FWIW the netdev recommendation is indeed to split the selftests out.
> Also to bungle selftest patches with the fix into one series targeting
> net, even tho the selftests patches won't have a Fixes tag.

Duly noted, thanks.

-Bobby
