Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C833ADBA
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845377; cv=none; b=LZFweYAB+h5hQHNUva8YfmvrJ7b/bt85NUZPUC3YCx5H11p0NOTGygZzbHSM52RFD/g8h1RA6yh9BsHZ5dCFcDFmoo9/3KtA9mp297T0EwcWXcQI9pfNtaSH4Sdg0Mxz2rYV+DsI0eMcpnFXVqiMlxOO2sJmln65kP3T+rBOj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845377; c=relaxed/simple;
	bh=78clmAwsi1el+xgSDzzxN+v+PeZ+98dtyaacZcx96mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jm9YI8ZIe2H+iXd8s4qjGvg1kxxwKifGXKiX62R/PnSJn0iy9nVisEemZwlOYouh6sWFbOKR7zGdBuDLD9rLuVmynfmaySp85iAupYiJDAmBF9g0pSibbZ+U3OQ2K9sEFxxjtQNdzhbeBPoyNQyDcwmZ9iIbJ1xJyCChcOXLSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nigQEZOV; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nigQEZOV"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJOTRc1689810;
	Mon, 12 Oct 2026 15:49:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=qD8wtWpgaBNW/8S6Hs6GY7gA8M+h2Sx7B3sV6
	RD6rlc=; b=nigQEZOVRmUXzXhkwBrd2EdJf+Kcv7aJiqZAj20XZktPnie6SNy8y
	lHx4NvEDK52PfmGZh9FEV2SCVwGoJBM7PRpm9RjZAZlb/EycJeMPTbHEWjUoWcID
	EXE8+etJJWOWAPEVkiyKIlunas6FiupynOCSLTahdkirbXEFN49vldUtYIpBCEsw
	m8dUStsPMj8h8ygJ+ArZpjUprTujCsBvBqiTVhvgy59I8gX1d7P8iSxYmwpqMmNZ
	tDY6hHKB5nvZKTbHYR0HYtG9ZZelGq7Brtbhc+ncbzs47+Er1j3CyjTV1Pvfawca
	sGRkb3Egsd6g2K4r9rFfx4LiW10SsT/Kg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h860hn20e-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:16 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:15 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 15:48:32 -0700
Subject: [PATCH net-next v3 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-vsock-guest-ns-v3-1-b32447c66b23@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX7Rg5XS41bj0C
 sNB3Z3GcST5SDwi4pTMwOSUpx662psFKS7cTagZkwgDyzrdbfL1DOybxJZJuYuaxRuna6iN4bw3
 ZiXU2yc5tuHHEAVL6jcoPUk0QB01Lho=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX92V9DOk07iBh
 RZRkDkgxYs8X5Cj3qLk8+fiKELFZRyTjZtSutE/TB8fI7dQ0U3IJ1Qq5QTEXNuoZLJNld45dETL
 0Hq/VMHHamv0jerUxFsM/Id/pzbSb1zeHc7exhFC284fDQ+e2Rt5KUf3uGj1TH7BIYKnEh19BGQ
 37SJ5wK/GXKXpaWW7fw8qnBh2cScBuo9jgtn7sNwL4XXHgBVLoYCyA0rkToSV+jZubfmY9XbGBe
 C0Eo1f9MmtcnvHD1VZ3mHqSzpBfY7eGq5ZvhJxX/G4DD+czbgcQjWLkfaLdCnYzZkghSWKDPBj8
 2GLyKRgMUDCqly88vYsjaGX53ooIksWkYR1cWvEAIKM1wj8635ksGWikad+MT6OMdgIPKoXs3OE
 xWlWh/bGwcKbPy6+0YzbIwjLU9x4oYzyGKmspW+v6+78dWsGBybPqdRU/5vs4dPoIffbIJCV4ma
 Txlfp5353yriZzWFmpw==
X-Authority-Analysis: v=2.4 cv=cJx1IVeN c=1 sm=1 tr=0 ts=6acd63ec cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=YkCHES2veT9o9JeyN-cA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: p7virgS3PT0zOjse0jArwKxrstDIw9b-
X-Proofpoint-GUID: p7virgS3PT0zOjse0jArwKxrstDIw9b-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

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
index 44cee7451955..f4f091b2a6e3 100644
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

