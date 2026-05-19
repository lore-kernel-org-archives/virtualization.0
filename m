Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3413A9DA7
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186208; cv=none; b=XUhrw+PIFn6uEgP7ZbmsVMzAylCSjlPR8rHYcMiiKFK+xpGvdloRA35r2Af8iH+mmAeSS6GFVtPqr3f0f726fMAZs5Wd8OpP5iNOe0b8fDKYIj4dNEshF8Qa4P7p3Hgr0oiwlGnFVwIDq4hazE0LEYUHM5cxK6Y+ILMeLlC6umM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186208; c=relaxed/simple;
	bh=DO0Gh9yEyPAdPj/ANVn8igAk2S/1BupY7L+OcOzpdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKsLB5rqVB/KyXj3bE3+0HO6VY52EUOGoFw4i7sK7yGp31bS6cwqu+N0vmJUn4vHPda1KfDOQftyi3vMhgmzDQ3MF/2/4GSlKasa7p30leJklSQamNzE5aF2LqN1WsYj9WstJKQIjokS+5JBoHMKfUyeLjTznXE5h+XM6BNW72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECv9dYzU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECv9dYzU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36974221f93so1602392a91.2
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186205; x=1779791005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=ECv9dYzUFM8Q1rlXjW7L2pPZyGoWBqAWLhT3GzhlehOeSyytF2e6xxYLvLSirxk2dv
         UPF83nSDtyMCbaGhKqh7dJD2k1MtCYWakw21WCJFi2ILX16YB2X/XMxei3z92VfwO7Wl
         /Ep2TMUGITS5JyDuNo63qRG68UvkxfCtsU/7xjKsYAz5Bzb2zJKlephWEpP9ZAJ1nSQM
         VQivN04UOzVUFBzOWU4pV63EpNsqNZkdxC6/mi928RnoDwdEukEpDLCkCA0BL3R7UV9B
         6htUJFKW/mzSFYQIshWvQNefv9+dAsT+sGgNEd6vz/3DSebae5jqv3PA1w1Y7VxGZYh6
         ciYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186205; x=1779791005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=rpkYtsHzwwAvlvIVv6dYu3PB1H9DUipLXeFLkoTakziXPrKR8Tz5pfikqhyLcGpX5m
         AFegmfwaKNWFMRlKzAYpkk9GxXXlv6GZUM1B1xn0hVgPKU1vtkk6SuF1zLoOP+ToBbVU
         j3PxkutYqz7wVZMQNapBlgUJKw//52VjbKzeusN8O8CnHxVxlzKwmkMDb3tf79AQuTLI
         VHOmduZtT9lJiY5SoQudzN2mvB4akvU5D0oFyjLXIFXnZHxuSNh2YvG0onRbWmZOVnEw
         FTP+LW4HX50FdHgguDKAlj9Ae7EGt0q6UnmO4PGEo8XtGnDc0j8oAem0x4mKnQTM2SK1
         N7SA==
X-Forwarded-Encrypted: i=1; AFNElJ/LoD7mj3XtVVAvEFktEH8Nof1xpEcZ6Y2tTXNt6W9Wpg8NgVFTwDHXEfuvPf8eRJqweeEAp96zWdjNloNBBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfhVbZg7fV+cP06honhfZDCmRaV/PzETdpQcVZTnkU/x5QEE4X
	0BtLjrPSeNMUc4Xz/3iOq1YePpvWVOYRO/v1YkJmP9wvbIPUS82IhbsL
X-Gm-Gg: Acq92OHEqj6CGoNFlaIDAygibP9hA32wE1DA57fIZF5WcIvEOtx/xxT9BHyLQdO2U2M
	qpV/9vKZSmmp/c/F29RBBfO323jJlmX4hrIc500dPYbdMgYFMg6YB+yZioBpTijYILXsC2I3Snq
	r5IgKNziS0sjjlta9YQ1SY/RoLBHTlOvfMaJRqBsanKgiIlnoAfMadkSlh++7S7508Oq9S+04lf
	dlFHVOGQFG8f+HLgB+YxUpse3BVxAW7d1l6viP4Q34NX6mk6VZXl5ITqUmHMiVQwMPTm8gstNAe
	o4DV1Z072iyDIF8YQ9eAypq5zfqABfjA56MxWzPz/TzwHgnWnQpnY6EAhSQhTtWflcE5L5r4fIU
	zhWtBt7+Npm++20lHaYJYVSQthhv6WolaKkDkb2JO+55mJw9ZyHYp4nIASbbpQUwqbEiKA6F/Dw
	6R4sBFeBVL8L0wQiXbdMr+RX44dA==
X-Received: by 2002:a17:90b:5290:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-36951a02b73mr18385801a91.10.1779186205288;
        Tue, 19 May 2026 03:23:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148d53asm13708947a91.15.2026.05.19.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:23:24 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: pabeni@redhat.com,
	bryan-bt.tan@broadcom.com
Cc: sgarzare@redhat.com,
	vishnu.dasa@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:23:10 +0700
Message-ID: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmci_transport_recv_connecting_server() returned err = 0 for a peer
RST in its default switch arm:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

That made vmci_transport_recv_listen() skip vsock_remove_pending(),
leaving the pending socket on the listener's pending_links with
sk_state = TCP_CLOSE while destroy: still dropped the explicit
reference taken before schedule_delayed_work().

One second later vsock_pending_work() observed is_pending=true and
performed full cleanup: vsock_remove_pending() then the two trailing
sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
the socket, and the second wrote into the freed object:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work

Treat peer RST like any other unexpected packet type (err = -EINVAL).
All destroy: arms now return err < 0, so vmci_transport_recv_listen()
removes pending from pending_links synchronously and
vsock_pending_work() takes the is_pending=false / !rejected branch,
dropping only its own work reference.  This also closes the
multi-packet race Sashiko reported on v2: pending is removed from
the list before any subsequent packet can find it.

The pre-existing sk_acceptq_removed() gap on the err < 0 path of
vmci_transport_recv_listen() that Sashiko also noted is not
introduced or changed by this patch.

Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v4:
  - Resend as an independent thread per netdev workflow (v3 was
    incorrectly posted in-reply-to the v2 thread).
  - Drop the inline comment expansion; keep the original
    /* Close and cleanup the connection. */.  No functional change.

v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  A separate fix
    for that gap is needed and would be welcome.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..d257938 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		/* Close and cleanup the connection. */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0

