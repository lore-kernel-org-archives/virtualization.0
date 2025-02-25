Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F31624DD
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498879; cv=none; b=Rlrn+DyvjEcBeFo+KQujL3R2NwAPLJejSAsRsg666EgaMBXgPo7pDQLdjSCocnoM1fcRzqKvPJ1RSkficsLVDBTb9PvS/bne6Y/RXz3AoWtWfXq0pwcHL/qZhwPA+hyYnZYQmFTs/GqkXG0rzDqE4Cxens/LjivZI0Txnzx6bTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498879; c=relaxed/simple;
	bh=B6guPeoLoNZZxbWYmAHZ5bN7rRVPk1E7b3Qht1EElwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eR3jV+PV/utn/+SA2t7Fafl4ID6bffBVDPCBSZtPKMTPvtLAISl8LbNmiyChJBEPsa5c1oiMdKkSpwTOkJTaUMrPWt/wnD+u7gbhTR8M7gpQrR4ZdR3mEboPfUwrO76oO4hmMnUlFubsGhW8x7tHwIkYzs2s3fXYw4Th5u5u1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHYEhFKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHYEhFKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740498876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RM+x+J7eeR+zYm9ULF/axeMhLxPe1qiv9A3ZyXjbFuI=;
	b=RHYEhFKDGyXU0ddlAZprAPlEGxsFhrSGfGyqwBQzkpyMuKzWNQPplTJu0xyE+3MKxBu+mm
	/hgccQz6A+8kAbMfBS4FkpgQjCM34FKtchBuT4jYsy8SnVZkeOdoyqrzGW2s1oeSmRyApr
	a5FdYgozg99r8PiGbi5QQ20nzusMMh8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-9taXhVSYOAi4w7crPb5PvA-1; Tue, 25 Feb 2025 10:54:33 -0500
X-MC-Unique: 9taXhVSYOAi4w7crPb5PvA-1
X-Mimecast-MFC-AGG-ID: 9taXhVSYOAi4w7crPb5PvA_1740498872
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f3eb82fceso2258141f8f.0
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 07:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498872; x=1741103672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM+x+J7eeR+zYm9ULF/axeMhLxPe1qiv9A3ZyXjbFuI=;
        b=JE37lsCgTg5mM0UkOCsyfI33D7b3Epu/qhnD8ljEApz5mm135FyfsXQq306jC3KsL0
         BckdPvdCIN6T4luNKOjK9H3h9szagqHO6BFCVbQDbBJr4PV8qoHQxArpyx9obnXKVMLU
         Ww6ufEt2XqDQGgT8aWbMwHmherm0b1eW2CUe1C8+DZsvbgsaRHDFdyz0JteKZe7rxRnz
         KBWzeRxjBMtv3U1UF37o8C70T+eJOHPjV3/uxyydwmlK6bCD3PxYYnYwiU5wwF0lbyr2
         4mAWMHJW86CzwDkf5HI1pFTGqmrAhs4zu35n4E0GQFQqrsY8+YqlvwhgrU5EunJDlMBo
         P9GA==
X-Forwarded-Encrypted: i=1; AJvYcCUT6N7jygUt2VWgOhzrDyNO0SoTlKM+jgulGYTI/Hg712uecS1OYHNYOUOjJPwkNQUBbc/SY/MtkWBRVuJnZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxslFPOLR5fwbWueB1+nrrGsSuHcM//0tnH4+jxgGyEf8CdEQGY
	AqU+Ady47czQk8EUvtHvs5VJTx9Nt6vH3vZBoxshYeW1TL9KIDQ5WoTJTZK1y9BoPcyJIvEfcCi
	NgfY/KQru8CnWFHQklVUgO/Y4QCB/X7BXOIvSgaZmpi8207rVkMcxvh6R8/Ge/pbO
X-Gm-Gg: ASbGncvKvouN3ckR43169COeYl0hZfMkr0glawjFqQIdrxrUwdJDYneRPhLdla/KYL3
	yTNx9c/h4ZfNoGMntkA49U691X3hfu94TI1mBhHhUD2qfxcPhdUX1Us0wUudGYkR5L4PaJiVJef
	AYKZkbwRb54IgVJaJIqsl0QfPjJA4x4pzGA4kY62fWeFmh33jtxnohEgr4RqGA/6Mps2jARs/2+
	bnVvL4M1N95zrtdKZihXMmNAWgt7/IQPf9Qf530jDQnVOocGilBgYHuynWgYQ/L0DNRcjN3zZiC
X-Received: by 2002:a05:6000:4008:b0:38f:4e30:6bba with SMTP id ffacd0b85a97d-390cc609228mr3580793f8f.23.1740498872418;
        Tue, 25 Feb 2025 07:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN4AARjN7wYgWWN9IZdCNUwZ68WPfkZ8QQrVfbimeKsOa/InqaQkeFml1FEQVyd0AsQFCcmw==
X-Received: by 2002:a05:6000:4008:b0:38f:4e30:6bba with SMTP id ffacd0b85a97d-390cc609228mr3580751f8f.23.1740498871961;
        Tue, 25 Feb 2025 07:54:31 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532d9dsm32083345e9.6.2025.02.25.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:54:31 -0800 (PST)
Date: Tue, 25 Feb 2025 10:54:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
Message-ID: <20250225105420-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eh4IHpOCQpdgrDUuJV0bzHL8siyD7UpZxVdCzFm4nog_1740498872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 02:04:47AM +0000, Joe Damato wrote:
> Greetings:
> 
> Welcome to v4.
> 
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
> 
> This is a significant refactor from the rfcv3 and as such I've dropped
> almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> and Jason; the changes are significant so I think patches 1-3 need to be
> re-reviewed).
> 
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
> 
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
> 
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
> 
> Thanks,
> Joe


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v4:
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
> 
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
> 
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
> 
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
>   - patch 1:
>     - New in the v2 from Jakub.
> 
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
> 
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
> 
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
> 
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/
> 
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> 
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
> 
>  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> -- 
> 2.45.2

