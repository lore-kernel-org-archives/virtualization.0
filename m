Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B815ADA7
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646766; cv=none; b=EnxjbHEwRWIUaaVWYyVhy84F4mPKD1aTE4/uHok6IalCy7MbplCPAq6tWowHn0iTNhW1gEUcELeW4VZRQgXbazk0Vu/zMfhInk2qvGaX2RlRnGWzpheh2wihZOhEDsuX8pdXDlZkMKwWNhRyGxCP2FdcHf7zgva6rHvzo/4P43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646766; c=relaxed/simple;
	bh=J/OYaM6+jTGguEhL1pMHM9vGNQQe8xO7deLzLD0Zrlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzMk9tKqp9Myo19OxC96uXMTwPW/eOM4ikqT2rIseruUC92LMb4QiFQvU6Q3u3YmIFK5Xewo+r2yz97B/N1FOs/9cTPL64k6ddpocemv/9pCSs+2pCGYenG9RY3SeNFertLfLZuwZWUVS1lSUASQUgUuzkmq0O6lJRsKISaNbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfw5tJYC; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfw5tJYC"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 989ED40B97
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81YRa9pzf3Q5 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AAFC340B8F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAFC340B8F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Kfw5tJYC
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AAFC340B8F
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:03 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3d9272287easo127027b6e.2
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646762; x=1721251562; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZum7xcXnx/YZciY9jm1etfeGDFDR11AzV+Fk8UpldY=;
        b=Kfw5tJYCp9lfE79idIA1b1L95ErwhYSTxNcvMkZFHd369SwB/dIDNK/Q9bmSDlN/Kq
         qX+uQ8WRvNO7FY30jd1q1MrlTrJ6K84s2oG1TDMTBfdnEU16kQ4Z+r5iQZxRzSM59vE7
         U/oOIULSHMgOJLRhcLnOJQBrbMFaDL6TO1xbVfupkhZB2mnGcQ4xYGYIjbn1jRi2Vavn
         iMW7kOWu4MMzPnho8JuBHys3oxWGj/83NtthQ5Sm+TJ8iNc4+WRRWBiLcZZ/YlOti7+J
         FNxXF70g6zL71NNF6N+o+ZUkiVAC8OJYOzRnyaMz0mFydQdI48J3k+Am6CrxR0/MIvwT
         2rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646762; x=1721251562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZum7xcXnx/YZciY9jm1etfeGDFDR11AzV+Fk8UpldY=;
        b=fgnBaEvSziKxWcp4z3LUjzm18GO2s3doYfNE+9OVsW6Hs4qQp8JQaEi4aaG81lIQb2
         gEoox6uzAAANn8WJvR8aUElporSncklSP/yxWvYw2e3leAamAWaV5MrL2pWNSJuntQnX
         CBq1TVSF/nmHL61CYVpS+r8XMjFUkIKWtpWw5cmOdWBcONBEuQ0ET6tbHn3O2XTbRhay
         DfDl3MNs4EoKEPnI8ob+FQlFpbvvttDggwDf7Rag/ZHZKnXWpp1PzJWsdZNZ8Sy/KVJO
         h1kjxGClBMh6pcyZK6qBcoUW2x+rl8EY+5Xojp8TZWCNv87tVqql7guJi6ABMCqGVDb2
         cHUA==
X-Forwarded-Encrypted: i=1; AJvYcCVWl1gPIO5Bm2WkPXeoVPNmkezvx2qFbdbFCka9AqTv2RTP8NsdmtBHwRj88/6PAQkBgySoIVchcMPOwnBtzN2i7ssysmQuS1z5wTA4QlEuE8zAIUrDqbqPZA==
X-Gm-Message-State: AOJu0YxHtpOynyBLJZcUwtqd2WGYo8SH3gEj4/p57oDpYSR8CJHhn9Zy
	SfE76iOzv9E0G7ksBstPlfbI+6vSsDEUrjkExryJ1Rg7aEG+mDNvbtCu3A==
X-Google-Smtp-Source: AGHT+IEwAeV+NVV9eWvJ41Uh/5eeH740eMks+WRw93+ZS4FZF5Q7SDWMuOErRunlQoY//g+dgPPf/A==
X-Received: by 2002:a05:6808:1455:b0:3d9:2925:cd37 with SMTP id 5614622812f47-3d93bddf767mr8767261b6e.2.1720646762507;
        Wed, 10 Jul 2024 14:26:02 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 08/14] af_vsock: add vsock_find_bound_dgram_socket()
Date: Wed, 10 Jul 2024 21:25:49 +0000
Message-Id: <20240710212555.1617795-9-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

This commit adds vsock_find_bound_dgram_socket() which allows transports
to find bound dgram sockets in the global dgram bind table. It is
intended to be used for "routing" incoming packets to the correct
sockets if the transport uses the global bind table.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 6e97d344ac75..9d0882b82bfa 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -218,6 +218,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
 const struct vsock_transport *vsock_dgram_lookup_transport(unsigned int cid,
 							   __u8 flags);
+struct sock *vsock_find_bound_dgram_socket(struct sockaddr_vm *addr);
 
 struct vsock_skb_cb {
 	unsigned int src_cid;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f83b655fdbe9..f0e5db0eb43a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -265,6 +265,22 @@ static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
 	return NULL;
 }
 
+struct sock *
+vsock_find_bound_dgram_socket(struct sockaddr_vm *addr)
+{
+	struct sock *sk;
+
+	spin_lock_bh(&vsock_dgram_table_lock);
+	sk = vsock_find_bound_socket_common(addr, vsock_bound_dgram_sockets(addr));
+	if (sk)
+		sock_hold(sk);
+
+	spin_unlock_bh(&vsock_dgram_table_lock);
+
+	return sk;
+}
+EXPORT_SYMBOL_GPL(vsock_find_bound_dgram_socket);
+
 static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 {
 	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
-- 
2.20.1

