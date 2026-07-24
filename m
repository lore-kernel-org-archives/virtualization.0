Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AB42DFF5
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896436; cv=none; b=h80R187SU/C7/fX1NlOxiOp2bjjt9uJaG2fH2N8UgvkmSGHO0jCzYZlaCOf6/RM8H91P+gga4125w4EHSaGtJJBtFjueUZFT3EfVDWsqLtK80WMvdJqy2tn1TBlQNUK+6iXiNjnBfouuga2Mhke8JLG1hU23irHUjQ5M24QgXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896436; c=relaxed/simple;
	bh=LDBbmwekKmmXHpQfdg+ZZQfu8q+P0aouaQmGttMVW0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brtB3AjVK3VALOmy4uJqgLu86Zwo3dM9E5RsCiZL+LlM6UJJgVYYhVPiKQ8XIMU2ndKHNdDPqzCOGKSWXyhl235+DQOX854DtsoA6SHxo6cvSi3DjadY9/KZ1YKHQb9Sd42BaJixlbmHKpjpsoFXtmSFx68/LDaRwWSuDW/ag7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=KV1PgOB7; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="KV1PgOB7"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward203d.mail.yandex.net (postfix) with ESMTPS id 50F188551C
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 15:27:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:83a9:0:640:50fd:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 432C8C01A2;
	Fri, 24 Jul 2026 15:26:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp) with ESMTPSA id mQYIjHPfFiE0-7t6nTZPk;
	Fri, 24 Jul 2026 15:26:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1784896016; bh=24sziNSOej9hW9ShsUcU0gGgB5716Fg83pEtrPNeQrs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=KV1PgOB7miJXsIz3Af2ESKl6u4pm5slpGdWysgwCsX+Wg+hoiSWXrbXp7mKearWAC
	 cYYCYeAgWt2LhWXyuVO3GswBgZezXZ1eCuy+mM1EfUls2O/KhjDdJwUs5GyyhXzN17
	 0nQINXebu+tOvqprBwjG4W32Fo2phrZMnY8MvedA=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Novosyolov <m.novosyolov@rosa.ru>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	christian.koenig@amd.com,
	sumit.semwal@linaro.org,
	dreaming.about.electric.sheep@gmail.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	m.novosyolov@rosa.ru,
	a.sudakov@rosa.ru,
	ghadi.rahme@canonical.com,
	timo.lindfors@iki.fi
Subject: [PATCH] drm/qxl: avoid hangs on an unresponsive SPICE host
Date: Fri, 24 Jul 2026 15:26:36 +0300
Message-ID: <20260724122636.213906-1-m.novosyolov@rosa.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symptoms:
  - text/fbcon console (and TTY) of a QEMU VM hangs (does not work)
  - SSH works OK
  - system cannot be rebooted or powered off via systemd

