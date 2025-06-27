Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363329B78E
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021524; cv=none; b=Ll4i3NYyoEbh0RZsNc6PXY6Bxr/J9TEaU3thOQkRcjbNm2rEzg8hPDGLkTvF0+NzRxN2BIXUrIKkKVFbc2KYDOlWK5wMtaZIlZfeRVZtEhcOrjsAZUeua2VzgNQ19N8Uywrs2s2VaLmtesiqt3DVLfFFK1kMRd7Ad9WR/KYdFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021524; c=relaxed/simple;
	bh=8NiJEsAY6H5hPb9ifVbvDlDwq1XB2n1aC1SVumzVDf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UBHFiZI3umVOSRk79Vd2bdWYzLhmq6ArnGko3UtYT1jqBUbks2XkxAPjh0N7jhqxbfZKNGxnlaC7CAn7aU90DRmyOu5eCCCiQp1rzLdGUmEeRZVlH+idFEx5GuqtaRuJA65NVOgu1u8QlMjk3d9ALyb6nL6HW8QkGxpYeJ5qmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxLlMhdd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxLlMhdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9N28nJ//bAtYtJKvSA/25sV4gpscCPOFq7vHxaYwng=;
	b=MxLlMhddaP8qSR4lhcokXI1zejsdofpYZNzgCGG46G2CNkrBP3RHuJdXkjBBHtr+H3CI3x
	Npa0zAnfyyH/RPqga/dovxOTwqOz6J3+udY2C+dIEScHir67CDvKhww6sfZZfLiuZQ+Al4
	bGDJpyPBwu9/7uBVHzD9oIJrZKJ02Bo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-3T-NUvYQOlO1WW7B_7Nudw-1; Fri, 27 Jun 2025 06:51:54 -0400
X-MC-Unique: 3T-NUvYQOlO1WW7B_7Nudw-1
X-Mimecast-MFC-AGG-ID: 3T-NUvYQOlO1WW7B_7Nudw_1751021514
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a58cd9b142so41639871cf.0
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 03:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021514; x=1751626314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9N28nJ//bAtYtJKvSA/25sV4gpscCPOFq7vHxaYwng=;
        b=KsZhvQFiu44JD3FntYMQzqumWfWq361LcbTjyrfLy95P+PfdBCotiJwCWK8JH4f+eC
         xJr56aIv/e6yfKHsOMkzPnz61h23fS5/uiiMNLZYJHXySd4spE8ptZFjpFevC0oXiRKR
         kKC0iPJFEdhXZdnX3MH15D+CA6iebLLcH94Vk/ovTq0evX86p/xVRSIRlVR+ltWTDaJ7
         9bSP/aWCXsbWAx4oODFtw0sCwLVdxEeph4Yj7gNmpzvjx8D0fCyWs97IeuSdZLCHtACq
         XrR4CtY3b0/67EMwFb4nTk3+KseaypRGet2TVrRO5acP/w6oScHe8eFSdZn1h0oKLxaW
         hrBg==
X-Forwarded-Encrypted: i=1; AJvYcCVrCBasXoeiXaNXFSEOdYMDAB/GP/KhEbY34xAxYyR4S2Shy/CSyoepRu2cTyQ8tIaI8dRa7rsAp43sZ+nXLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoUaVXmdL+Gl8P+ziXItA+kXssJa1x+4fO3/sVNex2dJHJKHQc
	HphKenjqibw+siJfRungS5fkSWmhdWH+P2H2CYltDJ1H9pUWxPMIcp1cCfKWS62hSkawaPM1gTU
	IOd04N1gkjy2U0NvcVMf1QIvdI9GmRTKd6sM9P4OMfL9wPraqKg/SBan5whjF5Cu6dCK8
