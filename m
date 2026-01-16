Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96B3A35B0
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594527; cv=none; b=D0yCcSx4JvxbLiRh4ujrc3vDxkMhIEjuMgm5uPKnv9FQYqLX4busZx/uqCQjPreF7E+R63/TdcOQG6zMaSladNeO1fTQkeCR2pF5hUsUs2t6pH1eo7eWJfanv1hphxEfrJ1VhBCTjqBKVFI4mkPIwWJEs/fnXwyD7dP76VDzz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594527; c=relaxed/simple;
	bh=ViVCTMWsZOBUvDZkBJy4R4gHYmuB/wp4Twq+n+RK/10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/HRV8YCICDmT8k+2u0bFCErdw+ZXczEzgQ/5Zr+vCW6xDSvg2hTZ5GirZ47adThmMEqWlkJAR/0Db9JEY0pSIRNjJL9jp/yO9a8xL5/xkf+BzEQlrZP4qrnn7PBGMq9J1Jw3Bzun0H2/WCvmASrtj27M8i6fHtU7P/bhwTZWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix3S2dJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix3S2dJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aokF+MKwgeAstmCjHO7lVmWSXdkq7v/KNJPU3598T+g=;
	b=ix3S2dJPuoSzqC43iy4IZFJTmFiaeqlGdul6CVgnT5Ac9Ggq6WeIGfcevV4W32IB7QvKVt
	O7olm70x4A+Nf/ZZj2hIPv0JNJXlV8JmJ8u+ng5v6J428CZirkj2LqUdp9A6xAs4dznF5p
	94GkQ755fhNavN/bwp8YECXJB7JbHbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-WBBc7eWGMH2AgnRDYmFrMw-1; Fri, 16 Jan 2026 15:15:21 -0500
X-MC-Unique: WBBc7eWGMH2AgnRDYmFrMw-1
X-Mimecast-MFC-AGG-ID: WBBc7eWGMH2AgnRDYmFrMw_1768594521
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee8808ffbso22825855e9.2
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594520; x=1769199320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aokF+MKwgeAstmCjHO7lVmWSXdkq7v/KNJPU3598T+g=;
        b=SQTan9dXqHZhsCQgxdwcd29tI9bjYRfvL8jq8nHtFaguD022PsbEnFtw6bUU3eUYZ2
         JPOSHqlOj2+7kCYKLH6zHg9oC+LeAYNByu/HSR8foWpIs0ta3Wv+qyTllsCZsaO1MubQ
         qeQrz2qJjwiNslfJeaaKy8ko2UIJhqjNP+gbJOEEONvrosX5Af5BGIFvLljn+VOM1oXd
         ROYlpdgZTLp64kksssZfAYUdccwCXxoZ4wgQzZ+ASCjWfcDwUSxFaulDcc4EiPxJ986a
         Lxgt/btQPuj7KMVtAmbNAbA84KGxeM3gkgkb8xKqdO0bncFMMs4s0wqc61Dav4OB1Io3
         qhkQ==
X-Gm-Message-State: AOJu0YwQqbxKnOY7X3r5lA5cfqbvUyCMwwjp+CBzkzyd2hr4FzaxC/Cb
	x7/TGipxpFKagRLCn1xGBtSjnN7SaBuBguheyOqm1psdgBmzYXX78q0DIkF067bzh3csFgKsd5m
	eXUq9IN5LQvfPM25Iw2fRrSRbCHtH31wdf5BcAkWW670IfhtzJmNP7zxwestsdhPWIuf5
X-Gm-Gg: AY/fxX4yVos6gtWjrVj1TKyydN3cJGpTsJIctvH4sEGMV5yGMmU3DMTKpBN3P33EZIi
	/KTCUhvFb+Hh946XymNYMushMsz94+AjXywES0mIN7RJv9EFF8QxAqKa+wNnRS2VZY7MFEDL8th
	JqTAZ8AA8qWthrF0S4rHkWamXENNgZhBt2S2shZYXH0lIj+CCjRhdvx3bnJR0DiTfaL4tNikGIX
	uVc7ROV9So05ChApmnM0WSgZUgxN+IoJ2XzLUc/tsuo2qWpmgnp7tSPXDkGNqGY18ntYb3Yl8UO
	hy9AUUHkshOUm6StDXLWiFnT9SdRui6S+tZNWgXxwbgzcY61Kk26o+w5ZBv217ezm6cyE6X+PGa
	f4VnuT1Xx68pz7ka5k1QD6fs8HkObcIwsPIW7R3o6KpdIHL0p+Zuw0Zun0p/a
X-Received: by 2002:a05:600c:3494:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4801e33a85bmr58520525e9.22.1768594520520;
        Fri, 16 Jan 2026 12:15:20 -0800 (PST)
X-Received: by 2002:a05:600c:3494:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4801e33a85bmr58520355e9.22.1768594520094;
        Fri, 16 Jan 2026 12:15:20 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271easm7009669f8f.14.2026.01.16.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:19 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Date: Fri, 16 Jan 2026 21:15:13 +0100
Message-ID: <20260116201517.273302-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -qIlRDIumhSjL08mXafn2Mm7bM7dKVsWymr5jgL4sn8_1768594521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Resend with the right cc (sorry, a mistake on my env)

The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till
v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/

Since it's a real issue and the original author seems busy, I'm sending
the v5 fixing my comments but keeping the authorship (and restoring mine
on patch 2 as reported on v4).

From Melbin K Mathew <mlbnkm1@gmail.com>:

This series fixes TX credit handling in virtio-vsock:

Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
Patch 2: Fix vsock_test seqpacket bounds test
Patch 3: Cap TX credit to local buffer size (security hardening)
Patch 4: Add stream TX credit bounds regression test

The core issue is that a malicious guest can advertise a huge buffer
size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
excessive sk_buff memory when sending data to that guest.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this series applied, the same PoC shows only ~35 MiB increase in
Slab/SUnreclaim, no host OOM, and the guest remains responsive.

Melbin K Mathew (3):
  vsock/virtio: fix potential underflow in virtio_transport_get_credit()
  vsock/virtio: cap TX credit to local buffer size
  vsock/test: add stream TX credit bounds test

Stefano Garzarella (1):
  vsock/test: fix seqpacket message bounds test

 net/vmw_vsock/virtio_transport_common.c |  30 +++++--
 tools/testing/vsock/vsock_test.c        | 112 ++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.52.0

