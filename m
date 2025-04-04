Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839521D3E9
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801309; cv=none; b=MsQ84hq+ha0XzYVYbKVQTHrkj4jSzCx7olNMbE7JCmjBMuUKesKF2IBmWZ949wYQBalwN/qUzTr/qa+6UvQ92SpTTMM4CCi3Wz50FLnLAhM8M2mA7VdMbAJIcAUnyC2pZ9H9xLlte6AGEU0A41kd+pKrTKo7qo4nU9572AHiw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801309; c=relaxed/simple;
	bh=lt3v4NByeuFhsRflhATM2AU2H0rLtGPyZ6uc0g0P4aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mmsv3KOQ6JeADRNtorSMkK2ZKBOh0XdYjl7rGippmjm8fDxq1FLElLAhlbj00XotPQ90GqpL8CPtG3nuBcNSj6O7adtKQTEjEBJnUIPeklb3W59syDoSFVpMkRVVa+a+3VsViGmataQLeUY99JxjIFRlcs8VHA+FcwPUXloOjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB9FUKED; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB9FUKED"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso3968600a91.0
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801307; x=1744406107; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj98VhLI5wUP0/dBD7V9/B8uk5MsLM5FlS2oO+5uLWg=;
        b=KB9FUKEDfYU2fGOTCk/Ir1iKTviLFJQtyj8htO0tdU+p9TiNnDQ7zBkBPGrjv+3/VX
         Y7wFk08Vk8gVAERwSn99lUPga0110qptR0948K8UMecuMd1INq++QaSKCDDj3MLKkuOO
         xLpoBEDRjtavf2GRsP83fTJ1GA4mZzp1H9ghKak9KgkZlEufabtSuvRsNI3Vb2xa3PAr
         Moo3HxP3/qxwJqMS7e4uPcY5/ybs0EQQLWXNHowyBrFy+MgrPRtTs04nvyBhwJ668BJ1
         3Rw/tAuhUEzDJJC1ZQygFGOsBB1eO5Mda+rO/mm5Gse814rePexOrQWkh1fo4QlOIKkL
         3VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801307; x=1744406107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uj98VhLI5wUP0/dBD7V9/B8uk5MsLM5FlS2oO+5uLWg=;
        b=ikeeqszA7m3erifYWx+50RscZwYuPAh7zjlJyQVXCyn4Y52BU8kG7Ay0orgIFyHd7M
         cnLn0dNrjGOp+SDvX3+CiGUzsZIoGaO8mrlci9Ocwu8SrN2j4s4WIOx9FUdQjQb1kPEv
         e7TnAyJrCAviF0YfG4eEru91vhPJumMaO9PIyhYNn1z5s9MODdgUVsV0XrxsYMHg8Q/2
         yR7wAiXSOCaPNdmobDlpgRpTsh/QypQalT5+IiGZOqnaGjKmL9b6d2fL4RipJjZjKO9X
         pOc16f4C6Nq46/h5US6jmXyQtfvUM3e6si0IqXdcHMHb62p/Ndrz45KbG71/AzOwAi0P
         HeLA==
X-Forwarded-Encrypted: i=1; AJvYcCUiAuHS/9rTDeY4ERJw/CCE3KVbNsQcMx6nkbSygNgzKDas88vNdhBkGKa23zhdS09wDx8N1VwyAJN6PMnBRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1jjwUMlMZMknK6hj7nWZC/dWmPjzltb2ln0Po1Y07RL/3ZkD5
	wJQ6PqQS6UUJeMPcOHe6eaSNxK3vi1ZWj9qTcnXLFp0L3JC0wrL1JDPvAUuSjqJGAnK310toZOH
	pwQ==
X-Google-Smtp-Source: AGHT+IFMRINuT3JO84ktvwx/JXf2G4VgNPaO3sJJsL1cqLAvtapdb4dYJmi4mlrlNRrGxzPd+4aTdmn2mM0=
X-Received: from pjboe14.prod.google.com ([2002:a17:90b:394e:b0:2fc:e37d:85dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d47:b0:2f6:f32e:90ac
 with SMTP id 98e67ed59e1d1-306a6154f18mr5792179a91.11.1743801307592; Fri, 04
 Apr 2025 14:15:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:44 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-3-seanjc@google.com>
Subject: [PATCH 2/7] irqbypass: Drop superfluous might_sleep() annotations
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Drop superfluous might_sleep() annotations from irqbypass, mutex_lock()
provides all of the necessary tracking.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 080c706f3b01..28a4d933569a 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -90,8 +90,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -136,8 +134,6 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -176,8 +172,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 	    !consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -222,8 +216,6 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-- 
2.49.0.504.g3bcea36a83-goog