QXL is a paravirtual display device: the guest submits drawing commands
and the host (QEMU's SPICE server) executes them.  Each
submitted batch carries a "release" -- a completion record the host
marks done when the work is finished -- which the guest uses as a
dma_fence.  Before the guest can reuse or evict a piece of video memory
it must wait for the release covering it to be marked done: a to-do
entry that needs its checkbox ticked before the page can be recycled.

The host drains the command ring only while a display client is
attached (someone is watching the screen).  With no client -- the
normal state of an unattended server VM -- the host stops processing,
the checkboxes are never ticked, and the guest's wait never completes.
Heavy console output (fbcon redraw) fills video memory and keeps the
guest waiting on these releases, which surfaces as "[TTM] Buffer
eviction failed" / "failed to allocate VRAM BO"; and during shutdown,
where teardown waits on the same releases with no timeout, as an
uninterruptible hang that leaves systemd and the console callback stuck
in D state and makes the VM impossible to reboot cleanly.

This change makes the guest drive the host forward again while it
waits: periodically notify the host to process and free completed work,
and run the cleanup that ticks the checkboxes -- restoring the
behaviour removed by commit 5a838e5d5825 ("drm/qxl: simplify
qxl_fence_wait").  Two deliberate choices keep the two known upstream
failure modes from coming back:

  - the cleanup is queued asynchronously, never flushed inline (flushing
    here would deadlock -- CVE-2024-36944; details below);
  - the total wait is bounded (30 s by default), so a completely
    unresponsive host can no longer hold the console/modeset locks
    forever; on give-up a ratelimited warning is logged and the caller
    proceeds or retries.

The periodic nudge resolves the eviction failures; the bound resolves
the reboot hang.

Background -- known discussions of this regression:

  * Ubuntu/Launchpad bug and reproducer (test.sh):
      https://bugs.launchpad.net/bugs/2065153
  * Regression report and analysis:
      https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/
  * Debian #1054514 (the report behind the upstream revert):
      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
  * Ubuntu kernel-team reproducer thread:
      https://lists.ubuntu.com/archives/kernel-team/2025-July/161304.html

Commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") reduced the
wait to a single wait_event_timeout() whose condition calls
qxl_io_notify_oom() exactly once, when first tested.  The condition is
never re-evaluated unless release_event fires, and with the host not
draining no such wakeup arrives; releases never complete and the fence
is never signalled.

qxl_queue_garbage_collect() is called with flush=false on purpose:
flush_work() in this context deadlocks against the console owner and the
worker pool -- the CVE-2024-36944 regression -- which is why the upstream
revert of commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") did
not stick and was reapplied as commit 3628e0383dd3 ("Reapply "drm/qxl:
simplify qxl_fence_wait"").  flush=false matches what the IRQ handler
already does and cannot deadlock.

Bounding the wait deliberately relaxes the assumption documented in
dma_fence_wait() (include/linux/dma-fence.h) that a MAX_SCHEDULE_TIMEOUT
wait can never time out: a give-up is reported to the caller as a
timeout (0), so the few MAX_SCHEDULE_TIMEOUT callers reachable from qxl
through TTM (the page-fault idle wait, delayed delete, the OOM ghost
swapout and evict_all) continue with an unsignaled fence.  This is not a
new failure class: it only fires after fence_giveup_ms on a host that is
entirely unresponsive -- on a merely slow host the fence signals long
before the bound, thanks to the periodic nudge -- and the pre-regression
implementation, commit 07ed11afb68d ("Revert "drm/qxl: simplify
qxl_fence_wait""), already returned with an unsignaled fence via its
'goto signaled' path once its spin-count limit was reached.

The reboot/shutdown hang is a lock-contagion effect.  An atomic commit
holds a DRM modeset ww-mutex and blocks on a release fence that never
signals, so every later console update then blocks on that same mutex.
Systemd's own console writes are such an update: they trigger fbcon
panning (drm_fb_helper_pan_display() -> drm_atomic_get_plane_state() ->
drm_modeset_lock()), which takes the ww-mutex non-interruptibly
(TASK_UNINTERRUPTIBLE) and therefore lands in D state.  With pid 1
stuck in D state the VM can neither be shut down nor rebooted, and only
a host-side reset clears it.

Example of this lock:
  INFO: task systemd:1 blocked for more than 245 seconds.
  Not tainted 6.12.47-generic-5rosa2021.1-x86_64 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:systemd
  state:D stack:0 pid:1 tgid:1 ppid:0
  flags:0x00000000
Call Trace:
  <TASK>
  __schedule+0x408/0x1360
  schedule+0x27/0xf0
  schedule_preempt_disabled+0x15/0x30
  __ww_mutex_lock.constprop.0+0x526/0x980
  ? __kmalloc_noprof+0x177/0x420
  drm_modeset_lock+0x37/0xc0
  drm_atomic_get_plane_state+0x7e/0x180
  drm_client_modeset_commit_atomic+0xaa/0x230
  drm_client_modeset_commit_locked+0x5a/0x160
  drm_fb_helper_pan_display+0xfd/0x240

30 seconds seems to be a reasonable default value:
  - it should not be triggered on a slow, but responsive host,
    realistic worst-case release completion on a slow host is < 10 sec
  - it must be less than hung_task_timeout_secs=120s
  - it should be less than DefaultTimeoutStopSec=90s in systemd

Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
Assisted-by: Kimi:K3
Assisted-by: Z.AI:GLM-5.2
Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosa.ru>
---
 drivers/gpu/drm/qxl/qxl_release.c | 59 ++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..75286e6d5ec5 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -21,6 +21,8 @@
  */
 
 #include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/moduleparam.h>
 
 #include <drm/drm_print.h>
 
@@ -56,20 +58,67 @@ static const char *qxl_get_timeline_name(struct dma_fence *fence)
 	return "release";
 }
 
+/*
+ * Upper bound for a single release fence wait when the host does not
+ * respond at all, in milliseconds.  Prevents uninterruptible sleeps
+ * without a bound when a SPICE host stops draining the QXL rings.
+ */
+static unsigned int fence_giveup_ms = 30000;
+module_param(fence_giveup_ms, uint, 0644);
+MODULE_PARM_DESC(fence_giveup_ms,
+		 "upper bound in ms for a qxl release fence wait with unresponsive host (default 30000)");
+
 static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 			   signed long timeout)
 {
 	struct qxl_device *qdev;
 	unsigned long cur, end = jiffies + timeout;
+	unsigned long giveup = jiffies + msecs_to_jiffies(fence_giveup_ms);
+	signed long left = timeout, slice;
 
 	qdev = container_of(fence->extern_lock, struct qxl_device,
 			    release_lock);
 
-	if (!wait_event_timeout(qdev->release_event,
-				(dma_fence_is_signaled(fence) ||
-				 (qxl_io_notify_oom(qdev), 0)),
-				timeout))
-		return 0;
+	/*
+	 * A SPICE host may stop draining the QXL rings, e.g. when no
+	 * display client is attached to the VM.  In that state releases
+	 * complete only if the device is kicked through the OOM notifier
+	 * and garbage collection gets a chance to run, so poke both
+	 * periodically while waiting.
+	 *
+	 * Garbage collection is queued without flushing on purpose:
+	 * flush_work() here can deadlock against the console owner and
+	 * the worker pool (see CVE-2024-36944).
+	 *
+	 * The wait is bounded by fence_giveup_ms even when the caller
+	 * passed an infinite timeout: a completely unresponsive host
+	 * must not hang tasks holding the console lock forever.  The
+	 * bound is reported to the caller as an ordinary timeout,
+	 * letting TTM retry eviction later.
+	 */
+	for (;;) {
+		qxl_io_notify_oom(qdev);
+		qxl_queue_garbage_collect(qdev, false);
+
+		slice = min_t(signed long, left, msecs_to_jiffies(100));
+		if (wait_event_timeout(qdev->release_event,
+				       dma_fence_is_signaled(fence),
+				       slice))
+			break;
+
+		left -= slice;
+		if (left <= 0)
+			return 0;
+
+		if (time_after(jiffies, giveup)) {
+			dev_warn_ratelimited(qdev->ddev.dev,
+					     "fence %llu#%llu not signaled after %u ms, giving up\n",
+					     (unsigned long long)fence->context,
+					     (unsigned long long)fence->seqno,
+					     fence_giveup_ms);
+			return 0;
+		}
+	}
 
 	cur = jiffies;
 	if (time_after(cur, end))
-- 
2.51.0

