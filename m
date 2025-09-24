Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E527B4EE
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699141; cv=none; b=mFG6a1nMKGpdjebeI5iGgo72dUfYo6lhxsV6Mm2SQDzTdLRP5bbKQD9Oz9gfQRP1wA3UGDSbC1UXO5LCR08jaF17zNetrhz4GkVCIrtOUGss/mrC//BYNLdLT5EGQ8NDbvECHdcdnx54ODmEo7nKhaLBHXxlZAEyCHZbmTs/MXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699141; c=relaxed/simple;
	bh=TX6kI82yO/RlICOevJbAdNu2g5LXBtW4mVT11ZayfNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwFj4jtNjb95JXZG/o9imm8fMkhSPlzRX7Z+OxJ3dagUpvHlBWkc3+1KcfprW7x21kVmYW9zH9ojQ0UPTB+dG0EKKrDk9AyMLG4E8lBWaOQGGxlbMnT7VsRdgMSNn7Jb/XG62jjoipjlWAiqmotNuCshdXXX4v8pUI9Uw04qEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf05263O; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf05263O"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso9705330a12.0
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758699138; x=1759303938; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=jf05263OmGAEBBo9wyQxxvjp1lpI8rBXAJNOw4JkgQSU6cTIlme1PKtB7iS2LA9Var
         /fS8Aa9DqHQPFkSMQ4Lgo81W1Cevh2dGRU9jFcy93Zw1VhKDLw93O1Er5i3OfoNzz5kU
         cgkcV7GgXTCxkpG3/1IWvVoOsvyI4tXIzDzWijPXnPC5u8z/mVREIHrite34vnztYedA
         OPgFQaBHu9zLAu7cGwWG32/0BaeNclgGsGSJXRi/XMbPrBUrkK5tJqT/FvdKtRl4eD5D
         aZMMq1nnvPGY87chtYTuH7KYO2WzU6HC/Uu1Oy6f9aMXL296Xh1HZ5OeVv4fIE6f1VTK
         AlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699138; x=1759303938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=hNEpXghTvud0GPnmpPlK0OnrT5HX4qSgYW+g/R3Twm7eSDWXrRh6R+3kEvVInEBDxO
         CwM9i1vbMHUv+3fdfgDZVOPY/59c4R4/hnuQ7hK2im5bRS9eiKDvDMcLlq7PVq+1Qp/B
         UFL1OfO486Tck3kBZ7aTeVyoAC3SM8n9aa1WCMlfzz/0RBc8FO0qnv2OLVQ5/P4DHDE3
         1Cjq8G8Bwa9AuZ2FGuX7yG5oGHpa/38WiLfLoguLonxdY1DRnCKrC5sfqXc61020GozG
         nj8haXuaub2WwECCwZ2gRuyTVmRWorC0xd/OmQz7xjRVPirh5LVNLl61vdo1cV/u5a88
         hItA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FIf5mNgWMLlOC1To83XQpjWCRJmXO3ligx6vPHgYejOHy2U2kW2wuqwgaDmEHivZOEnEK9apZqbEDKuKGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9LtHr6i5tnu+i8URhE5/8Zx/3f87Wo5KP/F1YC7IX1Y0mSSpO
	UqnSf0AhsG+Lgw/q0TcsfmoenBBAG5ITKKGFgrUoWwtdsSurhEXm1dFMjxtQB9DtQ/JZ04nN9YH
	bT+6FX1/wVtRI/dVFVSOgS+lKI6/b/NM=
X-Gm-Gg: ASbGncsRQf5Nza+qZzHaT/IiADCSFC7cO9C4x1GAEMSP8vYGAMmk06K3pjsF73pA7pu
	xCIHdW2Ddr+ONeV/cdqFolaBXErkpr3ajHtuP65hBFTRb0T76QBmrpHUarQKtVi/uWEediJbEyV
	Wv3gqLNadGd8yAvt73U7cXqA4naIaM5WUXNGFgt2HPjloLqqBYg3+K2+VFofnlW6ADtp2MjZyYc
	V70Xo/w
X-Google-Smtp-Source: AGHT+IEsD22J4a5V9bbdMWtQv1Ep8AmuRuA2KpP+ndq9VMyD7XFtjS94kSm5rlJirOSxMvazqqoNAsq4GX/ON5RyqyA=
X-Received: by 2002:a05:6402:44dc:b0:633:4726:a077 with SMTP id
 4fb4d7f45d1cf-63467796df4mr4258422a12.15.1758699137992; Wed, 24 Sep 2025
 00:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com>
In-Reply-To: <20250923235318.GD2617119@nvidia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 24 Sep 2025 09:32:06 +0200
X-Gm-Features: AS18NWBrVH-9-wBlZ7ZFV3RxYYp-7iSL9DfIPq4jDzU8rxFLx7xmKKzveUA49as
Message-ID: <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
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

> Suggest testing the same branch with the alpha patch reverted just to
> rule out any issue in the core code. If it reproduces suggest to
> bisect Leon's branch.
>
I can try to revert just the patch containing the alpha-specific stuff and
see what happens and then, as  you say, maybe do a bisect from there.
First I'll just try the same kernel again a few times more just to make sure
that this is really reproducible.

/Magnus
