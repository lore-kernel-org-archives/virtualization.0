Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C031B82E
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535317; cv=none; b=ZnzmqCqPdS2oDzj+E9rgS+l+aAiaSWzOIWZtCeTaDhrW+GosoKtSTBiwjaH6XCI4uVE/5grk2DFiGSQ87Pahj1iubMMmvd0qjC5Y2wacXv/hpsdc3mwlO+/2IGKt+IYBXtEvdBxWHUJehTVlpufIgyqDdt8XIEXVNJXE3QugHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535317; c=relaxed/simple;
	bh=k1goUGFLRnYWiOHlY1f8YG693FK+4R3wtZttzUxNEyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnC3HmrJeYoCoeslnMzLAQlICPvol+BxQsyZHEBW5Wn/B5I0AY+JWPT+N8Eu0i0oZKPXH65X8MO6Dzts0UdpmfJO+y1w/zleLNCS6xR5fQfOKuFhMhAprdykNi/BU1EMtrKOXG6XE+gNSjZH6gP3ulGqEowvxcNdaKUfmPltuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zao0mkQQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zao0mkQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763535314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AmF8UtmERypN0SmhorEC/T0EDvndPupXo98es8iiJ+s=;
	b=Zao0mkQQfAWTOJ538x3nsI5eMsaKHENJBWWuDaPxhVcoDyTFmSuERVMCFanAIv2Zp2Ex3H
	/FyVLvsKT3WlevvrO1V4r8naz1fhC8hhvkHpifNxRDrALyyWAzLwt1f5H10NS7Qc7j1zHI
	HH+Bx8ZnDI4TGNGgOEtr6uZTWF9iKaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-yUmmzoEsOo2RAMZrKMKvpQ-1; Wed, 19 Nov 2025 01:55:13 -0500
X-MC-Unique: yUmmzoEsOo2RAMZrKMKvpQ-1
X-Mimecast-MFC-AGG-ID: yUmmzoEsOo2RAMZrKMKvpQ_1763535312
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso4261168f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535312; x=1764140112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmF8UtmERypN0SmhorEC/T0EDvndPupXo98es8iiJ+s=;
        b=SnncYNjlKAynoV0YpGl/I20DP2/LYON+aLP2+KBpLszRJ5UUTnpon37bDIUmsTQNBk
         E/3CYhHjgShLamlaQH87Khzj77O5ArsplR2k+JJUX8ir0gcGdeuryGv3eoS5KAxtIFPW
         FF/Wmz78lKVuIZWg5nVVYF5MnD8zlsmG4GEo8bxB9/bBfDpaHGgMMVNs9UpJlNM3zO88
         vIZ2WBENR8TZieBJ8hkSp6EKKzo2eJuv/CCrhU+/02OJkvseMVTacydkKivEgoM4sUVt
         eV2lqr/2HStZGaWESKtiRv14831m64lb18a0a8eey/dq0DnzLSRdJvQRTGeVrfLj90Jx
         BvVw==
X-Forwarded-Encrypted: i=1; AJvYcCVbBwknfk/EsSZvy9F7oI1uim1rYH0/L4Q5o/pte2h6+enBghzLc+8Z/24U2CC0kUSstIVMR76P2+0iyhJ6YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrOzHRPTkGrJpMLRK6510Sdoe3xAukyanYSuBeyi6IjhwhP8Am
	uR2xoZInWiwe0ZvJ05GxAX96vQuDZ3vKGEF2+Y2zU7la/j9M+s4+rQHEkWYFPju4M3adJsSEsmk
	AQQQVqHab9+hCvXwfsnopqmkVJC+09m8Roz85smBei58jX0TX+wZTu/RXVKGAwOXxUE3y
X-Gm-Gg: ASbGncv/oGGN2UzRrV0apnvY//FzeYuoTnpQhpI02fpAVq/nrvBfJ0JPAu4xdsxB1Zw
	3Ld2bU+OA+QeT8w513g4ARWN04yU4RYP5pWpROiQBd7uww9BV5s73AKpESNb1v4Et/NiZ1PlKTH
	jsxwkS4ntOk1y8B22NF/NviUnhruAE2/3eHHvtzuCtVZA/BL8qcRNaHhHGcQJNBaIsxuOQIda8g
	qohvtOd/dNsiSZxvyB6imidss3s9Vndnnw4W6j7u+AlWT3724VnTU0y7RHUtR3jlyGGVXFgS95I
	vkrxw1evMLOcQ6JOJgy2wJ0FGCdmc5G/8S6XsyzmvVo2xamctLQ2UF3CRWNmD88NsqGnadwO7X8
	v9Ae/X8HQCRb834jceN72oCrXS7M99Q==
X-Received: by 2002:a5d:64e3:0:b0:429:ccd7:9d94 with SMTP id ffacd0b85a97d-42b593954a1mr18869473f8f.51.1763535311773;
        Tue, 18 Nov 2025 22:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfj+W4rZkCy+pTT7CJvO3zJ+eyBS0O5AvHoo22fcnNNP1yE8aTkZfwKuiofxYmEYEMCNpYUQ==
X-Received: by 2002:a5d:64e3:0:b0:429:ccd7:9d94 with SMTP id ffacd0b85a97d-42b593954a1mr18869443f8f.51.1763535311322;
        Tue, 18 Nov 2025 22:55:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b617sm35673024f8f.31.2025.11.18.22.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:55:10 -0800 (PST)
Date: Wed, 19 Nov 2025 01:55:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 0/2] virtio: feature related cleanups
Message-ID: <cover.1763535083.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C9fECxZtzH-IydJHrztWkr-KRbMc9CJf0uxgnsv_7Ns_1763535312
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v4: address comments by Jason
  move features variable to beginning of block
  unsigned long -> u64 - they are not the same
changes from v3:
  drop an out of date unnecessary kdoc parser change

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not


Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 39 ++++++++++++------------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 ++++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++---------
 include/linux/virtio_pci_modern.h      |  8 ++---
 12 files changed, 109 insertions(+), 70 deletions(-)

-- 
MST

