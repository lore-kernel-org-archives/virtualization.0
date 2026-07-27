Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE43DA7C0;
	Mon, 27 Jul 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140152; cv=none; b=hACq3PGWzxO6jZc6LbHk92sLLE8mIjPZonytJ9zeKam1rkT5Jk0RkQL0CJA1UqAb2rdg4zhm8OP6vZ0dwxZMhJgDjnCduAk+p1jUwrLotfstmfEDOiXUHWmL/nqkZzKrIa3zBJKtbBWY1X4OwCrrtQrRepSiF8CPx8bUwe8kpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140152; c=relaxed/simple;
	bh=c/JwRFWIZ9zKWmIisrWsLLITsUXgfGHW/PYJKN+RYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFizJa0dnE9yayXX9VrHKyaUBJoWF8fWLuqR/AMFR+BYXzPH/WWjmvusF2GaptvBFUcGBtd9ZKz5+BrQrSS4RpcaZstQidUikPDQV2UpdkMAV/uN6r3tM65RFJGy/DXSWXeep9nqUGmkhktwK3uNGECFt3wuScSVHz1A5TXjHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipst8riV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipst8riV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15021F000E9;
	Mon, 27 Jul 2026 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785140150;
	bh=aMp6H9FlzJc2nODG9Er85yscBE4n5OQfZGhO+4vG+3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ipst8riV1ZO430ela6U164edPoPnXojBF2s233/J5vbVn37/TyEw0BKUZtwkU6e+O
	 3zASlFlsBero08dq9hNqrH0LTY1MNyxIIMz9fICwQg6tC5V4e2OYlcJP3fGvO7C+LO
	 D2kx1citiPvOTjurS9wiVSuzVIl4Z3GMSmUwdlWud3JebnuTojbSSf593447ketuww
	 NjTW3D1sqEPbjh/rQQDHFGm/2frBKFHPpuhrgYYtEjOHSM5PEyYyYPpYAuUOdqbK/R
	 mOvFcClt9NPBgvmS/r6VSCd/LJfwM+K5KayO6VNg1Fqzmrm1/gqn3jcSEt9SYjE65u
	 lvXKIZW/k95kQ==
Date: Mon, 27 Jul 2026 09:15:45 +0100
From: Will Deacon <will@kernel.org>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	virtualization@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
Message-ID: <amcTsZj6wAmT1gUd@willie-the-truck>
References: <6A66AA54.2EBEFC.17686@m16.mail.163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A66AA54.2EBEFC.17686@m16.mail.163.com>

[Please line-wrap your messages]

On Mon, Jul 27, 2026 at 08:46:12AM +0800, Weimin Xiong wrote:
> Subject: Re: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
> Thank you for your patience and I'm really sorry for the issues you raised.
> 
> Please note: I sent a combined patch earlier (around 10:42 on July 24)
> that supersedes this v3 series. Your reply below may have been based on
> the earlier version. The combined patch addressed all the issues mentioned
> below.

That "combined patch" used attachments, from what I can see.

Will
