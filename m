Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7D1F1509
	for <virtualization@lists.linux.dev>; Thu,  1 May 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746112350; cv=none; b=XaNsRz2JPELzzxksw6Z4HtP9Q2iD2iCryl5mdzLrUwJX2LWOf6WFmf0ghxN7ZfSSn2XAnYztupbpb9HAJcfZkwz6nDf8+v4mtKHQ71sjaxwEPOJ9mJVf0Uze5ciJARExrpHfuY11LPbLqEIc6LFvGQNCGZPcCJltXG9mUZhPhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746112350; c=relaxed/simple;
	bh=dWnGMRLuuiig00/q1qNO4cfo1u8O7FAVX0O/ycoMXU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfOwTRs6KAmfxovF3ZXSR0jSi9cLVErbrC9Yy7l4bPN7yPKSUMDqXbsfsqD5ZKUToJqjs3lO+/nBUZxxcClJcyVPskcRLZkI5C4ywJQIHOhe7Znc8w+pZYLKdv3T/HXpswoBzjs9E2clpt6lA90i2EcOpyhGdXgkB4EdKA3dgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EzHUHdJ9; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EzHUHdJ9"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d812103686so3831895ab.0
        for <virtualization@lists.linux.dev>; Thu, 01 May 2025 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746112347; x=1746717147; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiSgvlc+jgTt+SalF/TBVD1MvIkMlCI4kO67DxSibGs=;
        b=EzHUHdJ9hINhEkOBfHg57z+NgTw0v/eeKq2QE3VrJZ10mQ6ZNVBZ7rAbbBwQKVRZud
         a4fyQmd+/6mYr+FM7s+wRc4sFZTMH5PlbyjTMkwHIxS+RdwLTLdSENi6xpWRdhIGPfP1
         DiWiEjzEyVDjQ783FSRYRwaGJlN0GT9i2OpoE87Mg5WNBDM8w0I1q07gC23io0cLyPtF
         QkG3FYGas+Nv+YeWjerzEMRUCaob3hk7+k5W0Ekr7ORYQ0v9EFvw5rYEjlMsWeUJSSWA
         QlSJaa47q0yjj5VCqpAliRsushU1Da3n+ZQqzfiZEWGu9pcH9/xJdD6j90lSysCaBesS
         I49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746112347; x=1746717147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiSgvlc+jgTt+SalF/TBVD1MvIkMlCI4kO67DxSibGs=;
        b=DSzwf69EP7cR2oe4exghtH/LZSVzRsu8gFoWJJCEcSRJPCIGKUavXxxvVgE0cYplE3
         +Brz4J+ZDPq9B0SxJus3z8ZyMYZqxCawEFLUtREBYg29hBshFzA+lPERvkLaLz34ab3X
         OgJZmO6t3TK9oyH6l2T1g3fpbj090R/E578DsZUkqUxtIa3QNggAaDaBJO46OGuIneTs
         LVtJj4pbuuUuYXygcTARE0HyZyN9TQnKsl2WaCLS1qdNBa1xxHG2v0Z/qUyAyHlCliUU
         3bVClirU3oiAwQoRnzsE1yrsQZiWtuc4MgO5lijQr0cQrZQEwlNiDBGk5BYaCmt///2x
         /Utg==
X-Forwarded-Encrypted: i=1; AJvYcCUD7mKX/J6j2zyrBxjzkeRUI3AXpBMyjBM65OOcW4s6yfLUm9IoZMHC224YAvuBSTycGc+lQotvJ7Ohn8TN4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YynZI5SyA0slJH0fISdN56HRu3Azi0+Kak5G1GwpMnm5GO5BzNs
	Py5PWZrUuubZa95EEXcuN7JSj/GcPcS+ZS8XyOqEFFpjx1VMZF6z3O+oR1R5YOs=
X-Gm-Gg: ASbGncukHS+MNrdEPPX5RPNbW4np3ZxFaW2toK90XGOSQtByeSHiKLCp99L3X62Mw7/
	VX7DiCIEXiDin7ZPNMmdZPA4RiJx1Cd+Zun1hPIL8ZZpdbcmgjemrYwkQuokaWBLuN1/hXKRLVr
	qq758U+O2qkkJ42nd2JKA78xpV50tpcw1IsrYFhImobFpZIVWxf61JzYnhf8M7D1Efr/ZCDm58O
	j0Ga711oAmN7xFW0RQaryroAXWn9TYoZwdGG04VhoqRqo1ffX69xuUVhvx+LanPSZAehRbNan38
	rFB9nOFppzXfxoKbVHiPeRA=
X-Google-Smtp-Source: AGHT+IEIOmyJqg0IDfnq12HF/KNZxN2C+QMTntsNo+GE5770dKW40hle7cceFLWUyRubp7ZQk3Lr0w==
X-Received: by 2002:a05:6e02:5c2:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d970bab314mr23866965ab.11.1746112346920;
        Thu, 01 May 2025 08:12:26 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:1b37::2b6:2f])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f882ead968sm224915173.12.2025.05.01.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:12:26 -0700 (PDT)
Date: Thu, 1 May 2025 10:12:24 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Keith Busch <kbusch@meta.com>,
	seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
	leiyang@redhat.com, virtualization@lists.linux.dev, x86@kernel.org,
	netdev@vger.kernel.org, kernel-team@cloudfalre.com
Subject: Re: [PATCHv3 2/2] kvm: retry nx_huge_page_recovery_thread creation
Message-ID: <aBOPWGPTCgnUgtw-@CMGLRV3>
References: <20250227230631.303431-1-kbusch@meta.com>
 <20250227230631.303431-3-kbusch@meta.com>
 <20250304155922.GG3666230@kernel.org>
 <Z8clO24vFqlDdge4@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8clO24vFqlDdge4@kbusch-mbp.dhcp.thefacebook.com>

Hi Keith,

On Tue, Mar 04, 2025 at 09:07:23AM -0700, Keith Busch wrote:
> On Tue, Mar 04, 2025 at 03:59:22PM +0000, Simon Horman wrote:
> > A minor nit from my side:
> > 
> > As you are changing this line, and it seems like there will be another
> > revision of this series anyway, please consider updating the indentation to
> > use tabs.
> 
> The patch is already applied to upstream and stable, and I think Paolo
> must have taken care of the formatting because it looks good in the
> commit now:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=916b7f42b3b3b539a71c204a9b49fdc4ca92cd82a

I backported this patch cleanly on top of 6.12.24 and ran it on some of
our production nodes. I compared 6.12.24 to the patched 6.12.24 over the
last three days, and we saw a drop in ENOMEM reports from firecracker.
It also appears our VM's to be consistently spinning up again.

When you said stable here, I checked the stable queue and lists, but I
didn't see this patch in 6.12. (only in the 6.14/15 stable) Can we get
this backported to 6.12 as well?

Fred
