Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9F269D18
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482755; cv=none; b=jZTxiczDvwRxUSwSwuhXEEdCxTeYp7m8PflPwjUfcKf4LIL5yuZY3e76xKHgutA5TRScWCjJLqAbPVFloFAqdEwjWR7oknweuKsKB5wfZGBci+0BwO7XxMUFMGes9Fm6cJdUR3J7/OxiaRcKx63C+TV3+rGEaZeJoJUvU0vsbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482755; c=relaxed/simple;
	bh=DM+V5KKdnVUpywk+KJAKHKXBaNrxO1Fixx3YyOB/7p8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNxumSwE28Dd2qaDv6CPfRilR4YOC7ZU4UwTvavwn9bU5CF6iAWx3/Utt2WoP+HMlPWUo+aqvnesjVpX+ZTEWdQ7ruX6pKHm/B3yyi9UTMBnCaBAZkDA/Bawe+s4MGq1XyUt0ok1SF28e2go+uTLNt2l6y8T8thrJy5jnhjeFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F241F000FF;
	Sun, 27 Sep 2026 04:19:13 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: put GEM objects when dropping a vbuf on
 unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
References: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 04:19:10 +0000
Message-Id: <20260927041913.55F241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter() fails
> or when vqs_released is set. It unlocks the reservation and frees the
> vbuf, but never releases the references that the caller handed over in
> vbuf->objs. Those references are normally dropped from the dequeue path,
> which never sees a command that was not queued.
>=20
> If a framebuffer flush races with device removal, the GEM object backing
> the fbdev buffer keeps a stale reference, is never freed, and its node is
> still in the vma offset manager when the drm_device is released:
>=20
>   Memory manager not clean during takedown.
>   WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown
>   Call Trace:
>    drm_managed_release
>    drm_dev_put
>    virtio_dev_remove
>    virtio_pci_remove
>    pci_device_remove
>    remove_store
>=20
> Drop the object references together with the vbuf on both early-exit
> paths.
>=20
> Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd93b9064fe5f74af3aa3
> Fixes: b7170f9457f2 ("drm/virtio: return virtio_gpu_queue errors")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927040655.1453=
1-1-ngocthang2710.1999@gmail.com?part=3D1

