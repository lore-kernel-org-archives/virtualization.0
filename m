Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5165259CB2
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168818; cv=none; b=UD3RQCb8uOCOrDhXBfIwe4ZRvG3kTNRGZR33CMh3ov4m9abo2xHgXdq3s4GBWqYAXyWdRqSgk1d0u3zbLBr9IqpBE43J+VByrwtahPKmEfAsoT0XrRnRH4SRwp2w/wmnFHpVU73N4JqjLUhpRlJR3YYeDJwzr7ViEw4/MUQW3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168818; c=relaxed/simple;
	bh=mkdifJuocRaPeE9/s8dJMI63LfJbJ5RNcEoZFWM/YBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zvg1uPHGyZevGlasIbTzYEIJ1IodCxA//UmLorrg9WDresWTqXxZkAgJzo7ZA4ClkAYkbWT0JO3ITUUdGuK5YRuCZc3QT2vmyteKdbRzBwHIW1oNHCm89u7VZZQTKHHrR68UsfuKi4BqKZ/EGht54mTOc/nlsYcVgoTJ8z+YD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pE4hR0Ch; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pE4hR0Ch"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325e31cece1so1278079a91.2
        for <virtualization@lists.linux.dev>; Mon, 25 Aug 2025 17:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168816; x=1756773616; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I6OP+E9wowSd53dNHDSrZPahIGECBB8CqlNw/C87dc0=;
        b=pE4hR0ChsmvPW7RWAbeUH+7+yTSv35UhMo/7HgPhPgVxw541JkdSfdK5ICIhTZuewJ
         egT9yohbJgjV4wbS5PbmxBXNhdAJyKuOi79HqkusTurrMObX8zi2OfqJEFSh9KqBustN
         G7VQi2wBD2JN/sG4zl4AytgQOquYYL9JppG0b8X1ke0WlUzX3MK12w8Cjl4jPzMy5ejY
         BI/7FaqEYQTsO66cwb7JlDRoSwrES9q6G8iOlpzx8dF8FmiNH7tqRwZK/FjEf7ykFCov
         ArzoN19rvdAVxQglQ15uoeoXyiDl3qZpcgtZoWmhXu6cYKfGUVQEi0B9zAMH0rE12UWP
         WweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168816; x=1756773616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6OP+E9wowSd53dNHDSrZPahIGECBB8CqlNw/C87dc0=;
        b=VQ6JHpv1GEe//y2Sl1gcH6tov+Oj7WctuvYGHQMCB3swxGIY7/acnDHArsILNo5M3u
         OWnbqrMl9eV3J0XwGPFNiQS/DR7aqd2u5VTPIcd+vXwifpfc0eQEMCCDuxLOJJWekNMT
         Ta50Wz7fdarnLwwmB3Xip3GznQ4UscTDo883sON25k8O4EwFTxGjF+pSqZJnYkv+d4ED
         vOVf6OuM461CDsb4TVZouH9Fxgh2+mP+cuEcxfz//fP6j8UJbPKE8SxUtbyF3ixAsWZz
         icHqqXqDNYm6tYElERfU/mK9/ucKnj0Gq7/BZR0EFaHpv0ztPKu1+dHJ0bUOowdr4V2J
         J/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVop9669KczDJbNkiZL11pabfXHTtAq0PfgaDl3Bp7j5xbFkFb/f86hEAz+1kmsg1QhvBr4KmdnXChX7dUE1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNpd8JhzYHeSrz+kWpB9ecsmVahyScOLIexCHjSJt5fp7673vE
	Yd70fUDJstQY0LpGpTuItd796lvFGixLZadHq3fXkanQ58GAIXlMkAhJXCYcVJ20uyN6Bng8b6D
	yrDq4RQ==
