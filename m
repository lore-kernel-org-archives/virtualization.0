Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DC30C612
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164318; cv=none; b=Rm6sBoThb1leUyOF9Kk5KyPROyJ0gJjE2TVeX/uk1wqQ9kk4eSGw/LppkHTknMYsjNEjDASjyOnX3nAtwbn7JmldV2mchMqOaIBry6JwHA9H0TxUIA1ZSxm9OP67Jx1C1pzMnzXyMlsC1/kBojHth7mJOASX7IEz04cHl/C5EZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164318; c=relaxed/simple;
	bh=qVWDhyzeG/Z8JL3F0OP9m69Cq46/dVVMczXqz8KQbOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rpkHG66rGG9oobMBBiZU2kdHWPUoslpcCDZwb4AyjLu8eqY2ZHzbDoTC5YZmoeLd33H3LG62aN1vuQzBqdWdFgZ7Kxfr859lr0S3ixcVMsCD5QHHRj1pcgT/zlIUZgkAkY/N5zAvJGP4ex+ofe/Uh/BtdNSeivGNR1+rNQU5Ytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te072fDJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te072fDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764164314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mhs6sooJ56Q3btp7R+WL1sLMwD4EfCJBflvbYxzesYo=;
	b=Te072fDJhD2WYB5syknG/XaXGRFM2I1QGJIh2XwLoWdLoKrOxaRqGrrBb4/xGWO4ssDc44
	O6IgkzLDr2ajA1aNjT7OjGji3W2REzXc3cmkQk7BSXBsgJ3Fnw3TdMtwgvCECZa3jKyyl1
	0+Wkc33LdKJj0CPPc4BjsR554wDWfZk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-0JUHHvtwNLCIX3U12B7YVQ-1; Wed, 26 Nov 2025 08:38:32 -0500
X-MC-Unique: 0JUHHvtwNLCIX3U12B7YVQ-1
X-Mimecast-MFC-AGG-ID: 0JUHHvtwNLCIX3U12B7YVQ_1764164311
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6417b2fae83so7480846a12.1
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 05:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764164310; x=1764769110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhs6sooJ56Q3btp7R+WL1sLMwD4EfCJBflvbYxzesYo=;
        b=B9wwUgQH3pqX9Mbl14ZSJ5cK54GO8KEYNkPPR65p4HWJrv15RMeM5iu6vHqMIBzYd7
         b3Mc6KxUZTzka/nZQJqpb0Pn/+NY7DmPk1ffojienaEqqX/GSvF//W9NKpkeFreIx2Ra
         GpVce+6uBYK8GetFUI/TPn8HFuzSKU4trDOFzzL5TXKJ+j3LO7iKZUVEclE/rvx2HhzR
         MdGaM8hQY1PcCzAy8brsOKJyrMOIDIhZVYJb7AqZHQ3wlOILBIUnGKHGyIovS6OEeABS
         IwoR0ls/+MeiL2mtnhNOtYP1KZvA4fmzK5VbAwEcNYrgISYGxx9ZRtWYxJy8CocOaZmo
         +TMQ==
X-Gm-Message-State: AOJu0YylQDT6hd4Fe2C96F4Jm/RjmAgIF3qe/HmLXw5EzMrHv235xaJl
	jUGyl54hNttQlN8ibUzlh/qacH59ho3FUPl8ZR89TvlfT0ayTYru8ZxUoXVDxf2rSnJMpNg02kO
	rsHrirDa80U4qm/SMpsCcw0TWPp6bWH1qxNesZKIx7ruUnBLpL+4wo5tW0OZ2jzS7vy3uu7dKVc
	bKn7zf3ERvjyI+djIe5IWt93QO9HyrCfqtj3/Icfda/Uc3nfH9M9xR
X-Gm-Gg: ASbGncse837n1u+aF8V7GOleS8+AJxCHjPNyHlZ7FigAy5Em6WJ13bqBbbM27iXgN5z
	q9ndvQaQx5heXxD01UQU/OrwWNfU0HHB8kSYJ6B3vyOj7JIDu1o/Qgv9zrhEWBWfWHe4y7W0TTb
	No5B2Sye3eB0AFMEDMwibXq/FjxnpT7kOHl8CiS16fF7ttawP7NJUEDWQETdcsm02Ie/rqsfeFs
	a7cLjc9UypI6qg8DBTZ7dbbO8nQW/3jK/fDQToaRZ/k/BRJWJiugCresDFQaJuFD3ju5cep17DY
	WY4DrF+SBkuUdtpaapZwqXPEJefO18bmapRf9JBwEA9uTL0f4IbYDaEkgi3j+z8y/3vfIozL85G
	ulRAHjmRxUy2/Q48cWe3wF5UkJ8Lti+hNNRHyGQAelH41EsS9
X-Received: by 2002:a05:6402:3489:b0:63c:4da1:9a10 with SMTP id 4fb4d7f45d1cf-645546a3c05mr16378923a12.31.1764164310158;
        Wed, 26 Nov 2025 05:38:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmZrPvuLqorBQCW4M+q1Ph2pYbinZMaUldcA+WNpMkTP4ojfgz3kplNRhWLiwfo17xPIT7cg==
