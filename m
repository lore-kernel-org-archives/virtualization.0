Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCB23ABBF
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270268; cv=none; b=MFWwZhppHc8M8ed/zfvtIv7yXXfPnBfjcgRNhGxjyj6YRSaiTpZKRqt30N03JHN441fM5A3w/gPbY6zUSidjYYQeDtrsTBHE1mSUU5oDt4+ZijaSzZXfVCqEQpn89i4VkFBwvzsRVNBdi746zoXQ9KmOTsoXiDPend5qLUnGDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270268; c=relaxed/simple;
	bh=yYhC1SvTr4r/q4aKyafrkgVQ1b+GHoCyO4kJ6c3v10c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kd4lc0LbGeTnd/FJsy8DUsIcn6qeQlLXkG0D0Z0eEsygaiHp81aqgw6dOvK3RafV+6t9wj1DZxhydaZ+ZAc2Hwcok0DUjuNfj/ZdTtvC+DNdkzKCCg29411fIATDVFvqhFJjKakMbU7IXWDCcBdtKKUwyZ/WeGkEYnofTULzwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/iQ4GEX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/iQ4GEX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23508d30142so20475765ad.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270266; x=1751875066; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te1ubGn4t4pkro6tbCWw9qlZ7DcNvsq3ids6nDR7Ezw=;
        b=A/iQ4GEXdNv4xW2G4Ns3d6KVIEIgRbJfxost4mh0MjTrdf5UJZueRqtmMAKUQG6XYM
         /yjSe+oC1GdDwTdoNBgXcJMSMA3z3/xgAQK8oqa7ckpxPugyjDQoiS0noXtipsDuh/O4
         JLUTQPSf1uzUhmRFyhnYZSHAHSxkn9t7GnKR7gSpo+euJkij+s7NLYufcoAYoCKE/II+
         Hr0lKqjhVK5fnqsKqy8LCOOhOk5aNeKNaVJeM+BpTzh/qi9gXIPzGx02yD2y1R57Pbe3
         18jBKd++f9277dTXxXNj5NWWpj7/vnwXlWgSjFqM5+M9h+Hiep/B6oEMwHW7DmpFgbcs
         UuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270266; x=1751875066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1ubGn4t4pkro6tbCWw9qlZ7DcNvsq3ids6nDR7Ezw=;
        b=Ov/9CH5VfYVbBkUFAzYEvjGqV5NvBH6yxqR0+fG0/tCHyjLVNc+HDqpSyKaO317mHp
         4TYbZpQX9nWswVmeNRObpToOl2qY1yPdbsTZptQZCKOrEoU+5pUJGJDRSxqJ3RInMqb5
         ImCW7y7Pq5str0peZ8LXbJgXHK5Fo9IywJ4OtO/rlRluZTzXmPpBRpGZxWP56OEX4zxl
         w7+mQ6wvriQcfo/cr0OOCz4BAITV3puawxY4o6+m8N+QYArreAmdoRV97EUs2nFtrmTJ
         omDp5v8rScroCloQRx2mve+PaT5E9V+WvcucB6GoTn+bdJOEYxE3AK2rWVoSqgver2a+
         2Cgg==
X-Gm-Message-State: AOJu0YwidkfpysLe5Twv5d+Vp7TEsons7rV6hSlEC/jugAgiX/2BgJrD
	xbQX0BvnXDpSlG5fXKdGbaVAyCZQi8+vj4m5RAp4c+uJ/dz97CG6h2de
X-Gm-Gg: ASbGncvgLCOBY2fZVuaocZGkicxfuULCby1IgryZbNiRJxJzUxsVCtxDTvkKR7ZzWVu
	6EV0jo2hlwS+GSxDdYCyIyes3nU/TivgqXLMah0YjsWL7zyMb0vq0MvBWh4igsKcW3qcpHn7EBQ
	xgHXmbr/njU9X0z6gjmSDJGgspNTDtsA/qykcMM0rBY9/1j5jiASA7YKoqLweF/49rsmrXKo/wb
	eb4JgqgAmWrEqiJY5wTacZcPCUAcabQ2LefGHFpcN7eTbgGAor3KVsSQSmGognPJ/qwlavb2muY
	b6ssUhRTMIlcs0fAkTC9HGz0RwkERKDBgRZlZJ/eydUaDNr2uRj0n3hWWqvQjTXVSebgheVKAgr
	iHy8/nMb/
X-Google-Smtp-Source: AGHT+IElsi4FmjD8ptxsYXp6SgY5L4HbtTxYXy+6Tm1I+pM33trhN/23GKQddZOGFvxJS5SLFMN9ng==
X-Received: by 2002:a17:903:18c:b0:235:ca87:37ae with SMTP id d9443c01a7336-23ac4637152mr195826455ad.41.1751270266294;
        Mon, 30 Jun 2025 00:57:46 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db02esm7414931a12.63.2025.06.30.00.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:45 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	leonardi@redhat.com,
	decui@microsoft.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [RESEND PATCH net-next v4 1/4] vsock: Add support for SIOCINQ ioctl
Date: Mon, 30 Jun 2025 15:57:24 +0800
Message-Id: <20250630075727.210462-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
socket. The value is obtained from `vsock_stream_has_data()`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965..bae6b89bb5fb 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsock_stream_has_data(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 
-- 
2.34.1

