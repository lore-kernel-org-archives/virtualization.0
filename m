Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D93D410E;
	Mon, 12 Oct 2026 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846319; cv=none; b=S9PMNVYy2TX5F9WDqT8lIPajsmKWD47kDepCyY1wuXNYFlz6OEXptxgCz6lBfahHZxuilYrYsHImDAbPB5ZBAtiRXTPI74HsExLpvqTRNO1f+I9QPRRk5Szv24HzPwxN8cqn2KS6aIFRyuRH3pE+2Nog74WIJI4f6D/U1cipvm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846319; c=relaxed/simple;
	bh=a5NSE/OCPjj8EGbdtDl914oTcYk4hmng2gRLj/0pDsE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CzESQqaZW+F5Vp/m78U1cMsTYD2EIowpZJ3eJ0Q4fxp4pqCtu1Dzf/dff7Bsjx6FNPcooc6GAjVjrEWprMXL3VnYR+UUnBTa/ktTLlCKRCgJPIMURP6tqa/tQ8rfZDEKHbJVJL2uM/Wt2KuNxPUNXmObVv1Ic+kS/1ZW7M81WIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtg+VdRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtg+VdRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52E1F008A1;
	Mon, 12 Oct 2026 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846318;
	bh=a5NSE/OCPjj8EGbdtDl914oTcYk4hmng2gRLj/0pDsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtg+VdRXVdqcvRtx0thUgHuiUmHpdK+M4Le9V4aGm2TB93ckRep2A6h5B5sta+lcR
	 Knm9xWgPEieTSTaDIjld9tRk1ZBNEVQhtf4Z/eiA1Q2EeQw8O2Tn7pVAQF5yqSWO2S
	 E0NoX0STQSmSASv37djkzdTWxHXXLDVZHrUFn6ujmvdGyTgqpyYfHc2CJoP2zzL++P
	 FR9yoONf96nuSZR3obTDjj/nAXlShffCrLgtXQQdaUEtBiZ1Fiko5Ra78Y4+phwPxp
	 G6WbvxpPHsFn3kkK3BUUm6TxF9IX5dTcLiYl+A3TWzk8Yp7QRs8O7bI58eGtNaHoGs
	 MKpE9+1MzIZdA==
Message-ID: <sashiko-outbox-168693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:17 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Namespaces let a host isolate a VM's vsock traffic to a specific
> namespace, but in a guest vsock traffic cannot be isolated to a
> namespace. The vsock device is hardcoded to global mode and can't be
> moved into a local-mode namespace.
>=20
> Introduce a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET,
> which moves the device to the namespace the request was sent from.
>=20
> VSOCK_CMD_DEV_NETNS_GET reads the assignment back, reporting the
> namespace as an nsid relative to the caller. VSOCK_CMD_DEV_NETNS_SET
> replies with the same message.
>=20
> The command requires CAP_NET_ADMIN in the initial user namespace. A
> privileged user wishing to "unassign" the device can move it to the
> init_net, which is hardcoded to global mode (so no unassign call is
> [ ... ]
> user namespace is required for the assignment.
>=20
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredh=
at/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D4

