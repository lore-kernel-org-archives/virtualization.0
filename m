Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500B26AA83
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168821; cv=none; b=OPl8CBslvMT4OXmMpscYpcQsgaxHxiY+A4aLhRJ84nC47+Oog5R/tjvzWEuesDgqT3P26w/J1OYmTg3XC1W7gdGh3fzYSfGoKyfsFNG/mFdzQWGO84pxbz+gl8R1NWM2ABgDfvweB3jDyZK0YDIkzLKAwFRLiarBSymplipYmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168821; c=relaxed/simple;
	bh=GVb0pAXSPXdxX83+/OPqswXLmkkoza3EcxtQURZXTX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ud7vQQ19KbdOkgaDCZE1Z4aEvStXBMFk9rkOSrpDgv8v7MjFzfeILkbgUjr95g6j85RHjavdna9TlFkJt39M4f9njW/Z171IY2Uf/LlSVFnPB3eY09APk7G6bxDbZ5abMJL0EVNAICxn9Vq2GZfgrpPYevnrdFZNRn5m85kLXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwgGSZOe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwgGSZOe"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-770593ba14fso2664490b3a.2
        for <virtualization@lists.linux.dev>; Mon, 25 Aug 2025 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168818; x=1756773618; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5V06R2YwV4P7mb6bnA7O8amlLNlaQTPU7YQZptgAyaw=;
        b=YwgGSZOedNrWkF6tXSP1PybNCGHI/jle7QeH4eH40SjROO7Srm+S+YDe+8RvyXZkin
         owlbk+VDabPCpIY/MSLLpKwit+CGzdxha/JZ+JNlwxWDDPSdCMgXU1HOYLnWZu9/ZcGq
         B/o7HMoWfnJYZcpgxbLVfhoAeqKkusp0dshtl/Tsgl8K77RjaahsfeF8pmYC8pXhJU9G
         RLVXqxF+btzzV5h6XZVsXIhByzdh6dxy7soqeuVwxiAV45IKeEbucaHwJ4E8+6n7oWjk
         S6bEkvZ6wJHyoiFqa0JobrTySKLdUtQktbziatNaygrLZcS3u7C6F5uoD9Blh1jhSUVm
         R6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168818; x=1756773618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V06R2YwV4P7mb6bnA7O8amlLNlaQTPU7YQZptgAyaw=;
        b=tCX2xeQube+kKqesMwnUiK8CGZgKYWpaB7bBYBJDcw8jRrTGc3HisPMa3RG4TbFoiH
         vLdgOt6EWb5vnM/fvIGVAPMP8tY+2bGxMuZPm9omDuNcJ/j9kvzNQYBAtRJWAXCfvL0Z
         03pBzXPqLlh0aE+pzZcVKVI3oxQrUFwKI83RiJUZmmh4N8NSYYYfig1j0lu/cASLND+a
         +nK0+xCFex0xlXddE0NeblAoGyqzrtD1aCh4yrffQ2Rrohrz5hAioLmsHFNWyw71hxCv
         GbMi9lJkzGxxtH/sDVb4vvXw7jcx0V0sNpLZ2l7DErpHU65grmeEkHS9hu7/5bUovvG7
         ym4w==
X-Forwarded-Encrypted: i=1; AJvYcCXGigJQ+WynArCU3Gnaffg8apU4f83t6CoIAgMrwKkaRY+033RAYIO1gCMvDsbnFvoAks52Llf1Ez2euto7bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ6vU98dT137Lixnk/GpUyeMpfPKV+DUP7QLR6ZyPgmGbyyLbM
	KnvhKfS0i1ASN7nYHSCUS1rBEOUF2IAMiqxbA2oMzLJKN4r4//SpP9blPgedvv8YH1VM7ZKmtt8
	th++5Qg==
X-Google-Smtp-Source: AGHT+IGvMwOaGiGqZx7k3m6cvaP4kpjaZdVQ4IKIUIbPn0jyCNEVmHY+8BVB6L/MWU98cgfspsjTfnfKiu8=
X-Received: from pfoo6.prod.google.com ([2002:a05:6a00:1a06:b0:770:5229:752e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3282:b0:235:6e1:7017
 with SMTP id adf61e73a8af0-24340ab113bmr16959785637.4.1756168817903; Mon, 25
 Aug 2025 17:40:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:10 -0700
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-3-seanjc@google.com>
Subject: [PATCH 2/3] vhost_task: Allow caller to omit handle_sigkill() callback
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that vhost_task provides an API to safely wake a task without relying
on the caller to react to signalas, make handle_sigkill() optional and
WARN if the "unsafe" vhost_task_wake() is used without hooking sigkill.
Requiring the user to react to sigkill adds no meaningful value, e.g. it
didn't help KVM do anything useful, and adding a sanity check in
vhost_task_wake() gives developers a hint as to what needs to be done in
response to sigkill.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/vhost_task.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 5aa8ddf88d01..e0ec6bfe61e6 100644
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
@@ -81,6 +82,13 @@ static void __vhost_task_wake(struct vhost_task *vtsk)
  */
 void vhost_task_wake(struct vhost_task *vtsk)
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
2.51.0.261.g7ce5a0a67e-goog

