Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545336;
	b=TOxvS1arB42quZrODB2VPjjn/I4EYyAQIVxRBPKAiQDWIFVAHPAfiRxn2brBHH+LmIuA
	 fUSIOrxlf+MULAcWa4DWiQPeDjchewLWXzVF2Tc5/8OgWmcRyUwhu7K50Geb03xuzEDdM
	 RlY0kP+Ehcg8cJOyWVUhHWsCtTtveRSumpJ8X9uoasW9mqYKl05WeFXTIx9Md13H0LWfI
	 /JztYeEuqaD5lFm1Obd2uIqPaB9JweD/Jj0R9PwR0+TVsf0b/UQKuZgcevZ5jXMxG/gxS
	 lHeC/TT8bNVU8xB/vdA3WGWSng/5OCBIImMYzKBUxaXf3Cz+7lrN4CQOyPDVBWj/IXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=wDZRIWFI1TDGA8t9yuhX4qEhSBIT/Hos700N+Mxpthk=;
	b=qmJfOI4RJBTP+Lxtd6Cl1jXjN71hLWwhH+uNpYS2E8VUrbkgGKWETgMvNKMuNUzftS3r
	 cQopTvZpe/j3ahLNtgkU6YM86R3ZXK3EGXWVFGVsLev4QPjV0fUQAsrCzigNm8hIw3GMd
	 akQzULCduIPA2emZn8lUPFo4hLo9rHbKYTlCch4KWcIMe/QyPalvcUGQR1p53jmxhwRt3
	 7dUlbeLWY1t7gEv6RbK0I6a+gYmdh+6ETYpIRv9XoRe30QmQ5J2Krd2cxTzW02TKWE4OF
	 GsNbI1b+D28j/VxUYvsy1uJBxPrJdIebXzRh5T3BxXU0KrRZJNgmJtu1a6tQnNITuAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=lAE3k9b6;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A9606A319
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3A9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=lAE3k9b6
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNFO8h937341;
	Tue, 20 Oct 2026 18:15:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=wDZRIWFI1TDGA8t9yuhX4qEhSBIT/Hos700N+
	Mxpthk=; b=lAE3k9b6L0Paznfa120wl5aELSyfzXv54DMvgOOfVnrrxMRNfTvwP
	tpK4sQdV9RcYkgnNFhW/7+kGEqxkL9ulRX/rA8iudVXX1SbVN5Q/HZUPByoGny+M
	qB+wk3Cc+vuceQ7ErBZlJcypTR2c6J1P6nPQp3f3G9ZgMt+VLBGFQ9dJVYUerO4Q
	TstKW4WgIr9EgjE3icS7/gXorCtxClhfpQ0SoeYO7O3xo1LBCdJl5ZpYWrnEvtek
	rB4IcuFFaY+M486wsKUKqN027thCmINRH2aH5kM/xQq40bFuH8Li3AWIx5r3rJ3D
	ZXyEWLFDkcQkznG/cD86fTeKVzq2xTDZA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50r1hv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:19 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Wed, 21 Oct
 2026 01:15:18 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:06 -0700
Subject: [PATCH net-next v4 3/7] vsock: pass the netns to
 ->has_remote_cid()
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-vsock-guest-ns-v4-3-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=XYwcX455 c=1 sm=1 tr=0 ts=6ad81227 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8
 a=WAnpC6A4wG5u40D751YA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX+mxKX/An8Msg
 pJCk3KR8Aa8NQKNoj8/5hPL0Ht5dhkC/CGY8daGT4c3Z/z6ZsVonBf+cj7JRZOAPktlrefEH6Jk
 9ccFdQ49SZzSUAwAZqYo/E/NHSzDwsY=
X-Proofpoint-GUID: L034eqcS3dW_02XTV43Eh_xrHT3qx5I-
X-Proofpoint-ORIG-GUID: L034eqcS3dW_02XTV43Eh_xrHT3qx5I-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX5E5isj7TtNVr
 i1bYx5dfomTnbKOS3qor3WyM6h1p8KnqSN2MBCwoGhr1vaPlSlSau1RIYfIuCynt0jjzpsp2//L
 6yvzdFRKjLkMXcoWM2do2v8NbAd5gmcJ6hGsduVDJ3fPh1oE+rkgrak64lFtsF8iQ7AzyqBw7ol
 guvyRuSx4Apm3SKb42/8HBwvXy5+tTIBtWSvghPstUG7IxbzYRBeazIrlSrKXOCDlPn3FMU1NOh
 AC4CSBzRc+J/12JE0W3qKYg7XWfXEk+3zatlpRfWMxX5VrpqPAVMolVvkIUfSvWiK7RCcZAqFWl
 WPnWly1m4C3Z6zlqVhMK3+/xaeAdhXNDJiPdQDZjaqG7JNWfVWzFWkgUX6zvdlCp4BxrzTlV9C8
 X+u1l0TXPSX3ptqE1Y6Cc/FptkB4jisGS3DRZP6f5+C2Yhz1aFgqErLTz4vZffjcLmxToB7yLXz
 a20KVDA4anhOt4uDxPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

The transports only use the socket to find its network namespace. Pass
the namespace instead, so that a later patch can ask whether a CID is
taken in a namespace without necessarily having a socket on hand. This
will help with avoiding CID collisions when devices move between
namespaces.

No functional change.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/vhost/vsock.c            | 4 +---
 include/net/af_vsock.h           | 2 +-
 net/vmw_vsock/af_vsock.c         | 6 ++++--
 net/vmw_vsock/virtio_transport.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66c..01f8930ca51f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -91,10 +91,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 	return NULL;
 }
 
-static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
+static bool vhost_transport_has_remote_cid(struct net *net, u32 cid)
 {
-	struct sock *sk = sk_vsock(vsk);
-	struct net *net = sock_net(sk);
 	bool found;
 
 	rcu_read_lock();
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 370fcd3ddabc..1c38a27fadf2 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -183,7 +183,7 @@ struct vsock_transport {
 	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
 	 * does not implement this as it only serves CIDs 0 and 2.
 	 */
-	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
+	bool (*has_remote_cid)(struct net *net, u32 remote_cid);
 
 	/* Read a single skb */
 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index aa4732c3599f..c9b28e34b1b3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -633,11 +633,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 			new_transport = transport_g2h;
 		else if (transport_h2g &&
 			 (!transport_h2g->has_remote_cid ||
-			  transport_h2g->has_remote_cid(vsk, remote_cid)))
+			  transport_h2g->has_remote_cid(sock_net(sk),
+							remote_cid)))
 			new_transport = transport_h2g;
 		else if (sock_net(sk)->vsock.g2h_fallback &&
 			 transport_g2h && transport_g2h->has_remote_cid &&
-			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
+			 transport_g2h->has_remote_cid(sock_net(sk),
+						       remote_cid)) {
 			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
 			new_transport = transport_g2h;
 		} else {
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..eced6929405d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -548,7 +548,7 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
 
-static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
+static bool virtio_transport_has_remote_cid(struct net *net, u32 cid)
 {
 	/* The CID could be implemented by the host. Always assume it is. */
 	return true;

-- 
2.53.0-Meta

