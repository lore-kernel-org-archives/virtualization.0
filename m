Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D42E8885
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794071; cv=none; b=aD8R3uZFlHBo2JWe2TLBiyI/FaZcRuMME7Ixc9YkTHzjOTti6dOhUqUdylg5XvnHnVgAuhKxWmPVpbMA2uPCgqRClRFhza1pSGHTwwrn0AZ3qu53L3mqLu2K9xaFxi74/Ka5R97ZWOnJI+sh/ZYEEFEvCTNkRaYMWJiV+uVfSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794071; c=relaxed/simple;
	bh=XKWkUMZVzA+dBYCVPpvxIgaKdkXs4N/J7Rl8dOvJVz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F7CHct22XoLCV+wU+at/5m/dabX8YK4B53O/Go31V4r7sv6jJXB9C3aV7OGW1bss1rVJQGIegfEUPdFaH9nVR9xxIfUwKFLwloWIJxxPy+Fu37zt7eVUOjTRF1gzmfR41y4qEkg/RDOi+LmMIRc20aw6eJb5jWrRZGYK7wYjosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykIgNPHI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykIgNPHI"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748764d84feso7644559b3a.2
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794069; x=1751398869; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=ykIgNPHILoL+OFGu+tMqfMBI71a52Ck+dAv9Ppgs4/riCwTBKAx6woUVAk/GIF5KXV
         juFpDrn0/u2NLCcp0N92OXIGhGpEL9DjKD3guv+86qBBgHCLBU9kWUQlmIDFsiGWyrYz
         FTVPMfhH/fWEHsaquN+AE3Tf4zzEDTniENHZzoxY1thnHyNcQlTCWh1+HhmacnCDsPIQ
         Fu+7KgnJ0ax31v3+UN4OKE7J6WNgCDyrIZysczwzcp412TXVvH44WiDcK5NsKG1otocO
         m91xQIf0NNyBH0v/AbJPf67t/nXi1qWeknMLFnEBXoHgmUfhl/UtNuGMgRM+sAbRsOVU
         nJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794069; x=1751398869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXiP320Rk+IeNYwcDV4nPbIgqWo0YYn3LIURX0sKo4U=;
        b=dGKKzfz/cl9em+mrn3wCUmkMqulAhQ8ZDSyfoIbAU8l/3r6BpYcNdd1L58fWP6offR
         Tx3tDLYmeKOXT4AsxNSSM9FaRYOg7NFI8OYFbg+6PnU1Lh0mQBkOroOJxQZcEY1/Jak+
         BxG6Nzn6dRMlLYbS3hvoiSWF6ku027HOpIyR9ppfeBDdUwl8xKvKn4cg7uFU07pJEL5f
         dxsGwl8tZl7NCPeEa/kRY8KVnGwTVnST0dibJu9QcJGqkHse/7WsgtB6Upw5zbR/iGoJ
         7cBC4c8d8nVTsquzDXQqR9VZMijtzokeRaieUdKl7Qca/MnILXoL61KEpCMpTg041F0Y
         bAxA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3KpydbX+CFoKbBPr3P3pwB/FJQBLBLyhdA/IF1zuxYsImexF+8/S6AfUGadoCWBJSbUgKpCCDEmJHh/hfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1+s3pxUbqueIr0I8R4UXUdf1fCdLbdoxJBGFyr8y/YfbzrDf5
	qx/bKjcSrTw7d54Ixv+MCaKJ2YyDhaw1PJ9pxiISVa90ghIb90Ge7/bWPS72BGIhK+rwZ5dbdjP
	UZXHBHg==
X-Google-Smtp-Source: AGHT+IF4iAyO0/jtdeTd/8bHHz1AfSHJa1kRLTY1ZYhbBi7eks2S0+pU5J68NpHqGCPbGgybwZERsmzdGEo=
X-Received: from pfx28.prod.google.com ([2002:a05:6a00:a45c:b0:747:a9de:9998])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ac6:b0:740:aa33:c6f8
 with SMTP id d2e1a72fcca58-74ad448fdfcmr481317b3a.7.1750794068977; Tue, 24
 Jun 2025 12:41:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:24 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079266935.516926.16732685121513755333.b4-ty@google.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 16 May 2025 16:07:26 -0700, Sean Christopherson wrote:
> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[1/8] irqbypass: Drop pointless and misleading THIS_MODULE get/put
      https://github.com/kvm-x86/linux/commit/fa079a0616ed
[2/8] irqbypass: Drop superfluous might_sleep() annotations
      https://github.com/kvm-x86/linux/commit/07fbc83c0152
[3/8] irqbypass: Take ownership of producer/consumer token tracking
      https://github.com/kvm-x86/linux/commit/2b521d86ee80
[4/8] irqbypass: Explicitly track producer and consumer bindings
      https://github.com/kvm-x86/linux/commit/add57f493e08
[5/8] irqbypass: Use paired consumer/producer to disconnect during unregister
      https://github.com/kvm-x86/linux/commit/5d7dbdce388b
[6/8] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
      https://github.com/kvm-x86/linux/commit/46a4bfd0ae48
[7/8] irqbypass: Use xarray to track producers and consumers
      https://github.com/kvm-x86/linux/commit/8394b32faecd
[8/8] irqbypass: Require producers to pass in Linux IRQ number during registration
      https://github.com/kvm-x86/linux/commit/23b54381cee2

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
