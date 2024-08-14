Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840EE13D8A8
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618785; cv=none; b=W8xqaZ3GVw93cOdQ3kOpBAL9Y2ehy49SVBA0Cedj0Ah2pMOas81lbEKBC+mp41YyNFFhaCo7FoAc7BWHRKJ26GttWnuGjLpw98AA+FIw0SO16RPt5bGTyJrXbzZNVWPBvJXL8nb3whQrvqQf9zJwbZOufLlRLI0rP1DNMSLZGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618785; c=relaxed/simple;
	bh=Pu3OGCo/CmwwpRnQchJJUnb7pVL/LRupMdZBjzDEC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T+4NhafuzpB9A1wds496kn80ULonbwba71whzk5sJq1uNhIoxbDhMrptLDYUp1EZtv3B06wGVFZmcmneFSrTJdo4n6QxL/m7MUyKLpByr9/TrZ2T/DfHWRDixowzeRuop5c6c5jv+zjHcJZaLsGQAT7P0RShLDerCskJKToczbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6PnSWqY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6PnSWqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
	b=g6PnSWqYAQrJ9nD/8BJSbHw1dRCsN4pl9tWWXRnoVFdd16F5VHEMemcVkS9jx+C5RsLvW6
	ey1zI7Gt7qB4LibMB7mC4qeb/kO9y2f2g+PKF9bLuah8m9nP95TNGZlI2ivvjkUWMIC8Is
	e43oWktp9r5q4kmGlSX+V1esF3pHzj4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-kdKxKFLNPDylvXMSNo4yaw-1; Wed, 14 Aug 2024 02:59:38 -0400
X-MC-Unique: kdKxKFLNPDylvXMSNo4yaw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a9761bf6dso526676666b.3
        for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 23:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618777; x=1724223577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
        b=Qz8RI2DzI489sCxTCIhZyOp9xPxb252//sJ+q71u8JF2HrwLtLq+3j9JzhWihK6hcz
         gggzjt7JztWBc1rtBzOZNKFAadVQFLS+iy6CQRrUm8Ij+YRFC3T9pWh+VKio0BNnh6K/
         lBpXg8XwAPqNeuAh7sY9wjxIAgqiB3PtDNUpytTpnxDOkb15hShbTIsNOZmaBOJz68Lu
         OkpYaZm//B+m9N37wOuD3FWUvXJQeMY3ENkvGaR2h1SNPqGl2ecctk/vs4TZzeV6PbVa
         E+YVsUtzxFlpvVpEpHtRtIivKCFfhfEAuH+vWc+T616+2xhsUlAFjsR/ncbLsuvk5jvN
         3A6g==
X-Forwarded-Encrypted: i=1; AJvYcCUwNkiTFg2nKxwJPQ46hwtMdMOYv6GEakGSexPjYP2ror4Clt/N0RA0qZiXClGAyXTmkkWHOtcFn/McPKx73aySkvc5f69uwiWyxD0CQqc=
X-Gm-Message-State: AOJu0YyLEA0sTBtetHJbAYu43R/ubPSQM39bAaIsqaecKJ+I50LjLCoq
	h/tQqQXrfEklQtXfc6CW4zCQkWTON7RkPWAc+P4o2SUsr9b2EkrjbhoFOcOxH5A/VO+WEv7dkUh
	gQgHXfN4zSJNhLLfTVx0ikbeHNSLPT+Qi3fU6S83LrmTcsGIdVOhxR5B7elCYem4E
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108210966b.11.1723618777540;
        Tue, 13 Aug 2024 23:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyMAjw3UY0D6+5QLVxInfDhyCUgtrNGyRp3D6mJIvUovvpU7E1koWdqS+NoKo4y/Bx+WFK7A==
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108207766b.11.1723618776638;
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm137019666b.144.2024.08.13.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 3/3] Revert "virtio_ring: enable premapped mode whatever
 use_dma_api"
Message-ID: <4937ef0c9389fd2031cd0be78ae791d3289b6e94.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit f9dac92ba9081062a6477ee015bd3b8c5914efc4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
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

