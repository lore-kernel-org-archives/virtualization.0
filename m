Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B10374E60
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554748; cv=none; b=F6d7pIv9h98dLjYcJhDnLSn89jdYmxkqXX+3wS+3N8GCKcnwbf2UqhdWHMbGdCyrKkIMbLPYZ/XHeWjSRZb3qFDEXz/GIO9PAyLQSUdfL6akqIJIGoAmZtDR3LHb8reXtc7rmuNp4bGF0376/37tj2R65tCq5MddKCl5bsy+4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554748; c=relaxed/simple;
	bh=qELwf6yVFwCKCy76GRQ3b5WHenmlqq0luRAqIwCu6hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZX3pwLTHMg/T6U4vtP8Zt37O5V6RJaEncPVOSMhKhd1UsrKeldZoZHZzs7rQCFoo0MXMrMXhxofKFX1Vcc4Xpc3OXa6dpRwmZ23u3RZIw2ptxyfpg1/WtHBLqNTHGQqI5a37F+DBLNoSNlq95DAuhZAN6wG8knYIsPP61vBoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpFXCbMF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpFXCbMF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9e9a6802aso19992155ad.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554745; x=1779159545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/R8nu4FmGtSchXT9i0AhYNs7M9dg3GLRopNafO7mLQ=;
        b=cpFXCbMFJGXfQieFtFWEKyIB0BIV5k/od2ewaEF2tmx0PL+PWaUd5m2nlpDc4zw2Gt
         b8a/y4IggRmGENI4zBfYW0xjnc320g8etM2wgh7v0oZIQrjYpwFyH/bpWtLbrC8YODPI
         d1YXbZk0mgBr98O4WXExID8NFzTnbkfga+QFpwgkdwCP+5m3L3CyVe4eUeK/mU+UI1zF
         jVGuqJXH/I3r0RfbMAoNDnmKaAqtpFuuU8cVSKGw3htLDnwihbcpmB+DoH+W4hvbm7O4
         gG0kttlzu4Z8h579svEWw/Kbmz5/6uepr3LF5k6XWkrg35EgKdEjGTFEVnk+zARfJemU
         XGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554745; x=1779159545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/R8nu4FmGtSchXT9i0AhYNs7M9dg3GLRopNafO7mLQ=;
        b=aYCz04obYMS2ZwA0MyvB8r72GtlJ+XdLqaJlcRbnA8gRIFRJXQhfWJd0r1bIOTDaSQ
         jU5xr7uZi8OqwKuTshwcMWTX3oGjvvo9MaewdXPWYJrECzBLwnuteVBWPI+7PruKRnM5
         j0PKL0mD9terpB0zSbg201jEhFSH+G8ZFOdOgfdcrJt70B69nthKWbh76PC9RtL5mNXl
         jLl6BhNxNomDwWxuRABTvPjn2aVAPQWVg49fq7IrHsBbfiubvZ5OnKIPvwEt73/xoiK7
         1g7AtuacqUD4/+K24KEjU3KD6ZKGmpa63zNLkGGnsyzHP3kNrrG1YfWrbrXnlg2VB1vO
         /ngw==
X-Forwarded-Encrypted: i=1; AFNElJ9ymQyXI6yz5N/VEaL6knsMAlmeBYXh3EpHyYI10//HHPyoogCeyYHSnLlHDH78PVDgeQ8zbUxQHzSu4Z+R2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxazz+URFNCLdTTE6ydZh9meEh5bLWqgZPX4qzm1JqubFLPGvG1
	Vaj2W+qcffS/pvIiiYRB9HH4e2nZ+uSExh2abks6Hh6szaOcSeU8eX5R
X-Gm-Gg: Acq92OG4b85bfSWDYidEOJS/uc95VZUojzLQH9UzVib2Vb6vnWc5k/V7G91Y7AGNahE
	8WbKVCkk/5ltyKTq29XUI3vrw2ga9NznRHuUwZ/jfN+JLPYjeJAOuHiOo2AzmgQzd/QZ/5zCB7m
	H1r6WoBirEQby88UcFRfc1xYjbyFA0+LlUXCK/QRBfG7/Zh0EKU8qRKP+iUb7Eyp4v1FMtfEABG
	g8gUy792/7c2hiA4zWrJGJOKrTOhx18U3ifJJukAq6B3dXZj7zU9F6Y31NcQDeKH+PmKaPtP0MU
	Wqa/Ft8FUP9INf1w+Nm75bnnewTueggAecQddUz4hac+M4Q/ZtgUkEXRlNMwczhZfsL98TPUEWQ
	F40Mwk2EdZWZAVgrpKHNCtJ/9YI92F8S9Ww1mmb9vReX3BOgUYyrlV05gR/Xyd8pbvxEXoKLCAw
	+k9CBhPnyCNw7JQfwvi5eoVxURQR2S
