Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757261;
	b=cT5maV6CDMxw8GJpj0e04u+7hP7gfZio23g4xtjWxd7ax/rbKr3cUUpqHMJxBxSz937r
	 wbxd+wHuPEsZFazW0MX6YErq2zcVFwmkEjUSW0tS6MDnBZWWKu90ozHg4etAheCUWExjH
	 O6DWQZZwxckj1gyE9UwVBCHZBnMDvDqs+sdNrTyz/qWFjZ7LvPA52yKecTBPAeD4n9EnQ
	 lkBbnpXMSvrYrqaKRVU7HKa9/oIyDax6vpaPxsJ8ITNNbeQLDHXjq+czYOZnOWFbBBv9i
	 IsC/lqxuvc9SbBm6QhBadg6JQd699UVb5VnldxAqd8mf4HBLzqCZYMt9VyaRQeKX7TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757261;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=oR+Bkg8GJxAW2CVAmjRHYxlRtmLJ1D5BjCzlD2s/Akw=;
	b=GujnAEOmPWSMMoXgsQx+oE3GUvpdMG/ZxC0Ef5/fT/l/8fHkEFdpEnXLSoE+b8NU337Z
	 RB5TPwES7nar4F9dJrUn5BKv2SpYxHYgMxW/lLTcA2nBkO7jD+apF7deu21IJn5eEwQHZ
	 +5WnLQzzqwYy4ND0Sfh9MQtN/kvv0AR2fipWl9iX+f35j0FctYBGMBdfLOC2KxqbrJNyi
	 63UCsqjRl95u6KU4WkxVqGyAVe+6YOP4s5aZ6kZZbrpZIc56/rlD07OZ0ScyyHKKd92tc
	 H6LAZzGXOhrm9SCKiMARCeNlrwKQu/RUGfy1z5Ap06D6E4lAiyXcuJ3WYS8V9dEX09w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JLHhJh1k;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF2606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JLHhJh1k
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40STr43727576;
	Tue, 3 Nov 2026 17:54:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=oR+Bkg8GJxAW2CVAmjRHYxlRtmLJ1D5BjCzlD
	2s/Akw=; b=JLHhJh1korhfc+kAoLkD7tpKzO4/g+QQyNVLTcABw4JPEEVnjq/m4
	UsTM8qbhUpYDxKxKlKIu5jBLRYPTe9zFHU6q1Lw13Bb6ocfLDunRtV3/XakHtP+n
	NLV7vCXO+sFBDAoi40vIvtRE3FoJ/9Qn7H3dqTPBqo/9CeQl7384n0OIv0cwKzvp
	QATjyUsU92FMi7NjnFRkjyMTPALoc8C5cAZFnPYpPw/a2FFdOVM7lESlhhQF+egn
	3Xi1ml3LBnSymUxCw8Oj3KX36J9qd+VJrqQRpinv2nty5Y/BkRj+FLtVHzDGaPrP
	th3zov8siEpFkvQV54v0KcEG424pLlzAA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqbb1qbu4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:04 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:03 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:18 -0800
Subject: [PATCH net-next v5 3/7] vsock: pass the netns to
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
Message-ID: <20261103-vsock-guest-ns-v5-3-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
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
X-Proofpoint-GUID: Me3SgFmUXnB2ZtChJutEyFXdcG4XU-ey
X-Authority-Analysis: v=2.4 cv=LsIHWXdc c=1 sm=1 tr=0 ts=6aea903c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=XJcQsa36eN5O9Fc7FbYA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfXx+zuCa20p+Po
 /fWnkqje2odZn539UhAfWdoHvrt3EjTT2/AL2u0vUR1IY2G3rQFUxSxnZsDVwNR0CFf0LYrjq35
 cVLh+CrhJMmESahPRnfBwdyaeJ+4q1yQU8z/2TatEdHIfUVFWQeX8235TCNZe8G32W3XK+t7ZHc
 pdOzICV6XE22iHhrAch0C4W24gz9g4eaq1NMIiyS7RJA1qfapEN89dTN/rS0QtPUaKFowYMRJ9N
 /O9swn4ggQK+VHTaNbaye8Ip3JxNLrAoX28vhvH3WVuFCwiemcs+vffRVk8x3N4nP8x1c/U9X1Y
 Sfsz36YHLss9ukGryES1hKFsan3meLBhFo2mGB1h9orRUxt4kzCjWeKiaF0H7ozrDY86BU69LkP
 W1nnlhGDAjnveWb6eBG+D25UwKK9y4el3bHG3qSjOR+nsdv2TIWQR7lo10PbkAtgXZmCcyvVWIr
 B4501mf8abfr5BbTeeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX66HY/FS/arBk
 /otKztARnWDnBYLZ/ZD+KmUZ6S+/SBfupujqkf+oR3bp0zsYM2w9TnjfP5mu4egsItK8evp4oMf
 Ra+KqFA/xERvwBYT/H1tbVZYoxCzoNY=
X-Proofpoint-ORIG-GUID: Me3SgFmUXnB2ZtChJutEyFXdcG4XU-ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

The transports only use the socket to find its network namespace. Pass
the namespace instead, so that a later patch can ask whether a CID is
taken in a namespace without necessarily having a socket on hand. This
will help with avoiding CID collisions when devices move between
namespaces.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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

