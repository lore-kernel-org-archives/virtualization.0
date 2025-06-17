Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29825C6EF
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134791; cv=none; b=HpnV2rw7KkvMI1dUMv56Qh/HVd+WAuCuYQ7ohYZBOFHxBNq6inpgcmqvDS4pRhuEp3nS87aSCmscxX7pMmBANSymWHpGeKZn3asqdYPN8mzEKWIf1ohLP2ZEhnpO/i/jtnyNNycJZD/9y8DCFszDTFvTKjEnLQoyGnNILvwahkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134791; c=relaxed/simple;
	bh=+t28P7IfMd6Z3qkHyejEJg2X1cP76IfrOfkKHb23b4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOauroyDcSfFr2Dda9sC1OMPVpxMtCWjMJWYYUfTBQq0UEp3rDBNnr1X4fZL6S6JPR4m1dqPId6EEDF8Kp1UEavUi+hDDtOEwZHSEmEAtv204Nc+McMouFBXFCguJVIoMz+9ZLFQCKF9DzpfQBGeUCjRK0RQ0NCBFWj1dcG5usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4V3FahB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4V3FahB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so4947098a91.1
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134789; x=1750739589; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfX6aOsHYzp8OvVtnsleRNNoqy1TSXcylauBeBxQCfM=;
        b=B4V3FahBz+oglIN6jLbUFsaCBpmsrPDC7gJ3vVNjyNO1GaYo7TZlcJhJSIhCk1XA6T
         NO7pGxs8C0JpLs/PR+kEYLHz/nC5sY9oxJac4eBxIEC7MCFmSWztGQg1Pr3uDKINYrxN
         B+SW/qV1bkSJ5jefCBAOH03F2Yvyd9UOBPG1QsHEK5KfAo8V8yeAdMwSKm52T6CPap4M
         ECMTHPjoodCWivjBVRrcrT7iqFkfGMfF3zgIBaO3F7enlFwWa/4ONSRfT8zxEHLYc3p3
         WatUqrE/WHxiPeYNhF90tjRmTSO8hK28jmmxJ4ox+yXCm4JZolfROAi6I71I1xF7ARHP
         CztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134789; x=1750739589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfX6aOsHYzp8OvVtnsleRNNoqy1TSXcylauBeBxQCfM=;
        b=lwoTpNBC0eu7dF0p+5IHdCFwpUulXI/18SjIxneEZI0A0Lkc/kBMJeEG0/l4QN5NBQ
         vkxbRk9hqX42GE3ewi6U14hDygryGkW5t9nl/Vd5ohRJt4Hb+GhlHD2LobiGagA9FrOI
         hjHqTs2SilY9kfP9bktALhisE7MH68MPABA1aG8s5Pw3x1y/TXOEHng1Iezfbmq6xRKJ
         jkRXCJOtcnd0OOJL9m0Ev2jxs7aN93XSd1lYOJJO77oqWL//sZjbcEg+CwUGzpTYzIqz
         /JZFRKUD2dQRoQ78ohAANit1UDKrqrIJpdmP+/JXRTPPxsTcJTboLA2edO3UjU8Q7zkr
         +a5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhah2/9sWBE1j2CeOmDnxdm6xVjIZN70GO03l8DEh9BpXLSmpIbNJ/sjiWAxfgZNLnZukc9c5m4YnWK/DiAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxId4QuAUy2gC01fixFuIERD/L9vj02w66tWH/20uVCLK997Yxp
	UokFcwO86GQU64bWR6tU+TbVpLcVi1w0BYGhM1MnurLQHhxueRpG6fdXfIlX1qAl
X-Gm-Gg: ASbGnctTWkkxzmr8H9Ol9/lfpXOn2wXCIyNCxdj9huE8lZyywhMoneeEKePzChIO4uc
	BeumNnuHIkAJJ+jNDJV4m0uKmAdxTJwOoJxEs0lF+ypf62y8ckUQZeLfus7RW5u9v4q6ErGeJl+
	bn8SGeKlEVxJCTjooUT+CthY+Da7NWgcH1sTJs61WUK9lj8aWkZJPkBfyOKfTn8TO/qCEx5PuGx
	IB35hyzVJ8FSisoXo3hC4SZHW3g1m98uKK6m1/TUtpJMssI89uMxphy8GmSKPwqcp82fKi2fenD
	T2bpn/H2c6IVzDs78K6wKstXNujQKbYcmQlGsbbF7S4X4eDJkTsfTp+qLIPsG7Hxeto=
X-Google-Smtp-Source: AGHT+IHnlb+3zl8t+M0JYb3T3mvJO36gRS/DjbaA/k1lUw1YbdWzxTO9ao8p51vZKxNJED/Jx4OQ8Q==
X-Received: by 2002:a17:90b:53c5:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-313f1daa7b4mr16313306a91.19.1750134789555;
        Mon, 16 Jun 2025 21:33:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6a80bsm9566197a91.44.2025.06.16.21.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:59 -0700
Subject: [PATCH RFC net-next v4 10/11] vsock/vmci: add netns hooks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-10-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add hooks for new internal NS calls to avoid breaking vmci. Guest vsocks
remain in global mode namespaces, so behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..8f374f84a526 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -703,9 +703,9 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
 	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
 
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket(&src, &dst, vsock_global_net());
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket(&dst, vsock_global_net());
 		if (!sk) {
 			/* We could not find a socket for this specified
 			 * address.  If this packet is a RST, we just drop it.

-- 
2.47.1

