Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB62264D5
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572848; cv=none; b=KZfF7oJET58CT00Fw7QS30+pm6JJqlRPi5brIqBxJOGx9WJ+iAeaDV335BYEccAv4YVm1DXb8jAubuUaIg2jNmKsnPTowYOCUzEHMUljYcOLBTtvL4Seqcp8CBFM6ia5CFurOOa0/9xis5MiglYcu9sNDY1B2eGyBMeT/H/+4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572848; c=relaxed/simple;
	bh=9lxLx87i+PuaUy4b5HDvysuGPPM11GdUfv0DuiWleUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WbcX1wrjJl2qdEG/s3/I0GG3U+xrk6Z5SgjgJWWwYkjfn3fmGEzNfnC/UbpPRLi/Jw4cnB6Kmws0IBkeVyRGCoPjmH2Q/Ac0WBfesQMFKEMKWEI7Kp3DXKcynhdehDWjiTfe5jVRwg/OByRAV09sYcNYfLN5RB5uNt0eW49pOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkUYhLk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkUYhLk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
	b=NkUYhLk0OlQEeb6CcSjMuhMO5nu5lYt1nhkW64xwCNlsKvDf6x4MK8rqFxTcaKq7U56aHf
	s9SCtjS71lO39V4X4Pbb1yY5oSrkRZAA/MFBDN7OMr2MxAZUuKb+4Vt/Hq+beua2H1qJgK
	UjqeqwYPQAgt8da9rUBFVwPjYAqhJe8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-oHw98HaVNwynIbPqEXuiwA-1; Tue, 15 Jul 2025 05:47:24 -0400
X-MC-Unique: oHw98HaVNwynIbPqEXuiwA-1
X-Mimecast-MFC-AGG-ID: oHw98HaVNwynIbPqEXuiwA_1752572843
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235c897d378so52874525ad.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572843; x=1753177643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
        b=riqmO4tkk6WuJFWP6NsvncSR1+MNzxrh0cFthUYffalfbxpEzhQac7nWB/2EEmH++J
         FJeCv501d5EpNCR9wTDo491Z3s5sIFWR6rCUOhwKZZOaPa7AKorc4jvScuuweKn22rM/
         w7PQu17fHUmGfOLpmXg2YnnOEATYibrDJkMVuVS/VGa175isFl1xKLbmQJsBin/2Ygwa
         8Wly1e6LRRQkOhdiIg1oM6aL8C1WUa+Qzx5QKgoOGgCfz79LUXoR3arkEXdhBdHPW906
         Vly2lpr2rWxPn9rXmHmnJN3OPcvklp3EwKYv20tGmNcF2azqiBHzdRK7FH+LIYGgdWN9
         ArwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnMyVNa76h0LqtygqTYsUeiFgRaoe1Fa7SsHupKBvi1FJP8F3CM26u0+KY46gPx0e9bwh6w1MBL63r1zkPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbZhRNjyqMtds4joNZ9J/6UQf9O0VQll3ZRXBAlNqY2fVkVF2a
	1e19UnXW5ewi6BxtjM6c2F2m2ZxU/VBsND7ABFUifetGt1t3imRG5Urc3Am1U6OGq56DkP+ZumA
	msBiX78YY7OJOO+wRV1CQwEHbN85g1yQ1zGzNBFa4RaALD1/gb714vCLbv6nhN7o9/e/g
X-Gm-Gg: ASbGncvQUtPgutoC7SmKMcNLDLWyDqYSCG81CYpLXs8YNr/1IQjIsT+1l2NljB4/Anw
	Kdx0qN1fgr8RxT+YAkjS+l3ubWip21ZRnt7npkQpEIFMv6V4hQiy0rEkghJoRwlR3hEhmvFOGUx
	VkRhawC+UenN7sAllsl1+eTSrlouhmo4BTHmOJse8QZHHZLCRKCbkAtt/EjBeIMQaFjGKMZnEGL
	qeDF4+phD4YzF3Dgw/9qXH7xhb8Z6HoZ4s/qJmdyCvE6G/mvBZ/UKCynn0XcXd2uXicBSZZfzYp
	ZNZrKIuDoAM8Dh7IwlP+ca3fuODDsSjJCbvJ6DCdNg==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658635ad.33.1752572842975;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFw6Q76ji3E4T0X070GuEwtmCWmxMCF8YU2BHFI5N2HYUKvQ3kiM+lmllOTIzW1Yz+SYAp4Q==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658265ad.33.1752572842509;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b3c3fsm113125655ad.88.2025.07.15.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:47:21 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:47:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] vhost/vsock: Avoid allocating arbitrarily-sized
 SKBs
Message-ID: <h3zu2fsjvuftgv5gmkluyqipcak47a2koh54idqqfmstos44o5@c4so6ajec72k>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-2-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y1s37TLEmh7JSVPOyCkTuRLicP8BU74emhG8nbTyii4_1752572843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:55PM +0100, Will Deacon wrote:
>vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>this is only checked once the SKB has been allocated and, if the length
>in the packet header is zero, the SKB may not be freed immediately.
>
>Hoist the size check before the SKB allocation so that an iovec larger
>than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>outright. The subsequent check on the length field in the header can
>then simply check that the allocated SKB is indeed large enough to hold
>the packet.
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..66a0f060770e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+		return NULL;
>+
> 	/* len contains both payload and hdr */
> 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
>@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return skb;
>
> 	/* The pkt is too big or the length in the header is invalid */
>-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>-	    payload_len + sizeof(*hdr) > len) {
>+	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

