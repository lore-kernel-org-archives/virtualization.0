Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545477;
	b=aOpXoPl4rDi8Y8axD++YkyumqaN9GnfTtHHaorIaj+oCDRZxtEQMIIETBwCGS5lZx+oa
	 YptTkDFxlFValrEqKhUo5MO68Ccj2Tsa7yZz51Ks2kPiw13Yu+fHykxu/5Cp8wqjlYk/p
	 W2+iB4wXWbJfvwvMqV9DV1sDcETCkAPTZEeA970SjyFMUCxtRTQXUbrL0ZpnOP5e6JvQs
	 MLwHhJz3qZiTYrmDwvvN60SHNf1chtDOP16R8icjLynsCEKtrgA0mtxFr0VdUbwjL4RHV
	 gj6Tsu5D9+pCdl2tIEvgWM0CE8WLTb2Uw4h+J7B1ycRnpO2lZHRcN/i6+AKKI256gyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
	b=wDoay6Wj8k/cPC5qZc7yotPcR/s76TQWMLWvC70W/5qgKNROyhlhyWz0pxql4E4FBNxP
	 nzVnmky8d7XsyqLifI6Fs0WSvCxhhwisov9APBovfVux3b4nTgpTQ7aXtiHxoNAuK+S0X
	 UhWAccUH7mbpthc/4GlbJpsfRKXp7YWhfJ5eSnIrdWIChSruLcN82fHrmVVpRBepI2lXJ
	 G12LjBR99npQ1g8YEoh+2s/ltYMB3wf4Md0us9WeH/8KUE/j9oCg+zJCXrgVh9VzgFPjW
	 oMDD1NCxLmnll3t9Celxdthr0PoHAT6sGqTywE6Mh4KlEHY93HrdpBTQek+HFv5k51A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptUeHBZY;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350E606A324
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6350E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptUeHBZY
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so1200923e0c.1
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545476; x=1794150276; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
        b=ptUeHBZYTGeZzyYnA4JUgLw0cQ/XSYWZrCrXMrO+t6EEONTh0PbP1QIRH4aQeUIkWd
         YlBD6ph5zEwzPs98V9USLMwA7arphyB6So6/XhQlU8lkP3Zyr98j6PbFNGx2LGiNjPJb
         xBgE3ekhtXP/xLteBpMh/Tns/GGnZ/QrnrMzL8V332KXWJ2jZRjo5GCAMkPcT7+sJ5Iz
         DDVUQApnRiAW4qiIa/7M5G/HTeuBwlUGkppS7SPATvC383CH9JuJzydZe00CLbuIy06m
         Qoz6USJ/5KV/8D4oIiZszwQPeQ+D98poNzsR2IK4EkSasAE4CjTfvuxVxLTrSN5M431G
         PQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545476; x=1794150276;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTpJszTPfdrFGTPrUWviGsFCLOFVk1Llppz1WHIBDvc=;
        b=NSoUt50E1o0dOWJx5ox/4y+lKqvL5OmY9uAfJ2OUxmi1CCbcDws4WnAGMSrNFjyzrN
         5kKVaNHpjvb07uNEsKX2lXVK3a/3L+pdpXp5jp4G4i9aMJi0CjLCRtplujZGKJQZYZNZ
         0KagR1IlErd43p66CSLbY2eyfW44PZqpspmL+QeMZUpMM5NTmybUyPccYYWtWJcnSPav
         vMnGPD18fC+ZTGXIp6L7nRqsntAz70nb4kRElLJrRQCObpYfCzDqS7zLRchlSUMykBfH
         xAJXZS3Rn86MqINIdjEoAm9V1Z42avSlo6Y/ARuaHvHq3jH5tXRU4PhoaXCeCkFwkflN
         O9IA==
X-Forwarded-Encrypted: i=1; AKwUvBy2Z5pijaxn37e2WuqSE8lbfYnMPRuy3C7Vt3NYABfcwJsupHcvtio+dtxaPTbV62gtrc6d5T4Mj+OMpjVX3Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKKyU+/xnBDKEyTyNEesnRhwVGmR05A7pBhmTkcxtEJiF1T+mdW
	QgtxcrGhURS+NdRI/2Jl72e4U4kEBVNaFg88cVGyjPrajs9XYGPMYnt1kl0E2Q==
X-Gm-Gg: AYBFou1SslmWWfb8bJyiabtpzB6p7LfiG0h9I/aaxwzSbzd7nMeHNpK5lqg1NRgGq/o
	36VF5IUa889U0jmoMdpnqmWQBThODybFAlvqFrAfgiG7bP3blSxuXZ5k7vJK5JROj1B136b5Qo2
	NwbHMY6a5EEGHM57GNUmQZduFRYzNUJa/2wLcbBWAhDx/qVNLYeHHvT8ERssjK8UEcW1WfLG5ZO
	YQzI+Bsm3aGuZ9JAJqxp2wInGcVa2yf0XXcoCMKjg7rSiwc8I5dWMYSN1JEktREiQVyiWo5pjeE
	wr+rNe5fWOYNZA0VQq1wKxCNaibU97COGqzrIMTX+dN4EkJwo5/ULAeEfzASPRpzzXKhUboAaQk
	V/azb0lf+7kJZ87ARdIs16DtsnHFYaTBE3Fth8X8USq8uNNa45DQpVmqiVTZ0NA39QtzeAG1bUm
	gmQ3R4n69hLlAeGVFEP0E3i6WzrKO8XjouVRsd1q0/SDi6zd/bmcTLiRwM9xDl5goIYVxjR/KQg
	YsHR1hm/J5N1La5fYvUClMmoNwoWFt3dKmXosI1lz8fX4blt3NSpIxoGcbBKJ/dQvsbX+KeDZr9
	ANwDh+dVkAMlNwltxIcmtJDg+6S9ZIckUW8yBbWlmgNETzgoBxb+qubgKfQ08SBiH50IqpcXZ9q
	DpStU14OloqKKTAa/1ZbcTFkDVnwd/SEH6DmsH4FkfhEMikGOeLTjCHaE6tzrflbVpEIZ
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id 71dfb90a1353d-5ec68953084mr3744746e0c.6.1793545476321;
        Sun, 01 Nov 2026 07:04:36 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5389dsm8369176e0c.12.2026.11.01.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:04:35 -0800 (PST)
