Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4B145348
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755502; cv=none; b=NRwDQbrty4XSTMxCwiztt7paC3It5RM/ooQvtM+ALo4W6U6iVW9YABSzQtr5onY1zitsqOvKGjh8UL9FAhLfAveAjH5lqE163mQN//YWlS1OXrB5lqErIvUxDrYdwVRmjux6cTAugsE0Ba2sHwS9Lt3QfHXbtkhFLIxrLOpuagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755502; c=relaxed/simple;
	bh=44t+/G34YxBgSaKHX9d+/SfEpoDPOQU0T/keIoBXs/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f/pxCUB5h3+dONua3Jb0cIAuMD6vw4Lu9PWp1GFFCc/7leICC8K0g2ZyCYGnM6ynmkCwf1MADqFlHoB08y3R67tI5/gcAfvhGHw2klZfeLUo9I5WH/4/9HgDcVG/KpklME2B0NTiya/miNOwPwJGzRoSsxFFza3ExkLCbv/LZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx3V1iU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx3V1iU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
	b=gx3V1iU7BElEZTzZ44Nw8glt3ZjB5CYOG9vlSBIKT1frAz4RBq2DN+aSgEyYFuxLbYb3eE
	dV8FL6bPKJPnjOrVg7xoODke80ce+WWhDoE6E9/yLdPeXPqHOcrETQFlVMpnM+BHAT2kY+
	vFBEfqJb7qoc3Zp4JxkGx4qSBShE47c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-nKfe8g_1PweK2NNi3QwzTg-1; Thu, 17 Jul 2025 08:31:38 -0400
X-MC-Unique: nKfe8g_1PweK2NNi3QwzTg-1
X-Mimecast-MFC-AGG-ID: nKfe8g_1PweK2NNi3QwzTg_1752755497
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45626532e27so6117795e9.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755497; x=1753360297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
        b=CiVb/HsoNPsiH7pXlcUkXvdMKWYSeFGukoxiUTiqgQH9Gs6JJNJwvb+sZy7KCzi0WK
         fmMjIu9WhW7nciYRevvlXQveZZ1nyc8FLqYAXLCKcnwVyVZaGl0Y5PI0CoEL/kSoo3PE
         Cg8pjOEP6+AgMZvNfCNJesE/1yju88cYWMnMnudB523ILjrrzp32QQLzzDPM6lre32Fe
         FXmmnBsVy8ElQ7iivwa+97ZoIM3OStc2oYICdUtsDLdDhyu2XjUtP2X9OEM+1yTJsDrU
         bpfkFfyXbxEfMz2Q/SJQOEb6QqfVvWOs+6UmU5MhPdxCKolRWiWpe1SwZIW1JFJF0gke
         qcuA==
X-Forwarded-Encrypted: i=1; AJvYcCX7691cWFftQadTQDiQkRQAzYkK9SOGxh6ypTQqqkvOirA9RaeKgKkLxII8Ql02SsVQcg5vX7DC6RS2bYJa2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHnCvkOwzIB25QLTmOIrYIA8Xb/As0/jnNZeY1QUIXwhPnaxph
	KP+zEdaEDeMu+cHP9AnYGiBKzAQ8CqG8VN5HpcH/3XHO8E4cbZCPQjMXjvtQ66pn3GOQNS8JnY9
	qDY1CJwYc9ToGi+otCSHVWQpJgnFOZK8tXwwQd//QcdFgLvrQqWHG+CnBNUMozTU9GAYD
X-Gm-Gg: ASbGnct846+6cFXM8FwNWTYKcvy3sqEn75PfTDzMlVZ0diUdyDm+JevwRWgElAiSK2D
	Tmf/xB8X8FJVT9JzNx2Avwg8ZyaaDhotLi+ZKWgPrxModpXLO2SoWBGhc8MvvspaCRP1qHT+aOW
	mQthVwH1kd60GTBHZMQ2HQ55o3CAnUlEIgv6wEfOSDnqAEBqPsv1A8W+AkoqgjgxTu4LPGbBRnc
	sB7oKfLPy0fXwKJoobLARxIrFKIvkarDdvoVwkJe3a9G+olAi2FcQ78HY4zYmCel3gI64iH8VBu
	WcV9IYvTep5JCklM+PrYXAVRDerH6sPC
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74472235e9.31.1752755496528;
        Thu, 17 Jul 2025 05:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUNLRLQmETtxRLBXnwmbrI7MpDiljAY5jueDojwiosgbm0KlFcY6TQxSyKJFFVblPJMsaew==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74471715e9.31.1752755495990;
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f6c007sm20924585e9.19.2025.07.17.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:31:32 -0400
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
Message-ID: <20250717082741-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LT7wfuA6ZC_q2cgdQ7Rgi8ZtkcVIDwwRZBkRz-mXnac_1752755497
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Who's applying them, me?


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

