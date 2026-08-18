Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293B41D626
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040784; cv=none; b=XzikwNOFFHBdauftG+JwLxc4K7Ofodv68LGwZk+Nw6GJx4IrTjNJOYRcLU6sbgLNG0LTrAKlyvhH7IV0h1xNntjm0gjmFOukULwYzhqhfR+J1N9ixQuCaEogkUQ+ZKD/Nbp1Kwc0EHu3vf8UGKlFFXYtILEHID2c6axVsOo7QjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040784; c=relaxed/simple;
	bh=8Rkk4e5WTxH3+6c3o6Adc8ngZf6wgKB9h5G6sxCUzg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=of7cOaN5/GCYT2jmsLwz5gO8VKN8iNpU5iBrw1yZta6ZSHMviMtLapfPxFI2/YYl6LqSN0xhpMHzQWyTZdaXlf2OzIc/3TzkUXZX9TMn0RF5AmJUvRoN44Ke0VIxnRdtT+pGaw5gP7Mw8gvwTLKXFrK5l+IOpT7/NmyFKdT5LHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3gX3zE4Rq0_uiAA--.35410S3;
	Tue, 18 Aug 2026 16:12:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgA3T3HyE4RqELh4BA--.51434S2;
	Tue, 18 Aug 2026 16:12:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: hansg@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] virt: vboxguest: fix use-after-free in balloon work
Date: Tue, 18 Aug 2026 08:11:39 +0000
Message-Id: <20260818081139.399994-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgA3T3HyE4RqELh4BA--.51434S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?wdwB/gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNUZUskktimozYxW8ba9i/wgnDXgVi0t5G+j51kPNETvrdH
	TeUHjVrNU9pXGHEeLL2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyrCrWkAr17Xw4fWr1kXrc_yoW8ZFykpr
	W3Cr9IkayUKF4Utw1xt3Wjva4ru3s2yr9rurW0vw1ayrsIyryjvr45CrWjvFZ5AF18KF1r
	trsYqr98KrWUJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

VMMDEV_EVENT_BALLOON_CHANGE_REQUEST is reported only after a guest
userspace client enables it with VBOXGUEST_IOCTL_SET_EVENT_FILTER.
The interrupt handler then queues the balloon work, which reads and
writes the mem_balloon.get_req and change_req request buffers.

vbg_pci_remove() calls free_irq() before vbg_core_exit(), but
free_irq() only waits for the handler to return, not for any work it
has queued.  A balloon work still running on system_wq therefore
touches the request buffers after vbg_core_exit() has freed them:

  CPU 0 (remove)          IRQ handler              system_wq
  free_irq()              schedule_work(...)
                         return
  vbg_core_exit()
    vbg_req_free(...)                             vbg_balloon_work()
                                                   req->event_ack = ...

Fix this by calling cancel_work_sync() on mem_balloon.work in
vbg_core_exit(), before the request buffers are freed.  The worker
does not requeue itself, and the interrupt handler, the only place
that queues it, can no longer run when vbg_core_exit() is reached:
vbg_pci_remove() has already called free_irq(), and on the probe
error path the irq was never requested.  Draining the work once is
therefore sufficient.

This issue was found by an in-house static analysis tool.

Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index b177a534b6a4..884e69d00f72 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1048,6 +1048,8 @@ int vbg_core_init(struct vbg_dev *gdev, u32 fixed_events)
  */
 void vbg_core_exit(struct vbg_dev *gdev)
 {
+	cancel_work_sync(&gdev->mem_balloon.work);
+
 	vbg_heartbeat_exit(gdev);
 	vbg_guest_mappings_exit(gdev);
 
-- 
2.34.1

