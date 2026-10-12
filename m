Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF434252B
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845378; cv=none; b=RnHsXocDG3gzf/HL/le7cmmNkWv7dlyB4sYbMuwrcG87W/SJZx7Fp061KRgLItnuARd+ZS4v5R69fpQd9T0aV06ds+zwoykdwIF2MSZwKQFl+b7oTf6lAsFIy6d4AA0qHiZ9UFiCp1Csr/UwF7G1x/i3K+4SPrDfUpRQyXV/5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845378; c=relaxed/simple;
	bh=y3wfYZBw0I68GR0LUyrpvkFqUtlyhJht8f1TMlKrGxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kWOpvdKTMDk74toA5Ub8spgNnxoNW1NTSGr2xiZSf2Ta6cco8pnYbUWu6gFqNG5bVC911zy+hY0FSeb1xIdsMRMlAEXwxredzKVz1X4DDJX5V0QAe2cBy/QXHwAMdvG2sQId3YWaLTonbHp6Braeq3Hkg1xOfEIhtKOvKhI4+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=J1JtDkXu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="J1JtDkXu"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69CJOLNU668216;
	Mon, 12 Oct 2026 15:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=UOTAWlh5/qcBPx7JRy0CCU5iRO5LIPoSrMOWR
	tL9yIQ=; b=J1JtDkXuGUB8/+XKDxZtwsflUzgo04HGbSDdEvqu40499YueBa9ut
	/XfJg0gZ8qKshpCDPqA0ycRwMK24rOgvRLaY4YTz2G2d9tDfNs9Q+gmWpqM3CzOg
	7oDH8BNJjC5ksHuo5wK7oo/a5jBVTko5H3qrTkOdIbfJzRmVUxKuksvC2xLevUVp
	NExdaEpKc6dqQW2mUBljDNf+HyZhBqn29ci4PmhvFpQRpJnEsH6sGiTl3pT+BuWh
	R5U216qptQ30X008bxuVwmY/axa23/zfVZliWxWHfgCH5TkzgLQTVSDIIIFtMT/1
	BOiwOA6wr2R3wPeEK3E5ePB7nrwMBEc9A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4h7h19thvv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:17 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:16 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 15:48:33 -0700
Subject: [PATCH net-next v3 2/7] vsock: rename the vsock pernet operations
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-vsock-guest-ns-v3-2-b32447c66b23@meta.com>
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
X-Proofpoint-GUID: Vy9sGodBhQvzrTcUnaXaFGiOqiEPpwit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfXwgeOSreEwbFT
 Jw5TTV91lHU88+YMxocMV7ho3se1SAErzUXUp6tGX77qL1N0Ta5chKHWE4p5tFf/of+Ln/sOEoZ
 HZsO9ylRnH9KXqHZ/ZMlUKGcidRQJNQ=
X-Proofpoint-ORIG-GUID: Vy9sGodBhQvzrTcUnaXaFGiOqiEPpwit
X-Authority-Analysis: v=2.4 cv=HpvjiETS c=1 sm=1 tr=0 ts=6acd63ed cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VabnemYjAAAA:8
 a=-BBy4ptD6Xa2-Mryg3AA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX+XLna28m1q2j
 J6n7kDxfEU6IU+hdk4tjJKs16P3OTUBloZtbOWmT+s38L90xZ4ZwzNtqLi9/RXThqrZEBiqzRQw
 Q+eE89KYtNVbJMMimBtDeAyiTnSfK3Y7TiyNg0EOexf4xvWAhsaU2pdwHN9twl6QhkEe/FS+qu1
 QKxZ64hbbbBxdh31aG9TqemYHFpu9XS2RbHi8PT4d/4VuAkRfIw4B0bo47HyR6gw4qOVecajHdP
 1NtemDAlACXBQBcrtgKYs7OVsd7pViAIH7gxpqK5g4uaPcI+ZeEi99S/UW56FJrcHqdiCpm07eL
 SxXce1fq9gEs7e72QkNqE3+ydr3UE6kiLB4pDHRswBbBiljHs66u6EzSgv8qvZsor8FWYp5phzT
 5eIKdnkRMhUirT1jwvlaYN3O6D+nJ5IGWIP+YIqQDJiGkzY/MEsw7XO/3DULk4ARVxS0JZRwovL
 hotYrR1rjMtg6gMrj0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

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
index f4f091b2a6e3..f7dbef8cf6e7 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3036,7 +3036,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3046,14 +3046,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
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
@@ -3083,7 +3083,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3107,7 +3107,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.0-Meta

