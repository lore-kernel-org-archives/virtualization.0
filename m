Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EE3264DC
	for <virtualization@lists.linux.dev>; Sat, 30 May 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159679; cv=pass; b=DHHcnBaU2PBaSPdW8eF65sES46knUJZYDMljfoJv8vVi60J2FwSWvI+AfuWjTHqROlV0pFcTzseQgnKpubt8kHU48FrK9CB2X1a7mSDfhxzxXsoaPnw2WvcmFyqe1jW4SL2BvpjVzAB1he2X1/R7TCpZzuGJQSERt9/TS8Cj26U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159679; c=relaxed/simple;
	bh=NO55GTUIErfjMW/u3wp6zeJt9pZ5TEdqDypSXTrdktw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DWr3jmBjGRU9N46pCwEhEK68x3rfAB96OzvYRNDFJfcZ5BGqDaReR6CJOElaLiGdvmiKVTuothBY8tYX4Mh47ZEvzv0PHkymdXQ47dFW5PW8BH6f6eWUj8BsJcu9xMDIP3e9aD5TTeZmQBxLar4ng+k+xyEhs7uB1Lg2HO3rzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CviO1rN7; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CviO1rN7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso475965a12.0
        for <virtualization@lists.linux.dev>; Sat, 30 May 2026 09:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780159676; cv=none;
        d=google.com; s=arc-20240605;
        b=G6XqdT3PRbpn6Apy0NhuUrEWF6AKCBghvC5VnRm4r0gfVXDMOVw6/w6NcMsLsW62l4
         8F14Cg9qjIdl8brvGYuwM+aoN0C1DXeTahgvVxFxeRPOBJUMSp3763R/tAYgfVOPO1Xl
         n5uNjdrSxotCtXABkaPEKtVWwL6uhk8w9NOgpfltNobVSnO/gtMyTRT4PUKP8UpvksEE
         XzSYMrDZTx2n2Paroy8LT0M8emzWN7vEjngCa0uNx/VBl/AeSzGfqPblwPXmy/gYsz58
         wqcXOC90e9qLPLGzDY7gZP31hhRPeD7zKec4dvDRhT5aPw+qakA9OA5ttDUAqcrZ5r6m
         2CFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        fh=b1Fb16PZGtU17XzSU0y1pSW6f4PRhz7ZY9dq1nT2RLs=;
        b=jj5fygUqqW5qlg4GDFeyRRXcTzSB38Bbstftqyxr6hnyyheIiQYPQIzmovY1hkmIuL
         Qr0x3X5VjMwaZBz339BglMft1d+Z8v6zI+0eWoB4N45orfQWV4lXc9fHhDW116bYW+Lx
         9UiI4pdAlXT4ZRLA1NPdtDHfqKVdZb0NCbaQh2zovBV255yO5h3tiWwQBlMc7Dvp7IUS
         898sMA4sj806rJKWDaMsNhJL1zuSOLXCiRedQfnfn4cjzH+NpNuseJoT8+MTDbEHvfu9
         bkX8puUThDiuR4YfFMFniEE82IlK3O8fbP6tDoWfF8qWdi0Yo6uXaC/k5Ko9STEG5cY0
         OGsw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780159676; x=1780764476; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=CviO1rN72lw7ofxwoBABaTeyPHqwqbttUjvsSMrCbgLPMHMaf7lt1kOE+K9obj7Ibg
         iUM3mZ56tQ/VgwBDHlEJQYrUTTcNMljj0V8U7FrA8hxmJYEIfQfCvdU04ZWsOzTGV987
         VvaeWAXu7s0TuO2ehjfdP4L33JgUtka1+A0nUe2OAMg+d1ouNjhRF+Brm4I0o9ub7Xqe
         zBwtSHR6/7G9WQkW2p5JxDrLMVKyAkrlJw64OWG8Jjr3Uum2xzBkMYk+Q4wXUG312BQb
         T/GbVkCFdW/Ln3+jaxi0KFMvEdfSBBnrpHEeghyFzlLTqw6h46MnYAWvCUzuYBXkDxBi
         O1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780159676; x=1780764476;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=kd1Me5KwR+dRP38WUn20iBWRU6MBsvGfogUx1hbSeSSl5/DagQ6A/KkySba6KZHOv1
         SHFFvNCx3aBYtG9ajTlMfK24WKDIxajcyqLKHfQHUqMAv+nvCGagPsaDz586bGCXC17R
         aP/0ImdQmipBRPZdhvuC9Oy8LEUm645ceZtshamiOqsUUwA/kdaC3CFMC1vRFeF3uOSK
         Q3wXLv7Zr9FhbIBzsPeTVELJnfBpmINlwnEMLlXcoxcvqQWAIzRwNqo+hgL1fsAyy3UQ
         JU3xt7BfCbJfP1Q3dA29+V3cEwL38lu7j3MXVC771FCnFBinENVJVJxopG8aVIz5fJmT
         +pYA==
X-Forwarded-Encrypted: i=1; AFNElJ+NhdjfAnxWGrsKSgSFvGUrkCYjBHlMWpr4kej8Rb3ECFIGMZLniDoB4aRubbEcYlqdL8u2XjozRHf8WlHuUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlXNv/dviqTjysCZr/m90Xi4i4Z03IHqKVNjQgLz84nynaQQRI
	sVdwI9On4Ccuy2rrkiwrV+ghRjF95Pb20snFEum+X2BN13Q1uRAIJylXgEC3uUOzyDkPJl4DSkV
	HCrICOAK6R0Xh2lDXvCWOjZx78IGH3js=
X-Gm-Gg: Acq92OFidc2iLOVZNkG/JTqxcvAmmdVbFra/vvuCkN/EDlQ98HKQ8PhHS3wuAaEo+NF
	Ioixppd8t7voRx9xexrvSDAriMFCq1zpcP/+Q334UW5+LqYawOhGUq/vNSBU4m6xqXetTqw9pdC
	MzaKXmaHacee8qW0l/oiSBz7TNTndn+UhLF7sJhSBZVzTn33tWUWTaVIFv+iqDHNt1mw65FHyge
	U5cBIbpbq5EhwEX92KfY+1Zx1e1LqZPl9eeVhYW+4Gl4p1h9VSQE8/tzmZqEvaTYjg3QiwUJi3j
	ee649cgUq+TPXuoKX+FnUUzuKFuUnw8ENS9lsxMsV9n36PLpIg==
X-Received: by 2002:a17:907:80a:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-beab3850c0emr227580166b.12.1780159676193; Sat, 30 May 2026
 09:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Sat, 30 May 2026 09:47:44 -0700
X-Gm-Features: AVHnY4LzRI4mtM2MVMA9vVPgTReaIAtSfV8wr74SnOQ4vnVCBcmxdNjiRFE8TOw
Message-ID: <CAKSQd8XBoaUf7MyvPJCv_DHeuEd-DtRYb5GnAofkbJTP89LLMw@mail.gmail.com>
Subject: Re: [PATCH v4 15/47] KVM: x86: Officially define CPUID 0x40000010 as
 PV Timing Info (TSC and Bus)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

> + *  # EAX: (Virtual) TSC frequency in kHz.
> + *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
> + *  # ECX, EDX: Reserved (must be zero).

Can someone from Broadcom please speak up as to
what a non-ECX value signifies for their HV? (Asking
because I see a value of 2, not a must-be-zero.)

--
C.
