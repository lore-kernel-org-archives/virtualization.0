Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180274;
	b=4h9UTIs6JAx6Ce5+siXw9baXyt0TpyC8Dic4LNITzSkp8VmCI4rmyssPEof6otcLWijl
	 BB+LsZFybzELB0193CFCF+jADdb1Y2RA61x6zEpTmyGH3LP+xvBhmTCkvSq0BTqKWdx5/
	 PslLTUE5YqU0LOV0Kbl2LqUrIRMIro4U+kYbBZgcolnd6cXiQCkO4laRKZV4LsyNqMxpp
	 c2JNA1vpsCjT+5NEUUIcBvno+IK5txFKXmn0/JLvlZHzzGWA+82Qjv9G1Ta1c+uAOJb1K
	 MIM9eXcY3sT5gKtoXABGovmxLUpFOvJ+AiKYbwC/7lEaImUyV8w7c2sEUPf9CBxGrgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FdJ8EGBW5QW+C/sP9la344kZC7oRyMH26Ut0NJdYuAE=;
	b=P/tA8vIwVblZJXMvH8dcACqTom4ooQ4Erwuw1mOmjhvEJOtctETa2jKrohmtYm4S3oqI
	 1CeM9BPqGDqc/qFYw91IBawdVhZZc18qt4QKhFqbRfnRyqtSuqBxUfHTz7wqZ5Si6iknx
	 o/IVIC79vA48FoKMFR1WHCZetW1XP68Jlc9vTyTwAUHieSUCCGE7FjjChK8dzL+igYtqR
	 JaLyLOqGEC7EQsB0vk/mViNi4XgqMw4xANkuRY1umHW+lhJ99Gvt7wS8+G66yfImGNUOs
	 l94tFV8Hg9QYJmYp8UG0BLFXFva/CgFAeNXvpyb9CYH45Z+h9nWqMz2FsUfjcB9KC6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5x1CJFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61945606A323
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5x1CJFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB8F1F031E1;
	Wed, 28 Oct 2026 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180273;
	bh=FdJ8EGBW5QW+C/sP9la344kZC7oRyMH26Ut0NJdYuAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5x1CJFbLpt+jPBlrHXKFlf/kUgBkLtuu5K+4y4lCzi8nmPqe2onlHMqwHpTTAhq9
	 aAiRPI44HAkE5VWdyxIVgneXcsbcOnbqArCKhVm6S5uZ4LJmewrjypOxGRwW2f2N/t
	 ri8yufVCcR6J0T82SWLeDi9gwjWfDlJw0Yw6RmsaRCmzEnlstverZXk273iwreqCYj
	 PjB3/iqcORsGtR0RKEGAGeFLkDYRX4vbC3+u6wDaEvKyIZ/YT9wI5ODpy3J5Y3suQW
	 ffpoi8JGQFHjQSvUjzJeGJ79QhjlELK9Y4SENmqZWfhnoYlgDspwqMI3bDLb26gjWv
	 MoN64uHssL5rQ==
Message-ID: <sashiko-outbox-187684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: Fix oops caused by missing free_irq on device
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianping Liu" <frankljpliu@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028092137.1372286-1-frankljpliu@gmail.com>
References: <20261028092137.1372286-1-frankljpliu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:37:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jianping Liu <frankjpliu@tencent.com>
>=20
> After qxl.ko is unloaded, reading /proc/interrupts triggers an oops.
> qxl_irq_init() requests the PCI IRQ with the DRM device as dev_id, but
> qxl_device_fini() never frees it. The IRQ action therefore stays
> registered, and its name still points into the unloaded module.
>=20
> To fix the oops, free the IRQ in qxl_device_fini() with the same
> dev_id passed to request_irq().
>=20
> Cc: stable@kernel.org
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Jianping Liu <frankjpliu@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028092137.1372=
286-1-frankljpliu@gmail.com?part=3D1

