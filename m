Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D63148BD
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211451; cv=none; b=OxQs1YnjyH69qkpF+wsDIf3ZLI/oMA6oTutLbXHxq6cElZwiPvmbk918rGrrLrCQomwEY1/5SBrAifZu48BLmhpO+iyxgLP4j3l/S+azsOjiEw3w0ZUEvBElv4gf2jGyMT+biEp/S/hhbdu8J010kG/lgoR0dlqgCj2SNhOb+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211451; c=relaxed/simple;
	bh=Z5B5dt6wI87+KOD3sTN8FRIoAj7TBjgpAUwP/aqCmqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bM4NRnoIU7S0J7yA7lYXqcDBPR0rM2hv76yrWDB8q7WZXP16rr865X6BxGAuNbLIsUANHk1LLr6aK7YiTOLl8Do0nxvAhiqFE+F3yxq0WAWuubmtBGZzYMwiSD45Sd7InpO4BQpOSdP0LFMJ9/Q8W3HO57QxQpg5DIzshbjt6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChrHGhmo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChrHGhmo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1635527a91.3
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758211449; x=1758816249; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqabNObTrUIXb/BYAEPfcGgxscP8Gw2Vuj2oVftkStA=;
        b=ChrHGhmoihgLdtIltWUAHYury7W11iIGrKbDQ+Ig5sL83Y84+lG4Q0PyYNqQ4plU4w
         ExhQ0yILLDMoJHSYffjywoTkeVcANhrxgDcl9U/qAcT7Ojfpzx6EiynYCLBj6LYbDMsa
         EU05YorL/i02d7p/XMFnYyr0S2tconXl31AspEklLz3T5qC77R9kyzRSB6yjMJxhEROc
         0kvYNy2N4LowQyyN2eI++yqLZoBmbMeAnVGaLJnFzyo10DB3exdyo/KQFivaqRVNPjSO
         qopkjK4CM/+GTgP1C9NHS22za9fyyXNN4mEwFqefLhTFOT6WR6iXyYCBCgEPBG345Dme
         /T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211449; x=1758816249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqabNObTrUIXb/BYAEPfcGgxscP8Gw2Vuj2oVftkStA=;
        b=MLjylMO7SUNPU+PWbSmQKswqLswgygvBId544suUdrAafIJizebBwfOyOwCwyVrxL1
         TZNkvYljBw8Du2RuysnOdJO9snUnKDypbKldFFgQULWvNelrDvPOAsgDT2KBM0zq/MU7
         E89KT1DbW3o++ncDmlsGx7iQGm/8YKj6Z6SNj4yG/HxDZ5tqCMOeWg4jc6j14PEIm3/1
         GIGjvOrZrjAjfxz0Fg5R7Ye//9/Bw3nPrbtKCJAH/Z1Cuo9q8+Hos2O9H24AqNxk5YjU
         /3S1GD6JIE4V0iRMy54A0lndhr0S16hiWtcCP3IuIwXif+ESsIlLyMUWhJtL/eyZR28V
         RgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWetB/Q8Lm0Eqsuc+V9L7w8OM7BWa10cT86kkZBA0ATgPT0RbGkk922pCUHfdTnTHZgqyAuAl1UIi4HIlSYww==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsmi4LCb65v1xcd0F2p+GPXK+K69CJWXdZsqsANty0OW85tVif
	vuKi28Yu7PppkN7KoKigeTKxeNyElkLvE1+LFltrtp4vU4xL9qPyoIqzan56juZA42xZqzOEhWi
	+/6N7Hw==
X-Google-Smtp-Source: AGHT+IGkmbYJfZP5nllHSP5gPnF6lwqm76wSLahcIX1/RcNPCgiykqnALzGjrifpViIQLPrzkR7sDPMdXBM=
X-Received: from pjp16.prod.google.com ([2002:a17:90b:55d0:b0:329:ec3d:72ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4b:b0:32e:9281:7c7b
 with SMTP id 98e67ed59e1d1-32ee3ebb1e1mr8451052a91.3.1758211448798; Thu, 18
 Sep 2025 09:04:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:04:07 -0700
In-Reply-To: <20250918154826.oUc0cW0Y@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
Message-ID: <aMwtd40q44q5uqwr@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > So how about switching to this approach then?
> > Instead of piling up fixes like we seem to do now ...

I don't have a strong preference for 6.17, beyond landing a fix of some kind.
I think there are three options for 6.17, in order of "least like to break
something":

 1. Sebastian's get_task_struct() fix
 2. This series, without the KILLED sanity check in __vhost_task_wake()
 3. This series, with my fixup (with which syzbot was happy)

Longer term, I'd still like to land everything though.

> > Sean?
> 
> Since I am in To: here. You want me to resent my diff as a proper patch?

Ya, I think it makes sense to harden against UAF even if we fix the KVM bug more
directly.
