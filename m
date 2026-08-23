Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAF38B7D1
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507991; cv=none; b=MLjS0htv2DFyTOOeTn+AKdm/ehLROj2STeZM47HET+dj7GidHZ2u/zyVTt/q1UnSiI6gJb7tDl4Hw6NOnaSThKukUsazJ05rYl24hXu6Bl/LoQqpTnAMyG3mL0VXBnSVDchdNwIzRHyOb5XbpivV8QFf5V6HFhRF80dP1k0wQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507991; c=relaxed/simple;
	bh=Q5N8akU4x+F36ss1pZ0xBmq2Yh+ClMoeMJuX3SACBjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9ftjPTiOe6j+1ChiAIRMRp7j/JAGe0+EewEJyHFuk5WIAq0IXH1a028Cxfw5qt4etzP6L2hg7m4gUnT/YXe8f+VdzzIA7e2xwQFBZdds9Dk5cSL2PKSJLXhclZh5uKsrjG9CnL0dcNHyRvUSD2uRwQgjfDEaEnpFD2il5Pzut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoRV2g2y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoRV2g2y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3061728a91.2
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507987; x=1788112787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECOspUthc7jBrs5mtjKd9RwO1oTEgx0ts6iTJsWVuOY=;
        b=FoRV2g2yrEUJEnlvJGG/aW26EHHviau0/UvvfOw0+xmQLz+mR4/u+3ANoGDu/F5tCd
         q90CgJgaAX8PGyJgL0Z7kRbh+7TynT0gVF3fPqrzP00HturWQYCrDOIiC78D4YtHTbBi
         xmCCb7zXLdMdN3wLHSl7qINsjfF3ISAx641wLaMvHXJNC3KRnTvAn1+SXThcW4bqI80u
         UfDZvaAF6Vp18NNtb8xrMhKXPqhGRYaHD8Oy6prWQ+NIPzZsKiv/1JvDBueal1STZ0aV
         DNj4EJgtPSaKfJPyDsKUyDIA3WBuwLX9yemi6e7m1oVBRjvmGqK2AblOT54yfnnhG9/P
         PACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507987; x=1788112787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECOspUthc7jBrs5mtjKd9RwO1oTEgx0ts6iTJsWVuOY=;
        b=tM7PqNJOPDJAd23LdRQT0oVjgB4PICBiA/cNb6MZMBxdv7eLYLMuJWVqYjXtKw9AKm
         97WAKBwYU++eoYnlboeWYYQxyDhrQYMNZamH6o4HRK7Y1tIp/YmT9hboPaFvmVp4i8hz
         xWjrQitUodu8ypw2JGhU2wNX/PntJbeegHVMkYSFncfU4GcoruYAXiH3Wlt/u40JmPHE
         qDoC2V9xobYmTHvgTN6dcY77N/zAmwLFpFoG3zE6C8ZXGcmu3XDeEOeayV2HHW/URduE
         9jDSZMR7OV1/XYBMo2neor7UuL8NzTp+7Clgv0ZDC1kzaP1ecj9s6pPUpkV4fAhJ2ZQt
         4heQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDnXDUw5iVwif+V0dMM9rgcsp08FbN0dbBECYAx6jPvy3bLl14rdwtrx54hwxY0eIcoCvDEO53adPwonrbcQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lfCludfyoV7BwjNx33kAxnOTlRCAFC85QWVibnsZ0xznBMf6Kx
	foTLireNxzzFvx7TpuBH0J1IRvRsf6jGOETzokek0l7DLLefm+7+OfKr
X-Gm-Gg: AR+sD10r73qi9fTdp8LiRohfLTeT7fsrxmhl+W5IC9vhXTzrwKg61Plg8GKcb443N+0
	XOsNj8Vpi/vTV4+HO8e0j4yZzN2lmfjsJkqU8360mM/IUGcR58fjyuvMdAo0nB8H+oaGYA1Tq0O
	8ZiV/lq/s4KeFsCdzdc6iYG3RcV5XZWm8wwJlkJNtky79+kkd3kNlq9Vw57KiPs1mWycwwyiyNI
	0pXkbf46/MPrHXRVzqnDj09I47m+tVWb8/Dy6mLht3d7CPy31gse6lpCCrAtRFj34iPUSSAGY3E
	Zz2yeX7nxTQAfEcYIMTi4ggSsZmam2GS5oW9PZn61VhMnm6gGHbIkUhqhaOPCHf6FmZkh1cKIwh
	iPUk+mTpXM2JJydw8JfdiywIRIGWWOObws/BoGuAP2SAcLIj+PtT9bsnhjGrdCc0in3BiAZQlSl
	HMXxcEhcjHHIFZyI6zGjLZuL25/awEHuB5AwEb64xc1DIU5lXbRpFpJUdlBbgPtsYkgMUX6/57
X-Received: by 2002:a17:90b:4c84:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395df2595d4mr19966783a91.9.1787507987364;
        Sun, 23 Aug 2026 10:59:47 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:46 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 2/2] vsock/vmci: validate packet source for connected sockets
Date: Mon, 24 Aug 2026 02:58:58 +0900
Message-ID: <20260823175858.351431-3-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823175858.351431-1-4ncienth@gmail.com>
References: <20260823175858.351431-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmci_transport_recv_stream_cb() looks up sockets first by the full source
and destination tuple, then by destination only in the bound table. The
fallback can select a non-listening socket without checking whether the
packet came from its stored peer.

This was reproduced with two VMCI contexts. A RST from the context not
stored in a TCP_SYN_SENT socket reset that socket after it was selected by
the destination-only lookup.

VMCI can process notification packets in bottom-half context when the
socket is not owned by user context, or defer packets to a workqueue. Use
vsock_check_source() after taking the socket lock in the bottom-half path,
and recheck after lock_sock() in the workqueue path. Listening sockets
continue to accept packets from any source.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1c4ee039c..b612a9893 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -680,11 +680,13 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
 	bool bh_process_pkt;
+	bool drop_pkt;
 	int err;
 
 	sk = NULL;
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
+	drop_pkt = false;
 
 	/* Ignore incoming packets from resources that aren't vsock
 	 * implementations.
@@ -765,17 +767,26 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    !vsock_check_source(vsk, &vmci_transport, &src)) {
+			drop_pkt = true;
+			err = VMCI_ERROR_NO_ACCESS;
+		} else {
+			/* The local context ID may be out of date, update it. */
+			vsk->local_addr.svm_cid = dst.svm_cid;
 
-		if (sk->sk_state == TCP_ESTABLISHED)
-			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
-					sk, pkt, true, &dst, &src,
-					&bh_process_pkt);
+			if (sk->sk_state == TCP_ESTABLISHED)
+				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
+									       &dst, &src,
+									       &bh_process_pkt);
+		}
 	}
 
 	bh_unlock_sock(sk);
 
+	if (drop_pkt)
+		goto out;
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -900,6 +911,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -908,6 +920,10 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src))
+		goto out;
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -937,6 +953,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
-- 
2.54.0

