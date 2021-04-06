Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC9C433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 18:32:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457D4613B3
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 18:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457D4613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00814607D8;
	Tue,  6 Apr 2021 18:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbvDJ3QugO-5; Tue,  6 Apr 2021 18:32:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BBCC60681;
	Tue,  6 Apr 2021 18:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41699C000C;
	Tue,  6 Apr 2021 18:32:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2E34C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 18:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1BE740E67
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 18:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWG41Eq_bXOM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 18:32:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F259840E58
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 18:32:19 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id z16so3603342pga.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Apr 2021 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=wJYY7GheEfi4pAlAAImgP5+fKrfCF1HoyhnRAbs6anc=;
 b=AsPYSFuJ/MxoZ8nLlETL64Sw3kAei32+x1lou6DFVApI4YThP4BinxUGubF9lIOmh9
 hXNBgWR9accVSmIdjgZ/xCqWWiWUBlijowOOfOWO0BkbaW6jGwiJWts2DvWqPuKVjvC0
 ENpX3l/xQkxTPmMMWpRMz/rBBadj+2Or5W1N7CDyISi4PNG8rsMrM13GXA6oEELoF90A
 YHEq3g/sFQSrdx2BK0cGT87UgC1HZlUawoT37sEc9mSTASaU5GrgqqYgWeHvk7kpbogr
 QM08+bTmNSE5TSI4ePWZKLYcUf864ZVuTIyQHRjf4qkFcuRMUi3fLvlSd63Q7ZIr7poB
 Q5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wJYY7GheEfi4pAlAAImgP5+fKrfCF1HoyhnRAbs6anc=;
 b=fhxjB1itbru752ESZawloyBILed9C5zes5DqkSinHGrtZNWDjXP0akV3Kti4bMFzmz
 kcJ4wPhIHJcSo4m3++T0gDNXHtcXNkdretck9MK471ECKjTB7A9XuPMJv/MhcdH/MQlN
 8g2hmtC90gq4anFC4tDvnWCATOCRQMgEovFVeZroEg6olXykYi0vG7dvo5UuD1DJWWVo
 5JRBvAf3SOW0rTsRnRoLUc8dcL2w4QPHwH9qn6jFbJZqPzU669D8MTJUpv4MY1BPc+IY
 hHFaA7xPgqHN5CXS1Edprnd/GFtwxlM9bk8MjhkjzoLMuYKlbFgwWl/yB7W9SXtw9/jm
 oyIg==
X-Gm-Message-State: AOAM531+ARUM7W8VxFqjDcdk7+o8ICTQiWSHEdA9VhGoECPAWUJh7sX6
 6EQ8o43Pk/uOeBNxV+wHnFK3thyr93vWHTfn
X-Google-Smtp-Source: ABdhPJy4OUn/0jt7U5Nws0G79lY7PqciaCZKw7vcPHC++mlJ+DjJEWqE40lZK/2ll7bJy9zyx2xRYA==
X-Received: by 2002:a62:8f4a:0:b029:20a:448e:7018 with SMTP id
 n71-20020a628f4a0000b029020a448e7018mr28602340pfd.62.1617733938703; 
 Tue, 06 Apr 2021 11:32:18 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id h21sm18475139pgi.60.2021.04.06.11.32.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Apr 2021 11:32:18 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: 
Subject: [RFC] vsock: add multiple transports support for dgram
Date: Tue,  6 Apr 2021 18:31:09 +0000
Message-Id: <20210406183112.1150657-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 Andra Paraschiv <andraprs@amazon.com>, "jiang.wang" <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Norbert Slusarek <nslusarek@gmx.net>, stefanha@redhat.com,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: "jiang.wang" <jiang.wang@bytedance.com>

Currently, only VMCI supports dgram sockets. To supported
nested VM use case, this patch removes transport_dgram and
uses transport_g2h and transport_h2g for dgram too.

