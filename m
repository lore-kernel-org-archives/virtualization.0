Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AF560AA4;
	Tue, 22 Sep 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082973; cv=none; b=dTVPxpSQxhZRdwns7RV8rlh4CVEup1tW6T/jOYL9dEZKetVMteex9aRIAJ/GO1RObqjE8kqWXlo90ybhWmijPBXb3TtnS4Ms3J0ZT5UK5JbWz84C1BGj0h0tHfvVYtFiZ9Cr2Dgq/NkJOr5Ca2b2PUA/rWau2Z20xm8vGaBef7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082973; c=relaxed/simple;
	bh=COxZrODMiG7wpwflNvDJFwyGJhZfUhncxZCYcHISVNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnQ85nWKu52bkvFk0GVFNpLukUOgOOZQPHKYWBVXypQkD5R5zUi3o0loWF6o8I8+z44qbVNAZIhtIDdDzUHlH/m3CSQxVS9vzVwlovljDIp/FGUo/mUoBEGwYHMw8vrVdEVRgOcY73zvszwSXubu4rW6c5Jw8D/An+U8ih9Is3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=nk+X5nxP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="nk+X5nxP"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LK-0038Pu-QK; Tue, 22 Sep 2026 15:15:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=h3c4JhoACmkDINEFsPgIY9AtPg/o1ylbFwdojB2jwYs=; b=nk+X5nxPTjjrwGFmtFlogUDUfW
	qFG9NvJ1BWKIU4T7xA4uOTGkKeus8B9UA7Z+vUYlP/0xxO5XwrwySVa/UQhaarG52iNUFK9wj0uRz
	8vnWp2jr6L59GELRCThq8/CauIxkrA2JESra56h0QF69DR98NYHN3TdIkk6kn/dM96ALyiqz/ozse
	4Z0QwtB1AmIKKncIWU0d3JI7G7bOuTpKZopx9Aw+RM+NjdyWwv4liqI4IEAhbLJeEDoL+2yRU8Uo7
	fc28cjImFVk3abQJIaKWomTlSDlvFUTXMLAf9fZM2VQAPGqQ5Br48ibYX0XRkuiI6YvSvfyhWP9za
	C7eTT0gA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LC-0006N5-S1; Tue, 22 Sep 2026 15:15:25 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L0-00FyKH-EN;
	Tue, 22 Sep 2026 15:15:10 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:14:56 +0200
Subject: [PATCH net v3 2/8] vsock: simplify error check condition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
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
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

On success, vsock_assign_transport() ensures transport != NULL.
Drop the redundant check.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b71479a2b29..5c8e7e7d35b4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1757,8 +1757,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		/* The hypervisor and well-known contexts do not have socket
 		 * endpoints.
 		 */
-		if (!transport ||
-		    !transport->stream_allow(vsk, remote_addr->svm_cid,
+		if (!transport->stream_allow(vsk, remote_addr->svm_cid,
 					     remote_addr->svm_port)) {
 			err = -ENETUNREACH;
 			goto out;

-- 
2.55.0

