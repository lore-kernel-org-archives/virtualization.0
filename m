Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD2287265
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398940; cv=none; b=hVnL3chWS5bgMXuitdiPeKuNXBmj1vm+fs8y646MpJ9LQthhLg9DKdM6bhvWXnzcou4CUiTosFNTo1wb10k3+JK/SP6e/BoUZpjrwwTvL+hdhwDRG2GBi/2ahBbTcxwfsX8m3K9dMdLrXrYBcZo3qG39LPC7OIcz82ctu6jKnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398940; c=relaxed/simple;
	bh=fUYEQGhjk2RH+VFTkyj+Jyxf4RgHTkhbrtdkjpNDk7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7Jb/mATOsUbc4Qdvs7pCLzACrKV/14IGGgUQUwBEFCG328wEFLDUj08x9JfkFelV/Ax9Nj/Gm2Bugs5V5eIxh0zQrbpOcfwspOV7fYxk0vBSGKLYAXCA/eMDwEaL8ChcodtbjoMINo9egGuUW/3PE/O/8L7nDVXDNfxT/ObXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTV8zEaf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KL+blGSM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTV8zEaf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KL+blGSM"
Date: Mon, 22 Dec 2025 11:22:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766398937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lQD6ftG+QaiE3wg2ETMlKshyjwgqQRgU1XF7oPL220=;
	b=aTV8zEafXpIaLuri2oweBadMgCimeGcNXUHeq46wXdt5Nx4865ul1nKlPaeRm5lnqDbYIH
	VJM9+sw197RG+f8mY/EeBgRE0gcwKsZ8bCSpmNZJybHiVSyjmGkq2oobKmzZ/YL3z003cK
	e8yb1Np3VC+zeV/t8PDHa0vTeXOk6SYyf+iqAaJinGM3tlnEwiPU8rZse8PFJwbApno2Sc
	mYA4xPuwY+ZOlRoGAqTeXww8w+QUuhtfR0uqEsLZPUkQOsRZmNX0xIxrKUm8vL8z0wrBhe
	qfHqVMoHxInWde0/Wqpfjj4I4IRcb6VCsA1DLXG+JFFtjkQqH4UpOMnK8ykKeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766398937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lQD6ftG+QaiE3wg2ETMlKshyjwgqQRgU1XF7oPL220=;
	b=KL+blGSMqQHM0mLOY9CloJCIepdOW7K12AyqxpzBVPlggzkeBPIQIE3g1VmCsxrNdFUyv6
	WJctFX6yVFrtAQBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
 <20251222033807-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222033807-mutt-send-email-mst@kernel.org>

On Mon, Dec 22, 2025 at 03:39:12AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> > 
> > On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> > not depend on libc.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> 
> are you fixing other uses of uintptr_t ?

I am focussing on UAPI headers which include libc headers.
virtio_ring.h seems to be the only such header which uses uintptr_t.
There are a few other UAPI headers which reference uintptr_t, but only
in comments or macros.

uintptr_t in regular kernel code is out of scope for me.
While it is iffy, it doesn't actually hurt.


Thomas
