Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D9171640
	for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483117; cv=none; b=s0fbRFBKyt6OhgtUGWGTSR4ozPmRg5WC/eSRTkBrHfa49JH7q5gwvU2g7hKIJokxSPjFLRS8035p8XwCNi/loEgrV5Rh0NaLlQPpm7foDPzeVRL6KqSLLmZwUhkEnJ1fwB7MELxBL9+9N4C8RRH/S11TOABTQT3FcNOt18j/bO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483117; c=relaxed/simple;
	bh=Upd0uZ+rILIoqrP7UwNwjenI04CLhFcHiFAA6RSjlpQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aP06kHsHlB0ca8RKcVDu+7mbkReGIYLQ70h/SakUTXWalJCKD2Vj8mkMuOBEKcZDphMFtPYGWxsQlzE6FIRZ5i8LfGU7Z+B3fcCZHKDC+9dq7l6FVjv4tESh3gmhLtCzMF9BZ3ycagTdiqwFx+SwI6k631KO+WLS24uV7ogS5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nK4NacSo; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nK4NacSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714483104; bh=pZTVlx2s1vNyEH6TmvcHFEZALJwqesPQAcM4Ml3108o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nK4NacSoFFcRKNPqEE8SvSQyelml0cjfEETrdGrQT00ZcMB5utQMqXhcjIPNYfK6M
	 MtL0OX6CwcJMrM+NrIj7xpct8ptUYO2cuPX32/eyNvEAbyp5FBJ5U7GwWo/jkhcpZM
	 mLnonbaD/z7f8UEVNeHXarUhw1WxrQHRb+296ryA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 145262F5; Tue, 30 Apr 2024 21:05:05 +0800
X-QQ-mid: xmsmtpt1714482305tgjwejboe
Message-ID: <tencent_4271296B83A6E4413776576946DAB374E305@qq.com>
X-QQ-XMAILINFO: ND42uzdxTIzrMsG1rW4qAKlH+bvUst3osNeAf4kpH86R3LvT/OrDnMAtDwuURB
	 b0s/cURRHUiOF8+oLulDl9Lb23y3KpWSwcTUKretVrG72SNzY0U4YxRTKgyK54PGOT1u6eBOf+aO
	 +7Q8kljhpERzVuWa+Jm63VLgan+FeMxQehR6eT8GzIjVjvd2vSCBkRNkbEwJJf/nL9mEc7Qhh370
	 aXl0iaZVUqbZv9hUqLhANcRhOktwhtmhiexbkWoxaDWZRjNq2keT8IAZCtjVlqgWCeiZAfHjG6Us
	 CaBt+cLifksGk4TKl1S63SfLb/sjWlvH+YaqXIXFAGQnig9wVmNyovv1nHOv9pjRNVfi/7dUrl5b
	 ohu03S7WStP723qCQyDXBT/ZFhe295cDqAxhkmqpCQGGWCJtjiRPlG/cSf1+n0p/sQwIUx0xV2V7
	 8OjxYdv59ZAlic0HlUVO/Hn9FcSTWhywlztVAQx8j5I6z4bctXYuOojbypIoANM0BxHYUZOsYr1I
	 CJmtKhrPsP+wCAhxmwh/NhnEhcN/OE0/6TOI6Q5FjnO4P4zKOcYkvEmA6o6gBBroBBo5JsvDVRVl
	 tTQ6rfmY+3uuCNfjWykJDJ5Xx9YhmUXasDDOBZVkuIp9xLL4hPzWPSDAIt0SXJz6aYkT443lyJoY
	 n6FiCSjRFteG/r+CRDk/+bnKDsK7LICu4THuSfFzrki/bbrr83trgXP3EIlC1lXvV6RK05mXH7is
	 J6BDvn8mc8DZ7H+T3UpAF2kX/L7UtuWH1gLmMaGfW12SK3aNr2PmvT2mE6RE3Ov+oeXTg2+v/HM0
	 lI78MJYa8wlGMPJifAYwwnwfvf+csWqHhwryqaRwx6MEvRbRezgy+5Umo/zT/lQ7MhIikXMsU9Sx
	 QsSsUjDCIQBbz3dqf+ELwVK9lDJxUMikqDtwaRQnn8vqdO0BhGt7m52R3hxRDPyhUv94KKKCMiXo
	 6oxi2RkeI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Cc: jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.christie@oracle.com,
	mst@redhat.com,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: [PATCH next] vhost_task: after freeing vhost_task it should not be accessed in vhost_task_fn
