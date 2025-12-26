Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B320E03F
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766759777; cv=none; b=M+M+p0PMi3liwRxB/NaLACVaWS4Dk8B1CbEABaS2+IgZPos8nJQew8QNLji8e91MMOKMD6mjvJx3cbNSPOCintZiyQLOwDP6hKYXOVIbB98TnRfY8uwqISGH8G1nZl1MSy6osoch7+eVrdbtJwSuBNEVm8Qzt/AOlUKPpiSBpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766759777; c=relaxed/simple;
	bh=d9E0S3a7Rqh638zbPGkOJvQRUJi3fvoEyv3EnW3OnN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jl7xso4LKLb9odwLkgidQo33ZsIes9PpZIGxqZkkXf/zKiFBvBwwyGggz16lbl1h4wmKVubvS5xfkDk6lFFGmcGwfoG1tmB/f+qXfKDxP0iyuc2R6tfjR0EsSJqVrxyYD3yoVLwwMWRnjXIotdHMj0odbwjalA9EXewrCbjgCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KowFihcT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KowFihcT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F6C40950
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 14:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id reavXXXy6apj for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Dec 2025 14:36:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C5EA94094D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5EA94094D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KowFihcT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C5EA94094D
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766759772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aM7UCYg0YYsybtoWO8yD5ljh1de1V9SkAU1INn7RR+w=;
	b=KowFihcTxz2A36nAnd4z3Tv9ZZ4JIb5BuC6eP/7oLy5x9ne8XMHrLVnb5o+fcVaj+ihQfo
	kVqFMMulFV9pqdI8RwnCBuDP77/LIj/S1xBp/fqUlABSEnbICjM1PlKUKKMR264/V9cy18
	mWFIh3h4IuLsyPkecLPMIS4NIZ/2OPA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-SBappwqbMFu5S8wPQ31DFw-1; Fri, 26 Dec 2025 09:36:10 -0500
X-MC-Unique: SBappwqbMFu5S8wPQ31DFw-1
X-Mimecast-MFC-AGG-ID: SBappwqbMFu5S8wPQ31DFw_1766759769
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43284edbbc8so213932f8f.0
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Dec 2025 06:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766759769; x=1767364569;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aM7UCYg0YYsybtoWO8yD5ljh1de1V9SkAU1INn7RR+w=;
        b=IEYbSodDMzXtNVANLJYjQmyNsfQmNLMo5axufs43QfIeV5qYYwXwohehKRc1+suLQc
         dsbZsK7h9IiXNDFl1mqNS5W6Y4khw7euOU8d56Cj4mbyJKEaOc2RZovlSll5/unIBGH3
         ZcrfYpijGKfHZTn8xzEqc/1LKCJs2OR6UE/oSyALNwKP79dz0yuT+fv3LvYIaPcgFkGE
         VXxxZKwlIaPoKsLkCzmM6MqWwnm4AvYWUXxZfHbFjc7byaOqgFCoZt1FFHdWo+yPc9xc
         WcyEygsYUo0bS9pF5aqxUiv8cEig2sBznH1TL4mxCDLl5nD6CUhoF6Zvzgn/2TvhVLYg
         fF5A==
X-Forwarded-Encrypted: i=1; AJvYcCXfDVvP2dytJBSA+AGxZpi0UyAOyg2gGclg1UUVm3knTjoqAJFuB0kUKAeG2pqUWr5RUARkuKvgW0Tv2YWXFw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxZCAWN2hIkfmW6pWKvnLO78CinurrGR8Y1pZC40OhWt6lk8nM7
	q6dpD3sLTli0xyzWxPGhcndAhM8TM2sA3u3HIocKI+c7imdiZUQetlrIcP3b0tJW9GGuu2yTCCC
	4mrgNPLK4rG8WpfP4P/urXIGhFyULFOYZu+J2UfnNltG8Cg7z+CBzT6M/oZbY8n3DJmdt4RqMpg
	yLBmqNBQ0=
X-Gm-Gg: AY/fxX5iB048g4v7ZXzydRy50W5b/jpvdAEi9onM/dYo1hFcdn8NfjPJb5TcmCOyO9/
	CYyMVy1oYhnZc2eAE88k4sR1wty9GsYP+z9utsSFfLQeX0rReMz4EpGrG+Rc6tkukBWq7IOOi/l
	7yefQo1l6ZT4+FzvoGYeUJh0qo+1/Qh5/fQQnTbijnj6rJTENEY3jXyAMFAIVeFnmo1fq8/76sj
	w10v5SzKBe2wMIGy/2T1q2aAT5BeshefZXQtsk6h/agG55s5L2BSDICRKHmX4e4wZ+DBwKpoRcq
	gBe/VHax7b27B7A9rUiYwa6wkTUZ8V2CXnSJ+oUEMtR29/ysBpTCGO7aqNqrB008X9ziWb1fyfF
	FDof8bum4mQ58IjPzjkrKCTPGcqwlHkhtvg==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr25656350f8f.58.1766759769349;
        Fri, 26 Dec 2025 06:36:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Ues0XID2D7Q3Cetsq2JyqnGEmS98rxaQOa4ee9lE0/h9FUcNthZgz/uYJCKJdZKFGsTz4A==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr25656311f8f.58.1766759768817;
        Fri, 26 Dec 2025 06:36:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08efsm46051829f8f.29.2025.12.26.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:36:08 -0800 (PST)
Date: Fri, 26 Dec 2025 09:36:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20251226093606-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: owot-YgatMEoNIPJt7eCs-jfrD_cRsxi-BB3AyGwccE_1766759769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d8ee3cfdc89b75dc059dc21c27bef2c1440f67eb:

  vhost/vsock: improve RCU read sections around vhost_vsock_get() (2025-12-24 08:02:57 -0500)

----------------------------------------------------------------
virtio,vhost: fixes

Just a bunch of fixes, mostly trivial ones in tools/virtio

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (14):
      tools/virtio: fix up compiler.h stub
      virtio: make it self-contained
      tools/virtio: use kernel's virtio.h
      tools/virtio: add struct module forward declaration
      tools/virtio: stub DMA mapping functions
      tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
      tools/virtio: add ucopysize.h stub
      tools/virtio: pass KCFLAGS to module build
      tools/virtio: add struct cpumask to cpumask.h
      tools/virtio: stub might_sleep and synchronize_rcu
      tools/virtio: switch to kernel's virtio_config.h
      virtio_features: make it self-contained
      tools/virtio: fix up oot build
      tools/virtio: add device, device_driver stubs

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

 drivers/vhost/vsock.c              |  15 ++++--
 include/linux/virtio.h             |   2 +
 include/linux/virtio_features.h    |   2 +
 tools/virtio/Makefile              |   8 +--
 tools/virtio/linux/compiler.h      |   6 +++
 tools/virtio/linux/cpumask.h       |   4 ++
 tools/virtio/linux/device.h        |   8 +++
 tools/virtio/linux/dma-mapping.h   |   4 ++
 tools/virtio/linux/kernel.h        |  16 ++++++
 tools/virtio/linux/module.h        |   2 +
 tools/virtio/linux/ucopysize.h     |  21 ++++++++
 tools/virtio/linux/virtio.h        |  73 +-------------------------
 tools/virtio/linux/virtio_config.h | 102 +------------------------------------
 tools/virtio/oot-stubs.h           |  10 ++++
 14 files changed, 93 insertions(+), 180 deletions(-)
 create mode 100644 tools/virtio/linux/ucopysize.h
 create mode 100644 tools/virtio/oot-stubs.h

