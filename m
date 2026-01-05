Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BB327BF8
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601407; cv=none; b=ok2PM8Qrteid59PvJfyLBNQvIxz9CwN17jPC3X9imdeyY1gYN+KJnaUXIC/w98HSFoJBYVZdCngBtnsc07WC1FZZbb9jD5vyPtTjsg6bYqJxEwKpdnCtC8jzkNXpBqQ5Pw6ysjEuWyye7Mh14EXATOhsdHeViWf8BRxvuE2kf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601407; c=relaxed/simple;
	bh=UZnbRwVvRPHcRgRCzpxYejrN2eYzh6K3qUvMvD+slXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Crzr3Mza6bGCNBdkUTAv0NyUGH0yjMkCs+aHE3++sxSFGDVsHoqb/GVqhgQ/6O28cGeZoT0e6nKT3LX6KrZA1dOmqrknnFZoVMlf+3ME/ej58Ue+Q4JRfrxcly88jGUJ5Bp4RawiDwbVUz0zGok/LAGkFdYIYBnWEuAhjWCy7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va5i9zMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va5i9zMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixiBJgqmLTQwR4hP1VcNBLxgwUtr+SaYhPMs/HYsyIA=;
	b=Va5i9zMeMtbcRHGkO3omiS2lnbjK7NHJmRV04pl1aei+cXj/VonDubjoano/21Gzm6DJza
	NuqsI5jUFDMBOOIBPpcc5KxS9XpfJzugdzZmrvHTih1SwK+tDbSBdheB81od2wtPh6Ji6w
	llfG0vjl4L4Fd7EkQ7ac2tMIxB6DT/k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-cO6EsyrMO_22BbhJtQfCeg-1; Mon, 05 Jan 2026 03:23:23 -0500
X-MC-Unique: cO6EsyrMO_22BbhJtQfCeg-1
X-Mimecast-MFC-AGG-ID: cO6EsyrMO_22BbhJtQfCeg_1767601402
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fdaba167so7331553f8f.3
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601402; x=1768206202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixiBJgqmLTQwR4hP1VcNBLxgwUtr+SaYhPMs/HYsyIA=;
        b=Nyr2udcgnVc2kts4FdhKTg2FUZ2AXmgKJZ2Qi3wDipS1hk7nbgocJBbwTpOL6dvwzh
         piOi3tQ81JvUbCsda9tuyVRw9ORFit/Ssd+LEl0tC1OeYqRlMdXO0waSUH/7yWhxehMA
         qgvEaD7FRfEoPEVKeIIBvkEaf/XHhLSfcRPyx26ZzkPRTUb0uZMkLKCn0SS917lrkIw+
         WkiFbLETM+Sh03oPQk/wRzGAEoKXbnLgQ7gV+6ykJbVbyKiotRojw3P4ICBWLz1FeVSG
         MX5uSuKmgJgmN1GxulWBRhm4CQHpIEA3/0GkUg7mptywkLr9bPrZZJiHxZZifIIfIVxS
         msgA==
X-Forwarded-Encrypted: i=1; AJvYcCXGYoKOWwiurecqFFdZIdKWVA2ZOHpsoYwwwpJAnQVW7/T8HpxwvwkLfnIOfh7/N1VB4DDyg+cetzYa/MfzbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YynvNMkRIvhQvWP5CFcztnLa3F6OwaW3BX3vOfnVA6H1eMTEUhE
	8OCJTSMi7XqMg8zAmq9G8Oe1n20+ET/8Di9GJWM9sqAYscD5hrL6CJnd+T3kcuIRpipcR/vX/6y
	mpBuoROPVGp6xLuQ4YGdQ3JSCnKujWJcb0PNpFjNw7OysLtcxxp4EjAaS5cHLChOsbWPM
X-Gm-Gg: AY/fxX42fnqEiMOWchiTMy3apXm7+PeIy48MRrYIXARAFne69OTcEmfXLt51rvpxWPC
	bl960j503KgP/48YrbYbaUHl4EVzVpMXJQL6EKmourn4es0p04WiGp+1NAfuLSt3M9ajTe1/7xH
	7bk+bIM0seKAF1FCWhiRXWeKJWSdtDWGYY/WenkQCbNlQhui66QvrK9Jizoja4h8UkPy0QgfB5U
	kMyI3VYQxWX8S+tAgFrM0jFL8Rjk74Zn1mW5PM+m4cWPYoxmJC9j7oVvdP+OQHjxMDQ/N1sI6SD
	nTShmXNnW+K0CSaCVbxFa2CbO9jGG5zMZVjqeUNcuBk7O8jx/voy7FavF8USPqEJlhXAIJ/z0+d
	lJ2oYKGBWLFKa9QHNKEHRqz/tB0kc3DMa6g==
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id ffacd0b85a97d-4324e4d04d4mr58561461f8f.25.1767601401670;
        Mon, 05 Jan 2026 00:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx1Nl8KRgrNe9z8PJkEy+oAdnaqu11UpBKN0xrzW8x/NIJB12I9Y53VIEzJyG5l7t+8XCSPQ==
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id ffacd0b85a97d-4324e4d04d4mr58561401f8f.25.1767601401124;
        Mon, 05 Jan 2026 00:23:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm100730503f8f.37.2026.01.05.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:20 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:17 -0500
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
Subject: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -LZw2XcSB20myRopm4Nsk-KFvrV58Acisefg1DiQszo_1767601402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The event_list array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
written by the CPU while the buffer is available, so mapped for the
device. If these share cachelines with event_list, CPU writes can
corrupt DMA data.

Add __dma_from_device_group_begin()/end() annotations to ensure event_list
is isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..bb94baadfd8b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_vsock.h>
+#include <linux/dma-mapping.h>
 #include <net/sock.h>
 #include <linux/mutex.h>
 #include <net/af_vsock.h>
@@ -59,8 +60,9 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
+	__dma_from_device_group_begin();
 	struct virtio_vsock_event event_list[8];
-
+	__dma_from_device_group_end();
 	u32 guest_cid;
 	bool seqpacket_allow;
 
-- 
MST

