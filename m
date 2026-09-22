Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98167550DB8;
	Tue, 22 Sep 2026 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082944; cv=none; b=P+QOriRmDwDWIsmAii1VnjQiE20o2J/mrhTSr+K/T3ILkklKiyNm6uHJW3W7rQZJXyAmcy8Xz0xn6nG0ljZNpURojKKVk0QqDiwBxxjWymOdYt55rOI0T802R+/tu/Qy7mENrBHhjwXYrLQHujdgfaRms6l+T8SU+LyIv3iCUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082944; c=relaxed/simple;
	bh=ZDCR40yKL5XCrf0V+FJi1+aiP1h5FHiYOXyl6f+/hp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uzl352ZOTO7842+1wcOUmjwUsQX2TaJtz0tkfnhTyasWt3kf9DwUrTezYI1HxmVQHriKyZdVBKRuPFpdq5h/YrR9xIhnHUXgenAnqdRXYNW563ooiZFkbbc0EubkEfMv3SNNsX/kWE5e1ZJizOd3g55JZaua83bsMmGyM4vWel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=plnAxFgL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="plnAxFgL"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LP-005SGM-EV; Tue, 22 Sep 2026 15:15:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=+IgXeIL0AUjZTUPvow4tkW8FuGjOzP197qVmDY99XXQ=
	; b=plnAxFgLfuqrerbyNVc6KKMtEOr/1uiknlNtQAhZqKLBzu8aZVsaC2JpWAABIdZUOK0NCyAEN
	W63AEp7B70F7QaxE9VVO49lerWmZF4r2NMG1I6YmLUlRrF/mkhEO/IPBErHPjRjOfCacZGQ9zGIlB
	Y4PeYwVeEPdSYm7S/NKAqOQ13ztgzrJjWQObx0Sbey6Hs2M6qZC4HbvQWirXpZ4CWKLcMHzG40xNe
	bVUZ8XYlGBW6qRLng0sO1/y4HmzLacVhQW22b82VPjvXwtFw8WaJ0AdPglAQ5xnr4sj/BD/wTJpMU
	0LhPmQ/oyNuhTGCQSpNOPw7/NVs+l3jLm7+b0Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LJ-0006Qc-5B; Tue, 22 Sep 2026 15:15:30 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90Ky-00FyKH-Mb;
	Tue, 22 Sep 2026 15:15:08 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v3 0/8] vsock: fix connect() races
Date: Tue, 22 Sep 2026 15:14:54 +0200
Message-Id: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw7CIBBFf6Vh7RhA+8CV/2FcFBha1ICBSmqa/
 rstLnTV5Z3ce85MJGKwGMmpmEjAZKP1bgmHXUFU37oOweolE055RRtOIUWv7qC8c6gGCBhxAPX
 w0boORKM1b+pK6NqQhfAMaOyY6RficCDX7zG+5G1Zr9y11ts4+PDOPySWy1knqNjUJQYMSspFI
 4VSRppzkH7cK589if+RWLlN4kChZVq0Uh5rbuofaZ7nD86ZUYklAQAA
X-Change-ID: 20260820-vsock-connect-reset-closing-98dd28769d7f
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Hyunwoo Kim <imv4bel@gmail.com>
X-Mailer: b4 0.15.2

Handle racy socket changes in connect().

v3 is taking a different approach by turning transport assignment on its
head: instead of trying to preserve the transport between failed
connect()s, drop it from an _unconnected_ socket as soon as possible, i.e.
when something goes wrong with the init or binding, connection fails, time
outs or is interrupted by a signal. IOW, route the failure paths of
vsock_connect() and vsock_connect_timeout() through one point, replacing
the open coded state rollback. Starting from there, corner cases are
handled, invariant enforced.

What's perhaps more important, the bug fixes themselves do not touch the
driver code and do not introduce lockless writes.

---
Changes in v3:
- Change the transport assignment life cycle (Stafano)
- Expand comments (Stafano)
- CC: drop bouncing address
- Link to v2: https://patch.msgid.link/20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co

Changes in v2:
- CC: drop bouncing addresses
- Add more related fixes
- Handle ENOBUFS (Bobby)
- Consume sk_err (Stefano)
- Link to v1: https://patch.msgid.link/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co

---
Michal Luczaj (8):
      vhost/vsock: Fix socket state constant
      vsock: simplify error check condition
      vsock: do not preserve transport assignment
      vsock: drop the re-assignment logic
      vsock: treat TCP_CLOSING as once-established
      vsock: handle socket bricking due to transport event
      vsock: handle listen() racing connect()
      vsock: enforce no-transport invariant for TCP_LISTEN sockets

 drivers/vhost/vsock.c    |   2 +-
 net/vmw_vsock/af_vsock.c | 142 +++++++++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 62 deletions(-)
---
base-commit: 23d42b9a3bcd55b17d3b371544fedc708c2397e9
change-id: 20260820-vsock-connect-reset-closing-98dd28769d7f

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

