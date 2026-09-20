Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359C7081A;
	Sun, 20 Sep 2026 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907496; cv=none; b=QP+C86EslYsnyfhnfd/Pvd8jywZP9c70+jdewD+OHU1gAZPsgnDuvlIrHs7y+MOmnhluL0+LIuGGnpW0UiZx7n3tDNn1sjHG92CMeD6c1OaSoHMcdEhDWdRnpX/hE0IZg3SimJtOt3Iz/oGDqedAi/b/KiVjgDwQQLZd8EQTIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907496; c=relaxed/simple;
	bh=ASMq3FNooPSEO1HqMpusUY/rkyOZL3h0UiPcC4l50XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXS67L9l4DtgiK/mg2jeqtEyvBcaLe4DM6DAyBXx7Gg+6sngNBKQ3yHa9Zlx9vjTkBlOZ0lDB7LcvD3qmoRB/tZwekXtGEebq7RnIlrGlPiARAFml1oonHCiziF1Xko0KUHk4H+jgNsoJA10OTPssBoXZIKWCm2W6TgAvw0dz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4jPOMnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4jPOMnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29901F000FF;
	Sun, 20 Sep 2026 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907481;
	bh=x7Rj+1lR8yco9L3uUKrFikg1vos+ZhMx9ekAaju3IsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A4jPOMnfgp6Majaj+E4qINiJINQ2rJMWGrLoChrQfIiPz/fV9o2XrHytqnMZcMe2s
	 VnsjYnsi8wwvq/L7wVAXQ4QjUIDD2YY9S73PjcSfWw+/wPLxt1tEOgC5rxjW4OVJDI
	 mnrhAHxgn8MgBBy78aIHDJcb2s6vyIorc9Uf1iSR7sSLAOF1YAxk3UfED1Mhotc2Rc
	 LGNViXdwhaJTo5eT8sse6dOjFuyuOHgC3gfMrw+zQLd7z7QYHkiUsJAdouLtDsFTTm
	 odUcv2hv3eQIylzSLvb/gaY1MVGhg2w8o+pWulnhWdwpwbF9Xpcv0mMbqGjS19GLa9
	 RYBWLfQSFOhdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vsock: keep SOCK_SEQPACKET message boundaries on
 interrupted send
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
References: <20260919122916.28226-1-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:31:20 +0000
Message-Id: <20260920123120.F29901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vsock: vhost_transport missing seqpacket_max_size causes indefinit=
e hang
- [Medium] vsock: seqpacket wait loop hangs if peer dynamically shrinks buf=
fer
--

commit faa45a951be47102c344158967938f9970eb6270
Author: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

vsock: keep SOCK_SEQPACKET message boundaries on interrupted send

A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
where msg_data_left() reaches 0. If vsock_connectible_sendmsg() exits via
out_err after a partial send, the already-transmitted fragments carry no EO=
M.
The receiver only advances msg_count / sets msg_ready on an EOM skb, so the
orphaned fragments are silently merged into the next message, violating
SOCK_SEQPACKET atomicity.

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6b..d94c613ef604b 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -143,6 +143,7 @@ struct vsock_transport {
>  				 size_t len);
>  	bool (*seqpacket_allow)(struct vsock_sock *vsk, u32 remote_cid);
>  	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
> +	u32 (*seqpacket_max_size)(struct vsock_sock *vsk);
> =20

[Severity: High]
Does vhost_transport in drivers/vhost/vsock.c also need to implement this
callback?

It implements SOCK_SEQPACKET, but appears to omit the newly required
seqpacket_max_size() callback. If the callback is NULL, the max size check =
in
vsock_connectible_sendmsg() is skipped. If a user application sends a
SOCK_SEQPACKET message larger than the transport's buffer size, this will
cause an indefinite wait loop because the space can never reach min_space.

>  	/* Notification. */
>  	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);

[ ... ]

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9b71479a2b295..01fc9ac6fa2b5 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2250,9 +2250,32 @@ static int vsock_connectible_sendmsg(struct socket=
 *sock, struct msghdr *msg,
> =20
>  	while (total_written < len) {
>  		ssize_t written;
> +		s64 min_space;
> +
> +		if (sk->sk_type =3D=3D SOCK_SEQPACKET) {

[ ... ]

> +			if (transport->seqpacket_max_size &&
> +			    len > transport->seqpacket_max_size(vsk)) {
> +				err =3D -EMSGSIZE;
> +				goto out_err;
> +			}
> +			min_space =3D len - total_written;
> +		} else {
> +			min_space =3D 1;
> +		}
> =20
>  		add_wait_queue(sk_sleep(sk), &wait);
> -		while (vsock_stream_has_space(vsk) =3D=3D 0 &&
> +		while (vsock_stream_has_space(vsk) < min_space &&

[Severity: Medium]
What happens if the remote peer dynamically shrinks its receive buffer to a
size smaller than min_space while the sender is waiting in this loop?

Since the seqpacket_max_size() check is outside the sleep loop, if the space
ceiling shrinks below min_space during the wait, the sender could be
permanently trapped without re-evaluating the max size.

>  		       sk->sk_err =3D=3D 0 &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919122916.2822=
6-1-bartlomiej.dmitruk@isec.pl?part=3D1
