Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629247B432
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988197; cv=none; b=mwZGBhPfQ3e7bQecuHon+UDLKT5M8idfU7LjBYd2JwaxUWgmLyp4nkeQx5jqbVPSqv1YCajTkwbD1AarHENgtUxZpWLF5OArJWGUmd7ytAdPYMGNO5KwNLAIPYiAYdIF3GcaPk0WL1fRz62cNduO6Ix+q5XFMapatvAe3l/OwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988197; c=relaxed/simple;
	bh=fGsZTd5bffSkjK7pmvupzLZGleZjRWTTlZMrE5HbivA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brS/DBvmmSLftHK7wLRjgf5NYJF+TtF9ZvvhH+702TiXVBL7qKMpCJEVrEsAOwPnEbfxHNuWhovP/eHdifp6iD5xcL+hZ58zIifVdyQF0ANo3Lau3HiEc7ivbtF8Y1BrX5hlStf6BXljodvl58VQgefqnBapmcJ7zKRMv1CaBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOSVseZ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOSVseZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R+pe6lmC40Ggeh//WpcWFgKiyf26tVP3wEil7HyM01I=;
	b=cOSVseZ3cTj9KXgJ9mQE5B8JNIGUxzGmXBiJXUw8KYly15DDxVgaFnvMc1geXrJZY7v7tR
	RSDh5j6pPW0OmalkedKPXoqqJu6pRr4teL2/82jAfVpxmK3ig3H4RY/eWnR+AP/AjfvUAI
	vVbG0ykpKg/W6p+kGsCXtPKgdEUspus=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ZWKh3ZDfOtWHZ2APNK6AFw-1; Wed, 21 Jan 2026 04:36:33 -0500
X-MC-Unique: ZWKh3ZDfOtWHZ2APNK6AFw-1
X-Mimecast-MFC-AGG-ID: ZWKh3ZDfOtWHZ2APNK6AFw_1768988192
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435a0fb0c9cso216565f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 01:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988192; x=1769592992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+pe6lmC40Ggeh//WpcWFgKiyf26tVP3wEil7HyM01I=;
        b=eCF1jHZnkAnWXzB8d5MleIhAjq4wMX1myAySWzi+401Bo1/sqjafVmqmlMqSn0zYlN
         kmu2slzO43SxRqbJUYOqFI+8/6WwBdM7NQvlqIaohGIGZZDwyQhtiEsPat+qzpWPGfka
         TpoeUQ76fBlKT1qtp9BUBeJCch+F7Ii0cv6hE3Jp/MCjE2vkGOXBr29J+phPG331Rmh6
         85PoYgrs7TY9krGkpfdEo9oYgcJpEEvaEMnrM/MtpkxbNEnojCkuLNUV8ZAbNKhvYRtD
         0xfE01xFfnQp96ZpSudj8EEVRUHM3rUACJDayVDpT+GCcCqrgZbFQ4C65CWQ/hCakiqy
         3klQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNCTbQUwZdr7i1XUdj29wfgpnqmKHPFK5ewwaOny0xN+su4MVNqsfERIOQUklrOKNbwPPg0+PKZl/VH4OY2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxORvd1OiiF3K9/URIsYIi/DLvJVHvW/1hUTncN35xnUAEN3N+G
	A+zevoNB51Ij1ZrP50n/WBgUdh438OI0Zv99MeSpV5svuyyY5VUQ5qcu1M/kp1cVjiya2Uy+8wl
	H5VUxuTiUkIV5MPQg+6Nc0asv5rbijZfFaV42JPeTenKnPnNwacd+corMqn1l9HjjH/uW
X-Gm-Gg: AZuq6aLM0sTcFV4Vv7I6mxZFq5thUYilLV2jR1y6yIW/mgHLd2yFQQAsMzYiZ91X0AG
	1U/Kou7RELYFkF+KxFg20L/sxxCgrbaK9A9vjG1lBgiS4lmiWNOSiauZa4evL/QrQTZdPlqZnBy
	wr6OtHopRQyLul6weflyTM9bPua0t4cxNT3NueAZ2QmqyQ2uocoq1AfqvErugqsuLYTevCpvNcB
	dl3RsJ3yISpa9ubJG6e/k4fzCDiIxhdtZMHJgNLWHPbelHPpGA6aVcWtNNpK08iE9/0cmWLsqTy
	pOK45ZI/SpJXHBr8IoRNLPkO6EMzFGkw6X6KDy+uoumWPSPY52pkwGIyTL/FnoIJY1fZRvhMp1T
	hpFesnu5GdinI9VLYj6yxpAE0++mtG6p9qX5dyuiekhEA1jcSqcqA71XfEOq3
X-Received: by 2002:a05:6000:186f:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-4358ff6fb27mr7238589f8f.60.1768988192255;
        Wed, 21 Jan 2026 01:36:32 -0800 (PST)
X-Received: by 2002:a05:6000:186f:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-4358ff6fb27mr7238536f8f.60.1768988191774;
        Wed, 21 Jan 2026 01:36:31 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921facsm33887841f8f.5.2026.01.21.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:30 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Subject: [PATCH net v6 0/4] vsock/virtio: fix TX credit handling
Date: Wed, 21 Jan 2026 10:36:24 +0100
Message-ID: <20260121093628.9941-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ucMClemGaCUP41l7K39Q-wcaStUSdmLjZIAjLv57xlM_1768988192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till v4.
Since it's a real issue and the original author seems busy, I'm sending
the new version fixing my comments but keeping the authorship (and restoring
mine on patch 2 as reported on v4).

v6:
- Rebased on net tree since there was a conflict on patch 4 with another
  test added.
- No code changes.

v5: https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/
v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/

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

