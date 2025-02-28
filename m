Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B01FDA8B
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730504; cv=none; b=X1qQzFiDDQG73IEjHGU4y53n7sGUdd3w1OKJv9NZQQIvwCitpVcXfQBL/Jd10R4p9PBrRhFz5wRxv/3OTgAsR6k1av8duAa8YYP0XCQ7/o3iHioswti6X1RKSTYV80M2HSdtRiCBTm3GT3f63xIvRqKBRDex8hsN6G7VgZYGytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730504; c=relaxed/simple;
	bh=i/awX897IKbbFPKU31yR0reOKho27xl7tHdkuuKPePw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW7IEUImAMVlJLT12dWtSZ7JhD5Dnv2dmLgr+bvIL2RPQAFpzPaP4KNjlNGJ+/OrK3QitPXFlKMOGMt10XsRdZJxDvth1GXYlrFevcey98NKt0x/mWuMNGyMOdYZEUFvuubrZJr/mvgRCTPQEpK2hNntqBpAn893VXiI4Ok4ZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVTJu/wT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVTJu/wT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
	b=gVTJu/wTgPW4g48QTANl6MN984ebxr0XTYS5OkkIqJn6sV9xFlszVOfvW92NMyCLvr2uJS
	yg3VG0OEMxGCfw0qxI/9PK7bM0T/+E5aP81U0M+w5rDOtXGe9Ir2YKbgxeBkI3qAnp8QFA
	xg503oC0KWdKrNQgOWxMk/3xsG4NTvM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-TXujUVuSM3qs-LxRMNh_OQ-1; Fri, 28 Feb 2025 03:14:58 -0500
X-MC-Unique: TXujUVuSM3qs-LxRMNh_OQ-1
X-Mimecast-MFC-AGG-ID: TXujUVuSM3qs-LxRMNh_OQ_1740730498
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so6629631a91.3
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 00:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730498; x=1741335298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
        b=Css2fKoU2zCR/c15iur+kEEiFP/GFJ9SOdltkIFfTm6ATS6+S6S8EIIRFXrWRLj1oG
         mfIeHnL0AOD1hYku0Nfec4sATkbwd6eoX4HrMSPUrpbhbJdFwq2Zygn23p4eojVr5MP9
         CVQrZ1/+t9DRqjkpSrcVDbPwFjOs3/wIUF029fC7Q+7/Qy4+fy8Oc8i/b6pa0GVyT7hn
         Ww8hETSO4sto5HnJGIMHdG4T3KcjOQ2loHGNB7S+KiC4Jc+uQPaGN125EBEvxKjRvf76
         HAFNi2R8YZI/WNKrskYq0hOTCBV9Ke1soYmHz8dhBInuCZie0umCAZeKsdk7/7sxRonB
         SZbw==
X-Forwarded-Encrypted: i=1; AJvYcCX2AtIv3debP8cUX4B8z/WwJ4ZBlWHbQPGVcQMCn+oTu2ua0LtSQXf5E3huXGBJJPnNoyA61y4BJeN8VeWiBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO05UpM7uBBTybg5ztK/MPirFCNkGpiBJKLtG8zpsOR3XE7AmE
	1/hDAMCMoQ58gPNS3rwIT28BV+b6IyFItgUIvYSem2/lpt/ABea0O6NHtMl+RvkZmGZJU/v7lBf
	9uxhgAdcSJ2Ao9yEJDYE1LP08jMWpDFcqGttom360iMs4K0Yc9dsIM6rMOo7JpvlddHM3UxC7ce
	SMd7Va8GNWgRhyUaWAGn3Gl1PqROr+KIxY6JgzL+E=
X-Gm-Gg: ASbGncvKydgMLDHBJbc26vVmWXoxvhr7WMA1us+Z1qRe3jZCjxKtD9mZj2leR6VgmH5
	zELN/HymOhEhqCg83M0EmZ2MWC1VF1Vg+hHxmFgrKmeatrS3yPbPlIvGxUqAwAYvfAGdxlsfcAQ
	==
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2febabd9c6bmr3713395a91.26.1740730497705;
        Fri, 28 Feb 2025 00:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcn+x0GZCIknQ4zTQaIWwzNhdUzSiOqz72PNKBkKpuyU9ZwZnQPTZZgdJG8a4JcV4cazyA92Z/y0DGoohoCj0=
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2febabd9c6bmr3713377a91.26.1740730497420; Fri, 28 Feb 2025
 00:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Feb 2025 16:14:46 +0800
X-Gm-Features: AQ5f1Jol8DOnnluZJdrms83ewIQuIWuNFxqYbgH6IOJBaoShyIqsVl50giYriC4
Message-ID: <CACGkMEus3m5M5ecA4u7irKd-N0p0=ZjnAPanLk-YJgoB6jhgBA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	mst@redhat.com, leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XMqLYLfvdSXeuv19O9B6cqix5p8rbAEBrNKzdHjl8Vc_1740730498
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps. Note that the netif_queue_set_napi
> currently requires RTNL, so care must be taken to ensure RTNL is held on
> paths where this API might be reached.
>
> The paths in the driver where this API can be reached appear to be:
>
>   - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
>   - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
>     an ethtool ioctl or via XSK - neither path requires a driver change.
>   - power management paths (which call open and close), which have been
>     updated to hold/release RTNL.
>   - refill_work, which has been updated to hold RTNL.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

