Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3F2E1C57
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378838; cv=none; b=t5dDSVuQQDiu0anWmX610ec1XZz4/cR+T+U0Wi6k4DxLWtURLCSQVRMPdhGRhIQCGyNYOJpPQo8GHFJJa7Ge23VWMeEyFmdrmOw+vK2dcu+aF0qLJ/XZri49khYHPEZ+BfSJk174M1ubdtM6/Ze7bPnpAq7jPEVAKqRChWVseRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378838; c=relaxed/simple;
	bh=MSr5XEHUW9lfwx8ONZK435PWQbRzcsG+H/xw66VcApY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOGZa5w5gbshb3KJKjamxWN+++IyUvLHlJ045wnlJ2VYwh+KK9ws+NgyRyQnJwRNzwm9tu2Rp7SCBnU40NqRAkooQIBX7ibMNEtPwICXSw27Ne5D/hHCiDsnLlZzGogGxE2D6YJOpvAPSvYHcUPCOh+c1akzyaqsibvfp5+H+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD3trnqu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD3trnqu"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37bbb36c990so8624931fa.0
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765378835; x=1765983635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCCa/WDuQFIGFlF08+35rlR/K3A+HtplJl47l9oHX5w=;
        b=iD3trnquWEBT+DaPqV50PdX3pFHxZoOJCQ57KosV6GiCihTNiSSAmN+h/cWL/TuULs
         SmGEjlsylc/3i4fmz/wL/GHD5r5yVFlJFFDdVFVOVNfEdQNoy78RHQCXnWoz7guxHTQl
         S5nBy52q10/Pga5kx7HmGgDeMToHynQzJs2FelXRvYVlGUqCcnA+l5sR8eIhLAQR0cVd
         FTWOC8HwmkEKL6Xh/b/v6lpnSAYb8zc2Kywe8gJVZCjHOhjJbDQVaCbQHPnw3i6gJGhJ
         DIxSEZGVKdkDPStCFRAu0duQjmR4TqN9c1A+VFATnuyqWH02gguvXx3N1sJksyRBC5t8
         Pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765378835; x=1765983635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCCa/WDuQFIGFlF08+35rlR/K3A+HtplJl47l9oHX5w=;
        b=J8YnqPTUId4RyxURN/ZBtMkus2zuKvwyrGMBgn/wZGW5uRvkp9Uc761aMbv9ppIdeM
         bRaKk19dhHWcr8b/QryNc2mqHfRRNAhfmAP+KzqMUYGsYGT1taq5ImPvxPh5YIDyfOSz
         QXj75mJG2txN9KIo4KvPzbUoHTq1ABUes6Jad/ENfsqcfb6UJdFfdHu0c1ZiICqf6LSi
         FpGokkICbQOooadj/f+vzBzpIy7Hdz2nijdHAaaILP6xuhm+fsInpippXtmBUZsKRFK1
         tH0boNfLlwEXtTszCe/qnTxObR2PnQM3ALnvJHyN7E5+s7X2sIOIsf8rRhLfpFBChicS
         u/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWiJqmrZYYN1ynYJSrKjTT+/MwEHooLQU/yvHQw7Vh5fXOwzcjoWbIuPe9DucICpKkXPWEHIRF55EqL7FPF9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2IhyHITOQBoI0Cile8D8OgvepbK2WnZ25Dr3t7YGIFWOG3NbO
	RrJT49E5590zij7wyP2soAkltuVGMtDwBPCnUOmi3KJSWCDphfLxa8Ly
X-Gm-Gg: AY/fxX4PRLcPPx2JUTg2rvH8KvyN9AHOsfyxKVUvTXH7Zjd8n5cdxFxww4QsPKS6yJV
	ZZyih9Eo813UgqJUYlXrU6U6MvXdtTDiJyI6xB8qyX1wE6K+/UwKh32HDWYTfupol6YPoDmhAQy
	6xm/Gh/7A7bQ86pVqSC+GG1LfL/2kgQO6nXweckT9xE7U0FlAKJgWSHN85/6CeBSG+k1TcIAsvN
	CzRQ2Yf/iyqHNMcR36x/UqYhhqBb2nJqDYqB/nHwsGXlBZT4yXpQt6CalUz7O/U3gLNhfDOG37k
	NBlYQrgZ4eBOcHClkCYqBsjSlbsnIgJDgyzLbyVQCSxWz6zn+iqT0bmxNcrG5S3cFQ2KGwlARf5
	CcoVKcA9+lHc7i5rDD7RYG/4FZLTsJikEMlAdHcUHxds7j+7jVGSMIkIFQmV9y9ZbQ0mBZHWB1u
	KwZmMBuC8wedw=
X-Google-Smtp-Source: AGHT+IEk2aJ9UE/bZeArjHeXKBRUIba+EThMiA73rubHvR6dRlwwPP/qhKuoL9TgS40b/KEUUho3HQ==
X-Received: by 2002:a05:6512:b8c:b0:595:99c3:cc1c with SMTP id 2adb3069b0e04-598eae5a7edmr1945468e87.14.1765378834679;
        Wed, 10 Dec 2025 07:00:34 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a3d9sm6467904e87.4.2025.12.10.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:00:33 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 10 Dec 2025 16:00:19 +0100
Message-Id: <20251210150019.48458-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vsock transport currently derives its TX credit directly
from peer_buf_alloc, which is set from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size,
rather than the host's own vsock configuration. A malicious guest can
advertise a large buffer and read slowly, causing the host to allocate
a correspondingly large amount of sk_buff memory.

Introduce a small helper, virtio_transport_peer_buf_alloc(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc:

  - virtio_transport_get_credit()
  - virtio_transport_has_space()
  - virtio_transport_seqpacket_enqueue()

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
cannot force the host to queue more data than allowed by the host's
own vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
recovered after killing the QEMU process.

With this patch applied, rerunning the same PoC yields:

  Before:
    MemFree:        ~61.6 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    MemAvailable:   ~62.3 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
guest remains responsive.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d58..02eeb96dd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/*
+ * Return the effective peer buffer size for TX credit computation.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we
+ * cap that to our local buf_alloc (derived from
+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
+ * so that a remote endpoint cannot force us to queue more data than
+ * our own configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	u32 peer  = vvs->peer_buf_alloc;
+	u32 local = vvs->buf_alloc;
+
+	if (peer > local)
+		return local;
+	return peer;
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	ret = virtio_transport_tx_buf_alloc(vvs) -
+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (ret > credit)
 		ret = credit;
 	vvs->tx_cnt += ret;
@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1

