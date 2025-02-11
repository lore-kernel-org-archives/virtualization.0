Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5826156B
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295807; cv=none; b=ob1X18qmvBOBE7BBbu2ahmC+AOPy8NxpR8wg+pk0UgFG3AMMOV26Ox/ndFjRUUnF/pLpW576l2LdcUunGak5sA5nSGvAe8imaifzkc/XxFWNz/akhOLcIzRtE3Cn8PWkwALP6Z/u2+gJ5jYN7+30W5sjEgbVIbyOrRXs3buvJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295807; c=relaxed/simple;
	bh=7JLxDrT3W6Nr5nwag7NkXl8otRQTU+qirxdskHYS1cQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4udFNz1AhXbKuR3prgAjPNgFx2BFRQ0lk0Ru6yUA00k2oTqh3B4BeOVzZ6rghQOaYytVHUfoq39BVf/hDuO1LxsRHrS1R+JGzog8s4XpvSpFVut2b/RcEEj/yEnzRryPl3pHbA/NnRd7S7dLx+EXiHXuMZ9llHGc1sfy2PTBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjWFmJml; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjWFmJml"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f7f00c75eso55811505ad.2
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 09:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739295805; x=1739900605; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mrriPfgsPPxXSFmU/JBzChLIiRw5rZPULaSxSIiLc=;
        b=fjWFmJmlbKcnLoolETobxuADDWexZc9XdFTrJ+BTDgPT7hAl1L0+DeSEMYcOIbovIc
         COnb/nvdyQKXwokwFUJfIGkHiKeZ0QXANqTOGgXSdRNmYTHWT+Lz/E/20e979xhrHRUD
         O82+P9pgxjb7pIC1gc/1BXI5MQeZ2wfRGzabwI1fGsrxlZ6O/4l81bhsl6B1ZSsiBsyG
         eR+JWUF9A89MLbVsVOPzknRnpWU/+R6HPx4ZJKhl/D/IOei5zIxqx2jc8CT/XPKOKdJj
         eKH1f21gMHRTBhtEL5b0kL1wsPiin/xKn4/JDqlTf/AG6D/N54zYOUZqZtXyY3GwLFOK
         fZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295805; x=1739900605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4mrriPfgsPPxXSFmU/JBzChLIiRw5rZPULaSxSIiLc=;
        b=GHEVXZlIl74hPezlW+DHpHroP04jqL996QhaxA8YB5G2HF4deBrCPpVLsbxjEah4QJ
         dl8w7rso73HXg29dppPTL2jZTeVQhExekobhJoVKqYKEEyzYnXqfBes61lPfvoL4Gc3Q
         n/j8Yci9Yo5bOU3X5fcSV7DOJtxJPWCavoMIHK1BWUNN+glhCyjnyWnqcpt2DeLlkqpC
         WAjKqQ0IBpImM1q6qgMJbxyo4glnshNbUXx46EC3llMMAncgdUpG913rVZq+kJqCevEa
         VHFKP2RxF3iVJgMLueoyyqGFBD+gSxSfshXNlJvq6+5L91AR3dUu3C2u5PUr/Ew1SDSW
         WG2A==
X-Forwarded-Encrypted: i=1; AJvYcCXbpzMPx7HL7fcXkEZuM1AdwccO6s/WIS9RDM40/ChUT28P5WLuGAjaXyNE+Z9oUD1i0kq9fz2111RjC9Iyrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwKGnj6bA3rwRVt6gljBRUdGNnOda1Jp5BGg7fzgz9lr4OuzK+
	jk3qsTIKHB5e3acMHQs3KwDoP1T+vUSRoComOmazc9lzRJylnEv4+pnDLPVb2U7r59G5LC0Y/Ob
	GFw==
X-Google-Smtp-Source: AGHT+IFvsE6NJWsYg5eZawythPvtd1Ryiyh5QdfSD0iYprnIkMmal30fbTQ5swLortjkJ0haAujEqXDb7dE=
X-Received: from pfbbj9.prod.google.com ([2002:a05:6a00:3189:b0:730:8ca0:1f9b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998f:b0:1e1:becc:1c9c
 with SMTP id adf61e73a8af0-1ee5c7db2d5mr167479637.28.1739295804800; Tue, 11
 Feb 2025 09:43:24 -0800 (PST)
Date: Tue, 11 Feb 2025 09:43:23 -0800
In-Reply-To: <20250211173238.GDZ6uJtkVBi8_X7kia@fat_crate.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-4-seanjc@google.com>
 <20250211173238.GDZ6uJtkVBi8_X7kia@fat_crate.local>
Message-ID: <Z6uMOyHD3C6-qCXz@google.com>
Subject: Re: [PATCH 03/16] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Borislav Petkov wrote:
> On Fri, Jan 31, 2025 at 06:17:05PM -0800, Sean Christopherson wrote:
> 
> > Add a TODO to call out that AMD_MEM_ENCRYPT is a mess and doesn't depend on
> > HYPERVISOR_GUEST because it gates both guest and host code.
> 
> Why is it a mess?
> 
> I don't see it, frankly.

It conflates two very different things: host/bare metal support for memory
encryption, and SEV guest support.  For kernels that will never run in a VM,
pulling in all the SEV guest code just to enable host-side support for SME (and
SEV) is very undesirable.

And in this case, because AMD_MEM_ENCRYPT gates both host and guest code, it
can't depend on HYPERVISOR_GUEST like it should, because taking a dependency on
HYPERVISOR_GUEST to enable SME is obviously wrong.
