Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7447139CFE
	for <virtualization@lists.linux.dev>; Tue, 23 Jul 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711094; cv=none; b=XUMHq/+sEgZxBgYq2W692ipJ1lKDom1JHEo8MT+YxI8ZErQXDoKXeLcFITbGM9PA9Ek2wOgq7CTU5TYO1P/ROyHJ5bTD3fKY2EbsLBmunQuS+EoCjxT61a+Jw1DzgnIf0NNPHnRoqMEzn/OgYNq8i0bu8bzPQ9+XJhG9fG8y1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711094; c=relaxed/simple;
	bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVCftFYE6kj2bdiByBMVWgkadyxSkQ1BX0LX5HQsZfDg4W/5ZNkKzr9MiT5A2p2bQrtzc+VV3gSSY13Va3LOFFrCH1+kO0kfKWGVXDb9FnAQAfhRZhZ7Bdzoth4Cgry3yIl5l3P8MW3MK6+ebrAcGBNJCIxUuSi1YbK6U49b8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DK4M4ugj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DK4M4ugj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so2684253a91.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jul 2024 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721711092; x=1722315892; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
        b=DK4M4ugjKNej3SgrVhI2Lzl6kOPl88qeuClGhzap0slnvbM+uUIKmArQhTds3taPLD
         lpJFEAn0ahyGzNV2BSBORUqS8O9yuI0VPI6YwbM885V690Wd/rvWm5t9nqwVpsjEh9W7
         Zo+kOBhLAhBwo7J4UIAhS3NZzxkK2doldWqLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721711092; x=1722315892;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
        b=kKotvh+Mp3CxF5o5/sjCgSuzqnsxlo9IF99Bad5qM0JFoTUELY559hxSaEAh5ll0KL
         UPll1D1Wo2Rob1O/m/WAOXrJZs/sz4zy5x0ouEmugSPETGCB2LOuEQyAPIXINUInoRqT
         eSwxQsgMlaba/oH60c8NYS5ch+GNE32GssnQcCXpdfn6Qe+ysqeUOLMKK/mRiR8sZemQ
         nTWEiu/LwPRlllHrk3ysJufDbLmOpNrl6fBQTj0FUlJHjx2EELTCrDjtuv+4iqFnn1KM
         xTR/uvEUTpUxs0QEVfbZVNaw5wmecszuSLpjxnUXwjtoGDwwo4rCmcOaF1sl8TFxwtpG
         wG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXMDfZUNOg9kod7cfxfv2FWnKLIAjEBOzbWsdd0+vbKaASxSWTQFHA9s2UZf+1647dPedYylXO/tGjD4HzrxFGKxlGNz18R8Ule83Io8Yg=
X-Gm-Message-State: AOJu0YzepoxnEm7HkhzkTjES4dmfapPhin0Ne/QUGaOEW7Qns9C/zRPn
	7xpyB2RXLu8eXkRK17cahRdyqJwx4BZ+2TyH1F2TwxedAeG9od1jidu2xgsuJA==
X-Google-Smtp-Source: AGHT+IHy5HHrWxb35Qqa7ZXc+sIM2Hmxg63fti34eqUQtbPkpYiSD64YHv5F+p2M5kRN5sYRROf1zA==
X-Received: by 2002:a17:90a:c593:b0:2c9:81c6:b0e7 with SMTP id 98e67ed59e1d1-2cd274ade2fmr5022887a91.30.1721711091951;
        Mon, 22 Jul 2024 22:04:51 -0700 (PDT)
Received: from prme-hs2-i1009 ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2c5edsm8048204a91.3.2024.07.22.22.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2024 22:04:51 -0700 (PDT)
Date: Mon, 22 Jul 2024 22:04:40 -0700
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 1/2] x86/tdx: Add prctl to allow userlevel TDX hypercalls
Message-ID: <20240723050431.GA10164@prme-hs2-i1009>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>
 <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
User-Agent: Mutt/1.9.4 (2018-02-28)


Thanks for the review, Kirill.

On Mon, Jul 08, 2024 at 03:19:54PM +0300, Kirill A . Shutemov wrote:
> Hm. Per-thread flag is odd. I think it should be per-process.

This is the only point I might need some clarification on. I agree
there doesn't seem to be much value in allowing per-thread control,
but I don't see any precedence for setting per-process flags through
arch_prctl or similar interfaces. Am I missing something?
