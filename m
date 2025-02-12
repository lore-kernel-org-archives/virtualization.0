Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773A204582
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400944; cv=none; b=rfs7vo2yVxsiQd78Rz68a/iPSDJnRb0aiEwcPgLomsEamrFV+GRhTjh0bugKMrHb8x2hjf5S/PtLFEoxU9/P9eeQdCxVwhp6BVxzHGLK6nGeUUnvwnDpgtSqHfGXYur3lfebuHjrDC9RpUvNvbUy4kjHPd2ZLEhCMkpVM7ptWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400944; c=relaxed/simple;
	bh=M/JEAtm/aKqZQpUcIkbOx1V5MbhNPluJ7A9OR2+JsF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0tj4trzwKlFwT5YsZV3sjHzRY/nfNqk665saiv+a0+h7Bby6xqy+C+fllEjt4km1Jgyu1SYp3Qh0U9Y/6vKgOd9BcgknhKye6Q/n2W/b+mv9ekK3P5DwxNWu6STYhGdK1vg3NkdnbZFx6+2lgBjcEd/gjZJl1k3ARG9kiRo80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbix+M3+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbix+M3+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216266cc0acso27476955ad.0
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739400942; x=1740005742; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=pbix+M3+gHdLeHOVBDASDOmHCG67hMNyLb9x15lFln7UscesoMxLWgbFCribawMABu
         YHzYQ8EmOFF18CZVDz/gpZX5GxIa/SG40Y3ukA3QFdp/d/TJ6YPaj+HCL1VOo3wbw9Jt
         yHogwcZ8HSAu1OJIs38/lph9VTIcMAp1+XAp5mq13Qm1F7LhyfD+UVUOj/9OWtZJ3DhS
         LBbr6d4bxgtM11VKQM6GsNkJcD75+JOFIiE2OR+mioOvAhNvwAKDZikE8HTM4oABIwgq
         aen5IsY62uBMYMBHT1KnIzzm4OERxBJjzmdZGS2g/837bpM2iov0FQCmRY/joTlvD3BP
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400942; x=1740005742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=qV+B9rUw9L3GR0QqNEJkQs7aCX0kk2KBG70OJ9xXRNBaS+/A8gYvr7VE6iUtu8BqCQ
         WLE47CCuB06ea7MJj9owwiLFD9SQ+YDwUU2Y6VLBCUk/2L4tmXbFwhgUx0LupZIx9IUB
         DshDET6jMBTHJuCJlT9vTqLE8rsllnsIVfVC7gYWJ2yx44441fuGq+rElEbyVbf6iN2/
         IPTRuhTmVl1QR1FICeEFtxnH6YDAAyBhqqmmrfvyq4xUXLZL5QOEbs5Sr4oZNCNr3wJ7
         jfu5BI1DgYs4DdjbKmXsE00p1POolxmwKbYlc37ubMqXTxlefilZTNKKeR9if78/vWsr
         uIOg==
X-Forwarded-Encrypted: i=1; AJvYcCXc8mARFkjML+lIWLn4xEmIbA+PwxLEFvF2IyCbYYRlwah3C93I5171zXPAEWHXWrp0QdGSicJJY1eNpzeQ4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSwpTrm/r7ghB+r97fo3Vy7tS13DtE1t4qC8vVIZqm+B2VqYbT
	baZBSYjS6rG0F+ODeznnO1JjdIoZA1maMcYka++zLUK16y/D3hpR3i6+u/IOxEkF5XJrUSXpzDH
	JFw==
X-Google-Smtp-Source: AGHT+IFCvprC2FVz2MYwofAu+gOZ+t6GzfO0x6W16EewccF+NjWJufThiJaaDpuXjWvbsRckLewQnEmSOUI=
X-Received: from plbb4.prod.google.com ([2002:a17:903:c04:b0:21f:14cc:68b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94e:b0:220:c2bf:e8ba
 with SMTP id d9443c01a7336-220d3528cc9mr11030295ad.14.1739400941927; Wed, 12
 Feb 2025 14:55:41 -0800 (PST)
Date: Wed, 12 Feb 2025 14:55:36 -0800
In-Reply-To: <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-17-seanjc@google.com>
 <Z6ZBjNdoULymGgxz@google.com> <SN6PR02MB4157A85EC0B1B2D45CB611FAD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z6onnUthSBUVAklf@google.com> <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Z60m6NiOlCmy4-q0@google.com>
Subject: Re: [PATCH 16/16] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Monday, February 10, 2025 8:22 AM
> > On Sat, Feb 08, 2025, Michael Kelley wrote:
> > > But I would be good with some restructuring so that setting the sched clock
> > > save/restore hooks is more closely tied to the sched clock choice,
> > 
> > Yeah, this is the intent of my ranting.  After the dust settles, the code can
> > look like this.
> 
> I'm good with what you are proposing. And if you want, there's no real need
> for hv_ref_counter_at_suspend and hv_save/restore_sched_clock_state()
> to be in the #ifdef sequence since the code has no architecture dependencies.

Right, but because they will be local/static and there are no users outside of
x86, the compiler will complain about unused variables/functions on other
architectures.
