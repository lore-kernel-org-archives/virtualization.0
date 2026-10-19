Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429874DCB27
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419902; cv=none; b=SUPV+zcztoPUHGpIQVQ8s1DDE8nXStaI4aaUwYbtC/7H3K9iD+TVGqu2DbKSeBJtYohTeWCjtqj31gG07gM9e7u4tGeMfAmmJRd95f2Lvzly/ehZPDqgqgA4trNpiYOY7lzMIzBZ/8zWtsDNY40R4nJQNViiHEnH3VSfagHlZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419902; c=relaxed/simple;
	bh=C/Lnsr6PNgztqR5X68HNND05cPDY5Lg4k04xR+eRqoM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aPG0BMX9QFIa/yEFvR87p3B35OAVDOoHEQs0+xQb0xHnvqB1U5zzgbq3hSDEZDmLXlyn/jA5WZCqP0V8kzwlvXE4eDlxLM8CeVipgbwU3ioEpwJtGzzUClZuJtpafEmRj6DwoSXulkcri1UqNzCzfmoEDMqP7Be7LZ1RuBjI7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlBjSqBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlBjSqBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCBD1F000C4;
	Mon, 19 Oct 2026 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419900;
	bh=h9tljKnekrHIQ9FzR1acWnUnizNYfR/eXxocFUWQWec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UlBjSqBZgU7UwPLvQ6NSGLs28wOm6EmYhDZHhCGjU2B8seVnUIChE1kVzfJhajkXF
	 kwBkP/eiupFL/zCYRSAAsdqCb7ygzAIyhHnkoJWv9UylOW67mzpDU8kq7B7urVD8lP
	 nrLDQejkpqKFySQ8r2YTbRh4RtVtP53+NRT1prmQ4s4jC1sDTWvlOx1E8UvT2EssZW
	 1z45WHm6opgxdIY3yODKkecf3HItMEGw3TUyK7KUbaVHEf33TH7lRyB4Nxfal7YW1W
	 1Gq/SAvQ76zl/hsxJmHIruAis83X5mwGaO/6ZWmIQF0CdPbpocJOg0q8VNYnhodkrB
	 zPUy4vkAbyTJQ==
Message-ID: <sashiko-outbox-177373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] virtio_ring: fix infinite loop in
 virtnet_poll_cleantx when device is broken
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-133-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-133-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:25:00 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jinqian Yang <yangjinqian1@huawei.com>
>=20
> [ Upstream commit 0d0eff39ceb3dcbf7847a6f4517086c207c60081 ]
>=20
> virtnet_poll_cleantx() contains a do-while loop that cleans up
> transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
> whether more buffers need processing. When the virtio backend stops
> responding during guest reboot, used->idx is never updated, so
> virtqueue_enable_cb_delayed() always returns false and the loop never
> terminates. Then it will block reboot process, and the guest will hang.
>=20
> The problem occurs during guest reboot under network traffic:
>=20
>   1. kernel_restart() -> device_shutdown() traverses the device list
>   2. virtio_dev_shutdown() calls virtio_break_device() which sets
> [ ... ]
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20260716115940.394832-1-yangjinqian1@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-133-sashal@kernel.org?part=3D1

