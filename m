Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965666;
	b=DvNw1xbW2+6MPS1qW/tnN5dLWnNAc6eCInD6ix33XlWFWdrzmkqXPdMe/yXsFJtpjYfM
	 yvFYMAPWX8hN5mjarFy5zBVXVx8NBLUgsG8NVV5WJ9rwDupKimML8e9mKfnFi/wf5bWl2
	 5uzuuHA2kIP/I5SWfsuRXOW5fYLdy9TOPxxXBiajipPYMPorvmARWzwSQuCrORh9v30IH
	 YUfytVKzPX41BrW8XjMVvIXxI1RuUNFjFBM0LIvyz3UuzjsxW1TStLUX0I2aAhwdIm04p
	 QQWbhbBGeB3WVNEj5piIKuvgblrKGHqMsFvmpLhMzhfjxggEyLbcymMCdCPZXIb+7Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965666;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=jV6t6PWYU+gRY85PqmOrSMCX0RHQP5nPRKS2mctQx70=;
	b=IHOHgxPp0FoxvetKQN6Ep9HFLWXZJcJ+WcGGBOzdM/pqNbbZEVlFbmIAOTxH+yu2oICk
	 zk+nMRepRx9tLRzU0zPckcbqOL/kF7A36sVmIR4rov0u/R77N/mRzXAMGIlEYRqexNA4X
	 xBw3Jlz/WHzV6poM8P3r4OZhZLlegzPvxeBMtr6gPEPFX1e5kNxuybcPT1XIqE3iHuZHi
	 T+jYJe3jqZam8A+zV1g837zhDpNLk1tb5YWQMXIYMyyYaF2CNdDBJlJp9UVCwv7sicJ2A
	 jwibJkTEw6Atrov0CbCXM9VeA252E8MqFzjbBNrK9KMHO4y2FVS3BpkbuYZPwO5I50A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YzXKbEcn;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A0606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YzXKbEcn
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI11sU62326271;
	Tue, 17 Nov 2026 17:34:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=jV6t6PWYU
	+gRY85PqmOrSMCX0RHQP5nPRKS2mctQx70=; b=YzXKbEcntQQ187NavHnJepn7j
	IbXisjvcPsRN6/HhS0EXpz5iopQh3jTJ42ABfPOqTN8RUgHDfEAIBbS49U8zIri3
	F6TjjWPCmI4cCu6N/FNeUpNP+1sfQWtzn3r5+2zTCFWEwXpimNJt1dV63fQBI2mR
	Sf1CUM4jyUESt4Iq9PkVjGq5w3psadn5AZEIO3NHbtxquPCAoVupHZP3LUY5Vxlg
	rxaoFmYbGFrh+AcYDZxtdudMAVu1xstgdLPqBTNzP4+78unh7GJNEhXE/Pn4Tm/h
	Uf+iudjSLnAE+k/hCFCVGIZEgyFfc1vG4+MKfzMniG9oLmUrub6YalzyJTDAg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu7s7pv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:34:20 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:34:19 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 17 Nov 2026 17:34:09 -0800
Subject: [PATCH net v2] vsock: only undo SS_CONNECTING when connect() fails
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
Message-ID: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
X-B4-Tracking: v=1; b=H4sIAJAA/WoC/33NQQrCMBBA0auEWXfESW2DXXkP6aKZTm3QJpKEo
 JTcXegBXH94f4ck0UmCQe0QpbjkgodB6UYBr5N/CLoZBgX6rHsi6rGkwE/k4L1wRn6FJEhWrGH
 bkZgJGgXvKIv7HOodvGQYGwWrSznE73EqdKS/aCEkvLSLJd1dTTvPt03ydOKwwVhr/QGmtvkQu
 gAAAA==
X-Change-ID: 20261116-vsock-connect-close-1beb7cb51e7a
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        George Zhang <georgezhang@vmware.com>, Andy King
	<acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kyle Zeng <kylebot@openai.com>,
        Michal Luczaj
	<mhal@rbox.co>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNiBTYWx0ZWRfX9h6p7cNXFu97
 b5KhZx8l92XbScr/7OFTnbjdWe9bojwjowK73sCdL7c60quLyEm5UJ6BP+Ycu8OWklJ+WvcXvcw
 iJNbpInrC6N4RpXItHjehY1XvoATRwE=
X-Authority-Analysis: v=2.4 cv=OcANnRTY c=1 sm=1 tr=0 ts=6afd009c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=LG5T7v2SAAAA:8 a=dWtmrrPeSTUMx1N8XlQA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 1lAp7PZUHP2yHb_dgvSE_tBsFEe7YuzA
X-Proofpoint-GUID: 1lAp7PZUHP2yHb_dgvSE_tBsFEe7YuzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNiBTYWx0ZWRfX7vSPbx5BqbDL
 WplZBoWXo+w+X8Nem9tgijngINBH7fZAyaado+Qd6RlaK+Sl1kXFIvxwZz5WibCHdrsUht0im1r
 ds7yw41aSfSuxcDL26NDpGH8no5HtnlFjmSDg2HX/cF8slWp7ikUGvGknsyBH1yYIwIUlywLp2N
 O2Ndmuv3dwufNuTeheM1aJAfQOKVlLgD6lYb9HmV0PxJ05CFQti7zz2d++QlN5fjEPuP1JZ5kYz
 WuqCljfYSM1qi8/OHXgtc3AvuvKOeZffYZyjjbXzQpggGPNdbXDi37vjEy9T9PoES2O1F15ZMlh
 hDhUbtaUBR17oiLwdLBoyt6OTVYy9H7ytIFiYt2ZK3oN+R32NtZ1TwejOy+P8SXht6pEDKMFrNf
 ZiiPzw7TTuRgNoXZEpnJ6YUX6ZAsKaNp1qaqRusF3WgH5QOf2Wf2PNrJEW8iX1uN1hQ+leiKuVa
 m+Uy4rDi+5zJuBCbdKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

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

Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
Otherwise a second thread blocked in connect() on the same socket can
time out after the first one failed and called listen(), and overwrite
TCP_LISTEN.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Kyle Zeng <kylebot@openai.com>
Link: https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Only reset sk_state if it is still TCP_SYN_SENT, so a concurrent
  connect() caller that times out late doesn't overwrite TCP_LISTEN
  (Sashiko).
- Drop Michal's Reviewed-by since the code changed.
- Link to v1: https://lore.kernel.org/r/20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1d7d53542724..ce958b48295b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1704,6 +1704,19 @@ static void vsock_connect_timeout(struct work_struct *work)
 	sock_put(sk);
 }
 
+/* Avoid breaking the socket when another thread has changed its state while
+ * we were asleep.
+ */
+static void vsock_connect_close(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (sk->sk_state == TCP_SYN_SENT)
+		sk->sk_state = TCP_CLOSE;
+	if (sock->state == SS_CONNECTING)
+		sock->state = SS_UNCONNECTED;
+}
+
 static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 int addr_len, int flags)
 {
@@ -1862,8 +1875,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 			 * sk_state == TCP_SYN_SENT, which hereby we break.
 			 * In such case VIRTIO_VSOCK_OP_RST will follow.
 			 */
-			sk->sk_state = TCP_CLOSE;
-			sock->state = SS_UNCONNECTED;
+			vsock_connect_close(sock);
 
 			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
 			 * transport->connect().
@@ -1877,10 +1889,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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

---
base-commit: 533ec433efdc11196f438da90d683053a57257ff
change-id: 20261116-vsock-connect-close-1beb7cb51e7a

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