X-Received: by 2002:a17:902:d50e:b0:2b7:a1ff:b239 with SMTP id d9443c01a7336-2baf0d27e04mr160602415ad.14.1778554744436;
        Mon, 11 May 2026 19:59:04 -0700 (PDT)
Received: from fedora ([2001:ee0:4fc8:5b0:526c:3adf:8a0d:13a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27242sm129460145ad.9.2026.05.11.19.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:59:03 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 12 May 2026 09:58:51 +0700
Message-ID: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmci_transport_recv_connecting_server() jumps to its destroy: label
and performs an unconditional sock_put(pending) to release the
explicit sock_hold() taken by vmci_transport_recv_listen() before
schedule_delayed_work().  The existing comment claimed this was safe
because the listen handler removes pending from the pending list on
the way out, which would prevent vsock_pending_work() from dropping
the same reference later.

That assumption breaks for a peer RST.  The default arm of the packet
switch sets:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

and vmci_transport_recv_listen() only calls vsock_remove_pending()
when err < 0:

	if (err < 0)
		vsock_remove_pending(sk, pending);

For RST (err == 0) the socket stays on the pending list, so when
vsock_pending_work() fires it takes the is_pending=true path and
drops all three references itself: the pending-list reference via
vsock_remove_pending(), then the two trailing sock_put(sk) calls.
The unconditional sock_put() in destroy: had already dropped the
explicit sock_hold() reference, so the second trailing sock_put(sk)
in vsock_pending_work() is a write into the freed AF_VSOCK slab
object.  KASAN reports a slab-use-after-free write of 4 bytes from
refcount_warn_saturate() on the workqueue path:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work
  Call Trace:
   refcount_warn_saturate
   vsock_pending_work
   process_one_work
   worker_thread

Triggering the bug requires only the ability to open a VSOCK
connection to the target and send a RST before the listener accepts.

Skip the sock_put() in destroy: when err == 0 so it only compensates
the cases where vmci_transport_recv_listen() actually calls
vsock_remove_pending().  RST is the only path that reaches destroy:
with err == 0; every other path produces a negative value, so their
behaviour is unchanged.

Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=y,
kasan_multi_shot): same trigger binary, same VM, 100 iterations:
without this patch 52 KASAN slab-use-after-free reports fire; with
this patch applied, 0 reports.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v2:
  - Resubmit to netdev per Stefano Garzarella's request after v1 review.
  - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
    enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
    same VM, 100 iterations); test summary captured in the commit
    message.
  - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
    bug is no longer embargoed.
  - Rebased onto net/main (no functional change to the diff).

v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
no public link available).  v1 review summary, for reference:
  - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
    vmware guys on this that know this code better."  Asked for retest
    and resubmission via the net tree workflow.
  - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
    me."  Also noted that no modern VMware product allows guest-to-guest
    VMCI communication, so the practical attack surface is host -> guest.

 net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..88d7128 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 destroy:
 	pending->sk_err = skerr;
 	pending->sk_state = TCP_CLOSE;
-	/* As long as we drop our reference, all necessary cleanup will handle
-	 * when the cleanup function drops its reference and our destruct
-	 * implementation is called.  Note that since the listen handler will
-	 * remove pending from the pending list upon our failure, the cleanup
-	 * function won't drop the additional reference, which is why we do it
-	 * here.
+	/* Drop the reference taken by vmci_transport_recv_listen() before
+	 * schedule_delayed_work() only on real errors.  For a peer RST
+	 * (err == 0) the listener leaves pending on the pending list, and
+	 * vsock_pending_work() will drop that reference itself when it
+	 * later cleans the socket up.  Calling sock_put() here in that
+	 * case would be a double-put and free the socket while
+	 * vsock_pending_work() still holds it.
 	 */
-	sock_put(pending);
+	if (err < 0)
+		sock_put(pending);
 
 	return err;
 }

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0

