Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C82139A8
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540093; cv=none; b=HRPaHiK9WBk1ZtCJiB8N9hsoFntBavwra2wAht/e4K2CqZ0d7XgirbMOklYbm2qytGMOKnQAy7gcWXEwrlFwebJOptqkBy91KOJUqFSMKD9bUaBzz5vI6KyryBdYmixYvsXaxPdStynEvPzErpq4PrBn/mIuNubzyn0nFVT5d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540093; c=relaxed/simple;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GwqFtUwQmI7Y7sTcIyFaj69G+Gth2u2fuLRyEDdm0F1AoJY61annvEZ5zan02Mq8DB2HvEu31RaNtBe2qSZmFtSRduzpbCGoB93rJSrsdbwIMsFk/cGicCIqKZzM+bqr2lOSq0KrkVPkGncZljbtkz0qK24qPjNJdveHK2tX3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6pPOnDh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6pPOnDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739540089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	b=K6pPOnDhV74gGzuTWg15x69yg2zSywkhIEN6WRy+QkLDIxrlqohijfLa12IuWmI0fW6pPp
	9Pp6lSmoURoTTI6sVEgJ1gxSryefOXXsVZ77sMEQhnnFOPqo1yIxO0ueoR7NuynWyqm2H9
	lgzjOoQoXQLZQEiPsB8pGGnZRoHKYmo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-0LAo1R1WOGC0u2Cm2azeiA-1; Fri, 14 Feb 2025 08:34:48 -0500
X-MC-Unique: 0LAo1R1WOGC0u2Cm2azeiA-1
X-Mimecast-MFC-AGG-ID: 0LAo1R1WOGC0u2Cm2azeiA_1739540087
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dc6aad9f8so1705901f8f.1
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 05:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739540087; x=1740144887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
        b=Q76Kvx/pT82xGcSFAmjfenkdWXtKQdwji2VJz4JYz9sjo14oyAaKMKh6MEJdOl1Z/W
         gtuiHn7jN0Mf4nh9FowAYQ36mpuYQJ0YvPDN+230h/Ve1z6NUKd/T3MKYL77LlfmVwm1
         GKYVPzj5h5S4L7YdHMB/OnA2QkXfEvMbGrfe6Ymf1HSywk4MKZdFizYCIvLnp0T6Ho6E
         usgxue28rtG0ZVE+fcr9b0YcGQ8XQGlCwxfgTK4eBVN76tgYBNi4yMJ4vvP9Exc7ZpxJ
         7KoUNsiujzN2QbnN+Z2HChf9Nahvadt8PaEOn0rD7IxTbJkeEjwOK3eHe2h/AwpyC5gw
         CVTg==
X-Forwarded-Encrypted: i=1; AJvYcCUUVUZz5m8LorQSAWrwocS9kCYZqVU5UU0tQcZ3p6BM9yCrtZl19pJY3gxNunpcnk95fPHi7JU1fInYQUyRNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAjHow/Rt5y12AqCUEaFMJhXk9szP4IIuA2e+vaTWTx3XNh526
	FVcw14oGE2YNSzAc2DqLqzAmlNokHYPXwbsIkagAqLW7trd7zcrv9awD5ih94U0F5NVOs4b/T+v
	lAhrhFRTuOOCcqijdQwLR+056b8FVYKKEBt7fEL2Ckb+mS2z7ilPxa1mo9d/uCP/u
X-Gm-Gg: ASbGncu+vNyVtnX2reWEEb21unqkJyBp9hsrk7e1pB2KFTBR00+7tYBAZnNtFkfURo3
	tf++oVYqi3rdA7LDbb1rpVRhpWwTWa6hQoTnNvulmgffc0+2HucOQY9MxqJhbatkPg8gQAdVcu+
	+N2oGnHvgfR+G+Mnnoi/y4GYE22TlhB+8f9GuWsPqFzxevLYn2Abs0tg0kFQJlTeevVT+sqsbn1
	8/vF/f22X0lcTTiEXTQMJm2QY7S2EKp1tFQraJJDy6Ngt9OfBV4wE4pK+LWrQT5Or1rEAmL9kZR
	jJccOag4TF0WkK1WglD9iad4Gzlpp+6JIyDiYn+NN/X/79Y8Iph+iQ==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382231f8f.0.1739540087275;
        Fri, 14 Feb 2025 05:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBDfyv1SdJm7R5cH01+wLfhjW4AOVc7JnS47asJmAAjRGNm0ow+MsDNI0LRQYW/dCz7cuhNA==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382167f8f.0.1739540086611;
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b43d4sm4600179f8f.4.2025.02.14.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Date: Fri, 14 Feb 2025 14:34:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <7zof7x3scn2jlszxwynyaw3i5lcwfo5j3yrgw2sraq6pw545h5@zwoqaewlq2m4>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QJU01aXwCvNyMNjGA5sGfg0XTV2KgPnJqYsIt_w0RvU_1739540087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
>When executing suspend to ram twice in a row,
>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
>Then after virtqueue_get_buf and `rx_buf_nr` decreased
>in function virtio_transport_rx_work,
>the condition to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
>
>It is because that `rx_buf_nr` and `rx_buf_max_nr`
>are initialized only in virtio_vsock_probe(),
>but they should be reset whenever virtqueues are recreated,
>like after a suspend/resume.
>
>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
>virtio_vsock_vqs_init(), so we are sure that they are properly
>initialized, every time we initialize the virtqueues, either when we
>load the driver or after a suspend/resume.
>
>To prevent erroneous atomic load operations on the `queued_replies`
>in the virtio_transport_send_pkt_work() function
>which may disrupt the scheduling of vsock->rx_work
>when transmitting reply-required socket packets,
>this atomic variable must undergo synchronized initialization
>alongside the preceding two variables after a suspend/resume.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

