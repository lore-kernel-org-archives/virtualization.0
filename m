Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F462F066D
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323679; cv=none; b=RXeem2NoPFrmvYzFBo9ugu3dFhcVTv2FWAJzmDk8WwCblyxzcsXQAHvnCZhATBDJCVfQPnuypqKKHNWOFG0lWYSnZGaEu+C5N93Ex6BuIE3d/rResvbMd+srBqfJr+PWyWJZe2iRKqPO2wDQT+eqeDkTfk7vGF8CIiQx3MrXPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323679; c=relaxed/simple;
	bh=i9u6IqjMGsxbK/CQQwKcRmXhfoxNpA8OWg2LJqEDcRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zyqlf478usGg9bnFzwFH44uwcRPELFwz0zHEtrWi+NIVufLoTay2cQAnGTS3U8OlpFpMR3hqu5xL8i2kQGZdJ+DHh6MoIm0uoKZJseWP3Mi9vnsycf7L1riv/C4wBF6AepGAv7acTnmmC5qZhRfAhQz2PdctmgV0oMpmsb7AnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWJehUvD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWJehUvD"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515e8e4cbso316627a91.2
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323676; x=1756928476; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V+WPD9e8xwvSU5bLer99fOwZ4SmYjxSoVKZ9uP/XO4g=;
        b=QWJehUvDaLp2cwWIoPy3YdEXCGmia6Jhq8zj7IKhNf7BArNs2PuXjSx00jbFqpYWrq
         iv0+240AFnCNGMJ9CHbwlYjF1U24B2jW0eA23x/dODcJeAgiBR/844SNzRZydOmbABPS
         wkVaJxktt8fiefeBrQ4H9FYT09NnCUGFZ72FAD3Mu76uyKSBOutZaBx/SzjaSDejYcD9
         oH9tltuIUaGnhYuK/01otalsaMghlMq4BQeaMppIW7sfnQBOmxParZFI45sCkfATkpeP
         lx/YKQPC6df7W7pFUsMWxuUOeJtyanlDn33Ljtj3MVXtEXMzQDVPI7HEj/ZcVND3IGgx
         w7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323676; x=1756928476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+WPD9e8xwvSU5bLer99fOwZ4SmYjxSoVKZ9uP/XO4g=;
        b=jRpCmvtOsffr9eZsKRZs8zKd9cYBtCuQWe1nQ/rO6L0MGka1rer+FgOvaGfB90IuQU
         lRHCJ6czYaROBmZIjddSalcRJT/slhvsJ4eLzyYrRTYuDzwxFu7QFQUtsNOEKrsO6lkw
         urQSA0VHnTgtSyb1Wsx/tt3BeGzjQz4BVUlF58GtV154Mxz/Jmhq9Q+Wgq23s8r2Gigl
         OBaxzygE1znrYt9wW1OkWZ8B6XQz9iJS0/1xq58Nzp5AmdmMbR7HHvQbOz+u0fhyKDOe
         8FC53i5tBgb8r2FDWNeVD6gx9WPWfg2PgYlsbzXvwQctg4bX9YaSZPbNIW/gS1UpfUBI
         PpbA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Q/wKVQnmjjsD2cqTXjhv9JCZfpOsd/R886gAZujebe+EWP+Sn8Afn5+U465yKc0l27SeLaQ8Z5rTxh0dZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8dvKXQ5GQGynJrcUx7WNrT8DlMJclJdyq2XXI4ZQt7qCM9nnQ
	i7Ydfk5FrDGGSes6/R5UPk7EZqJrXToBcaP7AOUD6nrQk6pjKvO8VdUHCYWPrb/1cVhgIcVJebF
	guRxt9w==
