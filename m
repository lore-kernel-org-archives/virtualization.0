Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626447;
	b=xJeu+Xp8uGvbNQ4uRqF1tOH0hHNlHaYnWMvpZrcUOXgUSMgyyswaGwkEvrCH71lFjJxd
	 IjX8KHZ+h/23TG2U+IWmujKCEPJ0qODLzru9YKaeEnBptARwc66CuCAFPiUO0l0eEddKt
	 2f4WIHYf1SZaMJhSy0H1VjMZL90tE6yxAd7gnIw0KLyD7rWshwhQzstf8wj+g1VdvUf/n
	 1BhwNndIK7qngEO6W723oRGWictGzJqwM9rG7EsiwBMZ0nkcraF18DyCOV17iIeQIkYI1
	 VlPa3918WSrTfTkbyp1i935RZALOMYsWrSganKylxtf7e02FGYDUVIKTDaUOT6YZ6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626447;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=rYrFlTJB+UyawFkAk0hfqRmJvjhfc3t73nvjA5LiMm0=;
	b=ZUZOaLyWT21MA2xJiIawUicI8tMkTFv2GhH6D3PPq9oStxrKXoG2lskvKMM7aXsJRX4b
	 Kxp89F9mBEyXFv+6Bk+YmAK0bL2MqYfV8ioxg9yUPx1mwdL8YQvAOfB4zEuejhDed+7jl
	 iQ+17ef3zD+CY74oLu+seSyaWm5xFqPqlmnZdv8yyL7/+0i8Cuwp4bdX7jx4+Rgis6+BR
	 UpmUfD3mlHSYTwT8LyXwWHHokMHUYQC/ncl2Y8R8fONLG33SbcqQIjP6rMY8Q2uyYjMOM
	 zcIrjWyKuex0B1gmu5mw2wXyJc9Nr12uu2SQdGTiR+cqqp1HAmMFU6ptdR3Jnz6+P0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=V1VzAOam;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895D606A331
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C895D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=V1VzAOam
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22bu31684277;
	Fri, 13 Nov 2026 19:20:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=rYrFlTJB+UyawFkAk0hfqRmJvjhfc3t73nvjA
	5LiMm0=; b=V1VzAOamwKmwLlO7KobU5F7uVSo6pVnD6if5nGqEZSb6UIvWG16xK
	K/NxSSBCNlxjuHTPGfJWk2QXHbiLSk7NqLp9Qs0m1ZwwAxyCT2f3Ul/LUWfgAU8u
	COteckQwXV/Hf8Vx+cxlBY4ZpsEA7dK+5hUSr8E/VJI+OjzxeWU8qKHAUtB1Rd8q
	ZudQEcB5KQoMuSSIoTfnoSsI/eQOlE0SvwIoHmvIz5UkREoYMOaDvZVV34eCgPIa
	AdM8W4bA/2E3zvBQLIsKkkRfU7DrQxFy61ZLk3ORbo8kE7KjUYWQ7PTF4ALfHhf1
	j1NoGI060xiswOOXD6TJ5jdQh7CGbW21Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwftjv17u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:24 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:23 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:14 -0800
Subject: [PATCH net-next v6 3/8] vsock: rename the vsock pernet operations
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
Message-ID: <20261113-vsock-guest-ns-v6-3-3737ce4673c0@meta.com>
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
X-Authority-Analysis: v=2.4 cv=ZYiIpcVA c=1 sm=1 tr=0 ts=6af7d378 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=-BBy4ptD6Xa2-Mryg3AA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX089up6LRXeZp
 yb9MqCMhkxXK1o5GKnLy3HkL6syPE0dEGL6egjHec2DBMiBRCmi5gCG/yasaWbtvv9lC25LtVDC
 PtcEP2W2i/XHSFrp4nfxkEIHOSlrDs/EJaBpnFm/gFWLvs6p7ANsM6vJQFbPm2Plp3bFB9Qt2yY
 glVme3X79Bx7V0s/Iq3m2/v8EftFXk7C0wCb0MDGXSOmGbcvioGf/nKsnX/og/Lhj9m+ehkFYZ9
 ZSKIpiE1zpFxdBpV7/FPK8YcJ4q5S0uBjdarG6oFAGIijb3+zqTVCfbmnFG/bSmS0D4X8Cto3Ir
 Hyg6iEasta59K/iN1AnjA16eKWwagDno5Tr1I2gL81zzUANagNf33xqiit66n7Mm2R+A2JjP40W
 AGfICNzNMJqv150wl076Z65zS/4hI3BYTt8jf92+nNAGpIOI0rY3ceBZ128/WAqOXKRTjEgq/Y/
 2xyy9u3vXeYNv1OorEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX6U58HonYd5on
 cjUKuxIic7k/g3JbDkA6NyNVblKVpadF+eTbZddeNGcZmyb6kz6eGPAVw4Xgho6W5uBRjPu6jfc
 GTGLXvJqQ+YsvfeEKTaTLfI3gV7ru8w=
X-Proofpoint-ORIG-GUID: SbAGkdZ09bkgC5EpHsHzONk5UAULgjRj
X-Proofpoint-GUID: SbAGkdZ09bkgC5EpHsHzONk5UAULgjRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

vsock_sysctl_ops and its two callbacks are named for the sysctl tables
they register, but the init callback already does more than that: it
also initialises the per-namespace vsock state through vsock_net_init().

Rename them to vsock_pernet_ops, vsock_pernet_init and
vsock_pernet_exit, so that later per-namespace work can be placed here
too.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/af_vsock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index eaf77ab55321..4dee7af259ab 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3044,7 +3044,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3054,14 +3054,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
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
@@ -3091,7 +3091,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3115,7 +3115,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.1-Meta

