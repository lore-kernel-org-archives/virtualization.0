Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9B182B4
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733730; cv=none; b=fiDFw9RLFs0QL3mkoXyT75EoGSueDtREVfKPexQwjbAmK/QD1iz7UKsFkMZ2wi9nIZBQm+3hhp+AcA3vHZPK/06tM7ffab189IM7A/BY60Dz4uaPj40TcUzDC9al3yiI+5LgBH7q2T1ua49RHq+L80X7+zMftYZZpThRtMLHAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733730; c=relaxed/simple;
	bh=nUAmv8H9hgiFvCdcE/9leaa+cZA/AIOWo7WtnrTKZ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM5BRZux4UpeYM9uvNUzy9iScII1f2AEIdo4U5kQoK1IroePK4sRsH1qRNbdNsUh/n/xyvyu7PG/se6duXK9F8ODqC9t/ZeSjDoQ2/b9ItR/Hykvun8Ti8DQd4zNJEINvGHnVqWVoP6hivKzxGwvhzMra3DjW+/i6gyXP873bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IdZkmND+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IdZkmND+"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42575d462cfso116815ab.2
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758733728; x=1759338528; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9YvycGlNJV4Q2DejLBsM63fTc6nBtT2JcHZL2ev/Ww=;
        b=IdZkmND+7LoExXpQuWcEVOXeOJAVQ7UhJ0BCV0qg91O7zTFmwDpIvJh5U4RuyQQZjZ
         30e0FpCdK9uydV5J1Gj0OF6cx+D3vHMzdaqbeKKHIgjYr8Idwq/pa9XkOsoLzSnO7icg
         wIOfMGNRnKHWZqDPJoYXvpVV0Q2S0xZlVc8jeZY+RAvWzCIYtrF/Y1AvSaKVVXIiplzw
         pX0S7a/VrDdVevhkyiUGxqW82lH5h1lCZB0CuWfjTihK1B5aCAzeO+dcR+gkMltO4U5X
         MZ2Ou2FoETOClphylue2MzFI9J4aZD+U10d654CRuNOWujMJjSqPZVl2sOq6oK7NVDNR
         bIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733728; x=1759338528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9YvycGlNJV4Q2DejLBsM63fTc6nBtT2JcHZL2ev/Ww=;
        b=bER2TYYQrzPlb8g7WZrMZB2HOlCEWoJo2RBvVwJlZnwStYtvA76cC/XjhB7i1bagWs
         gFeTT+j811ZLg2iyIID0qfdyembcvRC8+lXDfN0pJVacQDNFoD8VlYRJNMFlQtN8W48C
         Ds62yRqbLkBV6Der4wuQcqAJPjIFyQyeZL3hxcLWY+962F/Rw4x9HWVd90RHKgmetmxa
         fiLVwiuYw1r+oZF1y+aBW05/ML+7q8bCh/GNgNkqelUZW6q6IihbPiZCFDjBhlOQjD1s
         BjzHAujr86s2TDOT2NO/b9ZqwfxT1Gbp19XDp86FQReqloHWULaISZNUSHcnlJDiseik
         3Jag==
X-Forwarded-Encrypted: i=1; AJvYcCX9WuAKGUpOgzjzN961avoDMRSMk5NbI1j3HjJL1Sqyn4CzkrfP5kB1OP4xYEUyqQjeA9rG9nZg2sO8qsZlJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8ZPjeknQQwNz4N43Z17jVm4AK31k0C9mazGWqJMQfUhP6piJc
	0cqU8lHRz7OwSik064GIPTC+mquTt7yJzixh7xfctfopPIJOcmlDLulR52cuCJ+9V9k=
X-Gm-Gg: ASbGncvzk0WpC2K10yDViFhmQgJ6eqW8M6b5/ZYp6lvCH1bQKmIMTLEqe9kpDP20R2+
	S4y3qPFfE7F3mzCi5FC3bAspnEgPLcVm4yHS9T0bJgPlkYxBHhArpCF7c7APz6P+l6+rpSkuAmr
	7t9n2wClmCqsbAJBWMzneTGivwTonHRnUk5VBTcOxcatZyEbjE4bhxYrmIHASg/BkEHUSs3M8iJ
	pIdivSCnZesXpiqPylAook3YglivkM8vs1OK45PpBlLt/51yI884OU4eslRkIKAjwq9sgZSCrJ9
	VXBhijSaQLck15iBsLiu7auTtvXICkgyhYOxb7bdpSygMJKOD7ervSAK9l6XKjmKnMoV+TaAyME
	KO9uAloGuT5Oa+M1JtuGrZuIt
X-Google-Smtp-Source: AGHT+IGI2XTu1luL1W07izdN35I/CB5PQt7LugDhcv/pXBGWRBL2UtisiXkcMiabO518Q3HGRFAjrA==
X-Received: by 2002:a05:6e02:5:b0:425:7afc:b84d with SMTP id e9e14a558f8ab-42595660be3mr5073975ab.18.1758733728037;
        Wed, 24 Sep 2025 10:08:48 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42585a701eesm18122715ab.7.2025.09.24.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:08:47 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:08:46 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux.dev, x86@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v2 10/21] riscv/paravirt: Use common code for
 paravirt_steal_clock()
Message-ID: <20250924-8189d2caf8323e5f6770f429@orel>
References: <20250917145220.31064-1-jgross@suse.com>
 <20250917145220.31064-11-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917145220.31064-11-jgross@suse.com>

On Wed, Sep 17, 2025 at 04:52:09PM +0200, Juergen Gross wrote:
> Remove the arch specific variant of paravirt_steal_clock() and use
> the common one instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/include/asm/paravirt.h | 10 ----------
>  arch/riscv/kernel/paravirt.c      |  7 -------
>  3 files changed, 1 insertion(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
