Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1C2A1BF
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995158; cv=none; b=WdUOg02ymJ1ZANZpaAuukRmSwysjY8DEe3THq3C9op5NMlH6ZbBQbDBUelFQElh0Pq04+6uJMEO2gyiApqJO4G/0ILpddyT2BLyS8g0Wmd3MPfnV+wcDf97zfxF/cOPZpPb672Ii7ALAGOWyIaCI/PLSynxpJ2zdYlBdQEd3pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995158; c=relaxed/simple;
	bh=+q4OPt2stNgoEY1wZPAOuLkUrNjM0zDoFE6c77HSEmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRRTbxAnYsCnMQGu18oKwNsdM3gtR5i2oB8ZjPLctZ9kpkMj47NAxYweOEBF9fgaH0//Srdarssr3wQF5Mlu6AHaYXvC47z4dMobKpVWcTggmdb6KroEcxI0JmC/bdmVaQQydUmkPgMKIBZ6608eFwu6/aCrV+ILmfDSW13x4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFiAwwFH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFiAwwFH"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so7442404e87.1
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995152; x=1766599952; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6L/g6AKDLzO2oXAkjTlOO45wco9Gy2vbAOvP3aPl+o=;
        b=EFiAwwFHBKPtCa1mbDftsp1ubMq61ffQxa31TcJUwH2XWQVJhZd36SJQZnHWj9TbQa
         mM2I5HrUYFyxMSlygZemG+mZjGs7TOAy6J4Js5KELS7ciJIn2URo2SRPAKr+q1kAVM37
         ZleZNRPpZz0MigbcdJSvwpV63zEEe/bzaE7DNHeoolS1gGM7eD5SAYZMNfKEA0Yk3Squ
         ApIrV3Asfz8Sp88SQ6imKmNfdZLBK/Ym1ObQ3lxmmZSgLN6bJoCjDf6hZwv2AAIWlrFl
         oWtPSEJG+d0zxd6R3HNHOBZFH4OM+NGjvSvK9kSD0eFK858qXBpSozzawMELqwdlZtPA
         HgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995152; x=1766599952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6L/g6AKDLzO2oXAkjTlOO45wco9Gy2vbAOvP3aPl+o=;
        b=Mn3nBR/cRyaPQ3spU7jq+VBnlz/kQFy/hfseyGZis5WIXYyn/1gDhf47/VCneTlaD0
         rkbd+/s5WAfPuONb820Rds5zjDYeh8ovl874VrMDkPkDpN67aSidzwfHCvo1YAo7mMuH
         jKjHB0Berm7mWdXzOO5tkG+nApR8H3RzPMrjhsizp6KMHp1EtdfdeJMGLvTR4kydoDYd
         pjxqIY7W9Xp/hqgggwfgSLFsIFqF06NgPy1tC8coQxZXxnh4ycNEcqyb6XnUHJ3XIhUs
         Gx4dOXqmBYIdo0cI2WSeBEM18U1/10jH6ap7WJtx7E6tKcG9vWjkss7/u+y2te8qm6lS
         LxFg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Vp3Y7klTjjiCTBH8xYYFLHHQ4EeSqHVgMSzoW20BTxG/6kKIvl924wRoCX+O86rsyer5v6eaR18F5W0jvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFdN5IWrZqc2Y02Un2+DSj6aa4RnsMJKCTzDRrECT/pzPzCGB8
	YcPHX0eBrYWEC5hvd+I7ehJFToCiCpoRqm+hdkYXm0OO+VoHcutCCQMw
X-Gm-Gg: AY/fxX6LLKsHM33cfGTlm0006QId0Y9gyAQLueZfksoY0c57GAM3rG7XBh8KpYfbDqm
	1D/RuiRjNf0xEjTQf9ZHosgfRxlEkJ3c8F/0KKmkGZiM5l3tai+n7fPl92O3K620yfwnHG9eTz9
	dwMR51o+WT5WKIGwKFoFRcS2m7BECxzSoViCvDou/MIwLMJ3Wkwq6aIdeeRdPVRwgpqIvxmdhSN
	ZPrWzZNPL7Uc/WC+p9+AvAzrg0EjHyaX1G/UCb215ok9R12t8olwn58TYhzokVJxr7o2WQ/57Tm
	8HOikJJ7+ejFnJCPnQCszq2TbAlv0Xjfnee/9EBnltxUwsA8c92QwrhFh4EQs7U5fZV8Xnb/7Qo
	G+Nl/rCZhp4BzM5ZWniOc4W0lbr/Qy5LF3Nl8ydlunkov8ENH3dJOqim3j3Y4BsC9ebrQBlEabQ
	ccR5HIaaWJGQ8=
X-Google-Smtp-Source: AGHT+IFoJv0VtI+duA1BFZ1b2nyx/9qNil7UNuQ2voy1UQrqjVxXTqBKmiQjS+TdeaY4sOWMw/E4ZA==
X-Received: by 2002:a05:6512:3b86:b0:597:d7dc:b7ce with SMTP id 2adb3069b0e04-598faa3bd8amr6715768e87.30.1765995151819;
        Wed, 17 Dec 2025 10:12:31 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:31 -0800 (PST)
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
Subject: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 17 Dec 2025 19:12:04 +0100
Message-Id: <20251217181206.3681159-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vsock transport derives its TX credit directly from
peer_buf_alloc, which is set from the remote endpoint's
SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size, rather
than the host's own vsock configuration. A malicious guest can advertise
a large buffer and read slowly, causing the host to allocate a
correspondingly large amount of sk_buff memory.

Introduce a small helper, virtio_transport_tx_buf_alloc(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc:

  - virtio_transport_get_credit()
  - virtio_transport_has_space()
  - virtio_transport_seqpacket_enqueue()

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
cannot force the host to queue more data than allowed by the host's own
vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this patch applied:

  Before:
    MemFree:        ~61.6 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
remains responsive.

Compatibility with non-virtio transports:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    cannot enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

This change is limited to virtio_transport_common.c and thus affects
virtio and loopback, bringing them in line with the "remote window
intersected with local policy" behaviour that VMCI and Hyper-V already
effectively have.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index d692b227912d..92575e9d02cd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -491,6 +491,18 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 
+/*
+ * Return the effective peer buffer size for TX credit.
+ *
+ * The peer advertises its receive buffer via peer_buf_alloc, but we cap
+ * it to our local buf_alloc so a remote peer cannot force us to queue
+ * more data than our own buffer configuration allows.
+ */
+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
+{
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
@@ -508,7 +520,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 	 * its advertised buffer while data is in flight).
 	 */
 	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
-	bytes = (s64)vvs->peer_buf_alloc - inflight;
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) - inflight;
 	if (bytes < 0)
 		bytes = 0;
 
@@ -842,7 +854,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -893,7 +905,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.34.1

