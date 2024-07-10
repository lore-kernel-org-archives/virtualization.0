Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CE152515
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646764; cv=none; b=VDZ3sd9OVa8ayDVEAwVat/op1XoSDm64qjxsSHWdeikSudERiIHLDUYYar9ds8ODHSEvNiQx9B49kTP3bBqUFO0kEKOoJmrdmkQFW899J0juSz1BBP4hzgiAbbsw7GwWgXTm59/WSwN++vhVUe62vGwLPJBZVckCV50EIBQ4CfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646764; c=relaxed/simple;
	bh=LyJH2hBBhnOgPmwJMZXReqHovO0qHkbDTNVOj1OTcAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U02zs2KIUG8+K+se3yE8GH5bc0w2vobawJuoi/Ew7dm8TnsKrtiLQi4RJKahZtC/OGnjxtn/gsoDDOupSnHoxNtvbelv/cz+h6JvJzStKcDZAJfu0CNhh4Li0L/wvZT3WHiBPlfcwhNay1iV/gViGjOlrUCYg+dGPMZAnrJU1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkSgnhax; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkSgnhax"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 548D560F12
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRr8XOzAyp5q for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4B8BE608A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B8BE608A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HkSgnhax
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B8BE608A9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:01 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-79ef810bd4fso13717685a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646760; x=1721251560; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxKcfYe0aTkG2Qtc9qYf7tn4S8PrvFN6AZU5pXvNhSU=;
        b=HkSgnhaxKtO/0imKuFgi/QK/BOBt7oXc5RCDWnbA4attgo7cy8y5uS+ZHRP2X9KjF/
         NshkVY4otczgnKS6spC12JxH9sJZYG28hxBp8yyjys/bGuG+rTZgI2mNhjwLnhAfEpmU
         FNKhZto357ttoc/1KRa/6Hmt+Hg+6kAsqrNmfSBQrNA4h/GbUtYYzPNyZnNJpwX6qo2J
         0qRBNZW4C9Gu/XiPxWv17l8FhwtWIhU5sCVs5pTyl6TBYTrYZq+z+7BV8/kNuSeH6mQp
         9EZTY3agItcxc8iEnkz7YNG9jfoGsPlhKq5DBOYCl8ua0pTLJqBi1XsSPdZQ8AYoZxUY
         jdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646760; x=1721251560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxKcfYe0aTkG2Qtc9qYf7tn4S8PrvFN6AZU5pXvNhSU=;
        b=DtEFJdKBSAmzBWBcqTKayBjTddjToc9Z15GfYzw7YcOz0ZRCO15sINDRutvv4n3qJb
         TvlQWAY2jOpPvlfBwkZ/u1bU0P//yuTkOpCBhNsfmd2Mqr/Kwa/POw1KO/2fyUodl2kR
         qH39FqTsGfQ2IQpVQqP1Lruq/6MNf5fWBRXehse7Huww1ZVmsz1sX/AmegLevgVmshKy
         86sJON3EH3/lFruLNjUbUpPpwSQ8dyj9gHC1I/7qYR5Ls0w3Y1z1xvjb1omVXBFyYcPI
         w+S9IayPJCeYzJVyvN9s6TE8oHruW5828w4xjppGZ+cOi4fk4syWZk2Bo+5uibZB1QbL
         3ZGg==
X-Forwarded-Encrypted: i=1; AJvYcCXdOs8m8OwBu8L88NQat50oEIveh/g9oR58+pbGT6Bt2J86yv5PuZN5fByUMeNrnqa0Ptm8FA1xVWBmoFaUAWY+evc0TiOkX15WFyx6VXuVgjO33I2U0ojMIQ==
X-Gm-Message-State: AOJu0YxVVI/kWwtaqKZ2a3JecdgMi6HH7EytIqSAtjHqr243jqehIQfb
	uypAITlnDQ96ULAUoSRe9wxIBJZcW9txKe23jcK2p5LyhLukz2Aw
X-Google-Smtp-Source: AGHT+IF6x1tIBL/6HRZ76/k84A0vB251Ob+fzT6he8zcBfDrLo9SHcbTtQSiMBBYeiAZryPfmYl48A==
X-Received: by 2002:a05:620a:2186:b0:79c:119e:2b44 with SMTP id af79cd13be357-79f19a51d7fmr733109885a.3.1720646759964;
        Wed, 10 Jul 2024 14:25:59 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:25:59 -0700 (PDT)
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
Subject: [RFC PATCH net-next v6 05/14] af_vsock: use a separate dgram bind table
Date: Wed, 10 Jul 2024 21:25:46 +0000
Message-Id: <20240710212555.1617795-6-amery.hung@bytedance.com>
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

