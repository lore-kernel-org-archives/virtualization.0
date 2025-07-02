Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE492D0C72
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475163; cv=none; b=OQinGHtswEFy8zZuJ818uA5IyHMtXZ2Y96IyTzogMsOQxvUOxq7kGfcGHpFQAj8mqpVS8nr1rZvRNmaQe3hGYG07Alccq01TbcfpTyU594CWLC1toUaRYfUTBpTbGmQAAj2+InMu/cfeGMjAt1u8rlum61OJDsMK+8No1nVph0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475163; c=relaxed/simple;
	bh=qVCMZTaISxLivTk7+kWrRgV2aF90WxiPZyvJQoVyT4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CmFsCzN+81OxeUQJARvOxR12jjREvE2I03m8mTNxTSqNelhN9VB+uOW8nEFhXfHYBcUBEdO6hRwthG1VxfBP2pMeBHi/MUYJ0a5gOcS49s3CNi45DPaigHyNJg2tQEhy46L0AqIo0lwbjzaDKu9PZUWroDmhckzbXpBHFnsV8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhpBZRvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhpBZRvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751475160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmK+GBkVK6o0CyGzNkEe+iO0xXlQBKsvPUrRNPTdNY=;
	b=GhpBZRvCMOAOI3XZh9dUxan1NqundEzmsEMtOeLf18aWKxfhHQ0Nd5UCdC03serjktqCJr
	ImuZX4bhsH70vl+eSKfwOWEzVkdf59Ip12XiE6emAMlIfVYom8UjVnOLAB7y24AKyM7xOo
	b3TRavQNVMbm9bsJEHvf8hLrARJOJG4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-lhcjSdPKMp-UdeTFAg9maA-1; Wed, 02 Jul 2025 12:52:36 -0400
X-MC-Unique: lhcjSdPKMp-UdeTFAg9maA-1
X-Mimecast-MFC-AGG-ID: lhcjSdPKMp-UdeTFAg9maA_1751475154
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453a190819bso25746855e9.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475154; x=1752079954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVmK+GBkVK6o0CyGzNkEe+iO0xXlQBKsvPUrRNPTdNY=;
        b=wk5C4dWe/ptb9nGyTSun7SfyuZf2mONVrJaP099MSxErhy+3/j+L1zQYtnXrabneF0
         kXRU2kK4H7xASBqDTfdePFUB3yR0G76u44KlQdegybcPPGmT/08YADLWMg6PKXXtdy+n
         sTys6NPPa9WsaU4l42CvTm4ENpBYJW1MgSNvaEL6EQGZ8dLmuc6PgnIoU2+GMW6NE7f5
         lUfRU9yQmyUByi55j+XLN9lZSjo8iUNtMvt6nmmx0nxNsXuJrkh10sAmCD313RlCc8SG
         uVvt5EkBUvzfT/PUuhqF0cIqZR6EWDWZI/qIp2xRUBLJKaMyTdNfzEyrhSn/5pjzmJdJ
         0bVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIbOwlQaZZLzXKzqLFJaAVjtcF7+hq6N3hBesg+d9DPuaiw46fL4+fvP0P1zuA2OWDeocgwaBXmvA0to2yRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlPMeEUWTW7n+kORp61MdKzjEr7eGtmVz0s+iMTnVjL+8i6b8t
	CURNHhyFOyjewQJi5ZW6BIaYtB1ZZA/3rjQT04Rrr5qY0v0y9sGVcBT+kSRbcBV3pHVUvy/Imb6
	HQkNuEGovpea+xBHgkc7eJvgNkqVZPVjiST0g6EHr0rt0QACcU0ZqrFwNoYGVbffh0PAA
X-Gm-Gg: ASbGncuHDiSDxZdz7MmDLSN/G+1sYV74eQrrzHhcPNPzd6+MY/4oBSemEc8R5WzDddo
	jaYZ7ZJU+c8beJxvxEMmffghzEuwNqMAK6elCkEstiaVyGSY1B+jRrEXYUqEeCfwxGLHmEWd8I6
	jkBn/BgvBktCDV4CtcGoTRl6JZJPIwjpyYBqOOjFbtHm684y4IKbPfKvwOmSElSp8slhX0+bgix
	s5ZoG5yjCBtmJswt9D8tnHvcUY7E3Z5Vdsazpu2tS/CTe1Pvg8dpu0XZyhwk59ATRRslV8UmlTR
	dfcC8MeIXgRunwz3fSWjI21SU5c=
X-Received: by 2002:a05:600c:3504:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-454a36e6310mr46254895e9.10.1751475153819;
        Wed, 02 Jul 2025 09:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/iMFiOin+Y92R8cOiRVQwWoz7ykHbNXjulAxwXZzp4AivEVwBGwId8u9eEgfnW6G2MVF+CA==
X-Received: by 2002:a05:600c:3504:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-454a36e6310mr46254455e9.10.1751475153179;
        Wed, 02 Jul 2025 09:52:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9972011sm3013185e9.9.2025.07.02.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:52:32 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:52:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 8/8] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <7ff2lvfjrfyx4imh3yfhimiz76znfomnm73kcrlt4rxjciamkc@ddjo7isrx6vr>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-9-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701164507.14883-9-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EILbH_FlXdOTvjRQx8Q0kY7zniizlHjCjNRAkJ_AXYI_1751475154
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 05:45:07PM +0100, Will Deacon wrote:
>When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
>virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
>transmit data. Unfortunately, these are always linear allocations and
>can therefore result in significant pressure on kmalloc() considering
>that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the transmit data in the
>fragments. No that this affects both the vhost and virtio transports.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c9eb7f7ac00d..f74677c3511e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
> 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> 					       &info->msg->msg_iter, len, NULL);
>
>-	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
>+	virtio_vsock_skb_put(skb);
>+	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
> }
>
> static void virtio_transport_init_hdr(struct sk_buff *skb,
>@@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

