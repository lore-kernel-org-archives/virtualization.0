Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B662248F5D
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748356047; cv=none; b=Bn6vm4nWHj5a+oZ56ljBO7IPQ+kmNkIdfyKK13j4LVrFH+adVnoijqFup8W99bgiqfuT+sFSj+4mBqlLGr8N7Od9ym9txk2ytYn8IGrCLthM8JHzqSV8FGjgmfDWzGFL6GjHEPdIKGi+Crmx6NJy4PVmVmHWjKLkbQ6ClvRfH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748356047; c=relaxed/simple;
	bh=JzQItSNVv23zDd1t1/2QMHHi4DVBx9+mJ/ig56B2iEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HQAvEMbbclbtZ/uEUJ81jLAoTok7Rxqa/KPMvC1lAR2RYH+9ZJxB8hUQcbf2w3iUDWZ3c1xuhPI50Oy9ym2uMHujOpnSuKG+HPXgPpqY8wI4+yzHVLSnBYB/nUoxguVdv4+E4sT7ie07twWH9rwFPYQpbuPc0r3T5KLwL+UeEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HteH1A9X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HteH1A9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748356045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=loG0I+Dl2oQWj8aB672jQJbZ1XRhgLNEO/t73xTMpm8=;
	b=HteH1A9XB2ZcOVbCWxu3Mt3CiwSbbJxjbpxpO4ehm3txgJLevmsr3KzqiPXpV+4WRavLoo
	DfV0P0tLTZTlkjVfFvbLYWGIVQ/xvb+TUUyAJ5s7V4nhPU7RSaiTUhzVB7maMjg4XiDLSc
	TfIN/v54BMJmZvQutw2T+z6WwAKKa9E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-OOurGPNvNzioHdHvyo1nJA-1; Tue, 27 May 2025 10:27:23 -0400
X-MC-Unique: OOurGPNvNzioHdHvyo1nJA-1
X-Mimecast-MFC-AGG-ID: OOurGPNvNzioHdHvyo1nJA_1748356042
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442dc702850so22234695e9.1
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 07:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748356042; x=1748960842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loG0I+Dl2oQWj8aB672jQJbZ1XRhgLNEO/t73xTMpm8=;
        b=lbjnSWTBQ+IZtDQEdM1ju8i/xUeWwpvEzpQrl5uZ61arEJkPVkEHYr8LtTZ8vxX+Mj
         ozwqTw5u2PYllQPfbYYzR7l2MoQD4KQLrLqgK3bdwpmKllqdTSWm419bbOiPEr0TeBYI
         RFs+fxXB2MevKvfAAx5m6DM4cF/LiLzDzbT9EKN+MiFhpP/Rey/tTuDl/kM2eKsYv4oD
         emYIcOBUZPfcivO6SL0l6HgRPooRPcTm+0Zijn2jTwuFFbMLc+kZKJqSXCR8MIN14ETz
         S5PobMin7XLTcEj0gwiCi0/IclsK3oj6Jp9fnT7XT95Q0mjJtjvLymNjr6JMPSFjgQ95
         DOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGihKGQKtA98HkdtKvyEOXsglN9qfwOyllcossAoQFqu4BmM15JwZJPPbR2VYLaLm48LwwwfM1dtFxyFe7iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtlNfB7oVg8BvjPXfPDPUrnnup2hb8/Lvxbs99M9OXBe1iL/kA
	1wQWHqkqw4oEWaDSHq3vT/ULzlfaV495OgKxzgoxB3ImCXPwYCZLbepAlCOf/kYPwTYu4OUzfje
	eUtW6o2cm0a9wyiPmFsMWJmICZVSNlmTznbdWia5/ITXPCSTWsKXH5uFEvvg2+XdVTsXO
X-Gm-Gg: ASbGnctIW3dRBGIlCK5ZOr+pOmjumPvACmaWnzj4IpYSZJXEhL3/UUJ3RT6WBQonIu8
	T4nKWapA81F+itVJZQ4DIaypClHXqB9MYBytDhfkWvQ9lPzb65o8GNRURT4VlBNCFcM2ETd2Ool
	JLjUH6OpQbsUE+v0goKDbSIDe3dvuh8RYIkgBl9gAMs7zqkjxQkkcVqKxRMqY6bO8OUfFg5mac+
	dGFZrr83siZ3Q2wMhtnmi8Vaa2n1OdgUrHMuyAYGO09qbMmL9LCi8gCTsoKSPZcIbjlnTpYVtTF
	mR42/Q==
X-Received: by 2002:a05:600c:1d99:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-44c91cc3e83mr126110335e9.9.1748356042492;
        Tue, 27 May 2025 07:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbK8SlBZJYpkjFZFAqyV31vx7Hq1g5B/8buxgeL4/qwgmibcMk2FtXwnmTaXHM3QP5L/O9lg==
X-Received: by 2002:a05:600c:1d99:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-44c91cc3e83mr126110045e9.9.1748356042110;
        Tue, 27 May 2025 07:27:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm277186565e9.22.2025.05.27.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:27:21 -0700 (PDT)
Date: Tue, 27 May 2025 10:27:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio: document ENOSPC
Message-ID: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4J6orsM8peeABdNzt6_dC_zfP1EEi_dw5IsUOd6Gx1c_1748356042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers handle ENOSPC specially since it's an error one can
get from a working VQ. Document the semantics.

Reported-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..97ab0cce527d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
  * at the same time (except where noted).
  *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ *
+ * NB: ENOSPC is a special code that is only returned on an attempt to add a
+ * buffer to a full VQ. It indicates that some buffers are outstanding and that
+ * the operation can be retried after some buffers have been used.
  */
 int virtqueue_add_sgs(struct virtqueue *_vq,
 		      struct scatterlist *sgs[],
-- 
MST

