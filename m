Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BA4A9D49;
	Sat, 10 Oct 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643169; cv=none; b=p73SJv9hMfae8pckibIbjLnJBaDlHMKMcHANuk7sZ9rMzyIvPHp23v9n+i5PEZldW+OVea7Q3o7o2o/xPJJUyH95u3Ra66f4z+VOw3zMEJ3VgslaKC+AVUc5DhMOH3Vz6pvgOgVQhx9UlJWw4ZqVValHpIgbJbfBw59ry7DbDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643169; c=relaxed/simple;
	bh=uVUA1XsbirmFtp1MWpJ9obl2KTmxX7wj88ccSzNbqcQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hvKVhknx1LoiNE/1yKPw5pKbjzJnH9eKQ1uVVqzV1oFb9MkHjF9qy8JtvsDf+liPAXOTZ9q+Tshsp/s5yaw1XbZC3Kv8xECS+6BEAfziPsNnwtMR/aNfdEMkvuiWbGVrN3F5rXYlNvIKZQ1xMFwkS+CI3tPORBZP2CFL11wY8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQg2Hch5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQg2Hch5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781931F000FF;
	Sat, 10 Oct 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643164;
	bh=uVUA1XsbirmFtp1MWpJ9obl2KTmxX7wj88ccSzNbqcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQg2Hch5cRjrDmBKfGClW9KaHXrt0fSMp4uyIrpKd6ORjb+4LderCp7sBaKPqElTi
	 yTls3JfZ9V0eCNura4iwXBSAYQAphCzaaNDAARCTpk8rqPxb/tLUVSvRIoEZTYwqZb
	 4IbyiIRlkriG4jEx6OB337d2kRvokpUsrL06g1UYg+U2oF6kRPsdTNU8YHzDaVWhVu
	 H0x7+OMpf20k/+YJ+iFwfhNujcfxa90ee6o7djI7ZGIppX2ZYNF92WyRhmjTGpOe7Z
	 NK6i1LcleEDlUdAThJIHZHuKnEddujz65Pw8Ki96kpResz/H4kDgk8M6BWGV0ht8Fu
	 1w2k728sN+FOg==
Message-ID: <sashiko-outbox-166654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/5] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261010142247.99223-5-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-5-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:39:24 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Each received packet updates peer credit and calls sk_write_space() when
> send space is available. A writer cannot use the newly advertised credit
> until the socket lock is released, so repeated callbacks within one lock
> batch cannot let it make progress sooner.
>=20
> For the callback installed by sock_init_data(), record one pending
> write-space notification and deliver it through the saved default callback
> before release_sock(). If the callback has been replaced by batch finish,
> invoke the replacement as well. This keeps the native writer wakeup from
> being lost across a sockmap callback change while still notifying sockmap.
>=20
> Save the initial sock_def_write_space() callback when the AF_VSOCK socket
> is created because it is not visible to virtio_transport_common when built
> as a module. The fast path uses READ_ONCE() and adds no callback lock.
>=20
> Set the batch socket before processing its first packet so a batch ending
> on that packet cannot lose the notification.
>=20
> Packets outside the eligible STREAM/RW batch path retain per-packet
> notification behavior. The 64-packet and 64K limits cap the packets whose
> notifications can be coalesced.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010142247.9922=
3-1-physicalmtea@gmail.com?part=3D4

