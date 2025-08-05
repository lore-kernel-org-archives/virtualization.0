Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040529B21D
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430563; cv=none; b=tt9ooiBLmh2DVNIU11MXk+JVtfZF0x9LS1NKh4TaF/3Q0jvdmTXq8QjqXhJeem2TX8fF8z5hzWQ5JGf65/zEFTHZ6YQik4zJTlgTU3jt8sOSAa383TAKYR9tpsyCCBB1Txga28jQKMMeeuy9W7RdPTqfJ/rhgpsAE3l0CEIcu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430563; c=relaxed/simple;
	bh=4nOiUR2yclelPvjzHls90OB1HWOtZ8j4Fd2CwpbPgy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjH82assKEdswV3ZwPjWdqZxjDU3IUDbox6SYeWgTBrNuVxuqEgU6WNy6HC5FaW62eGq7cIFvRoaVeNi7siorsJL9IlsdtwrX+u+ki7brGuWfN3S1WhqLDIfcxiTFqUW8uTxAkkpqOyHKGoI3tGgcupUF81V9uBXDiRGUpu/Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIpHWsA/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIpHWsA/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2406fe901fcso49668965ad.3
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430561; x=1755035361; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIzbPe6n99JFgKHn/5BXgj7yzYZCxe9bDEHL/cgVeVU=;
        b=UIpHWsA/GacFAQOevZT2DcMR7SfUY8j1QwWhg60t2AOYovySqGt4BO4/+6OYs+z77z
         84vJLtrn5uJ4uobGY71nqx82zM5Dac539wE/oviPHefL7D+KPlvaieNhUBS04pbqoI59
         slhyjiK6ZQkMs1Nvb3bDRdKAFVBkZWyJuR9R/uQrOWMfu+T5/zmRGu2lCQNwA4t1IufC
         1JSrZtG/ZhsHx49IacPOVOz7HOJslzjwYNX2Uu3SIlIYdn0CNBnq1tkMAKeQ0daFDvKA
         a2TXUbGSUDtF9rhjwGXSjX43n9XFx5bPrSXdMyHvT4Z5s61CZd9jDY01hJovWXro48ze
         hMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430561; x=1755035361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIzbPe6n99JFgKHn/5BXgj7yzYZCxe9bDEHL/cgVeVU=;
        b=IfnB3hZGlexve4HbUu9f6C+OFco/MoTKGy4evn6Oa9X2FhR/NCHMPFfP2IXtnvPbdw
         ZQiiKW/5Iv5QXDpKRYi0bu0gHQFhmGN+Y08fnIVk9di+w5vj9RZZe0vOwQsPItHRNS67
         V1eWdMUFG4a8UlG91E7lpoIwBkZMZYaKILe+LSlvKJz+aPslsDEmzkaUGjj+FyOgem2l
         tox1r6qyDywwVa3YEyCPtm/3XXQEFJ6PjMmUGm0bqeT0tqIXfqK1i37SA7tojPRHX/TT
         Wcih26cEIeIv8pjPU5njMji3mpT9PCJEVtSPqPaESbLsjobJkr5/DQ5zDYyMt55HiMzc
         HfuQ==
X-Gm-Message-State: AOJu0Yym9UFjMGv5JXaqBNaqt+9YnMdKpM07Vs7GUiYStvHM9wElBemh
	eLO33CyUHGW1tQwNXkBgK6y338W1EvlWRUQwqH0sD3KOKsbzWKBan4qi
X-Gm-Gg: ASbGncuQvA2GHsuJbHlC4NsbHBIT3wRL7XqfMYseDN5D3RXZmKWMGpdApHkOev7RAmb
	lhm7zEhXt+zs4RXGISa7F3FGck5DghZPp0zMcE/oubWKZBKHmBoVJf/qTXtKU9YqBbdPel/y2hS
	M8OCgI5to9shxXIWf4IGioFN/vDTHasjgP69fEwFrRosNkCMVZn/9+DaYz78pAsM5UUxoZmNpUf
	Z8BOtjxmG0OUeG32zfBjmQpwBTJ9p5xHx/+RnXHm6D4QGh5WWZ1VQykBIcfHiaE1ITOdG9i4ANw
	OqckKysz+LAjL6Vg0SkgI/v8sUMU52fbASN/56Sq1yGeW3ZGoFoDFsEXfCMq5kpYryFlEub58hY
	YeZauD3/OhLK0hdNXB0fc
X-Google-Smtp-Source: AGHT+IH30GOU7ALtk6a4Qu69GWLu4nFmm7a9hAyqteGUmf/zmxX9XY6X82MDI/g8fCQ810jQb8Mvgg==
X-Received: by 2002:a17:902:e850:b0:235:e942:cb9e with SMTP id d9443c01a7336-242a0a765f6mr3164885ad.9.1754430560589;
        Tue, 05 Aug 2025 14:49:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67aesm142920695ad.6.2025.08.05.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:13 -0700
Subject: [PATCH RFC net-next v4 05/12] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-5-059ec51ab111@meta.com>
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

Add the ability to isolate vsock flows using namespaces.

The namespace for a VM is inherited from the PID that opened the
vhost-vsock device.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/vhost/vsock.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..863419533a3f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -46,6 +46,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -59,6 +61,22 @@ struct vhost_vsock {
 	bool seqpacket_allow;
 };
 
+static void vhost_vsock_net_set(struct vhost_vsock *vsock, struct net *net)
+{
+	if (net_eq(net, vsock_global_net()))
+		vsock->net = vsock_global_net();
+	else
+		vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+}
+
+static void vhost_vsock_net_put(struct vhost_vsock *vsock)
+{
+	if (net_eq(vsock->net, vsock_global_net()))
+		return;
+
+	put_net_track(vsock->net, &vsock->ns_tracker);
+}
+
 static u32 vhost_transport_get_local_cid(void)
 {
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
@@ -67,7 +85,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +96,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid && vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,13 +289,14 @@ static int
 vhost_transport_send_pkt(struct sk_buff *skb)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct vhost_vsock *vsock;
 	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -305,7 +323,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -403,7 +421,7 @@ static bool vhost_transport_msgzerocopy_allow(void)
 	return true;
 }
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid);
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
 	.transport = {
@@ -459,13 +477,14 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
-static bool vhost_transport_seqpacket_allow(u32 remote_cid)
+static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -525,6 +544,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		virtio_vsock_skb_set_net(skb, vsock->net);
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -651,10 +671,16 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
+	net = get_net_ns_by_pid(current->pid);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
@@ -668,6 +694,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vhost_vsock_net_set(vsock, net);
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -707,7 +734,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -752,6 +779,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	vhost_vsock_net_put(vsock);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -778,7 +806,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3

