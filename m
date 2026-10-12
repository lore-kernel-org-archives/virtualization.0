Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B60370AD4;
	Mon, 12 Oct 2026 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846316; cv=none; b=pnXWY4yZm0p4G+FdwSt6rfkR0GNKYx1LtQeMVXON76XvMwRZZUCNn6qhyf++ui47SjSRqVcGYbu2h8K6FGgBE0xcORjJ2giFJrqIK1iIpwP6f22nP0ekEdBQtUtwIrGjFI7o1bPdfKgF/W5n+SQR4Bx1jdPh66mAYPWq1J+Mz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846316; c=relaxed/simple;
	bh=OqMvUk15HzxNXVcTKA4wCwsaxQd/xRfknZKrjsDSLgY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m0nxyT1efX8bhbcUZj0r/i9HOQ47iaqcN5hjJtE7ZN8EQos+eL81FWAeXJcF0lkOeBppu6trPKO8NNibCZMVaDg4Bk0+fxgrI4fGJsa6QVjag7ePAbf7r/Vdw3nEbMj8k843vRNQW2vT9sLD1QSxY0zPXjsu4R/GBcV8VJjDOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INU0cly0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INU0cly0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370231F008A1;
	Mon, 12 Oct 2026 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846315;
	bh=OqMvUk15HzxNXVcTKA4wCwsaxQd/xRfknZKrjsDSLgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INU0cly0ddsOvSSQmlavw7o5R2ytVcb8puhTKpDa82yZ7L6a8yFK+HCaL+oAOVEWq
	 2Odvesv4nhvqsNMnC1k8dBfotnifkEYy+Auj2BpoNXHkaGEFzxz7ypAC2FtAl4lWA2
	 jzHtv6BEUdrb+krsAxtvws7XXFpgUPg1dnx3Y0HknXgwMVw/Va4btzXQcnG9p6Zg6k
	 4oxSKrqoSRRHYJ4fZUZYXWqAIcwdPlXj5mOdqBtSgmOm+l6TEozbuq3ekMZpDhmnWN
	 9DudT3N6mZDYAy43N7DRvM426aPsuF4ntSRHRkELHeTjqlHVJBiwGyseVTkk4ImSBv
	 9LjjJEMvMEPJg==
Message-ID: <sashiko-outbox-168690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-1-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-1-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:14 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D1

