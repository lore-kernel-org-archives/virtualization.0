Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867664ADD97
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185793; cv=none; b=n1RJ/mgVEYV0MM+sm8ZFLKwXRQETWqqIPWPrEFK5UnyPdIVZnqRLxrc4OKRejGebZ87AVWp0taq1alw5ewedwgaOZOti/YEnAsgitBPwTt2BMTOYTWUOSzLfDWBPTBa2MR6WPjTolPHPlxIaMJmjKyLK8EqalzLZ+M8UA33GubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185793; c=relaxed/simple;
	bh=A8lCk64tyDutpdWygpqGjJXORX5zZQ3IQ4DQQhG5Q8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwYLI/vJ6ONh/NuZvDcPLpnI0TkqQR4FgKvCgJTPtKlkgXP6Nhi0zkGrjFsN+df93251uh12SByedpx/5mnBf1z1It1ICfWKVxUkxoCiC+0uo6y7GjZnZTjGu6idm+FY9MBCTCatrHpfyh2qz17w+Tts/SoumbJn7oK8ixayyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfQJwZsa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfQJwZsa"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-369576666d5so1506384a91.0
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185786; x=1779790586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=ZfQJwZsaSwB4MzpN3W99Y20R4qHqdrDbDRp+2eJw3CILzrzUVjPfmYkdMksEOE0dXI
         Gz8NiG/X8no1Jku4mtpzG9cuSZmJDZu4GDN1Wubb3hAfdDDKiEsFYim7uyZjvsdwhCSj
         Mzf5mRZdumJ+rEGLbs7BynwOGbgAOhgCr6OhfvbOaA+jiskVzj8KUyX6ipfdiX26MD4o
         Gp9TbV6C1tsOUu4rz4g/hJdVAa5sJemWZHOX5kn5ncrxWELRvTria6L1c5TiYUYaXj8e
         YM+OzpVdGlnf5cBC6f18ZOVvFCTw9KCxQpCx6Eui+mHI5gILrHsGt3yB7iz+DYGH6x1/
         Yc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185786; x=1779790586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=k7dJUc/WH31gxxaoQhB5oWqTI6aP4sOFIN/Z4MqPXgO/uBTWUwTz+tIJvX5Eqh0R4b
         QFjMPyzNAOVZzDA5jobuppYwVjGZqzYCvnqUgvwr8uqJEbJCWe0WJrX0WJNPctbSEGHK
         dqAwqcGf8LOlJp4VS+YQYRi9gGYrxoQ/w1LVlAFKmnOKPFQb9UwW8COEZXDaFtKg3Fsr
         5PLqiNXL8MGaRH2U/PPqdGuFJHcm94XCKwyLBcG3ZfnhUqMbrJokEU/slnAg02ioo8oD
         lZpSYo7QX5byc3kP4ueAVO756g5mWqpVwMYlRL3KFIuQR1U/nkOBQAtrpldHPtAWcxdE
         UtAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R/4JfL209LQXiEZ3N+yc3A2OTySdS1Fe84dPjM/Mn4IGADPfTiPILkIsYeo3XUQI79V9b0EHR9tN1Jg5yqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymK+TeP1f54pw0FubV+u1Nz5wf0haZwu1ku8tzFrqzm5Vjx1en
	hYM+gx6eA1doZCV0NPvlOqslt64j4+YZohW4Jc4Ixdn9OjFprsU0JNP7pHnYVMwxEcI=
X-Gm-Gg: Acq92OEsbPXlhjRTsJZNli+54HJ9YiyxshwdmgcAL3EkdqpXGgT4QUk9v8cnE4/Si/+
	/XOxQnoHOEo/yro+1g1TeZ7NBoG566vBzytmqyXrjluyWMBOQOKo2IPUa5/MBMsCWSVeDWz/8qp
	4IPzAXgtP/V8AmKgF1mLo6jPGN03KQfmYNh4sF3db/npBlbN/8M+vfmcAV675A4vuPCKS9t8SlG
	Zvr8s6T1mFRXFp0SCbo5m9qgHpxQloIxG/w5l2O1SsAhVErd0jci9F0VuO5iG1c25nomkwo1mte
	GLaCKmFw9Ub8eMHnKfyHdyLKig7X7PZeUeLpcG8eRnrwGK/whz2UBWZiZDEeOqABMM29NkMTOWC
	pP25O/RGXNIdtz4WTJu9jeMj4ZwwVCdQnN9Sg7MgIUR7In0WGUmUC/x4aZXBvYKDyOFE37U6Z92
	72xDmsxo3yhRI72Mc8Qt9FWiGmcw==
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr19522119a91.15.1779185785623;
        Tue, 19 May 2026 03:16:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm177683165ad.79.2026.05.19.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:16:24 -0700 (PDT)
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
Subject: [PATCH net v3] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:16:10 +0700
Message-ID: <20260519101610.233070-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <agwv3YkxYIC7mvyj@sgarzare-redhat>
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
v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  v3 stays
    focused on the UAF; a separate fix for that gap is needed and
    would be welcome from anyone closer to that area.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..ba3a66e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1161,10 +1161,17 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		}
 		break;
 	default:
-		/* Close and cleanup the connection. */
+		/* Close and cleanup the connection.  Peer RST is treated like
+		 * any other unexpected packet type in this state so that the
+		 * pending socket follows the same cleanup path as other
+		 * handshake failures, instead of being left on the pending
+		 * list for vsock_pending_work() to find later (which races
+		 * with subsequent packets and was the source of a UAF when
+		 * the cleanup work observed an inconsistent ref count).
+		 */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0

