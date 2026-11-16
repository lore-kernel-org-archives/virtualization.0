Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862883;
	b=MYv+sssRceZgXTeLcPVfOyG4mf5/BUY+rTgLe8kJVIcX2kzdaX4iNJ4Lc9shSh+jyuns
	 h1ZukrD0ZRUnt98orqG5XwDVvqr0ofW9W9Cs/hN7LXZJxkEZixrsd3T43b7ONXCwiaR0l
	 cgzOKwIkLv7lfJ7ub1f0z0a+JR+3nb0T4cpwOsno/Ar5fMnOdaFTJp7Wt8zbzjwUrfkB8
	 W+h0E+nliqCFYNM08krTj+0E7sd9oqaAaUEE7Y6VH2TZi36vBZ/CXwOqeSC1shDs/1nvY
	 KSe6XZY+hHR6WozuMVGYbGOgPinzIogipiLmw5t2NwGG6l0mrjV510DKnHbubbkRvLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862883;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=uDmW6EN4c7C2wlqCaHSVu86+GMYoHtOxEPlXOYNTjbFP7t6gUIbq6jZaN+hPsTSJaRpM
	 +4/7oTq8ByTn0b00lL7zo3l2ScZ1hbReL/oWPl7w2ggL6TN2dPq0zd6QJ/Vtf1jIgQjwT
	 EathbkTgzItqBzPOLZhlei8nSLh+tWqhB5a2f4eudhf+lvtRtXCTrwmtbLe+9kzrxn9Dd
	 tYUCjG3oS7lyimY+gv+4nCUDVqAh2ByYPLT63gD0xGtuMJV+cKHw10gjqdfMHzULphQMj
	 rX4rbFPnNjXOYOzFWOdmTDBN+pDMpDarK3AZ9DL3keZdPOztOe+PWoIaotgMFwYvRwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6uUzIuu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2C606A333
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 21:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C2C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6uUzIuu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794862881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=L6uUzIuu9sGhWZiaXdVNhmWShvxtQC9UDHSuU/qCHzS0corWiFXBXbybYvNUI9qDheRkPF
	R6EVj4NCJrY2qUO7YG8bWn9LWTbaSzdBmi2BTlOeIyQxHQtOz2bevupKBQbaszHX6VrPCD
	UKlk/aTPNJYakgZ3hLi/CwIi+TUV0Tw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-iOrxqjJXM3GDKxu6shk_OQ-1; Mon, 16 Nov 2026 16:01:18 -0500
X-MC-Unique: iOrxqjJXM3GDKxu6shk_OQ-1
X-Mimecast-MFC-AGG-ID: iOrxqjJXM3GDKxu6shk_OQ_1794862877
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so20143965e9.2
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 13:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862877; x=1795467677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
        b=QyVFpuDS9aSqGnSlxAUX/zGosRN2GO/9Jgbl2fo2Ya0O+UFnk07l2vZhahzM0NW/by
         5Cg2lAp+gLFQ98D5PIie3PBocWaymEKP5V05VuSalB3UV3N2AWZjkNB3c4ZhoYqUw0MM
         CSavgYUGgoxZTPXiaM3zLAJG2e7LN3dLyQA+pzTJaBa308SEcresIF4PSKMGWAqOwQW2
         YC3SvxJ7HWJkXr2FqxtVgg9zVuLKhmmGNMKRofmKs6DNzDE0BLWqReZChgIVepZPpI6a
         LD/8+7FxppIy4A315kcaROVy6MxvOqBPH2OulQqjfHWt1CBXSSjzeT9pcYb7CA6prIeL
         c+0Q==
X-Forwarded-Encrypted: i=1; AL+hErGzlsjNBExQEd8hLYrTchOVw2x71EwCQCYmi6Znj45AVOQqJO/WiIkcJJTfACZgkGGjCDfq38Hdkc48qNtlRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/rwgprXZUvESqnvwe9wmPNmo6MWyEgxi91Snd4DugFMaPJPOnY
	ufHih9w+KuXfCfhZVa7Q9wahxB/rwH0GyDjMaZmle4Md9imaAbxEBe7kM3fHt5lg3voxBUCUiGK
	L3pshK/kKno+HZjqFTiJ3DLf3Qz3yy7st5tkl6BvV3HH4IDr77ssLG6NDKBDIZuYiM5Dx
X-Gm-Gg: AYBFou1iRol4RE+2FRWjp1Zye/+qhKgKB8UKw3wVue5Oz0iW0tGX+zfidrxTU+o1XqK
	4erscGDW0QjmjzaN4QskCaTn19AiEgbhNynMCBd9z1TOJP/oQRqYxkjQlvXi6pBL4pTj03RhGJD
	gvqbEQMvjwfapBl7n33LhX2X4vKsDVr7Dmr5KJ31qzCiPQN9sEWjaAz2r69qmV+AnwDrLKlzpL8
	aJGGtdyTLD0C6W89oUcze9JLarN4PGbAW8sLbvCe3yEQQFYywVP7O+ZZWcz6xMGJM2cxr036PA/
	ljfYiBAWi8Lf21uqrpBallvnbm4FOuJm6eXWHg3aDLveiRVR6d8d6RjrHbClLzS7F1GPvAeU/bd
	t8/mpyuQoHtpVAyw2zO5tyYYtgvBG7yBsA50riy4aMg==
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166278165e9.14.1794862877097;
        Mon, 16 Nov 2026 13:01:17 -0800 (PST)
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166277685e9.14.1794862876566;
        Mon, 16 Nov 2026 13:01:16 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7813fa23sm22454295e9.2.2026.11.16.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:01:15 -0800 (PST)
Date: Mon, 16 Nov 2026 16:01:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kvm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next v5 6/9] virtio-net: assert header sizes
Message-ID: <20261116160026-mutt-send-email-mst@kernel.org>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7bp5kSCnpEoSP9f4L3ri5_69DqtcvZaEsEg6cBpSdGI_1794862877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 12:19:38PM +0100, Steffen Trumtrar wrote:
> The header is cast from skb->cb and from device buffers, so its layout
> must not change silently. Add static_asserts for the offset of tstamp,
> the total size, the alignment, and that the header fits into skb->cb.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  include/linux/virtio_net.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 2abd8a614a23f..e7776a37a486b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -29,6 +29,17 @@ struct virtio_net_common_hdr {
>  	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
>  };
>  
> +/*
> + * The header is cast from skb->cb and from device buffers, the layout must not
> + * change silently.
> + */
> +static_assert(offsetof(struct virtio_net_common_hdr, tstamp) == 32);
> +static_assert(sizeof(struct virtio_net_common_hdr) ==
> +	      offsetofend(struct virtio_net_common_hdr, tstamp));
> +static_assert(__alignof__(struct virtio_net_common_hdr) == 2);
> +/* virtio_net_common_hdr must fit into skb->cb */
> +static_assert(sizeof(struct virtio_net_common_hdr) <= sizeof_field(struct sk_buff, cb));
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>  {
>  	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {


Waste of time. We know how to maintain stable UAPIs without this
kind of stuff.

> -- 
> 2.56.0

