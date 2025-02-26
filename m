Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDC2755F1
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600826; cv=none; b=Uvved+e9zHKIlVvG7fPNIT6vvfmnbBpinISd5l7wTbgl8S0E+DuOdt6muLshuinMzgvfreyVBejkE++1YRLX0ZDDOWCgZTcIAZv8qQ1bsztoIyEtq5o3YWtG5f8pVT41apV2zzSW0b7zGmSEd4htRKBy6XTnMCl8G8/HTcBUx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600826; c=relaxed/simple;
	bh=orgv02xasNMcG3m7QuMiIZlWbVZJKDsjvHGKqPb80dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsTc9L90vH7DhGR46yunNfhrncGTRPtDsq9SJtJrA5RawrfhStJsyoS5kVqkD21iWY8BEb+YceYL2reZg+fJT+Q5A2zSrl+/Smx4CQd3VlIZmbtV9FbPTEkW+4w/CjEOogxbMjbO4bDZRp5h4kVt4Q7uw0dxewlgUFsjqyPMasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ITR/S/1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ITR/S/1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe98fad333so461699a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740600824; x=1741205624; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxehUgTHz1zTiTKWIUwPafHBvSaHS8puDzXDyL6MEmY=;
        b=3ITR/S/1ANB9QxCYfYJmdc59ZTMpnLLYWBTnnJUUCoSbVMUSTpGyOQ5h6O0J6Ddc1F
         ObwllUoRa3mimml04KDXmFdh+wmKRiLe7LCvLzHOU7NbNno1NN+ZjngtJHK/UPV2i7UY
         Kr1gdN3jq0/g+0xxawzZYolxtFogsXsJRZOqDb0J4s1/r9JBTFs5MQSp+MXBNMzTi38J
         RDOjfxkWy/GVqLeMEPdPrY12PU18nF58kQPzikLUfbbS8Ct34TuIgNEBKQDUIPrwpKVm
         Cx/FxTKGnjxwk0Wnf1VRVLqvRngUSTZAh0gfJII6w9VHr0q07i5IZeHHhTYIV2q6apcV
         WDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600824; x=1741205624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxehUgTHz1zTiTKWIUwPafHBvSaHS8puDzXDyL6MEmY=;
        b=LLP8wJ/icIrrgORPUCf3Y+ObUIMMeYaWNO1CY/cG4cInmcvrbaJHFAuu7d01ial9S0
         CLzGxiQsqfjgPCftpJSKRIKpxS8TkvCK0ocpNItGxDktOTcqM8hL04um21EL1kOIpB/p
         fD2YMgFLJzFrHzA/Ewnseuv60CNckjde15PQms7wbPTM8T4PBxyxmJedFEXHhNm9qxFo
         gyniDFw76N8gbLzOoFFes7NRQpl7uAHGzLM5uPRK6Dpg8RkYl8YIRR9slqCfi/UcRtbd
         ymPIHdrqRHwbQgX4UP+RVbiqgL10PJkPpJourW7Of+zbNRfvrbpHleGN59DtQsjs6baE
         FEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVBlv9Qmw/VjRpp2zpU42ivdiTXEVsvpqgU+aIAuBUDeNSpuAFeu/DdN5bttzzRaZadClojAPKRGnMUZ6kBrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPr8DFfiBk7zayFVHUBejEutk+UV55D2Zf+1B+xiPHsQVUp/qN
	dfTwbjmusNm9epYRx2X/29emTbFi6V2Qfrh266vUg8DhnZMN+bFGKQRtSfGZtOIZZ8dNLeETSr/
	Stw==
X-Google-Smtp-Source: AGHT+IHicoYqkjL9RRgNen8MoIjG/DrdsSrEzzLYBuvIBt9STHGlwGCLvcuwxojtGCil5LIWk47Jve4NE/4=
X-Received: from pjc5.prod.google.com ([2002:a17:90b:2f45:b0:2ee:4b69:50e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcf:b0:2f8:34df:5652
 with SMTP id 98e67ed59e1d1-2fce78beb41mr32112608a91.21.1740600824271; Wed, 26
 Feb 2025 12:13:44 -0800 (PST)
Date: Wed, 26 Feb 2025 12:13:42 -0800
In-Reply-To: <20250226024304.1807955-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250226024304.1807955-1-kbusch@meta.com>
Message-ID: <Z7919lMgDtbcl1CX@google.com>
Subject: Re: [RFC 2/2] kvm: retry nx_huge_page_recovery_thread creation
From: Sean Christopherson <seanjc@google.com>
To: Keith Busch <kbusch@meta.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 25, 2025, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A VMM may send a signal to its threads while they've entered KVM_RUN. If
> that thread happens to be trying to make the huge page recovery vhost
> task, then it fails with -ERESTARTNOINTR. We need to retry if that
> happens, so we can't use call_once anymore. Replace it with a simple
> mutex and return the appropriate error instead of defaulting to ENOMEM.
> 
> One downside is that everyone will retry if it fails, which can cause
> some additional pressure on low memory situations. Another downside is
> we're taking a mutex on every KVM run, even if we were previously
> successful in starting the vhost task, but that's really not such a
> common operation that needs to be optimized to avoid this lock.

Yes, it is.  NAK to taking a VM-wide mutex on KVM_RUN.

I much prefer my (misguided in the original context[*]) approach of marking the
call_once() COMPLETED if and only if it succeeds.

diff --git a/include/linux/call_once.h b/include/linux/call_once.h
index 6261aa0b3fb0..9d47ed50139b 100644
--- a/include/linux/call_once.h
+++ b/include/linux/call_once.h
@@ -26,20 +26,28 @@ do {									\
 	__once_init((once), #once, &__key);				\
 } while (0)
 
-static inline void call_once(struct once *once, void (*cb)(struct once *))
+static inline int call_once(struct once *once, int (*cb)(struct once *))
 {
+        int r;
+
         /* Pairs with atomic_set_release() below.  */
         if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
-                return;
+                return 0;
 
         guard(mutex)(&once->lock);
         WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
         if (atomic_read(&once->state) != ONCE_NOT_STARTED)
-                return;
+                return -EINVAL;
 
         atomic_set(&once->state, ONCE_RUNNING);
-        cb(once);
+        r = cb(once);
+        if (r) {
+                atomic_set(&once->state, ONCE_NOT_STARTED);
+                return r;
+        }
+
         atomic_set_release(&once->state, ONCE_COMPLETED);
+        return 0;
 }
 
 #endif /* _LINUX_CALL_ONCE_H */

[*] https://lore.kernel.org/all/Z5e4w7IlEEk2cpH-@google.com
