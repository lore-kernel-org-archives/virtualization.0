Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590727;
	b=QqOwLHG3WeBpU48KjWbdXU8XSDBODrLoBhxqJfawOTim85rboWBhVKzKYNrxZHQj7iE4
	 z7Nc1DpH2KyD/6F0Q3vZ7zRiouBdR/vqs9iXOIFgPVAUqf1gl65uC1r85umayECBPa4LP
	 uTQnkPlj+ZST1GSc7S7tR8WuongPNZhLxDiljuZ1v4eRBe6LK89B7jnbMgOSIMHHKX7F+
	 9WyR9WRc9ti/UpDkrZB+Y4HSbHszyoMrnYpyJkmXE358Pca35H/PjnIjJRb1YHFpJAJNP
	 2aUUrXjPr1MecWQSxBBDvmo4Jqe8NEAKpysWMHnHmFCMB50IGaYA/svDLVX1/PU63Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590727;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vrv1IhDGehV5oZxT3Y1WqUZwa/2C/2pxuGz2iWYV+qU=;
	b=aHrCc48BfacbErqXwcX/G65/Otz5a2wm13h1cP6Sajp0tOj+r7j4UJGJVEnvMn0bID07
	 Tfg5wItfgmNC+DlcBDIuTFhwKnzW1I+jg/k7mcJhktNq2VvdyEAUpWs6NiNkWbG5RJvGk
	 p7akAAgO9B8qOyCt8lhUQifjJYpeayksj9QDTb9G1mDUimA6oqXy8+hjJ9LD/z3WcHYFM
	 K6Y0f58SAaQD3c9FEALuIba6ffTu0nRHwClA6A/VhYr89yymxI+sZyiTh36A9LFREud15
	 Z/5/+cWpmKqwVbcuD8svyXQ7uXtwZXS4EIF9+uXLJtl3a/QpnDCm5aw+N3iuiIKFGcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UjfNoBX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B46079D48
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjfNoBX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498DB1F000C7;
	Fri, 13 Nov 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590727;
	bh=vrv1IhDGehV5oZxT3Y1WqUZwa/2C/2pxuGz2iWYV+qU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjfNoBX/zg8EhZ0DkRZGTc8Fi7IuvLpcuXEnhqvSlLtduMDsnQYe3fuqc9htqHyn7
	 J61JlDJYUnqRHkj91vSfyj+ud5MupegxqkzS7324RVUEyDulc4Tn/oA728Swm9Xi/Q
	 dyJ4Kq+CDntmfMWiLEXkkuOKwQSxTNkuRidmeCC8G28F0Xfvue1SyyUe9Uzbx5a/WI
	 tJM6I21ncs3A3wNETcBHonZRr9uAxjEN3VKDVdmcz4QykWDWAO8v8d59iWDiuadVGt
	 jrTbuD0YFdIujKzgpn13kY1fWy06ctwZmmRiHSDSUa6H32BHZJ0SYla7OIOT3NXUhY
	 otfX+GKph8F/Q==
Message-ID: <sashiko-outbox-213303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 2/8] vsock: report datagram receive and send
 queue state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-2-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-2-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:25:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Datagram receive queues hold whole messages, and transports may charge
> queued datagrams to the socket send buffer. Report the size of the
> next datagram payload for SIOCINQ under the receive-queue lock, so
> concurrent recvmsg() cannot free the skb during the query. Let
> transports override the length calculation to exclude headers such as
> VMCI's.
>=20
> Report datagram write readiness only while the send buffer has space.
> Set the asynchronous no-space flag when it is full so freeing pending
> send buffers can wake poll waiters.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D2

