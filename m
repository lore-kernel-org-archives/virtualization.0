Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08522BD5B7
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430569; cv=none; b=avraJSqcI/ym4st6SNgxnL4q8RV7nmVNfQj6v3Cv1RBNkxpad/V/96u1YDB28RTuXP8JA1kOI84uby58b9l+WBNOdBje3ag9j3wusMxxbDQLZErSYnYjZLL1NdxswsqZ5nMNx3ID47vKBZIKflAL0Ud8RtBt9WFOVgWFbe08vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430569; c=relaxed/simple;
	bh=yE/DV+Fa+l53UFcKqQnpm7tvRiqGrYmy2+67mIwjIOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mt9vTPvXVYHDPhCI5YPBW4mSvQ+w7BMVmhvoMpSBq4HvknQ4FXhnnSV12mIXhcf/t318tQNE00nTdzGJJ24YX4mlulVNeCig2wbefsK599baKZ3IjY29Rvx0D9NDoJ/+NmMBeO/aAoHr/0uQ1i5y6qXg5teAzWWQzfxIwP/qG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6TUIDaD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6TUIDaD"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so4960707a91.1
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430567; x=1755035367; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF1xl+BFznimsCJZAMsIsfYFMKtmpYiJtkLDu4zq/fg=;
        b=Q6TUIDaDObZhoYxRoDxmLak93cjmLEFXZ9O3M7oApKGTtFesU9U0PHV8l0OFCh3XUp
         dSgK/GSfRhdqOx79aOUKxImaSOTnj3DycI04fe9Aq/i18vRS0opQ4Grag/wG8m/B+80g
         JWoP2nhbk9SumhqDKk/mire9lD9MzrLQCrC46iiKcdqofI4W3Pwr6l+gGQQfkePSTZpr
         07uvM/VXXGa1tqsldz/EJEOPHgbIskgQoa2nzzerKP9dDZ8p4akyf+M8ESoBuHWAea5E
         1LCmP+r7VflP3496LRGOzv/Z/vvuMNJIA2xyn/9M/n33KMjQu2p/E2wzJMSNQ/Pl4oBO
         VISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430567; x=1755035367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF1xl+BFznimsCJZAMsIsfYFMKtmpYiJtkLDu4zq/fg=;
        b=pjZXrMlODd0ZnvayZ8nLKuyocxVChWVQ7NBO05l5qkJdwPq0g6taaXh9R09502MQyb
         CqgURCfboRx/yBBsJWEzLFuyTKCmmY6O5+dR8qPgmNFwNsbF8305hSWPvR3+8+/i17NZ
         PD8x6LRH7J1ogcf+zzgIwQYDwdmqF6H44xDwgiQmojcOhmBo8FLsOd+3BlYoTBqcPE5f
         yby7d9fOD/OABhch0QcMZ8/SUPddR5oUongNScnzgyHNg9h82jE2TTWjyVvjbGX3ycB0
         Uw5g3Pm6a1JiRanq3BvmGhRTvXz/Hz4aqX1OsxoEbdn7mAsnGWBJIkemzFvxKCzWwO6Z
         GxBQ==
X-Gm-Message-State: AOJu0YxuRzUdgxWO31ngHeLtngx2oeGfciYTOsg8TpQiNDX4JUimySNQ
	dx5NbQDqavWhlQCXjBSHXj2pUAujk+g4yOJssjOWEBCDdZJIfAf3cV6c
X-Gm-Gg: ASbGncuw2677+ikkOkI5mAmX3Ze3qu5YB/bpT6bZ/142NrWQLvFf2QnH2NCAlTyMbqe
	7yLHODRzURsnaQjzvrJ+l+SSi8kFD02ulMfI4myU0se4sL1B9EpCSlEUWDwgf24BTgQqQ3L0da6
	WUt+ryNBeNgS2oOKXiEbvoglx0045G+df9ksrvhXOMm5pRnjt2/ace/IUP/XelebVnUmmVplW0m
	cWFD+GbzB/qgqB4q7soAiwgFGOMFBOtq8YjR8HjaoltG1MrDij+ht8zKpqA/dZV9pb4HRd6kf61
	3Jr7Gc08kdgS5qkWTfNFLLLMIDFqzWfIMtvy/efZ1Knr4wdDzaF4BPBsah05/Xq7p/PPL9yTakW
	q2ee7vN9u6Quaf2nD5clHjXg/cvKLUg==
X-Google-Smtp-Source: AGHT+IHCmjITq2EcgeFufDBMLSAU8t8naXO7KFWocNSlYPDmL+mvWgkr7b7AJS9sPJlmK72xrdsQOg==
X-Received: by 2002:a17:90b:4b:b0:31f:1db2:69b1 with SMTP id 98e67ed59e1d1-32167552daamr393375a91.18.1754430567204;
        Tue, 05 Aug 2025 14:49:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm17878352a91.6.2025.08.05.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:17 -0700
