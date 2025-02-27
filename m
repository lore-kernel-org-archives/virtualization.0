Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7802222B7;
	Thu, 27 Feb 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642544; cv=none; b=QHNobQBWMJU1l9aTMEn0IQ5a6o76kzn3JxruXADRTRsHtN9dS/I/SGKkaabTEY57PUYyHLUmDhQyfopl4r5W1xJm2rPn35zR2O8kMOwHCkb7nM7dM5yo8k1lcBjJG6aBozXy1lm0kyUQxuvHzwKgUI4cyVyTv2zlXwjwpdLlDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642544; c=relaxed/simple;
	bh=8xHwxb7DULW5yuedeqj1TqfqkEO+Z4YwLcQFV1stEpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MpTcrh7lvl/+kEgMmTpHeek8+jumd7y8NJWx5vTPUWu6kwiyEBki2oh8mh9I854Pwv2XZoKy+otqrEeS78rSHoP/H3xcu2abEyvOFDP06mdEgmHBQpKjjDwMHf3ZWN0MSC823Rf1c0CFMlUfHZgfTse2+BCO8Vf9EvAU58PR/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1XjA1dW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ISW4tf/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1XjA1dW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ISW4tf/"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740642533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/FiwpGgcFsUVJIrAAggZ118vbyRdPHUpVwLgvzzG6g=;
	b=j1XjA1dW4vnGkpn5Ci9y75c6Hdtwk4+Ny32gBE+duhCt1GqH+SXgRR8OpfDqAuGbWuEt1h
	5EJbYwhnGxs5hjLOxbM+6Emv5CZEuK3td6X14YzCv3acdSA9qJBj39CKJLgzNXURkKDViy
	0iBhoMl/MyKy3kGACfuxeLZzn/9ezs2VF+nelJPTcZFERUxRkA/Z16PYeh4FqaYt+wCxMI
	aXjwKb4z5MkbSu3pyzx965lwDghTQomZT81AkpHNuj9pZSh7BpG6U82ffo9q/wb1pqAdJA
	tKWZyeKKyru4urnzo1wUAlcKzsUWT7XqFBVJHaYqHguCn3LQgZ2m5ojNvENTqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740642533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/FiwpGgcFsUVJIrAAggZ118vbyRdPHUpVwLgvzzG6g=;
	b=8ISW4tf/hrqDpFSd37qm+hMBh7bnHgcoCCi0Z02YB2HvefWAxjbmeiVp57WxbL7NKjJPKI
	kpAAcrCDeSx49VDA==
To: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, John Stultz
 <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v2 24/38] timekeeping: Resume clocksources before
 reading persistent clock
In-Reply-To: <20250227021855.3257188-25-seanjc@google.com>
References: <20250227021855.3257188-1-seanjc@google.com>
 <20250227021855.3257188-25-seanjc@google.com>
Date: Thu, 27 Feb 2025 08:48:53 +0100
Message-ID: <87r03jeska.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 26 2025 at 18:18, Sean Christopherson wrote:

> When resuming timekeeping after suspend, restore clocksources prior to
> reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
> validity of a PV persistent clock to a clocksource, i.e. reading the PV
> persistent clock will return garbage if the underlying PV clocksource
> hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
> mess and uses its own suspend/resume hooks instead of the clocksource
> suspend/resume hooks, which happens to work by sheer dumb luck (the
> kvmclock resume hook runs before timekeeping_resume()).
>
> Note, there is no evidence that any clocksource supported by the kernel
> depends on a persistent clock.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
