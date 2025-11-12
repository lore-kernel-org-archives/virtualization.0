Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F402E041D
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930546; cv=none; b=Vc6VXqkvtWPZ6CCEr41GwboC+RbsDhV+0IHqtgkrJFlLnPnOOL83bAkuk3O7uudqlFLIa8776fJ53vustR2kGm1ixUSGIpCBM6F2cD1cwg4pYQR694ym3ZjXbLxSCAfvMfS5dQyjfDB0lImNLTCnmj98t+LrdwY2ArblcbCGvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930546; c=relaxed/simple;
	bh=t3Mr2b2gsOk7wPSdnxB9LNMHOkokWCDokVYefblhvtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0nr1+vSdRX4U6miFZ2BI2UnZd7+r9LkDD44sy/BaJ98AO4C4h2Um8At8jjabaBBa0LiPtc89wHrZzx6OU7G6J2Jsr3NiGZx0TUlq0U+4yKdy/WQwDhUyFDjR8Z3myTLJ3hsM7hxwjIQz/xjpbgxJHRUUTmN3sw0vQXnKinPImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl9m16R4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl9m16R4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ade456b6abso419590b3a.3
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930541; x=1763535341; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mie3ZonY5nqk3uh/MZASToKCQwxL+qxHRmkzFBuqQWw=;
        b=gl9m16R4o9Fj8/m7+7qPyvrzThIqMY7FV6OQM+/8QPi86+Qsus3o0S/W1QXBhcFIOa
         1qCQMEKJXaOYfD+AYto1P+LY5c1o89ok0z+Id4BZRsZfg3wMSjmgcTumhj1bHQ4P8PEZ
         Uq92dWxadzmhQT7wNSRM/qrWdpDXeHeDZlxFQVNhuX8reVU47aqlO2T6XQJM9mn5z141
         eEjbxvF4VkSwOze8lLR5vuWXu2vU5no2LC2W3LsLQX3GOrhLD8XyhNJJ4gWGxoMyfd86
         THY77cyxp0WdHA24hPu2knW1h2hEeReVbOfufWOZ28WwNOKe9wWPF7DxuIc+lD46g/aE
         Wmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930541; x=1763535341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mie3ZonY5nqk3uh/MZASToKCQwxL+qxHRmkzFBuqQWw=;
        b=pLds0bftzKXpjSlnTbddVuGm91DjtEInU08hhwQ0aDescyDQBKBpDl+ZbT23/54/oz
         SnWk0aPRrMZxpDSyBUtSRVhWLvUiXA//bY0hfs5+z4k3QCiQl3pxeTb3n9qEqXJhzk1N
         7GO+4Q/B7f8nuIZn/PwYXarn59yjsB0i55g4MQsNX55eVAUl5Hd2o2xYxP7Xp5/c9L6I
         PGd9Zxek+59SzgC6ZYP8u3KlQIAE+JPOQ0d00yNji9SaS0oMinUMf5EH7uOwP5anp8Sx
         Kf3NGB05t8ECqH3itKk11U8oAs/eosiTxWFWBVm/I7ykgp9NZ2kCxVqYsTpobeGhxYJO
         oBvA==
X-Gm-Message-State: AOJu0YyqSCDxyDB3khmd/ZD+a35Q6n3dm4U9mLcZRDqCP7cHAUYigyI0
	DnObi3RPY/3G5gXb2oIvSvD0Jmi3KXn7YsuBFJ/Vdg8m3qAnbx9GvEN9
X-Gm-Gg: ASbGncuB9ES6yCff5+6+KgSVNGAvwNVn+tYMrscNIiKh3pOqP5tDDNDIUGd0TfN5lOj
	x+Wm08TdQnq3w8qDvF9vBL+BDviNUbkwSl7JFATXWaSB1ZEDjg8Q0JZsuK0f94Bqy+XtmQiwACf
	+bBtzyMIAicrC7USz78jpUl8dOpaMlK4HHjDL2CIzvLIugp7KdYqiTY8zHnj55Wti6i9ciCiQU/
	yhEvMbt4PU1Ci2BUziEPPfoKZskbTtxQopL0gi2T5/GIxxGherJc8BVO32dBt/HZCfVNVh0IylD
	JJSJOI7YiR2+444GvKIFh2+oI0qqcvtqj5/2oJ2hgovITkPldkCnm4TNZzweobPXtP/9tHEtofp
	c5TfCMoU0AC3VSSrTuQz4WvRUnV3Rjj6J8gm5KV+a19wX88UKUBVbPiyDxjkPhi1zS8SMVv46
X-Google-Smtp-Source: AGHT+IGXZ7rfVWqB/ewlsvm7a/xd5BUW9p1lVk1z0FAiIDIraulNlsTqgpff+V8VlwM/dYWbNIS7mQ==
X-Received: by 2002:a05:6a20:3d82:b0:342:a7cd:9214 with SMTP id adf61e73a8af0-35909f65ad7mr2812752637.23.1762930541432;
        Tue, 11 Nov 2025 22:55:41 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0ec4f68esm1664489a12.1.2025.11.11.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:41 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:49 -0800
Subject: [PATCH net-next v9 07/14] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-7-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vhost-vsock flows using namespaces.

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

When namespace modes are evaluated during socket usage we always use the
mode of the namespace at the time the vhost vsock device file was
opened. If that namespace is later changed from "global" to "local"
mode, the vsock will continue operating as if the change never happened
(i.e., it is in "global" mode). This avoids breaking already established
flows.

vhost_vsock now acquires a reference to the namespace.

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- add more information about net_mode and rationale (changing modes) to
both code comment and commit message
Changes in v7:
- remove the check_global flag of vhost_vsock_get(), that logic was both
wrong and not necessary, reuse vsock_net_check_mode() instead
- remove 'delete me' comment
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0a0e73405532..09f9321e4bc8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
+	netns_tracker ns_tracker;
+
+	/* The ns mode at the time vhost_vsock was created */
+	enum vsock_net_mode net_mode;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -67,7 +72,8 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
+					   enum vsock_net_mode mode)
 {
 	struct vhost_vsock *vsock;
 
@@ -78,9 +84,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid &&
+		    vsock_net_check_mode(net, mode, vsock->net, vsock->net_mode))
 			return vsock;
-
 	}
 
 	return NULL;
@@ -279,7 +285,7 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, net_mode);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -306,7 +312,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)), vsk->net_mode);
 	if (!vsock)
 		goto out;
 
@@ -463,11 +470,12 @@ static struct virtio_transport vhost_transport = {
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
+	struct net *net = sock_net(sk_vsock(vsk));
 	struct vhost_vsock *vsock;
 	bool seqpacket_allow = false;
 
 	rcu_read_lock();
-	vsock = vhost_vsock_get(remote_cid);
+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
 
 	if (vsock)
 		seqpacket_allow = vsock->seqpacket_allow;
@@ -538,8 +546,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, skb, NULL,
-						  0);
+			virtio_transport_recv_pkt(&vhost_transport, skb,
+						  vsock->net, vsock->net_mode);
 		else
 			kfree_skb(skb);
 
@@ -654,8 +662,10 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -671,6 +681,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
+	/* Store the mode of the namespace at the time of creation. If this
+	 * namespace later changes from "global" to "local", we want this vsock
+	 * to continue operating normally and not suddenly break. For that
+	 * reason, we save the mode here and later use it when performing
+	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
+	 */
+	vsock->net_mode = vsock_net_mode(net);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -710,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -755,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -781,7 +803,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3

