Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626446;
	b=alfSIB8xiMVw2+Qei/1bHWgVgJLq75iAZC9+/bCMdirFt++jO2mmhuyAMHp6aiex0TSI
	 VOarS/KwR2Z+Lj+Ghs2k0E6BHoTcA3IqYWHueVZI5lwffXjED/h1wcoIAsNsNbUcs9JXM
	 P9+UYt2B6lSgpkhXUMREathuD6VNEyLya5L4ZvQ0aNr+MT12VzyluZqdHxvZ+WFSEyGsd
	 FwnN/jzj+083odzbOeSexxBkAu8uUB5qS0Sd9CYu/KCgf9NE7D/92LaSt3IXqhW66RRyx
	 Au0nBu++ZrAQrxDC1XGJ2YkWvC0x6YRLAWzzv6KhQtoSIQO78R7AFTlK1hY0BiqQFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626446;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=ZqC1JO7Xij1xDzS6PMbXLcvgwSoz4/mlT8vfbhBue/k=;
	b=ov9hO0Y4zKUq+hKtkaf1p9egLWptcfYJnbveVcogqreK1sdmfBcJSZxc9LP+O6xNQMJb
	 bvnkFVjnBm6yNkc15ejpVP8NLQcWIcIawqQ9g/D1C//q7kNzmJcQSJSRnIK6tdtywBSXT
	 7VsV12DphaKdrMNoyE+CvJclK0cF1zaQBz0NpHQELde3wPqcGJeKKKE0Yx8GI9AyzHoAE
	 QSkXKbDVYuKzr3pSt8YCB/v3XydgjvHzwx6OuMK/TgbbSayB/nub23Vnriux4YPV5YOwV
	 IvxHHXsk8XgXpu9Zaxo0u+b1qnecR7LXOkPdMM/wZ9+Nojnhd8OKGS14QR9tIzLnWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="g/+EcXOx";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB217606A327
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB217606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=g/+EcXOx
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22XEI2844953;
	Fri, 13 Nov 2026 19:20:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=ZqC1JO7Xij1xDzS6PMbXLcvgwSoz4/mlT8vfb
	hBue/k=; b=g/+EcXOx5cW9mVJHEM8GncVbH3mmWp41iKCEnUAfBZN6c7qJZQJBd
	6/cqweK9stIwn7f3Ah7fTmQ4eX6PYiTQGFCWCBfYLHyfZWZIur0w0Kl9wYvd9A/V
	hmFtWWgsS89EbZTwdZUOjArXAx0dcGvOZfIIln2JsyH/9TfQnfhBj+yQOjFDbYD2
	Yl3yyc4iE1Y9vhVmNzxSliIhlGujh3c0tEHWTC5POaBoouexKmObugdS2D6b1UNy
	vtBWBh0dWlSHr7eDYUcGyNbxMp+HJ9j3wBGzZFpCgeV2s7mguT+LDF5Kv8iXDEEK
	0O+SWzE0XAFj8lVT69f7syt/Hdgntln2w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hws2jg391-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:22 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:20 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Fri, 13 Nov 2026 19:14:12 -0800
Subject: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
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
Message-ID: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
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
	<bobbyeshleman@meta.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX0LeEncCIbCaW
 fC3lFb2IkSRz3V2Np/fgkBvG7+gjVtqQQIjiL+VHt2t//RfXYAYNKmGpb8hHsa5gCmMbUnuJIlS
 aBRk2EvEsFU8wbqAiknHuJ/bUU1+FlY=
X-Authority-Analysis: v=2.4 cv=B7QsQ+tM c=1 sm=1 tr=0 ts=6af7d376 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=8SSc3Ac-GxnkQpnFFP0A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: RVUn9LSV9M2pNuqbPtv7VbHlZwx4nBmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfXwMTQsn1M5UcJ
 xwwyUxNwy8vC0EzXDAOukpvFPAR332z94bdQ1YYeTn1hRqSab5rNdsBahmtCj2+mcJ9UnzttiOM
 6WQ3VtOIe8W0C75rtlSwMagOxvyB6R9GGUckemjij80yMttLJjdp2kZgh5bAg6L96QS3mMWy9e2
 xqHiSNLmaoJZVM1XLt+sBQYZbBDFxF/Ov9S+SwI16MAs7evesSBPzE2H/yVJLZa9kgg1dDgm3UK
 0yQY7DoJ3rSUHY+2BMGkmHVL60sQvujVIVn/yd098ZpFKCPBTZRIuZYIUVTqBcIlNq2Iq7lakV7
 etFbtHJYUwp/5RtZ6AhdKcQpbvHum6PysWfw1Se/liPYvVlrkFr1Ow9wJl8Gzr8silaX1yOI0rF
 OqQ9Ijgy2Z0m0EFN30kX+htzo0H+7Ny1R8k9/T5tVLKMW6Q13kMauwP5O6GpU3zbeiRx+EYul8C
 aTbke8V9bqRWwoP8fLA==
X-Proofpoint-GUID: RVUn9LSV9M2pNuqbPtv7VbHlZwx4nBmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
can complete the handshake, setting sock->state to SS_CONNECTED, and then
reset the connection, e.g. in vhost_vsock_reset_orphans(),
virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
connect() gets the lock back, it finds sk_err set and moves the socket
back to SS_UNCONNECTED. Userspace can then connect() the socket again,
and a connect() to a CID on another transport makes
vsock_assign_transport() release the transport the socket was connected
on.

Only move the socket back to SS_UNCONNECTED if it is still
SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
another connect() fails with -EISCONN.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Suggested-by: Michal Luczaj <mhal@rbox.co>
Link: https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/af_vsock.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 483af15a5109..dc81cd47f099 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1703,6 +1703,16 @@ static void vsock_connect_timeout(struct work_struct *work)
 	sock_put(sk);
 }
 
+/* Avoid breaking the socket when another thread has changed its sock->state
+ * while we were asleep.
+ */
+static void vsock_connect_close(struct socket *sock)
+{
+	sock->sk->sk_state = TCP_CLOSE;
+	if (sock->state == SS_CONNECTING)
+		sock->state = SS_UNCONNECTED;
+}
+
 static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 int addr_len, int flags)
 {
@@ -1861,8 +1871,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 * sk_state == TCP_SYN_SENT, which hereby we break.
 			 * In such case VIRTIO_VSOCK_OP_RST will follow.
 			 */
-			sk->sk_state = TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
+			vsock_connect_close(sock);
 
 			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
 			 * transport->connect().
@@ -1876,10 +1885,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	}
 
 	err = sock_error(sk);
-	if (err) {
-		sk->sk_state = TCP_CLOSE;
-		sock->state = SS_UNCONNECTED;
-	}
+	if (err)
+		vsock_connect_close(sock);
 
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);

-- 
2.53.1-Meta

