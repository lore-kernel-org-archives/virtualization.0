Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963083168EC
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587757; cv=none; b=lcURmAUTOBFnPMB/8Z/68mDRd0JqZQFaCxyApqIOucMDT7BaX0gC+WzoleRVYZWhJ1I1MxB+gU2VI47yK3BGOqc560qhdPBno+X5VwUzY+Q0IYYPbSVNM6B9rnAd266821Gcdl4Eavf82wt4H2onqOh+t4Ff4sDXfPhZ+gvHf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587757; c=relaxed/simple;
	bh=s0NTkuxgo9nTW1wwUPyDTmWbVEsjdGmA1omaFkoHwoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku+MvvZkpDBPEy9fsqR15aQV0QIOUTRsRshY/BblcvULhFVTHhPcz0URXYUSbRVWk9VdVRAhSXuOFg/ZRkgSgPgoXYfbx12ORlgsGKhP4aXhRGKuGzk0eBgQFjbXRwjOo3fIVfgAxHuajz95nZ9f8pkERDR2HuTSEzhNpyvwNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6YCSLkq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6YCSLkq"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7849c889ac8so87116707b3.0
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587754; x=1762192554; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t90v++bIrJi1Md65JkXT8gm2ApX72FdJn0ubPYfRRrY=;
        b=G6YCSLkq27CtqVV9WGNRtVfO97xrwdgLVJBFCn0Uvg2xUFuYe/xsQJQ14RxeXw2hTH
         d4U92JKtCkJ+pP5GYD97Wo3ICW9DravL7yf2HvI4SJd1ThfI436Wk1lc6jxMY18Flk/I
         tqYpzkB38SGwhVP3c4tftwhN9UtRdqKAawwCYyq7RqN+5eMW/Lg63wrqaou5LSNtsKMb
         K/QGrofypE2KHEXoAJA+VruoaTKFWLtLP5aOxONMMUPjCOCSoKKPWPrT1+w77LIlYAOL
         sQBSQeD6ZRxFFJNlpXykrIi7jUwbua4ccoraIPtnTE5AarrPREV4U4CXDLRfSTNw+3ao
         ky0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587754; x=1762192554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t90v++bIrJi1Md65JkXT8gm2ApX72FdJn0ubPYfRRrY=;
        b=oHuuT9wtc4G6Sc0MRfRXNyxzIBhS++igQ08AzChtqxcQTNnFVJn/Yqb/KR+4YISIq+
         64hePfQck57/RBBK1AK3vbvl9kZC6DzRx29CKhcjO2uM++MI2P3lmQ9IV/C35HBXa/3m
         8p8lZoMkr67nHk/Zu+w4jAq31Kv7hmpieREsFyvQZSx9+QKFYitLJmkxY7TseUOA3LJq
         1VtIdTutLH68+W4J13sQ0GlkuSXJ7z/qPomPbORyqQqiu2N39QS8a9hhEKRNF4oHRXN7
         IZAvUMBHGbecKg/16LY80tAwxHEg9UQ4tOJfnUrys4Rv9bWtlo0L9ArBeNH67fU1dfJN
         87eA==
X-Forwarded-Encrypted: i=1; AJvYcCXowlJ5FTio6MUZV3YYA5i6lHF9Wm6hQUwMekyAPbCaENHdERGmEYr9Eufze6JVseTHQAJOAGo/KCKbmBLHeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywqb5Zz1YznpGeDmpZC4dPnNw8HGKe6i9uEruZ4v/3WweHDtxrM
	OlK1b0RnDGmWDLgitsgX7U7mq1O2GF7AbaIhTN3sLKotO8hBZKoma7/K
X-Gm-Gg: ASbGncsnxfQsgdS+lgtriVMT5iKLdUkpdZHpneZ6lf/KpKTtChs0hqlE8SvsoFMmo80
	e+TZV85/1OgdZBtP6MAuuAmuSpSD2504tNIs2IPS1SqxIB22mv7zN0xMIkLizR3WJYkjkB6rr0A
	p2Rk0AZv1ZHI2o5dxO5Sn6DpZMbfAEq4hkVJd+olLnLBUplzVk748bzFBRmLFHEavMGmrsN/zg0
	CHLkhHdG6Q6M8wFnP6XqezHha//t+TDTya7ifpugvgp6YgntvPPaI2CAt3nrcOcdOicGBI4W5if
	q4yQf5bmOoe0ZI12weUB0ku1z1PjZ5WvBUBU/DbxcgeCZd4h86m4qDdU/Sei0IqccsMiBAb09ce
	FARzfMy89wE2vaODxf5upoZc4vhEKKvCPm7/s3geJYPpkEQFn0oNL4C96R0s8hFAgfV0gqQnWbq
	5jmPJ67cJZVSj4N3vSL+WiUkJCLzRLL7Sr5/RtBiv3y9CGIaM=
X-Google-Smtp-Source: AGHT+IEnq7T6tW6sESfh2/pS/VtVB6j5wsUZrO0cK7EA3RoMmtv5EedE7kUOtkxVYgtnLyJeX69FZg==
X-Received: by 2002:a05:690c:3510:b0:781:64f:2b74 with SMTP id 00721157ae682-786191bda08mr3102477b3.29.1761587754496;
        Mon, 27 Oct 2025 10:55:54 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1f2457sm20784977b3.58.2025.10.27.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:55:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:55:52 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Message-ID: <aP+yKDYZR6+/kzI2@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
 <aP-iXJQVPBCjfPHi@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-iXJQVPBCjfPHi@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:48:28PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:06PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Save/restore pipefail to not mistakenly trip the if-condition
> > in wait_for_listener().
> > 
> > awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
> > exiting upon finding a match causes false-positives when the pipefail
> > option is used. This will enable pipefail usage, so that we can losing
> > failures when piping test output into log() functions.
> > 
> > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 561600814bef..ec3ff443f49a 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -243,6 +243,7 @@ wait_for_listener()
> >  	local port=$1
> >  	local interval=$2
> >  	local max_intervals=$3
> > +	local old_pipefail
> >  	local protocol=tcp
> >  	local pattern
> >  	local i
> > @@ -251,6 +252,13 @@ wait_for_listener()
> >  
> >  	# for tcp protocol additionally check the socket state
> >  	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
> > +
> > +	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
> > +	# an error, causing the if-condition to fail when pipefail is set.
> > +	# Instead, temporarily disable pipefail and restore it later.
> > +	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
> > +	set +o pipefail
> > +
> >  	for i in $(seq "${max_intervals}"); do
> >  		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
> >  		   grep -q "${pattern}"; then
> 
> Hi Bobby,
> 
> I agree this is a problem. But I'm wondering if you considered
> moving the pattern matching into the awk script. I'm no awk expert.
> But suspect that would lead to a more elegant solution.
> 

I bet you are right.

Playing around with awk, I find that this seems to work:

$ pattern=":$(printf '%04X' ${port}) 0A"
$ awk -v pattern="${pattern}" 'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0}
	END {exit rc}' /proc/net/tcp && echo FOUND

I think it beats doing the save/restore on pipefail?

Best,
Bobby
