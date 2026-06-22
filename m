Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78209126C03;
	Mon, 22 Jun 2026 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136365; cv=none; b=AvvZuPlqupIxug9pRG8ZDjq8jxuxMK6o3sw4Cpk2Ne/iHlRqvZaAY2XJs2aezxAkGMlfEzB1Nnhy6ukNhryjrnY5GJYt1OIowLflhIggOX2sqjfakhF7XhOnEnwMY6VqGKgPSQHIJ8J9XWZ1DlSJv2H7z23OiwX2z3R4IERM2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136365; c=relaxed/simple;
	bh=mCLQR87u6rkv4md559rK+A5ERKEC4Hr6r9CQfLUPO40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5TEeSJolGnssMPTUdgRHBss4lnULM6/8MskYrp9Hj+8mBXY6o6iY3oW0tYDWtOYOp6JNImcnjpBHWO84gPu7p/uOKF8mj2ZFtxYR26RdbaTzjJZmWaU1z7KaLF5A8x3SV8OsidZV4RaXxxgd9UJZFWlsSWVMbj94rJUDeGkZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org; spf=fail smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=pJzZKq2G; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pJzZKq2G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=YxhIN8yKiqxPbM8Zuy411ydMDRSedAoQ9tX5ne6XTPA=; b=pJzZKq2GjdgM
	/DtNOF17Q6VfmcBukG8JdcpJeHjXLyvnc5zq6RHX7x3uQ+URqINngi7LmHeJcsJ8TL+P1Iy25FgMj
	dTd2ga2SYUOQiY+q9rcAd/aCLsZ9qP5QKbCj01PAbHWpamSlsJ+mKSMpZzhyODjB1aaEbLiYHOfQB
	2lpLQE/p54mFf1o8xZgsGzNXZW5CXqS6AC8jdcyntXWCuyRFH3A1MC+93IF+FQsEt6wB5hm69IZ4u
	8lL3ocLy9WXt6ySmGhD97bjZIyl/xe3dEwAR/GtQfC4EN54DpGfy+kD9Nc7a23hhhtrE5N8+gx2Du
	xDRjdHCrUyea+WZc/fPmhw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <den@openvz.org>)
	id 1wbepI-00FfsX-2t;
	Mon, 22 Jun 2026 15:37:08 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/2] virtio_balloon: quiesce balloon work before device shutdown
Date: Mon, 22 Jun 2026 15:37:15 +0200
Message-ID: <20260622133715.3707707-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622133715.3707707-1-den@openvz.org>
References: <20260622133715.3707707-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") added a generic virtio bus .shutdown handler that
breaks and resets every virtio device during device_shutdown(), i.e. on
reboot and kexec.

virtio_balloon provides no .shutdown of its own, so that generic path
runs while the balloon's asynchronous work is still armed. Once the
device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its
WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
ordinary reboot, for example a kexec based upgrade, into a fatal panic
in the middle of device_shutdown(), so the machine never reaches the
new kernel.

Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
inflate/deflate and OOM paths do not warn, they call
wait_event(vb->acked, ...) and would instead block forever on a broken
queue that can no longer complete. The device has to be quiesced, not
just kept quiet.

Add a .shutdown handler that quiesces the balloon via the shared
virtballoon_quiesce() helper while the device is still alive, and only
then breaks and resets it. The break and reset are repeated here rather
than reused from virtio_dev_shutdown(): drv->shutdown replaces the
generic handler rather than augmenting it, so that drivers such as
virtio-gpu can opt out of the reset. Unlike virtballoon_remove() the
balloon workqueue is not destroyed, as shutdown does not free the
device and cancel_work_sync() together with stop_update already prevent
any further work from being queued.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio_balloon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b02d9191ac6..e35ada767b4b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1137,6 +1137,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	kfree(vb);
 }
 
+static void virtballoon_shutdown(struct virtio_device *vdev)
+{
+	virtballoon_quiesce(vdev->priv);
+
+	virtio_break_device(vdev);
+	virtio_synchronize_cbs(vdev);
+	vdev->config->reset(vdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
@@ -1202,6 +1211,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
+	.shutdown =	virtballoon_shutdown,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,
-- 
2.53.0

