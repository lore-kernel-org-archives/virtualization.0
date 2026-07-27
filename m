Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECF3DB983
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124705; cv=none; b=EvgU0NdGBlX+oBcchRs+erw51PQeYoQpQt883deGs2uTGay40Veh3LWjimMCoV8GJqvGIb4i9uEC/EyPCt/2wfYekipp+BVt8sm8thu6m8w8joSveE9xpzpAlYLXzxTZqB968udcbSW321BbKSlniduYGrP/47OBg0gyvAmNqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124705; c=relaxed/simple;
	bh=TlYdtrHL+mvv8ijwFP2OcSIxIVHRN2GalntvmJUIBYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smSapnQREuhhNliM9xnXUSjh1T3LjXaCg+LihFrUtBG0cYlctJLYeGBGCfnbm2E0VRmtxUphX04R+A6qgz5IFxXGm8uROumNtB/uD5SQv2GapdriTltZ7onvwnGJt/iJhLnlrlAx/euZRkXx3sRRCs5BTbE2Kv8zZLRjwDqD1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBNWnRRk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBNWnRRk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso2216045b3a.1
        for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785124701; x=1785729501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=sBNWnRRk1dfpocVOdwRQN2lEderoEim7wrcU4XWLuOdpzCkZu8FVRaYJ47F00h5Awj
         UpKOPEqKnCzKKMp7ImX33wvMtJ51Enm2GWglm6PykJ4bdYPm+0X8U5Fdpb6gNeb8ZB3G
         gbhiwy4ZRCmu5MNR6Dltn3J9xmTHWXUPFsdtyFw9MGPdwA4cufKQlk6JPHGsYcAK5irT
         sw1QQpCeF5UEnHpQRGgnNk/WU1L/WusRgVXEeXFVSsGwT7B8bs18wuvmPjmFPc2nB2co
         oP1qLD8PwDag+yyl920ss+fXWYDOqMz6bjnTZvHnUumGCgp8umZb5OtnqvNOEnuiGB8j
         BwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785124701; x=1785729501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=Myh1taqfRnjAXUVnPI7fNIO1yM8pc2pD/JeLrMNJaaYQNm9G9CY1NQwIOk2ecqz58r
         q7SlTH35O7nqUriOEFuxdcWG0Aj3Dv3H27AEOd5hOWvHDyXungDX27EZvIf6+al2TQDp
         JMplPJNXHgEdryVUm9XFdpEYWwTh8UeBM3S5PKhdkTA/UqFhV1JN7J0fFuwtt0oxbiKL
         DOWS2tRtkm2Ty/Mwm1w2mttSBoDDBBsSriXg22WXcr1OLKJytd8udfHMk3wUaWN2ufTV
         GoueymszyvHyQbgIbcYif9Ihv86d0LPdQJqvg8fBBHUn2IweHKlNqoQmi7oox8wPhPoi
         ifXA==
X-Gm-Message-State: AOJu0YyNCEvuEWwY4PVYScvx7fRpTP2Oi2BQtVCIuHplDYfiCV12h3/F
	92fjuzhZ5IrXRUUXeZl+pppZIPZTrr31ok8m/zUbovCw2eURqjZcUfJ2
X-Gm-Gg: AR+sD11D6cr1G5DdN2cGuX3sziGqOabL+QDG2GU4bUbPfMcZ3e1fnStMQ5IQC6jiph6
	StRtQNA5M8gGcPthA+Nc6tNiPvEUsBkVkbY/nz+2EL4buflx39lkWiOhy9xNn+JaN0v2r2mhw9d
	1mbXv+4GQLqrhwi5ud4z6lskmgURZGZkm5j4DkXfdT7+417zQdK4l48USyaCCLJz+udwOaDuRH8
	IqewKMrn1Lglr4lws2Q9jGP7zq8ifkPLVIAWepU8zJ0rj8iIHDYkHCSV5qNJLNfFyuCoVkA73JY
	iVCQTedgG7uAegnh5hOQ0ZTrxBbIzRZj2uBZ0bH1LUlRg3lVuy142nZwIE2L4wXEp1HvXWC5UOc
	5rYGe+pFH5D942SCtfqKyKPVZqwdvBqdffn7hsgfslZ8lbA5CNTu10a+2HGQu6t9RSgDkp8Uz3k
	qARckIGzFsK0TbR5meEbbP
X-Received: by 2002:a05:6a00:4294:b0:848:4190:ae72 with SMTP id d2e1a72fcca58-84e5955f15cmr5374554b3a.46.1785124701206;
        Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660dedfsm2680815a12.4.2026.07.26.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:58:20 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
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
	stable@vger.kernel.org
Subject: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
Date: Sun, 26 Jul 2026 20:58:01 -0700
Message-ID: <20260727035804.1860862-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX, TX and event workers read their virtqueue pointers before taking
the mutex that protects the queue and its run flag. A work item delayed
across freeze and restore can therefore retain a pointer deleted by
virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
and use the freed pointer.

RX has an additional path: when rx_run is clear, the common exit still
refills the RX queue. A queued worker can consequently call
virtqueue_add_sgs() immediately after freeze deletes the virtqueues.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/2:1
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

Read each worker's virtqueue under its mutex after confirming that the
queue is running, and only refill RX while RX is running.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..79cf19f58943 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vq));
 
 out:
-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
+	if (vsock->rx_run &&
+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 	mutex_unlock(&vsock->rx_lock);
 }
-- 
2.55.0
