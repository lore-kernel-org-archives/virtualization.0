Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A9463B90
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351559; cv=none; b=mtWAVwdmK4MZ9T3vgT01tIsDRPWE/adE6YThDDuMimqEm3be1zeRMcwFbsOSslp3sfC3nR+pGjV/dDsU8RdcBgxyFx3Rxro54BA/yMF58gOpVoJawyf21exyveI8fgyxQP/4DcCHMYnhoKPcrMc8jBJSsMhMunsn86M7sCZ5Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351559; c=relaxed/simple;
	bh=CnZq6n4lbArF4xO3Li8H/zaf5RFPjl2mChGqONYhzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFV8N/yo1swsnzNhPTwZlM1rIfCjTslSde18mpQfa+PJLzPIK1Aog0sQlrORx5XIU5w2SyeG6erKErlFM8nE9ziIL48EkVoG1sCm6E2D4y+OHAJd1m5nUw0n/zn6QH46sHVu3YWKNrsrG3iNLsKlfByoW7bzpo6ystDvgWw3Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSpwwjde; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSpwwjde"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84830c774a0so1543259b3a.1
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351557; x=1785956357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=LSpwwjde9dW6LFnBsODccNke3ZEHUEwAnzxLUt99ApKWyJ6HrxlKrNZB+mquwa91w2
         kEA8S5MAKKJPaJ8DdfzC2m+RhUx8urNfuotRfLSSR2x5COANeN4EI3PeFSsFJTasfZhG
         j5m2P0gfcu3r476GxZg3eDRaeOzGc3pYIsgz3BxkBP/FoNoj1iPLTV1M9XO9b/LlBGiV
         H7Pj/9AhWI9Tdkl9942OAIsINDOZdi9dE0cCopDBPT5+SbSM/aie829l8gV5fgKLvont
         0/pAwQukTi1IWdQj4EFy4e9LBZ9ahjWCUPOqOl3ZIG0rrb+Z22kblI13NN8xO+JQ1z3X
         9k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351557; x=1785956357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=YP3W/UlCKIUuU6D8EbugcNplEmZjjdxo9PVwfdBKH7xFYe2p6DfSaYX9NmxnmEVvLX
         +Le2mdBdLfaocYjkU5Dj0kmil3GwPTvCNkVy1dh0cZAelZFRexqeUDUdHrbMuBifOp8i
         zkEkOiIoJaUq1u+rF7XKRzSgBecvcJiykapLm4pX5TaGTPcicreGoyE1R/AeYaNzlcR9
         fQC09WRddBftv2ixfVoN9xumrasyjsU0bsqkfUhQ+yTlYFs3wMC53LLZ9ss/trvMAZh4
         YbihujW2TICFdo2A+tjsTZegPAGa/ptUX0ZV9mApe/dJIAHr6VV45Tvdt+sluzdwhLMo
         Txhg==
X-Gm-Message-State: AOJu0Yw/owSkaYP1+pbnLhBeTcRlU8G1nYxjz+O6/QhlYdLfN9QmSp3M
	rnI28d6W9l0xdZA67ZKKrkB2O6P6QDYF0TnDb4IvPSntGxxn6ImN2LxE
X-Gm-Gg: AR+sD138q43xDcgCEsOg04fByP1a1aDgDUKBdbKdLPgpOwLCwrg0PbYrw+MwGsMVCY3
	mLaXmgqCmVxHLENhFX+Pya8vOl6sgn0zKhOUF/s/6Dv7OCjsA31wh7a3T8OXq3kkuV47VgbM1wn
	JrLFt9Jr5crb9YdsqsJDqxEn9ktTsxfujYQPe7c96Tb8VBqnRyrr94ABapoitBMRKSn9gU92GzG
	y/vbFkhOY3L+V8Su0tyfwjHk+ggEZhTZ3iw7kUwltqSxfrPA9xyD6T/h/MfuyXjeTvooKtLXXKS
	foNk2wqj7sqWtH90rcxNapz6O95ogtmT1C90gEKhb8/G21zT2a5otQIYSFMoXn76B0+hkBbeN5O
	oprJpE1Y13Si/4vtwdNk1cs04SvNEjRi2oxAPVQAmoKgqPM2b69vBLvV8C2um6Oy3E6oL8phYG8
	mtzRgvTZBLOVAYDp5pX1uqUJ/BXQvGNs7uYy6jRNHICzon4Tz4Asa3wxdiLj5fK5ATtFk7
X-Received: by 2002:a05:6a00:2d0c:b0:848:732b:6b25 with SMTP id d2e1a72fcca58-84e93445d37mr8060469b3a.63.1785351557221;
        Wed, 29 Jul 2026 11:59:17 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:16 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 2/2] vsock/virtio: avoid refilling the RX queue after teardown
Date: Wed, 29 Jul 2026 11:58:28 -0700
Message-ID: <20260729185831.3247971-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
made the RX worker jump to its common exit when rx_run is clear.  That
exit still refills the RX queue when the buffer count is low, so work
queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
have been deleted.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/0:1
Workqueue: virtio_vsock virtio_transport_rx_work
Call Trace:
 virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
 virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
 virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
...
Freed by task 141:
 kfree (mm/slub.c:6566)
 vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
 vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
 virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
 virtio_device_freeze (drivers/virtio/virtio.c:658)
 virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
 pci_pm_freeze (drivers/pci/pci-driver.c:1098)
 device_suspend (drivers/base/power/main.c:1968)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Jump to a no-refill exit when rx_run is clear, leaving the normal exit
to replenish a running queue.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index a8e1dd95ba8c..96c9fe8d357c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -638,7 +638,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
-		goto out;
+		goto out_nofill;
 
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
@@ -692,6 +692,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 out:
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
+out_nofill:
 	mutex_unlock(&vsock->rx_lock);
 }
 
-- 
2.55.0

