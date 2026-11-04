Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757261;
	b=nYVEgxkT/bdhRyv0Nz8OwxTbKZI1AdqJRRtKgta3TzqnMNDeiNozEIO8NmECbWQa3Noy
	 nBiqAdSgLv3AVL6Nx7qpj2vBI78sySJOfdmYNyYWWArTQFRNTvmJy/XPtrzWaXC5V5jgb
	 I7o2J6lzwROzINgGk2GSdrAnjnej7mQvP8MQw/5zeWX20VsyGlx7Ir6MJJe+2dY8nFm14
	 UT5QlJ5A1uQXFk6tQHr+Ocj+RWIV4VZSRwHiiJwebf8oEvd8Y3oDkyZhivmNWodUJc/dU
	 rhF8hwhIjSTVLjj+bGjD1OC48CeRIHtLjFnQu2aPioH/hfFygnjtXicEbRPmG2ae/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757261;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=+Rd+3kEkCsDWN0DvinxQu6xg72gBQ+FigAcOTspXtfI=;
	b=Z0VDh7munIKrjbCojKg0kaCx9OTEEwgR8uMMtoqe69u6D4wfoi1oYcPOEQlbskw5/w21
	 HI9YG05K0XO3rFh4c4DPcos3WBCfT6dieJIQOXcH7hNTlVBqKw+mAGa9x2hfu7dGaf5pJ
	 tE8TCgr7N8Ao0LwXLGmw6BK5clH9nCHKmG9Uv6Zs3bublm2bvM6eERFkw5n+IlaAt1kyI
	 aCGTSAdrDKjN6SQfWTx7tCqblO6xpMu6Ays1qNvNGV+t9u2NZD5n/bPxotrBlF+oyf9in
	 z3lUCnVlZLE4TET3+00AuIS/VGSPj8ZicYDQjqydACEl/N7CUwH8Ad6VKGjIO9DEeWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=b6Ir8iXv;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BF606A328
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983BF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=b6Ir8iXv
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40STwc3654074;
	Tue, 3 Nov 2026 17:54:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=+Rd+3kEkCsDWN0DvinxQu6xg72gBQ+FigAcOT
	spXtfI=; b=b6Ir8iXv6wbLkUn6j9ATqaAQ4Z7Jd2f0p5tKAYzd2RhLe7u/+5HlB
	XHJxk+rVwOao5Ws/aG8i997N8Lu690tIZUJ4+2106sWsf7xZG2srat5W4pQq9COu
	TIqySK1GBAPwKjEjL6Qg5v76ZgpIWdPyoOmV36ZNOi6BmeqT+j9SmD0/J0n3Acy8
	0YCwW/HS31XdTGs2MkAzyzUJ/3EuRMJ5UJRIUKzOC/QiQgxI3CkmKNM2xCismjKP
	FDXqeIhkVvoFDvlzmMd/Va/5iQqSeeio2sP46VrHUxpAlg0Rjbkr3MmUj+jtjTCO
	yxedEP9H2uPPSpMDuF9tDlfwRY4GDNm+Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqbrff7vq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:03 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:01 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:16 -0800
Subject: [PATCH net-next v5 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
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
Message-ID: <20261103-vsock-guest-ns-v5-1-48179b9b66b8@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX1XEWdBhCbQjH
 ZNzeZMt5F+yr/Be+5gZjJluEmUYTA4RMCXmbPNfZtvWMy7VAUAO8EWbyLajcsMbJOxBrHP2H7gJ
 nMxFgqXOpscTnguOdmkv0V83wBLcxedeDL1s30yx85N4agJVYxoQmU+ZXTY5mv4BR7zVGCEXm3p
 IjmVVgLe061IfqlTaZtxyjxZleq4M0WRrLqLp6pYAs60vq2PEVDYq1UYBZqvH668s5gOlG0awHG
 f0gGvE2CIponx0oWRSh1JOsyJlW1DMM6dtihE7FqFtMQHJ9e7UUulR4mxvtCkbLtNNEwQFG24pe
 kJs+LYMulsZMqrXKYgurMmsBxPICbwMqf8D79tskSCB4peo0b9uxjA8DzfnxH1TOSOJBaVoT4he
 JhIPKjnQQzwWT6P2bR3uCsIaWo3ZAqfifUEbeJh/JYBztd2uPOF3Kk134gdx4O0Kb1vpwlr7hS9
 fwEYsKMT/cVJYBtfGnA==
X-Proofpoint-GUID: cNfQLpC54Q5AcVMmtl5TN44QROMQnzjh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX/zvp6Hll4pi8
 KjEoCH09KHsDn5mtSUZ8/HwMTTcvjnBXU+XfVBEZ0YYaAEpeT0mI10T5w/XiH0bnB/TDwDQ9y35
 9EftXu3hzbPsSMm39vthSgpvzlZUbjc=
X-Authority-Analysis: v=2.4 cv=VPNIDNPX c=1 sm=1 tr=0 ts=6aea903b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=YkCHES2veT9o9JeyN-cA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: cNfQLpC54Q5AcVMmtl5TN44QROMQnzjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

Allow const transports to be passed too. The function only compares the
pointer against vsk->transport, which is itself const, and never writes
through it.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   | 2 +-
 net/vmw_vsock/af_vsock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..370fcd3ddabc 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -233,7 +233,7 @@ bool vsock_check_source(const struct vsock_sock *vsk,
 			const struct vsock_transport *transport,
 			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 483af15a5109..5a0ba068bfd1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -480,7 +480,7 @@ void vsock_remove_sock(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk))
 {
 	int i;

-- 
2.53.0-Meta

