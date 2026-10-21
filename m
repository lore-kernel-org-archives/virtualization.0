Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545336;
	b=CTCEUMgoBp160lACg1tRnOYDBHsF3xQPcjbu5jaRip0Bx8aW8Ryr75acuPateIDjc/ob
	 jfpozRMDnYG7oEVqJ18M5kyEHVd/Y+9EPf0i1ImxGfJqQrfp0k5J8S6+cZUxLA3f/Vsvf
	 XTCVBig7VFhmvjftJ5mOxHjx7KDhN8H2uVQ/hIPTDdy+wTVim/VBwmEOD8EtDf8vATDbI
	 2aq23KlHW1M6zQlCveaLHx+e66thFMFdab019ZjQO9Wbt4RiCeiZ/wPzDRza/YiFBK+VW
	 qKfeE4078M7dkqGU57hvsspMg9ME5arttAeZQUJhv8mjX6kiLIuvrRAQIIs5SXVwqqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=+Rd+3kEkCsDWN0DvinxQu6xg72gBQ+FigAcOTspXtfI=;
	b=pyMO5SgVGSHQhqJN29UEwMfDNS1pDBMnS+PamCSoaRh5pc+/9G9lY1uRHMaMzLYo4kAy
	 iQWPDKVCXe+TqQd2Jv/mPO0AzQkgLx3iwslb7C9NLky1i/bK5XoFpyRwX9xAUwWimZnlv
	 aLmmY29daAU7pPnKJOrygGpSl3O1hZG+1oPEaxGwLAmc77BkdxfhwR5KjI6zYFhGqMtH6
	 In87DINNARf5Kh3ga4YTtCqerVgbYqbVDJamSBvS+gat2gbk02Y1XnibwuK8N5yDs46Gh
	 eX4FlHyzFrZGJnYDLoOpnCiPU/N1tFRDhxFba9mvMdXDNM5BTXS6k92OaoDKhGwuYjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YJ+jeKMS;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF3606A31C
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BF3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YJ+jeKMS
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69KNF4pr3405467;
	Tue, 20 Oct 2026 18:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=+Rd+3kEkCsDWN0DvinxQu6xg72gBQ+FigAcOT
	spXtfI=; b=YJ+jeKMSD21K3MZJTczf5YmZWWC1p9vRLgTDIuEsyHHeCddJOCLXk
	QJgo0+djv3jHSpNkN8Wy7c184fYTa/cwrBnlz6v+gU36LV1ELWaDPTci6NFHqSyw
	4H7MaGzVaM493bk8N3ucdB2KW/bQ/SyxipQ7myXakOCdyi5eCVHPp1OY0hlxSc9K
	kv2CLVjQOUcWUv0TsoDl/MjvCOjUOkB6xy8AlWZAVH4mNXNJzy04cHAiUdUu2HNs
	b2y4phmlmUlKhb07awjPpI/4Tr0mJPMsU/diwgctyAJKEMRtSltKD4bmYntVZ8gS
	1r92zc3LXKTXbgfUIYP1oh0St88pttXfA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hdw56rsqq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:17 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 21 Oct
 2026 01:15:16 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 20 Oct 2026 18:15:04 -0700
Subject: [PATCH net-next v4 1/7] vsock: constify the transport in
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
Message-ID: <20261020-vsock-guest-ns-v4-1-047527cfccfc@meta.com>
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
X-Proofpoint-GUID: 9fqTzDTEQh1sPHL2-ALqesEAwd0XA8GN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX9oxiZxNHmwl4
 SXW8jeOYVrzHlmk2RTOcwdNX4zfMP45XQsLPyRBvfNRETBbs8H1fbjoYvtuYggpuM1JpEVeMXAl
 EAJCQA/VAGf81A5wHlFSYZw2UqkXPiiRYPyup1L+C3MDGLAAfChhs5QgHVSk/WkWKuEw+2mUfH8
 /wkiFhozbQRbYrRQrZjISPRQ+XUvC3+V9SQUNKb0cXw5mCWsdg3uc/IkT5+4emuS7BmSXLU6jVd
 2VnQ+85nAv7fk1X5SXeIdbsnMO7V9pXPytIh381xliClSrqEBr+pc/fnLy5T3rJtkDgF7KDvaXn
 fNze8GW6OOlBQwRhDiNfIKkPycSMgNkk9aYuaul/Gg1QDkb1W/c06AQSJaHHJysvUkrTzZqHEYI
 o0+C3ro5eNVGEwjDoK5xPF00nE0uto1WG4Q5LPheJMc22rgYKRA2d41AA4HdqdKgtmsbRkzZGx/
 j5U3rfcjQmcSfdwZgYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX4lf85LZnjz89
 nh6EkLV9vG/yrOPAM/haveJALy8ikmy3eo3AwJ6JfjoKwSHkoBwAAsCPEUyNqQUjiopUVAwkIOW
 0bgo4oaJ4hLi9/yPxJtCLtpnB4sRCGg=
X-Authority-Analysis: v=2.4 cv=J+Q/fwnS c=1 sm=1 tr=0 ts=6ad81225 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=YkCHES2veT9o9JeyN-cA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 9fqTzDTEQh1sPHL2-ALqesEAwd0XA8GN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

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

