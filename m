Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33345328B42
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601412; cv=none; b=BJHcu3YgjtUGR79kjoILf1a+HGY7FwAyXFJT5gPnG76X2bauwlk+1hwISsI4A1ESMjE7h4tQzIa+x/sKkEl2UcktU0OGOaJ9F4ouTN9Cr3aq41GXsUD04sA3YqYC3WYz9vWUV/Wo9hZNko5Se4eIfukoQLg94FNHTJe47puVsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601412; c=relaxed/simple;
	bh=m98JsLLlZnpLuynLg3Syt9uCZ7QvI0/Lv10M2IDOLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SUkpRXRYNLhGW78w8c9l880nngdZWRg2qOjsvNoY+CQsUDwyjNDOgUIwJiKXPo5f6BbzX4JnkScKxkVsx4FAKBv41DeLkHImWDflUMIpPyCT7t3/Kmepj07yaohU8oI+5aMU4JVkJXdqgeaRe0UQy4R8HUGDA+eahvzsRn4yx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3qbNY6g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3qbNY6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
	b=c3qbNY6gHZd3XSkps9gVu1mxH3rwcXq9axuYl9TpWmG1XNvEQM55NTpu5G+kWpGfdDy9Ci
	suD2bEZyxiTUwHYFGl4OA5kMZU59qLptJq/OoW1VuXlcLeZUZ7wwzHxQNY8CFPIXCZzjQl
	9u5nCqJou5ckvee78omuk3f/0MnjcYE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-AHTP0CPVPvu9LdTI1u_09A-1; Mon, 05 Jan 2026 03:23:29 -0500
X-MC-Unique: AHTP0CPVPvu9LdTI1u_09A-1
X-Mimecast-MFC-AGG-ID: AHTP0CPVPvu9LdTI1u_09A_1767601408
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso146967965e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601408; x=1768206208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
        b=ZTBpEwn5mbRzUyw+trmvUK8/mbNoXeQ2R8sl4ZNMW/V/CHOg1AZd3DHNwJFSHA/sSR
         afGKWMmKHfy3LLwVI13UX0KTRpXmMvZwKARXZ+OWXYWTBHEAsNVmXCy0LFUh2DidysuP
         2ZJIaTQfJktt/RI78Pe2qFfnsoU5wnlMcvAVvUOgHggSZfw8g2AvqLwGVnc6oR0+cKu2
         6i7K8RHK2ISAcRxnLZ89i9rznbrsqVHtPnJpUHU88hWaY1en/5EiuV1r5SKnKIM9QiXF
         +utPqSEv9Pv0gWULLRvXbGiuTj9PHFghSyhyTU7Pa+l/3mmEukaIjNfHcfwUmC1lROYC
         fbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzfxKiCgmVgLwnmAny02mytWnkwH5ueKimNQxsIOKz0UB3P958yWF2CPKFDvOHQzSMavkMHsleUV/xA2NIdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtwZRWN11RLon1IHO5hKq4LG4rQxbAmEdKTXyIivVBRvCp8qV4
	4xZY//HI8uOCw0kKwjqqwe8aBYkfAWwZzlfZBnj+ibArvhxEhqhU8JmBMSCyd6ns2b6C0sO67y+
	UrvlEFCW0FwKGAqNKUUWzrrs0Pz2OyAkr4HVoF4mMTDcWbSKDE4W5ZzVXzLBxpNa/Pzgh
X-Gm-Gg: AY/fxX6ETngS46sGDfE+Z9K3s4hsB0IQAAttcu5L+L1Xlf1sjiIndbd0B8lHpKLajtq
	FU0LdO/8EM/RlzsDvvkI0Rsqd/Tb8Nnvztww0CQOyYB9f/Zzn+cPGQV+o8cWkkJV0BqERe+r08/
	nxkwyPVjIEJwA2sgNOrkRCUK5vU1lJpPilcLxtdbsMTIuoTBNjQJZKVUgTcyR3DbN4F+FPF8KLX
	f7+TcJnyQ943z7LBLlIQlTjDM8fHFSTJ1S7XeDw6obT5pMSgg+znj/3aIOY7ko28xlF7LPItjYM
	vp+O2Cn0zF7aDk8T9K5rPwywAKfq6KnjNh0i9Xrut1SuWGcghipYx3WKvSeGfRuZpigSreLLwvM
	xOBsSDmgjJiUSl41KbWzvsyWlo0Bmpbr1Sg==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168645e9.16.1767601405667;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv7DIcbBq1VkvqQ23EJm44n2GxyGgRTRuTvRGBj8avn63Zc8/z+R9wImAFB24DC8Gpann5cw==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168065e9.16.1767601405201;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6c08f56dsm51171265e9.9.2026.01.05.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:24 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:21 -0500
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
Subject: [PATCH v2 08/15] vsock/virtio: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tXo7WeV9V1J_rsaEgLxEmFjU33Vg8z_OW3v7YMjS21k_1767601408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The event_list array contains 8 small (4-byte) events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

The previous patch isolated event_list in its own cache lines
so the warnings are spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these fields, suppressing the warnings.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index bb94baadfd8b..ef983c36cb66 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -392,7 +392,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 
 	sg_init_one(&sg, event, sizeof(*event));
 
-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
 }
 
 /* event_lock must be held */
-- 
MST

