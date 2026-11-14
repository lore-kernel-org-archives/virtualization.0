Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626446;
	b=I1AlNaWcqzBqY4uugxoDN1DvY8ourltzfjGwdks9wMS7GwNtnxIZM3eeZ5ZaxhqoMdie
	 4LpPg0nmjT6NLmFlBKHgcQhrPL9HAeVnlX8ocIIYzpZdK/M5uEPbGDFD0KIS5tSTDwYuX
	 n8VV1Ss2Qnpxgu9LIAlE7OZgdTcnN8ktzwRyEvEuolRGNPzuEwlZ5JeClM3vu12S8ATOm
	 OlX61USs/KAA2O6VtDZl9/9fSLZeCwk7oH41FtvXFWb6m/hqaWE8wIcqMswilM95NAG+N
	 5DHGyV3TAqvSp1PzLO2BuUfY3Z5ZLcbvXkZg0X8WMkmof5PY+GjjRBwE34iHqUwTBtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626446;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=Zat2TDCQjQrCJJMrldTuofKduoOsw5NtEo4KJnXzX30=;
	b=5YfuSsmA39zTCAvGkJZN1kwsA4cEA5BMguFx2HNjntdzTwyeztbrYiot5HoltQj/SwjV
	 sUgLQWuNzj06jBt17c1NqTZzNRfMpaMb0nKPBUatKdQCDfk51osCk4C4AcUQFLxz8Z0Yh
	 ztv/W29K+ZYMtitYM/l1AaWgHA/Z94rNB1AEkjxsPixo4dpLDv8TgS1OvlBxZ+fzZXRoS
	 wdgFSpV4VvKbGJXlkm3sd/qKYqTamRwsQr0LHNe3OZZ1Z/nRq0CSmJREACjmGE+smeSmi
	 2LxAe6xbiQcBHYMxw0WDNvFu/pNfqus8w5e0ZqdFkscW/l/6je2rcVjlAJVs5S1BY4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=DbVcyXLr;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C7606A336
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9C7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=DbVcyXLr
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22QKo3157778;
	Fri, 13 Nov 2026 19:20:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Zat2TDCQjQrCJJMrldTuofKduoOsw5NtEo4KJ
	nXzX30=; b=DbVcyXLr2uaGvRGegH7A+eoDwDt4dpnjN6ZanArxGLZj+W9eHd0B/
	syjY2L/lZeYAgG8qPCXGDdrozSz7d6gbuJ8RSq19bq06WPmoa4C3kwErQzso5w6S
	HlXaW6PtmcNLns0rsA+lCMpwwEx9Q9LcA7hmBq0wLb10gXcXctRBll2G1KnG9YGZ
	F28/qeGZsv/gQHl4eTuVCvtQSCgkgP3Lxz0FzGxgV5Ds5WV58GPI92QA59cjPnLq
	MtVqGqk0rKuDiR9I3zsl16CEuql5I0KGufHnMCpU0FOPzBlqsZgeyYaaS3GuWQox
	8JQtGQpoLAuk4fFtcJ6NelZ1yToJ1f8SA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:23 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:22 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:13 -0800
Subject: [PATCH net-next v6 2/8] vsock: constify the transport in
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
Message-ID: <20261113-vsock-guest-ns-v6-2-3737ce4673c0@meta.com>
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
X-Proofpoint-ORIG-GUID: bemiz2S90q8sVTl3DAMVPZy6ZL5HvRAb
X-Proofpoint-GUID: bemiz2S90q8sVTl3DAMVPZy6ZL5HvRAb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfXw1vd/KzJ5D0k
 /K5YHwTpZm72AmOSdGOWmF/ZfIy9Am0QO3b38BpKregGz+o36YKVkqV7B3vJngpPhmMedV4Xlsh
 yTuYfvx6nrIK4GcFjcp127wpV2JDQpQ=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d377 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=YkCHES2veT9o9JeyN-cA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfXxdNMnqxwZfFH
 aXA5yH2re5udZq7NOLooD6zLaCqK8i3ZCVKPmYvit744jAX0h9bY3Mz2zdl2Uv2tf8FG9SbtzC1
 jAnLTXx9faylJ2z9q+s7YURDUpPafIjeogPYNhZcOo7A3rhGH97+CbVDMm5oNkOLt4n9smtPaOo
 /t3E9W3V6Mobpw15ortGGOYf7I0+O3P4wgBYK6TuOFy49eEWhbOgXVL+EvM1ltsWz42HcC88G4x
 rgLn7LKCXmxZ1pOV9lnVtLgONYq6MIELQY5QMVsNrUiMn4K0S2f1ItyC/LKCHsg9am8zM11aFb0
 NaVJkMSCGVBOnAJ6aci54m5am0NSIh5q45Hgt9A0joxYUqKCJxurZ8PaiIJpOwHUkiV839LKRI9
 bU5X7lFheIaIQL40qrUM1VX3/o9GMQaVmY2qO0NEeDVv7K2wlCM/hlkxcDv9IjHvAr/2ICOtUwo
 xFgbAmcNg76cInSFSxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

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
index dc81cd47f099..eaf77ab55321 100644
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
2.53.1-Meta