X-Google-Smtp-Source: AGHT+IHfyEsrfv35hPjuJ4cCkQ67whYQiOrrNcLejtWiTZWgV3y9MtXTxxAf+GtFvnSoCWEA5haSZ544u4g=
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:325:9f85:b74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ccd:b0:312:e731:5a66
 with SMTP id 98e67ed59e1d1-32515ee159bmr16515015a91.3.1756168816120; Mon, 25
 Aug 2025 17:40:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 17:40:09 -0700
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826004012.3835150-2-seanjc@google.com>
Subject: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery thread if
 vhost task was killed
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Add a vhost_task_wake_safe() variant to handle the case where a vhost task
has exited due to a signal, i.e. before being explicitly stopped by the
owner of the task, and use the "safe" API in KVM when waking NX hugepage
recovery tasks.  This fixes a bug where KVM will attempt to wake a task
that has exited, which ultimately results in all manner of badness, e.g.

  Oops: general protection fault, probably for non-canonical address 0xff0e899fa1566052: 0000 [#1] SMP
  CPU: 51 UID: 0 PID: 53807 Comm: tee Tainted: G S         O        6.17.0-smp--38183c31756a-next #826 NONE
  Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
  Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.110.0 09/13/2024
  RIP: 0010:queued_spin_lock_slowpath+0x123/0x250
  Code: ... <48> 89 8c 02 c0 da 47 a2 83 79 08 00 75 08 f3 90 83 79 08 00 74 f8
  RSP: 0018:ffffbf55cffe7cf8 EFLAGS: 00010006
  RAX: ff0e899fff0e8562 RBX: 0000000000d00000 RCX: ffffa39b40aefac0
  RDX: 0000000000000030 RSI: fffffffffffffff8 RDI: ffffa39d0592e68c
  RBP: 0000000000d00000 R08: 00000000ffffff80 R09: 0000000400000000
  R10: ffffa36cce4fe401 R11: 0000000000000800 R12: 0000000000000003
  R13: 0000000000000000 R14: ffffa39d0592e68c R15: ffffa39b9e672000
  FS:  00007f233b2e9740(0000) GS:ffffa39b9e672000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f233b39fda0 CR3: 00000004d031f002 CR4: 00000000007726f0
  PKRU: 55555554
  Call Trace:
   <TASK>
   _raw_spin_lock_irqsave+0x50/0x60
   try_to_wake_up+0x4f/0x5d0
   set_nx_huge_pages+0xe4/0x1c0 [kvm]
   param_attr_store+0x89/0xf0
   module_attr_store+0x1e/0x30
   kernfs_fop_write_iter+0xe4/0x160
   vfs_write+0x2cb/0x420
   ksys_write+0x7f/0xf0
   do_syscall_64+0x6f/0x1f0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f233b4178b3
  R13: 0000000000000002 R14: 00000000226ff3d0 R15: 0000000000000002
   </TASK>

Provide an API in vhost task instead of forcing KVM to solve the problem,
as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
along with a new lock to protect said flag.  In general, forcing simple
usage of vhost task to care about signals _and_ take non-trivial action to
do the right thing isn't developer friendly, and is likely to lead to
similar bugs in the future.

Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c           |  2 +-
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 42 +++++++++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..d11730467fd4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7376,7 +7376,7 @@ static void kvm_wake_nx_recovery_thread(struct kvm *kvm)
 	struct vhost_task *nx_thread = READ_ONCE(kvm->arch.nx_huge_page_recovery_thread);
 
 	if (nx_thread)
-		vhost_task_wake(nx_thread);
+		vhost_task_wake_safe(nx_thread);
 }
 
 static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp)
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 25446c5d3508..5d5c187088f7 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -10,5 +10,6 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
 void vhost_task_wake(struct vhost_task *vtsk);
+void vhost_task_wake_safe(struct vhost_task *vtsk);
 
 #endif /* _LINUX_SCHED_VHOST_TASK_H */
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index bc738fa90c1d..5aa8ddf88d01 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -67,18 +67,54 @@ static int vhost_task_fn(void *data)
 	do_exit(0);
 }
 
+static void __vhost_task_wake(struct vhost_task *vtsk)
+{
+	wake_up_process(vtsk->task);
+}
+
 /**
  * vhost_task_wake - wakeup the vhost_task
  * @vtsk: vhost_task to wake
  *
- * wake up the vhost_task worker thread
+ * Wake up the vhost_task worker thread.  The caller is responsible for ensuring
+ * that the task hasn't exited.
  */
 void vhost_task_wake(struct vhost_task *vtsk)
 {
-	wake_up_process(vtsk->task);
+	/*
+	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
+	 * a race can only result in false negatives and this is just a sanity
+	 * check, i.e. if KILLED is set, the caller is buggy no matter what.
+	 */
+	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
+		return;
+
+	__vhost_task_wake(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_wake);
 
+/**
+ * vhost_task_wake_safe - wakeup the vhost_task if it hasn't been killed
+ * @vtsk: vhost_task to wake
+ *
+ * Wake up the vhost_task worker thread if the task hasn't exited, e.g. due to
+ * a signal.
+ */
+void vhost_task_wake_safe(struct vhost_task *vtsk)
+{
+	guard(mutex)(&vtsk->exit_mutex);
+
+	/* Attempting to wake a task that has been explicitly stopped is a bug. */
+	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))
+		return;
+
+	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
+		return;
+
+	__vhost_task_wake(vtsk);
+}
+EXPORT_SYMBOL_GPL(vhost_task_wake_safe);
+
 /**
  * vhost_task_stop - stop a vhost_task
  * @vtsk: vhost_task to stop
@@ -91,7 +127,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
 	mutex_lock(&vtsk->exit_mutex);
 	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-		vhost_task_wake(vtsk);
+		__vhost_task_wake(vtsk);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
 
-- 
2.51.0.261.g7ce5a0a67e-goog

