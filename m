Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D41236421
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570159; cv=none; b=OjG5Ar7u7qIOLskcHBT4vFV53idws2ha87iWZ7B6zkCptc3TS/FyCMNs88tK/aIr55NC71lyx1I7iaWN12Uc30/n74Y/eRNJQSiuBbwZOI9ddqMy+u3AFbqZgM1NcAso3s/Dam4qEtu6nWlJzh1G2qYuDH9lmXsrylzHHCIZSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570159; c=relaxed/simple;
	bh=W0OGvNpepYMtQUI2P000WddWaGAaKqDLXnohX671FZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R7d+Kgxk2me2XQJoAEWW20y0zb5QDgxVi+57yQCATTf6EbOZFO1gvb4ypnimMsZWzoDOUDfzQDQRzJCeeJWCstvC30RQqEVqRPGJeSxTPTlD89PHs+eURaUF0m7C8WxX0aK8MGzkkIvatYhFTUJT0Tp6N/jgrYK7NFx8scALyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nj7RLrD5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj7RLrD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745570156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
	b=Nj7RLrD5B80FM3sfw8qVVXIidHZHEw4rtlx4Slvpvu/61122WCGQxPj41SUPpgLBCAEEov
	blVqFRJJBMtVflgrm0cK2FX2oAYnOBzVkKT9jZ1HjYJofsu8Gi6Ur9PlUCGobBuZZo1JTz
	o6KRpT7IeiOy0Z/gwnko3eX8zdzpl2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-uNpY1C1lPp6ABHIpD5LnTQ-1; Fri, 25 Apr 2025 04:35:53 -0400
X-MC-Unique: uNpY1C1lPp6ABHIpD5LnTQ-1
X-Mimecast-MFC-AGG-ID: uNpY1C1lPp6ABHIpD5LnTQ_1745570152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so11566725e9.2
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 01:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745570152; x=1746174952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIpzb0kJnabV+/Rbk1AeDaWRoPqgDoiA6nLSqcAP3Qs=;
        b=NDuppNNfinXGqQG4YXB4FhJKYu1AFnMyiJUCe6OT3wn7UBjVnUh1AVBhj+vO3M1ozm
         aFBRQih3jSMQb4OceyScDrBM9HBF2p1Qd8oV3w1xy726NVuCvlEjtsQetj1qBzcXJQoZ
         UU8NDjHIvwwxccIVqXhchbsla+F7w5c4KdByoQ1YiBuM2fvS+OeRSHR0ckT4Q95sWvmo
         tmy3N4z/zrZUGnRPShWVgpnc4U4XlBfK+KfmVUl8MHKQ+ea8M27ItX2AXR95ME/OjGJg
         PnPQIQo1MbfJOFD79F9lCf3gc9ReI3EBk/wURDQlfj+X8m2UY66YKHGoVv2UxXaONX/c
         ixdw==
X-Gm-Message-State: AOJu0YxPxhYfSoBR+drlHsJteS1iFO4X78Dd0mSOET9AT2SIztKbkS3T
	0CRFvGsR+kvzqI5lWk1cwt2FTrbkQKsfodWrn8yyCiY/1YHIQBc7fGVOvpUiO0V8VuBCcQIsH3X
	51KKcq+3TBrq+yh8yWtgyJwk4kRkvVMjDV8Mlmz2oLf56jOtqE5I4Xzl9IxaDutNk
X-Gm-Gg: ASbGncualdXnA7Vma2bkPqPQoPZXMKn5MdRQKLq8XyecKSVHJXLeV39OQMgFTWCFybF
	aDX4FKSypzBu7Ch8fvBeVsuHeNecOr7DCFlWFDXd29g8Ubo+5d8sNMWvEiBYtqgLJJehZKLRhkx
	kSa0XmZ8hAHxjrLK45Ej63TvGdfUZFq0J0OI2bNSOnIx3bPkGiLLUWH2VZdHz1U/bu6/RPoHe9G
	bjRTPid/XarbrBdVNxByYT0dos0lhE9PXZki1d4BGiYF1mhkqeoRtyHJn4Yos8hws60KFzAK4uy
	7G+tiQ==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12028245e9.17.1745570152502;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwMxFD5f3mySi27LmA61xgw9SkI2YEf5bOWu+NSzAJvOJz2O8GeJpN1BaqSOng5t4z7wJTg==
X-Received: by 2002:a05:600d:19:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-440a66d9ba5mr12027935e9.17.1745570152192;
        Fri, 25 Apr 2025 01:35:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5310a8fsm17114375e9.22.2025.04.25.01.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:35:51 -0700 (PDT)
Date: Fri, 25 Apr 2025 04:35:47 -0400
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
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250425043542-mutt-send-email-mst@kernel.org>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hMFNAgBFoA6Zr88YkTrBNyqs14GilX3ZbLXgv06ewoM_1745570152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 25, 2025 at 02:10:14PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 6 changes:
> - Rebase on net-next and resolve conflicts
> - Move the retry logic to xdp_helper
> 
> Version 5 changes:
> - Refactor the selftest
> 
> Version 4 changes:
> - Add force zerocopy mode to xdp_helper
> - Make virtio_net selftest use force zerocopy mode
> - Move virtio_net selftest to drivers/net/hw
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (4):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: retry when bind returns EBUSY in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  .../testing/selftests/drivers/net/.gitignore  |  1 -
>  tools/testing/selftests/drivers/net/Makefile  |  1 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
>  .../selftests/drivers/net/napi_id_helper.c    |  2 +-
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../selftests/{drivers/net => net/lib}/ksft.h |  0
>  .../{drivers/net => net/lib}/xdp_helper.c     | 39 +++++++++---
>  10 files changed, 98 insertions(+), 12 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (78%)
> 
> -- 
> 2.43.0

