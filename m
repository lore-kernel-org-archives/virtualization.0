Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B64F1F7
	for <virtualization@lists.linux.dev>; Fri, 19 Jan 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667301; cv=none; b=u1fe+5lKzGAY6WOg06HEDMrVwlWihzOhUVhTZxGN+T7ORNrKOI04DjZj8v3ZFk5lsDeEZ/Q6klhslJGTEM3oeISZ/yVxwauUeFLIiM5eQtlkt1NKTeKEZ+eycFb68Q22uMr3yVOawOpdC9+xCfoTAaW7UMi1gc26OqopjrMGDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667301; c=relaxed/simple;
	bh=1yd3vuegWAMTRKs3hhq9NTSKrABM16eTj4S5eR2+1EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KiIxJgB4XRm2nC8OFJYuz0VOpaVHyUsNLBoAgcMzlY3RbS6qZ72GWCN3qTo6qpk7a4Vftlo5BiFkePxquvH/Fx+nAZuVkcgHTIquAGGvKbs3V9KjIWhYJ7mWci6vS+zvuTITVNupU/XR2Z2kohY8J/9Kow15duAMeBE8cjAAIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/7yjW6O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/7yjW6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705667298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu6PAuD3ioFybCYQzDmdkPHOFHjBT1D9Zj6epg1rV18=;
	b=R/7yjW6OS7Y5B1TxZ0xCJc4NZUfov0iHtAaQh5mLyC9YnFmtogVSBWLdK3LXaHrBS7PeGB
	qGEmcY4KH87TfyNo+8YdpD0NXM7n9+KfLGYmW/5gggKubtaYbw8+yEQhUnSCq3YExpajTu
	fvWvd9Up4giCB/ji3iL9iQGh5irxQGE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-CqkfJLUHNyGmnhPyNsVEWA-1; Fri, 19 Jan 2024 07:28:17 -0500
X-MC-Unique: CqkfJLUHNyGmnhPyNsVEWA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e5317c7a5so4564655e9.0
        for <virtualization@lists.linux.dev>; Fri, 19 Jan 2024 04:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667296; x=1706272096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu6PAuD3ioFybCYQzDmdkPHOFHjBT1D9Zj6epg1rV18=;
        b=Th8ofab92lmrDg88mDPbhRb4nl56H/zMjeDJ8HV/00jKIqqCch7k7P/Kk/AlFId128
         m57HN6MK6ooofHd9N7KP0ifZHDFKJa4ywHz1xxsnrU/d4vel4IdFiQTp7nUAXWXM9+rN
         Z9exmk0FSbAgGXNK+JDyd3UlisDCevJpTn9CQ94drnOyLNaeEnR3p9oJY+ElfTdCYa6R
         k9+6VhtQuBwPNVqlkACbLWDsHhI47Zx3Mgfcy5/KMZfHcDhW31+e5Buh2fN7iaWx1Zmg
         lapcFBRDNcoqvU58ERz6dZE3aAxChzPjkRCceQfGzqSF/6duzCpjrZPmUhduHJ+pTwLt
         wh1A==
X-Gm-Message-State: AOJu0Yx+910/8pl3pQmIjRrG0xH8rrH2fZl6k1QVMnxdrUUF15vdEpYy
	PHiVyHHE838y3o6MQgV5bM7efqAVmQuBgVAE/qHXestDIujzWNBb3SxsDM1BMmx+QbhI7PACpph
	/W/Xw8b/17w9yteFxkC1SvJXAP+Vjz3L1Hu45+7dvvphLep5od0KoC859G2qdhu/k
X-Received: by 2002:a7b:cb4e:0:b0:40e:5c0e:7dc0 with SMTP id v14-20020a7bcb4e000000b0040e5c0e7dc0mr1379246wmj.108.1705667296102;
        Fri, 19 Jan 2024 04:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRQ7q2eviABxb53dq9k0UI+qYO9BINyvJ+P81JZeeN70Ba5s+vjtIaNcbP8LhhKGkob4YTzg==
X-Received: by 2002:a7b:cb4e:0:b0:40e:5c0e:7dc0 with SMTP id v14-20020a7bcb4e000000b0040e5c0e7dc0mr1379237wmj.108.1705667295747;
        Fri, 19 Jan 2024 04:28:15 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:4aad:e256:6d9f:7a0b:7f5b])
        by smtp.gmail.com with ESMTPSA id iw7-20020a05600c54c700b0040d604dea3bsm28406255wmb.4.2024.01.19.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 04:28:15 -0800 (PST)
Date: Fri, 19 Jan 2024 07:28:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/3] virtio-net: a fix and some updates for
 virtio dim
Message-ID: <20240119072743-mutt-send-email-mst@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 09:11:30PM +0800, Heng Qi wrote:
> Patch 1 fixes an existing bug. Belongs to the net branch.
> Patch 2 requires updating the virtio spec.
> Patch 3 only attempts to modify the sending of dim cmd to an asynchronous way,
> and does not affect the synchronization way of ethtool cmd.


Given this doesn't build, please document how was each patch tested.
Thanks!

> Heng Qi (3):
>   virtio-net: fix possible dim status unrecoverable
>   virtio-net: batch dim request
>   virtio-net: reduce the CPU consumption of dim worker
> 
>  drivers/net/virtio_net.c        | 197 ++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |   1 +
>  2 files changed, 182 insertions(+), 16 deletions(-)
> 
> -- 
> 1.8.3.1

