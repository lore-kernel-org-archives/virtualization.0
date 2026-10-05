Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927B13C9C4
	for <virtualization@lists.linux.dev>; Mon,  5 Oct 2026 04:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791176192; cv=none; b=Z4PFTxmL/2jYwUfaVUf8GicuC2d+VP9Gvpn2I1kO7PBb6+5Cdbk0ilHDiBQrrrUNjqICazkXkqtX43MS3BnnLbvzJRJZ+KZvCoVH77zF4oQu+IQizgUMlHMT2ZyuCYOnYBroZtZqOiK7Lhag5lRskf7U5zR2zrICKV1py0RWP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791176192; c=relaxed/simple;
	bh=CPd2fu0czeemF/GCpnszw/dxXBdlCsQnNgIT+Gq6V0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0lr+aKD+PAtt1ew8hLippJlen5igJbFkWr/Q5/wEIjcd9H6G5cWFnND+Uyd5BlhNIdFWKYcVn7Ahz8hOHZEAUJqXaj7Fva80AuAzrqcuAzZcjvC1Cr4iS8/1HVwMVEcaTgIeYkW4vgmsX7+jMPbiXIVSa0mA6lzk11JopKPTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr1R7RKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr1R7RKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBB71F000FF;
	Mon,  5 Oct 2026 04:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791176191;
	bh=CPd2fu0czeemF/GCpnszw/dxXBdlCsQnNgIT+Gq6V0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dr1R7RKYq4gpwLIU1Z5w8GsgdzENQD50/K5CWviUPIhQEgzKQPmTGkyLW0koOJcra
	 JJApvc8IKLRlpirkqnxtc9rKuesdV2gD04OJiKDDrsXFTqHGEZpVmNBbDtAd/6SKB4
	 2E03zd9/AAHuLjTFoCsEPS+3wb1NGh69YczasuLlfl3qqKwUDAfYY6NibRU3RfXOa8
	 qj1lEjygy54H9gOBTe9qSLKhL8GYtdGgCKSWIFgcDKjBV6UU1Ojv9yzRDKEROfY6xR
	 fpBQRa6VY+Wo5p/6RvQUjofJ/h6LwC7qoyzhrDvUwVAQ4CDV8wPEjoU59bo/lrNGoj
	 p1nYE47mOhK/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vdpa/snet: Don't discard the DPU error in
 snet_send_ctrl_msg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261005044915.264532-1-oss.patchbox@gmail.com>
References: <20261005044915.264532-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 04:56:30 +0000
Message-Id: <20261005045631.4CBB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> snet_send_ctrl_msg() reads the error code the DPU reports when it ACKs
> a control message, but then overwrites it with the return value of
> snet_wait_for_dpu_completion(). As a result, a DESTROY, SUSPEND or
> RESUME that the DPU rejects is reported to the caller as a success as
> long as the DPU clears the opcode register in time.
>=20
> For SUSPEND this means vhost-vdpa marks the device as suspended and
> lets userspace reprogram the vrings while the DPU is still running
> them; for DESTROY, snet_reset_dev() never even sees that the device
> failed to stop.
>=20
> Return the error from the saved ACK value once the completion wait
> itself has succeeded.
>=20
> Fixes: 3f3a1675b731 ("vdpa/snet: support getting and setting VQ state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005044915.2645=
32-1-oss.patchbox@gmail.com?part=3D1

