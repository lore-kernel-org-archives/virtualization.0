Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5D13C8FF
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370624; cv=none; b=F+/ibE06DkNc6i5QEDqTodPceMOOU/PvcCdva8ALK620YlcTLZ5Me5pJoKwYrwqNlY1A+M8jdk4i2grAOcuXsNYQGpC3DMLrhsxkuEFOlepaMhogVGu18c9mrLRSXxO45PCineOuEO1l5RgJufrhWYnRs3pgnchdxwR89hyg8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370624; c=relaxed/simple;
	bh=rz2T/muz4Qw4k3ub258+1cVYVKlDE1bFbShc3SV/tFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwHMGkZV0DwoJPPrUYqC4Mztj70gwGbGgO4t1Jyk7MUNGQ2Rf9O1PUzUWuH8o43tuCyPqys7GF2S8E27ixvVDLehgxSz05zBKS0q1IRI5H8+nBdmlBbHrw+cVQbV/tkFkDkyAwQiwy1tlH8e1pLtgrHXfZ0Quciaq/cV9YIAvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eac0F6lS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eac0F6lS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so3918429a91.1
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 22:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754370622; x=1754975422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uY4cABllPxXs/C2q+4FmYgKlnMM0alRZ+gST3WbRQE=;
        b=Eac0F6lS91xImE7Ms4FN6QXKrEKKRxKa1gtlOwopBBj3bqVB3yatYk0k8VRH9QOl4e
         X4VWQdezV2OGX0QMPKErYnCDM5Rc60fj/2zhd0+ioBFdDmm7J0sRpHcYcarJgmmGmULe
         G47/jTidKKn8OeJRsFGdeEbqUHsDwVa4XouUmJ5JmGQx4mcDTHf1m5tEshwSSBRYEhJd
         gVAjtxD1XLGXhrunK4XSZn2TjTvnZUlcmTQt455oY1bD5oYGL5ksVOdxw0aMPa/ghdJZ
         S1B5VdfVYHfE+jZwUauKhLrgX6cqKNvzaVcrVKiHYmXtqY2Nhm8unjNuV5c451pdqKzM
         YttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370622; x=1754975422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uY4cABllPxXs/C2q+4FmYgKlnMM0alRZ+gST3WbRQE=;
        b=WCPbDkv7DoEyY0HwJ4N0j7OIbzk3N2qxYW5OE7kCe/d2O65udSH2z953yT9MwD3tnL
         XhCN4nfl0+/KCsjWnpe7wNjMlGvqv0bzNzUmE22eWo0/Lfh54nrjrOronid49he+J+rl
         pfqs2hUetoMAF/eZ56rVkQFZAX837RQW0tt05uyW/u62ZbcMvCVgjT8dSYwv1etPqgOJ
         acuU/vm14mZNXgcdAccbW46rJmnt/wjd8kryd1j0uGi7mjVtbGpHNjjZQ4O29zpqp2br
         o9YJNWTA2jVAihomsCKmoCksjDDUBKHAQHNyqlKjIlYwXaJE8D6FatRIffUnt7V0WPFU
         W+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMkGhGcspUoFNGxwSvwOIapxTqGLJAjAHwKRfGStSNYJsQN8NBoqzcqQJvWXJHqvwzFG7powabuN5GT+fxqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS84TH7usdrdyysZWSZtc/UU01LKUQY/h75oiPlHMKkb0y9YfQ
	AZrbkn61KIMqL/aZjyXs2R2xyttf0ct8J2Vu3J8AmT6gBGsVot+0rrZC
X-Gm-Gg: ASbGnct+t+AJqiAFE61TjWISxZKEgFjmxH2BWVvQL3uFXD36QFHvKoKLDqtDNzN3gAe
	En/oFAv7eUuIYdL83B+klB8GSB+gBGMTkeRqxCc+1B9HU4/H6rnpzi7JJyspOQQpS/LSVClZUVM
	XKK+r6mXyE04NzMG3Iw81sumDa0YPCUQSxDQDQbogBrbuB4MOaEkt9xKTSTejHEImxPt0tfxq4C
	vUZ/+iy8jFFphGnk3x/XpwvfHjaeu+6CqheUyHQKu8s6W9vkoxtS6yEn+hu3m0cNfkGs19rgHFC
	pt4SKbB2IAkQvcn3vUwRJadAXzntm/fyFcGRbw2Z/JCkutGRjggjFIlDiaOT34Ng3XB/wMt5Gci
	AbSFq2/MzWQkO45siQm4UBT//SrLtkPKsVrYCSHxw7XrCIfITKesuzqDbYJcB
X-Google-Smtp-Source: AGHT+IHufrTKBXs+K1VueoQh9zPly7G9Z9xC6MOKli9LFxgZM7FAsVi3GX49qoHXnWhLox0TwYq8WQ==
X-Received: by 2002:a17:90b:5804:b0:31f:eae:a7e8 with SMTP id 98e67ed59e1d1-32116203b03mr19506716a91.11.1754370621958;
        Mon, 04 Aug 2025 22:10:21 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3209a850417sm13177953a91.35.2025.08.04.22.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:10:21 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH v1] VSOCK: fix Information Leak in virtio_transport_shutdown()
Date: Tue,  5 Aug 2025 13:10:09 +0800
Message-ID: <20250805051009.1766587-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

The `struct virtio_vsock_pkt_info` is declared on the stack but only
partially initialized (only `op`, `flags`, and `vsk` are set)

The uninitialized fields (including `pkt_len`, `remote_cid`,
`remote_port`, etc.) contain residual kernel stack data. This structure
is passed to `virtio_transport_send_pkt_info()`, which uses the
uninitialized fields.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 net/vmw_vsock/virtio_transport_common.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fe92e5fa95b4..cb391a98d025 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1073,14 +1073,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_connect);
 
 int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 {
-	struct virtio_vsock_pkt_info info = {
-		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
-		.flags = (mode & RCV_SHUTDOWN ?
-			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
-			 (mode & SEND_SHUTDOWN ?
-			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
-		.vsk = vsk,
-	};
+	struct virtio_vsock_pkt_info info = {0};
+
+	info.op = VIRTIO_VSOCK_OP_SHUTDOWN;
+	info.flags = (mode & RCV_SHUTDOWN ?
+			VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
+			(mode & SEND_SHUTDOWN ?
+			VIRTIO_VSOCK_SHUTDOWN_SEND : 0);
+	info.vsk = vsk;
 
 	return virtio_transport_send_pkt_info(vsk, &info);
 }
-- 
2.41.3

