Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5064A8C
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821137; cv=none; b=Z2vHOMWQdGSUM9DN/2ZN6k+b0k6bw0f7GFu/REowIkJqCEiqFOscTpz91gTlUZB0qQTALCSaDvOJcGPIKLylDsx8ACr6Wuw0Gflr+2qBMZ6eisvpqTG+6l7YPh37hfOlFejIF3tuskL6+7m3ayCinuZyn1rZHj5WtfEDqpr0V+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821137; c=relaxed/simple;
	bh=GctKM9XXg+GnjqNzLj1lvNyHmnB2fVlViSak70gmUOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jgaU6jLeMssfaw0UoD79lelY9a+xLs0/ti8lO/9yBzttiP5i2za1f++LMhV2YR2nD6MpKarWX3kbnyAsiY355HqsXDhG4JxuQxn5Zr7LGk9O1sSXpYGUEe4xEyxuyVnTxnoJryw+9rLiEOYKBSeVntUvVcwCsI3z61oYi0MBkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=ERlqTsoL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="ERlqTsoL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso11305575e9.2
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789821133; x=1790425933; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkEY4SkyoeMcPychhtr9Y2+YjnfNMNOmheDASLiNUiM=;
        b=ERlqTsoLedKAzL3DGT7xE/5+RBh6Qa+G4noScNxqAI4ULlaF/LQI/1bWbjiIHvFwbF
         N6Q8UuYxzlAkAyTLV6j4C5O8Jeg9zvHjZGP03qMQt+47J5ai/laQtUJNaV6zS3pNK4Jg
         Nch3wDbePWqVixnGfg+hjF3dpybBSt+0XNB/cpjODt5Yt4V3EqsQ0h2J9TCuDimO4FDE
         96iTJZzv/iGZHKrVO7lALzvB80QxfmNfnMWLubD+TFqdo+5hFAcuBYM7wYH079d70TR9
         yPAgwAoeMGu3V9iqwgGRwQviNIS0c2vBMhESz2POsNvLJaqBn0BAJZadvR//zAPLqgk+
         Ei3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821133; x=1790425933;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kkEY4SkyoeMcPychhtr9Y2+YjnfNMNOmheDASLiNUiM=;
        b=MxCe445Oy+aNts9ZvMs3wUnJs3mh+oX+hWYwm9rfnh+F5H5Pb50AeQxNP5mOckQxbd
         5rb1OXHggGC0tYT5xjmaljdvtgrLn1Cn7MVz+UFIGMVBITvn4tb1webrxCaxaXpdctR5
         owAdQwiwxOEsYRMwlRGbT1fQ5FyAmM7faw+1KPcD9XQLGuwGw94vrX052w3Ep5V9XtSu
         vhlZTMBeGZcsOgwcfze5Dbgmu4AasCipNKn3bIwF/Tr7U+kqlhqCHaWDe4pI8POoYNbz
         0/RaQKzcazOLoSkMnhBJtYZxxsFmmBvHpb5THDTYTcrAvM6hXpWaycIKOAGb4TMDTC3d
         j1QQ==
X-Forwarded-Encrypted: i=1; AKwUvByeKB9mW/HpX/5bpChenyer2alvW7KewZm8bR0BEOnTn1wkYfKVC5TZ5eHsiZ8wPi03M13mMWlPThi1ciyrRQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m3SAFZByv5q9+hC4Rz4NohBODOcHPDyQoW9X7PD98GRrf5igm6
	DPvTwl89gOp6aMuKBF1QTPkk4M6pQlV83Xfwl5duUuCVA6LbMPVl795/XypxCOyCxFE0GTzaTCY
	QPnWrvybd/w==
X-Gm-Gg: AYBFou29++3zT5qnwHL1PlR00wzi+2wHdJirGge3JmMYFaWku/zB+wkhr4K/eulNStB
	WS08dnX4ndfk7OhonQcyeKUXYqP2JYbOs40rAJzaMZf+I9QAbg7vMi3MH8bK4SLe+c8tyXoRnr/
	EpA6Jub/+2u/crYJ2GqHuhpAH9vwBhxunqIF1QxiN3Z2t54mvLw5EmtoNyrglOsPf8reBPu8+9u
	Vc2wbadkok/nKjFpe/adBkIFpUoRqZ9qgnrJiAPQM0CZ0nLqx4W7nEsx0W+5LBhAColdRuAXILu
	kpnvy4yuTEkyq9/pTgh5leVJNbnxOUK9ScHs0K+0hUzyTu00NIwkN0ICGEFKnBirNyzmUvVVZW6
	GLmBFjGeyPSneBZNh0IDyYcUU5WDrdjKPztnBylyJMZr5/BnXHxkGoPYUNc2hHV7v7fEL4FS151
	pVvogjyVx2yKKgAe+T+H1+XXYmy+nhBFf3AGzqLlSOo5UWCZb0tNvFkjdHx+YhBT3FpPY/SKZQV
	yqgvPJ/pYqMvGXlfN74Q6c/aDdG9h1teAXJCMx8XXtMU1te8dFF5h4liQ==