Date: Tue, 30 Apr 2024 21:05:06 +0800
X-OQ-MSGID: <20240430130505.1040283-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
BUG: KASAN: slab-use-after-free in __mutex_unlock_slowpath+0xef/0x750 kernel/locking/mutex.c:921
Read of size 8 at addr ffff888023632880 by task vhost-5104/5105

CPU: 0 PID: 5105 Comm: vhost-5104 Not tainted 6.9.0-rc5-next-20240426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
 __mutex_unlock_slowpath+0xef/0x750 kernel/locking/mutex.c:921
 vhost_task_fn+0x3bc/0x3f0 kernel/vhost_task.c:65
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5104:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2b0 mm/slub.c:4146
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 vhost_task_create+0x149/0x300 kernel/vhost_task.c:134
 vhost_worker_create+0x17b/0x3f0 drivers/vhost/vhost.c:667
 vhost_dev_set_owner+0x563/0x940 drivers/vhost/vhost.c:945
 vhost_dev_ioctl+0xda/0xda0 drivers/vhost/vhost.c:2108
 vhost_vsock_dev_ioctl+0x2bb/0xfa0 drivers/vhost/vsock.c:875
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5104:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4430 [inline]
 kfree+0x149/0x350 mm/slub.c:4551
 vhost_worker_destroy drivers/vhost/vhost.c:629 [inline]
 vhost_workers_free drivers/vhost/vhost.c:648 [inline]
 vhost_dev_cleanup+0x9b0/0xba0 drivers/vhost/vhost.c:1051
 vhost_vsock_dev_release+0x3aa/0x410 drivers/vhost/vsock.c:751
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[Fix]
Delete the member exit_mutex from the struct vhost_task and replace it with a
declared global static mutex.

Fixes: a3df30984f4f ("vhost_task: Handle SIGKILL by flushing work and exiting")
Reported--by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/vhost_task.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 48c289947b99..375356499867 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -20,10 +20,10 @@ struct vhost_task {
 	struct completion exited;
 	unsigned long flags;
 	struct task_struct *task;
-	/* serialize SIGKILL and vhost_task_stop calls */
-	struct mutex exit_mutex;
 };
 
+static DEFINE_MUTEX(exit_mutex); //serialize SIGKILL and vhost_task_stop calls
+
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk = data;
@@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
 			schedule();
 	}
 
-	mutex_lock(&vtsk->exit_mutex);
+	mutex_lock(&exit_mutex);
 	/*
 	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
 	 * When the vhost layer has called vhost_task_stop it's already stopped
@@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
 		vtsk->handle_sigkill(vtsk->data);
 	}
 	complete(&vtsk->exited);
-	mutex_unlock(&vtsk->exit_mutex);
+	mutex_unlock(&exit_mutex);
 
 	do_exit(0);
 }
@@ -88,12 +88,12 @@ EXPORT_SYMBOL_GPL(vhost_task_wake);
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	mutex_lock(&vtsk->exit_mutex);
+	mutex_lock(&exit_mutex);
 	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
 		vhost_task_wake(vtsk);
 	}
-	mutex_unlock(&vtsk->exit_mutex);
+	mutex_unlock(&exit_mutex);
 
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
@@ -135,7 +135,6 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 	if (!vtsk)
 		return NULL;
 	init_completion(&vtsk->exited);
-	mutex_init(&vtsk->exit_mutex);
 	vtsk->data = arg;
 	vtsk->fn = fn;
 	vtsk->handle_sigkill = handle_sigkill;
-- 
2.43.0

