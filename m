Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C983CBE
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493969; cv=none; b=XCbUsARW13l97bWFtBdThS/h2AhE4XxxqrZRYK2uaR7EfGUzMPqzg2hQ+IO2pGC2S7eyKAb0SJZvq98H3cT0e1s71L7lPChsNpesBTQT82Sg63ThHI89LHsysKFkCcJ9UzESWxallLu/7SsTYVR3TLt+wf1zMKpVZJIv9mEEF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493969; c=relaxed/simple;
	bh=lnqVjgkvWi+fXg+ZEjXR4tnRofPmiBZHcMWL3I+8MDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+EFyr0k5ePXOhk/TaBAbfJKri8Nv0ry1EfsHazSbeTOs/hn+EAtJtTK6R6LS0jCbeAs6DDewOhLNNrD55DE72ADJYhLIlF2+uXSuQjgXZ5cvXB7EL3zlgpkcVGTVqwjRAC35T6RNH5p712b04RM0V3tapXE1wRjBi96KT2/+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xPNI7lGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XyoNc7Sq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xPNI7lGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XyoNc7Sq"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716493966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnqVjgkvWi+fXg+ZEjXR4tnRofPmiBZHcMWL3I+8MDw=;
	b=xPNI7lGKGva/APgAT7OzBOwQl0E/5c54B7HhDK5Phb1iKN4ahV3bEA3UYuY2dgt23o4aL/
	zrJH32EYXAH3g3a95KY8llv/YVQYNV6a9rlHrGMsdRm20IGUZwdLlM5g6EeLCOBtXIM3hw
	G3/z2s00T0J5qAe4+bcEQR/XZrvQhz0+znFmHQxX4y/T+GCPwc8e5Fkdhe1aZJYfA+YfLL
	XojEfru58leoF1h7RUOYBuDuQK3ylam76TMP4TMlsno1AJxoanRPXed6E34ThJQEVbAsTI
	H8xvTJIhVe/1xcyagrYMuSdK+k7jzB94Vlxsvm7pa920fc3xHyeKOCQXYOAuHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716493966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnqVjgkvWi+fXg+ZEjXR4tnRofPmiBZHcMWL3I+8MDw=;
	b=XyoNc7Sqyr7swkex7HE2TEIQjbODm3OkyVUDf2n/A6xuYrKYWTf0K/c+g5RINgK7oREaoe
	wOXHNQ0Nfr1iJjCw==
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/1] x86/vector: Fix vector leak during CPU offline
In-Reply-To: <20240522220218.162423-1-dongli.zhang@oracle.com>
References: <20240522220218.162423-1-dongli.zhang@oracle.com>
Date: Thu, 23 May 2024 21:52:46 +0200
Message-ID: <87a5kgfgq9.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22 2024 at 15:02, Dongli Zhang wrote:
> The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
> interrupt affinity reconfiguration via procfs. Instead, the change is
> deferred until the next instance of the interrupt being triggered on the
> original CPU.
>
> When the interrupt next triggers on the original CPU, the new affinity is
> enforced within __irq_move_irq(). A vector is allocated from the new CPU,
> but if the old vector on the original CPU remains online, it is not
> immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
> reclaiming process is delayed until the next trigger of the interrupt on
> the new CPU.
>
> Upon the subsequent triggering of the interrupt on the new CPU,
> irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
> remains online. Subsequently, the timer on the old CPU iterates over its
> vector_cleanup list, reclaiming old vectors.
>
> However, a rare scenario arises if the old CPU is outgoing before the
> interrupt triggers again on the new CPU. The irq_force_complete_move() may
> not have the chance to be invoked on the outgoing CPU to reclaim the old
> apicd->prev_vector. This is because the interrupt isn't currently affine to
> the outgoing CPU, and irq_needs_fixup() returns false. Even though
> __vector_schedule_cleanup() is later called on the new CPU, it doesn't
> reclaim apicd->prev_vector; instead, it simply resets both
> apicd->move_in_progress and apicd->prev_vector to 0.
>
> As a result, the vector remains unreclaimed in vector_matrix, leading to a
> CPU vector leak.
>
> To address this issue, move the invocation of irq_force_complete_move()
> before the irq_needs_fixup() call to reclaim apicd->prev_vector, if the
> interrupt is currently or used to affine to the outgoing CPU. Additionally,
> reclaim the vector in __vector_schedule_cleanup() as well, following a
> warning message, although theoretically it should never see
> apicd->move_in_progress with apicd->prev_cpu pointing to an offline CPU.

Nice change log!
