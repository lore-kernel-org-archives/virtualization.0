Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA68313E0D
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682552; cv=none; b=lpNER147Zs1Ly2W65+vsRpE186LHspy5mK4yr+AW+4x5KPxf52xsukmfpO/trTSbrDquW5c/rvkp2NfnmnrnlMmEBOHeYGPP5z3/jMpE+t+/WRwYdx5XhZ4mCp0CaIHH+UwsAocilfRdln33Euvv2kEpfDPB1rcbEQsotXuDoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682552; c=relaxed/simple;
	bh=IIELrcZjQaM+R/WjXfTSMq+xkgqRBe/9+IjDCcmboY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUTytH5c0ze4pf60nzC+C7EkjFOadJYEeHsyMwAtFo7D2/J0/jBkwFlV/bX9YE1e+I4lQ65U71DPJXPQmlqXyvLwhsRRbHVQhUKu5rFELliwIsQ34v7LSR2Mh1Wcj75yDwx91Jdmk2DH5hLVCd01Yubh3IsUeM4CkDYlkhVh6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=S0YUGZoQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="S0YUGZoQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so635035e9.3
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682548; x=1790287348; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/yXPaD69b7u/Az65Ta16/Sktw7FkIXu2IrXlAc4/yg=;
        b=S0YUGZoQhKjVYSG8MSr2n1yLDXhK63DYrfBZho84MBmww59AvAFX8+k6sg/PntzQGU
         XtR0wjyA3+Kl3i5j0HCCMrpAFYdekA5/pTFUyRFqkCOsaOXuycN4v81sn5ZoXbjTo38h
         gr5LYQ7HBVnlMxOsQ2qObM5fe6BqwKkdtGkTwUErHbdATeVTKQtsuRmHnndCbFjQFKAJ
         ouA4Edu/QI2ADtCpt5vgH0GFm2k5k8AqDZNPCnyFfpwwsF61NaEQhwWfUjWznq6AjHS1
         OJfyXkTc3b0k/paGje1dVtUKFu8v47bkO51WRz0PGISwpWs0C4CWW7KnVQQ/GQKbtqwH
         ielQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682548; x=1790287348;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/yXPaD69b7u/Az65Ta16/Sktw7FkIXu2IrXlAc4/yg=;
        b=Uz1d47hoh5UydjqVuLMtrObYg83ecwc0hpSmptfpzVZbq/iTNsMAVTMn/5EoAVXvxp
         xos7kZHKeo6FywHcgxsJMfRBO00IKPttZ0c8GxfS/1x1JG0ry2KtaX7mQzPzcXNOPJkb
         dphGuY/4rfXLDsSfFU6DGR/4eIDjzB5LWEikQ3HLO3U7fQkyezJRoN+i6EnjzOjxS3sC
         HRCxDcb1veW0Py0KUeQ8mOk1cEtEPxmFX/KmiYr6nfIQQe+7DIzBCT0PJ3mRk57Ej6e9
         vEG7OMoi37bwYMIusmyfmapOSy4YsNLN8ubOVWD6li9oe9g7DuXLZgqUJRRLqPFPNmFc
         OJrw==
X-Forwarded-Encrypted: i=1; AKwUvBwFYhkOIsxON1utJQeKXjyUm9VE19KOZ4XJ+sqbPRx13tvBiF/AADCdkNobNQKWUyX9Rcn7CSbJ5tWaCK67sA==@lists.linux.dev
X-Gm-Message-State: AFuF++k/zLMCRNzi7Ve44faAhrTnqYP1OS3nKA9WnUaDC9fbmibuOQpA
	xcPhppINDBsj5EqEQqY7EDbOwvr+DGQhdeprzm/dC2tOrG9gbzWstQlTa4BFyCDzMOk=
