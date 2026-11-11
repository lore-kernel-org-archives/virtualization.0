Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418925;
	b=d0sD+ZJXr1aHiGZSVMsQDUwUwVVxnaH6oHLoFLbNFuBjfYgBcSZy6dgglLG9yjtwWou/
	 1lHXhyiBT5dnp162a1C5QGGMvDs2q/83MNUg8A/jAULCmL5UZ1GHnRu3VTG+C2jm3PSBv
	 LAYVcnVcdc+3hE8YrRyOpHAG3QI5Zbaf2nqMtLGnuWrcksvUWRAsByJM9sV8i7CKRl43K
	 Ee7jiIcUSBmQ/znxn/apQipHw7/OV7PvhdACw918czV9jYdIA4H/Fojcc7y7rVbE15nki
	 J2q+8leCGIs3+yCLizaeTdxouSaoCW5vz5ZRfI2N3gW75Q3rC6+eu4ok2T2b01Tb9Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bbyCKMKi723E2Ku3bzE7FnvIHLPExArMYs/ipDabs3s=;
	b=J4flOiLHSWH/fLbB3xwTlWId6tl/w6bhwtBA7ztwmLWnf5ptjFNgtYBFtU2y/J77tLCb
	 Sl7UrYRclld0riDBOdEzJ1fkfJfs1lbi7KigQDGjfq/aTSuXvEz+aQmKsZVzjSOkMgZoo
	 tfWeKqhw3pRi3DhLaEVLwynTvWoiOjhqLSXnNvSSVpYEQOrEFqoCD03Is9uRqf5MRrxQI
	 dqWCaH4G47y2uKayzvRkMOYeAk/PwKk1yr1W80erM48qePN8TtpZQWmjkqPTk8uFzBIvp
	 ffTjfryghL9VV0RhHRKeBVhe5sLYWPz5/qS7kkdwl0o+lKVwXwTV+pjIyVSIwFGK1yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5c+NXVa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDC606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5c+NXVa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242EB1F00A05;
	Wed, 11 Nov 2026 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418925;
	bh=bbyCKMKi723E2Ku3bzE7FnvIHLPExArMYs/ipDabs3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5c+NXVa2ndgx9xkrktN37j8ewC5QjWQNVZsBoMOhRhP6cAVw2ZKnIsYSJrI806IS
	 /jmqQi7kmTD435MknS6GT6zpVtIrqaC/evKbexeI4YHqAEBJn5n0s/lLdrWqmypleL
	 voGFjlZnhfd5j/vonBERMsJtAXpLvllXoJR6tHGeyjDyvhHN1oDoG3x5miZE+CC4O5
	 ABN12qi6qWcLuHvvK0XOx5JEI5XE1INuJDCx7NyiOXzDHK1jGNsURHkU6LkmwItzGc
	 a5hWOobw0zlFL+3zZkdd/27+ZTZ1A64etVo71naS0dr+mRZG0D2athXH6qXrGk5YQT
	 Y8MsE6rOnzFug==
Message-ID: <sashiko-outbox-209429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools/virtio: vringh_test: check that a split ring
 must be a power of two
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111172947.3579982-3-stjepan.poljak@gmail.com>
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
 <20261111172947.3579982-3-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:42:04 +0000
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
- [Medium] tools/virtio: memory leak of virtqueue in main() [1]
--

commit dacd77c2e0af2c3d6ebdce34137950d56c8f8e41
Author: Stjepan Poljak <stjepan.poljak@gmail.com>

tools/virtio: vringh_test: check that a split ring must be a power of two

This commit adds a check in vringh_test to verify that
vring_new_virtqueue() rejects a non-power-of-two split ring size.

> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 2a5d7f7d2d6ce..75c66385502de 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -494,6 +494,17 @@ int main(int argc, char *argv[])
>  	__user_addr_max =3D __user_addr_min + USER_MEM;
>  	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
> =20
> +	/*
> +	 * The split ring indexes its rings with num - 1 as a mask, so a
> +	 * size that is not a power of two must be refused.
> +	 */
> +	vq =3D vring_new_virtqueue(0, RINGSIZE - 1, ALIGN, &vdev, true, false,
> +				 __user_addr_min,
> +				 never_notify_host, never_callback_guest,
> +				 "guest vq");
> +	if (vq)
> +		errx(1, "vring_new_virtqueue accepted size %u", RINGSIZE - 1);
> +
>  	/* Set up guest side. */
>  	vq =3D vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
>  				 __user_addr_min,

[Severity: Medium]
This problem wasn't introduced by this patch, but does main() leak vq
[1] when running with --indirect?

Later in main(), the VIRTIO_RING_F_INDIRECT_DESC test branch reassigns vq
without calling vring_del_virtqueue(vq) first:

tools/virtio/vringh_test.c:main() {
	...
	if (__virtio_test_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
		...
		__virtio_clear_bit(&vdev, VIRTIO_RING_F_INDIRECT_DESC);
		vq =3D vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
					 false, __user_addr_min,
					 never_notify_host,
					 never_callback_guest,
					 "guest vq");
	...
}

This leaks the initial virtqueue and leaves it linked on vdev.vqs when the
cleanup path at the end of main() only deletes the second vq.

[1] https://sashiko.dev/#/bug/linux-e99ea9bc-10be-4c6a-b7f2-1998001de64b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111172947.3579=
982-1-stjepan.poljak@gmail.com?part=3D2
