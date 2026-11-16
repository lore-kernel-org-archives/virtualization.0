Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837312;
	b=Y8hntPbUjqsSnwpvwzUUNseJOEy29MHI/Lw8eu8+VeoSlCN4M1X9HmIJIgrUr+lHNt8C
	 xJA1RWndL1hGTLm8JTGxTDS9t1lqjfyK+c9dXVFhW67pPewNgjD/qS8ehidJxzwOTOfqE
	 7Bcau5orPyPlbInvpfON7/DO3jq/42y17h0KGohQ00jn2zdzDYVM0BDFk0CQkpPvNMI7a
	 4IFcEl20iCKx3TwQj9feaWPheJS8+8NCRTRGbTY5F1K5ZgBFfUi5GJ2lwiE8I1unY10mw
	 jj1TnIRuEQVAw1bJhkpagvEqP4hg5xcOjFgDZ/eeBgiIRyXKbP6EC0SYX0IzyzRRXMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837312;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6+wHABsofSehspfHzJdUbQ94+anC5ikK+6WkhLo4zaw=;
	b=cCs2UPKWKrriEU4XCmfzP3szlwteol6O+GNvbjeG0Yp0AbPhqHJDBDe9TjrXyYKCns2Z
	 t07/jMWAhn2xzrKa+64a6PG+EjrLKDAMkNnHHU9f6MRBg6IZUZ8PwNYrFd61LtRIQLxa9
	 nOnTS5x/pcw0ab/S08oNCKgTJcjMDEj7h1+qNwiJpaC8drD1Ws650rz4e9gmbP4e0V58B
	 1L/FgBwdh0tEsOic7MZzvU9SfEjPQ/EdNxCH9LyLR71z1qXxGEo3EV7eL03RYGMAX5Kz4
	 xr+W+zCf4gp3LINgdi1a8rTez5/1Z8gNng+/VbRQzJa54EMTkUug6ZqSFuyQ9aqk+8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7yzx6Ao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FF60A263B;
	Mon, 16 Nov 2026 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7yzx6Ao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1B1F000C5;
	Mon, 16 Nov 2026 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837311;
	bh=6+wHABsofSehspfHzJdUbQ94+anC5ikK+6WkhLo4zaw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L7yzx6AoOEKCrIvuoPnMTexmPn/vRZbU4PYAgBs7j+XWA1B7SlgMP6vFMlAkSo+4f
	 vjgqsAB/0id9qHJfOjnnPkfda6xeY84Zo/kihMjsldg+ULJ63/+sUrXpfKXRQYOHlW
	 5jvwxiAnvaUhVlm4K4/U+GhgUEK6FEL4JkuLAlcfYakM8MY7p0f+rnC+XRouLSR/Lw
	 7OSObnpJO5pNYnOhJx23mUo2/uD4zF/rq4tcZtjnzlB77UM+YgYtNmIVGVXrdu0YSX
	 bEGImEUmAe/Bqi8JP9ZD1Xk0XJcQrNc+0sVwSYvTOp8Zf8mULRxXe/mNeH5pOMpHKQ
	 xUPCBfrgn1ysA==
Subject: Re: [PATCH net-next v5 8/9] virtio-net: add XDP rx timestamp metadata
From: netdev-bot+sashiko@kernel.org
To: s.trumtrar@pengutronix.de
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, eperezma@redhat.com,
 jasowangio@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@kernel.org,
 andrew@lunn.ch, horms@kernel.org, kory.maincent@bootlin.com,
 liangchen.linux@gmail.com, hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kernel@pengutronix.de
Date: Mon, 16 Nov 2026 13:55:09 +0000
Message-ID: <179483730942.3136.8459645121543996993@kernel.org>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-8-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-8-7ab67b572f4f@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] virtnet_probe() now reports XDP rx-metadata capabilities the
  device does not have.

--

virtio-net: add XDP rx timestamp metadata

This adds an xmo_rx_timestamp callback to virtio-net, so XDP programs can
read the rx timestamp with bpf_xdp_metadata_rx_timestamp(). The timestamp
is copied into struct virtnet_xdp_buff before the program runs. The
metadata ops are now also installed when VIRTIO_NET_F_RX_TSTAMP is the
only one of these features negotiated.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 57b7c32625dfb..46be686e34b79 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -6896,8 +6899,21 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,

[ ... ]

>  static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
>  	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +	.xmo_rx_timestamp		= virtnet_xdp_rx_timestamp,
>  };
>  
>  static int virtnet_probe(struct virtio_device *vdev)
> @@ -7063,6 +7079,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>  	}
>  
> +	/* rx_hash returns -ENODATA without NETIF_F_RXHASH */
> +	if (vi->rx_tstamp_supported)
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +

[Severity: Medium]

virtnet_probe() installs the same virtnet_xdp_metadata_ops table in both
places. Does that change what netdev netlink reports for devices that
have only one of the two features?

netdev_nl_dev_fill() sets an xdp-rx-metadata-features bit for every
xmo_* pointer that is not NULL:

net/core/netdev-genl.c:netdev_nl_dev_fill() {
    ...
#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
	if (netdev->xdp_metadata_ops && netdev->xdp_metadata_ops->xmo) \
		xdp_rx_meta |= flag;
    ...
}

Documentation/netlink/specs/netdev.yaml describes the timestamp bit as
"Device is capable of exposing receive HW timestamp via
bpf_xdp_metadata_rx_timestamp()".

Take an existing device that negotiates VIRTIO_NET_F_RSS or
VIRTIO_NET_F_HASH_REPORT, but not VIRTIO_NET_F_RX_TSTAMP. It still gets
the table from the has_rss || has_rss_hash_report block above. After this
patch, that table has xmo_rx_timestamp, so the device now reports the
timestamp capability.

Can such a device ever deliver a timestamp? virtnet_hwtstamp_set()
rejects the request:

	if (!vi->rx_tstamp_supported)
		return -EOPNOTSUPP;

So rx_tstamp_enabled stays false and virtnet_record_rx_tstamp() always
returns 0. As a result, virtnet_xdp_rx_timestamp() always returns
-ENODATA.

virtnet_get_ts_info() also does not set SOF_TIMESTAMPING_RX_HARDWARE in
this case. The ethtool and netdev netlink answers then disagree.

The opposite case is the one the new comment mentions. A device with only
VIRTIO_NET_F_RX_TSTAMP never gets NETIF_F_RXHASH. It now reports the hash
capability, but virtnet_xdp_rx_hash() always returns -ENODATA.

Would separate xdp_metadata_ops tables, chosen by which features were
negotiated, keep the reported bits accurate? The commit message covers
the rx_hash case, but not the change for existing RSS/hash-only devices.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f%40pengutronix.de
