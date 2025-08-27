Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BC2F0C59
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323679; cv=none; b=XZPkktvp0QdU/Qa1tNb6WzgN6hwWTT+Z8TT9hQnnoYs+reMSMW//leRDbqyK/cbMLXfxTyT5+4aoqr9TxdVAlITfJwQcViJX/RZfMQ2n4TnC25sEOqQ4WLXJtpEfMqKIeWxnCAG6WYjuMpSQjAgGUHnXpN/+JarvBakh7k824KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323679; c=relaxed/simple;
	bh=lOFYn5tzMu+BIyj/3iv2zb29eZrNyF3mgyqQKezrkec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hkKmWeFaR8xHWBGdxwWVGjfdP0WborWF9KV1OhuP+KJXmaPRo5Umj/bcXRGs+kE4YT8MbJLpvLdnCmOjTTis1n9bv6NXPil1mZCDFZK6HEF3fXn+coTPzEkGzfOhcnSKNGwVqq09kYYKhQsvOm3zxwkM/gK2x5RE7oHXNK9H+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsxLuvvX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsxLuvvX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327594fd627so185244a91.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323677; x=1756928477; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=BsxLuvvXC3zhqs18hO9Q/knmqrbBvGVWbAqvLYkw7LfANuD7p7mG6CCW8IiKfsWw9C
         3X8fSA1DFczvcEVifeV5sEaIKBgxBcSrpFN4JOiwneRAuDDeuMmr+vkKxwRo+IJdL3th
         uD+6Zed7Dc/VhBmh2Gw9gmQ6tJ/8fwmX+s9r8MYufDSVFa1WsVCSmZP4CjiHWtKQmflJ
         fovSCMK5VejF0sb3Xg3LjfShBv7HkyH14Zj4+PiJxyq4dlu0cUNkbamk41xXL83zYdM8
         6KaOAjvPOTYZsaICMBvJ7Vkljjc2L2iUgp5N+ydn/ugv6TRPocG3FLFv/65ddjADMtWw
         76Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323677; x=1756928477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=ps4tKL1TnXD/Gnuvkoknx/23DgyfxoQt11VwZzziSizq6foFWXYIfpmvtpQK5+bCpV
         lVC8ffKEP5Jsmf30XtY6nRnXTp9vQQNOIhqbObpe2oFChIFAEf/7QuHP87l5yc2bUFxC
         TzdzUx18mH/GLoBok/9WqPY+fdFxDFopTtDN+wAxowl/bhfPFU3VsZvGIj/IJjnjyDBz
         CdngI2BBdpF5dsiFIcgqBmXm6p3SiATKtVt1woIqp+/zzUNN0aa55lXF2ovYXwbLScjS
         QC5dmVvB5rn93WnM9p1lDtJOWOBwiVGrSBhV0fbXdA9R8VsEKPAVeY9Ite/dHl+D7O04
         otTA==
X-Forwarded-Encrypted: i=1; AJvYcCXJx+x8tYxiFGPiyNcpgR5vcGn2Go5wcHKQ3U/p3BjNU+EJ3K3Iq2hNQLMCId0/GMEsHbL+0aBr753GhpxJVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDQCHp01wnVkq+bxKmgAjElLke8xD9yWGY/WrCXnE/acAhdbg3
	jfEE1wDTqBJITREo4RrgWG1kKNMlOM/EslaUMyb5/kihAYSvEb0DymUZCQFmFlT54R0WC2TVxmE
	gK4e8Yw==
X-Google-Smtp-Source: AGHT+IFkp3cSkHK/LCzu7rsgKn502PeqGnc81s3u1mjxkvPKl0aSkQfYxtfmuXztKttrbNAZ69OCb7JCKaU=
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4f:b0:324:eb2d:7537
 with SMTP id 98e67ed59e1d1-32515ea1b2dmr27081009a91.20.1756323677599; Wed, 27
 Aug 2025 12:41:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:06 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-3-seanjc@google.com>
Subject: [PATCH v2 2/3] vhost_task: Allow caller to omit handle_sigkill() callback
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that vhost_task provides an API to safely wake a task without relying
on the caller to react to signals, make handle_sigkill() optional and
WARN if the "unsafe" __vhost_task_wake() is used without hooking sigkill.
Requiring the user to react to sigkill adds no meaningful value, e.g. it
didn't help KVM do the right thing with respect to signals, and adding a
sanity check in __vhost_task_wake() gives developers a hint as to what
needs to be done in response to sigkill.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/vhost_task.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index bd213d0b6da3..01bf7b0e2c5b 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -59,7 +59,8 @@ static int vhost_task_fn(void *data)
 	 */
 	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
-		vtsk->handle_sigkill(vtsk->data);
+		if (vtsk->handle_sigkill)
+			vtsk->handle_sigkill(vtsk->data);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
 	complete(&vtsk->exited);
@@ -81,6 +82,13 @@ static void vhost_task_wake_up_process(struct vhost_task *vtsk)
  */
 void __vhost_task_wake(struct vhost_task *vtsk)
 {
+	/*
+	 * Waking the task without taking exit_mutex is safe if and only if the
+	 * implementation hooks sigkill, as that's the only way the caller can
+	 * know if the task has exited prematurely due to a signal.
+	 */
+	WARN_ON_ONCE(!vtsk->handle_sigkill);
+
 	/*
 	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
 	 * a race can only result in false negatives and this is just a sanity
-- 
2.51.0.268.g9569e192d0-goog

