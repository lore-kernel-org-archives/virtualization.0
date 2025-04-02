Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BEB11CBA
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615998; cv=none; b=XNcTp8STF1z5EpFQJhDy0DjlvabRIA1Bm0b4NzTqyJOS3ebl19cI/Y86AB2dkZ/sPmSGTgP+uORaiVzpUqlLm104t8PJcsXZJ3yO0PNIBEz3PhWAhGU0Q5/vMNIA8mZM9TOfUqG4oErEz+G20LGn1vm6YFncGAwhx5aAQjnuQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615998; c=relaxed/simple;
	bh=ZAM0NRncp3/C0HdE7bQJ/OItovivxBBfaaJK67GIIv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SlF/k1obWHESj7LkmqfeW09ogbUOTIHKqUoB+hGWlYGKkIE97ukh5g0FoCQzMOW0i5v5tgn8lPfn0xHaNSK1moUF6ybimw/doJcLXikj0B5UBQ0LyYDDBBfYXEhn0xJ0NfB7AxtgcHL7xlpo5Q/gTROGRxOAjmo9Ndq7C5uqZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNTiAPOR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNTiAPOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743615995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M8tq3Ac2LCgq0tpaPoX9b/VjI7pxLnGx+4+0fVvmu3M=;
	b=WNTiAPOR/rNwK3d5GslVwOQPaplRdU2zGxg1Zf9n7CHSQ0hcPJCtxG1MZ1OCq6Jw/NdQAq
	v7UoxGwDSnrMSPOwzmwBzYeKaZyRBkNCX387aKunSGTLzJAjMNjo1fQXqcJAp1/kYil5AV
	6vDNuz8I9B4DCREJZVWnvXtvslLQi/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-CsplDWmqMEeu1I_y5ZaLCQ-1; Wed,
 02 Apr 2025 13:46:32 -0400
X-MC-Unique: CsplDWmqMEeu1I_y5ZaLCQ-1
X-Mimecast-MFC-AGG-ID: CsplDWmqMEeu1I_y5ZaLCQ_1743615990
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E3D71800257;
	Wed,  2 Apr 2025 17:46:29 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.44.32.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AA38180174E;
	Wed,  2 Apr 2025 17:46:22 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH v2 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
Date: Wed, 02 Apr 2025 19:45:59 +0200
Message-Id: <20250402-virtio-gpu-host-page-size-v2-0-0afdc8c16cb9@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANd37WcC/x2MQQqAMAzAviI9WxhlgvoV8SBbnb24saqIw787P
 AaSFFDOwgpjUyDzJSpxr0BtA25b9sAovjKQoc5YQ3hJPiRiSCduUQ9MS3VUHkbqyQ2DX9laB7V
 PmVe5//c0v+8HZo2n+WsAAAA=
X-Change-ID: 20250402-virtio-gpu-host-page-size-282c99dfe44c
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Rob Clark <robdclark@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=slp@redhat.com;
 h=from:subject:message-id; bh=ZAM0NRncp3/C0HdE7bQJ/OItovivxBBfaaJK67GIIv8=;
 b=owEBbQKS/ZANAwAIAfRpJ40vDAI1AcsmYgBn7Xfrg7BYQwZ9cPC3ftS9ZuMvWFjEkoif/R9dC
 8U+2uR0nJyJAjMEAAEIAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCZ+136wAKCRD0aSeNLwwC
 NfBCD/0c5I88+rTwl0J7ptGd5rMF5G1auRnLUjwnz3rv30ohXabt9ptbB1E62yEyQ0UfJk1GvAT
 VgKozBk/1SQM/n0bFJN6i89x3bwislJhRwuItJ7fs7u94bla8tCsi3vJGaemaYwh2vJy0Ct8+3/
 xWVfwVEaN4qwnJ1KsZEe9hT0J2DMl/roMHx5Mz3nybGIp0TCuXSxh137YhtgaNmwkpwlOP+oSKi
 Dc6bWV5MLtz6DEQWe6Q3J5pT5dtbiuHBn7+UZ2Wy5+hwAzd3CknxpNSbXwGE+Rng3cydSkGWBgt
 tvSLMoBeL762RLsT4+NoOFzrEOSRFgxWXmXny1PSJOfoFjfNTwPfe/CjpVaRKkEvkD48mTC4f7i
 D6IbfU/l157+gARu7t8Y1lSFZIDbyddOeFn4V3vbtOO4trQsmzJ10Lh79ubKCAvi3v61oY7W2y9
 9m3nQl5l9fYIh0Bb7sQr1F8And7Dizz+Qt7DIkpVofh74TXHcNPIiRlv7u5nV0Ep2XpPp85ZzdG
 JgBFpM6q4K3L1ZSOLHvagxyCloslE0C9VvhEIrK1sYNW/JyAF7radalx7YN7rHO7iWD1SXeejU3
 JWXUgaDp2ishZUDXXSalDSzUGPhFz+FInbuiE0QQEAyHL9NmEssLlrDpw/U5LAPBoC5DslLA0WV
 dZaG1WsTzLIbn9g==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There's an incresing number of machines supporting multiple page sizes
and on these machines the host and a guest can be running, each one,
with a different page size.

For what pertains to virtio-gpu, this is not a problem if the page size
of the guest happens to be bigger or equal than the host, but will
potentially lead to failures in memory allocations and/or mappings
otherwise.

To improve this situation, we introduce here the HOST_PAGE_SIZE feature.
This feature indicates that the host has an extended virtio_gpu_config
structure that include it's own page size a new field.

On the second commit, we also add a new param that can be read with
VIRTGPU_GETPARAM by userspace applications running in the guest to
obtain the host's page size and find out the right alignment to be used
in shared memory allocations.

There has been a discussion in virtio-comments about whether the
information about alignment restrictions must be shared in a generic or
in a device-specific way, favoring the latter:

https://lore.kernel.org/virtio-comment/CY8PR12MB7195B5E575099CD9CA1F2F39DCAF2@CY8PR12MB7195.namprd12.prod.outlook.com/T/#t

v2:
 - Rebase on top of current upstream.
 - Make a reference in the cover to the discussion about how device
   page alignment restrictions should be shared with the driver.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (2):
      drm/virtio: introduce the HOST_PAGE_SIZE feature
      drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params

 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 13 ++++++++++---
 include/uapi/drm/virtgpu_drm.h         |  1 +
 include/uapi/linux/virtio_gpu.h        |  5 +++++
 6 files changed, 24 insertions(+), 3 deletions(-)
---
base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
change-id: 20250402-virtio-gpu-host-page-size-282c99dfe44c

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

