Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406324266B9
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395758; cv=none; b=GtjP9Q701xeFmoc9plodL34F9WCmK0RYvmaQc1P7RMqhbcv/2T7CKvzPmpNrfgAcgY0A+ng8Nsc4HYXdy7WF3kHwN1g6pD2FBXc2dcyKjcgMSaTRSn1sPFWWI4t8ABMMIQggLROosoiWHeWEtbUw2SY4kXSU5JVtBnVrO77Sx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395758; c=relaxed/simple;
	bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSrtpGxJuqe2X0i2nvsd6yYd/6HbimBVIHtsayjR6mvC7XptqJINnUXLhmhiw0to6p2OLMPwSis7p5pxQa7zTFmcjNXAFw3d/UNE46Rr+rwqtkRFNzx7u6RjGxBUTHxZ4fsuWK3fJY0scfP3jvJ0I3N7xfmZmenSZJP+C+nD0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkacSS6N; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkacSS6N"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba838d3fa4so62296195ad.3
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779395754; x=1780000554; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
        b=lkacSS6NGUgZGw0MKI4O7j2c5hHkNv9Yhd806a88XULF/5eJJUDVthjR/O/u71b6GK
         4Z1XhN/9E5VNHIRt/B0PWaDvW2Ee9UOV6k4QHt99x47UGRCSlBeWhjdUfHzOZRt1zYct
         FxEDKf970lSr+135Ze3Kzi/Z/OzKhG4nfOGujxsO8lHtNUH03fzm6ecMTOnIEujy5nYT
         4W7B6Osl0kJwmzTJEsduJn/PnsRhMqUancVDLW84fjk+ysdnH6p563axTyRtD2uFrhAx
         NYsMqXG41ofrZlHN30x/AA919Fcf2zRYwjJSwj0j63b1U7xvSDqOnJgKjLIHxk+AWOTu
         95Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779395754; x=1780000554;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
        b=l6Uvj+dh7s0Zb+q5gzIAqJDc0RFRk19Pk6GvaM3dZeUhSir4b/YD5mcQ3bGnAaeWGv
         1xlwb1da6FplWzmqgrwYynQCCPtHfN4+l5YMtZwsFRJIDPI2RgLGm4QXcOyKljpNqIHw
         v8lcGyV+evN2Y0EPghu2qX/Ev+nbeo2ZNBP8BcE2U1ZBhPCmDhsWi+ZaoPzgOCqZkbis
         lN42NuXtw7LexLP2B6AvPUBAZcohw0IKB36QD7AD+tFVteGwBiiAQ7AlvlkyuQQRJiWa
         YUJ2zRDf10UOxo2IyE2QIXMLCMiMbMCunPkNnnI5TcJc6/Tkr/4y8oEVr/wH26rNMgNV
         1t5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9AEyrFyr8AvgA5liEqT0A4bUlNZCTdBvTnCbluFyhjyE/apAh1ZQ87RQFkpYGanSu1Z8xU3n6AgeYCLqChOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6d09U7EEqV710/zP5Qs7IWCkJgokzYW8tzGQNhLD2NxboZafT
	EflI6EM0sfPzuuJEvRhNyej+alxpzh2XIsaB62j9FCfFWY5IPGO6hR39w90Nqpz/citTIMwryM6
	/ltewiA==
X-Received: from pglv7.prod.google.com ([2002:a63:1507:0:b0:c80:192c:51ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d491:b0:3b2:8677:813e
 with SMTP id adf61e73a8af0-3b328ec5909mr476744637.42.1779395753857; Thu, 21
 May 2026 13:35:53 -0700 (PDT)
Date: Thu, 21 May 2026 13:35:53 -0700
In-Reply-To: <13d79ba1e0450068c9573ccd8deb3ec007aea8d6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-30-seanjc@google.com>
 <13d79ba1e0450068c9573ccd8deb3ec007aea8d6.camel@infradead.org>
Message-ID: <ag9sqdLCAqJwaaE-@google.com>
Subject: Re: [PATCH v3 29/41] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > Add a return code to __paravirt_set_sched_clock() so that the kernel ca=
n
> > reject attempts to use a PV sched_clock without breaking the caller.=C2=
=A0 E.g.
> > when running as a CoCo VM with a secure TSC, using a PV clock is genera=
lly
> > undesirable.
> >=20
> > Note, kvmclock is the only PV clock that does anything "extra" beyond
> > simply registering itself as sched_clock, i.e. is the only caller that
> > needs to check the new return value.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> Oooh... can we use this to reject the kvmclock when we have a stable
> and reliable TSC even for non-CoCo guests?

Yes, but I would much rather "fix" kvmclock to not even attempt to register=
 itself
as the sched_clock (which this series does).
