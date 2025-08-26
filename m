Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170C352FC4
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217018; cv=none; b=RGJqRThQGTgCVu9dllmewJUlyQnpuWaoS4ZknncOGpVsCtXwiY++XyctiJK1kyWw6bzQ0Dk4x9M9wifV1pgBygLZhL8OxfcZSJ4B79FdYZfYj5hx85DlXoAIHnv1ieM/npzGOnzP/v/0cq4qVBnGiu5Mr3Ila4nUI50P4vcz2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217018; c=relaxed/simple;
	bh=rjO0Dgpa+MvkB9kGuQaPMB5g0ekLMqstP2ZTtpD2Nsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IPrgCrl4AVs9a1nQjt/Vu2wHki3N9TFS0dUQMyJEGm/0NrucEJ6iJx9cuNBnhIUf63gWYDtvPEkBltUROR8tyNOL3j+EofNPPQxjZcUAwBcSRGwjV4Dw4bvdlQPKe2zlyfLdQTZ5R5zqHySj1fOdLdMdxa/0rDwltIZcJGk7kQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED+mLxG2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED+mLxG2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2465bc6da05so50554625ad.0
        for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756217016; x=1756821816; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aY0FrXGLxgZ/wGxfA4ovaT2GypQmDVl6QRK8fd0deSc=;
        b=ED+mLxG2RnichWjhGl1BEVh/eijQc5IHdN8mF2iS2mo93F3Xp5wwIYt68ZyD9XbN4f
         oQpslQaRwdLsaD3hoQB6o9TPYUqCfUNAg3sfyxIwZSv0Hh4qLmPSh6Q6/v83s7rihdyk
         AJRb7ZQyf8ZxmP6ue2ns3svZE2J8zbbS6u1J7DYvLqngbT1E19ODpN202fsjCQdOumPJ
         2HV2YSFvOYF+MaELeZ623cNWtHnk11bUEpwTlLeyA8WCS33xSTWFbz+7vdvnhlADAg/A
         61qoYtiv7ZmmK+XSaLybdxfCrcp7QbbieBKsIGGXSnnrhLPtKt9TwrN0gTpTRYGAMvU+
         LBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217016; x=1756821816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY0FrXGLxgZ/wGxfA4ovaT2GypQmDVl6QRK8fd0deSc=;
        b=i4oJrd1enxJv5hRhEsKkKIg5K7TftjMnitPYcpCjShq8wo81CInxsefrwoQsUgYaKy
         UqRc4jGC/EQpMrtfGvVulgQG/KndliKqqRMKi/TpDrORzruK3fidT8+kzlCVNp/sutvI
         KpgEIuKPc1l9XngbEZ1zAz+Qd1XE4f+GUg1htV7weJkCQdd3LSwgaQjYvCk1xbFYTUzI
         QJX75HsqTq8hcWl/8e5QEWSBZp/4GeA86nMLN7XTet9e1k12uzU8EUT2NujZbHIZdF1W
         6SWT/93BXgh5NUn82eSncJeYppW7iUiDJ+kaDqXeQste0Li9Z/kQaJRmPREAcR8asgOF
         MEoA==
X-Forwarded-Encrypted: i=1; AJvYcCW7HwLF8CSgrhbsX7tKHc3X6wl1KL/gMM8CTPihPgVQiJh6+0DzvXdzIxlzP1zUluLC2fzBPo+zUeQoFcSOGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk2yGQsdYgwP4EHRKj4ofKowA8uBCxvCwNYdlGjAD4wIXJs602
	yqYBc17HtKufgp9whH/GNdURIcdqb820jFHyeXmhADM5Hw7raYFNZqQfz/6QpTiXMv+8tE/72g1
	8hVvQPw==
X-Google-Smtp-Source: AGHT+IGVJFRNMksQGpAlkIJ4vRSKOikAD8qcNdNTZurK//e/TKsMdmUxA10VRE8eqTCLKXiBB2hNPFQ1m8o=
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:320:e3e2:6877])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:240:10dc:b7c9
 with SMTP id d9443c01a7336-2462ee2ba4dmr144692975ad.9.1756217015845; Tue, 26
 Aug 2025 07:03:35 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:03:33 -0700
In-Reply-To: <20250826034937-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com> <20250826004012.3835150-2-seanjc@google.com>
 <20250826034937-mutt-send-email-mst@kernel.org>
Message-ID: <aK2-tQLL-WN7Mqpb@google.com>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery thread
 if vhost task was killed
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Michael S. Tsirkin wrote:
> On Mon, Aug 25, 2025 at 05:40:09PM -0700, Sean Christopherson wrote:
> > Provide an API in vhost task instead of forcing KVM to solve the problem,
> > as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
> > along with a new lock to protect said flag.  In general, forcing simple
> > usage of vhost task to care about signals _and_ take non-trivial action to
> > do the right thing isn't developer friendly, and is likely to lead to
> > similar bugs in the future.
> > 
> > Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
> > Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> OK but I dislike the API.

FWIW, I don't love it either.

> Default APIs should be safe. So vhost_task_wake_safe should be
> vhost_task_wake
> 
> This also reduces the changes to kvm.
> 
> 
> It does not look like we need the "unsafe" variant, so pls drop it.

vhost_vq_work_queue() calls

  vhost_worker_queue()
  |
  -> worker->ops->wakeup(worker)
     |
     -> vhost_task_wakeup()
        |
        -> vhost_task_wake()

while holding RCU and so can't sleep.

	rcu_read_lock();
	worker = rcu_dereference(vq->worker);
	if (worker) {
		queued = true;
		vhost_worker_queue(worker, work);
	}
	rcu_read_unlock();

And the call from __vhost_worker_flush() is done while holding a vhost_worker.mutex.
That's probably ok?  But there are many paths that lead to __vhost_worker_flush(),
which makes it difficult to audit all flows.  So even if there is an easy change
for the RCU conflict, I wouldn't be comfortable adding a mutex_lock() to so many
flows in a patch that needs to go to stable@.

> If we do need it, it should be called __vhost_task_wake.

I initially had that, but didn't like that vhost_task_wake() wouldn't call
__vhost_task_wake(), i.e. wouldn't follow the semi-standard pattern of the
no-underscores function being a wrapper for the double-underscores function.

I'm definitely not opposed to that though (or any other naming options).  Sans
comments, this was my other idea for names:


static void ____vhost_task_wake(struct vhost_task *vtsk)
{
	wake_up_process(vtsk->task);
}

void __vhost_task_wake(struct vhost_task *vtsk)
{
	WARN_ON_ONCE(!vtsk->handle_sigkill);

	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
		return;

	____vhost_task_wake(vtsk);
}
EXPORT_SYMBOL_GPL(__vhost_task_wake);

void vhost_task_wake(struct vhost_task *vtsk)
{
	guard(mutex)(&vtsk->exit_mutex);

	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))
		return;

	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
		return;

	____vhost_task_wake(vtsk);
}
EXPORT_SYMBOL_GPL(vhost_task_wake);
