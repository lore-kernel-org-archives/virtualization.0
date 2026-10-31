Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470243;
	b=y79OzEbijfbh3MQOZehSwtw8DypBN7lcb+AmOV6cbYPaw+8nimKWOFFLwE8i9aclCBuL
	 rV83WvWV4MbK/mmPuVMjmfJLn5yFg5iQ6MMfvWER+RzExfyy/SBWD1q1gBcqZMnRtUBkV
	 HydlRZWWFLEmV2k2dQ4jkV/SEnjkJHvwOBvKQzWOTJp6VuoR05fz2fhZo9AmBLWvEMGFT
	 u/uJn4+Kx/9yZiuUqr5Bjx0UTIiIM7arT/KA962FD+L3nGvIye75VM6G8JnMv7LTFp8yG
	 iRYqf5+s6SuUSng32SgTIMBv6eR4pUiiVeOoVokFDF85AcG/B1x1mUwHrhVFJwdmUdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470243;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gasBqSAnV3vmniUcbI9YXZHfc6XeNj1p84CcMezMQsQ=;
	b=a5eaOiu5j+erIXYEIuyLUa9vM1vXlzWsnum0cdHUPHXvUSerZtL3MwiAVpyqhy6i2Wln
	 0+bZG5Mwf9n+rHQCmRZ71DldC0SMRcwuBXfaU9DUUkvKJdov6qXcz1MqKGRvatovcuJxG
	 KJqi3Tu2OmmoJPKiyzrwdbugu01n1OtSZqxzxVNZ5tyTht11GNdAfR+mE3E8iG/w/zLCd
	 Pvdl3uKRTLigfCL6ZFSeCxZNsLPIInCsBlo1SavTMWe2CYmnSPY6PUrIuh4VSUlHsMpfM
	 70kBw14lTAPln9+HBqUY17Vm1xxchAcG6ANYsq+CmT7buIOfIRk71ImqLD+CPDq5JAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I2ElcM0L;
	arc=none smtp.remote-ip=95.215.58.20
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4462606A31F
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 18:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4462606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I2ElcM0L
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=HAspga3z+Ons/LXwua+up+NOY/bhAKhpJxJzMMgbKTU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793470239; v=1; x=1794075039;
 b=I2ElcM0LLwWgAoH4NlKM8Y3TN7Lvpo6kQu370vl2ybS2DjV0HT/+yBwpf3GND434jBQupE9b
 p74O1fsOybSyUtcj+kUN1cpRHylOPU7FhjgDsnCTpNIEflMb57Gz/Lag2OpS2HXZoE+EhEXAXwv
 B4Vs3AV+smssBLCt0M2XWx2I=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5926407d61842773;
	Sat, 31 Oct 2026 18:10:39 +0000
X-Mizu-Trace-ID: 5926407d61842773
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost_task: do the return-to-userspace work between work items
Date: Sat, 31 Oct 2026 11:10:04 -0700
Message-ID: <20261031181004.4193627-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A vhost task is a user worker: a thread of a user process that runs only
kernel code. It never returns to userspace, so it never runs the work
that is queued for the way back. resume_user_mode_work() does that work
when TIF_NOTIFY_RESUME is set. For a vhost task this means:

- memory.high is handled at the wrong time. When a charge goes over
  memory.high, the task counts the pages, and should reclaim, and sleep
  if needed, on its way back to userspace. A vhost task only reclaims
  when more than a batch of pages has built up and the charge can block.
  Then it reclaims and sleeps in the middle of the charge, maybe while
  it holds a lock. vhost-scsi, for example, can fault in guest memory
  while it holds vq->mutex. If the charges can't block, nothing is done
  at all, and the count keeps growing.

- Block cgroup throttling never runs. blkcg_schedule_throttle() asks for
  it, but only resume_user_mode_work() acts on it.

- Task work queued with TWA_RESUME, like a deferred fput() or a NUMA
  balancing scan, waits until the task gets a signal or exits.

io_uring workers had the same problem, and io_run_task_work() calls
resume_user_mode_work() for them. Do the same in vhost_task_fn(): if
TIF_NOTIFY_RESUME is set, call resume_user_mode_work() at the top of the
loop. That is between work items, no locks are held there, and the task
is running. Passing a NULL regs is fine, io_uring and KVM already do it.

This covers every user of vhost_task_create(): the vhost workers and
KVM's NX huge page recovery thread.

Tested in a VM with a version of tools/virtio/vhost_net_test that puts
each RX buffer on a new page, so the vhost worker faults in, and
charges, 256M while its cgroup has memory.high=64M. Before, all 285
calls to __mem_cgroup_handle_over_high() came from try_charge_memcg(),
inside handle_rx() with vq->mutex held. After, all 589 came from
vhost_task_fn(). memory.peak stayed at 64M, and the run took about the
same time (0.66s before, 0.67s after). A lockdep kernel showed no
warnings.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/vhost_task.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 3717885a5992..f0ab21aa2a1c 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -7,6 +7,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/vhost_task.h>
 #include <linux/sched/signal.h>
+#include <linux/resume_user_mode.h>
 
 enum vhost_task_flags {
 	VHOST_TASK_FLAGS_STOP,
@@ -38,6 +39,14 @@ static int vhost_task_fn(void *data)
 				break;
 		}
 
+		/*
+		 * A vhost task never returns to userspace. Do the work that
+		 * would run on the way back, like memory.high reclaim, here
+		 * between work items, while no locks are held.
+		 */
+		if (test_thread_flag(TIF_NOTIFY_RESUME))
+			resume_user_mode_work(NULL);
+
 		/* mb paired w/ vhost_task_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-- 
2.53.0-Meta

