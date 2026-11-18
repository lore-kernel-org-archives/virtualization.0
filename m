Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966919;
	b=AOEx/Hlj+0aDIOnkxjKDGtD7DOFrAo5R/1MaEwaEQuHNAIVfkAJXop0IKz8xJFaE+UoG
	 EXhVpY3vDUMmYbZmeGgq1qNskMqBulCnSDcr97HQrLDnq7jdYH6Vw+C8SCVSOWnH/dhYQ
	 4nGbQ3PC9E3bDfz+e3XvF8XRk+bwJIIJ9BX7kYlPsn7bPsj7KGXpskAaoSfW8UZEkUJ1i
	 qrnmvZg021SixIGZJZg+HelbrllOwiorEQzCHA19ER/lvHfwRo3WX5W9kzaIMNObNL0XL
	 Q9Lh7vc0BQmg8EIMZv5xzbjyP3ESwDFUCiu7h4xa9SztjONCiIAwXdVx6xfKdDyxU9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966919;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=IAFDDFck3TkcsOlyiLhhqw74fLrYiwTEwjL3bipgbAs=;
	b=xEOg7TL8w+qJGPah3ZdykjXSbfIasAMpnfCMoZzFdyJTCtYecbknO0KkMVQnKxtipSR/
	 XA+6tNpXy5/ZWoaC49mlKNLNMIhczB2AuFnr9sO/19YMDtKHxMci7uUo50Ttj/d2WoDw+
	 9f2j8ha1+jBhX98TjC2ENMzWEq8sXH6tyl2MsrNgwCD2LGboWoNayAiP3lKLhaH28MWFd
	 4Ep6yKDAofwkuuOIWGLGYG0cGlkTIdXNH8uA0hw8x9GrhUn68x3KjxCKhb9v+faMI6nP/
	 U2hhyWCb5RhynnCPPDedBBMxBcP9NEXJUwg6BEY4llwrL29L239ugqwizGoJyCKnYAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fb2VKLPk;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A720606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A720606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=fb2VKLPk
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI12EgQ2682821;
	Tue, 17 Nov 2026 17:55:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=IAFDDFck3TkcsOlyiLhhqw74fLrYiwTEwjL3b
	ipgbAs=; b=fb2VKLPkqaeJY/jtcvubx5YZru83lz9GiLpH7Sq0J2gXnYoFPLhtZ
	saWGApH+eOyQkIvqMXxJJxX46cc7q8hxVBIxHImknlDKSlXIuU8+NMIBRF5LfAn3
	QjeN0QgW12bLPZAJ7FRrh31Z13f6DMImWqsGsa2lxTpwmYPYvf2AL6tWbfG2flwn
	8lMQBSodyp3F9BUP4JulZxMw31e0GJw7LX4aX4zbsq0uYeN1ZObjW4Km2MVDfHvY
	eg8YdQU4UtLAN71nIdXCHgfEQ68ta/zcG/K79X4zBW746ZOz8Hy06/qhXgi3l+NS
	SNaz4/kqRK80AD4d74K+iJSDZUKF9vqNg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu69bc7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:03 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:02 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:54:44 -0800
Subject: [PATCH net-next v7 1/7] vsock: constify the transport in
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
Message-ID: <20261117-vsock-guest-ns-v7-1-7e522ea9dd9b@meta.com>
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
X-Proofpoint-GUID: 18r-78dAn4V1aP2MF3Sf-hdUsTJ10r6Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfXyF0iwtGmE0Nm
 mLRlPTj40gzuWrHpPu5BWJZut50VA/rvsqFi1QQNJ0Ajt/OpTaaOaCQozvbcui1Z9oZVc1nPauz
 +a4KhIO3biAzSyT+OC1VSeg6eAqLM7g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX0TmEC1TAWeIP
 +8AfjOpk/yKtzXzc390R2KRKSpI2niZrdL5khyBLIkUJRnGHkA57pvUlnZa9X9JC5SzXLuNglNT
 HW94A/qP+yLPBXdz5Lfh56NWGsHq4YNCPKrnhBiXz4VphBtTFJQtnD+Yx7+PDuY2Jaa+AQQ7zXv
 nSfukvdk0GBz7UVYnPVdoaKcOIB6tdSWXaD+w55IMN0FqqZu1wt1IXqS1knMpKZP53bgFkeMNsb
 yKchJQufg0d3JbSviJZEFznKiN1kst3UrjttokqOLbNIiJw9mgDA8qjU9Jqw+qlOjqqJEd8ONvu
 NtJJH+edsV+aByksv+bY36ajvOSRRmNPX0Mi+cRqk8uy/08EaGj9uL2RUcRgBUxmA9F33YheJOC
 blp6vdbT8LkhSsOhTCFJAajan4r2aq3H8Q8XSpSnMUoM3oopB65Ach7D5a5oNIixOOQuDwVWSgO
 UAnQpIvGE72+T7KpQWQ==
X-Authority-Analysis: v=2.4 cv=H6JOUOYi c=1 sm=1 tr=0 ts=6afd0577 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=YkCHES2veT9o9JeyN-cA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 18r-78dAn4V1aP2MF3Sf-hdUsTJ10r6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

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
index 3e28865578eb..0ddcf2325ba5 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -234,7 +234,7 @@ bool vsock_check_source(const struct vsock_sock *vsk,
 			const struct vsock_transport *transport,
 			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ce958b48295b..a5c805f3b29e 100644
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

