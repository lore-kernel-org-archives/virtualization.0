Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F421E0E08
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219261; cv=none; b=O3oZwvp5CtOJwXxEsflxnmW2/CacdwD5FPU0MKzDFNTEaM8wtMeSYZBjidOUIvnlCbuYMKfXbJ19vJJKGmJw3cllszpiL4ZahqvrKND2fR8uFnsBxJLD0AjQs0FS9X2yn9MnEdVGkrkLykAbtd1vlyoS9z48wuPkFKyqOkpfFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219261; c=relaxed/simple;
	bh=UV6QsGJaNRCIjLl6uGJScd++GUZtMzgSHcsM6bVx3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bEVgVLY0bBIFmKu3oLf4fbTlq78hv40GculwXG+hVmbnnCInn0tnbUIDfLIs8sJ8HljTYa4jGyOL1vfgq4xIN5+O9tE8ZWaCJ/u0pxxWV0YU6/zmcWLoZ+ajYxPgryLTxiFsxXIvUSUhvyYBiOOLZVuyQvbzZrpoaxVypavXO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO1bToP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO1bToP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
	b=WO1bToP91ispJ69P0K21+rAnZVGMY77+QthH1BIJJgmqAwoOvMY4uB/w8v12ILKfUJBHMZ
	imn1dIOikiNTrqCRxv4OIlTiWgk06bY9LbJ5sYS9qmHGivHesvZfg4voR0yWrmn9owDQjD
	eUimPDVl9wfco+hxlqBI9fOiP/yCVXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ErehNeYeMWaF5PdSTTgTFw-1; Tue, 26 Aug 2025 10:40:57 -0400
X-MC-Unique: ErehNeYeMWaF5PdSTTgTFw-1
X-Mimecast-MFC-AGG-ID: ErehNeYeMWaF5PdSTTgTFw_1756219255
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so33846305e9.1
        for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 07:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219255; x=1756824055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
        b=bbbSmWQogOsFsS4zxBcx6qFWWDKr8Qr7YIHT23c7Xg3AbkjNWDMrxLS+2HAeLaxrPT
         2uI8QWeJdTtvWSF8lMkT9iw68aZNjMTbmPclVVPI2U5aV5kp7dEIQSYfG9qQH5Afl5JN
         n/UvVW79kuFyC7BCw+L6cuzjnB+JBAs+iR19QDOq2KleNJEQ3cudKFTBISFrcOtmV22m
         3HSSrynQqlYgptpKIMzcBJ8fECBNRKfCqF+x5cNAqeyRDJFljQDduA+mHgRSdJQl+GzB
         L3UPHfH4rno4i37PI+PvvmJA695jpZNkogfDZvDJ9q/JzXHf1bJQG7lH6ckSBFKzuDx6
         l9AA==
X-Forwarded-Encrypted: i=1; AJvYcCV8YL1el8KOdQWAa4qmRgh4WT+J+AtApfcEylvZ1d4BUOTtPmSCwhq9j5sXQGFApD9jf27scSAIRsOBCWtn7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yynw4aqVOtQyGnwitwZcO5G4uo3VCzHPp8x/9yt366pAfRC5/IX
	709dKNokyMHwkk+lSURl18vybGAnBvCxcAjVP7IoGurG5XkXTuO3c+XHZsBgnflFbC/CqdShsM2
	ajb06QwmmiashhHYv9IgyBhU2POBnVWDkPRlgt9csTxlcw5O1y7xWrnQP7QfrjdTtdxjR
