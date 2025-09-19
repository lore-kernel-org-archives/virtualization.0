Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6992D3731
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316549; cv=none; b=LgJLbbRFSlUTv0qvNfZbRkRI9xHisc0cCoIyXdmrIWF1r+2ZJ1mIjyo33xgKxCAf/0bUPued5oK7yWwJIgIP6fBPotyMXJtF4U6vSO0/LyIWWHXAWkgCv1EUDEElWdXH3UT9YFg/Z1wANws9NCa8o5JAtTwHQsBjyykxXLu10uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316549; c=relaxed/simple;
	bh=75+xMcEBZ4CCJG3zy2Fp8An358EsjOFKAwpWo1duVAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVeVpurf/s4Sv0JIbLR5iek3jh0/OxUNZOUAJpqmwfcegV5DGet3TQzPJxT9tJkgkkBkTDhACSlm7LlPUXLB9R1B3OTW69HX+05DjR1vB4u3ZzvGCthjHzrI5e9uylVl5thIc3/pgmDYFroDVDIr9EBgHmswmMejwFujOgY/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpIlJIs7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpIlJIs7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-252afdfafe1so26915715ad.0
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758316547; x=1758921347; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=wpIlJIs7LmyBS04DkCLik4L+Zt3mhb4AQ3Pq+SVl3EET5dLxXYWaekeRLIQGWZMDYF
         bJkX7uuIfRodS0SFmCBGwHLv/PPKNufSb8wJJzfxcqWung52C07utJrEe0QIPwVEAL4b
         3IYU2e4yvMef3JH9GVzEerIaLFXL/ENwLpxZmi2sj2ver1B56abMicx+XE6t1Ty1kg3P
         OwSo5gIzeQH0WKZvJyVEazHvcoL0sRAWvvxAc7MQDskD3vyvLKL5H49v3zBB769VYdbe
         IalkSvIDDunWZ/ebtPmU2+8rzCMKesirbLOxrCJqHtghUkSTpCklq0XNyIkCQCRitzOV
         UKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316547; x=1758921347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0+Liys18anQK6gRZATENTJbkZzHDkR1/8jEpmQV1kk=;
        b=f9Alu1j76uAysN7IsMF7dLb+z2Uz2IyFyTsC2IbhVBjnGyb+LSTW4w2o1BuEVxzi7f
         IGj3Z75g5472rn6i07ZrE4oS+UO9scklQmsq3qq9WRsEMSds8NHOqN0p/dCHCoGCZuVq
         Y/VWeHlpyd0mMX/evpVD7RaiNm2hp+HPWqAthtmFXES3FdXMTvIoT5vr92/G4A4KS1o0
         bd6lBFwLKG00gqz1fwhGFSDoJfi0JMcH81yJGjKUJc9eXbsZ4L4HRM27F9L+kAWyPNaQ
         6bB69WmNt7i9DXPrLZrUsnBJYNUEx8Q/HptoYThmw504dwWDT/PfCfTOxDEtg0DgUoc7
         9+ow==
X-Forwarded-Encrypted: i=1; AJvYcCWm2lbThrg6lEbfrgSaUG4gUtCrUJRs5FX7zAzXbd0QXS0y9ZFEjFr/PHi/DXZ2GriEtfjJneQncBdtHbsrkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yws8M/lmmsoEsu7hlnoBmnl3PFwOPeYJSfOn7wlb3HNv/vnLAiV
	37BZz7uZ7Heom2ph4juhj9tcs2AZ+INxysiiGUmFi3g+aOUv6g+e+z5Tx/y4lxq1UOXnuWQKqsf
	kC05gnw==
X-Google-Smtp-Source: AGHT+IFdtQnkscwGqsgriF6C5QkossH14ZthE8OI9NmQ2k9LQwcIhxPc2sZV4JW/RFjatX5u3z54HnLVEKs=
X-Received: from plbjh12.prod.google.com ([2002:a17:903:328c:b0:269:96fe:32ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:25c:e895:6a75
 with SMTP id d9443c01a7336-269ba4f020amr59534475ad.28.1758316546890; Fri, 19
 Sep 2025 14:15:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:15:45 -0700
In-Reply-To: <20250918181144.Ygo8BZ-R@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org> <20250918181144.Ygo8BZ-R@linutronix.de>
Message-ID: <aM3IAaCVx-PDeDsi@google.com>
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> vhost_task_create() creates a task and keeps a reference to its
> task_struct. That task may exit early via a signal and its task_struct
> will be released.
> A pending vhost_task_wake() will then attempt to wake the task and
> access a task_struct which is no longer there.
> 
> Acquire a reference on the task_struct while creating the thread and
> release the reference while the struct vhost_task itself is removed.
> If the task exits early due to a signal, then the vhost_task_wake() will
> still access a valid task_struct. The wake is safe and will be skipped
> in this case.
> 
> Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> Reported-by: Sean Christopherson <seanjc@google.com>
> Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Tested-by: Sean Christopherson <seanjc@google.com>
