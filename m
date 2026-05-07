Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A33563D4
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192619; cv=none; b=OHyquDML/pkZlEqFc0HNz3mQbdOqEtJwKROQwkwPuFukwqFeRrO4+QIdQNth2mTR9L8/K4Gj3Ilkdq8oxJgfQunyqPZLGHWuDHgmBBVUPo2qFTWOTVYTRPg12qdP0/ReCBt7CG3qfaDr3e4Vr5hcg2pDWxuWaW4RrcWZIO7H+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192619; c=relaxed/simple;
	bh=XxUQw3tZx0AkRKlM9jSBDC3gsiVvkne3m0EtV0t+S60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dVTzKI9nWJDSVYAIrHvAvo7hAtlloVy97kWfon8TO3Ljd2yKkEcYY7KW1C9PxfO1ph/m7JjpW6WRMVEgJroPB9rqQPEwiiUJiETgo/opcGGDC2mPmpF91ufYO2EgsUOdbxBRKryXg3li1l+ovJLtLQbm/0EOVezw8MfA4cM+gDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3NEoYP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3NEoYP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhmJzOluo2YbyCNWY9nO19Tj7FrnfhHS9n0nNp+gIQc=;
	b=d3NEoYP5ze+t1lj7enlxwh9FsUrMEQYeMU//HXQ7v/1sexVpKdmuR0Zh5mAj/Qxhr8mbqJ
	IyjGTU8Ur2TXxkckvdC74QFdyQiz8IIIM7ZjnIzW5SUelYNmVAFbn/ozJ4VIEGidCqbq0w
	dkcXoViDWvi9yZzF5JaBJbZco6ozSEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-5EVosXT9OqmhdQNqCEzJTw-1; Thu, 07 May 2026 18:23:29 -0400
X-MC-Unique: 5EVosXT9OqmhdQNqCEzJTw-1
X-Mimecast-MFC-AGG-ID: 5EVosXT9OqmhdQNqCEzJTw_1778192607
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44696b11265so1391307f8f.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192607; x=1778797407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhmJzOluo2YbyCNWY9nO19Tj7FrnfhHS9n0nNp+gIQc=;
        b=Dx0EmcrhpMU4cLwRQAoX6gtBaKRVAQ+uMleNAFzACpjPdeFBI0bOYNZGDwUKRw2Jfl
         4LX7/CExwu1E+9x5UZ0exD/seYXvrsTEJNV7TIhU5LAV50GadwW312ado7yOWqSWhg/8
         nzGJelNk9mbnKL2LWHZ1IF55Njzu4sCkmcIz0iQR/dpNMrUsQj5chzcgcNh54rR+FwMI
         c3bkLw8X6rRMD6cPX1z1zdBPDXsTR5NJUSxR70e0qbtdTnTDNzfyPkHxxCHhGVvB2Xq/
         bmoxXpZ1aPpVb4X+qPcmzM1zDaN9qOBTvI31Qz+kt3vRyLGy3Tatjg4XfwxjOb2+HcnL
         /Yow==
X-Forwarded-Encrypted: i=1; AFNElJ9u7Sio5dEOfYAAq+jCwYTZHAkRKLbNiVsuW3HVv5jvkgQ4sduphkwV9dBB1U9aE1nx/C434SeMNI/apxG/gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/PbHl2ZRbEvBJb7iIJLPDn8kAdqtXeQ/85ms4/K5HWuadBdWJ
	RCM1hNI+O2LSlyesstmwqhnOM7KkyoJsUGkJ8OkE6VLLAczN7OcEEPK3zk5y6dUIzX+jS/XVaN8
	+8vLmsZfwnnnkOyMSzt3izf2ZLK2buHoDDQCnbqwjITKBOI0WmguYZ8L3GTiRVwQ2VeHr
X-Gm-Gg: Acq92OGpzxLZAIHGdmXqxz700gcPfzDIUNjc+xC/xnWvTlG8fpyKex29VGmJCcWjRCR
	bjSTToZI3rVwg4I8XMxujiBzUJ5kbiUuyvBo7q5aaDiFZ/WD1CBmP7aMoZFk/LOpYG1W84Dqq54
	7ULTvOB3fUUVh3XuH49TqoVoU52B2usradoXulu1Gxqbr9wTZWsx2ZK2DMzitDZR8B4Q9lEQl36
	IBfhmfI8jfNftY00FA19AiqyJrmZt4o24KLaLpH8+kBWt5spREvFb7FsudKapXq6vtQyc/pbEnS
	INavgUYdVkJYRcwS/6VrTjOEXkbiqIO39F/n4FHyHvVPtclnwn7wNveFtw8RaF/VRdPWeOHQ30S
	nwW2JjxBTLP2tMrTAYEUCayGlVaTAl7902DQgvrMZ
X-Received: by 2002:a05:6000:4211:b0:43f:e99a:ff91 with SMTP id ffacd0b85a97d-4515b057368mr16166100f8f.4.1778192606968;
        Thu, 07 May 2026 15:23:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4211:b0:43f:e99a:ff91 with SMTP id ffacd0b85a97d-4515b057368mr16166067f8f.4.1778192606385;
        Thu, 07 May 2026 15:23:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412cefd38sm2251262f8f.9.2026.05.07.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:26 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v5 20/28] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <84a052f6bb0b0e286e9bd0f640e4f7269b1921c4.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CbGcL2_9K4aJ-TwRb6Bs5jBM3KDjlloKevEw_6NKfRQ_1778192607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Submit each reported page as a separate virtqueue buffer instead
of one buffer with an sg list of all pages. This avoids indirect
descriptor allocation (kmalloc in the reporting path) and gives
per-page used length feedback from the device.

On error, the already-queued pages are kicked and drained
before the error is returned. The caller (page_reporting_drain)
then marks the batch as unreported, which is conservative
but correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 36 +++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7ed024315539..e99ffbbdd2bd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,25 +202,35 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int i, err;
 
 	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
+	for (i = 0; i < nents; i++) {
+		struct scatterlist one;
 
-	/*
-	 * In the extremely unlikely case that something has occurred and we
-	 * are able to trigger an error we will simply display a warning
-	 * and exit without actually processing the pages.
-	 */
-	if (WARN_ON_ONCE(err))
-		return err;
+		sg_init_table(&one, 1);
+		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
+			    sg[i].offset);
+		err = virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
+		if (WARN_ON_ONCE(err)) {
+			nents = i;
+			break;
+		}
+	}
 
-	virtqueue_kick(vq);
+	if (nents) {
+		virtqueue_kick(vq);
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+		/* When host has read buffer, this completes via balloon_ack */
+		for (i = 0; i < nents; i++) {
+			unsigned int unused;
 
-	return 0;
+			wait_event(vb->acked,
+				   virtqueue_get_buf(vq, &unused));
+		}
+	}
+
+	return err;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
-- 
MST

