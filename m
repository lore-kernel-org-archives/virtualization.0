Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523602E65D
	for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309417; cv=none; b=RAK/8fuXjbYP20YeYBbAplwsd9O3crp1hL9vmsd76hkAUjBDCLO14CJuo/XswSCxtVrEOiR4ySj5FqOcclyQzh834pSOAo6N5+dSOYRp8y3bshjeb+Q6TBLXafQsGTx2IhtE/U/QCniWAyHf2rmFO+r58AUwJuRs2Tl3rvUtMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309417; c=relaxed/simple;
	bh=2xA7UwrmgSAiT4AAGXdHKe3DLcEVpuJqqL8PXChttXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QIbzUvYnWlZiys111/wdjWvBx8kXQvUD/OW4jsfW3gtaVXBAuuL/0vdTSo0HQwF6kXjo+Q3z6YCXM8VlGYT739IrGv+N+iHqPm5oIoWJqvhmobRkF/b5wYrHj2lBNvRG7EF4C2QiulWdX6Y5yVPCb4YGjU+uz6sKJ2HD76I1bR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW1BeQfe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW1BeQfe"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2070104a91.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309415; x=1781914215; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDW2+QBWaKIKD14o7O9QPMJy941RQm/F5fPpz4Pl5f4=;
        b=hW1BeQfedPjbuHeR6rMurCSZa5LT1NtfOvQDuf5YUw7p4sQNYjyLB519+WoV6EQ8h2
         SXCyQWwxpxvJWx4Zz5t86n4wKDsmjSdjvy2eRq54heYdbwntbzDRuc3DONQRO/w3QPPX
         yJTm8VfioVlTkIDZ9ytxfwX3VD6uGxs+X01a/p21quMasOXXsqi6nqXHM0pdCbPzzrFF
         0/5WR/3A7Qn7hdf2zYZ+diYxF6wweNvSUcR11X00cb4YNeD4qEj9V+5urkD9Vgo3hOgD
         dramez5NKkjB6N9vWiW41GQgmuS2vNVzjEUtlZe2H6q/F5zanWOr41lbOcdXKtqGhf/g
         r3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309415; x=1781914215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDW2+QBWaKIKD14o7O9QPMJy941RQm/F5fPpz4Pl5f4=;
        b=ay0Q9Da3H50ciA+9ZzRerU9GXSuWT2njfT+8TD5goUSHE9wBrNfuiVMc4scllkDkWE
         nYzRL1F3YtctGJ+g6rC+rI4w0W2ikDl5+ozZ6L/0aCNywvtIaGH5krmsPpMy42KG6ch1
         hWCv9kUo5c6kA2UeHkxeLaKd87ZcdKQcUaDBlRO3l3M6BH579Vm66nOC3kzTy6kSNr9j
         CJ1y8BnK3LbElQ6ojAR+K1LDVPvcAUX0dFUJe2vyvF4e1atbsNp7lhCEmk1FPnyR4Tua
         9EqGtmpvZEt/YKiQ1Cp0Tb0J1Qp7E4nNknSdtV//ajOGXkrHhhPTWWuy+Kx11lxWI4bD
         wALA==
X-Forwarded-Encrypted: i=1; AFNElJ+MFXwwLCUDi6rp4bQWjZ0NLYSZbMWYILD0YSo3Ql7p9Fn/oZB21Qw5PkEzg72sf+3h48PM1l9/am4N1TP8iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5lWum5/obLwNEPAajsCUnWxyohFwQZ3rkGdDXhQ+B5l3D5zAS
	3H02MmPViqjiL6UR/HGry0FYCQEu1Zr3LjpO/3Tyx6KoZ2m6eVhnxUwL2uhHrDWs3uwbaK9WD7z
	sPw==
X-Received: from pjbco19.prod.google.com ([2002:a17:90a:fe93:b0:36b:7407:9b73])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580c:b0:35b:8d89:719b
 with SMTP id 98e67ed59e1d1-37c2bc6f158mr1545724a91.1.1781309414535; Fri, 12
 Jun 2026 17:10:14 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:51 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-1-tavip@google.com>
Subject: [PATCH net v2 0/2] vsock/virtio: fix msg_iter desync on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a msg_iter desync issue in the virtio vsock transport
that can lead to warnings and eventual -ENOMEM under specific failure
scenarios (e.g. partial GUP failure during MSG_ZEROCOPY transmission).

To fix this, we need to restore the msg_iter state on transmission failure.
However, since virtio vsock transport can be built as a module, we first
need to export iov_iter_restore.

Patch 1 exports iov_iter_restore.
Patch 2 implements the msg_iter restoration in virtio vsock.

Changes in v2:
- Use iov_iter_savestate()/iov_iter_restore() (Stefano)
- Use a single restore point (Stefano)
- Reverse xmas tree (Stefano)
- Added comments in the code (Stefano)

v1: https://lore.kernel.org/all/20260609004809.1285028-1-tavip@google.com/

Octavian Purdila (2):
  iov_iter: export iov_iter_restore
  vsock/virtio: restore msg_iter on transmission failure

 lib/iov_iter.c                          |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.54.0.1136.gdb2ca164c4-goog

