Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60E2980A5
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021441; cv=none; b=f3X+NLcXNpO6v/fFixtTcZmr/+REvUk3eILPbH8z6zbSSQvsc+wihntxnlnQDicoJh1xy3H+mSZYGwAzdwrYv02/tbQmoELGeei6f5XHEXdEp0v3W+M/4gqdAWEttu0hP+zjMYhe3xXAkjSsqVmr21gbGXBRwjPX0pgE/ryKCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021441; c=relaxed/simple;
	bh=BVHZXeFbpjqe+fGCkZrzN32CSukxqi5Z0bBDKpeU2bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hv8E3gJrtdd3G2gcvMqSJaXX6wENR71GTls3mpxeQ2KLRkIPCRUouAfOop4V94TIaJhVT6BvBqvM5W2q6wL958AWJqJGFO4qXvpmDbqNkxV4qS9OVJuZJHb3p9Ng2lAPF4PQ6gscF+ehpqakpiw/jzmCe2FgBACJ8aadDCGQMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VacXPGhI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VacXPGhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htlFXUXFpvLyLzYGnFDK9X72riSzVnaZycxspABjtgs=;
	b=VacXPGhI6XfDWvWssq9qi7zP4qJ7Na1Mij4XPI0urkXG1viY3KKtMvzouSxlThHmiu0R/s
	6K7unmYv/Vbl1+r2/w2bmKBvhGSHZH3+5+yXGEoliefgpFvvstCMTzuqvRxpq9WuFGEug0
	rv7D+jXE+7tfQ0P7AGldtOiBvMNYi4c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-pcgfDJ4MPoeC4ypk55HRYA-1; Fri, 27 Jun 2025 06:50:36 -0400
X-MC-Unique: pcgfDJ4MPoeC4ypk55HRYA-1
X-Mimecast-MFC-AGG-ID: pcgfDJ4MPoeC4ypk55HRYA_1751021436
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb5f71b363so39313626d6.2
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021436; x=1751626236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htlFXUXFpvLyLzYGnFDK9X72riSzVnaZycxspABjtgs=;
        b=lLUbT/2WlzrW9k5Rw7Ocfmn6uL7JwBJMj+zzxYqfMIM12BKnnTaUh+/JEo6BggnwpI
         7vMzz86Ltdbgs1cTAwlUBGiN0J/OwWJ5f+LfMSYfueiWBpyvAUT5ZNtPUOzUsWZVkBJD
         O+S8e089NFRSxKNZYYdymvzvb22PxdOYaZ0pwdbar9OaQGfHrI8y5hSXIfnMxYBRVGGm
         jxIQRS06ojin7RhOx0vJWbV2xGkNwgJpHln/eBpyGB6tvMSYS/T+SUTXgnxL1cs9SPD0
         oKcdzZ6LA0xVg2tIU+ua6IA7XfxT9pXqe1i/yzx9Dq+DNPCLO9H4ldFWOdApzIWpbDbk
         +gWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOonClBGwCWlmz9Dd6q8DWORfcdosDGEqXmCqtfzrJAYEbR+yC6Gq6d/ziGLOSO80VJUxGqI8o9BOP35BhvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGhMG4HhCy6YCwRG+K6pY+AdI47WRmp43cuYLxb0rLmjHrcT76
	LANujs0f3/4Aq6sd9M7coaESIQNgu51vVPLTSrVoZBAgvmOreULWaeJHiEo0Q2u6gPqk+36sYW3
	adNyBK7uNSF8/VkOc7mjBVjsta3JiU/IXIkihpWl/b9X/sT4Yo+RpMcAQDNcycnHyO9Y/
X-Gm-Gg: ASbGncvPwGibeSn/GzvVaxVeGiJDq75RHHAEbKEQ4PcrkmTg0x5j0uVThYwO3goOisN
	4HSN/5u58chHG1CyYYU9fmh14bjaA6YIT5HZI9IcpjCiRYx9yBQ3imRVSAxIx/E+X0mYMFQWFvz
	3txHNSWUTUpKI2iZ3LlQpcfqXvM3u60TSV7fiZ4lHgonZoriMx9qfmrw5gnOVDhBXBIY4DIvJRZ
	yENzPcELOnHWly08OSNZJFccymU6xgTRJPE/oeQauV399a6ZdW00id8h1asJUWF5zjIXJdWe/xk
	ylvg73TzJhX05OKL+s9ELUn8vMP0
X-Received: by 2002:ad4:5e8f:0:b0:6fb:66f7:643a with SMTP id 6a1803df08f44-7000224847fmr46956086d6.23.1751021435673;
        Fri, 27 Jun 2025 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVOPpSbDXmObd1CmdrkOaPEYJK4J2y+x493SsV5Ja2/xhandwC2sZzDDh/UAk4qzxJ+GDUw==
X-Received: by 2002:ad4:5e8f:0:b0:6fb:66f7:643a with SMTP id 6a1803df08f44-7000224847fmr46955756d6.23.1751021435242;
        Fri, 27 Jun 2025 03:50:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f2dsm17866906d6.78.2025.06.27.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:50:34 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:50:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 5/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large transmit buffers
Message-ID: <cuqzmhjjakvmbwvcyub75vvjxorjkmzxkuvwvwowhec6wuaghj@uyq6glnhxp5n>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250625131543.5155-6-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KY2dqCXl9u88j61KzpyQOj1vvW49-ziemg948iQiLfw_1751021436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

nit: I'd use `vsock/virtio: ` prefix since we are touching the virtio 
transport common code. Maybe we can mention that this will affect both
virtio and vhost transports.

On Wed, Jun 25, 2025 at 02:15:43PM +0100, Will Deacon wrote:
>When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
>virtio_transport_alloc_skb() to allocate and fill SKBs with the transmit
>data. Unfortunately, these are always linear allocations and can
>therefore result in significant pressure on kmalloc() considering that
>the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the transmit data in the
>fragments.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1b5d9896edae..424eb69e84f9 100644
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
>@@ -261,7 +262,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
>+	else
>+		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+

As I mentioned in the other patch, we may avoid this code duplication 
hiding this in virtio_vsock_alloc_skb() or adding a new function that
we can use when we want to allocate frags or not.

Thanks,
Stefano

> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.714.g196bf9f422-goog
>
>

