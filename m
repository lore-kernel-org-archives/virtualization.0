Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5522D5923
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090430; cv=none; b=ihLz3oGi1kVntlFRXTUS2oUShxh+PdEDsO0ChuTuk2169k/ggLY/VwX72881iSD3pBmzr9BxcCFwTDUnMsUO//EHqi7FoAIh5cKfVrDsLhmoJ0PVbBXgq5DHzrR7uYnEZL3FwH/XzU1tqOy043c7Cq1l2xmxfGkO4nfeUnkgV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090430; c=relaxed/simple;
	bh=b0fx4C78pSOxYqC0cxHVGuTmxqUvfnqQA1i++829AIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRP0tWh7/4VPImqpALohCSSZArqTD7fNvW8aOgmtAaiAwU35rq0ffcPqTILjA1fd31uIV+9C3ax/ArR0oJ8LoeWRwifs9q6k13uxTgsHeFRT1etJKRfxJeDW+6jva/JHQrB4wx/yvYWJ30I57EcwVkNNPefiQCyQtFolxSv35eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsvRxYMY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsvRxYMY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290a3a4c7ecso66514265ad.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090426; x=1761695226; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s2iAlMKc65CfdOkkKY67qSFEWtoKyndRoIh13CYBQA=;
        b=OsvRxYMYMEu20BsddYYPG0QetHt25MrDBbdX32qi2SrUZNwMrMlkRT1Y3XT4xiaZaz
         6vtfy8AUWrule1cVBTpB0Gj5dH3+tqhPXeOJUtG8pzWT+MSlqT+tlaedA0n9tACPTiLQ
         yOfWiUpXCTt4JZZ7pPtA543syF0qopGlibDI3l0tHQW06wDNGSbf69Ej7oa4JhhFvmCs
         6djxPoR7CxDWnKnXbEx30lJy0QeiNoExiU+Pm3lutcvfE3LkNeMrWJEhyfmVY4408E71
         r9xzhUHntkvrAaPipsaZ/ITyGGGTFkQZp/3W/HDz/I9UOOw1c1PSK2p95WJ/V0LYK967
         0OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090426; x=1761695226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s2iAlMKc65CfdOkkKY67qSFEWtoKyndRoIh13CYBQA=;
        b=Ykam1wbFcyhk409jdzIQT/UlU3mgy5H9d/y4kG42ODgQRtdxGxUBgGnQXjQo4PJb14
         FEFzyD/XF6L0qe/kCu5hHQCfIuZ/EXBSRADpTpDw+esEEHMQWS4N19i3BUHJl8cv2Dig
         tdMe49pf353RAOeBV8wV2DCN0Nr59yHjvGIUnd87vxeNFIgyIFJlsRgAziAHTFzsi7cr
         CBGOVL9sUvHdZ+AZO0dAKXXEHe3+Rs4keAG+1LUqnYkCySn8TGs07fKtYRsWcTcCVePo
         0Q31+vzQud93GEVXo53lJ6hK98PT9zhdcq2I0lF6wNqCjBp0+EgzsBAImJ1czzgOSSlH
         3+OQ==
X-Gm-Message-State: AOJu0YyReQcCyDA+PhV8rE9nrCs16RNbb/PLG/DdafsEbubC1d+Sw1lv
	MmTxZOEyoo29hAqKh+61OJLf9c+h50TWFYc1HzUib2Y1p0Jnb/AC+iOX
