Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CA351FCF
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445860; cv=none; b=vANJVgfZk7Qv2WG4CvQ2b4yYzYe5OA6im/4nqMtmNi/5M5k3VFsCRG4Gm5AJndeVId5HCettdIeGuIQbWR+gHdrhfrxVXhzmzvbDJ2oNMlKwl1Qy9v8Kx29cdl59zFgJbHv5oEToWcO9yi6hrYvVeaX9U9grZ164AmOKKkO49pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445860; c=relaxed/simple;
	bh=GtjRPF6DweArbtHMO2aemgxvXl0n5TLyq2tqJNlhivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l+VE/tXO/c3I11fT171h8pYSpnM4Zc9oZQHjFVXx/1JBECRc9bQ6aY1eRhRoTRgMUny6gWnTXfidCYe4VEMVPpKa1Fc3peqTZraUFTHYPIcFhl8+ynTRGKOWCdujVN41VdOFuh1gdVhbbfA8pAS3/WawoKYDbJMy37Ay2WUD7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiALqfbe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiALqfbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
	b=AiALqfbejqRfbUcqzlhxIVz+vSbPYPqCinjwVeBQwOIqWRWHU8Rla8mUdPf8gJ9IYa1zFs
	2dBJPKhB6OX+N92GUNni6OeVGofp1gFDwqlzc3224WqTuny19VLiMEpR905HAwAYOu5JOs
	yAUKFdaVs5W5BTN3ownOazFu2RoN02A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-GjdnDaLOMoq-YpgfzitYuA-1; Thu, 06 Nov 2025 11:17:35 -0500
X-MC-Unique: GjdnDaLOMoq-YpgfzitYuA-1
X-Mimecast-MFC-AGG-ID: GjdnDaLOMoq-YpgfzitYuA_1762445854
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e39567579so5888605e9.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 08:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445854; x=1763050654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
        b=M3VL0zJJNAiu+gjn1mEYHzxj1FG5tv0JLLBI3DOJ7ZhYI0N+EqIhrynL0Irriyd5Fg
         cnz7SDqarip+Mg2o9UlNDEveuCFV4NgVrRYBd5dwtBm0rjm6nt6GMdUAA+wX4S9XYKfg
         kul2YiTJdg42CgUj4unUWip+NlVT5+GMeedEAUC7oDmqzyQtSbInXeXfIedj7cZvTPfq
         cvo5zznahXwi1/6wSagjaJ2TnQeUHomS7jAhjJMvM7rqoLY/yetlIvQsYs2FOhhJdopG
         D6lc6l/I8HQXFKxBeiLfovtSI/Dg+6MFvjoqWBjhf9kG9JugzrFFn8vtDgw5p2JLa6+g
         837Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMpGDFB38O1qiFCSErdHwq6clYBcmdBPpOZqHPTpc0tRMmktECPitCoDvHtDry9p1MeUjxDnVMI44Af1p+/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp6gFF7ZbYEe6Lfx7KwG8z/nn3bwzPpFYFT+CJ5M/rY0paCh7N
	hivSNdqQoumr1XrHjYZhAihsiDSE5gA0HHMKzOnNGSIFpQEG2XjnzPTz7E9TQ4MHBgvRO/S5Ojx
	HaS0doDmEFJ5/3kq1CrAULuVY+SH/bZr0RZGj5x2eFyggqMYXqpLFcUbgXz+u0UvqVA+A
X-Gm-Gg: ASbGncv7t7ZbPNQlfElC2YFJLDFTupuDnQC8PKLuB+OLT2ix1olYAktaF6f9JuAwPir
	0t0Dtz32B7yvct5L2eDuEBOq/kLwUQqkDMXqMLdayYEKCMEgzSkJnmQjCCZ7ZKF+mfndXIKQodn
	yUT/1A9GOmDhu0mp0wkewIskr/GE5/txjKnCz0OuXn4nWmdDVSgssCwBl25TLBN0PutXCbY8OtD
	bsTuykrEdMNBmrez9Hgwo4pHsiDR+LWURGzMcC7XKBIHCPiZNFuLhhBN2S7IMA2KJwiRy+T20If
	Pl0AE/oTr5izjCBlWM/Qcn+Hxz78Y223TTug2bih/Ufgtn31SETDqUUsgSeq5jAxhTesmiy6sVG
	8ig==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23006215e9.12.1762445854308;
        Thu, 06 Nov 2025 08:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIyTOWs4nIR7QeOKb8n83iy6iz/GaHMuA92Bwhg2oq7+DwP0ugN/AgSAqGuvWOvF3ICA0YJw==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23005835e9.12.1762445853789;
        Thu, 06 Nov 2025 08:17:33 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm20572515e9.6.2025.11.06.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:17:32 -0800 (PST)
Date: Thu, 6 Nov 2025 17:17:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
Subject: Re: [PATCH net-next v8 03/14] vsock: add netns to vsock skb cb
Message-ID: <q5w5y5qomj54k2tzztsy4pz2h2zqkvgfzkysjiv3uguoufrqy7@tfz7dj6cssxf>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VAJrtDiesc2HhdIQsTymg9US_eZTZGaCwSniB37KWFs_1762445854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 23, 2025 at 11:27:42AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and net_mode to the vsock skb and helpers for
>getting/setting them. When skbs are received the transport needs a way
>to tell the vsock layer and/or virtio common layer which namespace and
>what namespace mode the packet belongs to. This will be used by those
>upper layers for finding the correct socket object. This patch stashes
>these fields in the skb control buffer.
>
>This extends virtio_vsock_skb_cb to 24 bytes:
>
>struct virtio_vsock_skb_cb {
>	struct net *               net;                  /*     0     8 */
>	enum vsock_net_mode        net_mode;        /*     8     4 */
>	u32                        offset;               /*    12     4 */
>	bool                       reply;                /*    16     1 */
>	bool                       tap_delivered;        /*    17     1 */
>
>	/* size: 24, cachelines: 1, members: 5 */
>	/* padding: 6 */
>	/* last cacheline: 24 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- rename `orig_net_mode` to `net_mode`
>- update commit message with a more complete explanation of changes
>
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 87cf4dcac78a..7f334a32133c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,6 +10,8 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	struct net *net;
>+	enum vsock_net_mode net_mode;
> 	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
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
>+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>