This commit adds support for bound dgram sockets to be tracked in a
separate bind table from connectible sockets in order to avoid address
collisions. With this commit, users can simultaneously bind a dgram
socket and connectible socket to the same CID and port.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 103 +++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 27 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d571be9cdbf0..ab08cd81720e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -10,18 +10,23 @@
  * - There are two kinds of sockets: those created by user action (such as
  * calling socket(2)) and those created by incoming connection request packets.
  *
- * - There are two "global" tables, one for bound sockets (sockets that have
- * specified an address that they are responsible for) and one for connected
- * sockets (sockets that have established a connection with another socket).
- * These tables are "global" in that all sockets on the system are placed
- * within them. - Note, though, that the bound table contains an extra entry
- * for a list of unbound sockets and SOCK_DGRAM sockets will always remain in
- * that list. The bound table is used solely for lookup of sockets when packets
- * are received and that's not necessary for SOCK_DGRAM sockets since we create
- * a datagram handle for each and need not perform a lookup.  Keeping SOCK_DGRAM
- * sockets out of the bound hash buckets will reduce the chance of collisions
- * when looking for SOCK_STREAM sockets and prevents us from having to check the
- * socket type in the hash table lookups.
+ * - There are three "global" tables, one for bound connectible (stream /
+ * seqpacket) sockets, one for bound datagram sockets, and one for connected
+ * sockets. Bound sockets are sockets that have specified an address that
+ * they are responsible for. Connected sockets are sockets that have
+ * established a connection with another socket. These tables are "global" in
+ * that all sockets on the system are placed within them. - Note, though,
+ * that the bound tables contain an extra entry for a list of unbound
+ * sockets. The bound tables are used solely for lookup of sockets when packets
+ * are received.
+ *
+ * - There are separate bind tables for connectible and datagram sockets to avoid
+ * address collisions between stream/seqpacket sockets and datagram sockets.
+ *
+ * - Transports may elect to NOT use the global datagram bind table by
+ * implementing the ->dgram_bind() callback. If that callback is implemented,
+ * the global bind table is not used and the responsibility of bound datagram
+ * socket tracking is deferred to the transport.
  *
  * - Sockets created by user action will either be "client" sockets that
  * initiate a connection or "server" sockets that listen for connections; we do
@@ -116,6 +121,7 @@
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+static bool sock_type_connectible(u16 type);
 
 /* Protocol family. */
 struct proto vsock_proto = {
@@ -152,21 +158,25 @@ static DEFINE_MUTEX(vsock_register_mutex);
  * VSocket is stored in the connected hash table.
  *
  * Unbound sockets are all put on the same list attached to the end of the hash
- * table (vsock_unbound_sockets).  Bound sockets are added to the hash table in
- * the bucket that their local address hashes to (vsock_bound_sockets(addr)
- * represents the list that addr hashes to).
+ * tables (vsock_unbound_sockets/vsock_unbound_dgram_sockets).  Bound sockets
+ * are added to the hash table in the bucket that their local address hashes to
+ * (vsock_bound_sockets(addr) and vsock_bound_dgram_sockets(addr) represents
+ * the list that addr hashes to).
  *
- * Specifically, we initialize the vsock_bind_table array to a size of
- * VSOCK_HASH_SIZE + 1 so that vsock_bind_table[0] through
- * vsock_bind_table[VSOCK_HASH_SIZE - 1] are for bound sockets and
- * vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.  The hash function
- * mods with VSOCK_HASH_SIZE to ensure this.
+ * Specifically, taking connectible sockets as an example we initialize the
+ * vsock_bind_table array to a size of VSOCK_HASH_SIZE + 1 so that
+ * vsock_bind_table[0] through vsock_bind_table[VSOCK_HASH_SIZE - 1] are for
+ * bound sockets and vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.
+ * The hash function mods with VSOCK_HASH_SIZE to ensure this.
+ * Datagrams and vsock_dgram_bind_table operate in the same way.
  */
 #define MAX_PORT_RETRIES        24
 
 #define VSOCK_HASH(addr)        ((addr)->svm_port % VSOCK_HASH_SIZE)
 #define vsock_bound_sockets(addr) (&vsock_bind_table[VSOCK_HASH(addr)])
+#define vsock_bound_dgram_sockets(addr) (&vsock_dgram_bind_table[VSOCK_HASH(addr)])
 #define vsock_unbound_sockets     (&vsock_bind_table[VSOCK_HASH_SIZE])
+#define vsock_unbound_dgram_sockets     (&vsock_dgram_bind_table[VSOCK_HASH_SIZE])
 
 /* XXX This can probably be implemented in a better way. */
 #define VSOCK_CONN_HASH(src, dst)				\
@@ -182,6 +192,8 @@ struct list_head vsock_connected_table[VSOCK_HASH_SIZE];
 EXPORT_SYMBOL_GPL(vsock_connected_table);
 DEFINE_SPINLOCK(vsock_table_lock);
 EXPORT_SYMBOL_GPL(vsock_table_lock);
+static struct list_head vsock_dgram_bind_table[VSOCK_HASH_SIZE + 1];
+static DEFINE_SPINLOCK(vsock_dgram_table_lock);
 
 /* Autobind this socket to the local address if necessary. */
 static int vsock_auto_bind(struct vsock_sock *vsk)
@@ -204,6 +216,9 @@ static void vsock_init_tables(void)
 
 	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
 		INIT_LIST_HEAD(&vsock_connected_table[i]);
+
+	for (i = 0; i < ARRAY_SIZE(vsock_dgram_bind_table); i++)
+		INIT_LIST_HEAD(&vsock_dgram_bind_table[i]);
 }
 
 static void __vsock_insert_bound(struct list_head *list,
@@ -271,13 +286,28 @@ static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
 	return NULL;
 }
 
