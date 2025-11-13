Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC22332ED0
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026488; cv=none; b=nUku6L+KfVUKATwyskrca0U9bHwp/McFxLBJHIrK+gm1yyONJAVkxLWt/t5Pgv/wmoLVowmJKqAOIFLhkNV8OMBaK23UiovfKeddqUUTYvkiLqIgcCJ4/yInZ6hhxnWDEHsetoUZWAESURA41PcbvX45q6F8jKHEVPR+MOHTDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026488; c=relaxed/simple;
	bh=xfR1KLx+KNaQL4dbz8fvBPF4m749K6io0Z6FCilb3Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gjz2VN82t+luXoprKKoBwKy2VoTxEL7jutXu45v9xZnmZ7B2zXFeTYFkIIgrOeK5SOz9503Bx42NIQr4FKyYMcuX8r8wWfN8EDP+lt4PW+/CZ48q9iTMqBt+Xz9in5lmtCf3rn7P46FCwB6cz5gccr8fLTLiuLrqji+3tYbQDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIcOrW7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIcOrW7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=63W4XiiwxwFoFYtLR/OQ3ZfVXapccbvLIf45BvuiCEM=;
	b=DIcOrW7mxXyPdUy0C7byeNpuDXZkIMRuz9CFGQHF0GieoU8FxdAMz4DZhSWRZmILDEQhsu
	9XPvkZYRvwQ+HfR8+soMZ55st2zZEwd9LDc8f5ioAJvD5o07I7FyemVBxMOIbzVGK1Y+xq
	zoE1gMIiNE4YQgLPMZCnCGFKt76TlBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ZCof3xmvO5W2cNpug5T5ZA-1; Thu, 13 Nov 2025 04:34:42 -0500
X-MC-Unique: ZCof3xmvO5W2cNpug5T5ZA-1
X-Mimecast-MFC-AGG-ID: ZCof3xmvO5W2cNpug5T5ZA_1763026481
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475dabb63f2so2878755e9.3
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026481; x=1763631281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63W4XiiwxwFoFYtLR/OQ3ZfVXapccbvLIf45BvuiCEM=;
        b=lrVqcOQ5uSq5RpZE5q4Oiifl+vhr5kkDlXI21YA2EVyGfUJw1irf2pDhzC0J2wg9ZZ
         +BJUgWoStEkf8iatNPyFut0ZeyREecCrTwpcNKKRRRQu16H4Uz4K3AbJCtNFV8D4YPT7
         2/2uH+uVijreJWNmelOii1xoKGFie1LnlApuK+qeTM3sNoQEjCzU2dOH9vursbELlmrP
         elqhFwE8YxI5Fzjkt/99LtsjEwnQKOM4260y44l4US4yzqJqVuVHEj6KakNA+Q3xjp8C
         XhilEcvIl5v4FUPMwmJQKcISOA3Y2FDK10tVi2KhXhrWH1X4ryHiSSnP+bc3Nz9aw2ek
         F9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2LiUI8jg4Q593u4drQcgn7bVfaLaikfNL1GiU9uh2hq+0CRhLBY73hHl7tDLuTstG34jIHzIKOVCL8fkbBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf7idrdoAW0WA0zrP9R4V4hi9gngv14Jw73bf68X1HazfeL4zE
	HUCK1+vKH5YILbTumDLVNXQhVEmQagVO8iub7TdmrOX/ItkushAvtWGVNxMmz6tB4i0L9TIN+Lt
	Rg8x8PlInFcsioJ4G+T0VY1eHLTFJtxEm5PkgurF3WoOIcnw2jUiQW4ATfP4IASuesuxB
X-Gm-Gg: ASbGncsAcPV13PJ1CDYo/2CkUtnPcTxjRW27u+uH8LS2Ldc7mLRDLa+W6HSoNCTmCNd
	8ZPNlzsXgdSH7Xs1jlADk8lJWYzsgMNYo90Y+miu8Qf+M1YDpGpgewSfaUw78XzLJgA4XTudMsH
	2JqxAkSYx9sBpOB2cz8DOJKDrV5k9xFCJnjbcso9EVabRvNGw1D7Hj+LmtQhD5ROnWcD+/wUHx6
	ficjtaNx3gZqHS+mA3TJDwaMRhaPptkA54mrpv2b2MqHqQPwE/36clFNmjaqRwLkGeDJQ4/IlTm
	hk//LJm4kBxA9tFgsvfgZFIZELd/vPE9mNj3cPgA6DLwBarxLDgGvgtzSSNiWaZ2Od6P9W6CSQB
	tJQmhRwtWnskInphRSb8=
X-Received: by 2002:a05:600c:3b17:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4778704d781mr55602305e9.15.1763026481274;
        Thu, 13 Nov 2025 01:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnyqEDIQmdib5/zX3gGR4BSqFJnDRLq0SIXwuP735KDm2HXcgCzc9KXTW9ExR3VdSFpKkrcw==
X-Received: by 2002:a05:600c:3b17:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4778704d781mr55602015e9.15.1763026480857;
        Thu, 13 Nov 2025 01:34:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd08bbasm16670505e9.2.2025.11.13.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:40 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 4/8] virtio: fix grammar in virtio_map_ops docs
Message-ID: <3f7bcae5a984f14b72e67e82572b110acb06fa7e.1763026134.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IWVTyuXX_kmlIZq3bu79WW5a0Q0iA2dL-TiRHSNAn_4_1763026481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix grammar issues in the virtio_map_ops docs:
- missing article before "transport"
- "implements" -> "implement" to match subject

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 78cf4119f567..6660132258d4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -141,8 +141,8 @@ struct virtio_config_ops {
 
 /**
  * struct virtio_map_ops - operations for mapping buffer for a virtio device
- * Note: For transport that has its own mapping logic it must
- * implements all of the operations
+ * Note: For a transport that has its own mapping logic it must
+ * implement all of the operations
  * @map_page: map a buffer to the device
  *      map: metadata for performing mapping
  *      page: the page that will be mapped by the device
-- 
MST

