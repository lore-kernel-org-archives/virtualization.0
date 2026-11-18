Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966930;
	b=hlIZsuPsoHaP6HFPHAgey7GJ8XRgBPrKKLIrzbFVsXAFjV9LO5os7/auFgSy0xIB27+d
	 v9I3Xxxn0yPLuE9SVXc3WreiH5U1Xa8ojlFq/TRHASm0I/P++OHCyhofcvatqF9eL5Z7b
	 wQVO0+RqQPGMt89rQBN5yhxJbHpvL37nyJjrqsVxQHn9BXS8QnvCa4AgOvWYuUYiDeFFD
	 rFUv7z+uwd+S7C2w4Kz5Pdh8rYqod2F7Ya1zAE5P1Bfy1ED8cQb+Eu0ckH4d+gpVuBOXw
	 rykImNYE10tR/HyauJLiKLpv9iMQc9V67Y0iNbM0KwnPnRHa+nDNRNpZl6h3SsPr6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=QsieJltyWcCEvnM5nSEj6axcpf3UsGXZMeYjPVuVgzo=;
	b=iWCgPTLFUSCrVoAGNp1MV4BiO9eMk4HdK7oVRxJ44l0BLBiYtMxv2MCQYq5J+1HAL1rr
	 apOWnIJTb+rsfvN5+SZHmz8gNIydYN/miI4tB0hkgXeb2ghhMQggzwvMHJu22VgSMdYhW
	 ruD3UADsjGdXLvxXIiqJIYBdMS+65YYCmhwzKqg+qB4gNoEnBb9cXWR/8yuwIOIKZ848y
	 li7p4SKvgZ5uQavow9TJSYULYNu8ypKcIcd43Q2IMEdbQof6IKilEswIiT/KH8/PvpJWO
	 ccjCjyWFuo3use6IyAb8OJ0Z6V4Vo7cHN+hW662Pjc5zAl3fm5v5WWDlUx/0FWHi6Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="cWp6v6R/";
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC5606A339
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EC5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=cWp6v6R/
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI11rA9258466;
	Tue, 17 Nov 2026 17:55:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=QsieJltyWcCEvnM5nSEj6axcpf3UsGXZMeYjP
	VuVgzo=; b=cWp6v6R/XwhrEX5N9dwTmfqM/AnMfkcx76c7T+BQwWhEqJ/pktNPq
	KteWmblzaSULkDUYMRyT7jTONcSAhBRMsba/EuTKeQb9lPwgTVDICChwOXeduPuF
	ImOfoQFkVDp6nCA9wO76Xeevx6gGxEB1pmZk9gkWyRX4R4QaJoHrrhiAuIkfJzGX
	VXvTy+0GLSuSEfkCyFo43vKhYxFGP+NJqszQjjACEY8ti0nwHonzuNQQpt0/3b2/
	cdpJsn4Jg7+QSXgrjeATrWyqeRNLbOQ2P4tkpb6kQY8N7pinoDn+AEN8WGJIUjJr
	GDl3Mol0FZD3TD93qvPmNO7/UFTnYaLDw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu79b7g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:17 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:04 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:54:46 -0800
Subject: [PATCH net-next v7 3/7] vsock: pass the netns to
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
Message-ID: <20261117-vsock-guest-ns-v7-3-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
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
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, Eric Dumazet <edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX4SVpLCuHOxPP
 r94pf1Cs3tmMV4o+WtJhG/WD+HHSTRBtHLgNAY+a5ddyZr3Uus1n7D1wscIME60NK5fPvZQBHeI
 /GNk67M9KtVOs6o/CQm8x6NLWl7zAg210kofesLyR/Ag7tGd0r6kckfHRd84EFsJ+Dqf7TU9mi3
 InFoa4STZ1jpTXw9orhEP9D18j1iiYuvHKwVsYXfCGg+bRGYV0zmavB7Ez4er0/dslJkRRAtr1e
 vDlKVNV632CmWm/hUUdqoNU1d23kl3vLB9eTMbs9ogNbfL84CaXRKtcMtP5UjHXw3TA8JhrJBi/
 OIc1GSsCJ2TSnb4pMfx0RtCNLt2W8niz0WNrYbVR+ay5xBLaLWkIHiMt9grckGMNAqLCrZbTp8D
 HY/pkVM3JS752zT01YKQq2P8CkloLOxjKIX6SEWwAgNZyacrpwe9dbO3gjvsIp/Gy9kk0Zfzrz/
 SqxVl1/AcK91KlaW0Zg==
X-Proofpoint-GUID: k_3NQj5XExlGbADyzy_sXVcIPmqM95og
X-Authority-Analysis: v=2.4 cv=Zph4uN7G c=1 sm=1 tr=0 ts=6afd0585 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=XJcQsa36eN5O9Fc7FbYA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: k_3NQj5XExlGbADyzy_sXVcIPmqM95og
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX9EabyWu9SYn2
 cNcFHx37PZ7B8qncGmyHM7Edo+jXy01PipnTZWJ/ogSk/inOh85uDraYePaQOnX304aoQ+44m0R
 doRBTIFv0DGVAix3+2K70p5pB5wmu48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

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
index 3de1f1920717..0135abe9589f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -92,10 +92,8 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
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
index 0ddcf2325ba5..2a70b961cb45 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -184,7 +184,7 @@ struct vsock_transport {
 	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
 	 * does not implement this as it only serves CIDs 0 and 2.
 	 */
-	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
+	bool (*has_remote_cid)(struct net *net, u32 remote_cid);
 
 	/* Read a single skb */
 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 100570d83e75..7d58e7396b75 100644
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
index b39c001260a9..1ddb6839a8fb 100644
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
2.53.1-Meta

