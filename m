Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707C1D9A5D
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754367481; cv=none; b=ETbuvT3VLFNUbdt1/yq/bHse2yQ/utEqC8SugNAur6xptAA+FG7Pb1uP2BsVUwZu1Kmyh2lcpKs20ugYxOn3B0crONlZRGy3f5Zq/raRHvk9qgvUMwGf/Lno7RpIvXDhITGquFq8pRQd+KVBT+rsqAwYNdmVrX/MgkW+DbZp64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754367481; c=relaxed/simple;
	bh=YESv702JDbfuSthWoc91HVirrnAcbw2WvyWffAxBVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dX6t91k6wxcmD9Isie5luNwoYrCpHaY8CFIylT8/qDmF1uJzoDdiBoyKyQ9HwswtBY994OwA8fcvWkUbfN7axvmJy6DHpYSf0XnE+TFwozqFsM3GtzeBJXhTR43Sf9poj/5LPnEJ1kZALqFlEDxSKkFL0TRP85xRS6pSeE4vEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8e+CR8i; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8e+CR8i"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so5145819b3a.0
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754367479; x=1754972279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0wU102dcRZfX7qHNlGDp27YpvbTW8OMK3j2nigPqDs=;
        b=m8e+CR8imt5mKbROAMkrWtJs9vWDDJOFnn15B79I7VDTNLi7KqDzioETURferC85Zs
         Xfcg2CCgC3SAYPOxz4eI7RmO1IKNqh7JpDYlCpkf3S8v9bNxMn0XymsN4LDMxBjSqOdO
         4PnoRRy6ZRuoHG7evbcjty1z7Bax2efxPGJTd7p1RPPS4/cAtNIro+vDZqUxPrE9lO3w
         wJhC8iAUC7wOgyZCJmjuqQnGqfhVeFY6sXWX3KPCU218602AXxCyNXJCRLLZVX6bSX4j
         +OvmeCfls+7f4DIWwowskEQLNXSj+Ah6tnGXjgx+/jlnukqRzG8WV+XBnQYga/h+pTBK
         kMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754367479; x=1754972279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0wU102dcRZfX7qHNlGDp27YpvbTW8OMK3j2nigPqDs=;
        b=LA6FSCQtUI70YzQGv/tLoNcYdjxsZR8V2vx6zWdu/rjFIi33dVzMkEQ9zdQO7Ceal/
         Ev+1AhciSuR7SwbWXaKfFeLn5jVzJag1H/JKFjLSgkseScchzWvj7B99f4Hj9ky1mLlp
         qzKYCphsTMMizmlJY+lQRCx0i24b5v+ZUI0xmCri1aY5ut918S+A6hrVZ0K/WXANGNvq
         rpZ0PcaRY9NoehSNiNZGD+GWuNq4QgMROD3H7i6QpGfG9ocnFDVlh0hGtdI0ZT6ZwRk3
         VNS3eHwS32m5zOdcKmTpsgDYkPOa0V8ZMHvJm31xDeY0dP8sTA/k+7oju3bB9TnwY1Z2
         VnSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxqlhagJyyA76AAGb1q4M2gwettJakO3afAqUutwXSnQQ3+5VfY1BqBlCH97FXkA6qGvFIaUUmQMHH+emMWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCZzYh1UVSPc3kPuylsr47/ZCB3zrvgwhbH/MhqH7ruyeCB+DX
	/TzvFRU35ME4VD/9HvPYF1f1otoY757gRP9H8aqUAB5Z7fai2BAKMXF7
X-Gm-Gg: ASbGncufkHddP5Gbnm2dLQ+gHUO3tejVz18riLYJedc+MkAWjEyF3z58v2bMfQWkZic
	so0YizZDVDAKGfhZSc2ZWVRVwheDWOZx5IG1QhmtiGHdRSmVR7SrYDj+Lrjk+kj76YRuFPCkSZ+
	qGvNnCdEDtwiT16wEV93/rQdlUte/WtU+6tAYUPsBKF37csWXY2rCinxzoFN58f7SWnjGg+J6nZ
	Ddb3/CL14ssr8bhz7Gn7MKMNvQwFM1qeRiP1roaWvA/ZDIPjp9yRr/nFlRovSHppJ36mWucwGjY
	Kv4Qna9w6JGHboLmSXkF+DB5hFFzlooSKMisoSYyn046nix/WceoIys8zrD+0zkwJrvKPqV0kIB
	FyzXKakfN10+CNPs1OfKeZTjDmr46gC81mlzkQCWWs0mJ7cTCq47EXzwXjtWh
X-Google-Smtp-Source: AGHT+IHoPmZlrFSS3ycNX4xvQ7lUBJMXu1HMxEtJCBju7H0F4ElNjmffdcrUE0pi5UqPODbv2+Z6vA==
X-Received: by 2002:a05:6a00:a21:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-76bec311399mr16066330b3a.4.1754367479074;
        Mon, 04 Aug 2025 21:17:59 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe3199sm11680521b3a.115.2025.08.04.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 21:17:58 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH] VSOCK: fix Integer Overflow in vmci_transport_recv_dgram_cb()
Date: Tue,  5 Aug 2025 12:17:48 +0800
Message-ID: <20250805041748.1728098-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

The vulnerability is triggered when processing a malicious VMCI datagram
with an extremely large `payload_size` value. The attack path is:

1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
   to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
   vmci_datagram, payload) + 1`)
2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
   `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
   payload) + dg->payload_size`
3. Integer overflow occurs during this addition, making `size` smaller
   than the actual datagram size

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..07079669dd09 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
+	/* Validate payload size to prevent integer overflow */
+	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
+		return VMCI_ERROR_INVALID_ARGS;
+
 	size = VMCI_DG_SIZE(dg);
 
 	/* Attach the packet to the socket's receive queue as an sk_buff. */
-- 
2.41.3

