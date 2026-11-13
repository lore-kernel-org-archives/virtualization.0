Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591260;
	b=zwYGq7ZDojfEuy5YdJ33GfGFuD+xBzVwXdehGmMQtRESAVfqNUKiV9VoY0zX1BRahca1
	 6IRw06OrnrKKL/FO0SL+N3dneAq25f1pmqOtJojmPpfeGwfWfFtEA/HJE888nzT2oaXq4
	 A1LhHBbrDjvE0/WlD9UgYR3RkzsQwVj8+DHxEDZmiy7WPV+/IMc8xbBTbW3U4fVJ64s0A
	 Mp2FIpoLEkgv81ifnZ9eBK2Q0e+bAKbyRyqPRZZitnIxoAJI9xvYDEJkKMT8ASAnhxYjB
	 sbXZKO7OlPCy7mlOuAf1SzyO6Qdr82mtoDU/w42ir4tU7rBilVn/HdpTEk37OJpTjPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3r0ndq6M/Qf5B4NBYz6vbzQtjr2yp7/aZbNXsGp0yRQ=;
	b=THv5FHQ/pwh6+5IVpAZNy4i2lo2NxZt8vW+qR3ylXGNG15VlQKYg6ZADuPsRd9QtWXLH
	 GagiZ1Wt/a3WKivlpOVMaSigLcLY1NwNne+Tsz56BqzZ6S3HuGF5A53BXCgbwHnJ6vxob
	 tr4qjPo+Gc3Dw/2LjcnFpTzbIEC33UtrLhjNd2amreldpr4PsIlZE7v4jX/ZUiFTrjC0h
	 Y4BLxTMfO9bHY+++YaYU+sliwdrrzIAwQQVAJ2QE8UOvz8lIt8QX9M4gLrU1KjOwP5niC
	 SX7Y1S304SpJntkHYrXShutrnwynCPM09M8K61pM+g0k8HQif90WJ8S3o2YhBOWRw/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsJadv++;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DF6076F90
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsJadv++
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B731F000C5;
	Fri, 13 Nov 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591259;
	bh=3r0ndq6M/Qf5B4NBYz6vbzQtjr2yp7/aZbNXsGp0yRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsJadv++/ICf6C2uj4PqLDXfMZmtihocXX7eRRNKxi7EUAxVU5nYnl4GGBez0h6Lq
	 QHZgDz0V3b5CKnnkKWixCmCzY7Awwn/NhJkaIjI0voWKpr/PhbJSwENO1AhyzXaUUu
	 4ROTgLGQlRUn5i55RiqTYxODZtoBhOULvD+Fg4ZyAfJnIVnBjIkZyjy8zN/enIfQbS
	 T93X5UQpAuY7Mz5bqXUJ5xvwFcklRhFMkewWrckNPaNZSMpasFCmbQu08AtU6VoRG/
	 2jrZzxl7lEh5eA3myRFw94h3dGItjdxZG09W0VL5od9KhxJq88CcQqWCJSxzRNCQVO
	 5r4a+FlIP7hRQ==
Message-ID: <sashiko-outbox-213324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 5/8] vhost/vsock: negotiate datagram support with
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-5-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-5-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:34:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
> negotiated value for each guest.  Keep datagrams disabled until the
> feature is negotiated.
>=20
> Use a vhost-specific datagram destination check to look up the guest
> in the socket's network namespace and require its negotiated datagram
> feature. The common virtio implementation supplies the bind and
> message operations; destination validation remains in connect() and
> sendmsg(), where the remote CID is available.
>=20
> Reject guest datagrams on ingress unless the receiving virtqueue
> acknowledged the feature. Complete rejected descriptors normally so the
> queue can continue processing subsequent traffic.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D5