-static void vsock_insert_unbound(struct vsock_sock *vsk)
+static void __vsock_insert_dgram_unbound(struct vsock_sock *vsk)
+{
+	spin_lock_bh(&vsock_dgram_table_lock);
+	__vsock_insert_bound(vsock_unbound_dgram_sockets, vsk);
+	spin_unlock_bh(&vsock_dgram_table_lock);
+}
+
+static void __vsock_insert_connectible_unbound(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
 	__vsock_insert_bound(vsock_unbound_sockets, vsk);
 	spin_unlock_bh(&vsock_table_lock);
 }
 
+static void vsock_insert_unbound(struct vsock_sock *vsk)
+{
+	if (sock_type_connectible(sk_vsock(vsk)->sk_type))
+		__vsock_insert_connectible_unbound(vsk);
+	else
+		__vsock_insert_dgram_unbound(vsk);
+}
+
 void vsock_insert_connected(struct vsock_sock *vsk)
 {
 	struct list_head *list = vsock_connected_sockets(
@@ -289,6 +319,14 @@ void vsock_insert_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_insert_connected);
 
+static void vsock_remove_dgram_bound(struct vsock_sock *vsk)
+{
+	spin_lock_bh(&vsock_dgram_table_lock);
+	if (__vsock_in_bound_table(vsk))
+		__vsock_remove_bound(vsk);
+	spin_unlock_bh(&vsock_dgram_table_lock);
+}
+
 void vsock_remove_bound(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
@@ -340,7 +378,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
-	vsock_remove_bound(vsk);
+	if (sock_type_connectible(sk_vsock(vsk)->sk_type))
+		vsock_remove_bound(vsk);
+	else
+		vsock_remove_dgram_bound(vsk);
 	vsock_remove_connected(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
@@ -746,11 +787,19 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
 }
 
-static int __vsock_bind_dgram(struct vsock_sock *vsk,
-			      struct sockaddr_vm *addr)
+static int vsock_bind_dgram(struct vsock_sock *vsk,
+			    struct sockaddr_vm *addr)
 {
-	if (!vsk->transport || !vsk->transport->dgram_bind)
-		return -EINVAL;
+	if (!vsk->transport || !vsk->transport->dgram_bind) {
+		int retval;
+
+		spin_lock_bh(&vsock_dgram_table_lock);
+		retval = vsock_bind_common(vsk, addr, vsock_dgram_bind_table,
+					   VSOCK_HASH_SIZE);
+		spin_unlock_bh(&vsock_dgram_table_lock);
+
+		return retval;
+	}
 
 	return vsk->transport->dgram_bind(vsk, addr);
 }
@@ -781,7 +830,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 		break;
 
 	case SOCK_DGRAM:
-		retval = __vsock_bind_dgram(vsk, addr);
+		retval = vsock_bind_dgram(vsk, addr);
 		break;
 
 	default:
-- 
2.20.1

