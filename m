Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E3278111
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109990; cv=none; b=MW9EKrUzPYExXyOw9TDiimFWGgWCf6oxvENP407Q1+tmcUNDcwyJBKnwBKGtGB96c5FacwujU2a1LLg0hPH40Bvsd85sqvfo/Oyxa3HeKg0cBcJbolupWvRcgXdWbEoayclHsC18JAabd9j3GEiiwumajtBVPcXz0uLB67PAZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109990; c=relaxed/simple;
	bh=i50rufOwf6vwyAuooSNBHw4J8VhV9XZ8F0ZF8cluBGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIlR16pjdFoYJk8dYgdR9G0kPbFR/Clg1DRwNpf4QXhHhz0qpml8ClSFcAnHM5bKnnXURiO2bQ/lWHfjy15ZZfbtfAFUa80Q9yfZjOGXH0O51YKPLZzK0pqwRXLQbYq8mAvXs9wWKH43IHKgfQ58aPH1HNVnGZwNAuTpnAl85Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxzjTcJd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxzjTcJd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22334230880so79945305ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741109989; x=1741714789; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TI3FoVeE0Ra2glCU+l7ZrrB58ecOTFnnVt+cs3oYhCA=;
        b=YxzjTcJdvr8cZm5Z333BpkRAbVng5UVXGX8ZW8qGp3M/aJl+AQSg6qVuz0R385Sr2M
         6Kk6NuXMuHVvypLko/03b4vXcNnCRePJ9p+fp9uYee/En6ASe50D0aC9QbPlAVkKU8j6
         qYxecn2iyESRdyaWtxjujV62UYvzYO5V8kSt+0aFMr5UOzi1B7ZjXUBDIkI/urKJtzHM
         S28Ba7E1y5YsIB8TJDWwnWivIHMkH66JLWlNamZ40xMTQUYVfsyiKGs47XQ22d+boKsY
         5US4pwmtPzDhIOzRzwqnH+WcPIoF8tl3alHJlZnulr2IyfPnvWVkm1vlraub4ptYrcg0
         O/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109989; x=1741714789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI3FoVeE0Ra2glCU+l7ZrrB58ecOTFnnVt+cs3oYhCA=;
        b=Ubf7Gb0td0j9xJH0qJM3rL0OkLCmXl5SmhC+AUfcF6w4phFVMRMlnd/SuxgXuU8yvX
         wZb5COzG1VdLojl38G2VlQWeO2G4Ma6IgaPm4QLb8AxDhci8r2hVIuQSB11mhWRljPC2
         f2zGDKNj4Q8KJ2ubhXXPgFSn6gXr/xlGqvs6P+5zx9gn5fFpkXpYo6B4Yub/0xqxgNJR
         LAm5e5Oe/gomdUdV2qERzGDSNMcFfu8Yrn0C5e+kQkXriirlpvtJLYrSDT40UGTs+s3H
         SInbkwGV8hhhGtL15gPxD8NgJEdqJLGoYK0vLqqM4P1ULpPi8PFwD49hNu4fdTLADQ0d
         DIKA==
X-Forwarded-Encrypted: i=1; AJvYcCVr2PC7xeALc+e8O3yRDUt21mjs4PePSWdbbBmjhkSiMF38Oc9RYhtKTugPFqFMZtkQqJT8s7xFD8rkfA7QXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYXbMt5nSD6n1McZ/9A3EBD1MGlq6FeqhoHwNyfu4n7k8jm4wZ
	IKIr6uupPp6DiY2NbSN2dMXciwf/ZFoGbqvENaBEy9A4CfW2qc1l8gwDWxlo19FF2Kkx6ab0WeW
	g6Q==
X-Google-Smtp-Source: AGHT+IGZddoSY2oyJ60dCyqtZiF8YnS+v36sYEMEslkao7NI/8RRXlf38IKWdXRybiMidO4JcJg+/iNohU8=
X-Received: from pfbfw3.prod.google.com ([2002:a05:6a00:61c3:b0:730:76c4:7144])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734b:b0:1ee:d418:f758
 with SMTP id adf61e73a8af0-1f2f4cdb421mr28532451637.17.1741109988705; Tue, 04
 Mar 2025 09:39:48 -0800 (PST)
Date: Tue, 4 Mar 2025 09:39:47 -0800
In-Reply-To: <SN6PR02MB41576973AC66F8515F6C81F0D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com> <20250227021855.3257188-9-seanjc@google.com>
 <SN6PR02MB41576973AC66F8515F6C81F0D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Z8c641D3AuWNXGVB@google.com>
Subject: Re: [PATCH v2 08/38] clocksource: hyper-v: Register sched_clock
 save/restore iff it's necessary
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Juergen Gross <jgross@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 04, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, February 26, 2025 6:18 PM
> > 
> > Register the Hyper-V timer callbacks or saving/restoring its PV sched_clock
> 
> s/or/for/
> 
> > if and only if the timer is actually being used for sched_clock.
> > Currently, Hyper-V overrides the save/restore hooks if the reference TSC
> > available, whereas the Hyper-V timer code only overrides sched_clock if
> > the reference TSC is available *and* it's not invariant.  The flaw is
> > effectively papered over by invoking the "old" save/restore callbacks as
> > part of save/restore, but that's unnecessary and fragile.
> 
> The Hyper-V specific terminology here isn't quite right.  There is a
> PV "Hyper-V timer", but it is loaded by the guest OS with a specific value
> and generates an interrupt when that value is reached.  In Linux, it is used
> for clockevents, but it's not a clocksource and is not used for sched_clock.
> The correct Hyper-V term is "Hyper-V reference counter" (or "refcounter"
> for short).  The refcounter behaves like the TSC -- it's a monotonically
> increasing value that is read-only, and can serve as the sched_clock.
> 
> And yes, both the Hyper-V timer and Hyper-V refcounter code is in a
> source file with a name containing "timer" but not "refcounter". But
> that seems to be the pattern for many of the drivers in
> drivers/clocksource. :-)

Heh, wading through misleading naming is basically a right of passage in the kernel.

Thanks for the reviews and testing!  I'll fixup all the changelogs.
