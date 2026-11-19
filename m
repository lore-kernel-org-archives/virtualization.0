Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052326;
	b=fAqdpSIg0hpCTHHgEFx0JCZerbgC6fDQeLwGJAGFPF8PBPHj9s1T12eUyQxDV8f70Hob
	 lEtqR+3/Nzkdql/Z09sSNyHKHFJ0A4GyW09l13zrojllHsyNT137roH9FXk+qI4bQqnkb
	 bIBKytc+TX+dAQUnn5EGCFs0b6M0AeLMXkZHExqUoTflWbcPRl1IyzTaFjVoIQ457z7wh
	 HlEtkrz4AqpVqQcKR4ietoMU+TnjRNjTguquthvshOIc91zG40rnie0nsRAEgMKQA8jam
	 aaxGknzkM2tfdslsVKKInEFBlBMu9osxnzO6tmesGhErLGWHPJMm3kG2yWmW8iT/JEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D01aJBrZC7/6mUunqovzNwzO9YPPaZNm3CZ0NnyrX8U=;
	b=Snxm1LQxAFt18h91E7C0K3wdL0FK4MlSzsa1lLdqFPwKRnwOT7TeagppSZ6ayuvtdFiC
	 tkD16OzZ/9gtXIwhAeEJrwfaywd0gSdz+ozkww/ePSOjLu3EMfmed8et0szTahajb8ryQ
	 w8RnNLsJ12pndsB8chAT8Z7ANmUJ9GiVG6oCZkYh4YQmnBOnAXiZ9Vn3fZSZWVN3xUdAm
	 ds1RNtP4RS8nbtf0zZWp4yhRXn7PlXDZPtOrtSqQFwAg5kXsc0KnNBsrHODpx0uNd29TO
	 b0QqkhuxG7iyBoecRkvNSA3pxx2qsRuO6W5hMsINxuCEEajMEhb8f7IsHjscidnrF6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mjzz3yN6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A5606A335;
	Thu, 19 Nov 2026 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mjzz3yN6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B83C1F000CB;
	Thu, 19 Nov 2026 01:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052326;
	bh=D01aJBrZC7/6mUunqovzNwzO9YPPaZNm3CZ0NnyrX8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mjzz3yN6FsVNIEvPo6J1+bIp7QSOnKvVjVGQ75TzMD0a9tQD3Y/v0S/B2rUS9okJB
	 2lCxKFL8WRLQuzWB3Dzt4JJuDPlSGs9d5VgmWSyuumNnDj2iQLNEpqcbr9LMGoQDhE
	 BuRI5xuK3TfMwvr5xCFaq0WTtiJP/dJpLQLKECgCe5Ycm3LUOP0WheYAABlzEY7A3D
	 QML7kCA8rYW7mR7KoqmLOlOdFiYpKOzif4XlXFW/VWw6etseAiBpxHI3WSvSCBM9VH
	 DemolQeDss9iiEYYiuCCRDHkMYElNX9ckhawJp2uB85Fr2tnh9YxnEsFhUL8Uzarr/
	 0RWu3rzLkMPMA==
Message-ID: <sashiko-outbox-222286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to
 guest_cid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Dinh Phi" <phind.uet@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117164916.2332953-1-phind.uet@gmail.com>
References: <20261117164916.2332953-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:38:45 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] vhost/vsock: hlist_node reuse in vhost_vsock_set_cid() breaks
  RCU readers [1]
--

commit acdb8244e7111ba9c993f9a479a6926d4b658392
Author: Nguyen Dinh Phi <phind.uet@gmail.com>

vhost/vsock: annotate lockless accesses to guest_cid

This commit annotates the write to vhost_vsock.guest_cid in
vhost_vsock_set_cid() with WRITE_ONCE() and the lockless reads in
vhost_vsock_get() and vhost_vsock_handle_tx_kick() with READ_ONCE() to
avoid KCSAN data-race reports.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0a..f26c590130759 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c

[ ... ]

> @@ -859,7 +859,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vs=
ock, u64 guest_cid)
>  	if (vsock->guest_cid)
>  		hash_del_rcu(&vsock->hash);
> =20
> -	vsock->guest_cid =3D guest_cid;
> +	WRITE_ONCE(vsock->guest_cid, guest_cid);
>  	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>  	mutex_unlock(&vhost_vsock_mutex);

[Severity: High]
This problem wasn't introduced by this patch, but can reusing vsock->hash
here without waiting for an RCU grace period break concurrent RCU readers
[1]?

When VHOST_VSOCK_SET_GUEST_CID changes an existing CID, hash_del_rcu()
unlinks vsock->hash from the old bucket and hash_add_rcu() immediately
overwrites vsock->hash.next to insert it into the new bucket.  A
concurrent vhost_vsock_get() traversing the old bucket via
hash_for_each_possible_rcu() can follow the updated next pointer into the
wrong bucket, skipping the rest of the original chain (causing CID lookup
failures and dropped packets) or looping indefinitely if the node is
re-added to the same bucket.

[1] https://sashiko.dev/#/bug/linux-0431a358-6215-4016-8a71-f047effc16b0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117164916.2332=
953-1-phind.uet@gmail.com?part=3D1
