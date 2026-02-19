Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A433D4F9
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517168; cv=none; b=PzZlEiHwBo9BZ9N8CuCnxrF0BfZTA/Vd7EXNQqsBZ808gtvXbgSsDGfU8gARtU5Zh0MoYUkm2ktu1EtmY7rGxWk2TMrDhBx+zrPaFxFoq6wV6i+PAbtC2J7yX0hVvqnP4p6iBbcd0P+SFSNYdg8eLtOtAdJNnMtezGo2Xwdas/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517168; c=relaxed/simple;
	bh=4yMC99NeJMMCPXT8o7FBF9zbcjvh5tyBVPAtjWfERlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3s3/kn10Jmd+RiQ5a7rtTPdFGZEm2jzAdAZILkbR0ekj0Oo6iQxSX/9sc9ejtAmMmtQwAJ+VTHt1d70zmgyn7nDvCLYAeE3QfofsIYCeWYgb7JPwGBo+TfW05DjW4dYc1RFLlQ3wfCBBRvhHSUhn+SSNLW9RgYET8hCm/l3cPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/1QTYBO; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/1QTYBO"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-797d509a2f5so12779957b3.2
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771517166; x=1772121966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJXEV0fGE0delcXeFKX2uACQoYyrpadO3o4R7qcFW9g=;
        b=D/1QTYBOj7d4+90Sgv9t260vLZrULwAQJxcpAWcXlpksnPKJOKyRaKSGTg0l26NMd5
         X8FD0Fs0czEZliMWZtUGfdy7x+5ej3k/3lDPb6xQxJPgM6cZFCTD4DdcCV+x928crmYZ
         ixcUgoODVs/K7CAByPHuDND1saJN3a9ZKcmfXksHM3uaMJ7BZYeQbz5BlX/zDzFvKXl5
         Cpt5zv87KcHBfi2akxxJhOUyHlLhWc8ONu2/KOAj3zcSHyc3MU5D5VWBfHTlNtGZH9gg
         WcvcQ5CfM1HQYPabFKpOxqPQBJmedvJw6ePh2uDOJyyuf6Pw25JGzZhBAH3DpHWDcgbJ
         S6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771517166; x=1772121966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJXEV0fGE0delcXeFKX2uACQoYyrpadO3o4R7qcFW9g=;
        b=dEqlxuOroVCFmREj2GCFvEQ1f3tlfUfcLGNdiZIONoy2DocZUIKxa4RjwQS0pTL/8l
         ryHNcwgrqqTP/BIL+wUsJRGZufmfjea2omzPerOyNteQZgpPC2Bt6WMIMeKL9LsAF2uV
         8oEdVg3ULNyqbx9GT72mp3VYK3m5+pK+0E+wW0ruDYGTbxXqJPqSkpdSAE9WLJIBJ7pq
         kdnn0VwoUpkEXYg3XCQ3QfDh5jdXh3XeFANUCch4a/G5VBvUIWEw6SjdbQ7dITS1PeUu
         X4lErMfYQGgIdX2VjK8NpzFRRQkpk3sLwU4TUA+yFXcRq2zIy/iXtwMX2qL4UEQ+Mk1g
         qzNA==
X-Forwarded-Encrypted: i=1; AJvYcCV55e54lc+spLkq7Q9SxHU6dpzgTVsExIuFc6FWH2HWyQKRnKtNivfWgB2Idczs4CibPRdOK5wMhOgWmcjZjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs2y7P5Q+o0TQrNW16Uo3cutaOY59ZV41iC1UBQAFUS+jOEFSJ
	+cKsY8HxPqFSuwSuC01sAOjhdytBK+m15COfpMU8JC4lsqon2t6E+4Gd
X-Gm-Gg: AZuq6aIHIDVVF4SMH2U27p/qfprt9g4U6Iondwmq61TRXYOxiYA9hZlAIgXU5TPaARu
	hrP6V/WUITXolGN8lDicW1z5OGAemQyD3Ye1YHDfhzw1JZ7TK77Kv1SK84q2mnjc0yX4n/eMUej
	Ti5Od2xEtgMnvrnu13NWjY5e8IV0AV7GvxS6oOvnqix/YW31MPkI13x2zBdqReUs3KBghuCDvXz
	iZmOM0wiW/oO5z2bMGp4K9c9bQFmHMGF+qL3XVJj96z7dFNGVhpjiOnP7jSj0zWglA2EFQaK7fQ
	A/HUuAUdVRbM59FsfZsyg9sn+YVdrf1nppOvEzspNtFC85z/ReepiAygpDeyqTCpLyFZc/ZLG/P
	xdaIROJTYvQUwbdAE0a/qnR5gKorU8Fm/OkN/KJIpN9sKQi4qOlCLrxje0fvZ99GwIAwbu09j8l
	KNq+pByp6cvBUv52nM2zppDD5wgA2dq0trdCRtghIMGLnDfMI=
X-Received: by 2002:a05:690c:6c86:b0:795:c78:b633 with SMTP id 00721157ae682-797f73f4d48mr49916427b3.62.1771517165867;
        Thu, 19 Feb 2026 08:06:05 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b464sm135320017b3.13.2026.02.19.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:06:05 -0800 (PST)
Date: Thu, 19 Feb 2026 08:06:04 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZc07N4BFw0hhnoZ@devvm11784.nha0.facebook.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
 <aZbN8fXtCkhItSV8@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbN8fXtCkhItSV8@sgarzare-redhat>

On Thu, Feb 19, 2026 at 11:36:40AM +0100, Stefano Garzarella wrote:
> On Wed, Feb 18, 2026 at 10:10:38AM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Update the vsock child_ns_mode documentation to include the new the
> 
> nit: s/the new the/the new
> 
> > write-once semantics of setting child_ns_mode. The semantics are
> > implemented in a different patch in this series.
> 
> s/different/preceding ?
> 
> IMO this can be squashed with the previous patch, but not sure netdev policy
> about that. Not a strong opinion, it's fine also in this way.
> 
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
> > 1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index c10530624f1e..976a176fb451 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -581,9 +581,9 @@ The init_net mode is always ``global``.
> > child_ns_mode
> > -------------
> > 
> > -Controls what mode newly created child namespaces will inherit. At namespace
> > -creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
> > -initial value matches the namespace's own ``ns_mode``.
> > +Write-once. Controls what mode newly created child namespaces will inherit. At
> > +namespace creation, ``ns_mode`` is inherited from the parent's
> > +``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
> > 
> > Values:
> > 
> > @@ -594,6 +594,10 @@ Values:
> > 	  their sockets will only be able to connect within their own
> > 	  namespace.
> > 
> > +``child_ns_mode`` can only be written once per namespace. Writing the same
> > +value that is already set succeeds. Writing a different value after the first
> > +write returns ``-EBUSY``.
> 
> nit: instead of saying that it can only be written once, we could say that
> the first write locks the value, to be closer to the actual behavior,
> something like this:
> 
>   The first write to ``child_ns_mode`` locks its value. Subsequent
>   writes of the same value succeed, but writing a different value
>   returns ``-EBUSY``.
> 
> 
> Thanks,
> Stefano

Sounds good! I agree that is more clear. I'll also remove the change
above that adds "Write-once" at the beginning of the paragraph, since
this clause does a better job explaining how it actually works.

> 
> > +
> > Changing ``child_ns_mode`` only affects namespaces created after the change;
> > it does not modify the current namespace or any existing children.
> > 
> > 
> > -- 
> > 2.47.3
> > 
> 