X-Gm-Gg: AYBFou2U82K8Rj00zLSVD93dOdcAC7lZ58QdWKnwbaqtVCKgvv7Owd1Or7t2VIqq3cn
	vHOaOa8RozPGlIgQJ3XFe2ivhjfpsy3vW5MtCEINCB450i1ScuNlhsa9pedlE/C6BfE2MUK1dBs
	X+aD/TrwNPejeRpb4fnbUutVulwZEHb/LDEuwRzq2/olFOf0xERJbQz8igPLRzKYAqxjsBAwins
	6qDO6oeAVDaGnlimoJ9ozsHBDyOfzEniX/kes78WJzDNO3W5lqG5yNs7IbZjA1x6ovz9NX9Z1Ge
	zcX36v6uOHZfusdVPVXtVYWdGqezHpjV3wGk+J3GDi2Vxeboyp2jNHdhFHq3UEewgAoaAUn16pC
	74XdmdAjbAS8Qxpf0xqAtwVA6c2kAUElOPckdN5teNvVauvYE/hyQpyOeW4oyvDz39DuF+0LqD+
	euQmQ0SLWrb5mmw/dgsKJCToBxYxGc9HYZ9m63z67iiG7LpcPPkuiPaOqmuguNjHtbR6gJqoUhb
	dGF09TNzCXfah1gSnSWV1dW+bvQ8D4m4sqYf9WILbxVbYQ=
X-Received: by 2002:a05:600c:83c8:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49fc5851e92mr2295905e9.30.1789682548680;
        Thu, 17 Sep 2026 15:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:744c:a1ba:d233:283a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm106258905e9.13.2026.09.17.15.02.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:02:28 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: pv-drivers.linux@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vsock/vmci: harden datagram receive access check (netns bypass + cached_peer race)
Date: Fri, 18 Sep 2026 00:02:24 +0200
Message-ID: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vmci_transport_allow_dgram() gates delivery of incoming VMCI datagrams. It
has two problems, both in this one function, fixed together here.

1. Namespace bypass: the send hook vmci_transport_dgram_allow() refuses
   datagrams when the socket's netns is not in global mode
   (vsock_net_mode_global()), but the receive path never checks it. A socket
   bound in a non-global (local) netns therefore receives datagrams from
   peers it could never send to, defeating namespace isolation.

2. Data race / stale ACL: the decision was cached in vsock->cached_peer and
   vsock->cached_peer_allow_dgram with an unsynchronized check-then-set.
   The function is called both from the lockless receive tasklet
   (vmci_transport_recv_dgram_cb(), no socket lock) and from the lock_sock()
   send path; lock_sock() does not exclude bottom halves, so the two contexts
   race on those fields. An interleave can return a stale 'allow' for a
   VMCI_PRIVILEGE_FLAG_RESTRICTED peer (and it is a plain data race
   regardless). The in-code comment claiming the fields are never modified
   outside create/destruct is contradicted by the send path.

Add the symmetric net-mode check and drop the cache, evaluating the decision
on every datagram; there is no shared mutable state left to race. The now
unused cached_peer{,_allow_dgram} members can be removed in a follow-up.

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -529,18 +529,25 @@
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
+	/* Enforce the per-netns mode on the receive path, symmetrically with
+	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
+	 * (local) netns must not receive datagrams it could never send.
+	 */
+	if (!vsock_net_mode_global(vsock))
+		return false;
 
-	return vsock->cached_peer_allow_dgram;
+	/* Evaluate on every datagram instead of caching the decision in
+	 * vsock->cached_peer{,_allow_dgram}: those fields were an
+	 * unsynchronized check-then-set shared between the lockless receive
+	 * tasklet and the lock_sock() send path, which could return a stale
+	 * 'allow' for a restricted peer.
+	 */
+	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
+	    (vmci_context_get_priv_flags(peer_cid) &
+	     VMCI_PRIVILEGE_FLAG_RESTRICTED))
+		return false;
+
+	return true;
 }
 
 static int
