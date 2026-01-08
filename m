Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946E438390;
	Thu,  8 Jan 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866151; cv=none; b=eG8w4/1Bgi6K1fqQV2KdrgC9xpSbsdXTbAl31kDQDZwZqKVGNPq4x1w1pzqt+nmaBeLU1vlkXHBQfEcH+VozbNVFH+u0i26sVikEdvKVp3GhWscrnT3HzmP6aNriswPcri8wuipfP5W/faN8wQ/OatVYfVdpQtvMBkm3ChQYUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866151; c=relaxed/simple;
	bh=EvIONFN7UXUZL6xMVob3uUTPUEaNiM+IyoWJle+1bRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZcVijksr10XdlxkgZKf9/CL2+ZIP8kn4LgMJRDdKrf+A/O1cM4OF2pWVynGkrGLi+OaK77ARTD8U/V2sqv0nV8Up23YPHwYS1clNkykhqv02ag5J0tQNiUph3IFKwWxk2IO2YVhSj8LFHKDRwHv8smYobfuRs4Dm8BeOhOZb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LuUrR0+l; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LuUrR0+l"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vdmjp-0000fS-Tv; Thu, 08 Jan 2026 10:55:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=P3hj6q3gjtPJPbpzzaDTeFeR0mK65piI4fXLK4GYSOQ=
	; b=LuUrR0+lSF0ZCpK1mRKfpcF4cGx437j9yQIJ4UtNCEm+N1wGJBkFpxCXsSioHem2HL0kFObR2
	SP6J1TDsKIi9NFtUUZn7IVD3KVgT5ZJnVyEM9zgFY6Wc5lLVd0UxAf1ehejI1csLtXtLlSi8eBdKN
	VP8BbxqrsWTBCjQgzyppdVCtU41LoKdH7J1ArrEh/LuUThOp8pKQL11RmzBZXP2NBgia28s6CJNzv
	CfTOG3SEHmOKWkDOHOSVZi4VwoYoYUy0o30lMSwFWwLXBJBhnoOBaTYUzlQTxRpWbOSnqcifjA61/
	kcYeKOOqaMZJowzU2+SiBRvtUnZRtcTwhP6JIA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vdmjp-0000fD-8A; Thu, 08 Jan 2026 10:55:29 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vdmjY-00AchK-Rh; Thu, 08 Jan 2026 10:55:12 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 0/2] vsock/virtio: Fix data loss/disclosure due to joining
 of non-linear skb in RX queue
Date: Thu, 08 Jan 2026 10:54:53 +0100
Message-Id: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO1+X2kC/x3MQQqDMBBG4avIrB1IFFrxKqWLMP5ph5ZEMhAEy
 d0NLr/FeycZisJoHU4qqGqaU4cfB5JvSB+wbt00uenhvJu5WpYfF0hlyeEPEyQBz4t/LjHEzTu
 hHu8FUY97/Hq3dgFpg+z3aAAAAA==
X-Change-ID: 20260103-vsock-recv-coalescence-38178fafd10c
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Loopback transport coalesces some skbs too eagerly. Handling a zerocopy
(non-linear) skb as a linear one leads to skb data loss and kernel memory
disclosure.

Plug the loss/leak by allowing only linear skb join. Provide a test.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      vsock/virtio: Coalesce only linear skb
      vsock/test: Add test for a linear and non-linear skb getting coalesced

 net/vmw_vsock/virtio_transport_common.c   |  3 +-
 tools/testing/vsock/vsock_test.c          |  5 +++
 tools/testing/vsock/vsock_test_zerocopy.c | 67 +++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
 4 files changed, 77 insertions(+), 1 deletion(-)
---
base-commit: 653267321f05316f159e05b3ef562aa700632db6
change-id: 20260103-vsock-recv-coalescence-38178fafd10c

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>

