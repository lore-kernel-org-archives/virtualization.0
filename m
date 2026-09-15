Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF43AE1BC;
	Tue, 15 Sep 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478155; cv=none; b=cnjl/x4P0JZ3tSmhPpWSoO431QDD5+ZxZRZ3s1TxYRV2CVTKUHBASdLLPSwDxE3VE/W/++hmlzmFZnnAvM1LOf7VhS/xB4LgD7JdT1omBt6Q2mZUoL0MRF4UKOQBnpwQArSilnJd1J3mNovcRVpezMU0+A35OqpZhU9KazZeB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478155; c=relaxed/simple;
	bh=C0kAj0twCgVsqYz7xAzWT3venRQa0NE/YrdpflK9jAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RgONxHeyGHXxLTJtta31swZJ7M1dS/mDDsRLibZeH/uEIivw7lXsgf0UcNk8mMyI/hTtcTSdqBNjMO+/NYYCgnNzI4dXR2/rs3PNG9stcPnhRflAMyo+c8g5Z3w1KsTP/95t2Cb5bnI3FWM/YQBQE0HJe0npteLdg3524yXt/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XS5cEMDe; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XS5cEMDe"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0g-000wM2-AS; Tue, 15 Sep 2026 15:15:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=VaF+evrE8Rn7mltrExzSlFQ+pytZXfKnJyj0FVRJXyk=
	; b=XS5cEMDe6r7OoPmRvMaMypBHm69yF2hNOmEPOuYfn7zzgYcr/BcSlnzc7eSvY/4S2ecjmnxUK
	wisPy7F8cMOngXeposdztXDA0011Dt3FiIWolPe3mcYJ2we2+WTmng/Zx5yQx55244zpvPhMyn6KN
	ev0Nk/MYqL/eHEYtI/ozTx6vPhY/YqdRt7DCLUxcAlY+ZPOA0P8eJW4dONt5xUZ5U0jExdEAhhkDU
	/8ePIKoa7lwpUZ/8j53pGGwAg0pYpCyj4HPBBBWLC91bL4ll4Mo0YbAOXk23z/6A3FsuMCU+4nTHQ
	tb+AVaJpCrxuIk0wwWngBi49SRjOMVwK0o2Rxg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0V-0003iE-UH; Tue, 15 Sep 2026 15:15:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0H-00EUxD-9H;
	Tue, 15 Sep 2026 15:15:17 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/5] vsock: Fix connect() races
Date: Tue, 15 Sep 2026 15:15:11 +0200
Message-Id: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ7CIBREr9L8td9QEltw5T1MFwKfFjVgAElN0
 7tL697lTGbezAKJoqME52aBSMUlF3wV/NCAnm5+JHSmauCMd0xwhiUF/UAdvCedMVKijPoZkvM
 jSmEMF30nTW+hEl6RrJt3+hU8ZRh+Znqre21v3C02uZRD/OwfSruH9znJ5N+50mKLJ8alUFJrq
 +wlqjAfdYBhXdcvW7hdANsAAAA=
X-Change-ID: 20260820-vsock-connect-reset-closing-98dd28769d7f
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Hyunwoo Kim <imv4bel@gmail.com>
X-Mailer: b4 0.15.2

Handle racy socket changes in connect(). Plus related tweaks.

---
Changes in v2:
- CC: drop bouncing addresses
- Add more related fixes
- Handle ENOBUFS (Bobby)
- Consume sk_err (Stefano)
- Link to v1: https://patch.msgid.link/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co

---
Michal Luczaj (5):
      vhost/vsock: Fix socket state constant
      vsock/virtio: Streamline socket reset on transport/PM event
      vsock: Enforce no-transport invariant for TCP_LISTEN sockets
      vsock: Do not reset a TCP_CLOSING socket
      vsock: Handle sudden TCP_CLOSE during connect

 drivers/vhost/vsock.c            |  2 +-
 net/vmw_vsock/af_vsock.c         | 32 ++++++++++++++++++--------------
 net/vmw_vsock/virtio_transport.c |  3 +++
 3 files changed, 22 insertions(+), 15 deletions(-)
---
base-commit: 0654f4dba1fbc697f2653aba30cd68587fcbf10e
change-id: 20260820-vsock-connect-reset-closing-98dd28769d7f

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

