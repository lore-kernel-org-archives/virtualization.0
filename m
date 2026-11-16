Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837307;
	b=u5Zka2GM0oV28ocVWsP571yZFj5Mz4Uc4t233dr1Bk0UgLUVgQUv2FfuWWsY/ukbpeIy
	 p8Cly9yaK6NUR4zwpnZbB3JmkiyyqZrhZpaPuJ84jlaVZy4hixs/bt5PtCuqzGE1PbT4f
	 Wjq+wHHbmsnbmxvoXwxTttyozd8GOCwqDu7rLyqNxeBFQDgTdIQ9UZgTjnhdo2ZEZ9WnD
	 svphjOHi9mU2ExnPuH01NDQ1fTB8LHr35eNWv+aoq41Vv0tlJr+VmfPg9onBcuWxGQZRj
	 G2w+fkhneyKpq8A6E+9lO7HOaF7tp11NzgVi2XvVKfaudCZj1UPrKLmLH7lMmch45rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837307;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dJmBvsHxmFsY/NHiTygrkfChS2jWEf5KeHz33qzwJMI=;
	b=H+JvxtuekTTEvTBxp8ENIuWmQu0jBcDZ4cOHb+RhbQiR9OVahGP14/QqYKHed0jSj8Oo
	 3x6OhnS2yjL8nHE26LZ831Z4trFAlxVIlYeNUF+NgyKNWZprtuQF+9lTGSWY+iIw3KZqi
	 Hb7HjrK12b1ZxSdMSyw9h1+vg5IuJTgqBBe4w5B8VLD4CLFSSEl779Rz7b/Qayc6IoIM1
	 swhBUuLfsOeI6kh6WMhGiN4qagUij95duQgn8v26siswIrAfHP4LxMjWx7XX7xm4Qu7Qh
	 rOU2lSoD+9/f6MhTdfMgHLSbDNi6o912me3y2/XaymLBW3EdqT5sJLlIu+tN9prBN/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me975jvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343C606D54B;
	Mon, 16 Nov 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me975jvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7861F000C5;
	Mon, 16 Nov 2026 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837307;
	bh=dJmBvsHxmFsY/NHiTygrkfChS2jWEf5KeHz33qzwJMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=me975jvNDmUmvwA6FWFpPXMGtDNyifM8vZozlY5X4jl0OSAHXR6uPZshnPbXAMvHn
	 61ZpD4PP5BnE1LbiNwqUrhOsOkbAyF03vztminGJrZ7B9uFUBhK0M0EfiKFJsk0jWX
	 CJB+gzcO0HGSWHsbX7aoCVDKUaMHUt4W69ybxpOvaYsE1DQXLRem7xNl94hC+UBTRv
	 lyu6tXVPYA16TG1iD14X1JJai/Ez23xjubdXaXxp+007uwYB2N9/6wbuMoLVvnLq8y
	 /NUWuSKl2PmAgOXiC+J1qO/g8ppmiAW0ARPUiHln+emknOLP6HOFQkbH7fZQkQJdGT
	 xF3RLMRvN6tog==
Subject: Re: [PATCH net-next v5 5/9] virtio-net: support receive timestamp
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
Date: Mon, 16 Nov 2026 13:55:04 +0000
Message-ID: <179483730496.3136.1220905083498568586@kernel.org>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-5-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-5-7ab67b572f4f@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Feature bit and wire layout are chosen without citing the
  virtio spec.
- [Low] The feature bit is exported to userspace but the header layout it
  enables is not.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  extends it.

--

virtio-net: support receive timestamp

This adds a VIRTIO_NET_F_RX_TSTAMP feature (bit 49) to virtio-net. When
it is negotiated, the vnet header grows to 40 bytes and carries a le64 TAI
receive timestamp at offset 32, which is attached to skbs through
skb_hwtstamps(). Timestamping is switched on and off at runtime with
ndo_hwtstamp_get/set.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 23e7f62a6ff64..57b7c32625dfb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -1324,7 +1344,9 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
>  		return;
>  	}
>  
> -	flags = ((struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len))->hdr.flags;
> +	hdr = (struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len);
> +	flags = hdr->hdr.flags;
> +	tstamp = virtnet_record_rx_tstamp(vi, hdr);

