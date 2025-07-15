Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9742D839B
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573212; cv=none; b=GeStUCD8FAhWDDmU9zg31kRHpXnCD1aNZqpmeH4NNw3pLUynt/S/e6vtrSyR3z8zQlJ2WXKL/Q+6TVOaBmXw3+HKIO8cybpaJh5XFPKFCvzuwH/OQNMbByKpXkAgwdGpeRD3fy64jFoFZKZcJ8JQ80izJXrggfP4nhLMgZFUI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573212; c=relaxed/simple;
	bh=6tGyBJtvc2RtGieTCJUc7+YbV5rIOi+F+HZmZMgrilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M77lg4nBq52/MoQO40O9Ltu32lFzsXh0s+cnxchpisw049wS+VxE8w/ToOghScK1aRL6dPjvOs43lulqFix6sFFYC3oL5zv+EGN8LQGxNklriN1AMCoWT7BnINbwUFucuq49krbNdEvaMqS+6qL3aPuHBwz7pZWkare6soiRq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XovK4NJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XovK4NJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
	b=XovK4NJaeftMCw0JXSCt1n7eBBjaLiOy+I8Txv3PjCUBkDuzwfyX/gKjLUR7FsytXfFJrT
	4cPbL/b4seD4k6AImpXGtHsUihYCB/bn3IeCWS075XnNLwE30HzM4zF4zumhmBqUQcfMeQ
	1YrxwmFHj5T2OcFdnHL4UaxtkbYlk4U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-VR2JL1jXO4OeCoF9Gk3bTA-1; Tue, 15 Jul 2025 05:53:27 -0400
X-MC-Unique: VR2JL1jXO4OeCoF9Gk3bTA-1
X-Mimecast-MFC-AGG-ID: VR2JL1jXO4OeCoF9Gk3bTA_1752573207
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704d5ca41f2so25435186d6.2
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573207; x=1753178007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
        b=tiZjXD//JxvCo+XNKcMNv3Hwk+vTgP760J36NsQiawH2fq9tfqcjuE1m3WPzQRd06g
         1Zk24IhfGLgFfsx46gqKxZKBBWoi8h7lyocuGsB+Cq9bacuwSCsiw4nsWnKnTD+aCadH
         pTNzs3U4gaa7xLw5N5ZqVtGW0Ti+BGUiv61u1F6RlntapbMps6IUPm9qXyfN7ff8SXws
         Omv9TnbalCLhD7oc206svxPKfOY+Q9MsQFMZBXmiw/RwzQ3UuPoK9cef5rZM/rtqx8va
         Zhh8ouNLjgaUfmbD8GGO7x+MLC6iHkFfPG0rkvCcTUB/41GOBpwMlFb5SMmjHVBHfAdK
         JgZg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLTATa0qdyR5eKgGjX+r9FdhyRCD7Sin0sdiozhIIijMtbsFNodIMoSBLhPEslbd28xicpd2Yf7P4H2evVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxZ1zIoPjrqQLjB6fnmilHoq0FFC4dhaQNYlmxTUd4QvBuzrUS
	DN17r+qqUKf6hUGAWrW7OkX9zhDq3EBI5exrQNxyAWXFulAmDo9FitSBDPUmdXA0rYuzZr1SJ/c
	NWqlrSx9I80IplGLOrPfcnS2DAKh7Qu7QabTWMpxHwYd9v1lDEDITYMvHH8e1XeR7KI9Z
X-Gm-Gg: ASbGncsvBRKH8sh/0nafdZURJ1MFFL7L8mqhMFw54ysQt29MuSX/OL/npQFZ4kp/el5
	i3FSSQNxsrEFfpBHrcc/YrY9daqJUBCQlpKwvjwpmkw8N1vmHNM8YpUOLwf1zb+CPnl5CFs8xe/
	MIRpiXRnrUsF01ExfZzt/ijw/o1clTliqPTG1V/13SE82/KDfIC86Mjg3pGoDHTWqAmua3C8ru8
	P0Qj9MmdlXlQ+McUk5kN3XbLxtRQHmspJnB8Fnmm4vpBQ3bUPQ1N8+/CIo0VdcmvgcjXOj5gdfj
	/S0loFyLUBTzG4vcO0wMmxn+JBjGJj1MI+o3HLZVnQ==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226990186d6.5.1752573207210;
        Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWPMdVgtbcgI78Os5fvtMkQsvRVpbE9a1O27Hj85Ywr6W1l9K18b6noTWD3ov2A5GOpnHzCA==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226989786d6.5.1752573206613;
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704aa850c20sm40166476d6.70.2025.07.15.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:53:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <47gzwbsawomsgitmxcyd333k27qlwoail2k7ivwtqczbxuapyf@2gdxmlwlfsk4>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-3-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XjuUmenSr_9mUB2ZKA0uU8zPZTfxpRv__vQrjQ5E3Tg_1752573207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:56PM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..bd2c6aaa1a93 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||

pre-existing: in some part we use sizeof(*hdr) in other 
VIRTIO_VSOCK_SKB_HEADROOM, I think we should try to uniform that, but of 
course not for this series!

> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (payload_len > len - sizeof(*hdr)) {

Since this is an hot path, should we use `unlikely`, like in the 
previous check, to instruct the branch predictor?

The rest LGTM!

Thanks,
Stefano

>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