X-Gm-Gg: ASbGnctenbKCPnA0iLluJV442CuAP2lTV8Ms5JTtZBL1FRX9PkF5qofM7Ixmwb48Cfm
	xOa4TrolQ98YytfAfmdGprC11Jzl9EJ/MKssc9zBeYf7Ej78XQqK3OcybwroOz5WBm2cKxrf0Qb
	DVuiybh4emyPyl975gAzKroy8Rnwt0Z4qch/s67X0rzySc26CnH+qa2ps19r+2aFTmn3+42a+Zb
	WgyYC6K09XdaIS1Ku95iYoaaj1QKNsbRBkBgcA5IcvK1LWk8M7nWCYEzgiGrR59HA690E5pX2BT
	4w68fevOnvful9KWHEWUmmbRYlUo8T2R+iVWpt+PsrHIS8j4zPcxWmXaecNkRU6N3Ven52P+74k
	cWMakGqAVrQA0VBTLb/pj0BVkpHlbgXl42X59rT3oz9iTBl+tjZ5l/npU8uaCGlY5Ay9gwcuwDJ
	pLkO8i
X-Google-Smtp-Source: AGHT+IFdsZolmIiFqyPtZksL/bCEkBQ9alY5GAJRyheOzwEUfAbu76rqKE+4kW6zc2Tl2YxsalyEyw==
X-Received: by 2002:a17:902:fc4b:b0:290:8d7b:4047 with SMTP id d9443c01a7336-290c9cbc4c9mr215031465ad.21.1761090425791;
        Tue, 21 Oct 2025 16:47:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6cfsm121026415ad.107.2025.10.21.16.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:50 -0700
Subject: [PATCH net-next v7 07/26] vhost/vsock: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-7-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the ability to isolate vhost-vsock flows using namespaces.

The VM, via the vhost_vsock struct, inherits its namespace from the
process that opens the vhost-vsock device. vhost_vsock lookup functions
are modified to take into account the mode (e.g., if CIDs are matching
but modes don't align, then return NULL).

vhost_vsock now acquires a reference to the namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v7:
- remove the check_global flag of vhost_vsock_get(), that logic was both
  wrong and not necessary, reuse vsock_net_check_mode() instead
- remove 'delete me' comment
Changes in v5:
- respect pid namespaces when assigning namespace to vhost_vsock
---
 drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34adf0cf9124..df6136633cd8 100644
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
@@ -271,14 +277,16 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 static int
 vhost_transport_send_pkt(struct sk_buff *skb)
 {
+	enum vsock_net_mode mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct vhost_vsock *vsock;
 	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, mode);
 	if (!vsock) {
 		rcu_read_unlock();
 		kfree_skb(skb);
@@ -305,7 +313,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)), vsk->net_mode);
 	if (!vsock)
 		goto out;
 
@@ -327,7 +336,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 }
 
 static struct sk_buff *
-vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
+vhost_vsock_alloc_skb(struct vhost_vsock *vsock, struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
 	struct virtio_vsock_hdr *hdr;
@@ -353,6 +362,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	if (!skb)
 		return NULL;
 
+	virtio_vsock_skb_set_net(skb, vsock->net);
+	virtio_vsock_skb_set_net_mode(skb, vsock->net_mode);
+
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
 	hdr = virtio_vsock_hdr(skb);
@@ -462,11 +474,12 @@ static struct virtio_transport vhost_transport = {
 
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
@@ -520,7 +533,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			break;
 		}
 
-		skb = vhost_vsock_alloc_skb(vq, out, in);
+		skb = vhost_vsock_alloc_skb(vsock, vq, out, in);
 		if (!skb) {
 			vq_err(vq, "Faulted on pkt\n");
 			continue;
@@ -652,8 +665,10 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 {
+
 	struct vhost_virtqueue **vqs;
 	struct vhost_vsock *vsock;
+	struct net *net;
 	int ret;
 
 	/* This struct is large and allocation could fail, fall back to vmalloc
@@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	net = current->nsproxy->net_ns;
+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
+
+	/* Cache the mode of the namespace so that if that netns mode changes,
+	 * the vhost_vsock will continue to function as expected.
+	 */
+	vsock->net_mode = vsock_net_mode(net);
+
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 
@@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net_track(vsock->net, &vsock->ns_tracker);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -779,7 +803,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;

-- 
2.47.3