The transport is assgined when sending every packet and
receiving every packet on dgram sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
This patch is not tested. I don't have a VMWare testing
environment. Could someone help me to test it? 

 include/net/af_vsock.h         |  2 --
 net/vmw_vsock/af_vsock.c       | 63 +++++++++++++++++++++---------------------
 net/vmw_vsock/vmci_transport.c | 20 +++++++++-----
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index b1c717286993..aba241e0d202 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -96,8 +96,6 @@ struct vsock_transport_send_notify_data {
 #define VSOCK_TRANSPORT_F_H2G		0x00000001
 /* Transport provides guest->host communication */
 #define VSOCK_TRANSPORT_F_G2H		0x00000002
-/* Transport provides DGRAM communication */
-#define VSOCK_TRANSPORT_F_DGRAM		0x00000004
 /* Transport provides local (loopback) communication */
 #define VSOCK_TRANSPORT_F_LOCAL		0x00000008
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 92a72f0e0d94..7739ab2521a1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -449,8 +449,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 
 	switch (sk->sk_type) {
 	case SOCK_DGRAM:
-		new_transport = transport_dgram;
-		break;
 	case SOCK_STREAM:
 		if (vsock_use_local_transport(remote_cid))
 			new_transport = transport_local;
@@ -1096,7 +1094,6 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	struct sockaddr_vm *remote_addr;
-	const struct vsock_transport *transport;
 
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
@@ -1108,25 +1105,30 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	transport = vsk->transport;
-
 	err = vsock_auto_bind(vsk);
 	if (err)
 		goto out;
 
-
 	/* If the provided message contains an address, use that.  Otherwise
 	 * fall back on the socket's remote handle (if it has been connected).
 	 */
 	if (msg->msg_name &&
 	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
 			    &remote_addr) == 0) {
+		vsock_addr_init(&vsk->remote_addr, remote_addr->svm_cid,
+			remote_addr->svm_port);
+
+		err = vsock_assign_transport(vsk, NULL);
+		if (err) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		/* Ensure this address is of the right type and is a valid
 		 * destination.
 		 */
-
 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
+			remote_addr->svm_cid = vsk->transport->get_local_cid();
 
 		if (!vsock_addr_bound(remote_addr)) {
 			err = -EINVAL;
@@ -1136,7 +1138,7 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		remote_addr = &vsk->remote_addr;
 
 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
-			remote_addr->svm_cid = transport->get_local_cid();
+			remote_addr->svm_cid = vsk->transport->get_local_cid();
 
 		/* XXX Should connect() or this function ensure remote_addr is
 		 * bound?
@@ -1150,13 +1152,13 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out;
 	}
 
-	if (!transport->dgram_allow(remote_addr->svm_cid,
+	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
 				    remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
+	err = vsk->transport->dgram_enqueue(vsk, remote_addr, msg, len);
 
 out:
 	release_sock(sk);
@@ -1191,13 +1193,20 @@ static int vsock_dgram_connect(struct socket *sock,
 	if (err)
 		goto out;
 
+	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
+
+	err = vsock_assign_transport(vsk, NULL);
+	if (err) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
 					 remote_addr->svm_port)) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
 	sock->state = SS_CONNECTED;
 
 out:
@@ -1209,6 +1218,16 @@ static int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len, int flags)
 {
 	struct vsock_sock *vsk = vsock_sk(sock->sk);
+	long timeo;
+
+	timeo = sock_rcvtimeo(sock->sk, flags & MSG_DONTWAIT);
+	do {
+		if (vsk->transport)
+			break;
+	} while (timeo && !vsk->transport);
+
+	if (!vsk->transport)
+		return -EAGAIN;
 
 	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
 }
@@ -2055,14 +2074,6 @@ static int vsock_create(struct net *net, struct socket *sock,
 
 	vsk = vsock_sk(sk);
 
-	if (sock->type == SOCK_DGRAM) {
-		ret = vsock_assign_transport(vsk, NULL);
-		if (ret < 0) {
-			sock_put(sk);
-			return ret;
-		}
-	}
-
 	vsock_insert_unbound(vsk);
 
 	return 0;
@@ -2182,7 +2193,7 @@ EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
 int vsock_core_register(const struct vsock_transport *t, int features)
 {
-	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
+	const struct vsock_transport *t_h2g, *t_g2h, *t_local;
 	int err = mutex_lock_interruptible(&vsock_register_mutex);
 
 	if (err)
@@ -2190,7 +2201,6 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 
 	t_h2g = transport_h2g;
 	t_g2h = transport_g2h;
-	t_dgram = transport_dgram;
 	t_local = transport_local;
 
 	if (features & VSOCK_TRANSPORT_F_H2G) {
@@ -2209,14 +2219,6 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 		t_g2h = t;
 	}
 
-	if (features & VSOCK_TRANSPORT_F_DGRAM) {
-		if (t_dgram) {
-			err = -EBUSY;
-			goto err_busy;
-		}
-		t_dgram = t;
-	}
-
 	if (features & VSOCK_TRANSPORT_F_LOCAL) {
 		if (t_local) {
 			err = -EBUSY;
@@ -2227,7 +2229,6 @@ int vsock_core_register(const struct vsock_transport *t, int features)
 
 	transport_h2g = t_h2g;
 	transport_g2h = t_g2h;
-	transport_dgram = t_dgram;
 	transport_local = t_local;
 
 err_busy:
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 8b65323207db..42ea2a1c92ce 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -613,6 +613,7 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	size_t size;
 	struct sk_buff *skb;
 	struct vsock_sock *vsk;
+	int err;
 
 	sk = (struct sock *)data;
 
@@ -629,6 +630,17 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
+	vsock_addr_init(&vsk->remote_addr, dg->src.context,
+				dg->src.resource);
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk)) {
+		err = vsock_assign_transport(vsk, NULL);
+		if (err)
+			return err;
+	}
+	bh_unlock_sock(sk);
+
 	size = VMCI_DG_SIZE(dg);
 
 	/* Attach the packet to the socket's receive queue as an sk_buff. */
@@ -2093,13 +2105,7 @@ static int __init vmci_transport_init(void)
 		goto err_destroy_stream_handle;
 	}
 
-	/* Register only with dgram feature, other features (H2G, G2H) will be
-	 * registered when the first host or guest becomes active.
-	 */
-	err = vsock_core_register(&vmci_transport, VSOCK_TRANSPORT_F_DGRAM);
-	if (err < 0)
-		goto err_unsubscribe;
-
+	/* H2G, G2H will be registered when the first host or guest becomes active. */
 	err = vmci_register_vsock_callback(vmci_vsock_transport_cb);
 	if (err < 0)
 		goto err_unregister;
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
