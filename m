Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42E21E0AF
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341105; cv=none; b=ZOtgTfYgGuGxekdaQWCf9p2yaRt8HgBMBGlBxkT6l8sIsM2C59S3DyTT9fM9rESLUkv3/5bK7EXGVRtGAl9QvHo9HkHle3JRuqOPfpk60LgqFO1TA/PrZrwT/Pe1Ut3JIP6hgCxiK3pgwFKkiwapBmhrBbZqEUKkGNiIgTH+sZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341105; c=relaxed/simple;
	bh=1GJOYUbLkSVUFuavBj8tOYipR+NhigVATpZKUWUhpl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gECl6c4hOwc7P4E1AQsOZyza8+db3UBLk5Q2x0G/+QFlSznQoyKXj8pR41x9MreJvldrt+U9VjWP9inAHQmG8puScZo5yTO4EwwM1En2YMIkV+Yrfx0xC7bWPHlhvW2ybtDcJQd0KV+lQeavMQ1gFP2gzG74o+M+E3nLLdsP2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4f6JnHE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4f6JnHE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49db86cac4so315289a12.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341103; x=1756945903; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saysWBU4M7zZK6muNIPjMH0cBIXV8HIpOLa1ReuiyVc=;
        b=c4f6JnHEo5eBvcHmKU0MHYnXY34Pb1XyA99k+BZ8dtFSjSNPnJR7MCq00GLrP/Gwlo
         EHe+1lcesaPGnGGG1oR5TJAjfIkI7wkTIIvF6uI2KUg3DRSKk3z1fp2AiibJGySUl3Et
         dP7KJCQqV1EAbZPQqvrtGKRn/fUpqOPdqTTiEskUupxPhlanqgOTpr7NoQe26TWwpNEb
         qkAs1XXH1oSOza3wGD9BX+48YU0O1T3S7Q86iQ8GtrUCWLpYPK/Rlzu/LLc0nYrn/4tT
         I959wPqcYmPHFfGh5uRTsZD1oGIcGf1nIEaG+PevdYEaVuJi2UYO3eV23PL7R67GKoOT
         dNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341103; x=1756945903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saysWBU4M7zZK6muNIPjMH0cBIXV8HIpOLa1ReuiyVc=;
        b=vBl7BKCxqkIEHfdxZsghBJ6hGb/YUkaRipd2SMQypCecb+/RGrcMyv7VjQ9/9XcO2P
         ZcJlUOb7VTra23utbjPunEzLn7MHjTyp2Kv73LMSJNnrg0bOyctAK1Yz4Q7z5d53epdX
         aMemkVlVOo/ds6HQzdwJQOt2TUfFpr+/5sc/65kuFnkeLGo+aWU4PYWMOb0ezUVzTplI
         y2qMP82yaa8a61yOLHCkn3cOQuChoUNK7Z9Gn7VzGITvxKx0/6WbjLmuK0gniU2aB1Fk
         J9/ibS2v432Vz8glkIrHmXpMzc5rzFLrnR1LiiAkCnnbA/tOy5URU8q8FrfERqkzZQsw
         v7yQ==
X-Gm-Message-State: AOJu0Yw2DrYqjmxAdm5lbTMTJxM8qK2Qc5EAcPcs9Su9BogMieDzQnux
	fqjO9FCfEM7ZFh3OKJcUnh1T8zlZPHiE3EUyjmLcBPAxawbn5DdNxl0i
X-Gm-Gg: ASbGncuRZUouyKztP1zhAhzYJpe+TCvVMX4G+OO1Lj0TQW6Jx2MyrwgOHGREM+6BOnr
	ldxW4B077zoVey975n0PEpVTaBFg8g/hWncNm5yr+tQAJLoR78NQWU6gCW7COZLhDwkJe0QcNAu
	Sr2Yv9fdHqPErtJp0F6jn4I6eek2TgKwhXo74ZaFpx4t+ZHXF9ikigwIN4V5udBST4Hjt5ERONp
	0004nDV+9KGhbwlOsQ3qr9K0DyNuePu7UhlUmVNltaSLkme3M9jkCbGow/r74FOVdbJR4QvPB+q
	Jfpz9H/JSGC10p3a1vwtXmB3M3CmZNYRbusYNGzQ+HYp9lQcyhxQkJuDyJ6rYMm8baZ19GINgqm
	7LMNJyYAHUh2ABxX0X3yK
X-Google-Smtp-Source: AGHT+IFKdbFnw9poUFr+kYVT0cwCfnfmVv/oxnRCgfFdvBFZZP6G4plqa6FPpGcS35Ongi0a99gCnA==
X-Received: by 2002:a17:90b:2ccf:b0:321:4765:a423 with SMTP id 98e67ed59e1d1-32515eadd16mr26985871a91.6.1756341102437;
        Wed, 27 Aug 2025 17:31:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327aafa8e3bsm485779a91.0.2025.08.27.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:34 -0700
Subject: [PATCH net-next v5 6/9] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-6-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
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

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

vhost_vsock now acquires a reference to the namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..f7405bb27aab 100644
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
@@ -67,7 +69,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +80,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid && vsock_net_check_mode(net, vsock->net))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -272,13 +273,14 @@ static int
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
@@ -305,7 +307,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -462,11 +464,12 @@ static struct virtio_transport vhost_transport = {
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -526,6 +529,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
+		virtio_vsock_skb_set_net(skb, vsock->net);
 		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -652,10 +656,14 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
+	net = current->nsproxy->net_ns;
+
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
@@ -669,6 +677,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -708,7 +717,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -753,6 +762,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -779,7 +789,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3

