Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88EC221FD2
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956615; cv=none; b=nFsD39ge1h76/f2+NwRdWItd5ssUjrCOLyNcs+6BaK1wxz/M3KnJE0UiW0Sv0zMpTVYM6dKswm4RVPr+KmkN4Fhnpdg5JEmpusDHPkBt9mdRxE7laDeCovIm6isPfuU6g1/Vm72k6AgpYQdHQUc50Lxwx5dFkcPz68QudkWmM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956615; c=relaxed/simple;
	bh=lrNsByWI4+JZUOhPSorgBp0TBt5xNkaU5kzScC5uvPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bstEsaTG7LnCrz3BFpv7XNciFQkwVTMn/bnY49FXX2zbexH6xnqqg6it5aF+UwTiUOFTCHYFdW7vmiWryIwxjlwL/rE7aNhQW1Df3KpR10FN0WZ1I0l3Za2KfbyU//8s5V9yVzxjdRKKW9LbNkqlU9jpeelfKyH2fxkA2wdQENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=H+8QSoGf; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="H+8QSoGf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956605; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=enAMJL6mb/z9WNfWVziA8KCdR5RF2FfP9GwDXl38f/E=;
	b=H+8QSoGfmlSGIIxJeJ7pYnYimR+DcyuUI9Fd2F39PUDxk8fu1TO5DxD0Thn/Fv/HX97NCpIZm08Ebytje96Bg/dyKu6L7qU1YcnxODl4Cu617wk1gUnFZ0F/gOQ8n6IGyUt1jkcCW7uhfq33uijmm3JABNV/XP/a78Wj1BBIueU=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAe-_1751956603 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:44 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Tue, 08 Jul 2025 14:36:12 +0800
Subject: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
In-Reply-To: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
X-Mailer: b4 0.14.2

Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
socket. The value is obtained from `vsock_stream_has_data()`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsock_stream_has_data(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 

-- 
2.34.1