X-Gm-Gg: ASbGncuLcTS0WNd1Z3i+hsgHKYje23uOSbcsDW8bD6H628d8KG4H4qrlu2iVP4CWt1I
	RWa8o+v9payf5v4RijTfver9lasqQIdBpKogwlX+uA624PpR3U76VEmOMT2ZXmcaOaB1V91S62c
	v5KHlsyLFBq/BoleDIFiHy6qFyiMG3D9l6GTKLXI6GMfcm3DTdHhwz1JICf1aZAP0Rv6uSluMMa
	TVut+KsRS34uRXwi+jsj1Ax+CJeT/0dJhKTqzaD3YbYj4edNsfIuN4oCYr4dK0cpnwau4/ZcD6v
	Q1h9/Tk8ws0EQx0SWr/nfWuEVuXb
X-Received: by 2002:ac8:7f4e:0:b0:4a7:30e2:b31e with SMTP id d75a77b69052e-4a7fcac456fmr48138351cf.34.1751021513888;
        Fri, 27 Jun 2025 03:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZBEeQ02fjTo/PBcoZEjlOKuEN1OVgF9WmLAZpvc5pbASKuBu4dcl/skhi8pvedUhQk6Z7w==
X-Received: by 2002:ac8:7f4e:0:b0:4a7:30e2:b31e with SMTP id d75a77b69052e-4a7fcac456fmr48137981cf.34.1751021513420;
        Fri, 27 Jun 2025 03:51:53 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc5ad3c6sm9858681cf.78.2025.06.27.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:51:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:51:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 0/5] vsock/virtio: SKB allocation improvements
Message-ID: <izmrcafyog7cxvef2nipk5f2vzxxptyc4fopnvl3heqslsp7q6@32ssw2piag6h>
References: <20250625131543.5155-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250625131543.5155-1-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jV9iAJY6FGTrtF7k_r1td9J927xSTfq3Wrr8lYTWfRw_1751021514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 25, 2025 at 02:15:38PM +0100, Will Deacon wrote:
>Hi folks,
>
>We're using vsock extensively in Android as a channel over which we can
>route binder transactions to/from virtual machines managed by the
>Android Virtualisation Framework. However, we have been observing some
>issues in production builds when using vsock in a low-memory environment
>(on the host and the guest) such as:
>
>  * The host receive path hanging forever, despite the guest performing
>    a successful write to the socket.
>
>  * Page allocation failures in the vhost receive path (this is a likely
>    contributor to the above)
>
>  * -ENOMEM coming back from sendmsg()
>
>This series aims to improve the vsock SKB allocation for both the host
>(vhost) and the guest when using the virtio transport to help mitigate
>these issues. Specifically:
>
>  - Avoid single allocations of order > PAGE_ALLOC_COSTLY_ORDER
>
>  - Use non-linear SKBs for the transmit and vhost receive paths
>
>  - Reduce the guest RX buffers to a single page
>
>There are more details in the individual commit messages but overall
>this results in less wasted memory and puts less pressure on the
>allocator.
>
>This is my first time looking at this stuff, so all feedback is welcome.

Thank you very much for this series!

I left some minor comments, but overall LGTM!

Thanks,
Stefano

>
>Patches based on v6.16-rc3.
>
>Cheers,
>
>Will
>
>Cc: Keir Fraser <keirf@google.com>
>Cc: Steven Moreland <smoreland@google.com>
>Cc: Frederick Mayle <fmayle@google.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: "Eugenio Pérez" <eperezma@redhat.com>
>Cc: netdev@vger.kernel.org
>Cc: virtualization@lists.linux.dev
>
>--->8
>
>Will Deacon (5):
>  vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>  vsock/virtio: Resize receive buffers so that each SKB fits in a page
>  vhost/vsock: Allocate nonlinear SKBs for handling large receive
>    buffers
>  vsock/virtio: Rename virtio_vsock_skb_rx_put() to
>    virtio_vsock_skb_put()
>  vhost/vsock: Allocate nonlinear SKBs for handling large transmit
>    buffers
>
> drivers/vhost/vsock.c                   | 21 +++++++++------
> include/linux/virtio_vsock.h            | 36 +++++++++++++++++++------
> net/vmw_vsock/virtio_transport.c        |  2 +-
> net/vmw_vsock/virtio_transport_common.c |  9 +++++--
> 4 files changed, 49 insertions(+), 19 deletions(-)
>
>-- 
>2.50.0.714.g196bf9f422-goog
>
>

