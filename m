Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830D242923
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270272; cv=none; b=HCosFLOf+xFRz3LHArSXwZp8gUdkQR9ZK1wy192w+4Y4f3Qzdvp07mOWFfAEzCRiJKcHMv80hg7sPa9xv7nHQZ5JzCNFiUauyr8GAAaGx/CBhfdYR8yRBoCWos7vr11itefSD7+ujQ8JckM84AUzdcD35mLxKvq/cw8O7rXujvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270272; c=relaxed/simple;
	bh=8zHWFlCigM4oKQM+XUD7NX3O01Q7p6W6jnTQzPT3UPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5Tv3EIk8BUEwuo23hROX0bCkGVs81yH9O58O3N7Qz7r6LuOO62DxLJNPw5GztT1+2lGNvPAnfR2s1xlinE1KPlsi1AqRKwu2EvZKpc3o64KSOb6JOZumCNLx68Lqpj/T8HNUuOh9fd2Re1lKTICquwo1eqUgpjt+FhK9m6xYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwkyGvvJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwkyGvvJ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so3281609a12.2
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270270; x=1751875070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxu7ig/S9LCUmwMcMSykN7rd/mLUHqPQuKn7T6xu2vY=;
        b=iwkyGvvJhRCgJfzYjqnh0J9fPvuU55tOQnMlze3f+/6yMy1pTFotI1FKLospK1EeI/
         Y/DBCHs87jFKeUT1qkeffDvMa4rWyo+rh1vQycseyTNJCDgZ5qaIQIb8iveI0eYhqEK4
         22mKWTQC5ZoP2bGHdNpPFQIIvyBW7tTtFa/0J0pphH72s2/uCNpa+1IZ/wdjrG4fqvEb
         RSKnIlz921o2JCQzVzwkQHrPHY1/yri5naquUdKoIslDKZyw64DnXddBl/wfu/rsxYCs
         caZKqECQd2TC3oZj1gfG2ZGzUqkeY81KoUzDiPUlbo4rwuUXc1azWv+yQxDmZNOH22S4
         lwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270270; x=1751875070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zxu7ig/S9LCUmwMcMSykN7rd/mLUHqPQuKn7T6xu2vY=;
        b=Pelr33V4lgoCYeJel7EJSXix3GeglvsMm0Ui9viv6m4Q59PAYHMR38VaCOvwx3ZITF
         BpW4CAXCo2mujbjWbjAkL75Ot2eoMNfFSoL+CGsYs/B/mw+xZsG9mmVm/+c+wtIlZGCy
         gIKukXJKDbIrrK/jQZyNUQj0Lmfn5bCvox53bbyyMUF0Jmtc5LWq+obROAvluQBdKxfB
         Fnzv6tCScu2AguoELIuFXf9HhFAjaEWxls87J+buUtJWQkK7DpfTpH00VwVcCva3Ummp
         BicNxOk2ytbHJa2fkrSe5AKL9aXQv318lymbOX0yPWfAXObx1KEi1xKezS13D1SG9oKT
         SNhQ==
X-Gm-Message-State: AOJu0YxMUZeasj76fd1Z4g19R5R4/XAtrK6xjW+NOTCCBagiB3GDLIGU
	Xm+pUNVZjeDBPXBKJ5DygwXUu+tz3a7LL3IGRxcuoV3Mua7svwuUjDDO15ZmkoPHt37eMr4Z
X-Gm-Gg: ASbGncvy1UXXFNgbR/kiyQlZ+x4gZrnTiNJcVWZMF4IqCmXLNdokXnikxjxbXUIXBt2
	UOCjmcImA0uJFHl7STqG0Vh6MLJjbFkJ8d1VMy4daAAdbFYpZETFiBNS+nwGSgDLmW47XgyoSpR
	Ee1oKmpIW3P9x38NS90L2fUY1J31V3r9q4wrlAQkWbs7uOY+9Ovc2bLOTl4QDvqDm/CmEJiS/7j
	h3z6+GHSt0C1BUipWdVTG6aYt7cU2MqH4HiRegXuU2nowgTGnpslEPi6oytP8xNolx6uZGiytbG
	g4IdXOS1qSq3OHUfw7Gl5wOcI+t1+mUXvBTwA7x0KNe9iCkJbevLy9QgvxWlv0wMn4sbWfqmv6G
	1JIILohot
X-Google-Smtp-Source: AGHT+IFeB5QAqHDhB/+cLf2rBEoPse3nWkgqjJpbJmYfyGIZdEChb2MyNa+j8tvsdcGZfOOX40t+Dg==
X-Received: by 2002:a05:6a20:9194:b0:1f5:9098:e42e with SMTP id adf61e73a8af0-220a12a4a3cmr20966808637.7.1751270270193;
        Mon, 30 Jun 2025 00:57:50 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db02esm7414931a12.63.2025.06.30.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:49 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v4 2/4] hv_sock: Return the readable bytes in hvs_stream_has_data()
Date: Mon, 30 Jun 2025 15:57:25 +0800
Message-Id: <20250630075727.210462-3-niuxuewei.nxw@antgroup.com>
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

When hv_sock was originally added, __vsock_stream_recvmsg() and
vsock_stream_has_data() actually only needed to know whether there
is any readable data or not, so hvs_stream_has_data() was written to
return 1 or 0 for simplicity.

However, now hvs_stream_has_data() should return the readable bytes
because vsock_data_ready() -> vsock_stream_has_data() needs to know the
actual bytes rather than a boolean value of 1 or 0.

The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
the readable bytes.

Let hvs_stream_has_data() return the readable bytes of the payload in
the next host-to-guest VMBus hv_sock packet.

Note: there may be multpile incoming hv_sock packets pending in the
VMBus channel's ringbuffer, but so far there is not a VMBus API that
allows us to know all the readable bytes in total without reading and
caching the payload of the multiple packets, so let's just return the
readable bytes of the next single packet. In the future, we'll either
add a VMBus API that allows us to know the total readable bytes without
touching the data in the ringbuffer, or the hv_sock driver needs to
understand the VMBus packet format and parse the packets directly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4..64f1290a9ae7 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
+	bool need_refill = !hvs->recv_desc;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
-		return 1;
+		return hvs->recv_data_len;
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		ret = 1;
-		break;
+		if (!need_refill)
+			return -EIO;
+
+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
+		if (!hvs->recv_desc)
+			return -ENOBUFS;
+
+		ret = hvs_update_recv_data(hvs);
+		if (ret)
+			return ret;
+		return hvs->recv_data_len;
 	case 0:
 		vsk->peer_shutdown |= SEND_SHUTDOWN;
 		ret = 0;
-- 
2.34.1

