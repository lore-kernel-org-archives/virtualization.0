Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179624A067
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903353; cv=none; b=gQ1vM8FGGgGwRB28IlCrtAtCSU9HbnZ8iqyYEvqNBmQ33UmGUxSkS/97ieZ4l2XezCfn7C1NfIzlQAZDQNnLOCDIHSfuX8F7bG5jHcqh8ahD+jKTwuEfoWmeHMGfH//qmiHprwBZ69qiw3oiQuaDdGHy75jZWEeSfpkdqluEZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903353; c=relaxed/simple;
	bh=de5+oDDVsgvGv8gkgdX1kmDXXsYWScA7Vf9sIiPm1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iWWvpmm9I9gdq+BI7wPqMwsIXcZto+0jLDIBGKQ82FWyKaTxkufINPgeOjKk6sb1Mrovyk7dKKaOiR68qvYNkvgzXoKW+ngFru6TqmKsKf6ruAfs3z4vHJI9RVWvzaGu6N9FTwfLe5qmvicEnrWjv794IjLUZ8nKK8ZBA1MgOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hj/NhLVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj/NhLVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758903351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
	b=Hj/NhLVB1E5ZWq1MSO5Kd2FCgb8bHixvp7xSM1oJ2uUobqMm4BoR619/bK5f65yr54GTCD
	SPACY/+dsS9XypFrGdVrKfLfxlT5RW+2DBQ7qzb/wXa/RNUqvEJEmnFRdEZC1SYEsVrZrV
	M+ewdbIZgCv76H0vxhN/It5AMzprfkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-J-PEPx74NrKQGjTozlJclQ-1; Fri, 26 Sep 2025 12:15:49 -0400
X-MC-Unique: J-PEPx74NrKQGjTozlJclQ-1
X-Mimecast-MFC-AGG-ID: J-PEPx74NrKQGjTozlJclQ_1758903348
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e31191379so15549235e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903347; x=1759508147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1MsLjQnmPTfFCIHbux9eMDbdADdPspQOJNP4rI8N8o=;
        b=t5ZyKIaj0JnnXy4uypbKQSFhCIAfssOAe/4BJgBrrq9lAF5cC0qOfH2jmMZQoimAmz
         8GOFOfdPy43xbEVjQL4980qq0swhg7SWf1Hov/ObS6BCuw5PfTk3SDT8hwmp0JSjyDJd
         Macqq7lN8Fm5SBymmacBcZzNvFCq4Yqi3mm/entwRH17GsIEmOGMGugFdK2aMHLcHvey
         VOalDG7Rvx4j9fNlzHhiKWxtJHredytNwX6swGLIUcMDdzWwi4YoBZUnXJjuFSjTZZe/
         FFW41NWscoNNpSrKGrT6pmL89mC4H88VDOC0bcm6OBunf7fP+l34B9v9DVuxo2Onnv71
         G5DA==
X-Forwarded-Encrypted: i=1; AJvYcCVB2q5LrLZtyt6W96l0hUcDO+BhaGg92OLtWHmedU9EiK0G5mOPd/cUthmiKgv/HgWco5/P7Zwe6JC5UrjK/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXaG0sZPBAoKml0TqOQsiW1SqoX8gco+i6gleCqj8ZCyvzUl72
	p0q29Y9/AuApOXDOJj0HX2crOGmrdLB27JivGHuXc6OJ01he86hBQF2FrhLYH+a07jMF1Y2UxMe
	QNxbOUomjKtaABELqOnAs+1sa18sd6hsWsEjAQoonbLfLlgEgl0WP6gCaQ+nfQyVgKXix
X-Gm-Gg: ASbGncs08sLDby7HqGjOXAdhNaz52kQIK7+WbBcbhnR3L32xF/zvO9aXMWxlUAVMyo9
	cQwcR0mNpW5ExSWn8CqXKc+oaN/dUUBYxHxUxjMlTLGFYaGgERYvcEEt5ewPmvIBUkv1NJaHWTe
	ZvMBdrse1LUcdRagM4Cnd8RNKt50tOcywnRKs7MQs7mita0YEv73p3li0GQ3TqjMv0PQJ4bchrK
	/hHkbf9O5nb9YMxjFwJQG6fdL6A7IBQuKgKELUzTMJaZkagvc4IKNtwDit8vUW77mxN1fyZdod1
	nCDS8tIxNAsCQC+rczEyujH7NTKhOJjmCgiACzS1
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65454985e9.4.1758903347567;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTjqxVm23Seu1emihYmKwo45GTVLo85bMBuuc3NdcYCq5ID+za/F9XBnzGN2W1Z6Hc9IxXiQ==
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e3299a5c0mr65454655e9.4.1758903347022;
        Fri, 26 Sep 2025 09:15:47 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70dcsm78264455e9.23.2025.09.26.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:46 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:15:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>, g@sgarzare-redhat
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Message-ID: <bnsgxged7onwkc4jxxttt6b5yb5ct5xekhybdhcduy75rwwprh@u5o6o3gtgvlj>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a7YirvijPtFVDkngmyHRpET-X2EtmIh5GXq9eRsurRA_1758903348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 16, 2025 at 04:43:46PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and orig_net_mode to the vsock skb and helpers for

Why? (Please try to always add the reason we are doing something in each 
commit to simplify the life of reviewers but also for the future).

It takes a lot of time to understand why we need to store these info for 
each skb.

>getting/setting them.  This is in preparation for adding vsock NS
>support.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>---
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..ea955892488a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
> 	u32 offset;
>+	struct net *net;
>+	enum vsock_net_mode orig_net_mode;
> };

This structure starting to get big and isn't optimized in terms of 
layout. Since it's basically in every packet, should we start thinking 
about optimizing this structure?

Thanks,
Stefano

>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
>+}
>+
>+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
>+}
>+
>+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode orig_net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>

