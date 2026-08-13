Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D847126D
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623174; cv=none; b=KJetpRs/FLqOJ8sxUjg3CfrMH5U6YK2SxKOqPdmaPYYWVq+pWu++M3OFoqJzT+8a2xAj5HqIEPat2Qpjp0FpCMHXhp9hl71bxW3KNFiqnb2iJMwZGOWp13duCL8+Uh1mVv1OwQLhjomq5wN79sSmDhxYJFsFCZTxap8F3QHbHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623174; c=relaxed/simple;
	bh=/17flycYSc19MMlgQ2UNX8D5txCWeH/AzDfCPa7n4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsqxuttBQhK9VXS1BGMm1SfUZz0+lti1ABjHcIhmSwbVf7xaUeU1nUEPcdncvDn42vhMwpdN3HQBaU5jrcZCSDm3abrUFl5RlLtWBOBLauIgDDYW57sU6iBk66BLx/JpzalpEji/jIHVnUt2NH/QuK+JHc9JktJ8wfgbjZf3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp5UYtvl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp5UYtvl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e08baf860so689124a91.2
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623172; x=1787227972; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=kp5UYtvlTP6Xm49RKCgofr0+IDQbpB8UHrUiZjNf1VxcuDivTF/Lgi/lKQvAT68qXe
         WaB/s8KSM6eBbQ7mWmYz9q731IzmJBKIl35SWbZQAxBwLonTxwYQNoudnIgJH5XaEDA5
         wpjutb5UYAs4dKBMp+sN3/xVQdndFMJJ8NAzli0Eumy3Ap4IORN9Fl66E5TKCHypyDgY
         l4ZHDcZRYQHTcnGIBFAh9bAJLFTE+JZ8ge0O9JK7DzRf1okZKNdHLNVXiHKbKRbswSWd
         MrF3f9z3Vzwmw5Ude4qoXLvXW/qb2+4cK/J+kXJ0wzQASR2NP8n51q68uht7CFOFzvdU
         4mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623172; x=1787227972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=J3i5+dUDL9Y213XXmcPGiVQBdGnzpZAzPhSbHwsFi4xD3ZDbAnT9TfRi4U7TmeotT7
         QtgOAUFT6nSWd86kvW6BsA7pD2jT5z7PSaqLd+24nuW9nAReKaowQ/yOVfwvuMkTifp1
         hxWDU29M49SAZNULbIhxAvkgEcxnMiJsSAzaU/E2bXL6hhMtoZpWesGaFy7nirZbnZvi
         DTavbo47aGgh2QZQaA8EMU1vHCmsE22cE6MgBFDJ0OFnBlrE7xC8oR92L+wwWiXL6Zt2
         MyWua/VJKVbkiSA0aKCtkurKmCzmLbzaJEWMqCpnkuAoZt+knHqedHp6vIq7YXa1PpQw
         H9Tg==
X-Forwarded-Encrypted: i=1; AHgh+RoJ8PnYCD1uUAvXjbp6gU92xINnobFDDzHsy6Zu45wRcJ9L4wNachtMK+q82RXyjAxD1bI6Rwe1ACj+n+Dh/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNO/b7nwudBf8ESFGUP1a8jz95JfHwBAy+CgC63pMZEsuqID+0
	x5mVZBdZcbqQz2Jq+lVbD9jKx4Qcx7NjRdyxjowxa/Iyxs/5eScVmK8j
X-Gm-Gg: AR+sD11OoZHxZ+7QwEPoo3Q65XPkXIgBKWu+eFrCw3WZVcw5T6cAdXJEnWyTAzlD3J0
	sGxranUkgoAbVhw4HbQCJ7AdVMspE6npzC5gZtkbWeCHxZ5LNOInfHvQNygSdsyC2lmwzVTloHq
	VXGfdOQy990yLNadaKUKpFFpRSaTSRJ+scxYaORfKLnk/rxlPjbcZJi9tCKe0K/OSGksctooFBd
	BPaKglz3Z5U6r91BzMPNkwCh9ss/rYWkatK8yTPBPVqxroqTLrYZHdgcs8teRtaZjzXjcPF6YQH
	ZQwcOsIevJyyco2Ojkr3MxWBu0s4T+8dCQYrmNVCJrwxJUuJGTEyyjxzTahdA2fBXySGn/Ti583
	5DktciCRaIBBf27m0E0LNrKK8PdXGfV9eMZtcpZPUFab9lW7AIHdFYJyTXCniPtpZwxbqgTuVhJ
	BtIJbl+T+B4C7vnsCByo37MytAkJXEip7lp3TkINL5IwG3xy6P6YyCijGkgdSiRzzMeSevZsYL
X-Received: by 2002:a17:90b:53cb:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3931e0241cemr6853696a91.3.1786623171943;
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm1069999a91.0.2026.08.13.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] vsock/virtio: validate packet source for connected sockets
Date: Thu, 13 Aug 2026 21:12:36 +0900
Message-ID: <20260813121236.2328599-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() first looks up a socket using the full source
and destination tuple.  If that misses, it falls back to a bound-socket
lookup using only the destination address.  The fallback is needed for
listening and connecting sockets, but it can also select an established
socket that remains in the bound table.

As a result, a packet from an unrelated source can be dispatched to a
non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
selected socket established while retaining its original remote address.
Subsequent RW packets can likewise be delivered through the
destination-only fallback.

This was reproduced with two capless processes under different UIDs.  The
attacker discovered the victim tuple through unprivileged AF_VSOCK
sock_diag and injected a chosen 16-byte payload into the victim established
loopback socket.  The legitimate peer received none of those bytes.

After taking the socket lock, verify that packets for non-listening sockets
come from the peer stored in remote_addr.  Listening sockets continue to
accept packets from any source.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8becad812..f73e0406a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check if sk has been closed, assigned to another transport, or if the
+	 * packet is from a different peer than the one connected to sk.  These
+	 * properties could have changed before lock_sock.  Listener sockets are
+	 * not assigned to any transport and accept packets from any peer.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     (vsk->transport != &t->transport ||
+	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
-- 
2.54.0

