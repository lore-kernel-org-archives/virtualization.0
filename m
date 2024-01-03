Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688F1DA3D
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4tF9jna"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0645B60BC9
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 22:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0645B60BC9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q4tF9jna
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3g9raTvSfdl
	for <virtualization@lists.linux-foundation.org>;
	Wed,  3 Jan 2024 22:18:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6B4D605B7
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jan 2024 22:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6B4D605B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704320318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVvD+OONW3KVBBfzwOKbjoTXnyj2MLQ9M3imyFTNcV0=;
	b=Q4tF9jnaUBoX2knqzj9l4tlhLGNhYJdFCrfd06fuSuUwthcylByx3jMMagOD6R+Q/rKoZg
	CIkCsnhaUo3KUemNQJlP9oeB5+ITElq0NN2ZiNjWoovt8Ll0SIA637zbLDdVhwh00TYQZW
	oFC7SIwLjM0Ncvi4Yg7DLL5pieWhrl8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-pqWu-sogPkO8EPQYCZTRpw-1; Wed, 03 Jan 2024 17:18:37 -0500
X-MC-Unique: pqWu-sogPkO8EPQYCZTRpw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d1ffbc3b8so94931585e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jan 2024 14:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320316; x=1704925116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVvD+OONW3KVBBfzwOKbjoTXnyj2MLQ9M3imyFTNcV0=;
        b=qJi9TkUmOmjSdilGUNzK68L29ai/sQTjjxDyd6XBnmn0UhFQvoaE1y4T29l/5x+4sb
         jaNmu7ZOQuKSz8ofvY8myZ18ueF59NT/LlUl8rTGlISMhnqhB9Pe45rmbfmQXMLG0ylK
         qoXHmeTTbMi5M5YJMB78O5tZbB3Zdsf1K7lYoI6JtaZVLH9lL7RqRzb6xv1P74gbG7K7
         xJvshd8oYmXaXz81peDvKZXYk69D1Wo0KMX5uY4i+gU71A2tMZdSnNmJB8cjRaftHO7i
         AAxmZNw9VDPM756BnC95skoR7m4FHceqLWFYuFZJHI5/kV0q9nnTbliEOZPHca/ultGn
         HcSg==
X-Gm-Message-State: AOJu0Yz23fq+grcASXsqrukTAtMFReux1qk0gN41fnB0cVy4BEHctuIg
	6LNurUOUkMSGW5UmTUXuqSneqQCDw8lq15MQYivKGQzHRd+rN9glT/ixSpQGnLnDCOM83OqYDsN
	7E3eCil9UocWawMAkXdCBHHELw4iW9PaaZEaGty7Gz4o4Ob/KPw==
X-Received: by 2002:a05:600c:520b:b0:40d:88f3:a68d with SMTP id fb11-20020a05600c520b00b0040d88f3a68dmr1513203wmb.209.1704320315878;
        Wed, 03 Jan 2024 14:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWCoxB985xTGnKum4aAAMUmi92Y8eaJ1I0Lr2U7JE9EGJHFvOCANK9tPiNsUkZoDGTNBIVmQ==
X-Received: by 2002:a05:600c:520b:b0:40d:88f3:a68d with SMTP id fb11-20020a05600c520b00b0040d88f3a68dmr1513194wmb.209.1704320315584;
        Wed, 03 Jan 2024 14:18:35 -0800 (PST)
Received: from redhat.com ([2.52.4.45])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0040d91930f93sm2798635wmk.11.2024.01.03.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:18:34 -0800 (PST)
Date: Wed, 3 Jan 2024 17:18:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
Message-ID: <20240103171814-mutt-send-email-mst@kernel.org>
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
 <20240103135803.24dddfe9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240103135803.24dddfe9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2024 at 01:58:03PM -0800, Jakub Kicinski wrote:
> On Tue, 26 Dec 2023 17:43:33 +0800 Xuan Zhuo wrote:
> > For rq, we have three cases getting buffers from virtio core:
> > 
> > 1. virtqueue_get_buf{,_ctx}
> > 2. virtqueue_detach_unused_buf
> > 3. callback for virtqueue_resize
> > 
> > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> > 
> > That will leak some memory, because I did not release the pages referred
> > by the unused buffers.
> > 
> > If we do such script, we will make the system OOM.
> > 
> >     while true
> >     do
> >             ethtool -G ens4 rx 128
> >             ethtool -G ens4 rx 256
> >             free -m
> >     done
> > 
> > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> Michael, Jason, looks good? Worth pushing it to v6.7?

I'd say yes.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

