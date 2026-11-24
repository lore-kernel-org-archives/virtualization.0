Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505270;
	b=i3YNqqGT2Iu94qbVMYdjx0G0TY9Kf5HhDPdNTconT1dwk79r4J1j9Q2jwmsYhNLNSo/R
	 VdGD0LENHqtnYw2/NcWQgZDZFemdmQHAK2KthacJ1PjCplU+cXObwxQ/nLYpqNy0TEA3m
	 dUOwI4xG2tS2gVbsjNb1TOpvPONAUox+vKZ2eMSabZbQ3f9Z2fkZu6ifRuQ1A4iNRzubC
	 UeH1rrmyNZMY91HccC4BrNH3dPfCLyh+5gaSlXk2L+dkFyISpz7kcTaJJZFxexGbmwUcy
	 ubmGlpTBrkMcbJuLMiJTp2mKLieaiHYW14hDfW2YC3M5iNEE4WGa8ycrKb5n3SAVmxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jyx/keQNI3yIKwQG0ayazeVW4ab3XGMg9ymZtuz4VZA=;
	b=uGleZCGnV5bDlnnB1tTS9+4m9qKUq7GFLjsSODMTyxRkAk5xEVTMUvw+sxlD9nt92Hn5
	 V6wjFB8dt7iVDCJG8Mf2sUwFQTG20V63lDCi12jVYVWSVmUZ3kRzuVs649hn3mWAjwaN5
	 /lzBe8z901kmJilRKsb6kWB+Ch3CLKM2RY02UqrbIDp0TrB86YIq5nNOfR5Vi4qX0B8zQ
	 FfUhVUSC3/MlylK3+YPiJsHeGx03klsKhkpz3NX19Xp/RqJRUZi2aeaeEI2T/JIh7Owv9
	 q3VUNvbzj5UDBVp6Kl8qZYrG7sFeWdA/uzLX2FoCu91cN3JrokRCOffo/WNriuGR74Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oDgRveHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1F606A321;
	Tue, 24 Nov 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oDgRveHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045181F008B2;
	Tue, 24 Nov 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795505269;
	bh=Jyx/keQNI3yIKwQG0ayazeVW4ab3XGMg9ymZtuz4VZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oDgRveHLl5+DDLP7KUkeS7guQJ6fC2v+4EnGvNSMw2iBjsLYKBHXv9Ce6jXXsMzQy
	 9kULQVBdYWRiyUS0/mj8Qk+k5FIz2d5c/T+IG7tIshzuFPNM8PuEfnTwW/vExMZDdV
	 qHidARzxFXPcmIz6H3KL6kWZKqgPLxfBgi/FuorI=
Date: Tue, 24 Nov 2026 08:27:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ziheng Wei <zihengw03@163.com>
Cc: Jiaming Fan <fan.jiaming@hotmail.com>, amit@kernel.org, arnd@arndb.de,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_console: drop device reference when DMA
 allocation fails
Message-ID: <2026112438-juggle-squeamish-22ea@gregkh>
References: <20261123102321.8605-1-zihengw03@163.com>
 <179550385418.475969.16498839426484137487.zihengw03@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179550385418.475969.16498839426484137487.zihengw03@163.com>

On Tue, Nov 24, 2026 at 07:04:14AM +0000, Ziheng Wei wrote:
> Yes, you are right. This is the same issue and effectively the same fix
> as Michail's earlier patch.

There is no context here at all :(
