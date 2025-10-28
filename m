Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34C34A776
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675616; cv=none; b=Y9TZ3Obr3gbgS/tTUW/Tshp4SIr130P4sOlh23KSsTSAAweVF27Xqq1p2zzS1ZC3IrLJse+nwNMNkFniY+LI2dF/LWA/StUTAqUpzBqZJzyqDP0KAuWjWuD+zufYxK0cHAT44gsRJoxndgG/4BDErBO5QqfYkCGyBJIav9u0mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675616; c=relaxed/simple;
	bh=fVD8zVGoOJR8NtTaumfAAfOnBXb59cGQbZXEVlQfwd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfs20Vt9sxiNZCvObRndVMGN0dmcZrJzySUG9xZmMMouKt67UfITaegawTs9C7SqJOFQjd8fsk2Vnty/AI7Ioctl7aqr3l9atOd72byENECFqDkCCltulV+07bQo2Vm04Hqy9TPlHrAz1fcHyV113OfoGTdRgabk0PJaDMVd+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXsCIIDh; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXsCIIDh"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e3568f90dso6587051d50.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675613; x=1762280413; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=aXsCIIDhWdOGbTCGG6qICRP2bgK4DguUw/MYQA3IU4uYcYUvEL6pizSemLYKltOQiQ
         f4HPEEvnkG/stLHIc0xTfhnK7FDhMWo2FFS1okuU5lIIe+bofSpJ5tj+YUWcv2OG2oFb
         wWBwZeOpemASTxmh+4Nrd4mYYGo5KGQQCZII3qBMyFs+f7yWb7KgQFvwQOAliUm1rg+t
         igM3uOC+cP1WLdvfqsg/ug6De71+zwpVll94U0G0DWKNPy4saex0A1lUBb1q/WEehg+c
         eSsdqjtPfkp8jZ5pTwOowT2QMdRU0dlcL4wRRPNgQxZktHDBg09ScqQB3gbXkgWkxECm
         8RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675613; x=1762280413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=Mt8pNjUWiNKTy9+peuKNo02rOV415rRwwxhdwyAL8+T1a53p1px+E/jVyFbrAFEOV/
         /huSBQoRrq7vuXbKWD8OmI+WTEuG5BlLeUd+SOBrCOUfYzlWlmESHOpEYq7gEFujIbE2
         CbR90lttKc4sBKh2d2i6xi5RMLu7NKMfNC8vZ4VLJfvz0gQUl6hPzTAw2oDpdirJdyTx
         ijEyBXbV7+gZNRntCfej1vqy+2JaZB/924IhArgB+Sjin4drKa/MDT2iSLNbBC57GOQI
         k106XQlOS4E/9ig0AXslhqzKl0GOazzvvd/gKTywleujYc7HLAJR7+dmm9pzDHm6mnZl
         F/uw==
X-Forwarded-Encrypted: i=1; AJvYcCVuMDEcX6F0nsepJ4Q9mnFtN8VkMadgjvCdWZQz6g/3n0Pg/UXEYhld8FxlOwi1KiZeCGzg/rkzcjT1AKZh5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywjog1Z1wmOCYzFL1zDne3vStX6N1AgdKnswN5xwouoUQ4baaBv
	DV1m2o6sd+0XOTMGDbP3alvyeAk/fFOnnNoom85g1aTsq3EE8dgp9gJ8
X-Gm-Gg: ASbGncugx2xP0P1pHiVA/NJuqhTNee2O161oVSPbIWbNw/X0Whq8XzYdOaeeOSsX6Ti
	TlCDUTzDHfRQaV75VVmPPbKs2mkGivsFmlvWTvSN3JqARXXXEz952eb/rstP2OezvwHUJPyfSEx
	rc24SprkyesqVcH9fyKAo41jnol1Wt5xk7Qol3L8U0FI4pGoGN09VSq19nhz4FppIW8n7gJPqnq
	ikn9/BjwGLJCgLjhOxLQ3j0h6uQr3CdhTWVblCd/x0z0htxrgq6GQcvmpbkez+co8vtKTLcJHEK
	XKBG5xSKcpYRSRg5C677T64K3ZVEYW2w4x3hFrohr291sADrj7uvM0kA3VMTsvCXiyGTAVZ7rFO
	D+ViMdNXWGpraX5N7buid8G8/4uP3Vun/rZWzwpgj2Lc21JbQ/s7ZZS2txs7P4R2CEIDZ5x7HJ1
	CRVjcO1ja/LnKEHTr5bFV0mjkB1yeAewaksvUc
X-Google-Smtp-Source: AGHT+IECradbC/V5zPn66y4q4ZGUhUmHrlC+iHH0inghtcGySqIEBdHH/OeoOeHNcRqi2EB+aeyQgA==
X-Received: by 2002:a05:690c:25c3:b0:783:7081:c48a with SMTP id 00721157ae682-78628e7d68emr2711617b3.26.1761675613298;
        Tue, 28 Oct 2025 11:20:13 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed14081dsm29213987b3.6.2025.10.28.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:20:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:20:11 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQEJW9hGIPbWsRhM@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <20251027162244.0101a099@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027162244.0101a099@kernel.org>

On Mon, Oct 27, 2025 at 04:22:44PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 12:08:48 -0700 Bobby Eshleman wrote:
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> > 
> > I also see that SC2317 has many other false positives elsewhere in the
> > file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
> > unreachable. I wonder if we should add a patch to this series to disable
> > this check at the file-level?
> 
> Yes, FWIW, don't hesitate to disable things at the file level.
> We should probably revisit which of the checks need to be disabled
> globally. But file level is also useful for manual testing.

Got it, will do!

Thanks,
Bobby
