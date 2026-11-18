Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966922;
	b=2+v9TGOSXgg0cMuq1Ub5lZTZaU+BrB41WeLKqBdwKV1U4o8Yz9zHt2ayXprRmjHLZnj8
	 Zoa46DkzeoD3+HrGrnTAdurqztO5ce5aqQo7Npbo3zZkICXYsrpgHD9QLJlO7NPMN0/6/
	 nbDw7eGRLMatYAgn6Ea5rHtiX3fBvcoLeZCeBl24p7PHfPG+mBYkrYuE8svJsr6MK8UPv
	 XbiJKNKoV4glO3PqwXX2CH8Uy0zPAJiVx6TQoDV55hQ3Bjl01vG9DAyLVyCs3AYS0xFBd
	 mjo0VXRM8en6ihnBg/1HQMTZyf9OTK3cyTuj3LY5HQO+MyfXXsBOtf8CXqewQseLkCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=rM+PXP8JJcUMybNdJI1OSHiTvgbrlHQWSRXWArsiwAg=;
	b=I63fNh+bEeK5F8liId2INaLWeV8G3ZrWjqG79G97ZXkNgSVr8xbRJync/YDpRlrvhGpS
	 obtzoHYMiFdNHol2HdJ9Ys9f/S4TEKPTJOaRjMSWKCoLS9r6BV+faQOL1mnJy00I/37wm
	 R3U2tVJGBXJ+QY7RGJU8KmO5SRNhWjdSPYuNj3LfV7vMe5nyHS5+Jf9W31vS3gs3VjZ/D
	 m1HpAR+dG4aqOUbroVhrkJr7icrInZsuKWhaH4i2IiAsd3fmdoiJTwvM3KCxHoOq42Gl2
	 f1oJ6l7E/1WRY175ZoEffE55O86dCmstwLQkbYVO6shmUfayX9RiysMIpRto1Z0Or3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NgyrMkgn;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9B606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NgyrMkgn
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AI11qOJ492445;
	Tue, 17 Nov 2026 17:55:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=rM+PXP8JJcUMybNdJI1OSHiTvgbrlHQWSRXWA
	rsiwAg=; b=NgyrMkgn7zoJAejeX7xHRk/oQWDQLUDUzfZj8fdElA2XyuiX9rZT7
	fYGZQge5cmW5hh9p6cuJkhvrwFHYWpP+RfKG7Cewiq5y4rVprUNCDL0obHYWHExO
	E1MZOlVIMSHt+3MvpRJiNhPItno1xZQ8GssYg68be7xsvpqLAi0ATDqWFr0NoE46
	RzrHcbM1YfD/M9bvuD0laJHTtikVgrZtY+8QG9BVBJDWONKmGZDIEpNYvp4PraYc
	fhBAe4jyes7zAQHjvdoZ+8mBn1TwmF8+f96hbHxeGYOY2c0WZCwCyQ5ODl2Iwn0B
	HyLOlKGspd0kdkgHzp1PBnkiHdFLgsXeg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j0yu5hcsc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:04 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:03 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:54:45 -0800
Subject: [PATCH net-next v7 2/7] vsock: rename the vsock pernet operations
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
Message-ID: <20261117-vsock-guest-ns-v7-2-7e522ea9dd9b@meta.com>
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
X-Authority-Analysis: v=2.4 cv=EqFHPicA c=1 sm=1 tr=0 ts=6afd0578 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=-BBy4ptD6Xa2-Mryg3AA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX24btXMYEUauj
 mBazeTyfil3Iv7ihLkyarcYJ8/VBzLw0uzMmFVbXoLVswgkZIRmh44BKJZ5PtaEr4WVJLPDhjtj
 KHao9RxrAmRXieasF4FIsqRXfBR7Z+s=
X-Proofpoint-ORIG-GUID: 8GRUW8R3u0AxQ7M7fwEbViQ7m8jifeDN
X-Proofpoint-GUID: 8GRUW8R3u0AxQ7M7fwEbViQ7m8jifeDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfXxMkPNEKAXDcu
 mJI3Tfzq46NMeGhqbsTOeRG+kORPOj+I7hPZrAjY9/zbZgJ7Ttnvr6WajyBmOpC5+um74ronJ/t
 9eBMGh+Q3sQvMv71PCirns17NwX5AGakuLGlmeC9GyEik9lY5/QvkmWAEOki+UCm9MYXs+bJFFQ
 yHBi2RzCcJqEqrl+D7VvLDcW2Xc7Zui2GK6PAH/NrC3wHaDCB4VsIUxi+IyOKdvLbzXnCGqoHfG
 qJECJ1ly9lUJIoQf2gyAyyGiFL3R+BHbBkHhN9xuaewNLQcNuikkX3oq3bgkBmQZD74I45uMR3A
 lfuB6ANTp6z9sj/ok8uoiLk3n/1pnYDSgfHjlUSgRw4XlazM719DnUBVhglcIoIjmkxHjxQ0mEv
 qFugf0uyyax3vPyeQOWkqQ6tJVE4UvBHdBZ02FxXAUbyhi4J8exCdptD2SSlXZo3LMWrtRw02mO
 Y/OCcdhxdQiW7FIeH1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

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
index a5c805f3b29e..100570d83e75 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3117,7 +3117,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3127,14 +3127,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
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
@@ -3164,7 +3164,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3188,7 +3188,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.1-Meta

