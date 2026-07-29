Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D93B27D4
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352660; cv=none; b=ecL4p2xvv5GjqHAkMXve2kQPDJiTQNml2fMrGWf+cVm0D1DCE9MbR8+PmNMk8sveDvu9rnAH91KUNr6xjUHU0gAGVpQ5tT8jxvgKz3lADEYeMtXG3ktZfJOMqdi6sTTQjvwSDtXu46Z5MY7at1hiQyKOawriw8jW4RyjrTAaoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352660; c=relaxed/simple;
	bh=CnZq6n4lbArF4xO3Li8H/zaf5RFPjl2mChGqONYhzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIEDqd90ibCLOwnae5A6v+EZvluPGF7Qsps0qlyIKpFJ+M5ag1en1qn0hewooJNlWkp4rabi+DLPdQAgvTF4D0/Rt5fJzbUY7rbX+q0veYrNMdk9xmhPseaJ3eUuS11krDeiUN9TguOUDiXRgZkGFpsg09aIGuL1iRGj7Q4yjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inu1iMsU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inu1iMsU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1117326a91.3
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352656; x=1785957456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=Inu1iMsU33JvsgFVhLqbvpGLdSR9xNOIbO5bHKUtFJecJOk5iOWvwVJQvGEx+AymRJ
         B8v9ig8ik89ajKxiaA+LImtwIY6jlKr27vE3MjyDG5U8HNTl+9YrMmzjMogUQCi1kjBR
         nsSMaWlH6TNfbzOKnLwcMf3ZPN1yEUdkdZmBA3uIEFwNr+v0toYhQbcQk3nvzDmMdLk4
         pp4VkCQ6EQOLzwdLD1KczSMogyxJvoAREeHfNAMo36pcvbrWx+r/+LM9lmB5HaS4Y3iN
         81I56a84xxI0dQpfCtf7fpKhBYwUUXPnS8BzkAwWTexJSvDkTYckPJIpXS+5usgBBBc5
         kqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352656; x=1785957456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=hBZRcsJmnYfgoZObEl2yE6tnAmygVQgX+oTj5m1Sn/FC/vkwSm9NhlegNOR0GRYVio
         T1gJTAx6saIn2AyrW2dFzU25B/Bzf0MyY97ErRG68DCYhn+NErhzQnWf1o0mcr6VGHdc
         a9zvWdEB08MsdSABjSqrzdkLWazuWJLaKax/a/pC8Fcu5LzIad0ZqfsvZOWO1BVYY0eB
         UwHyYODS7l/Ad34e2exxZsEEttC0QXVYdTFqVoHSyEvD4sfIhfvsd4qFwj4TrT+Zigp1
         FVqARvZFFXj++Ea52XXsIgbtSYkjCVU4Ba6WD4tcMFMK3AZ6ULSRIzvNghUhvFFc69Oc
         HCSA==
X-Gm-Message-State: AOJu0YzFYiYGzVi185/Dn/uOmg8ALBHQnvIX2iNTMcRBk6MzszIKTVGa
	yNArVQj+IDnn4V+wxWKI3YfLwWjOKsZ7sAy71JknR1/sR4upQpwt+NbA
X-Gm-Gg: AR+sD12SoeU1VEm7uEIc4qJ7RRVIFs35crPdHDZxzKB8Jil4HhK/sQlls4CCoAxriGX
	mB3pD9svkfo29rmsNrChLplpn5yevJR40fVTV4BLR2dDzDokuN4N86mkIrquu2e0hJVLyQRYtAK
	scdBHcmd/ktK8WgUQmi/HKD2/0uAsmSxwyYV+sSgCLnl0ime/sFQ7xsnhMcpgMKC1sZVQg9T4V3
	A65rjuRrcnhrJJEK24j9r4IWY5qeq6ezulsK0s+nUoppQR1P+kIf72EmpYsK99Cg/FI/bea0NCr
	UtbiWuftAXHpEPFlkdV8VGMxN1/EaIkZRKr5lCl7cv711veRPJHfWu4ZswBhNyrcMf7RbDRFo4W
	sxPXHPJu6aWvddkoZVgLPJ/TG5xjjZf55Vf9HwiyqwwluPEKMlMom6ZwQWWxLxrtW0epfxgpAfu
	w4UZvVkyfpQKu3kv/5hS3YPIZRLBudRhzQF3YKoe2HLnD2bi1NkADA2ogS5TXhNQyhPKT/
X-Received: by 2002:a17:90b:39c7:b0:387:e0db:bc24 with SMTP id 98e67ed59e1d1-38f9938b014mr120587a91.36.1785352655805;
        Wed, 29 Jul 2026 12:17:35 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:34 -0700 (PDT)
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
Subject: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue after teardown
Date: Wed, 29 Jul 2026 12:16:55 -0700
Message-ID: <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com> <cover.1785352330.git.bestswngs@gmail.com>
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

