Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312038B148
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666214; cv=none; b=dqxyAx9C8syQOJ9xyyKeJILJSW5ozNv0LfJ28UfDr8W+iFYGJ22LlfexFeoHK1WPIHa9qws+M20tjI3IMH4iPmd40tpK9ExHyOn1p5aOuMJi4E432r7l2KeRQs/4FmPIuQSJ68gxeG4ZMN3L5q9xNues6Z0fTvQBe+yP2Ga0IAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666214; c=relaxed/simple;
	bh=l7Vwkevx3LLIJgJE/nCB9tv8ngrh2dULtvk7RySerkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aksE1JUC14edx+oeQep+uQ+jHhO+FDwcFz+Ka+r1cvkBpyoxR6LN0bR2xD6RHrHae53Uej/grqXEiqMb5pI8FLv4oSENvGwSalJsw/TmZFv44LZnD4ayJcoVXq6JJN28sx1qLWVTBmgys5Snn1ld2aX+YGHayyaKo4KU1WpezLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTuTHVLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTuTHVLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E67C1F00898;
	Tue, 29 Sep 2026 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666213;
	bh=/SdbbcPpSAU3qNhopsqNbdN09LfadPeBo0E9CzGhLgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTuTHVLVvcPsvwAB2u22IXamiM9zWz7tOHPxrIMFM+D1HcJDwzhfVmxdxpl5wbhxP
	 P6W0yW65qVU12SsyotLazDyapZO96meCinWwJHTXnguJNy+OFjEM9jpr/o76JynYwO
	 T6dU1wRf6gBIjwTuWJFvz07g5zMTpBNa823AfMeUz0dGIa/nNxxVSajkcHVus+kbQK
	 ADbUEroao//nXDs+G0lqf465iz38PQ6ZZn4sk2jVk1MbB24BAiUVaanrayMsTftCCM
	 Vi+3ajgkRTjoNy3yv/Wp0hbkDNLyE4v789irPcxGHxFPNdjZf7jdinT0aoMRdGL3Kj
	 UnxC3CYvu7Q4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260929070714.169412-1-abhinjoses@gmail.com>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:16:52 +0000
Message-Id: <20260929071653.1E67C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
> alive, and the fbdev DRM client holds a drm_device reference. When the
> fd is finally closed, the buffer is freed and takes the destroyed lock:
>=20
>   fb_release()
>     drm_fbdev_shmem_fb_destroy()
>       drm_client_buffer_delete()
>         virtio_gpu_free_object()
>           virtio_gpu_remove_from_restore_list()
>             mutex_lock(&vgdev->obj_restore_lock)
>=20
>   DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
> [ ... ]
> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring vi=
rtio_gpu_objects")
> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D3590d97d8a586fa955c2
> Assisted-by: LLM
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929070714.1694=
12-1-abhinjoses@gmail.com?part=3D1

