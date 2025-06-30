Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D422FDF2
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269136; cv=none; b=VKanu2io0YrWUNviuX1hUjabbaHTrdgSys54A3dylAJUvuPwHgIdlisVqDQEwm8ua9j6+zDtmhpBspByY6nase0Bt7WiUOlANNzEm6bC0TX8LcGp2daYyUn0AtyE/52T5ON3a3MN6H64f2zL60spNvJyjBqedVBsPzYiRyrP25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269136; c=relaxed/simple;
	bh=8zHWFlCigM4oKQM+XUD7NX3O01Q7p6W6jnTQzPT3UPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ElCGyiJJ6s853L6GOSDVnPs5uyYqvR7t34eiln6/6TMv8pi9Ncn5/NcSDqhKq8Vd0VOhKXhX5YDLGm23scO8M5/exTglSy23j+9nJHlKwUc/K3HprLsvACsEESpm57sH/3aDXPuQ3svlk86fOTsmU0sx8roIM1wPntZBK1nJYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7fdHeFn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7fdHeFn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso2312137a12.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751269134; x=1751873934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxu7ig/S9LCUmwMcMSykN7rd/mLUHqPQuKn7T6xu2vY=;
        b=R7fdHeFnXdj644tT4076+CHa5SqDxx91Bx5e68WX6PcJzFQ5XC29t144qDFniI2tIj
         V5DsYZd1c5xTdD5BR+k1RYd2pwsU7MHjvjGY4SqVfHh2BCppwGC9OcVf60fJg38EDfR4
         o1OIbneJtpcOlIb6Y5CWzaEn3WcQoDiGE9ryjEMJaTC8Z+LxM4k04QqFZNkzCyLG2Sg0
         dTnJ1Jgjp2V44ZUpU7ndgx8z1950eIK3ZbPXpWkq60ECX0ZzS1PtMOZj7EDcGREw/cP+
         MUdtddYav8Gt1MqOmvtvtdKkctAprW02Myzb/vTdtzXyCF5m2nNc5AtNSWyBKePAoWy4
         kEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269134; x=1751873934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zxu7ig/S9LCUmwMcMSykN7rd/mLUHqPQuKn7T6xu2vY=;
        b=aQGrX1YNeHA87RIkQVhGM0z1C/egsNpg7lIooM3OyFABw3enLXwb3vo8hKNNM1BqKx
         3rCo2vLMc4o+ZbY/zTpGY2KJgZSf+Fk6gxJS3/Kjb3e8sPGFJK9Zm6B4AtAm7EL68cNZ
         es//hZxqT/6xYrppaNbH5e10aVKGU4LZVDBMDturEnnceKEjl5ecK8Uhelii9VF3YZTy
         vfJhpPrrx4rHHYXWNL0N44XacY6dGszFIVldRSRcFEmB5CLLzPhAo6EcLvA9yVYlDxMx
         oQZp/xSbWR9hgAkNwAjZrHiILSzm68EQf0GVtNJ5p6vDJuHn+v1M/hYwMKGHzNsfKWzq
         FoHA==
X-Gm-Message-State: AOJu0Yz4pfsxhKtecXmiPiQLFcqFl3viAPa7dlFAiWHX1DJCayI9O5iS
	lSezEQUiZUYBLRNsGlm5KdQwsd0p281wBc8COLWdYfu6I+UEgv/Movks
X-Gm-Gg: ASbGncs8FMAD5Wj4UZg/3SFIe7ziacgdWxYKJJZJ5RY1uwcpYIU7lTY1J3qpklfuebq
	WpwC+e738QnaypCt//C8BTi7MNatKFGdfLTqrj/B1BS7SlipNRB7tjq3/OTgK8lvopEXMcVw9m3
	zTgMP53bPi0w4smLshy0ZnkhwE5TofXaafRLPoy/BBH5hMD1TiuhduQnnSL5MBH9E0BZvGrW/8m
	U/dy7puZ6Hz5fYtT2ZWW1LLrq+zfddVNCUuTxxYThIyzFCoXcOuNRfQRF0isYpAzpdVuD3rGZe0
	PQgnl6VWeirDefi3qFyqrVy4nkLuhbbohhcE9e44tNtQl772230EzIsXVebDb7JNIPuAZToSs75
	RKIcCQ9lg
X-Google-Smtp-Source: AGHT+IE1QdmSYxev8iN4dxDowA6la8V3gpzolPl3kw80LV0ejyoAdzLd6I54yNlIqSmD3I5yGH7Rww==
X-Received: by 2002:a05:6a20:c704:b0:220:63bd:2bdb with SMTP id adf61e73a8af0-220a16ca7famr20405202637.40.1751269134043;
        Mon, 30 Jun 2025 00:38:54 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c8437sm8075175b3a.115.2025.06.30.00.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:38:53 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/3] hv_sock: Return the readable bytes in hvs_stream_has_data()
Date: Mon, 30 Jun 2025 15:38:25 +0800
Message-Id: <20250630073827.208576-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
References: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
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