Date: Sun, 01 Nov 2026 10:04:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
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
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2adf5c78ee0e8@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 2/6] virtio-net: support receive timestamp
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> Add optional hardware rx timestamp offload for virtio-net.
> 
> Introduce the virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> virtio-net header grows by room for a 64 bit TAI timestamp (header
> size 40 bytes), stored in struct virtio_net_common_hdr. The layout is
> cumulative: the field is at the same offset whether or not the
> features before it were negotiated. The fixed layout needs
> VIRTIO_F_VERSION_1, so the feature is cleared without it.
> 
> Implement ndo_hwtstamp_get/set so the timestamping can be enabled
> and disabled at runtime with SIOCSHWTSTAMP. The driver cannot filter
> what the device timestamps, so any rx filter other than NONE becomes
> ALL. The timestamp is read before the packet is handed to the XDP
> program or the stack, and attached to the skb with skb_hwtstamps().
> It is a raw TAI value; there is no PHC.
> 
> The header size is negotiated per device and also applies to
> transmitted packets. On transmit, zero the header behind the fields
> the driver fills in, so the device sees a zero tstamp and no stale
> skb->cb or headroom bytes.
> 
> On receive in big packet mode, the header is placed in front of the
> data in the first page. Grow padded_vnet_hdr to 48 bytes so the
> 40 byte header still fits there.
> 
> Tested in a guest with a patched QEMU:
>   guest: ./timestamping eth0 \
>           SOF_TIMESTAMPING_RAW_HARDWARE \
>           SOF_TIMESTAMPING_RX_HARDWARE
>   host:  nc -4 -u 192.168.1.1 319
> 
> Based on work by Willem de Bruijn.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/net/virtio_net.c        | 136 +++++++++++++++++++++++++++++++++++-----
>  include/linux/virtio_net.h      |  10 +++
>  include/uapi/linux/virtio_net.h |   1 +
>  3 files changed, 131 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 17d3e32eed9d6..23af10c613b48 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -20,6 +20,7 @@
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
>  #include <linux/dim.h>
> +#include <linux/unaligned.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -416,6 +417,12 @@ struct virtnet_info {
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
>  
> +	/* Device passes time stamps to the driver */
> +	bool has_rx_tstamp;
> +	bool hwts_rx_en;

nit: cryptic name. rx_tstamp_supported and rx_tstamp_enabled or so?
> +
> +	struct kernel_hwtstamp_config tstamp_config;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;  

> +static int virtnet_get_ts_info(struct net_device *dev,
> +			       struct kernel_ethtool_ts_info *info)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	/* setup default software timestamp */
> +	ethtool_op_get_ts_info(dev, info);
> +
> +	if (vi->has_rx_tstamp) {
> +		info->so_timestamping |=
> +			SOF_TIMESTAMPING_RX_HARDWARE |
> +			SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +		info->tx_types = BIT(HWTSTAMP_TX_OFF);
> +		info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +				   BIT(HWTSTAMP_FILTER_ALL);
> +	}

    `ethtool_op_get_ts_info()` leaves `info->phc_index = -1`, which breaks Ethtool
    Netlink `ETHTOOL_MSG_TSCONFIG_GET` and `ETHTOOL_MSG_TSCONFIG_SET`
    (`ethtool --show-hwtstamp-cfg` / `--set-hwtstamp-cfg`): `tsconfig_prepare_data()`
    in `net/ethtool/tsconfig.c` rejects `ts_info.phc_index == -1` with `-ENODEV`.

    Either `net/ethtool/tsconfig.c` must be taught to allow PHC-less `ndo_hwtstamp_*`
    drivers, or the device needs an associated PHC (e.g. `virtio_rtc`).


> @@ -7250,7 +7353,8 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> +	VIRTIO_NET_F_RX_TSTAMP

    `VIRTNET_FEATURES` expands into `features_legacy[]` as well as `features[]`.
    Legacy virtio only supports 32 feature bits (`0..31`) and never has
    `VIRTIO_F_VERSION_1`. Move `VIRTIO_NET_F_RX_TSTAMP` (bit 49) into `features[]`
    alongside `VIRTIO_NET_F_*_UDP_TUNNEL_GSO*`.

>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index a6de308b8f25e..2abd8a614a23f 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -17,6 +17,16 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
>  	};
> +	/*
> +	 * The wire layout is fixed and cumulative: a field sits at the same
> +	 * offset whether or not the features before it were negotiated; unused
> +	 * bytes are padding. tstamp is thus always at offset 32 and only
> +	 * present (header size 40) if VIRTIO_NET_F_RX_TSTAMP was negotiated.
> +	 * The negotiated header size tells how much of this struct is
> +	 * on the wire. Only ever append new fields at the end.
> +	 */
> +	__u8 reserved[8];	/* outer_nh_offset, ipsec_resource_hdr (not implemented) */
> +	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
>  };
>  
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b5..15e8e408d50fb 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_RX_TSTAMP	  49	/* Device sends TAI receive time */
>  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> 
> -- 
> 2.52.0
> 