X-Google-Smtp-Source: AGHT+IFJRADQETHcJ/b21m/KxVbEwd3QLJppQZSM8otNcmYzujReVgpmb4RU+eVLd68HDkmWMr55KCbsQHs=
X-Received: from pjl5.prod.google.com ([2002:a17:90b:2f85:b0:327:5464:5d5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c0b:b0:327:a295:320c
 with SMTP id 98e67ed59e1d1-327a2953816mr848186a91.3.1756323675820; Wed, 27
 Aug 2025 12:41:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:05 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-2-seanjc@google.com>
Subject: [PATCH v2 1/3] vhost_task: Don't wake KVM x86's recovery thread if
 vhost task was killed
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Make the "default" API for waking a vhost task safe against the underlying
task exiting due to a fatal signal.  This fixes a bug in KVM x86 where KVM
attempts to wake an NX hugepage recovery task that exiting before being
explicitly stopped, resulting in a use-after-free and thus crashes, hangs,
and other badness.

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

Handle VHOST_TASK_FLAGS_KILLED in vhost_task_wake() instead of forcing KVM
to solve the problem, as KVM would literally just add an equivalent flag,
along with a new lock to protect said flag.  In general, forcing simple
usage of vhost task to care about signals _and_ take non-trivial action to
do the right thing isn't developer friendly, and is likely to lead to
similar bugs in the future.

Keep the existing behavior for vhost (by calling __vhost_task_wake()
instead of vhost_task_wake()), as vhost_worker_killed() takes extra care
to stop and flush all workers, i.e. doesn't need the extra protection, and
because  vhost_vq_work_queue() calls

  vhost_worker_queue()
  |
  -> worker->ops->wakeup(worker)
     |
     -> vhost_task_wakeup()
        |
        -> vhost_task_wake()

while holding RCU and so can't sleep, i.e. can't take exit_mutex.

        rcu_read_lock();
        worker = rcu_dereference(vq->worker);
        if (worker) {
                queued = true;
                vhost_worker_queue(worker, work);
        }
        rcu_read_unlock();

Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/vhost/vhost.c            |  2 +-
 include/linux/sched/vhost_task.h |  1 +
 kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8570fdf2e14a..dafce01a9c0d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -744,7 +744,7 @@ static void vhost_workers_free(struct vhost_dev *dev)
 
 static void vhost_task_wakeup(struct vhost_worker *worker)
 {
-	return vhost_task_wake(worker->vtsk);
+	return __vhost_task_wake(worker->vtsk);
 }
 
 static void vhost_kthread_wakeup(struct vhost_worker *worker)
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 25446c5d3508..1a9c2ac65c9a 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -10,5 +10,6 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
 void vhost_task_wake(struct vhost_task *vtsk);
+void __vhost_task_wake(struct vhost_task *vtsk);
 
 #endif /* _LINUX_SCHED_VHOST_TASK_H */
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index bc738fa90c1d..bd213d0b6da3 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -67,16 +67,52 @@ static int vhost_task_fn(void *data)
 	do_exit(0);
 }
 
-/**
- * vhost_task_wake - wakeup the vhost_task
- * @vtsk: vhost_task to wake
- *
- * wake up the vhost_task worker thread
- */
-void vhost_task_wake(struct vhost_task *vtsk)
+static void vhost_task_wake_up_process(struct vhost_task *vtsk)
 {
 	wake_up_process(vtsk->task);
 }
+
+/**
+ * __vhost_task_wake - wakeup the vhost_task
+ * @vtsk: vhost_task to wake
+ *
+ * Wake up the vhost_task worker thread.  The caller is responsible for ensuring
+ * that the task hasn't exited.
+ */
+void __vhost_task_wake(struct vhost_task *vtsk)
+{
+	/*
+	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
+	 * a race can only result in false negatives and this is just a sanity
+	 * check, i.e. if KILLED is set, the caller is buggy no matter what.
+	 */
+	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
+		return;
+
+	vhost_task_wake_up_process(vtsk);
+}
+EXPORT_SYMBOL_GPL(__vhost_task_wake);
+
+/**
+ * vhost_task_wake - wakeup the vhost_task if it hasn't been killed
+ * @vtsk: vhost_task to wake
+ *
+ * Wake up the vhost_task worker thread if the task hasn't exited, e.g. due to
+ * a signal.
+ */
+void vhost_task_wake(struct vhost_task *vtsk)
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
+	vhost_task_wake_up_process(vtsk);
+}
 EXPORT_SYMBOL_GPL(vhost_task_wake);
 
 /**
@@ -91,7 +127,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
 	mutex_lock(&vtsk->exit_mutex);
 	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-		vhost_task_wake(vtsk);
+		vhost_task_wake_up_process(vtsk);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
 
-- 
2.51.0.268.g9569e192d0-goog

