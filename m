Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA0219E8C;
	Mon, 29 Dec 2025 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037417; cv=none; b=UrwWTC+hH7Dpm8nsa8kKgaH4MM6EhA+MjadNIyH0V7C/EKXPu5ek4hvopObIjgOhGYlsX/0q7+a9iLN8Qbmz8jd2yViD3a6pcNycu/82zSSfmfG2iE/xi4/kYgsfRoYXv16jD5aBSY4pugZmZkAmXLHGxv8Sj19DRbF0K+H2VgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037417; c=relaxed/simple;
	bh=cJnrWkTrM9BqnF980ApPVLsFX3lGeVXOMLICrOdkQgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsdkWZ2DdjKPAasqbwj+dqRyuwlrDJJBIjyl8OccKkK408+mcJ92dmyeuZX+DtCIhZgDpp4FujvkiH8mER3r5ZO9eVjWS1kiUnVAeTmYC9ZseYivWmXTlqr8HeRH9WoBH85vMVOuALfQm6lfnrISU/Fy+n1xvAQVgOe3E0vg+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ACkCnhKq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ACkCnhKq"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9Q-00DYtm-Pj; Mon, 29 Dec 2025 20:43:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=LxJRcNt1H3n/G01g5/IvxN20LnKqGALHfiDAONsEvug=; b=ACkCnhKq8dcz0n5lNUmJvefVok
	7VGkCyapgxh9c7zFhhDfTFO12Bx0Lpjn2h8Jo9htkAvi9e4fFIAQ0wzCkJKsGakJJ92/Q6zBIpFQk
	BWjf506L6QpPSiysXPmyCxIOqy43CdQwwwKso8yTPFG6oaQ3tUO1Q2FFG2rgdpKPArFCKpizTy9dG
	ne07KumHj1dgi19wSkSTi8KtkL8UZRxmGow1XRVsjtKK+QlJQSeEngrJ9dfN6WxEPo84yyBtNN5Aj
	ZamwpAGwKFRMLPhnvd4SS8TCuI5U2vAK3ywmYJ6SUgJBnEa/ZwTxh3u9kUAVz6K3FgAb0OamlV0e5
	wa5U+++Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9Q-0000NL-FP; Mon, 29 Dec 2025 20:43:32 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJ99-0055FL-F0; Mon, 29 Dec 2025 20:43:15 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 29 Dec 2025 20:43:10 +0100
Subject: [PATCH net v2 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-vsock-child-sock-custom-sockopt-v2-1-64778d6c4f88@rbox.co>
References: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
In-Reply-To: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

SO_ZEROCOPY handling in vsock_connectible_setsockopt() does not get called
on accept()ed sockets due to a missing flag. Flip it.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7bf74..a3505a4dcee0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1787,6 +1787,10 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		} else {
 			newsock->state = SS_CONNECTED;
 			sock_graft(connected, newsock);
+
+			set_bit(SOCK_CUSTOM_SOCKOPT,
+				&connected->sk_socket->flags);
+
 			if (vsock_msgzerocopy_allow(vconnected->transport))
 				set_bit(SOCK_SUPPORT_ZC,
 					&connected->sk_socket->flags);

-- 
2.52.0

