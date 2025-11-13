Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A033439D
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026495; cv=none; b=k58pReZ0KJD7QDeg+CaJvCaCF0ZpSsELvUGANMm7X10udviVLnRZz1de6PYbQ1vjHQdS7R8mjld46fqenBsgfVg9Kwz3c+9qoFHqxoE8yt2mnkdJIgfeQO3v2ps+EayYPRBx+ZVgYWe69tNgWDG2cbkGryusZYyZMjn+VfTUxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026495; c=relaxed/simple;
	bh=z60GwjST/zk2QDD1x+EuW4UyxC9I2dr3siMbe0rHDgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lD+wqWRalv19qDbXYvei//anVaQDNlHlnKfvxvgH8HkGQzV+Q/qIwDuOTrQahd7Fel3cuwDSvsuiac2DXBLldTCPQMX/s8LUc1e5m3OMiEH/71jExew20Q1FOSbRrAElbklE6YqAow/XKF1FQ5JaRO64AVlFHzjXzucHfgrvkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXspHzEG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXspHzEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MHG/qGEvEaekFDzpsq1W609jrOgnKzRH1nvgnjyO4=;
	b=hXspHzEGPP4J8xazOC5b/dai4dym5GYKBl0Db+EWgIC/XDhZW8Vy8hpe9/+gLSzoKxNGdg
	I2y3rRTnrarZ3SqXyu0aAFNA5EPSKsC0QL9l5MLKI575JZKYtPqxBeszH2py/bfP/nDMCk
	pssHEuaF6Ew8+PXmvszmAQ29lrvHQLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-8z_gBJ38Nh6Y-pPnaDlE-g-1; Thu, 13 Nov 2025 04:34:51 -0500
X-MC-Unique: 8z_gBJ38Nh6Y-pPnaDlE-g-1
X-Mimecast-MFC-AGG-ID: 8z_gBJ38Nh6Y-pPnaDlE-g_1763026490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477792eb8e4so4521345e9.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026490; x=1763631290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+MHG/qGEvEaekFDzpsq1W609jrOgnKzRH1nvgnjyO4=;
        b=dGPHr2ci9ctvIsFRXuNMd5qEigpIJ23p/hKxXC1L6FN/eoIt/Tt8ctR7EVz4Y/BOzt
         kpNyCLktDqCei8ico5/m4KHKLnsvksFzcn5U0EsmUFWC7uTdUDY+p1GsKTwV1Bw/VFkn
         5RJ7MDG0DcxYg50ZkanGZaTqX5gEvIopgGc0zYcKW2UO9tMzoNIVOLR1yFSz9KW7K8nO
         g6gBroQzPBHmF8AZnQUPCd8+X/WuZm7i1mTGKrDdcr68foQ2S3EtPuzeud2ThWOdKnk4
         UXpqd0Q7GrRh6VHPoLsth09oNiZlQkhh+cqM7zYzjAbbEvT0+hMkHa6a2JxCgis/0hwl
         5IcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpsgRjzyyTqks/mwZfAIYM+lGA1QnWZfMMQuL0+uiCz+urz5spC0EefpR2rqlvalSF6MwDu+Fv7EQI+V6moA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3WsyoVVkNziefyz1duSaLlNvOKppEZ4muuGJkwFYFo6knYayv
	GYOfmUw1gnO6kkYgAafugVvGOQISlzbteJTjDW3DtWNqGf3GNbdRh/cewboAW5E3ymqRKRyuLmP
	veZP4zNVfPGd8fkdIrh5u0np0+f06yrps/wbcFUFCVtyom3EzR1E/wCikzF+/tYfI2GDZ
X-Gm-Gg: ASbGncuHkrTPsOEhKwpPgPYOGjtV2EDBRrbxF35eNv5+NQyOLjJaQb7oqt2uoB3CUeQ
	Qb6kYfnnlk6OR6cSLhRdbPOqv84e5CgVqciqmOzWiol0qxbhzDDBiDXfXsRNAtdRsLKuJh9fU/P
	/74pKetuulcY1S7DOS3U4cR4t2EqcgCA7PO7RtKXdaMfjFWuC/eHCMuE+cWxkmgcud8scw5eTZ5
	lwa5LLvoxMc9oMpXrJzr3bGNXfu/4WSrEHLLYoDxMG2aW05gmH4/jhnnc1gWopk3iPs2apQzuYj
	UI51dLW+NwPzSxkrRGNXRSzxsuu/q4RnjCmIGZeFTqEf9Yvon3s/xwCLMTW4szZriXggCBJ7+38
	nNpfsv6SxHOnhdgdSkfA=
X-Received: by 2002:a05:600c:19ca:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-4778bd833a8mr22275855e9.20.1763026489969;
        Thu, 13 Nov 2025 01:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi5BxNgVBwbH2dS2CfdV6ze2yR3gC4sODjJo0GZI3/5JNMQyx7RCd4MzGrjukOIyKetZ5ITw==
X-Received: by 2002:a05:600c:19ca:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-4778bd833a8mr22275535e9.20.1763026489584;
        Thu, 13 Nov 2025 01:34:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm81404125e9.1.2025.11.13.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:48 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 7/8] virtio_ring: fix htmldoc warnings
Message-ID: <975dd9115d8160e8a17a4adc6ae39d05b3cff037.1763026134.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: M0NEG1TwcMhpsMf5yBEyie28nJvFwe0iQ3gRi5HJb60_1763026490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We get:
  drivers/virtio/virtio_ring.c:3174 - Missing parameter description for vaddr in virtqueue_map_free_coherent()
  drivers/virtio/virtio_ring.c:3308 - Documentation mismatch: expecting prototype for virtqueue_mapping_error() but the actual

Fix these.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..1b32aa38d26e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: virtual address of the buffer
  * @map_handle: the mapped address that needs to be freed
  *
  */
@@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
-- 
MST

