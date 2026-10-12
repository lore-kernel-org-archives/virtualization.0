Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2A3CB54E;
	Mon, 12 Oct 2026 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846318; cv=none; b=aM165G9bz5UhM9jcFwhCcqOXgvmd4l9PIHZXCHTQvuMeZfntQHNoj2+wu/1Vi+m168nBXsOmFyKp5mvYZfY/vGO19cZKXkjwyjxlda33y9srFumFfQbhm+LR0mC/uU3ffHHu2ze1ZGzpPDertDISiEQyixF5rIHO1EI3AiYk9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846318; c=relaxed/simple;
	bh=kCNzKp1uvT9caRW3pGUQ7YqtNVBYWgR49YzgcCNUAY4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=umRkm4TI+IAmIVEOzkdIx3TuvqnEr3lcrHJBrVuPXyndH72ijdSNZEjj2/zzfzYbuvbq2VGmFoJU8TT0oP4YKlvtOUeizjMJ/TaeI83SSgE1WZBcEj6t9FDM5CFJCRIjCyI09qAr0UiSoTSlilFPIUhL5omfCsBUNzJ7b7Px0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGTYsplm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGTYsplm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FF11F008A3;
	Mon, 12 Oct 2026 23:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846317;
	bh=kCNzKp1uvT9caRW3pGUQ7YqtNVBYWgR49YzgcCNUAY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OGTYsplmjiOSJnoE01oGIxTpYS9FCq9u8yJkyPS6Y9WzK/2vWtH4SbDW8NWqK0788
	 Z9L6qxflUiRfOAyWvgPqrEk8LiyEv2AnPsgJwVrGduRB4wy1xft5ZI3rL9EgJd6tTk
	 bATqVwl2UyzG8tUypgWIB60WkEJFMM5s9Po9u+qQew5I+rdCpokDax78dmMMr+oW/W
	 /4PD09AWczi4Wk51WDO09pXPGubXJT/+hQrqJxpbycDFkDaVT0HvtBlllYW1iTfP5r
	 bg4FQAVJCAJacw2v73WjHiuOq6f2c+jVNWd3gUcvrGuwCoO1CF3IIsP3o/kGw33OKG
	 zCNPB5O0b5Slg==
Message-ID: <sashiko-outbox-168692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 5/7] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-5-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-5-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:16 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio-vsock did not have namespace support (the device was always
> accessible to any global namespace).
>=20
> Make the virtio-vsock device assignable to a namespace and initialize it
> to init_net. Because virtio-vsock and init_net are both hardcoded to
> global mode, nothing changes until the assign command is issued.
>=20
> An assign can land while virtio_transport_rx_work() is draining a
> batch, so the assigned namespace is re-read per packet rather than once
> per batch. Matching the rest of the batch against the namespace the
> device has left would reset connections that belong to the new one.
>=20
> When a device is assigned to a namespace, every already established
> vsock socket that is no longer able to reach the device is forcibly
> closed. For that reason, adding new sockets to the connected table must
> be performed atomically with regards to namespace assignment. This
> ensures that when the socket is added to the connected table that it
> actually passes the new reachability conditions set by ns assignment. If
> it wins the race to the table and does NOT pass the reachability tests,
> then it will be reset. This is the purpose of the new helper
> 'vsock_maybe_set_connected()'.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D5

