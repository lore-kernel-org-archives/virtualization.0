Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545336;
	b=3j8vlWJqmBL+gCsIC2WYet5dANyD37+ZQ0fY2NGW3yLFt8JCGkyirX+R1AdyJtwMb7ge
	 PpTXbEcugSVMaa+05Mz3jHddIz06/qQ96fKhPNIKd3lUbxCGN38OPdShE2N85TYdF+D6B
	 iN0EVSrf8DgnGX6vha9VDKS6/Z2r4FKvU9kAiBJU06xU6IDagdZm47h8Nk9sO9mwidrkk
	 STUJ7Y9+LnQY9zlRjd4x1PhIvg8uPifxkWMqmnJcW+hUlfWi7gMnmWbbQabHb96zQ97Rn
	 aJeh7orAZWSX1L0xAWxqdqlt3Tf9k5GZdUY3v/iG5jg5JDfKR7b/kK2UQPRDl/QO0yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=w/sWIs8UfkKmHt3/JDcaudv9fV9VMQ092RWZIMJKb24=;
	b=1953leadVLTpeoVDvzr3eS0FqvBVrIvAtfQXW0akFfKKgYIXKxC2eZ9GGFtctlSkj/IJ
	 5qzMLgHjcGQWmbHh3pBptJffLKKfNopc+rB9jsF4du2vj4LlDNqqqGuu7de6WDPT1USCb
	 KctN3vfLjeP6eyk9dIChf95GHyLKQWcT1SZiHOi5j/6eyWZtMdN1BhrTS2gQtv7gtTEFp
	 /VTvvv4GapPiobJEUooN2stpykqY0fGXpF/VUjW53bWugKmoOknj00xM84+Wc+O4JRezD
	 IVHjAIXQgVi6kT8Hibip7HNqe2n2qIbpZi8SMUYITMCdDNxFpS1RkHYOoLCJESYCYtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ETT54AgX;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB87606A31D
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB87606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ETT54AgX
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNF5we675525;
	Tue, 20 Oct 2026 18:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=w/sWIs8UfkKmHt3/JDcaudv9fV9VMQ092RWZI
	MJKb24=; b=ETT54AgXEzEQJjmnb0nAmMaTldKWGzXYYa+VBpnzMVw0hbZw2+kuM
	7euO1T6VVYEz4s0XxlVMj34e6djf0Uq3zj+Nq2noD24i91jVfGjJBG+qOntvohk+
	msG+MCLxAIui02YNtysbwtFFI5xtpBaC1nhb36jP4YSJVI4U2NVj1AaTfaqNTC8B
	I3ApAfolSq7aZjNJw0LXvFjqnFkhOgekaH3wAHv9tE7E+erpgeYJ+tnhvsKmNx1f
	/Y9DaC6fNpW32HP1q1DSxF9UwIR1VF6y0NlYGjQ1Xm77aJ4BGOSvDHJX1ZufQgfD
	D03LIJe0Jhphw7Cd7mGCvVkhtZDGC1uKw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50gqnx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:18 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Wed, 21 Oct
 2026 01:15:17 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:05 -0700
Subject: [PATCH net-next v4 2/7] vsock: rename the vsock pernet operations
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
Message-ID: <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
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
X-Proofpoint-ORIG-GUID: uAWGrrmTl2KtKN_H49_v8iwHl4hbkK4h
X-Authority-Analysis: v=2.4 cv=GaCCDgXL c=1 sm=1 tr=0 ts=6ad81226 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8
 a=-BBy4ptD6Xa2-Mryg3AA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfXwhmaw+rx2RYx
 UGHI9uDfw7CD6TF038BwzKrMJ//hM2S+FYERkAj9VwUYbAMFJPwM9+gI41NJM1foVdoi1RzKr3o
 HFIeD/wb3LvdJ6aFYMHcfbKKHGEXs8g=
X-Proofpoint-GUID: uAWGrrmTl2KtKN_H49_v8iwHl4hbkK4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX6NodKB2OOCh7
 v/GMGLb965va5x1I6+Uvjy8m9Wbpcinfif4pxTLj254SAW/8P8uzm6y7fiustuA2r17oApS49z1
 xKhOqWlEtwUbRqkIHoJftFFEhxePngj2pof1TwdCgCmXQvMZ8Soq6N5gEyaY9rxWykzGw8CfxG7
 Z9F4Lber5sISsvN0zZmh2MSIMEr//XsuN9d7OrJMdyZx8+PySlHT4Cno/EfmvJ4ufs3PsCAmVxq
 a7iY636NOIdHmi6xIt5tyKC1fFc7hR5H6s5m7V7+N19IkdAPhi2YsD6aKCg+ceor9iA3RZgB/wp
 vd5WzdHXPHcIDwzNaENxYccnbIDAFz9rgd8Zcd1z0wnugX+vkUIwSrhaw5W6j5klYdeXhGqQ5Xz
 1mvib/DdiX1watL3rm2jeAo7DXlLN98l768Y8QYZ52UQLxSe+QM6lASLI5J0m+HicZ2R7EMjSUT
 vrhCzlRX1wVT89E0q1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

vsock_sysctl_ops and its two callbacks are named for the sysctl tables
they register, but the init callback already does more than that: it
also initialises the per-namespace vsock state through vsock_net_init().

Rename them to vsock_pernet_ops, vsock_pernet_init and
vsock_pernet_exit, so that later per-namespace work can be placed here
too.

No functional change.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/af_vsock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5a0ba068bfd1..aa4732c3599f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3037,7 +3037,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3047,14 +3047,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void vsock_sysctl_exit_net(struct net *net)
+static __net_exit void vsock_pernet_exit(struct net *net)
 {
 	vsock_sysctl_unregister(net);
 }
 
-static struct pernet_operations vsock_sysctl_ops = {
-	.init = vsock_sysctl_init_net,
-	.exit = vsock_sysctl_exit_net,
+static struct pernet_operations vsock_pernet_ops = {
+	.init = vsock_pernet_init,
+	.exit = vsock_pernet_exit,
 };
 
 static int __init vsock_init(void)
@@ -3084,7 +3084,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3108,7 +3108,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.0-Meta

