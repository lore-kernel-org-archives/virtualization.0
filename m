Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94586284B3B
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218292; cv=none; b=FFj1N4gwEJKPVjy0f393oSIH8CqSxuXaWA+16nONUlakjYr7C1jDAdERnOEdcAD/f0MCjp9LyOT75WRrKbtK6hSGcyBgEEARbjgrNVOszDZIQOYMJmsWLJMuqEiqJCqg02HZi/WoCNGo3HMqFcPWSptRUpKlfQBWuXR+MzVGbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218292; c=relaxed/simple;
	bh=VmpW7OnEYoEyc5lIRNLt2u7dmN2rs111BQgn9ACktVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P0zY99W6fF/8Uy0uw/Tw8rhhf9NxNpOkDb/bKIPHFuxztedRncK+RVA564e4lpV7aGuJ8KuMBaQ9S0ceqZ0W0cdzBwCV3oiXFk204Lryke3D9hhXZs2dg6HCltdEC1rllmEMhVjgpFy3VjTaQ8P5NyAzDFJ94fGzNcvMIaeLu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gU7g3mQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gU7g3mQ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b52047b3f21so885601a12.2
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758218290; x=1758823090; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/M1FEowV3diJ/eMdBsk6hJ8wec8W1gdfm/YaaJ0QnQ=;
        b=1gU7g3mQ+RsKMvF2omem5PgWlq10K7GGBX7dpeN9OYxY9RHVJLzkzG/8T6sXPc+jHh
         x8ymGltkRQHT8yYAzxLsFwXcUPoLh4bPgsX9ySZPWF8wID6/oICiWKr8Uy7FTgRf7EVw
         OIjhOems4cQimUSVwntq2C5ZGu1NGVZ0fK9njmGAltJ1eFZZyfp/PFhm8iUCFaRNmQ3Y
         pAIUxoMSs5ZkoLCfBZG+pPVjPtbPPmjp8RvPHf578oFqdgGf7/rNEOIXhdKz4xmck3ey
         3xizCrrKiXr2rzEp7UVU3zAh7jjToGViQgZf3aDHfxIbji1oSR9tUvfwj7h6JajqVYtE
         oylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218290; x=1758823090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/M1FEowV3diJ/eMdBsk6hJ8wec8W1gdfm/YaaJ0QnQ=;
        b=u/BbdP1hWTcRF+y2fVvoHkf7cTeY/Y880aKJKykvSpElQFblUlpsmoIIKDXW4hFRu8
         fEOh+ar4fLZnwiWOhGuy6Bu1m0V0Xjcrx7nprCzIa0azatcQ0kGgvRdSq2Pc/jcNzkwj
         Za/3ON9Z71EQtWHjX4ndQmubyuOgL5Lv4DUM8Gve375ZIsq59YtIAKg/aPNI7lUIryPm
         COH424sZ9M/cEDBsW2wHCm+0cLv9b79N1YmUw5wtwxwx0IvHn+hRvU9sfDE1eNKAlbU3
         xISN0c2m6E0/58izbkNZ3KB9oPVQfTNXfCjrsiFauIajfl7ilL3LhvEUNX+vffz4RPEN
         dxEA==
X-Forwarded-Encrypted: i=1; AJvYcCVxY/FkACi2amkdK1GY/MgKRLBt3OJNV61C6x4TSxVKe+s2y5hSQenrvEqvFo+IzWLapvWSe7d3qrFQJI1PMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP/TpcI4cJVEs2ciT7FMyWTC/xGrNZ/hEBg+c2ccOqTKxow/Lb
	MEelEG0wX6g/cVGnxJKuWwUZP9Q5MTVemIAfbFr+sj9/3P+RwAwpuvqjM+bMVgoQV9ghTegytMm
	Kqk0B2g==
X-Google-Smtp-Source: AGHT+IHFOysq+TUFP9EvRmUcELUaug1GgnM47ZAa/SK6gIEhQbX64NyajJHdrY4fLWC0UBAHJ5CzHUj9VNc=
X-Received: from pjbkl14.prod.google.com ([2002:a17:90b:498e:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec83:b0:32e:8c14:5d09
 with SMTP id 98e67ed59e1d1-33097fef587mr345549a91.7.1758218290023; Thu, 18
 Sep 2025 10:58:10 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:58:08 -0700
In-Reply-To: <20250918133938-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com> <20250918120658-mutt-send-email-mst@kernel.org>
 <aMw4wx5ENt-odhYS@google.com> <20250918133938-mutt-send-email-mst@kernel.org>
Message-ID: <aMxIMADtzYrJg6Pb@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> On Thu, Sep 18, 2025 at 09:52:19AM -0700, Sean Christopherson wrote:
> > On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> > > On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> > > > On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > > > > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > > > > So how about switching to this approach then?
> > > > > > Instead of piling up fixes like we seem to do now ...
> > > > 
> > > > I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> > > > I think there are three options for 6.17, in order of "least like to break
> > > > something":
> > > > 
> > > >  1. Sebastian's get_task_struct() fix
> > > 
> > > 
> > > I am just a bit apprehensive that we don't create a situation
> > > where we leak the task struct somehow, given the limited
> > > testing time. Can you help me get convinced that risk is 0?
> > 
> > I doubt it, I share same similar concerns about lack of testing.  So I guess
> > thinking about this again, #2 is probably safer since it'd only impact KVM?
> 
> I can't say I understand completely how we get that state though?
> Why did the warning trigger if it's not a UAF?

It's purely a flaw in the sanity check itself due to the ordering in vhost_task_fn().

As is, vhost_task_fn() marks the task KILLED before invoking ->handle_sigkill(),
i.e. before vhost_worker_killed() is guaranteed to complete, and thus before
worker->killed is set.  As a result, vhost can keep waking workers that have
KILLED set, but haven't actually exited.  That's perfectly fine as UAF won't
occur until do_exit() is called, and that won't happen until ->handle_sigkill()
completes.

> > > >  2. This series, without the KILLED sanity check in __vhost_task_wake()
> > > >  3. This series, with my fixup (with which syzbot was happy)
> 
