Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696253;
	b=3NB086qMTK2NIGdH/XYwDClub/+rp2O9pQQepFJkYmruUWYUHAaxP3iBY6W/zQEOv8Zh
	 T+jGe+1Ydt22pdawvpuMSVmZudQ1VqYyGwsat3bGwjHB2xSXQPus+FgCxchUppOJAcsEb
	 Iom8Kkvo3ekIMUFyOXkhod8JpvyacskdPU/TNkUjalkp7qyFR3YxsLWq939qcVcRk4IHS
	 PKdHM6eJRna47JebRTKw8jjkRJiVpzkOusTZLQ6kcCP/RtJrNU+E3ixMecJ47GU3hA/l8
	 9/tR3R364AaTRR/639uo/2XHjf+yKo6tvzOEi5NEh629J8x6eSmIUAVIArZRVCo2lmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZUMSLEBafRMuZr9iRe5wIuQuOGYTq39uEIpdXFMCe58=;
	b=f9j1NxAJGosTO46SF/turcL2mCo+kEeJOCN3fbLt0dfOMzuX1VMgcqT/1ALr27IVJurJ
	 2f2pV3rHITm9DgXELYoY12OtczQPynsXaFLGI57+7kGOOz+7Ye3dhdU8nblkxI3JuP4q8
	 gLJOQe6CeENSDl7m/sjHRLhW3j3e8seYg7HG3VFEJdvfvI7EGK/qOMCpCD+DSUpQ8K6m/
	 qN1Z6pHJ/wSJVHkMGgW2THa6qPCfJ6bELZKVR8MR1RauLYisLOH51c+MOU4vjV/5jKGy9
	 BAg1Oq20Zm4kMthZ0BcLby1PKpW+LzuVxRijNfu+DTkIxO2+YLVJtN5tr02KGkWexGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJWCL9mX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8F606A326
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJWCL9mX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE66F1F00A15;
	Tue,  3 Nov 2026 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696252;
	bh=ZUMSLEBafRMuZr9iRe5wIuQuOGYTq39uEIpdXFMCe58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJWCL9mXDLKbykGCpDF5Hg+xTzY1py0FTtOAfQBJkD7Gzo0YqAj9PypjbGWsDeQFq
	 7y541zHl6ZBHxP+IOt7zUB1DBSzKvIU/wX7tUKykZaDiUTHYwWRoucRTu5xSeB1M6p
	 NsS2Y9cjizzPb6WJOmZ9xkGA7nUDv/yLHizYrDlDFLiZWv/aKbDccHShh3GBxMMZ8O
	 MmftewYst/94FQNoTK/4S+iwjWsFJf1sAknVfz1Y1M8igfMn2yRC4QwIC5r94uRFSt
	 lp0ThO2/nXoh+vz5RKkEe8yl+9xeExmKbxslC2lkwVZDD+6OCccnADesuB1yqmekne
	 WGXbUjbt49jUQ==
Message-ID: <sashiko-outbox-194901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio: console: check the control packet size before
 parsing it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanglei Zhu" <zhugl3@xiaopeng.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103084156.426810-1-zhugl3@xiaopeng.com>
References: <20261103084156.426810-1-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:57:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The control queue handler hands whatever the host wrote to the
> control queue straight to the parser:
>=20
> 	buf->len =3D min_t(size_t, len, buf->size);
> 	buf->offset =3D 0;
>=20
> 	handle_control_message(vq->vdev, portdev, buf);
>=20
> handle_control_message() casts the start of the buffer to struct
> virtio_console_control and reads the id, event and value fields
> without ever looking at buf->len. A control packet shorter than the
> structure makes the driver parse whatever bytes were left in the
> reused buffer as a control header, and the uninitialized event then
> drives the port state machine.
>=20
> Drop control packets that are too short to hold the header.
>=20
> Fixes: 17634ba25544 ("virtio: console: Add a new MULTIPORT feature, suppo=
rt for generic ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103084156.4268=
10-1-zhugl3@xiaopeng.com?part=3D1

