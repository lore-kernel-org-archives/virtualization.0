Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479676;
	b=zqGBnn+tRf/dnF+tBVWbeq6OCBWNBdE1JK1Vn35h38RXJHSekUfTBNlAwUYlCQT+EosO
	 BCK/GxIcBqJaSg/zzNdsMSdaKJT4Cv9JKbtIdwsiIEF7eQl0zZA2J5Pm8KFGy5DYWpSE6
	 QVrxL36vwcR+QxWCTrV0GID0bcwI98ucrDkYG4HU/y1xwUtqt5vacxjR5NULgMfDDEA0S
	 KXk3D8SvUYfE8JIMUgIT/wYVwFrkP1YX1te1qgSbkmvbs8sSAPgYcdzPN8KjhA5GzYCI1
	 9RmiB7UB3d2XIwmW7QlOlMwCbBYcDL+veWfKXwwNBCgEUde1tybCgii0IfLqdqZSuKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=BHs/OyYUfBBxLJirzBuVYNat8LAfLh3aco/vCWM/6mQ=;
	b=r09B1EyJ39w05BqcQlLRBPce6Iz5fZBoD4Scp6KRhqjwd68FhoALFStr15mO/Wbyc+7g
	 U8L5ZbIrr43rSAA67efnbXq2am9c1DUuMGrcdPrOFErFlK2p8I5gQejKRe/epHF0c/nmu
	 1QI+QYWiqWdbi1XdJ+vG8YeAYxIPmZGfpZAb/wWTfDnfnuTaGk1Uf/aGeWjLPGq33XY1E
	 3qNnXiUx49nz+qlxbD7k2EEPcWY8OscXIXd5Yx3wrOgjkV0M6DTTYtHdzC5Vlrmba1Rsg
	 OPAIuoaPe93iIuBllZcs+MyAdxxmDNmVG+0v/Z7yH+aU8ybcldgYOz235Fqo+HI0weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=gLYMP5q9;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E533606A31C;
	Thu, 12 Nov 2026 10:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E533606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=gLYMP5q9
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRS8V-004syg-8P; Thu, 12 Nov 2026 11:34:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=BHs/OyYUfBBxLJirzBuVYNat8LAfLh3aco/vCWM/6mQ=; b=gLYMP5q92vNmSm4ft3Ovgkax4c
	TPAbjsp0h35/45KsUt2MYjKaR2v5xz77KKfnCb09BWhXyGTPUxcPmQOYBWJiF7yZaYjs5MgyJMmEA
	TohimVwv8peDL07jMJvVyMtHDH1HvHCdjjgLtkw+BcK0m7YVhVXTv7UqmWrjPUhPLMFWTcuLrenBt
	1qYSUgTB764G576Dc0FlVu2k2IMVcxJWBLIvOWsa3tX8287zc5mZDlGKvnr29CbgZCfbUFf2CXxxZ
	lBHoALTVQ3LzkFBY/Lu4kqkhe63658IDUlZRZOjhMHmZRjEb6pZDtc45CzEUJgcOKsaL9Swvc/UEz
	cKEtTAAg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRS8O-0003BV-RN; Thu, 12 Nov 2026 11:34:24 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRS8K-005SbJ-27;
	Thu, 12 Nov 2026 11:34:20 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 12 Nov 2026 11:34:14 +0100
Subject: [PATCH net] vhost/vsock: Fix socket state constant
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
Message-Id: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCQAwFf6XkbMBNywr+injYtk9dD9uSxCKU/
 rvbepyBmZUMmmF0bVZSLNnyVCqEU0PDK5UnOI+VSc4SQwjCrqnYPKmzwuBsnhz8yF/upI1t38V
 R0oVqPyuqPt43KnC6/6V9+jcG36+0bT+OUa8jggAAAA==
X-Change-ID: 20261112-transport-reset-state-fix-42363b46d2a7
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
Until now, sk->sk_state = 1 stood for TCP_ESTABLISHED.

Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Salvaging a single already-reviewed patch from a series[1] that was
superseded.

[1]: https://lore.kernel.org/all/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co/
---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 88a310390eb0..fd224f7681d9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -789,7 +789,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 
 	sock_set_flag(sk, SOCK_DONE);
 	vsk->peer_shutdown = SHUTDOWN_MASK;
-	sk->sk_state = SS_UNCONNECTED;
+	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = ECONNRESET;
 	sk_error_report(sk);
 }

---
base-commit: 145480b28ca82e9fae789427cc4569e596515a32
change-id: 20261112-transport-reset-state-fix-42363b46d2a7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

