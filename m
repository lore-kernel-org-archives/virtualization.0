Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D0379C4C
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167298; cv=none; b=IouujktBXzZMIib0UBVT/wDps9eNAXU/4d9yTZwLo82PfqHJi4ctpvPNdUSN/yzyc9zhNF7NtBlYAljXa91UCte3omRNiwXHPJ3PiVwvO80FGCzE/UJR72O4IpaOM3KgEWvsBgnmzcij8kWBPABbKQKsnZWUA14rb2kX4E3plQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167298; c=relaxed/simple;
	bh=SihlRBBTVD9/sumreJgofJm7EYPORk4CoiN8TCjcnAY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MFpRnD8fLcKoP+bGv8+5bgdSyd6S3DmdAbA8XqmCJXCrLPfW5unWmv+nAqiuJ+Dx87DKNK01AF5WuWGT4V2qOUjU4DcIcvMRlVUf3CuwBoRmn+CLONaUX/AYJaGeLDwoeQuP+vItZmT/3oS3Iz+M+K8s3WGKbV7D90bCxDOXj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKwb/NKd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKwb/NKd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88d7a75507so6477788a12.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167297; x=1782772097; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=iKwb/NKdtd6nd12KUN8yZLMJ+8Cl32tSyJBftMu4ERttqhueRSUplsXo6e7SWJJAeb
         vAQxQw4xZUDJsQBeaaRJJz6sjVwD8syvjrExhOCL2EPMZJ1/NVL3L9SMaSOQAiO8GJe1
         dOr7Q53JrieaY/7jtFWRQBKq+Lf30eKg6hUv22ObcpB7GG2SV9LjIwF43XPgbONzCAAh
         BeZb1P2pXpA1mFp1JqQwHSer77Exm1FkiHNbq3vEKFwxGgcH2Ifa4ia/HFNxQS9/2SSp
         xW+jEs3C4M+acz0ORCOUi76yKke8zSiPwtNOIXYKAI8AkmiTplL2WH75zVwlMZJcLOjp
         pguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167297; x=1782772097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVIN0Q4+496+/EZ2BPsuqq3VkPJBQAckK67gmjBeUzE=;
        b=Z1qhMtyMkalXHxtD/8ArHrC1l0ri8cVyZfYhPC8nXt42aaLFV8wPp2yday4fmgMq61
         TTwdPgjrSTM1da7lZBzzqEHteU0rMgYt3o/SSujoCmplNDwzEVqhBbk0BlY1VeRrUu5H
         cgrB3vzNbaLkgvT4UiKnrvPXu9lm83RS8zOqroTyxaE5juem2MvQHz55TjDcpXpl5v2x
         sUJcx+NDtNdCE9mj4/2t+jubyMmdvBBz3dZnJR1vUqKV/2m9nV9Sq962Rxk7MCWrMHg+
         MDPaoyBYhMVAJrt9GOaECMHoUGBz+ARJQVMCmgnV2FrgdyrgPXhf9LsJ7/L6Utyc1PJ2
         4O0A==
X-Forwarded-Encrypted: i=1; AFNElJ8qQ+/xfjW6TLTDwASrLbyrwWBwTz23SiK/HiqnFlrjdXEoGJEFkLQ4yB/KCvLWecF1Vxhz0Qa36a+xxHW+tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX5OIuCdd1IuO5k59IVXrRJYGq3roKC+nGX5vrbjB/tWJLyJQv
	+kKHOncMt6LXHfpRL0/aiL2HFDlpRE5WgLaxT6paigDpewzH7i9ZaT80hGF0GorDumBNOZX1z+a
	klg==
X-Received: from pfmb6.prod.google.com ([2002:a05:6a00:1146:b0:842:8ec2:ef16])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4004:b0:845:4c76:e46a
 with SMTP id d2e1a72fcca58-845952108a1mr266932b3a.3.1782167296263; Mon, 22
 Jun 2026 15:28:16 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:55 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-1-tavip@google.com>
Subject: [PATCH net v3 0/2] vsock/virtio: fix msg_iter desync on transmission failure
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
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a msg_iter desync issue in the virtio vsock transport
that can lead to warnings and eventual -ENOMEM under specific failure
scenarios (e.g. partial GUP failure during MSG_ZEROCOPY transmission).

To fix this, we need to restore the msg_iter state on transmission failure.
However, since virtio vsock transport can be built as a module, we first
need to export iov_iter_restore.

Patch 1 exports iov_iter_restore.
Patch 2 implements the msg_iter restoration in virtio vsock.

Changes in v3:
- Use EXPORT_SYMBOL_GPL (Jens)

Changes in v2:
- Use iov_iter_savestate()/iov_iter_restore() (Stefano)
- Use a single restore point (Stefano)
- Reverse xmas tree (Stefano)
- Added comments in the code (Stefano)

v2: https://lore.kernel.org/all/20260613000953.467473-1-tavip@google.com/
v1: https://lore.kernel.org/all/20260609004809.1285028-1-tavip@google.com/

Octavian Purdila (2):
  iov_iter: export iov_iter_restore
  vsock/virtio: restore msg_iter on transmission failure

 lib/iov_iter.c                          |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

