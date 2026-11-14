Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626445;
	b=htrRefTiJ8dMeBwQ1Nxvb54n6Kao4vhrdYPX6U+ajo/Kw/RrWGaTsh/rmP30RHxk2Y14
	 m/C3eI/58pCgFxW2Z2ZFHnqi8WZyTEbbNbLq798kCT41PGRxNd2nZW10iHNd+p4UsFI2A
	 Ugl+5egd0DO3UPh2tYn+aRbPS51T0VVC2LSSrdp1mIW5zjPqIeUBtHSIzlq45k+dInLWD
	 rW93kiWNO2HCV6DiMna/mUxniZgRLz7C+RtT8sls0tLl7Hk4Y+KRMECaA2qNrXAtONaDx
	 5mORQ0tAqdUGN1hy+Rg+aJTHbcwNkcqy0nT1kP9fgI2UacFDVkXB6m9JeDu0ClDP7QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=uUxUfqd9LI7JvXXA4EpxThcsrnoWv7uHxs805oALM0U=;
	b=dwj6a8YQkhqt4xDn5QmjJA5BxQN811TF1JOMwaQm010HHVMdNgDkWuDMq5ABjwS2i262
	 76GRS0nrQql9qF7/C1QMlnGTfhxA+9//gN7vLBkAbZlGDZTYcpbKNaG277P7B3AELO2Ib
	 IhejK8SAo5ih32mVJ6/8YpVzVtV32kV0dq4QfBFWfLwK0d0j+6NdbsbjJ/UtK5ZCgzNSf
	 lXuqJ7Sa3BYvKMUWqdpVIVTO2JE04uj7SmsHmeHFfeeEoJWR9NpIpl4cPz+JHmB+maX7J
	 NtzKNi3hkZzaK6+zdlVzSTLzWWnJk3bj1Mu1VRIxyimdgPvi9gv42VtzOQlFlOSmLAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ic+Ed4qM;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64921606A32E
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64921606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ic+Ed4qM
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22XeV3157915;
	Fri, 13 Nov 2026 19:20:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=uUxUfqd9LI7JvXXA4EpxThcsrnoWv7uHxs805
	oALM0U=; b=ic+Ed4qM+dTh/spfmGgmV1Lzd46ckq12/UPrcfZ/lzK3bHwnxDB1a
	IvuNkbnRakv3k6u4bsa1zVMTXCS5BpIjXeZFgMPU1yC5ClJtcBNPl+zaWAi8llhB
	GlqEgPNI9hqA6Q+4Ai05ErFM4YZiaRsocdKzLqwyDJjko0/Jif+gN4hUihDEQdTZ
	wKSMUakxgkExDjHkGRmyooCTVJlbxzbv+VpCn0QY23HIpOD//CVSUgurIsOuTpuK
	4Za4a3IBVa+Q4BWAy7NxMb4AL0s4R1vk45PCI0NpdqDWC0wnuJywFO0vjrBNv9OE
	kR8HcWL+qSndm4lBCsep7//NgK9Y+2NHA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:24 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:23 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:15 -0800
Subject: [PATCH net-next v6 4/8] vsock: pass the netns to
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
Message-ID: <20261113-vsock-guest-ns-v6-4-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
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
X-Proofpoint-ORIG-GUID: yU5Tx7R08RVqQlSfn9tQnz8FbCvbXmWU
X-Proofpoint-GUID: yU5Tx7R08RVqQlSfn9tQnz8FbCvbXmWU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfXwbM0xFof1axD
 5uxYrPu3HN0lUmlLfmpexrdR8QpWCR0H+hTCV0U0rp0RUkkMokADOH82S3i9xeyxk4zIpQrnuJ+
 jsUZauXWJ28gCktSGsMvuCu/Cs9Jveg=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d378 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=XJcQsa36eN5O9Fc7FbYA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX+x0vwLItIxVJ
 C+TGdIlla7MAmJbBTc3RmppxXJUQKIe/lX4lfqIQRV8aGg7v5hdFK8uPRJ/irkNA/WmQzUoaqv6
 4NWEcIqxGIwuDrIm7rYXCWC5yi2nMICCk4BuKsah69mHx1g7o+wrZmweQlNSNMPAnLzk08ssLOc
 G+q6UFmIaTxYOs1hjiSQ+lT0g+my5eFMzctzm4G0PHbaP6J3InKqohADrWq8vZp9Vn6Yywa4M1r
 N/uCKk5HArM/h292SqVF+cRTXnTunBtiDDqRpPEWzZVs8NRU7rwtj6baoeg/N7cvch/v41gBzYX
 EnidUUpsP5+tmmyQxOqE+C4okXn9Du0dbW86IpQLKCm98FdUsGVlXG/WsXekvVNXOF0sVx27lRB
 GeVfkHgpfgo7zzMEnqOo8kfS/hPbesvJeF8i3zdcW/lU9HSBm8HzFrIfFfG+VHpisP0LIXQS3Uo
 vSRCA3i9ZMNC/m1MnjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

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
index 4dee7af259ab..37abde1ca26c 100644
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
2.53.1-Meta

