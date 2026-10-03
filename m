Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB4387361;
	Sat,  3 Oct 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013619; cv=none; b=RJu4V4E0D3Ruhjlk+1Qd84j8wvPOvmM791y1kVoJvo57zXeihEXfSBTcL9hwMhIvzdL/LruYTpvTpsbhFOL+snOT7iFFuqJ6Z6OhIt/bJ1ftbYPzYFyuY8Fgcro3iN204V0/N+Q0PJh29un/6nnfsGgaLFy8Ps5jxLOdWdQWkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013619; c=relaxed/simple;
	bh=VUFz0HC7bJ8cP9nJ2iJHsZL3NIKbXlxNR9HVHswXlhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7YkIFnpCdK3IOTofkBzylAXahHQ3zy5VJjiPUKVA9ET7P8czDi0YxbAkP8+yZADTdmob2KlbgFNexdMtztxSCb3DMKg4hJVbRyw3eKLyF2Yofvgg7PsxuSc+BgH7bTQaOhnBYrJDX7a0KNcktZ2+TdZWjCyOTkg8ZzcDr7gRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBSyJQ3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBSyJQ3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AC91F0089C;
	Sat,  3 Oct 2026 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013617;
	bh=5LWeAhpE9748/WcnYi9GaWSzyke7CA3XJRiH7AP8Pu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBSyJQ3phmsLYizfB2xG6ChU5F6ujzNMFVIilAkHEZGk4U/g1XK6aDEwQ6s8uvJdv
	 0T5p8+vLeLXrKHPiQQjDJJqjpFfvXstpi12FJIgEu1A6btm6h7d05nFcBDGRvdt37K
	 tQ6uOTy6tTwQRwBbP7mgR3BmSbqN7xb/1jMMnLF7jMqZD0p62W1u+tTZAQ25xlPrz1
	 tiX+M1M4Mb1JZa37vU9R7o8c0tZT/qQffoTzf/qSMpiKeJMSxftTIKHQ+IsOfsFnA3
	 dE7sOHSPdxh2+dOR8G0BpxLRboZH1l1+EQXx1TOTB1qc/K1EcfM6kW3gW7M1Be/UrP
	 3qc6LFWXbCS2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] vsock: defer RX readable notifications until batch
 unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261002074551.318789-6-physicalmtea@gmail.com>
References: <20261002074551.318789-6-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:46:57 +0000
Message-Id: <20261003074657.71AC91F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] vsock: unreachable callback replacement abort logic in batching
--

commit 811453fb266663fdded1db37d3b4cf3bde547c9f
Author: Jia Jia <physicalmtea@gmail.com>

vsock: defer RX readable notifications until batch unlock

This commit defers vsock RX data-ready notifications until the batch finish=
es
and releases the socket lock. It records the initial callback to handle
mid-batch replacements.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -2015,6 +2040,13 @@ void virtio_transport_recv_pkt_batch(struct virtio=
_transport *t,
>  		    vsock_addr_equals_addr(&batch->dst, &dst) &&
>  		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
>  			sk =3D batch->sk;
> +			defer_data_ready =3D READ_ONCE(sk->sk_data_ready) =3D=3D
> +					   vsock_sk(sk)->default_data_ready;
> +			if (batch->data_ready_pending && !defer_data_ready) {
> +				virtio_transport_rx_batch_finish(batch);
> +				goto lookup;
> +			}
> +

[Severity: Low]
Can this branch ever execute?

The condition checks if a custom callback was installed (!defer_data_ready)
while a default notification is already pending.

Since custom callback attachments (such as BPF sockmap insertion) require
acquiring the exact same socket lock, and the lock is held continuously whi=
le
the batch is active, is it possible for the callback to change from default
to custom mid-batch?

Could this bailout branch be unreachable dead code due to the structural mu=
tual
exclusion provided by the socket lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.3187=
89-1-physicalmtea@gmail.com?part=3D5
