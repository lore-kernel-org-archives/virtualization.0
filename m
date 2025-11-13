Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799393321DF
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026486; cv=none; b=kbJhTJospU6PUpGwlvHG4R7wGMMGTwWX+iyuUcEpn/VDTBLFTguL7LWDv7nWsMDN2WqMA/dgdJQpZNlFXOmNXxMBNkkFkee7Nuqa36Ly/wL21VKk1XheqkIg7W7HV9IMKBFV2zArbZkouhwihedeQgy+ccauCWo8HSge4bKuGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026486; c=relaxed/simple;
	bh=Xruh3Ywcz1D3n7/nuy4V7sDlr0NblGX/5QKZaGOoVAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lsqvrOigb9fuynY38BSugDki6j4OOHNV33jxRi4E12onotiiMRNOHKQerPHUp46rdA1amAJ597qrWC//DPFMhTAw7eJWXMUwR+RxwhzotIRTuj5W8QBGF5PKNgbUFr4nzDUmfAM1TzuxkrQvjx/H9fOlXZofodwuLNaVfLIA/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ07AnmQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ07AnmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsUUwKWRnkOljoqqPyGEmiTbFEa75LNxpqXQAn8U4is=;
	b=KJ07AnmQzTDSFYXGm5kJIZ3jzH5NcHEYnlznanzex9/zggWDAUZnQdlBUiLsaZqpTYKl7a
	l7WY0A0Kz8T26ojJkpnu9BPWSE/LB1yD8FC5KbMtAn7A4QrT0UYVc/2+Yb2w+p0hqqCu0o
	7b/rT4Xj6bAJPD1DnaCRniUDZKlsb/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-a8a4PKWhNiK7GdjUFWY2gg-1; Thu, 13 Nov 2025 04:34:40 -0500
X-MC-Unique: a8a4PKWhNiK7GdjUFWY2gg-1
X-Mimecast-MFC-AGG-ID: a8a4PKWhNiK7GdjUFWY2gg_1763026479
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so9950905e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026479; x=1763631279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsUUwKWRnkOljoqqPyGEmiTbFEa75LNxpqXQAn8U4is=;
        b=gSM00PooD92Xeeb7axZ/Mkr5jhZSxXighXyM0RGYrw3aGUnMtk5VmOENdro8r7GOLM
         SxnnL9N4Rfz/AFM9wniZoz8S8BUVFlX4R8/soBiDXGwpVJ72WA5E/MWe8tBnizXUcZ9/
         dx2KxycNQLJUD7l7HVhXJdfOfOMVsJTt7qIINQDgANx4Q58WbxIPs4kDUlgQWCbFHzGi
         9jhPqD5rFjjCInXPI363QcUJkXJB4IpDfeKm9r2OwIh6IozZ+id2pKBrJGVug2Vf4rs2
         aDGfIkBJOPNP6qMgsJbfBEmMOjM3+oJbktrR2xJ63k0QWeloioFofHEiBKNP59uXvYrv
         Fc9w==
X-Forwarded-Encrypted: i=1; AJvYcCWRzd9Y4PRx3PCnvWy0aFEh5RlOvLYqGc4MnneCrwutOAbSWYOT2jaLzMpLuTyk+YFbza5sZqEXSXlD1tGW2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPkyInVbaAUA6WmneoPi2J6JsHLieG8uGCCoRk0xVwyU+sDDts
	iu83+8jti/l1swVNsxhdm61HHr/AZ1NSKY2VfyGySHCtFjzrPwyHwbT9Inf5333K1teUHGXKOw/
	UkToJSjAIH6kaZcrRKK23Cj+lgMD6JN7IMtxcrWlWyiopmSqm/e47P5ppplfg4w/luuO4
X-Gm-Gg: ASbGncsjrInBu0js4k35dE4GDkyly7LZSMtZBrCy8QWjjrwMLbkAvmPkmnJVpTShW4b
	Jo2q3HN4Xqj9onwImB/bMrvEM0PM9mwyESuGWJIBWQuxGVL+gs1UNNn7oZhFnakgZ6RSItT7Lcn
	4lqqtVEV4TcJZsFCP2tDy0TO2W09pDzo04RECYofJVLU6X6YfDrZ2ExYjRMsrFCuwDJ14M1hdBn
	7LTxyBAtcZId7HkPNvRxxAPEJzXfBPxtHkaEA9fRagqsRLBbWch/XUzQEmVjRVpytdi2vRIs+f+
	IxU2/KpPfFFhZE+vSznUY03WOaP1GhpHBO1BqPlS6Nvbs/8dpq7+V2L56jQVSLBwPwOlrF6l/Fv
	3+x9nvzxPxt9maFPWMao=
X-Received: by 2002:a05:600c:8b38:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4778708589emr59187425e9.19.1763026479005;
        Thu, 13 Nov 2025 01:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPII++NrZn4Z+gEqXZEfn9usn07cUnqFaMupGk+enop5M03tCCv41vu4D68di3KuTfwLYyTg==
X-Received: by 2002:a05:600c:8b38:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4778708589emr59187025e9.19.1763026478447;
        Thu, 13 Nov 2025 01:34:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm24629445e9.2.2025.11.13.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:38 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev
Subject: [PATCH 3/8] virtio: fix grammar in virtio_queue_info docs
Message-ID: <a5cf2b92573200bdb1c1927e559d3930d61a4af2.1763026134.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: KGoflam3jR1jIO-qUXYl2Mi8ZqzIAPNAJqqpGpIqjWM_1763026479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix grammar in the description of @ctx

Fixes: c502eb85c34e ("virtio: introduce virtio_queue_info struct and find_vqs_info() config op")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index dbc7eff1f101..78cf4119f567 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -24,7 +24,7 @@ typedef void vq_callback_t(struct virtqueue *);
  *        a virtqueue unused by the driver.
  * @callback: A callback to invoke on a used buffer notification.
  *            NULL for a virtqueue that does not need a callback.
- * @ctx: A flag to indicate to maintain an extra context per virtqueue.
+ * @ctx: whether to maintain an extra context per virtqueue.
  */
 struct virtqueue_info {
 	const char *name;
-- 
MST

