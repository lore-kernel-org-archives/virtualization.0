Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF752D661D
	for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058847; cv=none; b=B08LA2I8PB+5/eTdqip+XIUk58ylGN60iT1Qb59vqDqe7TlQzVD4/yUBvXl+GWTOvkGqm+A1rGyTaRrM+Su133OSPmQoNDL7kig4GDDpZxFNyANgC4FpbxIH1Fi0ExPisA4zRvRBEUCaM4NMAXNw/mBe5iQK9shv77RhPS+Msd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058847; c=relaxed/simple;
	bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOvlkBjqU5Na0jlkDcvJxhl6aK1V5ModwyNcEjSKkGT/USbavC1rNN/huBUS7eNiCXYcAHUjwmD56lujfrkdPqICTMiKkKKP/gkKwMVRVhM1DfM5hDBzROBcF3vm0++ZdQKkdnlLrX76EBZpF6GZSqjS/f/FtxZMaeJ+MME3Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFyGqXOs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyGqXOs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso8019067a12.1
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759058844; x=1759663644; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
        b=kFyGqXOsnSrNvb3kc9Uyw/2MhcQhEVuK/ACEBWsRxIQP0LuzQPQbxd1LGxjoScnKVv
         QAIrJBjWB/ISkGLnC0VyVwXBybQLlZBkrMlLDRwtKbog2HE3Nwyvqk4rEEDzcyq26VXE
         JLV3S5+pte5evVvr3M4+fHB5pRfg0IYHjL9lNrM/t4fnFS7qASgeV+ANLK9IdeRDODo+
         iveczty521l8pfmjZfSlQSp1arGu5fC9wTEJ38tFquYgjOJ8W4s/B9dmMIeUVzoaIoOh
         UEBOE8mf/T3GU6xznAeUnYnULvSO3YXhm1BytFs9x0mClK+gKQ02YTgfqavHobxx166W
         gZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058844; x=1759663644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnTsRVx2LKHSGCofdfP8cBisj0hnUGCd3CLwMZjXxX8=;
        b=Kv5xFexMxiSIKJNDOTQM7vLAUMEhlh7Bugm32le1Ifly+p8At1sW4ZHQ5z9J/8JvlT
         T93qoGRnQWzeIV201vPovHsVUNFwfcREpKn8cyi/GGmqXJxXnEOH2WpX+sQIFdR7ThYg
         E4no2lLQYGlNFFTMJH1GRsaqMr2POXkD7vuuNpcWPnmD4SgynuLeBUEBJ97gQWPo0zAn
         +cALniiTTx2LEZUf4PRVJveVNneXAriyqHqbR0U1mHzRIFf1TgcVt7UCXVI9CdVIan9x
         1iTcBJKsfKXMlD/kvyeTmm4YwaVDvQn6O51K/+Uk+LKDdfYbrXv7NbvLP7ZRDPRxsH2e
         yPPg==
X-Forwarded-Encrypted: i=1; AJvYcCViNLs2ZwePaySVc8nL5yHbBq+6xtqSzDlenH0rcipRfwmd0iyrQrYp1IJD6oY5WVLhiT8TuNuTkjKnCqt4DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaXZr07Ki5RQgX5Gy5Ok4H52OgLqrU7YCH9ZvTpQTFrjdzpAIS
	u9sPlaJQITeBXlGrruxlnk1EUCBEKBmgSSvVblXzqU5z9vyschPZEq4ksUvktCBj6K3eBxTwwy0
	tQo/z92OIp/je+j82R8U3uiFA2sDIDvI=
X-Gm-Gg: ASbGnctTtM4qDsTXgcMhW69lq+HLZXc9XoZCb9Iqx7fWa8rVfG0AtFGMgKQvCLbdK58
	pEv0hss+nky39LkIUYRPh51OSPSPEgN4FZnPVpsMbUvF/etFK60PUu/gj6vAWpjs8lrWjlA5JEh
	WPArlSFdMEuKa+fdMo/n7B9GD6s/Ia5Xz6cPLscvRM2HTIUs4qqwaLSqbtVKaakwthx5RZZ8XlF
	UA0OrVmeogqq8G8/8M=
X-Google-Smtp-Source: AGHT+IEbmR6jFZWeOZACTqVTuyroT1qollOj9im3bB2gCUN08/YU89k9vFmzDRRbDuqGeOLmGGtFiulh5CESx8Sm0EE=
X-Received: by 2002:a05:6402:44ce:b0:633:ddd4:4e37 with SMTP id
 4fb4d7f45d1cf-634a331587amr9387899a12.13.1759058843815; Sun, 28 Sep 2025
 04:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
 <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
 <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com> <20250928105413.GE12165@unreal>
In-Reply-To: <20250928105413.GE12165@unreal>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 13:27:12 +0200
X-Gm-Features: AS18NWDQy06zFzFA0Tb4sMvL6G-ftUfrOQ8ZIU-yy9wPAEd2O_xZFFnSMKmSHdI
Message-ID: <CA+=Fv5Rnk5RaGU9R_65izNOJOns9w_eEzetH9kBF_MaRgdhLAA@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
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

> Thanks for the effort.
>
> Can you please check the following change instead of reverting the patches?
>

No problem, happy to assist. I think this did the trick! preliminary
testing shows
that this now works on alpha! I guess the offset information in paddr was lost
by doing "paddr &= PAGE_MASK" before retrieving the offset, well spotted!

I'll keep running the system with some load to make sure there is nothing else
we haven't spotted yet, but so far so good. I'll keep you posted.

Will you be putting out a v2 of this patchset with these updates?

Regards

Magnus Lindholm
