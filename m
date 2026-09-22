Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11274361DCB
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040798; cv=none; b=ohfzWN3VF7GNSBojbjAckavWTL8yOQ3Hqc9/aRTIYis+YQti3uu1UeYhdLAVIp5xfy8Y6oxa2ao2QL4IWTDtajxRCfwJ3/T5b5u1lGVtKjS1jlfZ7AsW/UvPmFfnksc5Q3dWUpGoQHlR8w+LlRd9x6xsjnmuz7V/f+Fvx/CrzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040798; c=relaxed/simple;
	bh=RwQjF5gp74MpRivf4d3S2U9VdDQkXPXaJDMAW5/Hpzw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GtqIUF1X1x/oJQbsA3olSAzejOyFCMuPpwgQjZ0qQ790Qbviac/CTrSwdWYhLnfXxasHILlccbor5LNB+S9DaXXEghrSRkLKDFjPJ0GJ3chYA6QbO6G0qTkvzhzwthHxsAgwcQTpCBRR4vBAPbBUfMqQk7o7lsmqwJz/Rp07VKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvU87o0h; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvU87o0h"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso30253027b3.2
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040796; x=1790645596; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ay4065FSvCY9ZRaYwz1DEwsmCGDvPHvVukTn40zk1F4=;
        b=cvU87o0h7qPJO+ceKD0IBm2SM380QvbhCcqEyzCrqVSUuL37V8hfAu7udolBFLQ6Nb
         FUrm8S7KFXSYDFHiCYP76sUX72Z+H/lv+xJHaOJRD5uNUoPDuELKmQO2pN86yUbFZ7Dw
         9+ZfSFXvoFRW53fASuRRsJi1HLm7dWG+g5ooHEsBIeNJve5C88jt2/3ESwyjK5J3L+/L
         6KfarhljjHj7rSUaLEHjik7WjhvfTNDRYWc1avsTV6MUu96gxcCqL5xSY1pdmZRqbt79
         GkYw+UfBbm2p6dJmEj/vuY7lxXFdtyaFY7lJRiAHm+XBsNVZlmkejzGTCUPxsVo/cHZO
         XBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040796; x=1790645596;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ay4065FSvCY9ZRaYwz1DEwsmCGDvPHvVukTn40zk1F4=;
        b=A3fi0w6kHAvS6SWQK0Q42zfN4WkjXvpP0gvYgQGLctbKPng6JwmZKyyWU3xNX69Cno
         eI9oEbsiMy6QyqLUg/AT/pP+mwYjmdXOj9gdEvN+Pxk7QPWPEBQvkTAVHO86Q96nMBJr
         ZzfWJ0KouHMz/hutAqSlHXWRZQyXzIUh48Ml1m+upn8PO3Ddzc/jPvj5LnTjtmAgewZO
         4vjRtDDp+1bCpkHEea/YPx9U2YJMzpRY/NzGvblLxA51vZ4g8MKriXJ3C8z1maWSQ+k0
         wxoJhUdUngJ5pGHK+tJZeJg02f5BmrCQpWBfD43wkXg0KFPLnACeonVAJQuiu7gf5mf+
         khmw==
X-Gm-Message-State: AFuF++loDGh3pKwPy/p0xPCCN9ZtYzO/lFq3PJAzDWFzZGiWREDBmmhQ
	1vj1aUnXgmIMIjpRXGMrX4Al/WakiVMGLU3X8+1pDzG77BYVX+11s4qO
X-Gm-Gg: AYBFou1K2feBZ/yrHkAtGX8eQ5MpZteb6uTE7dXfTFLtlpLlMSsWakCvaPjhYFk8eD7
	LfNCaKZZGPVk+heUDNzhCTcZpBd+BXm2a5OYcS9lGGHpz4P50aSACC3Bmxxl9bMjHU+a1JU05Ri
	Ys9Vump1M5MeyrX2UN0h6qb/RF5HGQHyT+/QCAIBh1eFpde8IzjRkbuNr2XHKUgsTMvlb0dJ5jU
	xm73yjET6pxl8nvzGkQMLWKtUo+EG5yY6fcX/c3bQ33dAM18KXVjI6l0TZ0rkTwm0sIub1XLC3U
	Rz80Qb6xMXl6CKgA2z1cnQeiK/WJsMj5d2wZ1mHKBAV7ZEk0KDx1lyjjrBnYl9PNRs5fTjh2bd4
	LMlV7NPJt/+P9efBW+N0CAGTDBT8is2wjMNYHj0+O97wCbd7CZT9MnGYyV4+nNQcIyPL9qWl8Aa
	kyXek7P0UuPlQ7AjV0jXvhtFZa8+luQQPpiePJJSGvXXhhLGC4fi+1kTH8af1c/RrVaaDC+9uOP
	cQnwTkEHUeg8753D/4ywWvTyvYJIzbIoxXW9WKYgkgVnu8UMOB6
X-Received: by 2002:a05:690e:1c09:b0:672:b6ce:62cd with SMTP id 956f58d0204a3-672b6ce65d7mr1585414d50.69.1790040795858;
        Mon, 21 Sep 2026 18:33:15 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c768e6a3sm159526d50.18.2026.09.21.18.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:33:14 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:33:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.3b33970b82622@gmail.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
 <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
Subject: Re: [PATCH RFC v3 1/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> Add optional hardware rx timestamp offload for virtio-net.
> 
> Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> virtio-net header is expanded with room for a timestamp.
> 
> To get and set the hwtstamp the functions ndo_hwtstamp_set/get are
> implemented. This allows filtering the packets and only time stamp
> the packets where the filter matches. This way, the timestamping can
> be en/disabled at runtime.
> Currently, timestamping is handled the same for all supported filters and
> therefore handled the same for all received packets.
> 
> XDP packets are not supported and timestamping is skipped for the XDP path.
> 
> Tested:
>   guest: ./timestamping eth0 \
>           SOF_TIMESTAMPING_RAW_HARDWARE \
>           SOF_TIMESTAMPING_RX_HARDWARE
>   host: nc -4 -u 192.168.1.1 319
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> --
>   Changes to v2:
>   - update filter handling
>   - move tstamp into virtio_net_common_hdr
>   - remove new struct virtio_net_hdr_v1_hash_tunnel_ts
>   Changes to v1:
>   - rework series to use flow filters
>   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
>   - original work done by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c        | 127 +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_net.h |   1 +
>  2 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..ef6238cb336b9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -416,6 +416,12 @@ struct virtnet_info {
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
>  
> +	/* Device passes time stamps to the driver */
> +	bool has_tstamp;
> +	bool hwts_rx_en;
> +
> +	struct kernel_hwtstamp_config tstamp_config;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;
>  
> @@ -499,6 +505,8 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
>  	};
> +
> +	__le16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
>  };

What is the alignment of the structs in the union and thus the padding
here?

Moving away from introducing a new variant of the struct with every
field is the right approach.

I don't think virtio_net_common_hdr was intended to be extended in
this way. But it might be the simplest approach.
