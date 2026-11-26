Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704440;
	b=iAOyr5jB5SWT4HWtR+vfkEmH982oqkLs8aLljJMr3/LEKxxfQ6tkVgdpcU+uun+YwxUE
	 TZ4UzpqPIRo9etW+Csu152vl6nOusebAPrvUugJV+ceQyPA0i6F3a48JRQDy9IHtcpcmg
	 ENT0TW3thvo7o0usI1Evybwxko5WkBsOpXma6DSnpyc9qSZMSZFToW6DvNnUR/Z7t+ZYC
	 arqpUWEHcuqV7SYchJGA25HqN+0kYwAnxYLBzGFh4GYB/TIaW2upatGZFhKsjNQj96t2s
	 ju2Jd2ZdX/CXvDjZitbGn30Wad4T2GXsaStCoEK4V00VKBGzTuRDpsE4LW3LeSTZvTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NRac2Ct5II8As5h6vkdT38x1JtMy9sggn+8WZKv57PQ=;
	b=4ho003hA2b4N3lUoQKNAkfe+nHCrtdqLcA75fXPTzp/jwGCpdkHI56StxyeKGItM7Y6K
	 5UFwMOUGs8c5i2/+jdBqzjYFHq+D9FH1TJO7ovsrqpSUzfuepJpGftamdDb/7+5F5vZx9
	 Sk8vU2LcgibPl3YKlr6sekVHtAzVbKTAUBc5bgS8/13s0qdHMRLyKg43PUP4183HlnLWd
	 zfGfRMZ3emlSDsNOuQqa5AmIqcf1UGljnNaoH34nJzExZVCfBkqLklrLDRcqYCCeKn8+e
	 9F3WkwCf+WCOrcVJJ4x3NyVIJZioig5cjaAL084eBrsRoYZBYqZHk4xP8D/NtXAvNUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxvEhfvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF0606A31E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxvEhfvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69FF1F000C6;
	Thu, 26 Nov 2026 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704439;
	bh=NRac2Ct5II8As5h6vkdT38x1JtMy9sggn+8WZKv57PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxvEhfvJnEI8miyE4PMjP2xhFzoQg1rtE1IyRgJITfwaXCKMZ9AAKrb4dvfDZQcC3
	 DcrcsLpImVh435OgG0mOHzENuGxBEOM57AXllyrMXzsbppJ87AZ2jbnPC9X/btKVTI
	 QKTh5PqoVfeQODv7DVN/LgYj73D0cOIFHSDwwT8mM/G6n0bo98k2f37O2tH99zjdt6
	 3geBUSXqUb102MoSMm+QAe48UlDYtk86THYlbAbpNIpwvC6uu5lJR32FW7m0VBMZPJ
	 g8KUAjU3EZwOWzgoTh+it2VZwFLV9AaiYjQ70a3c7OIih6YmGpjKlqBbyo9aIrvPFu
	 k5ayfh95uukmQ==
Message-ID: <sashiko-outbox-235738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: bound execbuffer commands to control
 queue size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Seojin An" <love09010224@uos.ac.kr>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126143800.3493685-1-love09010224@uos.ac.kr>
References: <sashiko-outbox-235004@kernel.org>
 <20261126143800.3493685-1-love09010224@uos.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:47:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> DRM_IOCTL_VIRTGPU_EXECBUFFER accepts a user-controlled command size and
> copies the command with vmemdup_user(). For a vmalloc-backed command,
> virtio-gpu maps each page to one SG entry, then adds a request and respon=
se
> entry before submitting the chain to the control virtqueue.
>=20
> With indirect descriptors negotiated, the driver accounts for the chain as
> one free ring descriptor. An unprivileged render client can therefore
> submit more SG entries than the device Queue Size. A sufficiently large
> split-ring command wraps the indirect table's u16 next index. The device
> then consumes a chain different from the one constructed by the driver.
>=20
> Reject command sizes whose vmalloc page count plus the fixed request and
> response exceeds the actual control Queue Size. This execbuffer check does
> not depend on the ring layout and applies to both split and packed
> virtqueues. The driver creates one command SG entry per page even when
> [ ... ]
> Link: https://lore.kernel.org/all/20261126080044.2898223-1-love09010224@u=
os.ac.kr/
> Suggested-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> Suggested-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Seojin An <love09010224@uos.ac.kr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126143800.3493=
685-1-love09010224@uos.ac.kr?part=3D1
