Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A35201019
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359590; cv=none; b=IKOW+alg3d8XYv6zwPCBtVWKiRzqXFM50aAFJk7Ib45sKTLetrLYi90orQKgKvMvf0wFCH6FStr+s/IFzJE3DpQdjDjPpZpK8TuXFh7khPRdB1I1eWraA1b3QxuPM4SfjhFxFJoyEIEHntnMEAZEHJRxoqTSnHgmiMeC418xcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359590; c=relaxed/simple;
	bh=R4UWrVe5Gaa9ndThzF20AYFG7pj0l2pER0Xs1zgkco0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e+PByrAzn8XAd7G3j/ehq7r1Tmvb5XvYyP+3gRzHpujQlsj6L/PnwIRP77YIcewjQdV3vUQsPRBEirBlbgi6kIT8j/J81QsyNnKzqv/P1rbQ1f3hAD3D2OabnpPeVDnfefP1LXkr3sM8kL6q7xsFn2AjPwo8dV1DnoUy0vz1MW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgM8/uAR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgM8/uAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
	b=HgM8/uARmq8LCCg4d37RErM/uOl72OTCJWc5Ke6nD1kQT21NUKV2AleL91Txi0kT5QborY
	UDQER1XPEIhkmoX3ZVRz5yMlymhce8JP0i9oHoQJwnlq4eqwKFKTPtcS9ahxt+U/Z/6vOn
	9oWDX/qg/TZXPfMjKJgSmhfSRNuiElc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650--3M0-YBZOb6X_1FkToiJRg-1; Wed, 08 Jan 2025 13:06:23 -0500
X-MC-Unique: -3M0-YBZOb6X_1FkToiJRg-1
X-Mimecast-MFC-AGG-ID: -3M0-YBZOb6X_1FkToiJRg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so791535e9.3
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 10:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359582; x=1736964382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
        b=Ml5VlzKVx3MHgAO01W2oxfqJizUxs1Ina62JwzUeYhNKf3hyAJSrQ28Vr5/iL9GqMl
         5rAkaQ3F+5CLfkA6HZhOrL0EEgoHpXzTfA0zrA/HVg+k8LRt2MKdxI9w99BI8uoyCnO4
         ekPdJ15Jw4LsIK2sDkSE+//FLWszc7dewtOSV6to9Hc/vNOVNCrcw9sgDvAh29a4uwW1
         3XUWogaidQH8i7GDa9NJk6PJprwO4QI943dMOHS7N6GOMlVilo70H7k+Iqu+ftyJe2GU
         ZMAnXkb7OEmwNWuLbcBFLVvCvxNpISDSraZCILOKNj9PKH41rBlQNwpnE5pxgCoGJZHQ
         Jh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX343wgdFf0sM9tYG2JSpw4Ye2yzAX8VUq1gAZQF32WECJCaxn4KBqv6KZOf/puc6vff3e3MRtPVpyuW6YyJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsWsVt7kAf3YCEZQCjW+a8kbA8iBD5xLamHmFel90eQORls9cj
	d+ecaV15xpOOVmA/3fNG1QJ4T04ysSBGDeYixNfppJ6rLgpP/++G66cR5wHHKjZzHcTaZBderw+
	XqWo+YwG5HylZBabPqh0Rcgs3luLhpJuwJUPIeKv8q0T3387QjYTz2IE4bxGpqJKT
X-Gm-Gg: ASbGncvt5AfxBGuI6v/QH60iUONiI5c5GOhkXItths4rv6pppTvWDRRSL3DzvyKr8dM
	sOkN6y9kzFpe5lpoz7B3FUvb4ESb8pb4IjLC4HuY18S9NJWtpD6gAN+1yoaAj59cookLJzQYh+a
	tC4K0BMHT6nqUVcFNw3vReI1mKYpxaEAjMN0emRJv38RefCkAA9SotXyM38X8lEZeFgEZKlCkaw
	exKKrlUNrwcb8/cUCP/ZSrewRMk7CegrSOebidtyus1W+4=
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946675e9.31.1736359581544;
        Wed, 08 Jan 2025 10:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzI29sT/XCixMM7XrCBkXw/ioHXUjl2FaMJjmaMr+6Pqs+CX8MLIRg6SGkdexZ2/7lWykfQ==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946165e9.31.1736359580892;
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847d7fsm53389298f8f.60.2025.01.08.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 0/2] vsock: some fixes due to transport de-assignment
Date: Wed,  8 Jan 2025 19:06:15 +0100
Message-ID: <20250108180617.154053-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PnjfpRb-DIG_G5giWa78NHqfMw1vtpEajagEeTMxxGw_1736359582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series includes two patches discussed in the thread started by
Hyunwoo Kim a few weeks ago [1].

The first patch is a fix more appropriate to the problem reported in
that thread, the second patch on the other hand is a related fix but
of a different problem highlighted by Michal Luczaj. It's present only
in vsock_bpf and already handled in af_vsock.c

Hyunwoo Kim, Michal, if you can test and report your Tested-by that
would be great!

[1] https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/

Stefano Garzarella (2):
  vsock/virtio: discard packets if the transport changes
  vsock/bpf: return early if transport is not assigned

 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 net/vmw_vsock/vsock_bpf.c               | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.1