X-Received: by 2002:a05:600c:a013:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-49fc57378a2mr67846385e9.22.1789821132994;
        Sat, 19 Sep 2026 05:32:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcd8:ca10:f229:8aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d21asm88593265e9.12.2026.09.19.05.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 05:32:12 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vsock/vmci: make the cached_peer dgram decision race-safe
Date: Sat, 19 Sep 2026 14:31:56 +0200
Message-ID: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vmci_transport_allow_dgram() cached its result in vsock->cached_peer and
vsock->cached_peer_allow_dgram with an unsynchronized check-then-set. The
function runs both in the lockless receive tasklet
(vmci_transport_recv_dgram_cb(), no socket lock) and in the lock_sock() send
path; lock_sock() does not exclude bottom halves, so the two contexts race on
those fields and can return a stale 'allow' for a VMCI_PRIVILEGE_FLAG_RESTRICTED
peer. It is also a plain data race. The in-code comment claiming the fields
are never modified outside create/destruct is contradicted by the send path.

Keep the O(1) cache -- it avoids an O(N) vmci_ctx_get() lookup on every
datagram in the bottom-half receive path -- but pack the peer CID and the
decision into a single word accessed with READ_ONCE()/WRITE_ONCE(). A race
then only forces a recompute and can never return a stale allow.

This was found by code inspection; I do not have VMCI hardware to test on
(compile-tested only).

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
Assisted-by: Claude (Anthropic)
---
v2: keep an O(1) cache made race-safe rather than dropping it entirely; an
    earlier revision removed the cache, which the Sashiko AI review flagged as
    an O(N)-per-datagram fast-path regression. Split out per Stefano
    Garzarella; independent of namespace support.
v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1..97968ac53 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -39,10 +39,13 @@ struct vsock_sock {
 	 * modified outsided of socket create or destruct.
 	 */
 	bool trusted;
-	bool cached_peer_allow_dgram;	/* Dgram communication allowed to
-					 * cached peer?
-					 */
-	u32 cached_peer;  /* Context ID of last dgram destination check. */
+	/* Cached dgram access decision for the last peer, packed as
+	 * (cid << 32) | VALID | ALLOW and accessed via READ_ONCE()/
+	 * WRITE_ONCE() so the lockless receive tasklet and the
+	 * lock_sock() send path cannot race to a stale decision.
+	 * See vmci_transport_allow_dgram().
+	 */
+	u64 cached_peer_access;
 	const struct cred *owner;
 	/* Rest are SOCK_STREAM only. */
 	long connect_timeout;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -524,23 +524,38 @@
  * only if it is trusted as described in vmci_transport_is_trusted.
  */
 
+/* Packing for vsk->cached_peer_access. */
+#define VMCI_DGRAM_ACCESS_VALID		BIT_ULL(0)
+#define VMCI_DGRAM_ACCESS_ALLOW		BIT_ULL(1)
+#define VMCI_DGRAM_ACCESS_CID_SHIFT	32
+
 static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
 {
+	u64 access;
+
 	if (VMADDR_CID_HYPERVISOR == peer_cid)
 		return true;
 
-	if (vsock->cached_peer != peer_cid) {
-		vsock->cached_peer = peer_cid;
-		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
-		    (vmci_context_get_priv_flags(peer_cid) &
-		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
-			vsock->cached_peer_allow_dgram = false;
-		} else {
-			vsock->cached_peer_allow_dgram = true;
-		}
-	}
+	/* Cache the trusted/restricted decision for the last peer to avoid the
+	 * O(N) vmci_ctx_get() lookup on every datagram.  Read/update it through
+	 * a single word so a race between the lockless receive tasklet and the
+	 * lock_sock() send path only forces a recompute -- it can never return a
+	 * stale allow for a restricted peer.
+	 */
+	access = READ_ONCE(vsock->cached_peer_access);
+	if ((access & VMCI_DGRAM_ACCESS_VALID) &&
+	    (u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) == peer_cid)
+		return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
 
-	return vsock->cached_peer_allow_dgram;
+	access = VMCI_DGRAM_ACCESS_VALID |
+		 ((u64)peer_cid << VMCI_DGRAM_ACCESS_CID_SHIFT);
+	if (vmci_transport_is_trusted(vsock, peer_cid) ||
+	    !(vmci_context_get_priv_flags(peer_cid) &
+	      VMCI_PRIVILEGE_FLAG_RESTRICTED))
+		access |= VMCI_DGRAM_ACCESS_ALLOW;
+
+	WRITE_ONCE(vsock->cached_peer_access, access);
+	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
 }
 
 static int
