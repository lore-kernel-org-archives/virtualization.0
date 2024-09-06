Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311E1CB336
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616376; cv=none; b=r4w4OZqRYrW9Z3cWVm+pjdUz91SbbL63o44QBULw7RF1i6vSxl6U7Z7U61PtMBlUopM7W1ZS9JFQa5EEpgnKO3qZd2TzkQ957yeA8mT7rQlIhUAUw7uGsV1ZMtItUY52cGvNoWuWfO93bZDRM3x0romJ9WXZem3SEmKh+K0s7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616376; c=relaxed/simple;
	bh=G0vuRwIZULx1awulz3TZccpUD9HBmx1Km+yJqugvR6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PvLQAkzS1gQ+gpgOhWGAb5mfgCeoyhwuxwrSRHJI9oXCv/YKQ3X4DKpMO5yXMlnkPvvKzjUb5ddxUV8lpk+t/9aHfXZOp0rNEJt/U+olW9bNXnIsSZlNIT/nGg1ZijGYqezt5sAr0ruOcwBieyzW+iWd29M3IGUiLkcQSVA3lGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHdz4xly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHdz4xly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BVAAiLX2YDT2AdtI4QtNJTs70zsl324iWlMmUL5ZGE=;
	b=ZHdz4xlyE1lnTWlbo9k91UKfUo6ugi3/uGDh1jfsUl1OWTuRrRkMzRREqYwVv67eHQcbkr
	ubpuX2cb7hIEiWoXuBHMVc4iQ8vxntvzg2nAZ1n+5UGARi9IbDNKRHW2Iu5WKeIPUDXlxw
	ONMHUSq9jL/lEcHSCQr1EMQAQDfhMU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-qjSvCoPdPVKmaNR9zue2zQ-1; Fri, 06 Sep 2024 05:52:50 -0400
X-MC-Unique: qjSvCoPdPVKmaNR9zue2zQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c80412dc1so14621085e9.2
        for <virtualization@lists.linux.dev>; Fri, 06 Sep 2024 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616369; x=1726221169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BVAAiLX2YDT2AdtI4QtNJTs70zsl324iWlMmUL5ZGE=;
        b=VFV2zdng4BHUjVeqmi3XWHtzaGgnIsietI42rc/DbT1MVt+oNc7QQR2hr7NwKh1/+V
         b1ZP4I+aCxRNOToRL/6+oNKB0ubeYQBhgYioRMao3OlRY8odE8zUFzYW0a8JWdWhGkYF
         CbwQIFzuzR9N8fMR3NOydnNM4PaewZbq0//c5gsIehhlAZm1MBlea3mCPNhvupVdx/1o
         7C9NtYfneA3m/e++VaBbqjCIrJhFEafMYRt030E4X7TREhitNwVrZg5vJa/4tfv/xVy0
         3USopDzHwU1yCSbk+zHdVHpta7E1pV1rHByo4fu8cwJT66+uy5jzTuAr2Wqs7+OGLG6Y
         DgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnMIA2ogujvtexHeTa/e++qZe9lCAJIXsJJjlAWTROBu8GslE6Wk/xEFs/4DDZzi4sZWqGGrPAqhAItKh4VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEq8zIZMp965tLllaLXLxkbix/sM7BSlFS2JjLs+6zGwk9ug3u
	+TtpXyANDv2ZURjuOVcQk/BJfpTdy44BEB/Emt8k0Zz2C62NOghwnq1nRswKKgYV08I5IJkyeq1
	z5Uje7ue3l4KKYS0Fn6OPSDlSAJ9AUpRiClHxIGGlUaxhKNGqu9dPyH+/9ekf6XAO
X-Received: by 2002:a5d:5225:0:b0:36b:3384:40e5 with SMTP id ffacd0b85a97d-378895de480mr1326179f8f.24.1725616369306;
        Fri, 06 Sep 2024 02:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpPl6uh0wHWO+9rukppTUDX20dNZLFoJnMDp58PodNRcJ5IH3PPSXhUNF+FyNXmBHbr/zcog==
X-Received: by 2002:a5d:5225:0:b0:36b:3384:40e5 with SMTP id ffacd0b85a97d-378895de480mr1326157f8f.24.1725616368848;
        Fri, 06 Sep 2024 02:52:48 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c5ba7027sm14447997f8f.19.2024.09.06.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:48 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [RFC PATCH v2 7/7] Revert "virtio_ring: enable premapped mode
 whatever use_dma_api"
Message-ID: <e8a8f8c3a2d67b25dd261184da6684fda1813c6d.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit f9dac92ba9081062a6477ee015bd3b8c5914efc4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..06b5bdf0920e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
+ * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2798,6 +2798,11 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
+	if (!vq->use_dma_api) {
+		END_USE(vq);
+		return -EINVAL;
+	}
+
 	vq->premapped = true;
 	vq->do_unmap = false;
 
-- 
MST

