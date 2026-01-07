Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4C276049
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774564; cv=none; b=Yp7dLLzg3Mdza0pKA80b7HuZLDWbN3T6j0TjHyfpR0kIolBFwan0NkDZq6xXxWq1cijtXdAIwIAwz1YWIVxJmOS3ZJ0VwCdSHM0sP2rzRJSBmfc3vxyoMjvOKkVOXljom9nj3L/oKCCD1reBUHl5+z+d7Z5lBu/bjRZn1rqamzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774564; c=relaxed/simple;
	bh=Mg00K9PwbyrkiuHwFuf0JzVO3VWZFdCmsSSxAkDeO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k2XPOgBrU8jladkczjoIg9dr9gYNexZ1uDP+/UKbT/pX/WgJ9sTwQ3bu3dd+oZbeBKin3PADMO5jQbnneTdO/dB5Oy1WDGB05jYqjkzRqU8JypsOltQ2xyqhU6PF0g/IXqfMak2mNOQ3c+k1BTgHDPOQg3MsW7wHyn45gGcEGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4cFPih+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4cFPih+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767774561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cunsvOyBEpA2jF2JmeSIYeJboZyz9iSoN1/dk/+Kvfw=;
	b=S4cFPih+IQ+xSe394cTCLlJxV7Z4Lidfzh/MHce0eC1lSAldEdpn18FLflMSpuxFxiecLD
	sM52gCOSxcBQy+lDv8Wa/r4ju+7duq4FEkR9sPlzhVMnR6tQMaFRUwwo6hS4txgtPTmhBP
	YkcKTpWq5nG+dkNXThS7TkUyX8SqiUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-k4HIMrx1M4GuPjKgD4BldA-1; Wed, 07 Jan 2026 03:28:10 -0500
X-MC-Unique: k4HIMrx1M4GuPjKgD4BldA-1
X-Mimecast-MFC-AGG-ID: k4HIMrx1M4GuPjKgD4BldA_1767774490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso16765145e9.1
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 00:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774489; x=1768379289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cunsvOyBEpA2jF2JmeSIYeJboZyz9iSoN1/dk/+Kvfw=;
        b=Hk8tHMotzEOIdqx+8ji0JV1wPCNdqxxuID6IC6oA+LIBpQrBJkHxPBWr3JYg/bcLZI
         NdhXvg/AG5wX+LopILuI8z1IHou49rISBrkk3uFuKnPYIiN/oXoheImEsn+DoTwgAmrH
         1kqibgVt+bPGkAouqwhPAT5VH4hZCY63h2edw8UXxZgiwUTErzHahtt6KR+LuWn+jj55
         G09pHGWHwnkMeajTTlxKKLDJySLhyNDdDQDIcXTkYXAc31heZd3a3/iMYkmE3IW9uVry
         X+LSa0B7agYGLyfE+i53iePsJOUXXJYz9oprUTouEF9d7YTAfjTg/zDDMVCZ0IHHQYCr
         VFCw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgMRoDIJfbThGsdtDhO8LSBnWhtP1afE1WrT4dSewHrdp/+njpQX2Jh+ulWLFD5ZHlRnwpTPcuTynK6HxDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxDh2VwPtvSo0aWWHLCfr0F6l70xG7uRkJrtRJS/hXrrDCCPab
	FwEDfLbgH7L+5bqfLShIxyJm0BWRd9V1kdB8fHC+ALt4/yOjuNsxbUuslzYFZD28Jfo7tkwLRom
	63rIh4qi0AdaXvix6WmasLi2Evu7/t97qf3hH7jc/3m9MJs4xJulDc9wVwL+mOmWMtG3a
X-Gm-Gg: AY/fxX7K2k5SbziKRRmaEaUohH7SgJ3gD2ENMSW9beg/d4Lhnz+KhCFyVevVZLGmiN+
	sDtuo5K8dmXJ5F1QnMIes2s1VgDkMzx77ViCbbJAfR+ypAKC+qoL2E7P5pS5F6OH8LshBtvzA8R
	nPF/eZLLT8SonL64u4PtqPvah+Emn3yrBbENdHjcu2AiJ2PZG/VDENHnqXFDiIHeNkWs1PD++xE
	gDYIMAu2I492mr/Lpw0oNZeyenT6jZRboZLRwQxsr2Pg/11X1ReoYidkZ9UTletKZ1Um1Bt89el
	7FnO2nlLoKwk3rXG7UzZPk9YUMsNpSD5QFu6AJ1wUCPeNcr/oofWsb7Fy+wF2oNu2G4v3Obu2xH
	r4S9aD+h7ld9V+K43HyDil0Gs31v12ozLQg==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr17590585e9.15.1767774489508;
        Wed, 07 Jan 2026 00:28:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfTqFw1RFyOrDz3FTYetJ0O3Wwz0Nw74F1etDtvhfpLP8L/Oa0ngtxX/fuOMspIpUKEWiHKw==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr17590255e9.15.1767774488997;
        Wed, 07 Jan 2026 00:28:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636cb0dsm9019575e9.0.2026.01.07.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:08 -0800 (PST)
Date: Wed, 7 Jan 2026 03:28:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
Message-ID: <20260107032738-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260106221924.123856-1-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DUnWn8Ttd3sgCiCcA0OyT1kqjsDWNnZ2YNMhA8j2TTI_1767774490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
> Introduce page_pool support in virtio_net driver in order to recycle
> pages in RX buffer allocation and avoid reallocating through the page
> allocator. This applies to mergeable and small buffer modes.
> 
> The patch has been tested using the included selftests and additional
> edge case scripts covering device unbind/bind cycles, rapid interface
> open/close, traffic during close, ethtool stress with feature toggling,
> close with pending refill work, and data integrity verification.


Yay! thanks for working on this!
Could you share perf data please?
After all, page pool is an optimization.


> Vishwanath Seshagiri (2):
>   virtio_net: add page pool support for buffer allocation
>   selftests: virtio_net: add buffer circulation test
> 
>  drivers/net/virtio_net.c                      | 246 +++++++++++++++---
>  .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
>  2 files changed, 275 insertions(+), 41 deletions(-)
> 
> -- 
> 2.47.3

