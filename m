Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D697148829
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305264; cv=none; b=kCQSM6vqVgpsotpf9Mp1hVt06EamUbxbkxJkjR/AUd4DhFyyX3mcaiwLWer1Of8wwdPdqzWqt2ZX7DFERa8FHnyOd/jTAlyCJiFhb+0mCC6Z0ayu/oSFyVc3jNU3wLLNYsF/AvOzb6ksfNwHly7N6KhHXbfN+AyuChnLwRVKHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305264; c=relaxed/simple;
	bh=khjT1qW4ZRdDYbiemFS9EcjMm6/guvFxZTFx7kX0BT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klT+RebGt+G5VIepQIJcpBoEBm85xyFh/ZngXSteIxWgckOMIvQbtkz5LZE4dWejQvq1E+DNPDHQI9jApiuPR1upyZ8RvrtWtFyY7jWV6irubLngtxTWRfV+ZH7Cz67bk52HQ+EAib2X+4Kt6UBfSMZZaktqLyGA9aJITavJumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IAofOHA2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IAofOHA2"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 058EB40E021D;
	Tue, 25 Jun 2024 08:47:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wEX573EBUvLZ; Tue, 25 Jun 2024 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719305257; bh=nOfj2BKUC0LTV44iiPUObwzjmvg9jAdhTHWcWwPCMyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAofOHA2nD4wOCyRGdT9l7Utyo7U+FEb+z/InhqptsHGAgh6z1cgLpw0x13WSq2UO
	 HQgnhat6qZ+JFgjDc2eCxw1RglEtbCj6I6myL/MVeL6EapUmKXqyMMTmaigvUPCUh7
	 Q3jHrJbfOgfyUyTs/cmbJHcpEEOtQ+vCCsvrL0zmPqhTBYtvMe2vV260vm3ty0R+rj
	 nYkinUx2rEB7lZGft19UcmCqesG5WDOXrt0oyMPMlG9v4jWDVFOGSs0PrPCu0+o1DR
	 B5Hghb+NpX1Y9yes0x1o1D0PRtGQ4RP2dqieRHkTjxymlL3Y0vmadw0DndS8Jocn1z
	 9gaqhiSSPBux/oxgJIFMw4LOuRXnkJvuw7QfODRzn/nPCFwxQomr1edMPt7IdpOqPU
	 EBcdEFj7xwEam2xgEe+4SiHsgkYoa5wOwS7JQFi8xJau695aRx/3+ATqif7fzSrGUk
	 8wj8WJcljN4T5KePTfmK/lbfk8jhM89ImIVmHzJhXCLH2rxPuFDQBJ+Yf8cquah+YF
	 B3gWGBIUG8WFbDGYTpcDEQKvVfd2CMpbyLMwiVE+CRnb1FQvoXEP1cagpLAIUhzXQ7
	 qIB1srpPv+Q2SJjrBXjwVTnjtf8BlIzmNbnhUb5ZJMYH5BofxuE/e/CspSdCUEbX2s
	 zjpvO4kjHT/g+w84GS6qD0P4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7F2E40E01D6;
	Tue, 25 Jun 2024 08:47:26 +0000 (UTC)
Date: Tue, 25 Jun 2024 10:47:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, ajay.kaher@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alex James <alex.james@broadcom.com>
Subject: Re: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
Message-ID: <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
References: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625083348.2299-1-alexey.makhalov@broadcom.com>

On Tue, Jun 25, 2024 at 01:33:48AM -0700, Alexey Makhalov wrote:
> Caller of vmware_hypercall_slow() can pass NULL into *out1,
> *out2,... *out5. It will lead to a NULL pointer dereference.
> 
> Check a pointer for NULL before assigning a value.

I queue your patches and *now* you find this?!

How did you test them in the first place and why was this scenario missed?

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
