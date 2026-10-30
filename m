Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329333;
	b=smGx11M4d1OvlbVw+ITrU3ioduRoUFrXZArBsOovKTccA/ev2hsN8sIIasJWLQ9CbEj2
	 900z0VOi33oKj4csX/dX+gtuzM3sGIuo8QqRYoMkPb8ZxwSc5arVjl9wrmQhCt3at5EFm
	 PtbWkymVq+LqHH8/Gu+8EGob6pO+YnP8RRF0TQig2NxzaROjstUaMmrxplb33zK4ZdpPn
	 UGlV2XCsv3YyqY+hXy8zdfkTG0Yr9b9rBTscmnXIc1VUz2YzPzSU7e8ej/lcQXR+G3qtl
	 5bUthFg4hRVSlbxV9JzH5nNEhlNeSwGMEQiV7+/ywdS3+2f5DMTxt92D+W2jMA/ka7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CTqjPQ5cTJMN7TPA7YZ0B17wjUxjkaWSkyRExqZQQ4g=;
	b=jna347hLAcv4et/Vda3EdztKi3xYmGQif9vjdNg4vAb0z3ko3VZGcRoq0tHnjh+6Xygw
	 VwhuDTi5fPP3HBVGMk6IWEmtobS2mH0i6z2UTT60F2w8s9whm07y/Y+o9J1JkRlKYLfN4
	 avy95iHhsvPDtg6EkPPmZ4BXFg/Cau1T9gNp6x5QfgnsXeOcm64ugi5i3QsVGLeFXu3tM
	 cGhk8q+CnKNs61QHfIq3hsauPLoGIAMyx+YQ0LASNzJ/ljKgNwSGvXBnT6ZyXRxG8NT0y
	 01I5plQSmqhxp/wPOWWgLw6zby5G6sJ4FZ9poFtzUfCYWaD8MNuGcbhqkjRlp7LrOHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxKQgdMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9263606A336
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxKQgdMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F001F000C1;
	Fri, 30 Oct 2026 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793329332;
	bh=CTqjPQ5cTJMN7TPA7YZ0B17wjUxjkaWSkyRExqZQQ4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxKQgdMJAhjVolTinBvOfROxMSLP+GJIbxahG1W0EspoiZbBYAIn7CWFCTT82CZLG
	 qL3vvq2o/MuVPImCs1euHfFSFRWxf0ajmObuVLbWWiCfvJWcmcp57h2hU0g/THCK+d
	 X74UwUfxS8T061OoIWwdraAe3uS0+JqWwmMPPGto3VrUt0zwlOvQUIYb3dNkVU62si
	 nBg6Dgt2CLS327V2SGD+akCar3Ei0n+Fn1xKDzsVOINGkgWPn/Miy/f9kVEzgnvmgP
	 jyLfVZPpzyh5HFxIg7AODMpy6FQdr7NTrkkE73iTMRYxKPemqtWp215fK55+gujIBa
	 YSXI4wpVmneKg==
Message-ID: <sashiko-outbox-190192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] virtio_balloon: add tracepoint for host ack latency
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030025834.19160-3-liuqiangneo@163.com>
References: <20261030025834.19160-1-liuqiangneo@163.com>
 <20261030025834.19160-3-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:02:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Qiang Liu <liuqiang@kylinos.cn>
>=20
> Balloon inflate/deflate block in tell_host() for host buffer consumption.
> Host-side stalls are easily mistaken for guest allocation issues.
>=20
> Add virtio_balloon_host_ack to record tell_host() wait time,
> virtqueue and PFN count, to split balloon latency between guest and host.
>=20
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030025834.1916=
0-1-liuqiangneo@163.com?part=3D2

