Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706503;
	b=HuviU866mR7NoPu6k3UMeLPgHxo0ApDs1IqS1rgBPHwEm79sHzUrJm3enVkp9DjEKmdE
	 /R3zk2TJ3l2EGV45AzJsNUTrTF636f5FYpT56XobAN9K65tq8FuKGbkkD62oreCmEy+BS
	 HR+v/MSKusGC4W9JffEj+PXFw4oFXd7fjyfrBphroomau9t14+x/ghbBuqXOJEQqkea1I
	 fDPGvlv8xx1XE1Awz/oGF22TDYqFtp8obs1FcVEx8FdJhKKzN3CAgPHYKT7uYtRqdPz7C
	 LRaF+pwrNUJQ0LA9nTJK0u1jaiv6SxlxPeSX0T7ylNza9/t6p0b/t5iYpTj2H5hIfaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706503;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dYjrImbKjvTgduATVWv6BpAbZVCe/ugP8SgqQZOZVmk=;
	b=k6Hfywfr+r8+S3FevHPYcXVS6lg+fra+aiBq90TYBRLv+sWHNaWApsT20SN9KJw/WRaA
	 RLVvFOvu+eKXKwHm4jbDlPGJ029DpMDp2rA4o4Ppp+gJsECFfn12Wl731c4pTY6h8UKFj
	 xyn8ANOxMiMElWrStgMuT77dd7iSUgc6ueS8hAUL86Jz2s1cFhlJcind0x2/nReBq0ZCY
	 9DievB7NSh2lhkOPvdprBtZd+YKjK0r6gF2NBtRTserJgMz8Dwrleaq0hkSjcBWl2e74h
	 UOjexeHqPJPDf0Y8BK6eU1gKilEzYlopyCu45OzYfoyD2lXc/Brkxze/wDFXVgiaN6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="L0/vJzZ4";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=pZLy0L9d;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D29606A334
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D29606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=L0/vJzZ4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=pZLy0L9d
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793706468; bh=dYjrImbKjvTgduATVWv6BpA
	bZVCe/ugP8SgqQZOZVmk=; b=L0/vJzZ4PDtJUHg/9NqgCyT0SCD06oYuI6ze0WnUX2pIj/7J4F
	ZbWF/ZVJW1netL6/+CyF7HHGjNbR10UKgZxVd57fwVGpyfBaeUibpZiUUZvUYglKsZAqD7/Ovu7
	AOyLeaPlb6rm0glrzY/ROrF5LqKP58CRb/BnKyD/IlBtlJARmOmtDDkQVi5tQkRI/In+McyHa/o
	05zYhdfjwzXRs0IrtfIgfoYAGfA2Gq0mCOxmmwpIeNZTIZzz1GQAgAMgZgMfjGomNWeJ4krK6qr
	oLVLZC1JK7b6CxJi4fx9S8JUfNGoD8Usn9LPYHaaQNirxNqxU+QnRJh3AMHzNP6IuPA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793706468; bh=dYjrImbKjvTgduATVWv6BpA
	bZVCe/ugP8SgqQZOZVmk=; b=pZLy0L9dPusggIsjur5QpHR6mAHsN/+75f0GGHYOixwM7qv5W1
	9xBFzkcLjYgY7EZNH0amXuLEKQMJf+DPKrBg==;
Date: Tue, 03 Nov 2026 11:47:50 +0000
From: Bradley Morgan <brads@mainlining.org>
To: elb12345@hotmail.co.uk
CC: eperezma@redhat.com, jasowangio@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 peterz@infradead.org, shakeel.butt@linux.dev, stable@vger.kernel.org,
 virtualization@lists.linux.dev, vschneid@redhat.com, ziqianlu@bytedance.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_vhost=3A_Run_TIF=5FNOTIF?=
 =?US-ASCII?Q?Y=5FRESUME_work_in_the_vhost=5Ftask_loop?=
In-Reply-To: <AS8P251MB0001F1EACBED6E7A2AFA8A96C8692@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Message-ID: <8DACE49B-4588-4419-BB47-4C35F7600AE2@mainlining.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 3 November 2026 10:54:40 GMT, Aamir Ahmed <elb12345@hotmail.co.uk>
wrote:
>Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
>model"), a throttled task is only dequeued when TWA_RESUME task_work
>runs on its way back to user mode.
>
>vhost workers never return to user mode, and vhost_task_fn() only runs
>task_work via get_signal() when a signal is pending. A busy vhost worker
>therefore ignores its cgroup's cpu.max, while its runtime is still
>charged to the group, throttling the group's other tasks (typically the
>VM's vCPUs) harder.
>
>This also fixes memory.high and block cgroup throttling for vhost
>workers, which are handled in resume_user_mode_work() as well.
>
>Run pending notify-resume work at the top of the worker loop, as io-wq
>does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
>generic xfer to guest work function") fixed the same problem for KVM.
>
>Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
>Cc: stable@vger.kernel.org # 6.18+
>Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>Tested-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Assisted-by: LLM
>Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
>---
>v2:
>- Also describe the memory.high and block cgroup throttling fixes
>  (Shakeel)
>- Add Shakeel's Reviewed-by and Tested-by
>- Update the code comment to match
>- v1: https://lore.kernel.org/AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
>
>Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
>a busy worker drops from 100% to 19% of a CPU. Reproducer available on
>request.
>
> kernel/vhost_task.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>index 3717885a599..f63ac005214 100644
>--- a/kernel/vhost_task.c
>+++ b/kernel/vhost_task.c
>@@ -6,6 +6,7 @@
> #include <linux/completion.h>
> #include <linux/sched/task.h>
> #include <linux/sched/vhost_task.h>
>+#include <linux/resume_user_mode.h>
> #include <linux/sched/signal.h>
> 
> enum vhost_task_flags {
>@@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
> 	for (;;) {
> 		bool did_work;
> 
>+		/*
>+		 * We never return to user mode, so TWA_RESUME task_work and
>+		 * memory.high/blkcg throttling would otherwise never run. Run
>+		 * them here, where no locks are held, like io-wq workers do.
>+		 */
>+		if (test_thread_flag(TIF_NOTIFY_RESUME))
>+			resume_user_mode_work(NULL);
>+
> 		if (signal_pending(current)) {
> 			struct ksignal ksig;
> 
>
>base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>


--- Thanks!