X-Received: by 2002:a05:6402:3489:b0:63c:4da1:9a10 with SMTP id 4fb4d7f45d1cf-645546a3c05mr16378881a12.31.1764164309584;
        Wed, 26 Nov 2025 05:38:29 -0800 (PST)
Received: from stex1 (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d267sm17573469a12.22.2025.11.26.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:38:28 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: improve RCU read sections around vhost_vsock_get()
Date: Wed, 26 Nov 2025 14:38:26 +0100
Message-ID: <20251126133826.142496-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0_5Z3HO7FLcdEsZSgeZO-lasCsguPlDY0J6kJ2PmLWg_1764164311
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_vsock_get() uses hash_for_each_possible_rcu() to find the
`vhost_vsock` associated with the `guest_cid`. hash_for_each_possible_rcu()
should only be called within an RCU read section, as mentioned in the
following comment in include/linux/rculist.h:

/**
 * hlist_for_each_entry_rcu - iterate over rcu list of given type
 * @pos:	the type * to use as a loop cursor.
 * @head:	the head for your list.
 * @member:	the name of the hlist_node within the struct.
 * @cond:	optional lockdep expression if called from non-RCU protection.
 *
 * This list-traversal primitive may safely run concurrently with
 * the _rcu list-mutation primitives such as hlist_add_head_rcu()
 * as long as the traversal is guarded by rcu_read_lock().
 */

Currently, all calls to vhost_vsock_get() are between rcu_read_lock()
and rcu_read_unlock() except for calls in vhost_vsock_set_cid() and
vhost_vsock_reset_orphans(). In both cases, the current code is safe,
but we can make improvements to make it more robust.

About vhost_vsock_set_cid(), when building the kernel with
CONFIG_PROVE_RCU_LIST enabled, we get the following RCU warning when the
user space issues `ioctl(dev, VHOST_VSOCK_SET_GUEST_CID, ...)` :

  WARNING: suspicious RCU usage
  6.18.0-rc7 #62 Not tainted
  -----------------------------
  drivers/vhost/vsock.c:74 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by rpc-libvirtd/3443:
   #0: ffffffffc05032a8 (vhost_vsock_mutex){+.+.}-{4:4}, at: vhost_vsock_dev_ioctl+0x2ff/0x530 [vhost_vsock]

  stack backtrace:
  CPU: 2 UID: 0 PID: 3443 Comm: rpc-libvirtd Not tainted 6.18.0-rc7 #62 PREEMPT(none)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-7.fc42 06/10/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0x75/0xb0
   dump_stack+0x14/0x1a
   lockdep_rcu_suspicious.cold+0x4e/0x97
   vhost_vsock_get+0x8f/0xa0 [vhost_vsock]
   vhost_vsock_dev_ioctl+0x307/0x530 [vhost_vsock]
   __x64_sys_ioctl+0x4f2/0xa00
   x64_sys_call+0xed0/0x1da0
   do_syscall_64+0x73/0xfa0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   ...
   </TASK>

This is not a real problem, because the vhost_vsock_get() caller, i.e.
vhost_vsock_set_cid(), holds the `vhost_vsock_mutex` used by the hash
table writers. Anyway, to prevent that warning, add lockdep_is_held()
condition to hash_for_each_possible_rcu() to verify that either the
caller is in an RCU read section or `vhost_vsock_mutex` is held when
CONFIG_PROVE_RCU_LIST is enabled; and also clarify the comment for
vhost_vsock_get() to better describe the locking requirements and the
scope of the returned pointer validity.

About vhost_vsock_reset_orphans(), currently this function is only
called via vsock_for_each_connected_socket(), which holds the
`vsock_table_lock` spinlock (which is also an RCU read-side critical
section). However, add an explicit RCU read lock there to make the code
more robust and explicit about the RCU requirements, and to prevent
issues if the calling context changes in the future or if
vhost_vsock_reset_orphans() is called from other contexts.

Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
Cc: stefanha@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ae01457ea2cd..78cc66fbb3dd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -64,14 +64,15 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
-/* Callers that dereference the return value must hold vhost_vsock_mutex or the
- * RCU read lock.
+/* Callers must be in an RCU read section or hold the vhost_vsock_mutex.
+ * The return value can only be dereferenced while within the section.
  */
 static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 {
 	struct vhost_vsock *vsock;
 
-	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid) {
+	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
+				   lockdep_is_held(&vhost_vsock_mutex)) {
 		u32 other_cid = vsock->guest_cid;
 
 		/* Skip instances that have no CID yet */
@@ -707,9 +708,15 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
+	rcu_read_lock();
+
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid)) {
+		rcu_read_unlock();
 		return;
+	}
+
+	rcu_read_unlock();
 
 	/* If the close timeout is pending, let it expire.  This avoids races
 	 * with the timeout callback.
-- 
2.51.1

