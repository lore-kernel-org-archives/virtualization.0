Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECB258CEF
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656087; cv=none; b=AAkmn19/Xa7//Iov83Tu8b8PLyy48xEclaARRbeESyWK0w0k4BzQOy0aK0/Te6/9eM65gmG4m0RDs0abVl4wK5Si69JtmPUgRu0TkBcEIoLj9Wri5vQZG6EWPf3Jqg8UpM9eCLk8K0ok+/Kidv5zeYZPlvToHorneMugsSTKcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656087; c=relaxed/simple;
	bh=etBe5tS4/ktbP7b91h5lJ7bLsJwtJz9vOdnnm/WxrFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4biNB5v3U7k657KXxKvrUOO0EirltqFAB+jT2KOifsoE/qNxDHqN1bOIWiOWvCLl9pd/aniqEXQW2fbypndnW/iZj+iCUqBF5b3pm77grsBZc0tkc4Yfy8bob6IVCGe85YuNc1SxVgsSEODa/g8JLHlRNj74AJzPZ5SKtULbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHOLJOLY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHOLJOLY"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso9974863a12.0
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656084; x=1759260884; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++d3dqdiBWxrOtz0QgpiS/0g7+oJyTqlQjLbyxgEnJo=;
        b=XHOLJOLYZI2J7pfM4FKjoFPxF8aLSCqkwyJFhWAGu43f9aA3UxxiSOHQ43X7fF+ZbQ
         /chfL7PCN1wtn2H4YMpYMQJxHK0qtv/vIRc+6JHUuw0gHBkxrq8bWf5/j4B8Jgzw06Qw
         Jljt+V0VoKISzkYJjpgKMO9FOHx2GhsVzjCreulwSYMPOxnmAJbWoMfDW2Kts985B8RB
         4WbbEOyew/WBA9HPBGe3xP6aBQtZq+IhZp20w7CeviFF1heE6WfqPG/XdS5IkJ+4LVGo
         MGxGdhyj5VybJoaMTwsVji+KV40mdzCmp/yNjzYGgGi7iwQXZgiEvgLQ+o+wf1VFEAu0
         H1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656084; x=1759260884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++d3dqdiBWxrOtz0QgpiS/0g7+oJyTqlQjLbyxgEnJo=;
        b=hweJjvkvl9qU2/+hsnf0/mCN9ZTHFIkKGGEiXQpJSkkIymCv0hRJwWOFGHwSf6+Pzu
         TY909VytZyuBczWQQ0emHvvc6V60RingJb+BvG5l5zqpSdzGoU1XghQ6SwlHOAyrSML4
         H13vrpm8EpKUPvEYlM5dFVtCQma3/poAH+xq1ggWJOzuKEAiNg36TNYUvW92LIN+RuJZ
         hH4Hcfhr8X6IGCuMgj3QKB6/UQ1LAQK2vaSZX0jaw731q4a94295CZlgn9TOaQC5ApcV
         lgU6gf0asNpwJ22Zve/pxygEFjx3PyVIE3rSBRHEEX7iHIYsAeiDL/vueEFHCbltFpAu
         N17w==
X-Forwarded-Encrypted: i=1; AJvYcCUm97RiDrupwqWLf3mWLpKy+ZhJ9FXpQEw81sPOlHz/oj4GR1a1NlcTs7aSl1/w+uD1d0SXRhl925idQy76UA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfdWwBqj0xtPCkDPXUUaUu+yGDYCEWrqz1+UD9LdEpsuwLQ9sx
	RJwpTjUwjzNR/Vp1ZRMkXa+Ke6myxBEE9DjtGGtQlB9raClfFT/3VXoZtLhYhHK9g0r2+aJwLcz
	tlazBSCEjiE5qTwUGClfFYNs3O3exSdc=
X-Gm-Gg: ASbGncspYqpKHkMGK417wBLQhn5IdNpyW5OhjdBHKpEMJdGQK/sHtJU9wEK18tbFw6T
	rgB66F/wRs9QhhoQAIh4CA6YplXVXY29Qvu1kugNmeMJR2I8FlldESSRdtOcwjDCjZ7m16TCulZ
	1JiNUM/lT0e7Cc8dJ8TdhKOKiyHjd+yxQ268zsEvF5hwCp9A1v4+tJdyjQh7v1UZxA5+CUUgJ+1
	rKE9ToK
X-Google-Smtp-Source: AGHT+IG+y6U2HPtJWiJ06zINgKFsCV3h5cNmzOdYimKubd6x0uYI1nvJ7cf5K8syyZNEK08ri4tKiPSTOpp4XlvA7nY=
X-Received: by 2002:a05:6402:520a:b0:633:8c43:eff8 with SMTP id
 4fb4d7f45d1cf-63467a15e4cmr3129540a12.36.1758656083579; Tue, 23 Sep 2025
 12:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com> <20250923171819.GM10800@unreal>
In-Reply-To: <20250923171819.GM10800@unreal>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 23 Sep 2025 21:34:31 +0200
X-Gm-Features: AS18NWB41C3D5JsYFHuNFW-M81tws8xiK0mHlB-cBnQqvONalyjABahoz4jqIPg
Message-ID: <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

>
> I will try to setup Alpha architecture in QEMU in following days, but
> would like to ask first. Did you test alpha on clean v6.17-rc5 (without
> my patches) as a reference?
>
I'm running now on a fresh git pull from today so it's more like a
6.17-rc7. So no problems running the latest git at least.  I can
dig deeper into this to see if we can figure this one out. First
of all, is this alpha specific?

Regards

Magnus
