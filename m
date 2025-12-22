Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052A32C92E
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400236; cv=none; b=IzfPxkzOHHEo86MqOcpeofpU5H6OtQM6OninsEw4SF2lEodZpkUBoREqTAFWzgQwOe9hMG2hGPIUL7UlFuiY+0wyTwiLSNMrHyNvWfKVU2brpxL0QVfygW0O+ETN7HWuHG7MtVMsWV/YQ4WlDUk18C0i+EkrjT1yBnAjEvT121Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400236; c=relaxed/simple;
	bh=st9Kkf38gfas5jnEpgyemYuebUJ+rOQSs6qedvA8lL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPIfXBdMDbptjSwQ2necXWbg83a0XKh36JjNxUhNM76094eAp1/Q9yQd6FARWdhyul9xFhhlrf9nMNfoQ9Dv/LNGlUP3LIPHLVGdA7BiWg5B+hGf/8LMEpZcpuIIC0VeTHoDsXYnmtWVATSDWvjpDMqP+ao5ZVPuDEJpqX4ndTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufhLlVGU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8UgylPv+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufhLlVGU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8UgylPv+"
Date: Mon, 22 Dec 2025 11:43:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766400233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIq42/NMDqw1boIgrD+qQl1Ucqv9nt0VUZoMLeXkLyM=;
	b=ufhLlVGUjtLbptB18lOeZRkJeanEwt7PhYvGyCoNj7ky5KHz1dtPvDh2l+1EmYpshhrfDV
	ZT+5fH6rYwRpMNnngq34icU17X7beXcnX1ZLjIPJkgAnmXV3O9J48+mxc6BS9l+bVm03wZ
	ozCQDGjGaCZA7Q0riItp2o9njcW3egs3nA5sbIl5sNWqgTImzc7O+eX6km5cDuCTp9Rvb1
	LvqJGOIke/QTUCG09/DaUdaileWHN+fnyNTZmoJwzwuTiTIvoHU7SiQCWJ+DlSQw4Oi5/G
	gkXSwJx80TJYEdVMa61Cm11oieR9jtC4E3axLDYJr5IhDnjt+rDMSit2vT7FIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766400233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIq42/NMDqw1boIgrD+qQl1Ucqv9nt0VUZoMLeXkLyM=;
	b=8UgylPv+JZqqxHjTeQXfOtGARoQVRgU7cO7FLBvatsv5cqhVVWnJgPONlAxCkkJQDmo+Wy
	lzFDPUDOCkBcgsCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251222114303-6d63eff5-792c-4727-8bb1-61a024884616@linutronix.de>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
 <20251222033807-mutt-send-email-mst@kernel.org>
 <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
 <20251222052818-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222052818-mutt-send-email-mst@kernel.org>

On Mon, Dec 22, 2025 at 05:28:30AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 22, 2025 at 11:22:16AM +0100, Thomas Weiﬂschuh wrote:
> > On Mon, Dec 22, 2025 at 03:39:12AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> > > > Using libc types and headers from the UAPI headers is problematic as it
> > > > introduces a dependency on a full C toolchain.
> > > > 
> > > > On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> > > > not depend on libc.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > 
> > > are you fixing other uses of uintptr_t ?
> > 
> > I am focussing on UAPI headers which include libc headers.
> > virtio_ring.h seems to be the only such header which uses uintptr_t.
> > There are a few other UAPI headers which reference uintptr_t, but only
> > in comments or macros.
> > 
> > uintptr_t in regular kernel code is out of scope for me.
> > While it is iffy, it doesn't actually hurt.
> > 
> > 
> > Thomas
> 
> And other uses of stdint.h?

If they are in UAPI headers I will look at them.
I also have a series prepared to prevent new users from creeping in.
