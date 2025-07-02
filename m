Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F79288CA1;
	Wed,  2 Jul 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463536; cv=none; b=FcXG08QmKe+7NDpV/gE8icR+GQVtnYUKmernI7VpZkrwdtmaW5sHqzmiBuL6IzwF6IUIYjXWgXxUXRBjb8w0u8XC18jJzQpuuuo5J0djyoa9nC/RBcdLql4uzWIKto9f4/ffrR0rzkz2TPxh4tqELcu11AViY9bIEs1MuWNMCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463536; c=relaxed/simple;
	bh=ajLG02yi+ttHchLtbL7gZ22RqiGskqK0Alx3czSX0yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oevCNWOWArd6RD4USlhP19KIHK1YqcLHyUackfksOy4Wc0b2iw8XtJvUPkX1Ecj6bGJMMJBCGPoy+tzRhfXOzMiP8ti4/MxgYzXC19EBEGlYEc7yNRRt2mVU51+GJA4WJoP4EQpGXlfP28fSNgsCeMx97ELe/p4QCK5q2SzAWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=llNjzvhM; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="llNjzvhM"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfp-00GxRq-FT; Wed, 02 Jul 2025 15:38:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=32SZ/8kTDsVrpAS16u/KNOvN+G7U0kqiaAdXc6L1eMA=; b=llNjzvhMtz51MMP245f7eRuKxH
	0rxItQGcu31Efb0pxWL5cmGh2Zh6Z4vYHXFuoMGSbZoOII42lgLFxCiyhKaxQLLyRvD2+yF/KJDel
	9+AHduuAce8VIR41AQGTEQrSgEeJd+Lwxb0fwFbOaAxBxxJuQ//6qiI4dRzLhndiL7U/FCuecPBR9
	F6SnUokZCBApdWFpNbNAblwk1Bvhyz9luqWGkZyZIAEEfOahFXwwSEm8snd5f5tPBradc9uSTV3sG
	Tva01zYEPjVidyMLsKlLim/rHNBbiAvOY2la7nFIY/0LMOp6Smae1JSXJco1iktls+2tsyYyjGnmB
	Zq2fCCjQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfp-0005HX-2e; Wed, 02 Jul 2025 15:38:53 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfn-009LQl-Aj; Wed, 02 Jul 2025 15:38:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:45 +0200
Subject: [PATCH net v3 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to
 check also `transport_local`
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-vsock-transports-toctou-v3-3-0a7e2e692987@rbox.co>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
In-Reply-To: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Support returning VMADDR_CID_LOCAL in case no other vsock transport is
available.

Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b2af5c63f7c2ae575c160415bd77208a3980835..c8398f9cec5296e07395df8e7ad0f52b8ceb65d5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2581,6 +2581,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
 		cid = vsock_registered_transport_cid(&transport_g2h);
 		if (cid == VMADDR_CID_ANY)
 			cid = vsock_registered_transport_cid(&transport_h2g);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_registered_transport_cid(&transport_local);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;

-- 
2.49.0

