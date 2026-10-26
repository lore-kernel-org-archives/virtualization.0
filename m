Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004711;
	b=Aibw9mR1fHMdCwdQID5V9eN01bbSZ53inDA1mYeG3SZRKQaBOqRkZxUQB3nMZFkpFTX0
	 1xmdAK+EAMlTskQu/vWMvhEiaMVoDJkKokGidMITHUNd6UsncjdrKlWHWhKgwIs8i8d+Z
	 ZGW+2RV9kw6rQr/hIXbnVHtVKYQ1y69ln5lYL+6HV4jpxghPAo85jlWGXDVyTvHjUGhE9
	 B57SyiOdSh0CtcIAEvWTSwr6I2GfBouY8LfvzF7UhzyvnvS8WG0fbhEwiWN9XWQpyUG8S
	 Zp+9uKOTuz67aruhWSFabK81YOCvy6yE/YqoGqfxA7asokKh6cPrPPkvH9CYgeyRryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CJHceKQK26nCX0KjSi3Rni3VFAp3mTVRQNa7AOdu2Gk=;
	b=uiJmSsZs3qDdk/eJ22IsjNjgPOrzJc9QtkH5PBvQ8kLZr+eZTLLWQWXJafRzY8/j2ktE
	 BF8VnI2nEdYJ5JEB3Q0dsSe+VjEA7R3xmATCllQzONqsHmHOylG1bKVas8WvsniLGZ/HN
	 QQ1B1l5tNa0Tgp9zcF6aBuQmFTfJgzOZFaGlwft6GxMor6p/+6Njb5UHmQGK/kbjXzvX2
	 L8V+RQoHO1MnCHy3z9/w9mOHWKIe7Xg5IxeRzdcdj/SvDsEMdRv/EuR1diLoiALSrzJQE
	 lAq4gWfQnf0xlPWuDyBhXI2zvQjycZbJQWUtk6hp9qkEhozV+ugz83ipSbAQCJ7QCCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVPfSy+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA384606A321;
	Mon, 26 Oct 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVPfSy+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017F01F031E3;
	Mon, 26 Oct 2026 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004710;
	bh=CJHceKQK26nCX0KjSi3Rni3VFAp3mTVRQNa7AOdu2Gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVPfSy+XOisR0bl65ffKWn8cKoqujkA8q18X3aAe1tsyuLmCuCv9LbiDYjme9nG5j
	 +f8OzWl7Zr46eORmVzY477XssPXGc314aZzTxGG6tQ9tgDZXrJOjwqbnEyvpj7XN+1
	 fb7dTk65OvOli2+o9zdo4SJGeL4EKh/KAxVsYCQSFzX4ckqan9P/OHN5wnDSrJAF4z
	 Q6zcgjKF1kmrjmlYFJHwJ+x9jFGBw4sc/v4wglhpG8VRFiMp0JXJFg1CKKrGBmN9hY
	 NgXiTSqN9KXFoRXzZWngJt3AfUwGJZyjGWKLiUJD7ea202Xx7Cc2DBIY3+FncD3Yr9
	 qhYkERJ5U80lQ==
Message-ID: <sashiko-outbox-184699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 4/6] vhost-net: support VIRTIO_NET_F_RX_TSTAMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-4-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-4-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:51:49 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vhost-net: incomplete header zeroing in handle_rx() without num_=
buffers
--

commit a70532fad1c69345268d35c3f489b52f8abb6392
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

vhost-net: support VIRTIO_NET_F_RX_TSTAMP

This commit advertises VIRTIO_NET_F_RX_TSTAMP in vhost-net, sizes the vnet
header to include the timestamp field when negotiated, and zeroes the extra
header bytes in handle_rx() when vhost supplies the header itself.

> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 2cc730729e08a..2a38ad0ea1af2 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c

[ ... ]

> @@ -1282,6 +1283,16 @@ static void handle_rx(struct vhost_net *net)
>  			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			goto out;
>  		}
> +		/* Zero the rest of a header supplied by vhost, e.g. tstamp */
> +		if (unlikely(vhost_hlen > sizeof(hdr) + sizeof(num_buffers))) {
> +			size_t rest =3D vhost_hlen - sizeof(hdr) - sizeof(num_buffers);
> +
> +			if (iov_iter_zero(rest, &fixup) !=3D rest) {
> +				vq_err(vq, "Failed vnet_hdr zeroing");
> +				vhost_discard_vq_desc(vq, headcount, ndesc);
> +				goto out;
> +			}
> +		}

[Severity: Medium]
Can this leave the final 2 bytes of the vhost-supplied header unzeroed in t=
he
guest RX buffer when neither VIRTIO_F_VERSION_1 nor VIRTIO_NET_F_MRG_RXBUF =
is
negotiated?

In vhost_net_set_features(), VIRTIO_NET_F_RX_TSTAMP (or UDP tunnel GSO) can
be configured alongside VHOST_NET_F_VIRTIO_NET_HDR without requiring
VIRTIO_F_VERSION_1 or VIRTIO_NET_F_MRG_RXBUF:

drivers/vhost/net.c:vhost_net_set_features() {
	...
	if (virtio_features_test_bit(features, VIRTIO_NET_F_RX_TSTAMP))
		hdr_len =3D offsetofend(struct virtio_net_common_hdr, tstamp);

	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
		/* vhost provides vnet_hdr */
		vhost_hlen =3D hdr_len;
	...
}

When handle_rx() runs with this configuration, set_num_buffers is false and
writing num_buffers to fixup is skipped:

drivers/vhost/net.c:handle_rx() {
	...
	mergeable =3D vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
	set_num_buffers =3D mergeable ||
			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
	...
		if (likely(set_num_buffers) &&
		    copy_to_iter(&num_buffers, sizeof num_buffers,
				 &fixup) !=3D sizeof num_buffers) {
	...
}

Because msg.msg_iter was advanced by vhost_hlen before recvmsg(), the packet
payload starts at offset vhost_hlen, while fixup only advanced by sizeof(hd=
r)
(10 bytes). Subtracting sizeof(num_buffers) from rest unconditionally causes
iov_iter_zero() to stop 2 bytes short of the payload, leaving the upper 16
bits of tstamp in the guest buffer uninitialized.

Should rest only subtract sizeof(num_buffers) when set_num_buffers is true
(or should vhost_net_set_features() require VIRTIO_F_VERSION_1 for these
extended header features)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D4
