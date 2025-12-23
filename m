Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3023C8C7
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473853; cv=none; b=k/3B8l3ji3FbWVXXmC8FZokDRyuRjurOQnTnWOPqAP94Ocr5Y4Qyml2ZXl8LJL/N5NlRl7ufKt1g1xsFmYCsg6Oj+DvQ6zUgU2guUfCokI/b5OzMrfG0VpSwsS5oLiShtdFveHcZ5QuoJpe4B6AI/S143km/roc/05WVX4PP004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473853; c=relaxed/simple;
	bh=j2BBu4rp0WMOehT2QgF7gqoozKUWTpmfjIVBWhzDhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk3tnMb8AlY+3/rzg4D9c3gtGh3gTWPJHJOqdnMXLfB4AlfIIsy0p7UTGESiLuUbd5sUSNpZ8oUP1VMP+BErLTsUkIA1e0NoIPaqjm4CJLkM9gfer4WJH7fVFNXFP+2/qMbdIkcUmgOtHc/xInxIGJzZtSeo7cqHZ9sz4EFqVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wt7+sqxp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWAOOS0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wt7+sqxp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWAOOS0j"
Date: Tue, 23 Dec 2025 08:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN6Dmr2BT40puAGgGu0V134KWOgx+SWB/YgD2oDPSOE=;
	b=wt7+sqxpDD6KGVAqOzUUZnA8rZSHBaLE1X0bwGhdT9b7/+RE24p5UMDxtcW+RXSmyln0T0
	oAp/JRceHCFPDlwSoFmw/qvr/jQBd0nXDc6+x01bGpchZGgCZuvj4J+eeOZ+iyH5AOeyVd
	6gd6qAG/g4bGp4MgXwyxuEtbo8NHQIB1+HSy7Hae/U6QtyXkuR0V5BDaVPkVcZKiLR3A+O
	A5kpBKCuiFnJLZ23c88iRSDzwoeYD99yRkmfr9c3i1WbmMkcNNNs4K3RhMD4U5acoAvvrd
	ZMPJ5LGts4vUHEx99hrwhpp3lO2A9KYED3Bd+fG0EjYAoasWAnPVsTa6akyvYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN6Dmr2BT40puAGgGu0V134KWOgx+SWB/YgD2oDPSOE=;
	b=fWAOOS0jbX/9cJpkjLI+jF+QSbEY5yUoXGUuMfJqUYFeVHTIwG9l12KM+yX4D/SQQItMJP
	cqzOIHqQqeM2qRDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251223080426-583c4599-264c-4d94-9af0-f67c043c559e@linutronix.de>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
 <20251222033807-mutt-send-email-mst@kernel.org>
 <20251222111044-611cdccb-327c-4ed8-a75b-1a65aa353802@linutronix.de>
 <20251222052818-mutt-send-email-mst@kernel.org>
 <20251222114303-6d63eff5-792c-4727-8bb1-61a024884616@linutronix.de>
 <20251222171742-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222171742-mutt-send-email-mst@kernel.org>

On Mon, Dec 22, 2025 at 05:18:26PM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 22, 2025 at 11:43:52AM +0100, Thomas Weiﬂschuh wrote:
> > On Mon, Dec 22, 2025 at 05:28:30AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Dec 22, 2025 at 11:22:16AM +0100, Thomas Weiﬂschuh wrote:
> > > > On Mon, Dec 22, 2025 at 03:39:12AM -0500, Michael S. Tsirkin wrote:
> > > > > On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> > > > > > Using libc types and headers from the UAPI headers is problematic as it
> > > > > > introduces a dependency on a full C toolchain.
> > > > > > 
> > > > > > On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> > > > > > not depend on libc.
> > > > > > 
> > > > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > > 
> > > > > 
> > > > > are you fixing other uses of uintptr_t ?
> > > > 
> > > > I am focussing on UAPI headers which include libc headers.
> > > > virtio_ring.h seems to be the only such header which uses uintptr_t.
> > > > There are a few other UAPI headers which reference uintptr_t, but only
> > > > in comments or macros.
> > > > 
> > > > uintptr_t in regular kernel code is out of scope for me.
> > > > While it is iffy, it doesn't actually hurt.
> > > > 
> > > > 
> > > > Thomas
> > > 
> > > And other uses of stdint.h?
> > 
> > If they are in UAPI headers I will look at them.
> > I also have a series prepared to prevent new users from creeping in.
> 
> I don't mind picking this but I'm just curious what's driving all this
> effort.

It started with a recent change to an UAPI header which introduced a dependency
on libc that broke some things I was doing. See the fix and background in [0].
So I looked into catching such issues earlier, which resulted in [1].
Fortunately there are not many problematic headers [2] in general, so I am now
also fixing those, so the new check can validate more headers and prevent more
regressions.

[0] https://lore.kernel.org/lkml/20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de/
[1] https://lore.kernel.org/lkml/20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de/
[2] https://lore.kernel.org/lkml/20251223-uapi-nostdinc-v1-1-d91545d794f7@linutronix.de/


Thomas
