Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3D13C90E
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646763; cv=none; b=ncF9HDxKLqfAXDo1B/J5uWcWKEmHMjQ2GXgAQtpgSEgMPXCVxogBm9wkmQ5SdzdeN3VBPht6AVm9JR16vIy9NRAlsO70Sogh5vKrM0Vz7K7aAj1BwxEnmVWV4qA5a2dQXJKclKjfq+/DwvLvLnGOF8I66GcUPbij117F3DtfMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646763; c=relaxed/simple;
	bh=uhCcNYibbkqcdwdVnInAQFJ9ST2PnHWFbtJHgHboauo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stm5PMCEy77i527XNcI/6S8cSfBexw520dbimByg0Ft5ZtF1f6sz8+H1hCzIzg9VD98EFGBdpAtiVfUz/wEUPoD1E1pggIVUq0Xrui0pzQmoB/nC364ig7dYLOzJK+TP87kIXiMJ8sKj+PptjTgN+5BSNE+zZw1jELQN3kPYEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U34Vy2I6; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U34Vy2I6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74B6640B97
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDfV46R6Y6ZA for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5F0D440B8F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F0D440B8F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=U34Vy2I6
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F0D440B8F
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:00 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3d9234b77dfso138528b6e.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646759; x=1721251559; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmXSwxoqzjXnEZ3Wwvngpw8L/cu5lmFAezrwWUUIofg=;
        b=U34Vy2I6l5Y+azoBk2MjkPI4zWqqLSTe4unV19qdP4dQLp2iY3MYUrlrgxDOSQt5iA
         TxuRRypMcbs/W32khK/c5NiW07dgkJ9EznjCMEEMJ17KRgsMuWIycchknIYTJwSnPSYO
         0dDVYsB2BlN3kwTJEsveC0y4kWiRnxWzQo0ztqEISXURgHVmPx3zH2g2rHkfwXgM7Pg2
         pjNZ544PZ+SkcRVDDR4mJCmVQX47MQsezfR7Li/HAkcyA9NQau6NLgg/qa4bb++r32TY
         W0IdYnm7iiABn4ElxcTLD1UA0/K5pVUmpIHKxFEzNs2FpRrk+zCT3/m4/guOgrBSYsQO
         +fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646759; x=1721251559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmXSwxoqzjXnEZ3Wwvngpw8L/cu5lmFAezrwWUUIofg=;
        b=HhcitnVnU4FbN4UBjqDklCG1BRjB60YOS9yz9GFWONI1Fxx1NihadtHjpnwqLzEZky
         JwTNILJ7dFyiGP65EFF28p8HLfT/uVk6pTYLFwrWo4141wruLxEgqzkDn3n2s9UGUv75
         qFvaQ6901Z34+lR3monHHpb5vpkD6Lcmeu8ite+xThxzY8a5lmtidb++9+Ea04P5GSSf
         dxT1k8PllT+Csfd8i7WwHde2PTkF7mC/uvOrkSmCqffteg+EbqFCIXpIbRf4BL+IWYgo
         0MwWOc+rrV41gnrg/7l4IwJ1XU6CPwOujTuLpLPMQBbDFSdY0toU/m8TViEjvSkzl5gQ
         kD+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8M1T7GA22rwOXak6Tyh2BIzKn3BgvyuCc2sRc6RW8UD2CjcKxK0XIpzq5O24RSYhgp3fbgivOOham7o0y+GmTVvyhJU/k3V8Iz3skyHeAoifeU2e3sPWi7g==
X-Gm-Message-State: AOJu0Yz452u0xBqMBNS625jE6Tttawip/kUbGAv0yajxMPtKmXHRHIFz
	TXYiBgRiIXb6SR/GaekbzD7/KFXLDjifWO3lNBb/NSRWhWNzMwGT
X-Google-Smtp-Source: AGHT+IHAi58F+5PJOYlliCTAylnZUgBqrqKTaxEPrlPEhkPkEh9JQbful2UvFJHyD7bxBrd2xbJ6sw==
X-Received: by 2002:a05:6808:2129:b0:3d9:29c1:be4c with SMTP id 5614622812f47-3d93c07b10amr7068703b6e.38.1720646759158;
        Wed, 10 Jul 2024 14:25:59 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:25:58 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 04/14] af_vsock: generalize bind table functions
Date: Wed, 10 Jul 2024 21:25:45 +0000
Message-Id: <20240710212555.1617795-5-amery.hung@bytedance.com>
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

This commit makes the bind table management functions in vsock usable
for different bind tables. Future work will introduce a new table for
datagrams to avoid address collisions, and these functions will be used
there.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index acc15e11700c..d571be9cdbf0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
+						   struct list_head *bind_table)
 {
 	struct vsock_sock *vsk;
 
-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
+	list_for_each_entry(vsk, bind_table, bound_table) {
 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
 			return sk_vsock(vsk);
 
@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 	return NULL;
 }
 
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
+}
+
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
 						  struct sockaddr_vm *dst)
 {
@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+static int vsock_bind_common(struct vsock_sock *vsk,
+			     struct sockaddr_vm *addr,
+			     struct list_head *bind_table,
+			     size_t table_size)
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
+	if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
+		      "table size too small, may cause overflow"))
+		return -EINVAL;
+
 	if (!port)
 		port = get_random_u32_above(LAST_RESERVED_PORT);
 
@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!vsock_find_bound_socket_common(&new_addr,
+							    &bind_table[VSOCK_HASH(addr)])) {
 				found = true;
 				break;
 			}
@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (vsock_find_bound_socket_common(&new_addr,
+						   &bind_table[VSOCK_HASH(addr)]))
 			return -EADDRINUSE;
 	}
 
@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	 * by AF_UNIX.
 	 */
 	__vsock_remove_bound(vsk);
-	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
+	__vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
 
 	return 0;
 }
 
+static int __vsock_bind_connectible(struct vsock_sock *vsk,
+				    struct sockaddr_vm *addr)
+{
+	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
+}
+
 static int __vsock_bind_dgram(struct vsock_sock *vsk,
 			      struct sockaddr_vm *addr)
 {
-- 
2.20.1

