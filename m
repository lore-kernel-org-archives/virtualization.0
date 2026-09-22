Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6B54EEAE;
	Tue, 22 Sep 2026 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084625; cv=none; b=N5rZxG7fEEJYaIyEZ3uChb8JDiuMyeJA3a9M2823hZxPSclOMGQ4FHT/e52QYHOfdG+ZbFiZweX8ICkzyRLigb23bMQuZzTzXh59QizkXeAO7jW9eVIiUWngSRM7JTR+VaobUx4YlSTrygx07nChuQpUX5jv3L/LcGhFwKQWaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084625; c=relaxed/simple;
	bh=u3VgFldRHuzB9THAr287+82+C9pTT+eP1mw5iHsQaDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVxRus06z1i2cdJ4V60Rj6RRvJCLAdJdW9cf3cEk8t2kg+Px2V8plI15HJX8AbwYgstr7SjOEKZB2dWWaETkyfpJ3qT8121t7aZip8W0r3vuY25tPoWuLj24YL+deoi0oKFPwl8CK8XT8vo7l+XU777HHvs7gZrgRYAKc1kdmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJU8100n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJU8100n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7A51F00898;
	Tue, 22 Sep 2026 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084624;
	bh=DFPTNUKxunDrtmkZhSSos9fiuZLjU7SGils4PvKHy7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJU8100n9+CANKB/UKeeMM8xDofrf5PF8ctKXlQGIQ6baZ7hjub9PyolhvlFFMoz+
	 jQk2fq601bFDKs69wQYJab7d0+9qpKaN4V4Oh14RkPRkSKl7+h3+InFlqsCV/Oww6p
	 S15Hbx7r+Yw0I/ZMYPb8zNEL86cIx0RESTveWBAFHiflIgqP/t6lqY25z7CllS2d7c
	 c3je7Sf3fXmjqlZ3BYJmPNXzWRHgyEyD9lW8IUfGVAJb96nlJZ6BxpkByUH+IIpkae
	 VvNscDFGapQ5PZ7BwwYa71i6eNHhbRcJfwaJaIZVomkRoVtiplikUayDrsRgyTl+HC
	 yFhWFfoAVbPiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 6/8] vsock: handle socket bricking due to
 transport event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:43 +0000
Message-Id: <20260922134344.4D7A51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Transport events are serviced by resetting each connected socket. The res=
et
> is done under vsock_table_lock but without taking lock_sock(), so from the
> point of view of vsock_connect() - locklessly. The same pattern is present
> in virtio_vsock_reset_sock(), vmci_transport_handle_detach() and
> vhost_vsock_reset_orphans().
>=20
> While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
> transitions can also occur:
>=20
>   TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
>   TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
>   TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
>=20
> But transport events leave SS_CONNECTED state unchanged. So take a note of
> that, rather than a) making every event handler drop the socket from
> connected_table, or b) adapting connect() to handle more transitions (whi=
le
> missing proper locking).
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D6

