Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145F366055
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821141; cv=none; b=SBsoFEetiRZTr7HYQAWDRpgx6zzUVDMfPfql0Z2WPAaMEeYiQ9uuQQtbfh7d0Z2vax6OoI276pweCnQBK8S98VxGrCAj//I1zN3lfIqIzctC4kch1orW3Ag1epizny0HKyJAMWjh/PApjeiRXiCgzdhK9n1Dn2z43PgCq377Drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821141; c=relaxed/simple;
	bh=ohMLhoHsIhyrQR++saiVhSXMuKOsrbcqrQpd5HS7woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNjiidK+hMPo2N5cB6cyRP3Qzq5DKxzgUS81nw+pAhZb8wlR5qV7twSyDhTLOdBhA+2WL76Vfl0L3+O+PObDqsSD2tF+k4YRs46vAV3/KCYNi1cm9QGV/X+Es5xmzAjSJ9o23Ja5Te8BhJ6YZ47o2x0Eqhj5Hr+H9k3rj2Dn5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=Wv9SuH9G; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="Wv9SuH9G"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso13230125e9.3
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789821138; x=1790425938; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UwlcS9+bFUXKkO5ovoMUYQeBuvELj6Lvx0WboaUWawc=;
        b=Wv9SuH9GfJGsDpI6fqXL3IYsvOPUpyl0I3GbHAMRFFq7jYdLxvOxUSZZlh1EH4OtaI
         8+w/1cgst4985b+hLomvg8M8M8QOkcuVZGezUho4+lKLGAF+YyUqhbMIB2XBZ1fSWyDj
         QHm5X6C5mc/l3Do2MKwtldYHMPgRFi2DjsAIxXNDQyb4G+3Qc6MUpHrm0rDX4mvEZVx3
         1yhI9Qvhfbyny/cnyiiHKIoz3M39Bq1xliwZfQ9PneNEXqgYHiaigmqP8cUyiivCuDp8
         7db2WmdXszFhNa1ZKzyeExMQxeyYxxFMqeFfI59InUtBlwXT1WiHKDi7Z0EaYJIE3PoK
         CbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789821138; x=1790425938;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UwlcS9+bFUXKkO5ovoMUYQeBuvELj6Lvx0WboaUWawc=;
        b=lqK2GHrXd7v2RiVb9/VrwuuzkUxpopLY9wLWOi1sH/AYqv72SqqVulaEI+wEqHQgT8
         qLuNGXICmC82jEn1gnuQVHLbQuTgp2kiGYf0hOPxSkVYbFKuLTGWjJ7f6x8oApuf90tN
         9TbvXyra6KVT+D9wUXn2NZG9RrXz2PmPUvZrdabF92ZY4g9dW9u8KbEg54i5GhAx2aCh
         znaG2VCJwpMH5zizEIZNMGaSzyonQgGbK2aXIYP6rH2CkCLyIuAM/q8d+v3VQUql03CK
         lOyzXlaGQNplhqhRL7iyr1vgH5rz4oMiIYP27eF7vKVHva4MEBBqUMrou1soEIZ+vewr
         e8HA==
X-Forwarded-Encrypted: i=1; AKwUvBzZrgCGq0DrO+X2eMph1MJQloLi93Z0CEC3wh9inTKWt0ORYp/Imy5RHoMkSOCbVkeAtHROLbN5cJw9WnDL0g==@lists.linux.dev
X-Gm-Message-State: AFuF++mTbJZaFfGzI3Os/FdKHysQ5s1qdZSZN7+wraAbh/f/MtRBPHWZ
	BVD3Drj7yReY/3wDSWNDQp+t7VUk5iz6eswcedQ282zAn6Ru4rQfxEtosrg8ctdmNeQ=
X-Gm-Gg: AYBFou0SFeVpgub6uj3kqmjtctv0aMVQ1LP1UK2tnT6DxzYT21eR4R3p/NFzVG0tr24
	zbL+UhDt5AlZibPGTNdDWRm1q2ZDtZxCHjhWDNICDwa/sMz/4cK/9Bdh3j648kPlOmw15LNtrlq
	FsdXjpPFEL80RdA/A6RxgSvrOSmqu0AHBDV1vPePJYM6wKEtJnKzfu4jmo57j64Xl4W9Qv6Z2pd
	bh9XJ2DHyefblEFJYcnxRV6Jrf4uPIcS2n+tJBWKaMJYzX+Jk98JOdIlKMawzqDeccMq2z4tkAX
	Mi1ROk+kur6TQ+YuL5vkKCCdM8INrZgYnalzenLlAOzQ8QRh7mtjVo7d4L+h1OSoRcWOC5jKfPd
	plW5hSb/8qTRKpEkr3OTMvqJZrD647V4ya3C2nzrHANW7rsYKxhr+tb0Rfoi5L8m6KdGL3moI8g
	bh+FyZ1jbsRAgXJUFlJ5XHHkaWP08XALfuWNOk42xB4qmcoWSXRqXWJs3GwDV3lsCjhbn3dw4RE
	Wx7VS8D7t+DpsjLOTQBq52xf93lS1CN+LXcLBmX3/TDA/U=
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr67615405e9.23.1789821138247;
        Sat, 19 Sep 2026 05:32:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcd8:ca10:f229:8aed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd10d21asm88593265e9.12.2026.09.19.05.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 05:32:18 -0700 (PDT)
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
Subject: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the datagram receive path
Date: Sat, 19 Sep 2026 14:31:57 +0200
Message-ID: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The send hook vmci_transport_dgram_allow() refuses datagrams when the socket's
netns is not in global mode (vsock_net_mode_global()), but the receive path
(vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not, so a
socket bound in a non-global (local) netns received datagrams from peers it
could never send to, defeating namespace isolation.

Add the check at the start of the receive decision, before the
VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
(matching the send side).

This was found by code inspection; I do not have VMCI hardware to test on
(compile-tested only).

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
Assisted-by: Claude (Anthropic)
---
v2: perform the netns check first (before the hypervisor early return) so
    hypervisor datagrams are also gated in local mode -- the Sashiko AI review
    noted v1 left that path partially bypassed.
v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -532,6 +532,14 @@
 static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
 {
 	u64 access;
+
+	/* Enforce the per-netns mode first, symmetrically with the send hook
+	 * vmci_transport_dgram_allow(): a socket in a non-global (local) netns
+	 * must not receive datagrams it could never send (this also covers the
+	 * hypervisor CID).
+	 */
+	if (!vsock_net_mode_global(vsock))
+		return false;
 
 	if (VMADDR_CID_HYPERVISOR == peer_cid)
 		return true;
