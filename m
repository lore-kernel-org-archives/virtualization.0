Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334503403E1
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845377; cv=none; b=q+QlWhyoabxMr0ulMLi1edBZsmHxwR8So765j57ppj8Z6UnY6DZydIJhn6EVDSVGCtC92Zwu520tz+9TcKeBB4PnhZuM/1X49LbhJI7GwA6rxcoPTAKN5p0oH0DRbohJUWcFEq34DcXGvWU1lKTMEoAzX/Nx7cwxwfDlcwhmGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845377; c=relaxed/simple;
	bh=0jln89G9ElqXSr66RTwfyMMDtNjERyslsAOOz+s7yrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YpqZdWanSr5TlOEm6kHefjfth1DbN7AXc5+VSlfG7lTjhg4srmlPV4B5nAJ+xlaonyCMd9unX2BDPWL9jrDQFhSFnKjlrmytUyyMS8n2OUdkL8XwUVFJWUlOEzBKekh9js3Xs7hcpLaYHl2yPAi1d6s5bWrZitfL2e3kvdvfzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MhOua+yZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MhOua+yZ"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJOTRi1689810;
	Mon, 12 Oct 2026 15:49:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=aiCydZBACRiTylTtXuNEDKMNxk/u3wBKD0iU1
	9o4WPg=; b=MhOua+yZFf3QA0e9nXNPb8/PFjKDIXoiQo+iA4NX7DOIBFzH1JBs4
	uPP4IzC5ro7CIr6PTBpZE6TgInXODoT5K/r182uM2xT8dBkbxsywRuhBTcWlNao2
	rNLnUGXBfq1TgTOXtnGFy6erJ4VZWnkTOJ70rK5kLiEGTGroLNFu0X/ZFFOaJEv6
	HidOr62dr11jVIJF8Qxukwld4w9N4KX2IZ0VpXARMFXH//3ApYav8kazpkdDJHNw
	tHgdaBWwPgUzOT/TI4RPoZtomp5S7Nwr0zHrczLqj8XiLPgp19yW3HjAGfoXhWo7
	r74L+6qKVb/XOcFB1zVv4r1/940nfX0iQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h860hn20e-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:18 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:17 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 15:48:34 -0700
Subject: [PATCH net-next v3 3/7] vsock: pass the netns to
 ->has_remote_cid()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-vsock-guest-ns-v3-3-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX9HM/KZ3L2CSd
 QfzOUJ41qdNjckSkr6Czrb1TKkt/XE/KmGHlnuyiNBq5aCMpr878CQcjFUNnhEnBgsOohftNMFL
 gOaXhWdUkxo6c6ucXZ8pIlmEWmJHUi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX70kiGjcnMn2v
 IKlcEm3OrfswDWKP7ZqtCNfhDC9GmPX1fyDD8wWvysHDUtlkCRsVjOYWSteBl+3nrWO8lTsH4lp
 FtkX/fTUtxL8WrJf9csNVApWOcra2UZDRh0S5QSgdEsRwDsv5wewhEcjTemHMOC8q9tHPQlJmM5
 ONVLuAI1ujNWjsnaD1wmPq+oxfltAk1yTiJaAPaKExHbw6URah3mLp/4D198d8ExqRHTRZcU3LA
 eUbNx7T7yDukAIcyM8dsyctZpyz2+LKlsmaoykvMigtLHhYdi1an1iYalIfsEnbz/zCnEUnoFt0
 accRlQZ74+0PH1ZLeNXZEgoC4IykgQY9ymxAKl4oiSUu8UGbPkVoM7NwsJI7x7IscMZxDbTwNPW
 R+higP/r6nlP4hla7uyNWqS4n550LHxtTLi/L5scIphdPA0q8oo1BBdPN9EMWqjkp+b+b/FRUo8
 c+yVkKmfKidsNf4op7g==
X-Authority-Analysis: v=2.4 cv=cJx1IVeN c=1 sm=1 tr=0 ts=6acd63ee cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=WAnpC6A4wG5u40D751YA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ihA2FeNJBJ59zznl91GgtTP9TkVrzVIj
X-Proofpoint-GUID: ihA2FeNJBJ59zznl91GgtTP9TkVrzVIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

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
index f7dbef8cf6e7..8f34bf68f916 100644
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

