Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA662329392
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601419; cv=none; b=j51umKTuRPJFE5Uzntmw+GOwlccpmeQAngTpSA/LhvLxZrvnVKqmHku4FgnXE8nTCM4uYNRbfF3Eb9ZSBYkUfmW7o9AbsOEeBYakS3FJpnFRp88oKdinEp4bQvGTjLNTmb5tbx4tNs+vo6/klIAYFMBsgqFRCf0cpj6TAiOh10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601419; c=relaxed/simple;
	bh=S9cU9rMSKLAHqC3C9VUi030/VnGNztyhDP4UPj+0Vaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=h77b23tz/7GkLkQzjHukMH+OPc73T1PXOVtAUgXjf9gbO/Szgc0hmAS/VUi2fYLTo3midM3KjvD3oAeVLB/x8CaFZ5sebKRB2HpjEIn/J53GkzfR04KfoOKzl0xaqB21bVo68XLvPXiPA1jJwJSQ35GAV1e/InCSoOcWD0KdwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRVrAXij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRVrAXij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvLvTQPEJKAtkqGovGo2GHeF0+EOLKvEuwFpv+PiquM=;
	b=hRVrAXijnRHK0hEi/eE2t7KSUH1uBH4rQYAH3sGQGFJz3cJBz24Mtx1Yr4otKh9d6xgLLs
	YmFjzwD5jtNbo8Y7fc0052KAMVFH7wbKt1vWGVB9jUS4kVzDoQ1mywCeJPSTDAHzpXJkph
	XDopFb8BTfKCDqPGJwUoSWfPU3FUM0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8XIZkJF_MMGFpasaLLaVCQ-1; Mon, 05 Jan 2026 03:23:34 -0500
X-MC-Unique: 8XIZkJF_MMGFpasaLLaVCQ-1
X-Mimecast-MFC-AGG-ID: 8XIZkJF_MMGFpasaLLaVCQ_1767601414
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f57cd2caso12513520f8f.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601414; x=1768206214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvLvTQPEJKAtkqGovGo2GHeF0+EOLKvEuwFpv+PiquM=;
        b=TDAbfAA8/ANs3QcCWrFMiz9eL0KdvJPRHAei9QNrQ3356YjPG62MsrQBRTrn/iGcRU
         Fhot7N4Sadoz/7eBeWCQEwPMLasqwqz5lJftJOp9X8mah9wNaLJeD16aglQk5xeyXMTb
         edb99QOxTSubhUucXFXpI4PzlVce0AKQp9AQbKQIokwzpuemj/eCvr6ows+b6Wus4aVZ
         nogmMfi/VHWULxG1q4EU8B7vjZKJOQj1MeD35w2NzsOUq3bzizkVYPvgqdVbSii49+N3
         onCaz8vfF15ZRAMl79In4cZLCEfY+br07n92URiTkDKKjVBTSgGyygUCFnzBAevMCsuH
         JAJA==
X-Forwarded-Encrypted: i=1; AJvYcCWMCImL6YfYQL5ovxct8QMhGR3xW8gpffAxtXn3bAQzuFbWDh9UuWLec/zUrHZVCSDz/ngzMN0cpluG1Kz5WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLTBDHJWWsbJ42JoTgBvrDQXC1Dp3S7H6m6o3aFYsQRreBEVDL
	PDiOg6BXDjEBzreICSUqu8Ny48IkzJoEjyIfXidyPJNs5zeBK1aPEPW+RMh+6BJDhlmtitOYaYc
	5wdJND8UC4lHuXtUF0x+UXokJMohRZeTbCJ4jUxaXFmIvK0tl0BJinCUndONFCVVnOkXq
X-Gm-Gg: AY/fxX4Gy1U0/tH4aoXeGoJ8aFkpb78Ac5JQd7DcIy6M1ETpl98zMRBcSthiFC3utqQ
	7PFBym4VY4hhY5KokoeLpL0Ykls6L7vS73Ey57bqaYGc+T1BmcUeYAimOG47zwpLTIoz/MlS8cI
	J5myqmXcN5nRfRP8Zcb43ljT17dfT3wn075Qr5tMzU6ByjJv97RAlXrM51l0k/IITm370ZYQqd0
	JIxJpX5BSETdFRdMtfjjT20HUT1D4Vk957aoUPUzRW0Os6x0J8QQh7u5SKpPs6lSf9jS5CcthRg
	dPGtR5tgRhTxItBk5urFzEz56rUrQdLtByVS+avPNXIVIDx8pMQCUKtVsAeSekQm8KNNPes0fwh
	0jHO8BxpXEaFCTsCccbcUt1yw/sZrQnU8Eg==
