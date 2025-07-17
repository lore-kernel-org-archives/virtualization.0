Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEC2D3237
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755725; cv=none; b=S1Tv7rAfsUxfgyNOqasem4BO+/DQ1T+KXDoHYZVhmgO1bJX+vXPWb3aWt+F1c4RKMUhQsoCSnPAzJn6iA+6etXonqlS2lD2EbYAaHfGbRhk/XfWwAZsBDRsxQhvKUbXnwsgQ1iMm5V8l5HCkewX0r+aNEaRjdx2IXoxL7cxXmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755725; c=relaxed/simple;
	bh=I+W/ywICrQU8Jn6+qPAIsFEguyGDlREwLAb5GJXRNXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ulNF5ywxZyl/+rz1F8CYOlFLcx6zqVKDaJNBZ3Fvts6BI8EhpEFJR7StTKahJqX66q4aoROsYS7nDI85r7v/J8rSU5vdlUG9qP3skKTEZjahALPGSph/Vol2+t2SUmqwcLYY/A5Y1KTajmrpnQKkf3/wILqeYVuOvaBcX5346ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBit86dQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBit86dQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
	b=HBit86dQEReZCssJpBoJhMaJBYR1qM3JGo6LRk6kSIbwdDkfX+CpUJ4Ost727lWAxHSXVh
	+bMZeN3VndoRGAgH2PQltR8wDOAM/Bhd0w8ioL5cJkbt2HR2CK9mjVElSjHj6WNKU6hhyj
	Y9u/IsztmSFeSNxph1tcLeE1wifVx04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-ZfcCZCKzOMe-uxaKEtYwdg-1; Thu, 17 Jul 2025 08:35:17 -0400
X-MC-Unique: ZfcCZCKzOMe-uxaKEtYwdg-1
X-Mimecast-MFC-AGG-ID: ZfcCZCKzOMe-uxaKEtYwdg_1752755716
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so5280125e9.0
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 05:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755716; x=1753360516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
        b=qxjZ7yuRqsp4MpSQyR60Wp/V+TE6kNwQrSHxytIJk2z8sZWre4YtovnqNPxadrt1cA
         +M7j3O6K1ewpnm5/JpbHpfKuApXXPaMuRunjT8RK1SjhrDMTNPJcrYME17XkJEQc84iT
         BLQ32fh4x55CoEKKoLgsNMeh/cwkCXuuc5mKFPmTPPa2YpwfY8qySTG5hqYFLfXTKV0r
         mCstKCCNwN1rwxobeDErJwdDdfluYus2MUaFtJFPGpkZ+aAiVERMXiRhRG31QzDWeTCi
         WIt7VRFAtnEu057prT8bt+XFi7zZty1a9YhhGV4335iaCQFHyjaAC5t1ItMNvZTQdmqC
         iXRg==
X-Forwarded-Encrypted: i=1; AJvYcCUfQOd7/g/USzUOTOiPJ6qB1XC8f5lRuzMILkxy2lA9PRuY8+If+E90GoGkfvCAe2+X9M7nJxBS30SlTvs/bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRnTM1yGLO5YOlU3p/4wrGB9IHmVZlUVL30WF8recX//r3AyQI
	GCUDFYJZGBMmGYaZ2b//RksCzFk4bP8HN8o5ay79pkFtf/lyNeuv978cl786teBhpLjV0NQN8Cq
	GHfF0zYGbm9D12Y7oylVrKC7qHXU8linFhs8uCu3Yf3Z4A42BNpSz0tMgScRWo/7dbj5d
X-Gm-Gg: ASbGncsUOLm5/2H9k6ghFY4B/cEM6o5cmSBfbXTWGRVwVR2v/mfQ8IXENXgRaDvX30u
	fnAnad1dfdLrFy+IpDXIX2v6YU0Ki0sRuyDOqFL+T/saYe6uFE2OUo5N1uC56tcymKTMsTVn/hF
	FcfNArzQT9no000YfsdSy1mi5tztjHUmfSQ+qY0eLaZ4uCN4SohVh9S2PvWVd5VkpIOxRo5IN/3
	3GHhaW7SdYDRv2FAqyu/Mp7CIX+D9Jatq2CFtOjHrClM32M+lZ2J5KL+1Dt9PYBuzMy1a2i3Wu4
	yPzn2p9mi3tsvFMAzdqbEwD347zM8FZj
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742815e9.4.1752755715624;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAuVmQfkjMs0IrNh0YbIZypcGXHZJRkbzaNBRv4xK0uzAkkQO25FKstUtNwbpNaIIw4E0tiw==
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742385e9.4.1752755715182;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26938sm20503442f8f.89.2025.07.17.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:35:14 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:35:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <20250717083457-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tv3yAk1-d6F26GMpIAH_8gEiHXBCcH8yZ4Bp8W3oqmg_1752755716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> Hi all,
> 
> Here is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> 
> There are only two minor changes since v3:
> 
>   * Use unlikely() in payload length check on the virtio rx path
> 
>   * Add R-b tags from Stefano
> 
> Cheers,
> 
> Will

in my tree now. Let's see how does it go.

> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org 
> Cc: netdev@vger.kernel.org 
> Cc: virtualization@lists.linux.dev
> 
> --->8
> 
> Will Deacon (9):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a 4K
>     page
>   vsock/virtio: Rename virtio_vsock_alloc_skb()
>   vsock/virtio: Move SKB allocation lower-bound check to callers
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
> 
>  drivers/vhost/vsock.c                   | 15 ++++----
>  include/linux/virtio_vsock.h            | 46 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 20 ++++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 60 insertions(+), 24 deletions(-)
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog

