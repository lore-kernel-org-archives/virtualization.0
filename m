Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC87489FDE
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044977; cv=none; b=GSMkjk/n6JFJX3qkj0mocZZU8u1k7OGBEoK9Greu334KW8AGppgKc4hmO4j5fQDWHqKRta4as3SyqHixL2qdieR2WVgvIpuo4bkayY+CNRquozOpB4HqhYhfviT2bkUIUNJa3h1Bkp7T/Zx1rpZIGWrKWJ8n0+V1wFrsx2jHzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044977; c=relaxed/simple;
	bh=Kf9XktC4XbLj4Cw7aQxs+mHoVNQKRjSFR0YTMj0+LqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kp7A6kVvRTkSXB+FOYoKZzS3A2W1N7+3b0kckAI0xqUNqg9A1nCAppi2M5AGP2er2qcIg/msNYunWu/P8cq+GaHzZMqNnI0BHLoICAqTQX8ViJR/MdxhEr50+KdpIBYmnSY1LBe5XMvAZiVHDS9ZAd2eaYuDUVATmQ34brIEryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia8JrQqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia8JrQqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F591F00893;
	Thu, 10 Sep 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044969;
	bh=Kf9XktC4XbLj4Cw7aQxs+mHoVNQKRjSFR0YTMj0+LqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ia8JrQqKLxXTSHP4BN0RCCvCq/K8QQYZ7/PqqzUym+e7pr34KiI6GAv2vaPOohKXi
	 CGcEoYi157dx3j15BYekj6L44yXabxoB8HHWODMhPAp5iXoqYTpGKOX26mcil3UDMp
	 80eY9BqMLaoOnjfFA7dd8mk9LAabrEBP572jljB4oF4AFz0MK5XmgeqH13Xwd78hWp
	 Nx8iumXpkHCP//vwhdhoj+JuAsOUecTSWKFMh89jsGL0ByDXGrcY59HkuJwkwtEApX
	 k6mtc9Pu+IBZsUuld5GvJSkjGD6g3a7h8X73PrL0fQU4EUYkFXp8OjsIwS+SN/r6UK
	 TgN2Bi5VbeGUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_ring: reset IN_ORDER state in virtqueue_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260910123903.1717-1-lirongqing@baidu.com>
References: <20260910123903.1717-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:56:09 +0000
Message-Id: <20260910125609.90F591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Li RongQing <lirongqing@baidu.com>
>=20
> The IN_ORDER feature uses additional software state to track the next
> available descriptor and in-flight descriptor batches.
>=20
> virtqueue_init() resets the common virtqueue state, but free_head and
> batch_last.id are initialized only when the virtqueue is created. When
> an IN_ORDER virtqueue is reset, these fields can retain state from the
> previous queue instance.
>=20
> Reset free_head and invalidate batch_last when initializing an IN_ORDER
> virtqueue. Keep this in virtqueue_init() so the state is initialized
> consistently for both newly created and reset virtqueues.
>=20
> Fixes: f6a15d854986 ("virtio_ring: add in order support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910123903.1717=
-1-lirongqing@baidu.com?part=3D1