X-Received: by 2002:adf:eb04:0:b0:432:84ef:841f with SMTP id ffacd0b85a97d-43284ef8d0cmr31362883f8f.38.1767601413455;
        Mon, 05 Jan 2026 00:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx7eWbROO38mdjmsXsZ8eTRhzoo1KnfbPFeP9XiXzVU5+PKMGQRYrz1a7izR0YG2kvu7gW1Q==
X-Received: by 2002:adf:eb04:0:b0:432:84ef:841f with SMTP id ffacd0b85a97d-43284ef8d0cmr31362856f8f.38.1767601412963;
        Mon, 05 Jan 2026 00:23:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2beasm98160481f8f.33.2026.01.05.00.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:32 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 64sBXL0qnCAevnPpY8QEcmfjRMh3GrtNSfEVYDI5e8c_1767601414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current struct virtio_scsi_event_node layout has two problems:

The event (DMA_FROM_DEVICE) and work (CPU-written via
INIT_WORK/queue_work) fields share a cacheline.
On non-cache-coherent platforms, CPU writes to work can
corrupt device-written event data.

If ARCH_DMA_MINALIGN is large enough, the 8 events in event_list share
cachelines, triggering CONFIG_DMA_API_DEBUG warnings.

Fix the corruption by moving event buffers to a separate array and
aligning using __dma_from_device_group_begin()/end().

Suppress the (now spurious) DMA debug warnings using
virtqueue_add_inbuf_cache_clean().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 96a69edddbe5..6ff53fc8adb0 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,6 +29,7 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
+#include <linux/dma-mapping.h>
 
 #include "sd.h"
 
@@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
 
 struct virtio_scsi_event_node {
 	struct virtio_scsi *vscsi;
-	struct virtio_scsi_event event;
+	struct virtio_scsi_event *event;
 	struct work_struct work;
 };
 
@@ -89,6 +90,11 @@ struct virtio_scsi {
 
 	struct virtio_scsi_vq ctrl_vq;
 	struct virtio_scsi_vq event_vq;
+
+	__dma_from_device_group_begin();
+	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
+	__dma_from_device_group_end();
+
 	struct virtio_scsi_vq req_vqs[];
 };
 
@@ -237,12 +243,12 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
 	unsigned long flags;
 
 	INIT_WORK(&event_node->work, virtscsi_handle_event);
-	sg_init_one(&sg, &event_node->event, sizeof(struct virtio_scsi_event));
+	sg_init_one(&sg, event_node->event, sizeof(struct virtio_scsi_event));
 
 	spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
 
-	err = virtqueue_add_inbuf(vscsi->event_vq.vq, &sg, 1, event_node,
-				  GFP_ATOMIC);
+	err = virtqueue_add_inbuf_cache_clean(vscsi->event_vq.vq, &sg, 1, event_node,
+					      GFP_ATOMIC);
 	if (!err)
 		virtqueue_kick(vscsi->event_vq.vq);
 
@@ -257,6 +263,7 @@ static int virtscsi_kick_event_all(struct virtio_scsi *vscsi)
 
 	for (i = 0; i < VIRTIO_SCSI_EVENT_LEN; i++) {
 		vscsi->event_list[i].vscsi = vscsi;
+		vscsi->event_list[i].event = &vscsi->events[i];
 		virtscsi_kick_event(vscsi, &vscsi->event_list[i]);
 	}
 
@@ -380,7 +387,7 @@ static void virtscsi_handle_event(struct work_struct *work)
 	struct virtio_scsi_event_node *event_node =
 		container_of(work, struct virtio_scsi_event_node, work);
 	struct virtio_scsi *vscsi = event_node->vscsi;
-	struct virtio_scsi_event *event = &event_node->event;
+	struct virtio_scsi_event *event = event_node->event;
 
 	if (event->event &
 	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
-- 
MST

