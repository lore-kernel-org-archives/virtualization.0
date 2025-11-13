Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F402325708
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026490; cv=none; b=ZAb6JdBVxheVunZUZuAWVTLoDqXi+o2CfzTgDhXX6m6IKfKsgc2ARvORZRiEy5qHMpKFqlfaYuy3i+LCDCXWOm8eQcHFcRXAx/9LhIpoSJ2Nw1HtIiG8WpfZrgnnNZai3x7sDfVI4prMaxjVNQonO14e7puLw7CyD6Dfb2v7XHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026490; c=relaxed/simple;
	bh=X2MHxzmOtiIQ8ZjSTogxws8F4QugGtz4XXzmDlmK5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=niurQip7qZpNY023bTnxFH9bNM3hZZDKGWBb0E7c8pt1L838vaMmD8i7RrFUmpVyXY111Buys/r3at7xatY91kOz6WHBqboLksFCHgUG/P+xj2bpCmS/ls07xGcG/nEzMcNOs8jGKG44aUmCIzh9oY7Io8JWh0ttfS0YAelqGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCU0p4GY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCU0p4GY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlOSk77TvYr08CPHtBLqV/3i17PN69Yk5p/etd8KwsA=;
	b=CCU0p4GYAhX82voZLcmHBa3H3pCYp8QJL/Sj9ViV3ZZW0hjN/eS4scf0QrSB863cIQT7Ix
	hDcehuLGFrjXZZcVEtz+XB2itjDP5WUXuNuQHSOVSJNk9oql6OCJ7I3Ig993AMGGNo2Hvf
	+RxV2btbyRYqQaCaTh+yOx1SHKWKcc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-A9Mk-xvuPPK_OAy2kmc0Zw-1; Thu, 13 Nov 2025 04:34:44 -0500
X-MC-Unique: A9Mk-xvuPPK_OAy2kmc0Zw-1
X-Mimecast-MFC-AGG-ID: A9Mk-xvuPPK_OAy2kmc0Zw_1763026484
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cbd8299cso317130f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026483; x=1763631283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlOSk77TvYr08CPHtBLqV/3i17PN69Yk5p/etd8KwsA=;
        b=HQRaK5zF9a8sLUk/b9xm36DNolxQHQLvdBjelgUtzeBA6bXxhWT83v4TIWkoVy4VS/
         1YBNS6oB6H0aIdsP+ZmRFHDKFaES69lzv7zfbAqDx2Jy6GRI3mPMkE0yeEa2JpxkBaUb
         jBSyIkCGvQdSdStcVmt9JvZtjqgvjFPae9F6ICVlb0JS7QnV/CN+8E/oKSbIEyZeeyx9
         VG77mX6hZ48+X+74MsOQdOQAVa2DAhkKkptEkzSTN4tzYXIpz+z+GbmpewCa+h4xyi80
         QsBafqRyR/ywZ0YkAllKvNTp1CsI+nrOrnvSGq8yW6EPkkavtD3ywIhG1SeYKXrF/cqp
         hxJw==
X-Forwarded-Encrypted: i=1; AJvYcCU4mF1/YAJjrsN6FsuH1AeAMjt0aIVr3maLrtp172lqzKuxb6MpYoCeVo/KsUe5u4791UzMpLiqxfCLjT4llQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAT/CYWJOYDJLQPOYDKcbzqLeccFHQZLuB3GhtEg0OVeZhzIVu
	eZE9I6OBQABlppAe7Yxb3FTY/DteOvqBZI7D0gFOVcE5+FMWEsazctwWy8Id0vMW0/wXq1TRM0T
	xT6AtRd/4QVnDK2wMY1CrWAc3qGPpJnxJjDPji1RUoVogtcbr9TfkQdA3oLIytYsdrOnm
X-Gm-Gg: ASbGnctNfvpNEcoTEXMMMEi9ggnH96HDwg07A890CZy+nbhid1a7Lmwq2BST149+gNU
	nHQixNWC0CRsJssjFZdOiCESnu8ze2utvj1s06KWWRHd/4rgYAiiPbrc+l2VAGoWJSzgHNCH+fg
	wmnYwewBpZR+iJuvJ6bzuj2TeOkox3L/R6dAI9IAetEZnJBmIaDgtb2ChIMZzM+do20c5F/BBiw
	8bbA6xoHefqoaxELFXMFSWfyXq0uiNLFVTbdEC3CrcgANhr1u6IiRg17BZrPByYTIaOcHXSj21J
	mQGlk2oSOKnHOzxksRKqL3MBTpbjCxpM5i/0o4A8ciiJ19ifrvksLL8wEnb+zqFcFqEogrNGdez
	XJ/ToGtCfjiL1+oa+wes=
X-Received: by 2002:a05:6000:420e:b0:42b:43cc:982f with SMTP id ffacd0b85a97d-42b4bdb0267mr5749986f8f.39.1763026483475;
        Thu, 13 Nov 2025 01:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtNW2d1OKL8QSOQbEcnkG/4WCI8nXAHj83lbgVXftVz3WJ6bAWcET3xmzjhJXnDc6RTdgBxQ==
X-Received: by 2002:a05:6000:420e:b0:42b:43cc:982f with SMTP id ffacd0b85a97d-42b4bdb0267mr5749954f8f.39.1763026483069;
        Thu, 13 Nov 2025 01:34:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm2918118f8f.18.2025.11.13.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:42 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 5/8] virtio: standardize Returns documentation style
Message-ID: <c262893fa21f4b1265147ef864574a9bd173348f.1763026134.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: k8o5vH7tSFG2HT3utj1CgERwaC1zZKWMZNybZO48hHY_1763026484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove colons after "Returns" in virtio_map_ops function
documentation - both to avoid triggering an htmldoc warning
and for consistency with virtio_config_ops.

This affects map_page, alloc, need_sync, and max_mapping_size.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6660132258d4..e231147ff92d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -150,7 +150,7 @@ struct virtio_config_ops {
  *      size: the buffer size
  *      dir: mapping direction
  *      attrs: mapping attributes
- *      Returns: the mapped address
+ *      Returns the mapped address
  * @unmap_page: unmap a buffer from the device
  *      map: device specific mapping map
  *      map_handle: the mapped address
@@ -172,7 +172,7 @@ struct virtio_config_ops {
  *      size: the size of the buffer
  *      map_handle: the mapping address to sync
  *      gfp: allocation flag (GFP_XXX)
- *      Returns: virtual address of the allocated buffer
+ *      Returns virtual address of the allocated buffer
  * @free: free a coherent buffer mapping
  *      map: metadata for performing mapping
  *      size: the size of the buffer
@@ -182,13 +182,13 @@ struct virtio_config_ops {
  * @need_sync: if the buffer needs synchronization
  *      map: metadata for performing mapping
  *      map_handle: the mapped address
- *      Returns: whether the buffer needs synchronization
+ *      Returns whether the buffer needs synchronization
  * @mapping_error: if the mapping address is error
  *      map: metadata for performing mapping
  *      map_handle: the mapped address
  * @max_mapping_size: get the maximum buffer size that can be mapped
  *      map: metadata for performing mapping
- *      Returns: the maximum buffer size that can be mapped
+ *      Returns the maximum buffer size that can be mapped
  */
 struct virtio_map_ops {
 	dma_addr_t (*map_page)(union virtio_map map, struct page *page,
-- 
MST