X-Gm-Gg: ASbGncvsPKcaIqjEL/55H+yt0ca5MMJPOqRv6TJkdM7Ti3jr3VtApL8me49/u8/D4E9
	LJh3qHh8QQLj+r95vlBI5CM8YRtbxvxBHSv6QQLUdYs4SlUbubS8oyHsO+WhCtwc2vFtQgCUhbc
	UmdIasxKg01i1hy+leErzMfoaNWG5QNndKvEa/JYwoSFbudpdT3xVteGUd3xGSXATfq07AqZNEn
	hEzjSDBomghcRJwnhC0eivA+g1/FtJ+/zGc4b+aIhYz3TkCaM204mmsseg8BZ1PMMwPZz3glLwO
	Mht0neirDMINwerHI2/cwu8Mt3A60Is=
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149244115e9.18.1756219254628;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQn6JvvJeT7MlM5vxv7NDmMYfGEo1DRscOYnhsp0L3inuZrfVRfxK+fMUnsbs9Tx6WF6MBXA==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149243805e9.18.1756219254143;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
Received: from redhat.com ([185.137.39.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5df6b356sm112346715e9.0.2025.08.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:40:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:40:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery
 thread if vhost task was killed
Message-ID: <20250826103625-mutt-send-email-mst@kernel.org>
References: <20250826004012.3835150-1-seanjc@google.com>
 <20250826004012.3835150-2-seanjc@google.com>
 <20250826034937-mutt-send-email-mst@kernel.org>
 <aK2-tQLL-WN7Mqpb@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aK2-tQLL-WN7Mqpb@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ekpdjix-Qze3HyA1t10YbP9G6jKdZfHIPldLKObyBKs_1756219255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2025 at 07:03:33AM -0700, Sean Christopherson wrote:
> On Tue, Aug 26, 2025, Michael S. Tsirkin wrote:
> > On Mon, Aug 25, 2025 at 05:40:09PM -0700, Sean Christopherson wrote:
> > > Provide an API in vhost task instead of forcing KVM to solve the problem,
> > > as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
> > > along with a new lock to protect said flag.  In general, forcing simple
> > > usage of vhost task to care about signals _and_ take non-trivial action to
> > > do the right thing isn't developer friendly, and is likely to lead to
> > > similar bugs in the future.
> > > 
> > > Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
> > > Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> > > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > OK but I dislike the API.
> 
> FWIW, I don't love it either.
> 
> > Default APIs should be safe. So vhost_task_wake_safe should be
> > vhost_task_wake
> > 
> > This also reduces the changes to kvm.
> > 
> > 
> > It does not look like we need the "unsafe" variant, so pls drop it.
> 
> vhost_vq_work_queue() calls
> 
>   vhost_worker_queue()
>   |
>   -> worker->ops->wakeup(worker)
>      |
>      -> vhost_task_wakeup()
>         |
>         -> vhost_task_wake()
> 
> while holding RCU and so can't sleep.
> 
> 	rcu_read_lock();
> 	worker = rcu_dereference(vq->worker);
> 	if (worker) {
> 		queued = true;
> 		vhost_worker_queue(worker, work);
> 	}
> 	rcu_read_unlock();
> 
> And the call from __vhost_worker_flush() is done while holding a vhost_worker.mutex.
> That's probably ok?  But there are many paths that lead to __vhost_worker_flush(),
> which makes it difficult to audit all flows.  So even if there is an easy change
> for the RCU conflict, I wouldn't be comfortable adding a mutex_lock() to so many
> flows in a patch that needs to go to stable@.
> 
> > If we do need it, it should be called __vhost_task_wake.
> 
> I initially had that, but didn't like that vhost_task_wake() wouldn't call
> __vhost_task_wake(), i.e. wouldn't follow the semi-standard pattern of the
> no-underscores function being a wrapper for the double-underscores function.

Eh. that's not really a standard. the standard is that __ is an unsafe
variant.

> I'm definitely not opposed to that though (or any other naming options).  Sans
> comments, this was my other idea for names:
> 
> 
> static void ____vhost_task_wake(struct vhost_task *vtsk)

That's way too many __. Just vhost_task_wake_up_process will do.

> {
> 	wake_up_process(vtsk->task);
> }



Pls add docs explaining the usage of __vhost_task_wake
and vhost_task_wake respectively.

> void __vhost_task_wake(struct vhost_task *vtsk)
> {
> 	WARN_ON_ONCE(!vtsk->handle_sigkill);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
> 		return;

Add comments here please explaining why we warn.

> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(__vhost_task_wake);



> void vhost_task_wake(struct vhost_task *vtsk)


> {
> 	guard(mutex)(&vtsk->exit_mutex);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))

Add comments here please explaining why we warn.

> 		return;
> 
> 	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
> 		return;
> 
> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(vhost_task_wake);

