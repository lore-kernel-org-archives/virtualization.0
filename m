Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D173F786E
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481711; cv=none; b=CuZB+R1cx6noKFMTWtsnCaQSgzAU9Ss/ABmfcM68Yp7bR0PQjXp50GmETXar3DC5QHzirSYQ+LI+M8W3u80WWd13Ar2bvKR36PrsGhSFiWCvVbupbzjD2a8U8X4+cqHS+vkEprNYdA7Lm36ymgVUMLKiIPjdia9PY+vkorT9TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481711; c=relaxed/simple;
	bh=Z0WPHV8/Mv0LIJVrKuAdJ28C6sgGsMyxIyrReBvVNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Be7ptHyI3zfFkkhdifmKqC7E/7wnE370jXUfVo3kkaxM3o/MavMVlRHzBZgDI61k/Rcae/LHT7yui/AFYM14NkkMEjgUWE1ejcl9CA/nbYDHZYjfKAtpnAsZHkrg3LSjsdRxPI0TQJH6YV7llN0+fvr7ee82XxiIs9NRkfKKoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4VNKbAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4VNKbAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
	b=D4VNKbANx1H0LEOp9M7xz55Ip10pnwh9dmkiH3GEJt5Z9Jq4hKEVCrTUA5xgthuvrcVfiA
	+IlYG9Ue8B0TpO/bWg+wYIppaPaARvEv3+UFt/Ikfa93eLmYI1xLZzrA/ubImRynSnySP6
	xBXxK1fJ+2EPc9jtA0Suc2tZcRvqtbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-aMv2M4z4OYCdDpsDV98gdQ-1; Fri, 26 Jun 2026 09:48:27 -0400
X-MC-Unique: aMv2M4z4OYCdDpsDV98gdQ-1
X-Mimecast-MFC-AGG-ID: aMv2M4z4OYCdDpsDV98gdQ_1782481706
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45f3d008865so710785f8f.0
        for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 06:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481706; x=1783086506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZNpqQhDRtZVJSfSiG/V88dl8frC1MRUvBsYP5nVWQY=;
        b=Jp02BcDYUoaFzG/x6mefgqJdw7YLRicGUDATxx1py9VJ60cKmvrNSl4A+kwnLHh6+m
         rEMnEqBBmk0RR5AaSkG4PEVuOKNXy666UXEOEcdt/pP1xPp1CaILf2O3Q0li5MFBAGFl
         auTzNgNRrgXLIqmJzPiMWJvIZc4UdNY+oKyttGhEP6/EhDBaXTYojjsBzEBQLh8n7daC
         Zst57Uv8bYIPGQkgCwn4SzSuL/LE3lHLxyxXwduW7xbELqCzGyahJwOX+UXCuqXIANnI
         RcP9xjTbD7pZbw6Y8WBBejdS+tQPJc+7ynrUL2yqvGgT5a7jLi3QO5p1FLRe4Lr+6Xu5
         C/PA==
X-Forwarded-Encrypted: i=1; AHgh+RpGLyswGAP6Z0W6RQYwuzD6CTTL4Nax9jaozQztf9fOD1eaAweHIUjqbPaq4G83FO86hj87BYLI2zCgyrbZ7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiZA8pRvydj6nNaDkYoixGkqN37dKhya3bHGfMOhbdQZ6PS1B0
	mBZYJhwOA79pIKcjLb79lpiKv+huODdGxqWg8Gn8dYJVHq/VL41agK+1rVBSb2kIlIOQvjLc9c4
	0qqvZPEDpCmOOhQMGBJpLGM/kPW+SFW1vUSav7J3Yg9x5RJ6DRzt5G6CyV1cujSN+fxkp
X-Gm-Gg: AfdE7cl/dGxQ/t/RkqZuaXwU20pCRmtpU8Cv/uYt3xWTFXStbMmJ0Gb9oWcK/e6vmqw
	T4Q3jLL5PcriDQDu0GUYPQ2fcbX4tMrEOPUnKMV2lJQiau6/PmYKmGZOTsDmQLoLTE+JS20fVk6
	q0zdlJY03HAkpVEDumoVtkG3WmsHN4OKoDyFk//PSuGmljhCXODgFLmOIwnubw0LVIq01rfAtjy
	YASZYUCK6w4R8wuqgeqe1WD4SMDaJG4cXLRCPYvS0h6yxVF0JTWHOv1YKMsLsZWA85nEfAw5Nm4
	zGLI3eE+r4h+Z8hZjpXZiyYdUEptqq3rORMinIMjb9ZVfu7VXGxBrpyis1lLlPCHc4i9SuervR+
	6Owyl0XkPrBMyO5YSxAHgLJCEBiCNT2yyh6gAxw8cK+GEeCI=
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779371f8f.12.1782481706438;
        Fri, 26 Jun 2026 06:48:26 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46a7efb7522mr18779337f8f.12.1782481705917;
        Fri, 26 Jun 2026 06:48:25 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm22722884f8f.8.2026.06.26.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Fri, 26 Jun 2026 15:48:21 +0200
Message-ID: <20260626134823.206676-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3b0fNc7HKXn2V5HN3D7pqI9W7Zl_PqwQbcWwyxRgP4o_1782481706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series contains a patch (the first one) that is part of work I'm
doing to improve the tracking of memory used by AF_VSOCK sockets.
The second patch is a test for our suite that highlights the issue.

Since Brien reported an issue with his environment (based on Linux 6.12.y)
related to the work I’m doing, I extracted this patch and tried to make it
as easy as possible to backport. Brien tested it by backporting it to
6.12.y, which now contains the backport of the 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

This patch primarily fixes STREAM sockets, but also partially fixes
SEQPACKET (with the exception of EOMs, which are kept in separate skbs to
avoid overcomplicating the code).

The rest of the work, I feel, is more net-next material and still needs
some work to be completed.

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 148 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 ++++++++++++++
 2 files changed, 233 insertions(+), 2 deletions(-)

-- 
2.54.0

