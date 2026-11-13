Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590543;
	b=vtGSxpGyCZmzl6RnpSDJ4x3gIyn/8Fm3kO+73JPvvmlUlR17h/H6vzUHqZoR3OdU9jh0
	 VaFYj+yv7waLxzLyGJr2Hv3hKYkIQUfOf5+JR+DADIwtICu9kJ5SeT2ZR7mERdZvCNSJs
	 59WzlUBS7nUGQIVbH0NmKYVy4WwSnZbRMGVyHpuljAo7+5wWwszNs4yD0dc13Qz2MTOcR
	 XLgSpsKhZ8VywuczmUBkTz3H+DYokCwwVxyZKFdAEzWPkShCXf8MuKCnXlLyNKSqzT2or
	 EtDDNgv/7xv0amXFNlUOKVF1gfMTZQ3hV5vNMHKB1K0aA3N4ntb5FGtPyuOkfvc/1lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c/lDAftOuB3duJdY9HIqZ1kmmjRxylTeiCuYIaIUJRk=;
	b=IU6873XyRZiWLYdmRkRHowvkI1rmKZiX3o5Rj1iXh19sQH9eicHqyt8zV+iBxYvDVMXW
	 IqFBk0nH/H8BbVpBDpbIZty2EB1vAVPt6YFV3Z1X+HY7waCwQf56/MX5cyd3fUXzrO8LD
	 F329YeWYtN5ZDiGjgnocvghnm1CpBxqbZWm8mzsZYIkVz//95znU+NBmqaoVVbW4Pze51
	 gdmk1v74VxLAUyE9DPs9YNm5OpY4w9Zs/PYaIwgeUU9BwvcOLnUXdXIsJ8yix3bqukuDx
	 xubNRgen4tTy9yG7qJk7V1wAvCJ10wLFnx+bODXbdZQAFM4+BSO77H7oQ24/y3ZSGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUou+g9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52A606B36C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUou+g9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9239E1F000CB;
	Fri, 13 Nov 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590542;
	bh=c/lDAftOuB3duJdY9HIqZ1kmmjRxylTeiCuYIaIUJRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUou+g9rS6+sWbgHEeBjb2V+3ch2RM2p2FNkc0yPupcJQ7EztaE+NxUVkD9lQIuK8
	 uRUxthxRBZZvAFo+kpQLQzZ2HL52SKc5xY+FkexWWF97kd33RcPrPCoc7doFhTNnp2
	 OcHrs6O8l7ilsuwFBujQYiMACt7J661AFQG1G6L1dpScMUTwzZOTuqw4sqeSBIlb54
	 R/YVVOrUrQf7wjOrAGGhfJ53a1FKMGcY60dpMzM1hjjd0WumFnCQ1gyjXvlul2UoVp
	 hkmxVhBBeM0zHQI/GXqmoWMXOhFiFtzfzPzWnG1EE91b+bwcNqy9pOGOh7WiJgJ/fA
	 ZhMVBW0RivbFg==
Message-ID: <sashiko-outbox-213295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 1/8] vsock: expose the core port allocator to
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-1-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-1-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:22:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The core port allocator is currently private to connection-oriented
> sockets. Virtio datagrams need the core bound table and port allocation,
> while VMCI datagrams must keep their own endpoint creation and port
> namespace.
>=20
> Export vsock_bind_common() with the bound-table locking inside the
> helper, and use it for stream and SEQPACKET binds. Keep datagram binds
> delegated to the transport so a transport can opt into the core
> allocator without changing other transports' binding behavior.
>=20
> Keep datagram and connection-oriented sockets in separate logical port
> spaces within the core bound table. Filter bind conflicts and bound-socket
> lookups by class, including wildcard CIDs and automatic port allocation,
> so datagram and stream/SEQPACKET sockets can share a CID and port. Stream
> and SEQPACKET sockets continue to conflict with each other.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D1

