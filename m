Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81762580F3
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758674; cv=none; b=EtY/zKC2fa7OSYh9JCo+RckoYmTEYsKV9BJ28EREQA6WRzIKRpNETxtT+Eh6/8IWhPeRUlfcNimfFNwFdZxkXSZUUV+Jq80IsGZOxeLyNDjJ8/RosiF35YhD9iD8JdlOtv1ENQhjTRbvHqH8nKkkwWgBmQKy93WQyI9uXbzxKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758674; c=relaxed/simple;
	bh=A1uJoYur0CJnK5muRGxD+LMFE0Wmuv2z5f3tDoh1UVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbEBiG88kIMgSQYZJut7cumf8eIngOGd5EV6YybTpEburO5b7+FvWRRmNSdVOjVEFcg810zyNTTFN0cTEK3w55UuxtDJABRDxdKEZ3lVrldVz4nVFkwTukKcdQoc8GZJ21Ibzllais264IzXbo621wrCdSL+Yim5oM4X8R/1mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd+3QvKL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd+3QvKL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e57a373c9so5789101a91.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758672; x=1748363472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2t05IAhu5JS6yf2a0L1zsY+gn4NL8gR5pf4kfZkSQo=;
        b=Jd+3QvKLaDFbEH/ZhqeO/pFAtej4T4epxJvs8AEu+z1V0PWa3wQAGTamKqDNnqHpGm
         0McXvG0NezlqyMFXXziB3RILbLduxwVZ6cIEc/UXJDA3W26sy/VTXvpl58lIKIxLU80x
         OQpKZbYAreI5b84tV7okaCWGtnUkslwqTLS8xd3vz+7yYcmwdQJrs1jUnuvZ/0UoCeyn
         jGZ7fYGpqtuawyyiajW2Ft5sCh2GCWV+9v6jSC0KQ5Z9qrXPoiHD5jkAgkPhXDjafFTe
         vwohoGoKtwS6NXTmZzOUByatGkifvupBs0a8NANF22SiPFf74po4sVeLpb3iJQOSmeaj
         2n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758672; x=1748363472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2t05IAhu5JS6yf2a0L1zsY+gn4NL8gR5pf4kfZkSQo=;
        b=JQXirvaFewRmuFaAs6Hrc2mxOKd4CkWdpTN+bLN9ewSyYrjToSrTvpU3MeDI13hKdZ
         5SFdHyrYWPntICWcBSEr8iHy1u3/t3V1RbPyL/THGpWRxS6uV6anA88istifyqr0PoFo
         wEH/HCWU4+7wKmBo8H8WaAqCeJtLy2onF73weHBuIxBXjodWstEVig2ittvV+VG2T7tM
         17ml10fzYQg0NWrv1TvgRQU/UI9L8zbaBNHUWPtJVA5imN33bbNKWtq4lBu7eQkfWmNY
         uI6RP2McTDPD+zCJz+Q9v08gHhIcUvqWBd/gapFw1mOeDLlkS2wrELjLttnvHcV5BWyG
         stvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgQ+6bfNtUr1gz8evSaeJBBawVKRRYDjIZMvomXoulmPULay9X3BsJJkU66Fz24lX9lmuc6weokdWWncpf1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVNxendqIuZFqJTayHXg9nwmK5tLBy8OJMMPxNL8JeYaXTSI/b
	FWvWj+pHeM3kiGasVmsh1vXrywNZjVKyDzT5aCkyzw5suBv3uSCufZsF
X-Gm-Gg: ASbGncsRCdbaMpnywFtH3J4K7FSizkhs1hqz3wOWYCKAsmQCYDVcAVMgR3ZRSw/UZul
	An2DtAvF5qGb1y5eugYIQJKi/8KRWy1LDYX4ViyL2MLFTiwghCdutMxz/rh/FXM4yBEQBTCmVai
	r9fQpYWu3kOQvOPzMEsxJ675qV+rt7FuF415wg6HI8jJSVl72oNRzh3KVGN56IMze4WJKgmA6dI
	nVfbZsCz/UUxMoIPqrSGdV4XatHE0+zqa44VjWhU+119ZD2BMscMldub9ONcw3BqivyVsAO6wjV
	Ah4Udq6CWgM/5TTZgqw3ebLacSgKudnrDKdWkM6gDyV7aZ0rrGassptclSexJw11K5gyXcE=
X-Google-Smtp-Source: AGHT+IEtnb8aYdRjb2chzZc4KFgAuKLohjg+W8+FnvIkeyuCGBJPJPSMAMhgJm+kE/2axZm/rVc6cw==
X-Received: by 2002:a17:90b:570b:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-30e7d540033mr26297107a91.19.1747758671634;
        Tue, 20 May 2025 09:31:11 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8290669a12.49.2025.05.20.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:31:10 -0700 (PDT)
Date: Tue, 20 May 2025 09:31:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCyuTMNkRzCBMp1i@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>

On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
> On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> @Bobby: AFAICS this now has all the ingredients to fit NIPA integration
> am I correct? the last commit message sentence could possibly be dropped.
> 

NP, I can drop it. All of the ingredients should be here, but I haven't
completed setting up an environment yet to test that integretation.

> Still it could be worthy to re-introduce (behind a command line option)
> the ability to build the kernel as per Stefano request, to fit his
> existing workflow (sorry for the partial back and forth).
> 
> Thanks,
> 
> Paolo
> 

No worries. I can add a "build and run the built kernel" option... it
should probably build the tools too to be all streamlined.

Best,
Boby
