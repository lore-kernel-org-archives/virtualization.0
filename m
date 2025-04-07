Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F22222D4;
	Mon,  7 Apr 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052619; cv=none; b=RLkUs47DiCnc9caJCcxajxYAtymQsakRM+q6TVicWfeieB3ned0EvpU32f4wbh/Z67XVITdfYW5ADrrT/KxjdsLFH/Dp6k89G3Bxb2YdKlkYpBRKLmD0F80Y/gCrzb3x3MFINJlswBo1icHyzNxltp9iqwZhLigsQo3VzHwqf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052619; c=relaxed/simple;
	bh=9jUK5fFO/zBSCtoslWjYR97SvHCJCuRCU0KIKS3G5a0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V28jqYTh9LDQqWaM3qd/qc5jA2ppL4BJE7ryYwOrGz3af4lBw1a3OABh17YfoQbYBsP3u47XW+p48WSawBmAYFuYjUKeM1NYXcFyPbVg2l6a9U0L47FY5euYK2bhjNxbj4RZbzgojT6aLgNcPG+bUfXIVvTgvDTs24VBfvziWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=O+8BqO7M; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="O+8BqO7M"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u1rQC-00CpZg-VG; Mon, 07 Apr 2025 20:42:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=B46oeqhR6OuooSI1uvUNydwdBFfTPFTrPvRqV6TVJlY=
	; b=O+8BqO7M0VZFCHknGdVU2zQ/2dkc5OFRM/4XZMGQfM+V1PvaK+faD9P2Gr1VKilTIllvKeQaD
	1awEBt/PiRh/mP0j2XNS5gEz3RH21Hh2wum0GvVuCu3vIUZ6ngYH0z0wa4IaFAs5+RMEFWz312qTy
	4RDI6XvcaiU/O01W52l0DXvK5Pt6PBXm6KZbK01Gkf6cRl2U1yBDATGjWcFgHk/c9/XaOln9HPSBo
	vUVoqG2RilDPKLsOpnnzQjFaOhuSlhQljB7G9FaASog2qeMoEC/IIgmiMGobf14NeUZ43K0HRaM1E
	Rz0SxZ0oNeRG5pXQvMxW4ZdKG+leqDl2OLtCAQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u1rQC-0001M7-HP; Mon, 07 Apr 2025 20:42:12 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u1rPz-008fhd-5o; Mon, 07 Apr 2025 20:41:59 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next 0/2] vsock: SOCK_LINGER rework
Date: Mon, 07 Apr 2025 20:41:42 +0200
Message-Id: <20250407-vsock-linger-v1-0-1458038e3492@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYc9GcC/x2MQQqAIBAAvxJ7bsEsJftKdAhbayksVEKI/p50H
 IaZByIFpghD9UCgmyOfvkBTV2C32a+EvBQGKaQSrejwjqfd8eCiAhohNSlnTK8tlOQK5Dj/uxE
 8JfSUE0zv+wFVJPPHaAAAAA==
X-Change-ID: 20250304-vsock-linger-9026e5f9986c
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Change vsock's lingerning to wait, on close() and shutdown(), until all
data is sent, i.e. until workers picked all the packets for processing.

Changes in v1:
- Do not assume `unsent_bytes()` is implemented by all transports [Stefano]
- Link to v0: https://lore.kernel.org/netdev/df2d51fd-03e7-477f-8aea-938446f47864@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      vsock: Linger on unsent data
      vsock/test: Expand linger test to ensure close() does not misbehave

 include/net/af_vsock.h                  |  1 +
 net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c | 25 +++----------------------
 tools/testing/vsock/vsock_test.c        | 30 +++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 25 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250304-vsock-linger-9026e5f9986c

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>

