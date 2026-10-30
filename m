Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342820;
	b=mXCl/Gj/OmGjBIko9jaWiqx+7SKwlkuSQQBBJgEa3iKZIUpRYvEFa/sQJu19BgqLKkGs
	 cnrT4PdR7cFi+4sztJivOP/yws+lVOKCz+EsK6Y6mdKmsVIyuFTFVt7ZZ7OhsQrQPbOnI
	 vOqW8FbA7A6j2UfRZG5mQKA8iV7QQMIox2dQSFqGM4+LovV8X+QaRy9ROKnpSP/6dDP52
	 eEw2+XQxFxvrelYnJzdE3RekKkMezM5XGp7QqKFWMKL9G6m1cMGgAtZ7jKK9OHpFWiele
	 xUT0ZCmrsgLKenj0h3ku9EbflRGzSJiZxrJx3UFg/Ew6cOhO+2Sw9aFyKLDXjs131UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342820;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ActI47yzI3V9YPR4LI6wlgEbQ+M6pe+vUeOdyRecz6E=;
	b=HlMD6+q+4UlMD995PEGVeI4OzKmn9ho1/kHnTVqWSxqVeO9LP5Shp+hT87tmvXKtR7sZ
	 yA4CRF2tMOIXKZqkrM//TjL7Wj6dkieuTVg097PqRaoCYAtHp2AEQprl8djQ3z3WovGxq
	 sd41WSo4ISiN5vPuwTcP7u/79nsNgHzKKWOnAefKn+IDoXlOkFO9cmStvoIryORMjZHRc
	 SqtfNJ3ZHSwTbvbrBD2dZGEpBaQgZ3N3vlj3SM0CXI9m0ullsyU7zOfjeSvMBbTnHTL6n
	 TZATkxBknBG27sWjgtnYvXklvOCrk9XOkZpia2aQzf6MAPziQZOBSfoyFlH982QBUaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ikuyo.dev;
	spf=pass smtp.mailfrom=ikuyo.dev;
	dkim=pass header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=V1Kj1axR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E9606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069E9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=V1Kj1axR
ARC-Seal: i=1; a=rsa-sha256; t=1793342810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RQoKKSGTMcHcKejF5YVcP10g4Uuk+K11K/7ux1Dq6QQWT5DmYgWBNTm/bslIt87f7hJvnGdyvf/dbUv6/CIy5/B42D2TpA4eYB35eyc1yllfiYx+0kf98C+aNq8/QVf4rWYUZkST2MOyV7Tynty3cPiIapgGuNydkyRI7v+E2S0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793342810; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ActI47yzI3V9YPR4LI6wlgEbQ+M6pe+vUeOdyRecz6E=; 
	b=GO4d3oNHMslYfBFUw2e4PZfl66WpNX15Mz3T0ujoVbyw5t+yWFYJHkZAPcaskpM8F1LxSSLnCduj5dSGpCJbSFGUvL1wNSt/qnGd1miEASuZQAWE0g//0DWvDAxkDBoLjUyvZ15pMDEXBrvdxngmyLrqQ8vRnxpG0W/g4P848H4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: a=rsa-sha256; b=V1Kj1axRMHat8VPGf2z/012jgrEhYhqpF8QOBNUjjHzMTt+e+BdGMDyBoXAODZr0gNFX/oNvRAsOZXZAQC2WioywrdHxZtXWd7zOuLLgxVmVPFMeWUDEs67NYMJXUfMdp1rEcIJwdj0RDJxRP0XYDWT04looSrzeptPflXyaSMumSGNzuio4xpNKcG3hNTIfvDD1goTrTgvgJa6PwFd2KT2rCvh9uQ2ntRAKssCFORNre2vff8L27pfCIMT1r9HRLODDl2xh2LQiM86O2rGYcRk0KSD0qf3gVUfpY93+RjFF8CiIZPk39qrSoj+T/A5Xim+1jfsSIKr1k5/mVNYD2w==; c=relaxed/relaxed; s=s1; d=ikuyo.dev; v=1; bh=ActI47yzI3V9YPR4LI6wlgEbQ+M6pe+vUeOdyRecz6E=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793342808745704.1039460582357;
	Thu, 29 Oct 2026 23:46:48 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiran Qiu <eritque-arcus@ikuyo.dev>
Subject: [PATCH RFC net v2 0/3] vsock/virtio: don't let sockets send from another local CID
Date: Fri, 30 Oct 2026 02:44:15 -0400
Message-ID: <20261030064418.133349-1-eritque-arcus@ikuyo.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio transports send every packet from the transport's CID, so a
socket bound to another local CID sends from another socket's address.
Patch 1 refuses connect() on such a socket; patches 2 and 3 close two
other ways a socket can send from another address or have its local
CID changed.

I'm sending this as an RFC because one problem is still open.  Over
vsock_loopback, a socket bound to (VMADDR_CID_LOCAL, P) sends from the
same address as the children of a listener on (guest CID, P) -- or, on
a host, on (VMADDR_CID_HOST, P) -- and vsock_check_source()
(dee44f41f206) accepts packets from either one as coming from the
peer.  So either one can shut down or stall the other's connections,
including those of clients that never called bind().  Making
vsock_loopback send from the bound CID would fix this and make patch 1
unnecessary for loopback.  Would you prefer that, or these patches as
they are?

Changes in v2:
- New approach.  v1 made bind() treat the same port on two local CIDs
  as a conflict, but as the Sashiko review pointed out, its alias list
  missed VMADDR_CID_HOST and did not handle guest->host transports
  without a CID.  I reproduced both gaps.  v2 leaves bind() alone.
- Patches 2 and 3 are new.
- Only the virtio transports change, vsock_loopback included.  VMCI
  picks its source context by route (a nested VMware guest reaches its
  VMs from VMADDR_CID_HOST), and hv_sock has no CIDs.
- v1: https://patch.msgid.link/20261028065231.655701-1-eritque-arcus@ikuyo.dev

I tested on net 4dca97647a3e (net/vmw_vsock is unchanged through
5838f10563d5) under QEMU/KVM with vsock_loopback built in, in four
setups: guests with vhost_vsock, with and without the virtio-vsock
device; a guest with the device but no vhost_vsock; and a host with
vhost_vsock and no virtio transport.  The table shows where each
problem reproduces as the patches are applied one at a time ("no dev"
is the guest without the device):

                       base          +1            +1+2     +1+2+3
  connect() reset      all           fixed         fixed    fixed
  credit update stall  all           all           fixed    fixed
  rebind to CID ANY    no dev, host  no dev, host  no dev   fixed

vsock_test passes at every step, and no connect() that used to succeed
is now refused.  I have not tested VMware, Hyper-V or nested setups,
nor run with KASAN, and there is no vsock_test case yet; I can add one.

The patch 1 problem was found with afb-afl, an LLM-driven audit
pipeline, and this letter was drafted with Claude.

Yiran Qiu (3):
  vsock/virtio: refuse connect() from a CID the transport does not own
  vsock/virtio: send credit updates only while connecting or connected
  vsock/virtio: only update a socket's local CID to the transport's CID

 net/vmw_vsock/virtio_transport_common.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.56.0