[Severity: High]
This is a pre-existing issue, but this patch adds a new read from the same
region. On the AF_XDP zero-copy path, is the vnet header in front of
xdp->data ever synced for the CPU?

virtnet_add_recvbuf_xsk() posts the descriptor hdr_len bytes before the xsk
DMA address:

	addr = xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len;

buf_to_xdp() only calls xsk_buff_dma_sync_for_cpu(), which ends up in:

include/net/xsk_buff_pool.h:xp_dma_sync_for_cpu() {
	dma_sync_single_for_cpu(xskb->pool->dev, xskb->dma,
				xskb->pool->frame_len,
				DMA_BIDIRECTIONAL);
}

That range starts at xskb->dma, so it does not cover the hdr_len bytes the
device wrote in front of it.

Under swiotlb bouncing (for example SEV/TDX guests with
VIRTIO_F_ACCESS_PLATFORM, or swiotlb=force),
__swiotlb_sync_single_for_cpu() copies back only the synced range.
Non-coherent DMA has the same problem. In both cases the CPU reads stale
bytes from the umem page, and userspace or bpf_xdp_adjust_meta() may have
written those bytes.

virtnet_record_rx_tstamp() now reads hdr->tstamp from that region, and
virtnet_receive_done() reports the value through skb_hwtstamps(). Could a
stale or user-controlled value end up reported as the hardware timestamp?

The same gap already affects hdr->hdr.flags (VIRTIO_NET_HDR_F_DATA_VALID)
and num_buffers in virtnet_receive_xsk_merge(). If num_buffers reads as 0,
the while (--num_buf) loop in xsk_append_merge_buffer() wraps the u32, then
consumes and drops buffers that belong to the following packets.

Would syncing the header range too, starting at the posted address
(xskb->dma - vi->hdr_len), fix all of these?

[ ... ]

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

[Severity: Low]
Should this layout be exported in include/uapi/linux/virtio_net.h along
with the feature bit?

VIRTIO_NET_F_RX_TSTAMP is now in the uAPI header. The 40 byte layout it
turns on (reserved[8] at offset 24, le64 tstamp at offset 32) is defined
only in this kernel-internal struct. The earlier patch in the series,
"virtio-net: move virtio_net_common_hdr to virtio_net.h", moved it here,
and the series never adds a uAPI struct.

Other features that extend the header have exported wire structs. Examples
are struct virtio_net_hdr_v1_hash for VIRTIO_NET_F_HASH_REPORT and struct
virtio_net_hdr_v1_hash_tunnel for the UDP tunnel GSO bits.

Device implementations that import the uAPI header (QEMU standard-headers,
vhost-user and DPDK backends) get the bit but no definition of the offset
and size they have to produce.

reserved[] stands in for outer_nh_offset and ipsec_resource_hdr, and
neither field is in the uAPI. The cumulative layout claim therefore can't
be checked against any exported definition.

> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 1db45b01532b5..15e8e408d50fb 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_RX_TSTAMP	  49	/* Device sends TAI receive time */

[Severity: Medium]
Is bit 49, and this header layout, reserved in the virtio spec?

The commit message does not reference an OASIS virtio-comment change. The
only device it was tested with is "a patched QEMU". The tun patch in this
series says it is "not intended to be merged" and links an out-of-tree QEMU
branch.

A gap in this header doesn't mean a bit is free in the spec. Bit 51 is also
unassigned here, and bits 46/47 are already reused as
VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED and
VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED. Willem de Bruijn's earlier
timestamp work used bits that the spec later gave to USO and notification
coalescing.

Placing the timestamp at offset 32 also relies on outer_nh_offset and
ipsec_resource_hdr, which are not implemented here.

Suppose the spec gives bit 49, or the timestamp offset, to something else.
A device offering bit 49 would then make virtnet_probe() choose:

	if (vi->rx_tstamp_supported)
		vi->hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);

for both RX and TX. RX would strip the wrong number of bytes, TX would send
a header of the wrong size, and unrelated bytes would be reported as
hardware timestamps.

The vhost-net patch later in the series also advertises the bit to
userspace. That would make it negotiated ABI as soon as this is merged.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f%40pengutronix.de
