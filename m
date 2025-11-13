Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A6334395
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026492; cv=none; b=RNoSJV01j8Vp9OgytcE2gAyQEcDdfQP0+csCSBVd9JWPSSehO8FqDiDx4HDlwBa0bOhyM9GDuOioZlDY93bNgaN4txACgq8vqL96gEtoLhsFACYd0T9oz19wfeQ0wJGQdTBIioU0Buvn75VvKrnTXwXQhEf0Xd0rEWi81W184CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026492; c=relaxed/simple;
	bh=S8gYLmvc/Q/yblUy9qjW/klwunvJSVCih43kuC1flV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OnOnU+t/PIs0BJIIftwyeSk1SKy3n7bHEbn0SKju/BTYjcdzt9szz4zBM7XtrwQDs7WY+Eak7EaZIt53tyxnBeTr7NKnPZajKDNOaZFICJvHbIGSPqVEppHe3XfffKGPc2Px+PES8Lc6+kiZOXKQG+4QJP/FBJx+l0ptqrPpOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chCJS7L8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chCJS7L8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUTTnvYQgb1XUViqIygb3agldGtgy/h7adkhliwQCV8=;
	b=chCJS7L8kC8TtxiuhA7uvlJdkw5MJNa9ZSz/z2hdJHhujltV73Le6yHnw0OTJ/DI0savMS
	b1XCIPWH4qEQBM4dd8UlmDMc6fGMsXjxAJtgphh0xBE3y7ehAdxf04nzzntlIdDFbfXVnk
	G0blUTbXP7xFj3aWs3mm2eL9hNiBIMc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-sd_XQL_ePLyAH8mA7XZAsQ-1; Thu, 13 Nov 2025 04:34:49 -0500
X-MC-Unique: sd_XQL_ePLyAH8mA7XZAsQ-1
X-Mimecast-MFC-AGG-ID: sd_XQL_ePLyAH8mA7XZAsQ_1763026488
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so4744195e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026488; x=1763631288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUTTnvYQgb1XUViqIygb3agldGtgy/h7adkhliwQCV8=;
        b=KdmaFFRJ5Sglz78TCnOlO3J93NUhbCbuJPLLsAcXDJsS3RJ/76G/aObZIq0lqStjWE
         0Rbli9/tMaQRRMMyBa9QGBaRXz5V532632PehFveZwph9k+VW2ZMZU2CxiS/O7HAtqtF
         NVVLcoXFKJ508OZd5OMKTpxspAB7pgKlYhgt2UbV9I2U76HigUXz/wWm4RSsa99oVOTS
         +fAHLZ4CfQq6Iqufkjb/QMxcdtBiSxdrilNgPRPpptHP7Y/QoHFDFCtIl7SnRQcW2N+D
         N5U1qUgr4DgeAApMAdYfCmKjUb53OKDPoEr448SToG9HNKSwBovGrNw7xhv9Ein95u3x
         Clyg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+MF5lmaXtKl1E/GrI86vaK4qkp5YkYNmktlOwaSErV/fe26DBOE3gbmYQfw5x1APzP4cwnJ4TcDUuzv+Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytMZaflgU1th+nks8olsTCR9dw+/wIG+PYX3ty7sgtS5+IUkno
	lbrrq2fCz/DADEP3cI/PvcpL035lw4ZY6BVeODfl2Y2DprdjY64NWUHoOZPlxzAuJJDUqT6RKzI
	bppogSAHBMSTValBsZV3+G9UBzFRU6c2vnJYapz4W1fJW6lnVxQq3PPZeQVbyK4vOoE35
X-Gm-Gg: ASbGncvzhTSjadNKEkzN8//GzJDvcdSsbqueAC3hkezW46SKepr53nTAHfkLa3dS90o
	sHXCxrIys9TfLwURnu1fhQ7r6Rl2Bm/hFtDpgEFf24Jk0d9Dp8kTYY1KjugI7ZpyV4BE5SbkTdc
	bCq978bDOPxuMvLXA79rusRq9LDdQ9GDsOc5P7uPceB5c6ns1/v0zowdaFIWa4xAxnGg8QyI9Qi
	wWXYjazN8Yiz/X9EM9TqF2JUgw7ZMmQjNvlDGVLotri4j9Id1mebcLgrIJ7bR2q3NCg9oaEeQMo
	JwJxDnTRcifTF0wX5HXTKOZo+SN0zRMyxZiTKWaC6pOhgboghk3Em1jI2CxhhIFcclBZjvhkZYR
	mNGPkL2r27a/8Qez66CE=
X-Received: by 2002:a05:600c:4695:b0:477:7737:5652 with SMTP id 5b1f17b1804b1-4778708e277mr52156855e9.20.1763026487675;
        Thu, 13 Nov 2025 01:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKBrYwFSU0SavZSQ3g8QVdoUiCVlvcnTMxvHwgjRjgdqSpBYRq4SNYNmIIu9mrYUf+MxT+zw==
X-Received: by 2002:a05:600c:4695:b0:477:7737:5652 with SMTP id 5b1f17b1804b1-4778708e277mr52156445e9.20.1763026487144;
        Thu, 13 Nov 2025 01:34:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm77800235e9.11.2025.11.13.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:46 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH 6/8] virtio: fix virtqueue_set_affinity() docs
Message-ID: <e317e91bd43b070e5eaec0ebbe60c5749d02e2dd.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lm6gOPwAe6vvf5wo4SJs3nB3msNLShruWVHtg7q0lQ4_1763026488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rewrite the comment for better grammar and clarity.

Fixes: 75a0a52be3c2 ("virtio: introduce an API to set affinity for a virtqueue")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e231147ff92d..1a019a1f168d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -384,7 +384,7 @@ const char *virtio_bus_name(struct virtio_device *vdev)
  * @vq: the virtqueue
  * @cpu_mask: the cpu mask
  *
- * Pay attention the function are best-effort: the affinity hint may not be set
+ * Note that this function is best-effort: the affinity hint may not be set
  * due to config support, irq type and sharing.
  *
  */
-- 
MST

