Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6528E5FC
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725893; cv=none; b=WV7r7ehoYp5C3fPLR1CJE3AsuLf3InHNdNQ8K4x7VhgdtgrGIu/4T1eE/I4VNdiaCLhNd0DpAuswdnOaAcVwFIDVXcn/oaVML6PwtSOP+fu5TbDcVF8iL1tIMBF11Q3OWlDA4/uFXSEfKsRaXQA20sCoUWZNenhJ8owQuv2x/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725893; c=relaxed/simple;
	bh=QXP9FxMrw7KNSGwJPkQN8Q4+F9sKVBVOP6V3LiUSFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UQjSdXie5mIdGYMFPUTScVaPnIxV1NfldIZKWTgNXSKpmDoL2vI5pjt5yRra0u32ZEv5oIWVnek+BJOOWr0vr+luiTjovczNK47XUSMzsfu67flbYeAU6TGRwBiOOg5VG/+48zZgVrfHyNKtXUujU1I5FRy37cQfDr9bZ/1mAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKxb5ptz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKxb5ptz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744725890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
	b=BKxb5ptzYCieGjbhUBpuISLlRTjvhxhXtdxZTgHmQf43cyAOnm2dRBLFH56ZhaI0kHb4g4
	0ibdiTKEMUOfg2uleC+LGKTdP+pwH7cR56SZLE4afWiYEJMyLaD6xSIDLIrnAnpb0tE9Dk
	0ZfvbVmcHe9jaHxZkfRqvCA3/TTQ0Rc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-wiDv-8kjPvqD1SI7Ru65cg-1; Tue, 15 Apr 2025 10:04:48 -0400
X-MC-Unique: wiDv-8kjPvqD1SI7Ru65cg-1
X-Mimecast-MFC-AGG-ID: wiDv-8kjPvqD1SI7Ru65cg_1744725888
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so39878205e9.2
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725887; x=1745330687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
        b=d8X+IJEP9OkYflp8lIuZhWbHyW39wwuzPnoX56TkvGGZCZ8i5H2yXg1dGPU+8YSRnE
         zM1F3LPNpwq4eNk1rpg2JLGPP1vNhzta4STT/ExMRsWyzXvZEtYk+q0Y5bacOqTlAb22
         EzH0n3+wAsotB/6wXNr/LIrNkabovRQyJlY6YRQAhYmqzfIC36u7CEL+/4srZfBiUnlN
         hfXXLvdcNG3xLDZQdAZ7PX7J/hwMP8rQODCjqfKFWf3hezskouDdDclVmvojXeCcW1pd
         iFP8khrcGN62avxbqALa2JVsJml3PP8zoWcX3Gpbd3+ugaJuY4+kyQ2yzgNEjF0rN00t
         VkFA==
X-Gm-Message-State: AOJu0Yx7eIB4mq8+lazunwZWddGzIsF2GJbel/rvbWccV/3aL/slC8hm
	85oxLYDbQCbNxqwc1v/wGZy2HwHPJ77oNVc9KiEGg7Or4ZRisJmMgkBD/rosyW+yJs0UwZ9hARi
	LSr1stIXlTnCba9lbJa9/XjhcgrQftSn+C4mqwUbKhqwcl6TZdXhyoEIHnwn42xlb
X-Gm-Gg: ASbGncuELP3CroKuOrmSLmDmflT+xXYhKlTMNAukckWs/eo0cCWwUhBrycqGR36M6+T
	IheWe6PN7aLpCLmWb3Ob3fTD8AfsPDI8HGS9zqmApFwcaqcc6aswHQMnGXu788WAfnA0f/t2/cH
	tc63MaB3rtl0E1fgrJ6+481MnBIPrCcC8gUz3ghxL4hXKDbpeeC4BLdDD0Hr1NFopgmfUWZTCWA
	81tpBuockfGVnjK4HL3HzxY5rt78LUsSGkjw+0uefM94rwBbxCSIyf5p6v6bJDJgC9K4b2iMiu3
	KY5wpQ==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130332915e9.8.1744725887410;
        Tue, 15 Apr 2025 07:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHITYoM+E4rIVBkVC+Zy7bnyx80+fEMQuQMdwZhPsCxD1+xYR+TZ77Lv7xvd8u4v2RkPh0L7w==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130331785e9.8.1744725886545;
        Tue, 15 Apr 2025 07:04:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ed041sm210253075e9.2.2025.04.15.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:04:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415100425-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bsi2V2Q0njgMKPpmIIdCimwoYnu-K-bTPJijYeWaJ80_1744725888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 02:43:38PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series tries to fix a deadlock in virtio-net when binding/unbinding
> XDP program, XDP socket or resizing the rx queue.
> 
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This fix adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Bui Quang Minh (3):
>   virtio-net: disable delayed refill when pausing rx
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add a virtio_net deadlock selftest
> 
>  drivers/net/virtio_net.c                      | 69 +++++++++++++++----
>  tools/testing/selftests/Makefile              |  2 +-
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  .../selftests/drivers/net/virtio_net/Makefile |  2 +
>  .../selftests/drivers/net/virtio_net/config   |  1 +
>  .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
>  .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     |  0
>  11 files changed, 133 insertions(+), 17 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)
> 
> -- 
> 2.43.0

