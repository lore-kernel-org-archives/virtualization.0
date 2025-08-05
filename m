Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DF2BD016
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430567; cv=none; b=Ul4IcY9gHqIJ7CK9ermQ9q5oDR1jyfChV0UUlia/1rCNU3nZsjJtSAA9xKgjsg2vR5LqygqtDukfkPthQSYKwfn7wy5Y7DhRNPKFBdPSIXlClGiFW3RoZ+GQRA9M5c1QNtUPViIMfU9uwDSNmgaCTnho3HccsTWsHBCP8cFwUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430567; c=relaxed/simple;
	bh=P1/qaJCybjcXSEfP6RGJaoK9v8utpfUNtngCHpZIML8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qD7VesTm4HOEhus0/37yxcqBkSOBhgon0tiegln/9Yl4VjhKZLEAu9E2Er9B/q3dI3HhTBhHp2TXG6DRHhyZJfuR1BexMRADZz82ZSPAZtmdH6TYXO5VACQOlVYKrW1xBB4ShgBI9t+kM1oH76vg529/gyyHLJ1jMYoDyTWbRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDrCMFIo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDrCMFIo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23ffdea3575so34881245ad.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430565; x=1755035365; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWqr1u7R6aV4zTd/B0j1tkHJBdcxjwTrCzBwm4Fr1i8=;
        b=bDrCMFIofqq0LBUCU7sXf8VABKz1j5xMze5VOwtAEih3Jnh5vNvhHq82bvu+1M6Aii
         gEgp9DzuoMlze7s1VRaz+Y8AzIjo2rx4e+XgZNEbGMykQXqPz1byWdaXeuH2ObJC8dMx
         g6uU1jq3P/bdnvJjFAAGHv42f2slnOh1bf7XmVgHNpwEaFd8fDyXb+pB2QN9JrQUfxYU
         631Jg2aobIaVEwBxFODw32Cxa3dudL65wNOQUALjuDW3Buju/QVHNjO1dPb6ECtVhA7T
         2BPr7ZDUWj92y/QsDX+XlHFWcuYkztHNesxTgR/WTJVITQFfjQHcZF0N8xCDanF0VKDb
         ddvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430565; x=1755035365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWqr1u7R6aV4zTd/B0j1tkHJBdcxjwTrCzBwm4Fr1i8=;
        b=jchZ+cbDETzLe62yl8nmPB8hO9q9DknwFqTkxc8K/+uDMyzWS9PZRt42ofRN+ZOH7e
         zQYxe9IUROxILM6fSvPUHy6DNHSiXQ/8mdpQWD1MxRkTqRLh29FWSdAYt/a9a0EYRrZG
         pbuQdUrt3r/g36R4jr0r01WZK0jP/j3hTKY9XDFl5yAxeE2u+xEHBZS8AFbBBTh2RpN+
         HboFh3TPdp78v93IYhPn0xd+Po7BSpFEZQcgY3BTjwDm6fkvMBaWAIpODuOC8Bzo95ZT
         iE50yNr8RZbS+L0u0HDf+OBeQavKEhND5aDDarVUYTqKGPwNGrn0E6mayyJdZ754Geo/
         1X8Q==
X-Gm-Message-State: AOJu0YwLEqiI7MgK+DJM8Ey8G37a9bqRfnKpt3rWnJPom05seaondyRs
	tAWCMGRtB3cauDqKw2J3VPg538KXz4KVp65y+5CfH2ZG7aaDV13/2HcT
X-Gm-Gg: ASbGncsqRWt5ydLk+tE0sNLfhnPVR7K8S8fuUN9oDrwFY4MoMTdIt5lOOerqC6bfJss
	5FPZJRiXyO0sZSUBJHMHFhEWG4MsDe2dLZK08/IynMgZiEFqXIz2QfLxGt8l3P7Yjn4q1JOX0Sb
	yn3vFTiQnT79B8dLjANQSs+ybzi+TWne81seyKS+jFZxe3lDXU5OZPITrlfFopkbXJtCAcBZmnu
	OGeH3BKZrvXAQhn+mwcG2Lb8mt4OxMi749tPs89jLnfWpUhyZXpVnBH0ELNzLBCjXg4X3vbkAxV
	OwCAhK2Qf5EMizhYk/TvUovcG8pHMvMTGpRa9x8sqbewHbUN7yyPPH0864jRyTxtfnPQmqQBUjC
	kkLImQdhzoAoSDO6Arhhj
X-Google-Smtp-Source: AGHT+IF9PY4f57pByyzJj+B/qQvdtKhfo8+NygbXA2dkub9dCFAKHMnBQ4/xzUnOCuyFm/MQwZFvxw==
X-Received: by 2002:a17:902:ce0b:b0:240:3e73:6df with SMTP id d9443c01a7336-242a0aa3352mr2595325ad.14.1754430565561;
        Tue, 05 Aug 2025 14:49:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a11sm142925745ad.86.2025.08.05.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:16 -0700
Subject: [PATCH RFC net-next v4 08/12] vsock/vmci: add netns hooks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-8-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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
index 7eccd6708d66..3c434ee3ca8c 100644
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
2.47.3