Subject: [PATCH RFC net-next v4 09/12] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>
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

Add NS support to vsock loopback. Sockets in a global mode netns
communicate with each other, regardless of namespace. Sockets in a local
mode netns may only communicate with other sockets within the same
namespace.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h         |  4 +++
 include/net/netns/vsock.h      |  3 +++
 net/vmw_vsock/af_vsock.c       |  8 +++++-
 net/vmw_vsock/vsock_loopback.c | 59 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 0c0c351394de..aefff6e102e7 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -305,4 +305,8 @@ static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
 	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
 		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
 }
+
+int vsock_loopback_init_net(struct net *net);
+void vsock_loopback_exit_net(struct net *net);
+
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index 0bad4652815c..4420346e10a8 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -7,6 +7,8 @@
 #define VSOCK_NET_MODE_GLOBAL	1
 #define VSOCK_NET_MODE_LOCAL	(1 << 1)
 
+struct vsock_loopback;
+
 struct netns_vsock {
 	struct ctl_table_header *vsock_hdr;
 	spinlock_t lock;
@@ -14,5 +16,6 @@ struct netns_vsock {
 	/* protected by lock */
 	u8 ns_mode;
 	bool written;
+	struct vsock_loopback *loopback;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index c69c2db03162..5689ce7d5843 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2778,9 +2778,12 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 {
 	vsock_net_init(net);
 
-	if (vsock_sysctl_register(net))
+	if (vsock_loopback_init_net(net))
 		return -ENOMEM;
 
+	if (vsock_sysctl_register(net))
+		goto err_loopback;
+
 #ifdef CONFIG_PROC_FS
 	if (!proc_create_net_single_write("vsock_ns_mode", 0644, net->proc_net,
 					  vsock_proc_ns_mode_show,
@@ -2793,12 +2796,15 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 
 err_sysctl:
 	vsock_sysctl_unregister(net);
+err_loopback:
+	vsock_loopback_exit_net(net);
 	return -ENOMEM;
 }
 
 static __net_exit void vsock_sysctl_exit_net(struct net *net)
 {
 	vsock_sysctl_unregister(net);
+	vsock_loopback_exit_net(net);
 }
 
 static struct pernet_operations vsock_sysctl_ops __net_initdata = {
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..4fc07e3a1d2b 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -28,8 +28,19 @@ static u32 vsock_loopback_get_local_cid(void)
 
 static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
+	struct vsock_loopback *vsock;
 	int len = skb->len;
+	struct net *net;
+
+	if (skb->sk)
+		net = sock_net(skb->sk);
+	else
+		net = NULL;
+
+	if (net && net->vsock.ns_mode == VSOCK_NET_MODE_LOCAL)
+		vsock = net->vsock.loopback;
+	else
+		vsock = &the_vsock_loopback;
 
 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -46,7 +57,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +117,7 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }
@@ -134,27 +145,55 @@ static void vsock_loopback_work(struct work_struct *work)
 	}
 }
 
-static int __init vsock_loopback_init(void)
+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
 {
-	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int ret;
-
 	vsock->workqueue = alloc_workqueue("vsock-loopback", 0, 0);
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
+	return 0;
+}
+
+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
+{
+	destroy_workqueue(vsock->workqueue);
+}
+
+int vsock_loopback_init_net(struct net *net)
+{
+	net->vsock.loopback = kmalloc(GFP_KERNEL, sizeof(struct vsock_loopback));
+	if (!net->vsock.loopback)
+		return -ENOMEM;
+
+	return vsock_loopback_init_vsock(net->vsock.loopback);
+}
+
+void vsock_loopback_exit_net(struct net *net)
+{
+	vsock_loopback_deinit_vsock(net->vsock.loopback);
+	kfree(net->vsock.loopback);
+}
+
+static int __init vsock_loopback_init(void)
+{
+	struct vsock_loopback *vsock = &the_vsock_loopback;
+	int ret;
+
+	ret = vsock_loopback_init_vsock(vsock);
+	if (ret < 0)
+		return ret;
 
 	ret = vsock_core_register(&loopback_transport.transport,
 				  VSOCK_TRANSPORT_F_LOCAL);
 	if (ret)
-		goto out_wq;
+		goto out_deinit;
 
 	return 0;
 
-out_wq:
-	destroy_workqueue(vsock->workqueue);
+out_deinit:
+	vsock_loopback_deinit_vsock(vsock);
 	return ret;
 }
 

-- 
2.47.3

