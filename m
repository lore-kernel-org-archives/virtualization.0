Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE14221C18E;
	Fri, 20 Jun 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449186; cv=none; b=IKNHOBJTnBTdWeoNf+5MgDsP26rEQ8GQyBDPVK7CBdQvQ1UauMprZ/gwO+TxknwyA9j7UOBQy1GL8HKh+K8y2Mnmg1kxapmsFK+H7pNAQEKEh0Ls+BF7DVdWS3t6g1XzIzW7ZM4nQX0TCTWgvGUVPNjnaYejOVNa2ZCtVt5DYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449186; c=relaxed/simple;
	bh=RZPG8aYaBqs1faQr1RUPCTWlDi76g/eEloLcvDb8mGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lBr+razGcrvLLLE5LdZAful57gDkZNX8oLTdQjsiZ7hHHvDlKNXAQ2sR95cY08noqU1M3Dh0AIBOT+d3LyvOwN2iTWHkcpMCKceaAO1BwZ/qfUYvphTczr26Dh3uwqYPE8tGXg2CGYnvSkkRSlEIN86qxZAlvGsha2Nqbq0iA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cgs1rdNV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cgs1rdNV"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uShnH-000fAt-F5; Fri, 20 Jun 2025 21:52:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=wxqRabh9V1+p1qzCeWFOl/62tp6glwab9xHgMB7DtNk=
	; b=cgs1rdNVtSLyFrffAM6DMWr6/M7TYAZPdNxmEnFen/Ij0HTyu0fYgkLB7ZyxqrltUaPYszNWr
	RTomPaksC+oC67Ze8BUsXgHqhsy8NtK4OXKpqBoPBRZ6/KkSkgKiPl5wzm1AHtHVM5fLmcE00kbOl
	6hVTjyMC6GULLTp1bdGf+iAJFAyRrfd2wNTTIit0miEUH3VKC7O/MWK5GrEQ1xGf+Bp/3ssKzy7j9
	FUqLab2JYQOadqvBIIQD5026G+mAb4ZdjxHtOZ7zg03Zcy+3rCZmZfxAE8pOnofjMASKQ8NDOUHo9
	/K/cHX27Hx7x8rBiMGzKF6YH7pTth/9AsupxvA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uShnH-0003hK-41; Fri, 20 Jun 2025 21:52:59 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uShnC-00CRMQ-9k; Fri, 20 Jun 2025 21:52:54 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH RFC net v2 0/3] vsock: Fix transport_{h2g,g2h,dgram,local}
 TOCTOU issues
Date: Fri, 20 Jun 2025 21:52:42 +0200
Message-Id: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq8VWgC/3WOwQrCMAyGX2XkbKWLVjdPguADeJUdtja6IjSjr
 WUy9u7W3j39fCH58i8QyFsKcKoW8JRssOwy4KYCPfbuScKazIASlVS4Eymwfonoexcm9jGIyDr
 yW+yHozKtxr6RCvL15Olh52K+w+16+c0cRehyjjZE9p/yNNVlo/gPdfPXn2ohhTFokAy1ucrZD
 zxvNUO3rusX8853PcgAAAA=
X-Change-ID: 20250523-vsock-transports-toctou-4b75d9c2a805
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

transport_{h2g,g2h,dgram,local} may become NULL on vsock_core_unregister().
Make sure a poorly timed `rmmod transport` won't lead to a NULL/stale
pointer dereference.

Note that these oopses are pretty unlikely to happen in the wild. Splats
were collected after sprinkling kernel with mdelay()s.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Introduce a helper function to get local CIDs safely [Stefano]
- Rename goto label to indicate an error path, explain why releasing
  vsock_register_mutex after try_module_get() is safe [Stefano]
- Link to v1: https://lore.kernel.org/r/20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co

---
Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

 net/vmw_vsock/af_vsock.c | 53 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)
---
base-commit: e0fca6f2cebff539e9317a15a37dcf432e3b851a
change-id: 20250523-vsock-transports-toctou-4b75d9c2a805

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>

