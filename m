Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908124DCF9;
	Mon,  5 Oct 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791161020; cv=none; b=r79q3Z5CkJ+xt/WZ4EO1no6Ma/HZA8W0y1ODnClMRl5T2rYOdhehth7CIbvxsl4Qy0NPB8m+gKth2GaE5o1GdRXu0FagBiR9Su8BT4T5CJh6KkTH188/CeRsnD+yZPny8rkGLhAe4Ied8KSH0jqMFMk3QarD+q7uHEiXkZmTejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791161020; c=relaxed/simple;
	bh=KvqnzX9smOrBIuSz6S0KV5qNfps2KgiMoCIUcNnSKfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SPx9VIJT++91UzDk1IxCHax1IeDEbdIPUVxvAhgpJNSpJbRyAgRsjw/LR5Y9a0ctMZkKAeaexdmPfLtic+SG6Y5dFHaLUk+8C4gdyfk23Nrjkj/33f0jmVftamM4cE98hP1rU2YhEs6017l8KlNZRKIVnxH5IJOpBYEUK/jwXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Z7atUyWx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Z7atUyWx"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xDWXr-00BHFF-MA; Mon, 05 Oct 2026 02:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=tVlV4UZqBeeHCemy5wFEoi/THPCJIIEMwXyBJC+bMPE=
	; b=Z7atUyWxs5JfbQi/nqiCSUIJ6YOxs8WMjld/7o6oJCE8jD2xrCbuNmvcprOryv8UR3SCjSgKa
	ekqXteYyA9AhQSKjtaQy8SxY8zEjFkLUTZCovQr2lm4WiB5YDMM3l5JRPucjMrenlX+X8qDcBulBB
	YpVEWfQffAyfgNmDcjFFfQStfF/uK1W4tWBriNdZSIlbQKzzC1kc4ClNGViJNJIjFJ9MikFo6REVc
	OBCTAlxQoA8drAM1LHYBapBIwHzRXlfCKqWrJpHmO/UXN4E8t4G9A/Aj6hAdq9u1b7mRsCeRPMx9D
	8HL9SC6lBv3PTQO3Hb35Ou5LFiB5RtpxPUL9LQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xDWXg-0004tt-NY; Mon, 05 Oct 2026 02:26:57 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xDWXK-00AQqX-Uv;
	Mon, 05 Oct 2026 02:26:35 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v4] vsock: fix connect() races
Date: Mon, 05 Oct 2026 02:26:21 +0200
Message-Id: <20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QwY4CIQwG4FcxnO0G6iiwp32PjYcBirJrYAMj0
 Zh5d5E9qJc5tmm/v+mNFcqBCvtc3VimGkpIsRXDesXscYwHguBazZDjjivkUEuyv2BTjGQnyFR
 oAntKJcQDaOUcKrnTTnrWhL9MPly6/s0iTWz/3yxn89O2H+5j7BjKlPK131BFH+5xmuvFuCpAw
 JajVkZb643/yiZdPmzqORVfJLFdlhA4jMLp0ZhBopfv0uZFQlyWNk2SSnNp2re4G57SPM93czv
 fXW8BAAA=
X-Change-ID: 20260820-vsock-connect-reset-closing-98dd28769d7f
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hyunwoo Kim <imv4bel@gmail.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Handle a racy socket change in connect(). This iteration focuses on a
single issue and aims for minimal changes.

I'm keeping this as a 1-patch series so as not to confuse the patchwork.

---
Changes in v4:
- Defer all other patches to net-next (Stefano)
- Link to v3: https://patch.msgid.link/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co

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
Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

 net/vmw_vsock/af_vsock.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)
---
base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
change-id: 20260820-vsock-connect-reset-closing-98dd28769d7f

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

